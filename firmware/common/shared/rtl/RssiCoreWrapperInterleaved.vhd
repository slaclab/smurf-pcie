-------------------------------------------------------------------------------
-- File       : RssiCoreWrapperInterleaved.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: Wrapper for RSSI + AXIS packetizer 
-------------------------------------------------------------------------------
-- This file is part of 'SLAC Firmware Standard Library'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'SLAC Firmware Standard Library', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library surf;
use surf.StdRtlPkg.all;
use surf.RssiPkg.all;
use surf.SsiPkg.all;
use surf.AxiStreamPkg.all;
use surf.AxiLitePkg.all;
use surf.EthMacPkg.all;

entity RssiCoreWrapperInterleaved is
   generic (
      TPD_G                : time                 := 1 ns;
      CLK_FREQUENCY_G      : real                 := 100.0E+6;  -- In units of Hz
      TIMEOUT_UNIT_G       : real                 := 1.0E-3;  -- In units of seconds
      SERVER_G             : boolean              := true;  -- Module is server or client 
      RETRANSMIT_ENABLE_G  : boolean              := true;  -- Enable/Disable retransmissions in tx module
      WINDOW_ADDR_SIZE_G   : positive             := 3;  -- 2^WINDOW_ADDR_SIZE_G  = Max number of segments in buffer
      SEGMENT_ADDR_SIZE_G  : positive             := 7;  -- 2^SEGMENT_ADDR_SIZE_G = Number of 64 bit wide data words
      BYPASS_CHUNKER_G     : boolean              := false;  -- Bypass the AXIS chunker layer
      PIPE_STAGES_G        : natural              := 0;
      APP_STREAMS_G        : positive             := 1;
      APP_STREAM_ROUTES_G  : Slv8Array            := (0 => "--------");
      APP_ILEAVE_EN_G      : boolean              := true;
      BYP_TX_BUFFER_G      : boolean              := false;
      BYP_RX_BUFFER_G      : boolean              := false;
      MEMORY_TYPE_G        : string               := "block";
      ILEAVE_ON_NOTVALID_G : boolean              := true;
      -- AXIS Configurations
      APP_AXIS_CONFIG_G    : AxiStreamConfigArray := (0 => ssiAxiStreamConfig(8, TKEEP_NORMAL_C));
      TSP_AXIS_CONFIG_G    : AxiStreamConfigType  := ssiAxiStreamConfig(16, TKEEP_NORMAL_C);
      -- Version and connection ID
      INIT_SEQ_N_G         : natural              := 16#80#;
      CONN_ID_G            : positive             := 16#12345678#;
      VERSION_G            : positive             := 1;
      HEADER_CHKSUM_EN_G   : boolean              := true;
      -- Window parameters of receiver module
      MAX_NUM_OUTS_SEG_G   : positive             := 8;  --   <=(2**WINDOW_ADDR_SIZE_G)
      MAX_SEG_SIZE_G       : positive             := 1024;  -- <= (2**SEGMENT_ADDR_SIZE_G)*8 Number of bytes
      -- RSSI Timeouts
      ACK_TOUT_G           : positive             := 25;  -- unit depends on TIMEOUT_UNIT_G 
      RETRANS_TOUT_G       : positive             := 50;  -- unit depends on TIMEOUT_UNIT_G  (Recommended >= MAX_NUM_OUTS_SEG_G*Data segment transmission time)
      NULL_TOUT_G          : positive             := 200;  -- unit depends on TIMEOUT_UNIT_G  (Recommended >= 4*RETRANS_TOUT_G)
      -- Counters
      MAX_RETRANS_CNT_G    : positive             := 2;
      MAX_CUM_ACK_CNT_G    : positive             := 3);
   port (
      -- Clock and Reset
      clk_i            : in  sl;
      rst_i            : in  sl;
      -- SSI Application side
      sAppAxisMaster_i : in  AxiStreamMasterType;
      sAppAxisSlave_o  : out AxiStreamSlaveType;
      mAppAxisMaster_o : out AxiStreamMasterType;
      mAppAxisSlave_i  : in  AxiStreamSlaveType;
      -- SSI Transport side
      sTspAxisMaster_i : in  AxiStreamMasterType;
      sTspAxisSlave_o  : out AxiStreamSlaveType;
      mTspAxisMaster_o : out AxiStreamMasterType;
      mTspAxisSlave_i  : in  AxiStreamSlaveType;
      -- High level  Application side interface
      openRq_i         : in  sl                     := '0';
      closeRq_i        : in  sl                     := '0';
      inject_i         : in  sl                     := '0';
      -- AXI-Lite Register Interface
      axiClk_i         : in  sl                     := '0';
      axiRst_i         : in  sl                     := '0';
      axilReadMaster   : in  AxiLiteReadMasterType  := AXI_LITE_READ_MASTER_INIT_C;
      axilReadSlave    : out AxiLiteReadSlaveType;
      axilWriteMaster  : in  AxiLiteWriteMasterType := AXI_LITE_WRITE_MASTER_INIT_C;
      axilWriteSlave   : out AxiLiteWriteSlaveType;
      -- Internal statuses
      linkUp           : out sl;
      statusReg_o      : out slv(6 downto 0));
