-------------------------------------------------------------------------------
-- File       : EthLane.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- This file is part of 'SLAC PGP Gen3 Card'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'SLAC PGP Gen3 Card', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.StdRtlPkg.all;
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.EthMacPkg.all;
use work.AppPkg.all;

entity EthLane is
   generic (
      TPD_G           : time := 1 ns;
      CLK_FREQUENCY_G : real := 156.25E+6;  -- units of Hz
      AXI_BASE_ADDR_G : slv(31 downto 0));
   port (
      -- RSSI Interface (axilClk domain)
      rssiIbMaster    : in  AxiStreamMasterType;
      rssiIbSlave     : out AxiStreamSlaveType;
      rssiObMaster    : out AxiStreamMasterType;
      rssiObSlave     : in  AxiStreamSlaveType;
      -- UDP Interface (axiClk/axilClk domain)
      axiClk          : in  sl;
      axiRst          : in  sl;
      udpIbMaster     : in  AxiStreamMasterType; -- (axilClk domain)
      udpIbSlave      : out AxiStreamSlaveType;
      udpObMaster     : out AxiStreamMasterType; -- (axiClk domain)
      udpObSlave      : in  AxiStreamSlaveType;
      -- PHY/MAC Interface (axilClk domain)
      macObMaster     : in  AxiStreamMasterType;
      macObSlave      : out AxiStreamSlaveType;
      macIbMaster     : out AxiStreamMasterType;
      macIbSlave      : in  AxiStreamSlaveType;
      phyReady        : in  sl;
      mac             : out slv(47 downto 0);
      -- AXI-Lite Interface (axilClk domain)
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType);
end EthLane;

architecture mapping of EthLane is

   constant MAX_SEG_SIZE_C     : positive := 8192;  -- Jumbo frame chucking
   constant WINDOW_ADDR_SIZE_C : positive := 3;     -- 8 buffers (2^3)
   constant NUM_AXI_MASTERS_C  : natural  := 3;

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, AXI_BASE_ADDR_G, 16, 12);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

   signal obUdpMasters : AxiStreamMasterArray(CLIENT_SIZE_C-1 downto 0);
   signal obUdpSlaves  : AxiStreamSlaveArray(CLIENT_SIZE_C-1 downto 0);
   signal ibUdpMasters : AxiStreamMasterArray(CLIENT_SIZE_C-1 downto 0);
   signal ibUdpSlaves  : AxiStreamSlaveArray(CLIENT_SIZE_C-1 downto 0);

   signal keepAliveMaster : AxiStreamMasterType;
   signal keepAliveSlave  : AxiStreamSlaveType;
   
   signal sTspAxisMaster : AxiStreamMasterType;
   signal sTspAxisSlave  : AxiStreamSlaveType;
   
   signal localIp  : slv(31 downto 0);
   signal localMac : slv(47 downto 0);

   signal axilReset : sl;
   signal axiReset : sl;

