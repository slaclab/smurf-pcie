-------------------------------------------------------------------------------
-- Title      : 
-------------------------------------------------------------------------------
-- File       : Kcu105Core.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2016-01-25
-- Last update: 2016-01-25
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
-- Ethernet UDP Port Mapping (COMBINE_G = false): 
--    192.168.2.10@8192 = UDP <--> SRPv0[AXI-Lite]
--    192.168.2.10@8193 = UDP <--> RSSI <--> Chunker[tDest=0] <--> SRPv3[AXI-Lite]
--    192.168.2.10@8193 = UDP <--> RSSI <--> Chunker[tDest=1] <--> MPS Sw message

-------------------------------------------------------------------------------
-- This file is part of 'LCLS2 MPS Firmware'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 MPS Firmware', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.StdRtlPkg.all;
use work.AxiStreamPkg.all;
use work.SsiPkg.all;
use work.AxiLitePkg.all;
use work.TenGigEthPkg.all;
use work.EthMacPkg.all;
use work.Pgp2bPkg.all;

entity Kcu105Core is
   generic (
      TPD_G            : time             := 1 ns;
      BUILD_INFO_G     : BuildInfoType;
      AXI_ERROR_RESP_G : slv(1 downto 0)  := AXI_RESP_DECERR_C;
      MAC_ADDR_G       : slv(47 downto 0) := MAC_ADDR_INIT_C;
      IP_ADDR_G        : slv(31 downto 0) := x"0A02A8C0"         
   );
   port (
      -- Top Level Interface    
      axilClk        : out sl;
      axilRst        : out sl;

      axilReadMaster  : out AxiLiteReadMasterType;
      axilReadSlave   : in  AxiLiteReadSlaveType;
      axilWriteMaster : out AxiLiteWriteMasterType;
      axilWriteSlave  : in  AxiLiteWriteSlaveType;
      
      -- Sw Message master (EMAC_AXIS_CONFIG_C) AxilClk domain
      swObMaster     : in  AxiStreamMasterType;
      swObSlave      : out AxiStreamSlaveType:= AXI_STREAM_SLAVE_FORCE_C;
      swIbMaster     : out AxiStreamMasterType;
      swIbSlave      : in  AxiStreamSlaveType:= AXI_STREAM_SLAVE_FORCE_C;
      
      -- XADC Ports
      vPIn           : in  sl;
      vNIn           : in  sl;
      -- System Ports
      extRst         : in  sl;
      clkRefP        : in  sl;          -- 156.25 MHz
      clkRefN        : in  sl;
      phyReady       : out sl;

      -- 10G-BaseR ETH Ports
      ethRxP         : in  sl;
      ethRxN         : in  sl;
      ethTxP         : out sl;
      ethTxN         : out sl);
end Kcu105Core;