end entity RssiCoreWrapperInterleaved;

architecture mapping of RssiCoreWrapperInterleaved is

   constant MAX_SEGS_BITS_C : positive := bitSize(MAX_SEG_SIZE_G);

   signal depacketizerMasters : AxiStreamMasterArray(1 downto 0);
   signal depacketizerSlaves  : AxiStreamSlaveArray(1 downto 0);

   signal packetizerMasters : AxiStreamMasterArray(1 downto 0);
   signal packetizerSlaves  : AxiStreamSlaveArray(1 downto 0);

   signal statusReg        : slv(6 downto 0);
   signal rssiNotConnected : sl;
   signal rssiConnected    : sl;

   signal maxObSegSize : slv(15 downto 0);
   signal maxSegs      : slv(MAX_SEGS_BITS_C - 1 downto 0);

   constant PACKETIZER_AXIS_CONFIG_C : AxiStreamConfigType := (
      TSTRB_EN_C    => false,
      TDATA_BYTES_C => 8,
      TDEST_BITS_C  => 8,
      TID_BITS_C    => 8,
      TKEEP_MODE_C  => TKEEP_COMP_C,
      TUSER_BITS_C  => 8,
      TUSER_MODE_C  => TUSER_FIRST_LAST_C);

   constant CONV_AXIS_CONFIG_C : AxiStreamConfigType := ite(BYPASS_CHUNKER_G, RSSI_AXIS_CONFIG_C, PACKETIZER_AXIS_CONFIG_C);

   signal rxMasterPipe : AxiStreamMasterType;
   signal rxSlavePipe  : AxiStreamSlaveType;

   signal reset : sl;


   signal sTspAxisMaster : AxiStreamMasterType;
   signal sTspAxisSlave  : AxiStreamSlaveType;