begin

   U_axilRst : entity work.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axilClk,
         rstIn  => axilRst,
         rstOut => axilReset);
         
   U_axiRst : entity work.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axiClk,
         rstIn  => axiRst,
         rstOut => axiReset);    
         
   process(axilClk)
   begin
      if rising_edge(axilClk) then
         mac <= localMac after TPD_G;
      end if;
   end process;

   ---------------------
   -- AXI-Lite Crossbar
   ---------------------
   U_XBAR : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 1,
         NUM_MASTER_SLOTS_G => NUM_AXI_MASTERS_C,
         MASTERS_CONFIG_G   => AXI_CONFIG_C)
      port map (
         axiClk              => axilClk,
         axiClkRst           => axilReset,
         sAxiWriteMasters(0) => axilWriteMaster,
         sAxiWriteSlaves(0)  => axilWriteSlave,
         sAxiReadMasters(0)  => axilReadMaster,
         sAxiReadSlaves(0)   => axilReadSlave,
         mAxiWriteMasters    => axilWriteMasters,
         mAxiWriteSlaves     => axilWriteSlaves,
         mAxiReadMasters     => axilReadMasters,
         mAxiReadSlaves      => axilReadSlaves);

   ---------------------
   -- ETH Configurations
   ---------------------
   U_EthConfig : entity work.EthConfig
      generic map (
         TPD_G => TPD_G)
      port map (
         localIp         => localIp,
         localMac        => localMac,
         keepAliveMaster => keepAliveMaster,
         keepAliveSlave  => keepAliveSlave,
         -- AXI-Lite Register Interface (axilClk domain)
         axilClk         => axilClk,
         axilRst         => axilReset,
         axilReadMaster  => axilReadMasters(0),
         axilReadSlave   => axilReadSlaves(0),
         axilWriteMaster => axilWriteMasters(0),
         axilWriteSlave  => axilWriteSlaves(0));

   ----------------------
   -- IPv4/ARP/UDP Engine
   ----------------------
   U_UDP : entity work.UdpEngineWrapper
      generic map (
         -- Simulation Generics
         TPD_G          => TPD_G,
         -- UDP Server Generics
         SERVER_EN_G    => false,
         -- UDP Client Generics
         CLIENT_EN_G    => true,
         CLIENT_SIZE_G  => CLIENT_SIZE_C,
         CLIENT_PORTS_G => CLIENT_PORTS_C)
      port map (
         -- Local Configurations
         localMac           => localMac,
         localIp            => localIp,
         -- Interface to Ethernet Media Access Controller (MAC)
         obMacMaster        => macObMaster,
         obMacSlave         => macObSlave,
         ibMacMaster        => macIbMaster,
         ibMacSlave         => macIbSlave,
         -- Interface to UDP Client engine(s)
         obClientMasters    => obUdpMasters,
         obClientSlaves     => obUdpSlaves,
         ibClientMasters    => ibUdpMasters,
         ibClientSlaves     => ibUdpSlaves,
         -- AXI-Lite Interface
         axilReadMaster     => axilReadMasters(1),
         axilReadSlave      => axilReadSlaves(1),
         axilWriteMaster    => axilWriteMasters(1),
         axilWriteSlave     => axilWriteSlaves(1),
         -- Clock and Reset
         clk                => axilClk,
         rst                => axilReset);

   U_AxiStreamMux : entity work.AxiStreamMux
      generic map (
         TPD_G         => TPD_G,
         NUM_SLAVES_G  => 2,
         PIPE_STAGES_G => 1)
      port map (
         -- Clock and reset
         axisClk         => axilClk,
         axisRst         => axilReset,
         -- Slaves
         sAxisMasters(0) => udpIbMaster,
         sAxisMasters(1) => keepAliveMaster,
         sAxisSlaves(0)  => udpIbSlave,
         sAxisSlaves(1)  => keepAliveSlave,
         -- Master
         mAxisMaster     => ibUdpMasters(1),
         mAxisSlave      => ibUdpSlaves(1));

   U_SYNC : entity work.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         INT_PIPE_STAGES_G   => 1,
         PIPE_STAGES_G       => 1,
         -- FIFO configurations
         BRAM_EN_G           => true,
         GEN_SYNC_FIFO_G     => false,
         FIFO_ADDR_WIDTH_G   => 10, -- 16B x 1024 = 16KB > 9000 MTU
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => EMAC_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => EMAC_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => axilClk,
         sAxisRst    => axilReset,
         sAxisMaster => obUdpMasters(1),
         sAxisSlave  => obUdpSlaves(1),
         -- Master Port
         mAxisClk    => axiClk,
         mAxisRst    => axiRst,
         mAxisMaster => udpObMaster,
         mAxisSlave  => udpObSlave);
         
   U_BUFFER : entity work.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         INT_PIPE_STAGES_G   => 1,
         PIPE_STAGES_G       => 1,
         -- FIFO configurations
         BRAM_EN_G           => true,
         GEN_SYNC_FIFO_G     => true,
         FIFO_ADDR_WIDTH_G   => 10, -- 16B x 1024 = 16KB > 9000 MTU
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => EMAC_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => EMAC_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => axilClk,
         sAxisRst    => axilReset,
         sAxisMaster => obUdpMasters(0),
         sAxisSlave  => obUdpSlaves(0),
         -- Master Port
         mAxisClk    => axilClk,
         mAxisRst    => axilReset,
         mAxisMaster => sTspAxisMaster,
         mAxisSlave  => sTspAxisSlave);         

   --------------------------
   -- Software's RSSI Clients
   --------------------------
   U_RssiClient : entity work.RssiCoreWrapperInterleaved
      generic map (
         TPD_G               => TPD_G,
         PIPE_STAGES_G       => 1,
         APP_ILEAVE_EN_G     => true,
         MAX_SEG_SIZE_G      => MAX_SEG_SIZE_C,  -- Using Jumbo frames
         SEGMENT_ADDR_SIZE_G => bitSize(MAX_SEG_SIZE_C/8),
         CLK_FREQUENCY_G     => CLK_FREQUENCY_G,
         TIMEOUT_UNIT_G      => 1.0E-3,          -- In units of seconds 
         SERVER_G            => false,           -- false = Client mode
         RETRANSMIT_ENABLE_G => true,
         WINDOW_ADDR_SIZE_G  => WINDOW_ADDR_SIZE_C,
         MAX_NUM_OUTS_SEG_G  => (2**WINDOW_ADDR_SIZE_C),
         MAX_RETRANS_CNT_G   => 16,
         MAX_CUM_ACK_CNT_G   => 2,
         APP_AXIS_CONFIG_G   => APP_STREAM_CONFIG_C,
         TSP_AXIS_CONFIG_G   => EMAC_AXIS_CONFIG_C)
      port map (
         clk_i            => axilClk,
         rst_i            => axilReset,
         -- Transport Layer Interface
         sTspAxisMaster_i => sTspAxisMaster,
         sTspAxisSlave_o  => sTspAxisSlave,
         mTspAxisMaster_o => ibUdpMasters(0),
         mTspAxisSlave_i  => ibUdpSlaves(0),
         -- Application Layer Interface
         sAppAxisMaster_i => rssiIbMaster,
         sAppAxisSlave_o  => rssiIbSlave,
         mAppAxisMaster_o => rssiObMaster,
         mAppAxisSlave_i  => rssiObSlave,
         -- High level  Application side interface
         openRq_i         => '0',                -- Enabled via software
         closeRq_i        => '0',
         inject_i         => '0',
         -- AXI-Lite Interface
         axiClk_i         => axilClk,
         axiRst_i         => axilReset,
         axilReadMaster   => axilReadMasters(2),
         axilReadSlave    => axilReadSlaves(2),
         axilWriteMaster  => axilWriteMasters(2),
         axilWriteSlave   => axilWriteSlaves(2));

end mapping;