architecture mapping of Kcu105Core is

   constant NUM_AXI_MASTERS_C : natural := 6;

   constant VERSION_AXI_INDEX_C : natural := 0;
   constant SYSMON_AXI_INDEX_C  : natural := 1;
   constant ETH_AXI_INDEX_C     : natural := 2;
   constant UDP_INDEX_C         : natural := 3;
   constant RSSI_INDEX0_C       : natural := 4;
   constant APP_AXI_INDEX_C     : natural := 5;

   constant VERSION_AXI_BASE_ADDR_C : slv(31 downto 0) := X"00000000";
   constant SYSMON_AXI_BASE_ADDR_C  : slv(31 downto 0) := X"00010000";
   constant ETH_AXI_BASE_ADDR_C     : slv(31 downto 0) := X"00020000";
   constant UDP_BASE_ADDR_C         : slv(31 downto 0) := X"00030000";
   constant RSSI_BASE0_ADDR_C       : slv(31 downto 0) := X"00040000";
   constant APP_AXI_BASE_ADDR_C     : slv(31 downto 0) := X"80000000";


   constant AXI_CROSSBAR_MASTERS_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := (
      VERSION_AXI_INDEX_C => (
         baseAddr         => VERSION_AXI_BASE_ADDR_C,
         addrBits         => 16,
         connectivity     => X"FFFF"),
      SYSMON_AXI_INDEX_C  => (
         baseAddr         => SYSMON_AXI_BASE_ADDR_C,
         addrBits         => 16,
         connectivity     => X"FFFF"),
      ETH_AXI_INDEX_C     => (
         baseAddr         => ETH_AXI_BASE_ADDR_C,
         addrBits         => 16,
         connectivity     => X"FFFF"),
      UDP_INDEX_C         => (
         baseAddr         => UDP_BASE_ADDR_C,
         addrBits         => 12,
         connectivity     => X"FFFF"),
      RSSI_INDEX0_C       => (
         baseAddr         => RSSI_BASE0_ADDR_C,
         addrBits         => 12,
         connectivity     => X"FFFF"),  
      APP_AXI_INDEX_C     => (
         baseAddr         => APP_AXI_BASE_ADDR_C,
         addrBits         => 31,
         connectivity     => X"FFFF"));
   
   constant CLK_FREQUENCY_C : real := 156.25E+6;
   
   -- UDP
   constant NUM_SERVERS_C  : integer                   := 2;
   constant PROTOCOL_C     : Slv8Array(0 downto 0)     := (0 => UDP_C);
   constant SERVER_PORTS_C : PositiveArray(NUM_SERVERS_C-1 downto 0) := (1 => 8193, 0 => 8192);
   
   -- RSSI
   constant NUM_RSSI_TDESTS_C : integer := 2;
   constant RSSI_AXIS_CONFIG_C : AxiStreamConfigArray(NUM_RSSI_TDESTS_C-1 downto 0) := (others => EMAC_AXIS_CONFIG_C);

   signal rssiIbMasters : AxiStreamMasterArray(NUM_RSSI_TDESTS_C-1 downto 0);
   signal rssiIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_TDESTS_C-1 downto 0);
   signal rssiObMasters : AxiStreamMasterArray(NUM_RSSI_TDESTS_C-1 downto 0);
   signal rssiObSlaves  : AxiStreamSlaveArray(NUM_RSSI_TDESTS_C-1 downto 0);
   
   
   
   signal ibMacMaster : AxiStreamMasterType;
   signal ibMacSlave  : AxiStreamSlaveType;
   signal obMacMaster : AxiStreamMasterType;
   signal obMacSlave  : AxiStreamSlaveType;

   signal ibServerMasters : AxiStreamMasterArray(NUM_SERVERS_C-1 downto 0);
   signal ibServerSlaves  : AxiStreamSlaveArray(NUM_SERVERS_C-1 downto 0);
   signal obServerMasters : AxiStreamMasterArray(NUM_SERVERS_C-1 downto 0);
   signal obServerSlaves  : AxiStreamSlaveArray(NUM_SERVERS_C-1 downto 0);

   signal axiWriteMasters : AxiLiteWriteMasterArray(1 downto 0) := (others => AXI_LITE_WRITE_MASTER_INIT_C);
   signal axiWriteSlaves  : AxiLiteWriteSlaveArray(1 downto 0)  := (others => AXI_LITE_WRITE_SLAVE_INIT_C);
   signal axiReadMasters  : AxiLiteReadMasterArray(1 downto 0)  := (others => AXI_LITE_READ_MASTER_INIT_C);
   signal axiReadSlaves   : AxiLiteReadSlaveArray(1 downto 0)   := (others => AXI_LITE_READ_SLAVE_INIT_C);

   signal mAxilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal mAxilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal mAxilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal mAxilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

   signal coreClk  : sl;
   signal clk      : sl;
   signal rst      : sl;
      
