-------------------------------------------------------------------------------
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- This file is part of 'lcls2-pgp-pcie-apps'.
-- It is subject to the license terms in the LICENSE.txt file found in the
-- top-level directory of this distribution and at:
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
-- No part of 'lcls2-pgp-pcie-apps', including this file,
-- may be copied, modified, propagated, or distributed except according to
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiLitePkg.all;
use surf.AxiStreamPkg.all;
use surf.SsiPkg.all;
use surf.EthMacPkg.all;

entity AppLane is
   generic (
      TPD_G        : time := 1 ns;
      BUILD_INFO_G : BuildInfoType);
   port (
      -- Clock and Reset
      axilClk        : in  sl;
      axilRst        : in  sl;
      -- Local Configurations
      ethMac         : in  slv(47 downto 0);
      ethIp          : in  slv(31 downto 0);
      -- ETH PHY AXI Stream Interfaces
      obMacMaster    : in  AxiStreamMasterType;
      obMacSlave     : out AxiStreamSlaveType;
      ibMacMaster    : out AxiStreamMasterType;
      ibMacSlave     : in  AxiStreamSlaveType;
      -- ETH PHY AXI-Lite Interfaces
      phyWriteMaster : out AxiLiteWriteMasterType;
      phyWriteSlave  : in  AxiLiteWriteSlaveType;
      phyReadMaster  : out AxiLiteReadMasterType;
      phyReadSlave   : in  AxiLiteReadSlaveType;
      -- Backdoor AXI-Lite Interfaces
      dbgWriteMaster : in  AxiLiteWriteMasterType;
      dbgWriteSlave  : out AxiLiteWriteSlaveType;
      dbgReadMaster  : in  AxiLiteReadMasterType;
      dbgReadSlave   : out AxiLiteReadSlaveType);
end AppLane;