begin

   U_reset : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => clk_i,
         rstIn  => rst_i,
         rstOut => reset);

   -- packetizerMasters(0) <= sAppAxisMaster_i;
   -- sAppAxisSlave_o      <= packetizerSlaves(0);
   BLOWOFF_FILTER : process (rxSlavePipe, sAppAxisMaster_i, statusReg) is
      variable master : AxiStreamMasterType;
      variable slave  : AxiStreamSlaveType;
   begin
      -- Init
      master := sAppAxisMaster_i;
      slave  := rxSlavePipe;
      -- Check for link down
      if (statusReg(0) = '0') then
         -- Blow off the data (prevent DMA lock up)
         master.tValid := '0';
         slave.tReady  := '1';
      end if;
      -- Outputs
      rxMasterPipe    <= master;
      sAppAxisSlave_o <= slave;
   end process;

   U_IbPipe : entity surf.AxiStreamPipeline
      generic map (
         TPD_G         => TPD_G,
         PIPE_STAGES_G => 1)
      port map (
         axisClk     => clk_i,
         axisRst     => reset,
         sAxisMaster => rxMasterPipe,
         sAxisSlave  => rxSlavePipe,
         mAxisMaster => packetizerMasters(0),
         mAxisSlave  => packetizerSlaves(0));

   maxSegs <= ite(unsigned(maxObSegSize) >= MAX_SEG_SIZE_G,
                  slv(to_unsigned(MAX_SEG_SIZE_G, maxSegs'length)),
                  maxObSegSize(maxSegs'range));

   U_Packetizer : entity surf.AxiStreamPacketizer2
      generic map (
         TPD_G                => TPD_G,
         MEMORY_TYPE_G        => "block",
         REG_EN_G             => true,
         CRC_MODE_G           => "FULL",
         CRC_POLY_G           => x"04C11DB7",
         TDEST_BITS_G         => 8,
         MAX_PACKET_BYTES_G   => MAX_SEG_SIZE_G,
         INPUT_PIPE_STAGES_G  => 0,
         OUTPUT_PIPE_STAGES_G => 1)
      port map (
         axisClk     => clk_i,
         axisRst     => reset,
         maxPktBytes => maxSegs,
         sAxisMaster => packetizerMasters(0),
         sAxisSlave  => packetizerSlaves(0),
         mAxisMaster => packetizerMasters(1),
         mAxisSlave  => packetizerSlaves(1));

   U_BUFFER : entity surf.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         INT_PIPE_STAGES_G   => 1,
         PIPE_STAGES_G       => 1,
         -- FIFO configurations
         MEMORY_TYPE_G       => "block",
         GEN_SYNC_FIFO_G     => true,
         FIFO_ADDR_WIDTH_G   => 10,     -- 16B x 1024 = 16KB > 9000 MTU
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => EMAC_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => EMAC_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => clk_i,
         sAxisRst    => reset,
         sAxisMaster => sTspAxisMaster_i,
         sAxisSlave  => sTspAxisSlave_o,
         -- Master Port
         mAxisClk    => clk_i,
         mAxisRst    => reset,
         mAxisMaster => sTspAxisMaster,
         mAxisSlave  => sTspAxisSlave);

   U_RssiCore : entity surf.RssiCore
      generic map (
         TPD_G               => TPD_G,
         CLK_FREQUENCY_G     => CLK_FREQUENCY_G,
         TIMEOUT_UNIT_G      => TIMEOUT_UNIT_G,
         SERVER_G            => SERVER_G,
         RETRANSMIT_ENABLE_G => RETRANSMIT_ENABLE_G,
         WINDOW_ADDR_SIZE_G  => WINDOW_ADDR_SIZE_G,
         SEGMENT_ADDR_SIZE_G => SEGMENT_ADDR_SIZE_G,
         BYP_TX_BUFFER_G     => BYP_TX_BUFFER_G,
         BYP_RX_BUFFER_G     => BYP_RX_BUFFER_G,
         SYNTH_MODE_G        => "xpm",
         MEMORY_TYPE_G       => MEMORY_TYPE_G,
         -- AXIS Configurations
         APP_AXIS_CONFIG_G   => CONV_AXIS_CONFIG_C,
         TSP_AXIS_CONFIG_G   => TSP_AXIS_CONFIG_G,
         -- Version and connection ID
         INIT_SEQ_N_G        => INIT_SEQ_N_G,
         CONN_ID_G           => CONN_ID_G,
         VERSION_G           => VERSION_G,
         HEADER_CHKSUM_EN_G  => HEADER_CHKSUM_EN_G,
         -- Window parameters of receiver module
         MAX_NUM_OUTS_SEG_G  => MAX_NUM_OUTS_SEG_G,
         MAX_SEG_SIZE_G      => MAX_SEG_SIZE_G,
         -- RSSI Timeouts
         RETRANS_TOUT_G      => RETRANS_TOUT_G,
         ACK_TOUT_G          => ACK_TOUT_G,
         NULL_TOUT_G         => NULL_TOUT_G,
         -- Counters
         MAX_RETRANS_CNT_G   => MAX_RETRANS_CNT_G,
         MAX_CUM_ACK_CNT_G   => MAX_CUM_ACK_CNT_G)
      port map (
         -- Clock and Reset
         clk_i            => clk_i,
         rst_i            => reset,
         -- SSI Application side
         sAppAxisMaster_i => packetizerMasters(1),
         sAppAxisSlave_o  => packetizerSlaves(1),
         mAppAxisMaster_o => depacketizerMasters(1),
         mAppAxisSlave_i  => depacketizerSlaves(1),
         -- SSI Transport side
         sTspAxisMaster_i => sTspAxisMaster,
         sTspAxisSlave_o  => sTspAxisSlave,
         mTspAxisMaster_o => mTspAxisMaster_o,
         mTspAxisSlave_i  => mTspAxisSlave_i,
         -- High level  Application side interface
         openRq_i         => openRq_i,
         closeRq_i        => closeRq_i,
         inject_i         => inject_i,
         -- AXI-Lite Register Interface
         axiClk_i         => axiClk_i,
         axiRst_i         => axiRst_i,
         axilReadMaster   => axilReadMaster,
         axilReadSlave    => axilReadSlave,
         axilWriteMaster  => axilWriteMaster,
         axilWriteSlave   => axilWriteSlave,
         -- Internal statuses
         statusReg_o      => statusReg,
         maxSegSize_o     => maxObSegSize);

   statusReg_o      <= statusReg;
   rssiConnected    <= statusReg(0);
   rssiNotConnected <= not(rssiConnected);

   process(clk_i)
   begin
      if rising_edge(clk_i) then
         linkUp <= statusReg(0) after TPD_G;
      end if;
   end process;

   U_Depacketizer : entity surf.AxiStreamDepacketizer2
      generic map (
         TPD_G                => TPD_G,
         MEMORY_TYPE_G        => "block",
         REG_EN_G             => true,
         CRC_MODE_G           => "FULL",
         CRC_POLY_G           => x"04C11DB7",
         TDEST_BITS_G         => 8,
         INPUT_PIPE_STAGES_G  => 0,  -- No need for input stage, RSSI output is already pipelined
         OUTPUT_PIPE_STAGES_G => 1)
      port map (
         axisClk     => clk_i,
         axisRst     => reset,
         linkGood    => rssiConnected,
         sAxisMaster => depacketizerMasters(1),
         sAxisSlave  => depacketizerSlaves(1),
         mAxisMaster => depacketizerMasters(0),
         mAxisSlave  => depacketizerSlaves(0));

   mAppAxisMaster_o      <= depacketizerMasters(0);
   depacketizerSlaves(0) <= mAppAxisSlave_i;

end mapping;