begin

   axilClk <= clk;
   axilRst <= rst;
   
   --@@@@@@@@@@@@@@@@@@@@@@@@--
   -- Ethernet section
   --@@@@@@@@@@@@@@@@@@@@@@@@--        
         
   ----------------------------
   -- 10GBASE-R Ethernet Module
   ----------------------------
   TenGigEthGthUltraScaleWrapper_Inst : entity work.TenGigEthGthUltraScaleWrapper
      generic map (
         TPD_G             => TPD_G,
         NUM_LANE_G        => 1,
         -- QUAD PLL Configurations
         QPLL_REFCLK_SEL_G => "001",
         -- AXI Streaming Configurations
         AXIS_CONFIG_G     => (others => EMAC_AXIS_CONFIG_C))
      port map (
         -- Local Configurations
         localMac               => (others => MAC_ADDR_G),
         -- Streaming DMA Interface 
         dmaClk(0)              => clk,
         dmaRst(0)              => rst,
         dmaIbMasters(0)        => obMacMaster,
         dmaIbSlaves(0)         => obMacSlave,
         dmaObMasters(0)        => ibMacMaster,
         dmaObSlaves(0)         => ibMacSlave,
         -- Slave AXI-Lite Interface 
         axiLiteClk(0)          => clk,
         axiLiteRst(0)          => rst,
         axiLiteReadMasters(0)  => mAxilReadMasters(ETH_AXI_INDEX_C),
         axiLiteReadSlaves(0)   => mAxilReadSlaves(ETH_AXI_INDEX_C),
         axiLiteWriteMasters(0) => mAxilWriteMasters(ETH_AXI_INDEX_C),
         axiLiteWriteSlaves(0)  => mAxilWriteSlaves(ETH_AXI_INDEX_C),
         -- Misc. Signals
         extRst                 => extRst,
         coreClk                => coreClk,
         phyClk(0)              => clk,
         phyRst(0)              => rst,
         phyReady(0)            => phyReady,
         gtClk                  => gtRefClk,
         -- MGT Clock Port (156.25 MHz or 312.5 MHz)
         gtClkP                 => clkRefP,
         gtClkN                 => clkRefN,
         -- MGT Ports
         gtTxP(0)               => ethTxP,
         gtTxN(0)               => ethTxN,
         gtRxP(0)               => ethRxP,
         gtRxN(0)               => ethRxN);

   ----------------------
   -- IPv4/ARP/UDP Engine
   ----------------------
   U_UDP : entity work.UdpEngineWrapper
      generic map (
         -- Simulation Generics
         TPD_G              => TPD_G,
         -- UDP General Generic
         DHCP_G             => true,
         -- UDP Server Generics
         SERVER_EN_G        => true,
         SERVER_SIZE_G      => NUM_SERVERS_C,
         SERVER_PORTS_G     => SERVER_PORTS_C,
         -- UDP Client Generics
         CLIENT_EN_G        => false)
      port map (
         -- Local Configurations
         localMac        => MAC_ADDR_G,
         localIp         => IP_ADDR_G,
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
         axilReadMaster  => mAxilReadMasters (UDP_INDEX_C),
         axilReadSlave   => mAxilReadSlaves  (UDP_INDEX_C),
         axilWriteMaster => mAxilWriteMasters(UDP_INDEX_C),
         axilWriteSlave  => mAxilWriteSlaves (UDP_INDEX_C),
         -- Clock and Reset
         clk             => clk,
         rst             => rst); 

   -----------------------------------        
   -- SRPv0: AXI-Lite Master Interface 0
   -- Port 8192
   ----------------------------------- 
   U_SRPv0 : entity work.SrpV0AxiLite
      generic map (
         TPD_G               => TPD_G,
         SLAVE_READY_EN_G    => true,
         EN_32BIT_ADDR_G     => true,
         BRAM_EN_G           => true,
         GEN_SYNC_FIFO_G     => true,
         AXI_STREAM_CONFIG_G => EMAC_AXIS_CONFIG_C)
      port map (
         -- Streaming Slave (Rx) Interface (sAxisClk domain) 
         sAxisClk            => clk,
         sAxisRst            => rst,
         sAxisMaster         => obServerMasters(0),
         sAxisSlave          => obServerSlaves(0),
         -- Streaming Master (Tx) Data Interface (mAxisClk domain)
         mAxisClk            => clk,
         mAxisRst            => rst,
         mAxisMaster         => ibServerMasters(0),
         mAxisSlave          => ibServerSlaves(0),
         -- AXI Lite Bus (axiLiteClk domain)
         axiLiteClk          => clk,
         axiLiteRst          => rst,
         mAxiLiteReadMaster  => axiReadMasters(0),
         mAxiLiteReadSlave   => axiReadSlaves(0),
         mAxiLiteWriteMaster => axiWriteMasters(0),
         mAxiLiteWriteSlave  => axiWriteSlaves(0));

   ------------------------------------------
   -- Software's RSSI Server Interface @ 8193
   ------------------------------------------
   U_RssiServer0 : entity work.RssiCoreWrapper
      generic map (
         TPD_G               => TPD_G,
         MAX_SEG_SIZE_G      => 1024,
         SEGMENT_ADDR_SIZE_G => 7,
         APP_STREAMS_G       => NUM_RSSI_TDESTS_C,
         APP_STREAM_ROUTES_G => (
            0                => X"00",
            1                => X"01"),
         CLK_FREQUENCY_G     => CLK_FREQUENCY_C,
         TIMEOUT_UNIT_G      => 1.0E-3,  -- In units of seconds
         SERVER_G            => true,
         RETRANSMIT_ENABLE_G => true,
         BYPASS_CHUNKER_G    => false,   -- Bypass chunker for debug
         WINDOW_ADDR_SIZE_G  => 3,
         PIPE_STAGES_G       => 1,
         APP_AXIS_CONFIG_G   => RSSI_AXIS_CONFIG_C,
         TSP_AXIS_CONFIG_G   => EMAC_AXIS_CONFIG_C,
         INIT_SEQ_N_G        => 16#80#)
      port map (
         clk_i             => clk,
         rst_i             => rst,
         openRq_i          => '1',
         -- Application Layer Interface
         sAppAxisMasters_i => rssiIbMasters,
         sAppAxisSlaves_o  => rssiIbSlaves,
         mAppAxisMasters_o => rssiObMasters,
         mAppAxisSlaves_i  => rssiObSlaves,
         -- Transport Layer Interface
         sTspAxisMaster_i  => obServerMasters(1),
         sTspAxisSlave_o   => obServerSlaves(1),
         mTspAxisMaster_o  => ibServerMasters(1),
         mTspAxisSlave_i   => ibServerSlaves(1),
         -- AXI-Lite Interface
         axiClk_i          => clk,
         axiRst_i          => rst,
         axilReadMaster    => mAxilReadMasters (RSSI_INDEX0_C),
         axilReadSlave     => mAxilReadSlaves  (RSSI_INDEX0_C),
         axilWriteMaster   => mAxilWriteMasters(RSSI_INDEX0_C),
         axilWriteSlave    => mAxilWriteSlaves (RSSI_INDEX0_C));
         
   -----------------------------------        
   -- SRPv3: AXI-Lite Master Interface
   -- TDEST = [0]
   -- Second AXi-lite master 
   -----------------------------------           
   U_SRPv3Reg : entity work.SrpV3AxiLite
      generic map (
         TPD_G               => TPD_G,
         SLAVE_READY_EN_G    => true,
         GEN_SYNC_FIFO_G     => true,
         AXI_STREAM_CONFIG_G => EMAC_AXIS_CONFIG_C)
      port map (
         -- AXIS Slave Interface (sAxisClk domain)
         sAxisClk         => clk,
         sAxisRst         => rst,
         sAxisMaster      => rssiObMasters(0),
         sAxisSlave       => rssiObSlaves(0),
         -- AXIS Master Interface (mAxisClk domain) 
         mAxisClk         => clk,
         mAxisRst         => rst,
         mAxisMaster      => rssiIbMasters(0),
         mAxisSlave       => rssiIbSlaves(0),
         -- Master AXI-Lite Interface (axilClk domain)
         axilClk          => clk,
         axilRst          => rst,
         mAxilReadMaster  => axiReadMasters(1),
         mAxilReadSlave   => axiReadSlaves(1),
         mAxilWriteMaster => axiWriteMasters(1),
         mAxilWriteSlave  => axiWriteSlaves(1));
         
      ----------------------------
      -- TDEST=[1] Software Message interface
      -- External interface
      ----------------------------
      swIbMaster       <= rssiObMasters(1);
      rssiObSlaves(1)  <= swIbSlave;
      rssiIbMasters(1) <= swObMaster;
      swObSlave        <= rssiIbSlaves(1);
         
         
   ---------------------------
   -- AXI-Lite Crossbar Module
   ---------------------------         
   AxiLiteCrossbar_Inst : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 2,
         NUM_MASTER_SLOTS_G => NUM_AXI_MASTERS_C,
         MASTERS_CONFIG_G   => AXI_CROSSBAR_MASTERS_CONFIG_C)
      port map (
         sAxiWriteMasters    => axiWriteMasters,
         sAxiWriteSlaves     => axiWriteSlaves,
         sAxiReadMasters     => axiReadMasters,
         sAxiReadSlaves      => axiReadSlaves,  
         mAxiWriteMasters    => mAxilWriteMasters,
         mAxiWriteSlaves     => mAxilWriteSlaves,
         mAxiReadMasters     => mAxilReadMasters,
         mAxiReadSlaves      => mAxilReadSlaves,
         axiClk              => clk,
         axiClkRst           => rst);

   ---------------------------
   -- AXI-Lite: Version Module
   ---------------------------            
   AxiVersion_Inst : entity work.AxiVersion
      generic map (
         TPD_G           => TPD_G,
         XIL_DEVICE_G    => "ULTRASCALE",
         BUILD_INFO_G    => BUILD_INFO_G,
         EN_DEVICE_DNA_G => true)
      port map (
         axiReadMaster  => mAxilReadMasters(VERSION_AXI_INDEX_C),
         axiReadSlave   => mAxilReadSlaves(VERSION_AXI_INDEX_C),
         axiWriteMaster => mAxilWriteMasters(VERSION_AXI_INDEX_C),
         axiWriteSlave  => mAxilWriteSlaves(VERSION_AXI_INDEX_C),
         axiClk         => clk,
         axiRst         => rst);

   --------------------------
   -- AXI-Lite: SYSMON Module
   --------------------------
   U_SysMon : entity work.AmcCarrierSysMon
      generic map (
         TPD_G            => TPD_G,
         AXI_ERROR_RESP_G => AXI_ERROR_RESP_G)
      port map (
         -- SYSMON Ports
         vPIn            => vPIn,
         vNIn            => vNIn,
         -- AXI-Lite Register Interface
         axilReadMaster  => mAxilReadMasters(SYSMON_AXI_INDEX_C),
         axilReadSlave   => mAxilReadSlaves(SYSMON_AXI_INDEX_C),
         axilWriteMaster => mAxilWriteMasters(SYSMON_AXI_INDEX_C),
         axilWriteSlave  => mAxilWriteSlaves(SYSMON_AXI_INDEX_C),
         -- Clocks and Resets
         axilClk         => clk,
         axilRst         => rst);                   

   -------------------------------------------
   -- Map the Application AXI-Lite to Output
   -------------------------------------------
   axilReadMaster  <= mAxilReadMasters(APP_AXI_INDEX_C);
   mAxilReadSlaves(APP_AXI_INDEX_C) <= axilReadSlave;
   axilWriteMaster <= mAxilWriteMasters(APP_AXI_INDEX_C);
   mAxilWriteSlaves(APP_AXI_INDEX_C) <= axilWriteSlave;
   
   -- U_AxiLiteAsync : entity work.AxiLiteAsync
      -- generic map (
         -- TPD_G => TPD_G)
      -- port map (
         -- -- Slave Port
         -- sAxiClk         => clk,
         -- sAxiClkRst      => rst,
         -- sAxiReadMaster  => mAxilReadMasters(APP_AXI_INDEX_C),
         -- sAxiReadSlave   => mAxilReadSlaves(APP_AXI_INDEX_C),
         -- sAxiWriteMaster => mAxilWriteMasters(APP_AXI_INDEX_C),
         -- sAxiWriteSlave  => mAxilWriteSlaves(APP_AXI_INDEX_C),
         -- -- Master Port
         -- mAxiClk         => pgpClock,
         -- mAxiClkRst      => pgpReset,
         -- mAxiReadMaster  => ,
         -- mAxiReadSlave   => ,
         -- mAxiWriteMaster => ,
         -- mAxiWriteSlave  => ); 

end mapping;