architecture mapping of AppLane is

   ---------------------------------------------------------------------------
   -- UDP constants and signals
   ---------------------------------------------------------------------------

   constant AXIS_8BYTE_CONFIG_C : AxiStreamConfigType := ssiAxiStreamConfig(8, TKEEP_COMP_C, TUSER_FIRST_LAST_C, 8);  -- Use 8 tDest bits

   constant NUM_SERVERS_C  : integer                                 := 2;
   constant SERVER_PORTS_C : PositiveArray(NUM_SERVERS_C-1 downto 0) := (0 => 8198, 1 => 8195);

   signal ibServerMasters : AxiStreamMasterArray(NUM_SERVERS_C-1 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal ibServerSlaves  : AxiStreamSlaveArray(NUM_SERVERS_C-1 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);
   signal obServerMasters : AxiStreamMasterArray(NUM_SERVERS_C-1 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal obServerSlaves  : AxiStreamSlaveArray(NUM_SERVERS_C-1 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);

   ---------------------------------------------------------------------------
   -- RSSI constants and signals
   ---------------------------------------------------------------------------

   constant APP_STREAMS_C      : positive := 6;
   constant TIMEOUT_C          : real     := 1.0E-3;  -- In units of seconds
   constant WINDOW_ADDR_SIZE_C : positive := 4;       -- 16 buffers (2^4)
   constant MAX_SEG_SIZE_C     : positive := 8192;    -- Jumbo frame chucking

   constant APP_AXIS_CONFIG_C : AxiStreamConfigArray(APP_STREAMS_C-1 downto 0) := (others => AXIS_8BYTE_CONFIG_C);

   constant SRP_IDX_C        : natural := 0;
   constant BSA_ASYNC_IDX_C  : natural := 1;
   constant DIAG_ASYNC_IDX_C : natural := 2;
   constant MEM_DATA_IDX_C   : natural := 3;
   constant RAW_DATA_IDX_C   : natural := 4;
   constant APP_ASYNC_IDX_C  : natural := 5;

   signal rssiIbMasters : AxiStreamMasterArray(APP_STREAMS_C-1 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal rssiIbSlaves  : AxiStreamSlaveArray(APP_STREAMS_C-1 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);
   signal rssiObMasters : AxiStreamMasterArray(APP_STREAMS_C-1 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal rssiObSlaves  : AxiStreamSlaveArray(APP_STREAMS_C-1 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);

   ---------------------------------------------------------------------------
   -- AXI-Lite constants and signals
   ---------------------------------------------------------------------------

   constant VERSION_INDEX_C    : natural  := 0;
   constant PHY_INDEX_C        : natural  := 1;
   constant UDP_INDEX_C        : natural  := 2;
   constant RSSI_INDEX_C       : natural  := 3;
   constant UDP_TX_INDEX_C     : natural  := 4;
   constant UDP_RX_INDEX_C     : natural  := 5;
   constant RSSI_TX_INDEX_C    : natural  := 6;
   constant RSSI_RX_INDEX_C    : natural  := 7;
   constant NUM_AXIL_MASTERS_C : positive := 8;

   constant AXIL_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXIL_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXIL_MASTERS_C, x"0000_0000", 31, 16);

   signal mAxilReadMaster  : AxiLiteReadMasterType;
   signal mAxilReadSlave   : AxiLiteReadSlaveType;
   signal mAxilWriteMaster : AxiLiteWriteMasterType;
   signal mAxilWriteSlave  : AxiLiteWriteSlaveType;

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXIL_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXIL_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXIL_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXIL_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

begin

   ---------------------------
   -- AXI-Lite Crossbar Module
   ---------------------------
   U_XBAR : entity surf.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 2,
         NUM_MASTER_SLOTS_G => NUM_AXIL_MASTERS_C,
         MASTERS_CONFIG_G   => AXIL_CONFIG_C)
      port map (
         sAxiWriteMasters(0) => mAxilWriteMaster,
         sAxiWriteMasters(1) => dbgWriteMaster,
         sAxiWriteSlaves(0)  => mAxilWriteSlave,
         sAxiWriteSlaves(1)  => dbgWriteSlave,
         sAxiReadMasters(0)  => mAxilReadMaster,
         sAxiReadMasters(1)  => dbgReadMaster,
         sAxiReadSlaves(0)   => mAxilReadSlave,
         sAxiReadSlaves(1)   => dbgReadSlave,
         mAxiWriteMasters    => axilWriteMasters,
         mAxiWriteSlaves     => axilWriteSlaves,
         mAxiReadMasters     => axilReadMasters,
         mAxiReadSlaves      => axilReadSlaves,
         axiClk              => axilClk,
         axiClkRst           => axilRst);

   ---------------------------
   -- AXI-Lite: Version Module
   ---------------------------
   U_AxiVersion : entity surf.AxiVersion
      generic map (
         TPD_G        => TPD_G,
         CLK_PERIOD_G => (1.0/156.25E+6),
         BUILD_INFO_G => BUILD_INFO_G)
      port map (
         axiReadMaster  => axilReadMasters(VERSION_INDEX_C),
         axiReadSlave   => axilReadSlaves(VERSION_INDEX_C),
         axiWriteMaster => axilWriteMasters(VERSION_INDEX_C),
         axiWriteSlave  => axilWriteSlaves(VERSION_INDEX_C),
         axiClk         => axilClk,
         axiRst         => axilRst);

   -------------------------------------
   -- External AXI-Lite Interface to PHY
   -------------------------------------
   phyWriteMaster               <= axilWriteMasters(PHY_INDEX_C);
   axilWriteSlaves(PHY_INDEX_C) <= phyWriteSlave;

   phyReadMaster               <= axilReadMasters(PHY_INDEX_C);
   axilReadSlaves(PHY_INDEX_C) <= phyReadSlave;

   ----------------------
   -- IPv4/ARP/UDP Engine
   ----------------------
   U_UDP : entity surf.UdpEngineWrapper
      generic map (
         -- Simulation Generics
         TPD_G          => TPD_G,
         -- UDP Server Generics
         SERVER_EN_G    => true,
         SERVER_SIZE_G  => NUM_SERVERS_C,
         SERVER_PORTS_G => SERVER_PORTS_C,
         -- UDP Client Generics
         CLIENT_EN_G    => false,
         -- General IPv4/ARP/DHCP Generics
         DHCP_G         => false,
         CLK_FREQ_G     => 156.25E+6,
         COMM_TIMEOUT_G => 30)
      port map (
         -- Local Configurations
         localMac        => ethMac,
         localIp         => ethIp,
         -- Interface to Ethernet Media Access Controller (MAC)
         obMacMaster     => obMacMaster,
         obMacSlave      => obMacSlave,
         ibMacMaster     => ibMacMaster,
         ibMacSlave      => ibMacSlave,
         -- Interface to UDP Server engine(s)
         obServerMasters => obServerMasters,
         obServerSlaves  => obServerSlaves,
         ibServerMasters => ibServerMasters,
         ibServerSlaves  => ibServerSlaves,
         -- AXI-Lite Interface
         axilReadMaster  => axilReadMasters(UDP_INDEX_C),
         axilReadSlave   => axilReadSlaves(UDP_INDEX_C),
         axilWriteMaster => axilWriteMasters(UDP_INDEX_C),
         axilWriteSlave  => axilWriteSlaves(UDP_INDEX_C),
         -- Clock and Reset
         clk             => axilClk,
         rst             => axilRst);

   --------------
   -- RSSI Server
   --------------
   U_RssiServer : entity surf.RssiCoreWrapper
      generic map (
         TPD_G                => TPD_G,
         PIPE_STAGES_G        => 1,
         SYNTH_MODE_G         => "xpm",
         MEMORY_TYPE_G        => "ultra",
         APP_ILEAVE_EN_G      => true,  -- true = AxiStreamPacketizer2
         -- ILEAVE_ON_NOTVALID_G => true,
         ILEAVE_ON_NOTVALID_G => false,  -- Might be a bug in the AxiStreamPacketizer2 when (ILEAVE_ON_NOTVALID_G=true): LLR - 05MAY2019
         MAX_SEG_SIZE_G       => MAX_SEG_SIZE_C,  -- Using Jumbo frames
         SEGMENT_ADDR_SIZE_G  => bitSize(MAX_SEG_SIZE_C/8),
         APP_STREAMS_G        => APP_STREAMS_C,
         APP_STREAM_ROUTES_G  => (
            SRP_IDX_C         => X"00",  -- TDEST 0 routed to stream 0 (SRPv3)
            BSA_ASYNC_IDX_C   => X"02",  -- TDEST 2 routed to stream 2 (BSA async)
            DIAG_ASYNC_IDX_C  => X"03",  -- TDEST 3 routed to stream 3 (Diag async)
            MEM_DATA_IDX_C    => X"04",  -- TDEST 4 routed to stream 0 (MEM)
            RAW_DATA_IDX_C    => "10------",  -- TDEST x80-0xBF routed to stream 1 (Raw Data)
            APP_ASYNC_IDX_C   => "11------"),  -- TDEST 0xC0-0xFF routed to stream 2 (Application)
         CLK_FREQUENCY_G      => 156.25E+6,
         TIMEOUT_UNIT_G       => TIMEOUT_C,
         SERVER_G             => true,
         RETRANSMIT_ENABLE_G  => true,
         WINDOW_ADDR_SIZE_G   => WINDOW_ADDR_SIZE_C,
         MAX_NUM_OUTS_SEG_G   => (2**WINDOW_ADDR_SIZE_C),
         MAX_RETRANS_CNT_G    => 16,
         APP_AXIS_CONFIG_G    => APP_AXIS_CONFIG_C,
         TSP_AXIS_CONFIG_G    => EMAC_AXIS_CONFIG_C)
      port map (
         clk_i             => axilClk,
         rst_i             => axilRst,
         -- Application Layer Interface
         sAppAxisMasters_i => rssiIbMasters,
         sAppAxisSlaves_o  => rssiIbSlaves,
         mAppAxisMasters_o => rssiObMasters,
         mAppAxisSlaves_i  => rssiObSlaves,
         -- Transport Layer Interface
         sTspAxisMaster_i  => obServerMasters(0),
         sTspAxisSlave_o   => obServerSlaves(0),
         mTspAxisMaster_o  => ibServerMasters(0),
         mTspAxisSlave_i   => ibServerSlaves(0),
         -- High level  Application side interface
         openRq_i          => '1',  -- Automatically start the connection without debug SRP channel
         closeRq_i         => '0',
         inject_i          => '0',
         -- AXI-Lite Interface
         axiClk_i          => axilClk,
         axiRst_i          => axilRst,
         axilReadMaster    => axilReadMasters(RSSI_INDEX_C),
         axilReadSlave     => axilReadSlaves(RSSI_INDEX_C),
         axilWriteMaster   => axilWriteMasters(RSSI_INDEX_C),
         axilWriteSlave    => axilWriteSlaves(RSSI_INDEX_C));

   ------------------------------------------------
   -- AXI-Lite Master with RSSI Server: TDEST = 0x0
   ------------------------------------------------
   U_SRPv3 : entity surf.SrpV3AxiLite
      generic map (
         TPD_G               => TPD_G,
         SLAVE_READY_EN_G    => true,
         GEN_SYNC_FIFO_G     => true,
         AXI_STREAM_CONFIG_G => AXIS_8BYTE_CONFIG_C)
      port map (
         -- AXIS Slave Interface (sAxisClk domain)
         sAxisClk         => axilClk,
         sAxisRst         => axilRst,
         sAxisMaster      => rssiObMasters(SRP_IDX_C),
         sAxisSlave       => rssiObSlaves(SRP_IDX_C),
         -- AXIS Master Interface (mAxisClk domain)
         mAxisClk         => axilClk,
         mAxisRst         => axilRst,
         mAxisMaster      => rssiIbMasters(SRP_IDX_C),
         mAxisSlave       => rssiIbSlaves(SRP_IDX_C),
         -- Master AXI-Lite Interface (axilClk domain)
         axilClk          => axilClk,
         axilRst          => axilRst,
         mAxilReadMaster  => mAxilReadMaster,
         mAxilReadSlave   => mAxilReadSlave,
         mAxilWriteMaster => mAxilWriteMaster,
         mAxilWriteSlave  => mAxilWriteSlave);

   -------------------
   -- Raw UDP PRBS TX
   -------------------
   U_UdpSsiPrbsTx : entity surf.SsiPrbsTx
      generic map (
         TPD_G                      => TPD_G,
         AXI_DEFAULT_PKT_LEN_G      => X"000000FF",
         MASTER_AXI_PIPE_STAGES_G   => 1,
         PRBS_SEED_SIZE_G           => 128,
         MASTER_AXI_STREAM_CONFIG_G => EMAC_AXIS_CONFIG_C)
      port map (
         mAxisClk        => axilClk,
         mAxisRst        => axilRst,
         mAxisMaster     => ibServerMasters(1),
         mAxisSlave      => ibServerSlaves(1),
         locClk          => axilClk,
         locRst          => axilRst,
         axilReadMaster  => axilReadMasters(UDP_TX_INDEX_C),
         axilReadSlave   => axilReadSlaves(UDP_TX_INDEX_C),
         axilWriteMaster => axilWriteMasters(UDP_TX_INDEX_C),
         axilWriteSlave  => axilWriteSlaves(UDP_TX_INDEX_C));

   -------------------
   -- Raw UDP PRBS RX
   -------------------
   U_UdpSsiPrbsRx : entity surf.SsiPrbsRx
      generic map (
         TPD_G                     => TPD_G,
         SLAVE_AXI_PIPE_STAGES_G   => 1,
         PRBS_SEED_SIZE_G          => 128,
         -- SLAVE_AXI_STREAM_CONFIG_G => ssiAxiStreamConfig(16))
         SLAVE_AXI_STREAM_CONFIG_G => EMAC_AXIS_CONFIG_C)
      port map (
         sAxisClk       => axilClk,
         sAxisRst       => axilRst,
         sAxisMaster    => obServerMasters(1),
         sAxisSlave     => obServerSlaves(1),
         axiClk         => axilClk,
         axiRst         => axilRst,
         axiReadMaster  => axilReadMasters(UDP_RX_INDEX_C),
         axiReadSlave   => axilReadSlaves(UDP_RX_INDEX_C),
         axiWriteMaster => axilWriteMasters(UDP_RX_INDEX_C),
         axiWriteSlave  => axilWriteSlaves(UDP_RX_INDEX_C));

   ---------------
   -- RSSI PRBS TX
   ---------------
   U_RssiSsiPrbsTx : entity surf.SsiPrbsTx
      generic map (
         TPD_G                      => TPD_G,
         AXI_DEFAULT_PKT_LEN_G      => X"000000FF",
         MASTER_AXI_PIPE_STAGES_G   => 1,
         PRBS_SEED_SIZE_G           => 64,
         MASTER_AXI_STREAM_CONFIG_G => AXIS_8BYTE_CONFIG_C)
      port map (
         mAxisClk        => axilClk,
         mAxisRst        => axilRst,
         mAxisMaster     => rssiIbMasters(BSA_ASYNC_IDX_C),
         mAxisSlave      => rssiIbSlaves(BSA_ASYNC_IDX_C),
         locClk          => axilClk,
         locRst          => axilRst,
         axilReadMaster  => axilReadMasters(RSSI_TX_INDEX_C),
         axilReadSlave   => axilReadSlaves(RSSI_TX_INDEX_C),
         axilWriteMaster => axilWriteMasters(RSSI_TX_INDEX_C),
         axilWriteSlave  => axilWriteSlaves(RSSI_TX_INDEX_C));

   ---------------
   -- RSSI PRBS RX
   ---------------
   U_RssiSsiPrbsRx : entity surf.SsiPrbsRx
      generic map (
         TPD_G                     => TPD_G,
         SLAVE_AXI_PIPE_STAGES_G   => 1,
         PRBS_SEED_SIZE_G          => 64,
         SLAVE_AXI_STREAM_CONFIG_G => AXIS_8BYTE_CONFIG_C)
      port map (
         sAxisClk       => axilClk,
         sAxisRst       => axilRst,
         sAxisMaster    => rssiObMasters(BSA_ASYNC_IDX_C),
         sAxisSlave     => rssiObSlaves(BSA_ASYNC_IDX_C),
         axiClk         => axilClk,
         axiRst         => axilRst,
         axiReadMaster  => axilReadMasters(RSSI_RX_INDEX_C),
         axiReadSlave   => axilReadSlaves(RSSI_RX_INDEX_C),
         axiWriteMaster => axilWriteMasters(RSSI_RX_INDEX_C),
         axiWriteSlave  => axilWriteSlaves(RSSI_RX_INDEX_C));

end mapping;
