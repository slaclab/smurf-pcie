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
      rssiLinkUp      : out sl;
      rssiIbMaster    : in  AxiStreamMasterType;
      rssiIbSlave     : out AxiStreamSlaveType;
      rssiObMaster    : out AxiStreamMasterType;
      rssiObSlave     : in  AxiStreamSlaveType;
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
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

   signal obUdpMasters : AxiStreamMasterArray(CLIENT_SIZE_C-1 downto 0);
   signal obUdpSlaves  : AxiStreamSlaveArray(CLIENT_SIZE_C-1 downto 0);
   signal ibUdpMasters : AxiStreamMasterArray(CLIENT_SIZE_C-1 downto 0);
   signal ibUdpSlaves  : AxiStreamSlaveArray(CLIENT_SIZE_C-1 downto 0);

   signal obClientMasters : AxiStreamMasterArray(CLIENT_SIZE_C-1 downto 0);
   signal obClientSlaves  : AxiStreamSlaveArray(CLIENT_SIZE_C-1 downto 0);
   signal ibClientMasters : AxiStreamMasterArray(CLIENT_SIZE_C-1 downto 0);
   signal ibClientSlaves  : AxiStreamSlaveArray(CLIENT_SIZE_C-1 downto 0);

   signal obRssiTspMaster : AxiStreamMasterType;
   signal obRssiTspSlave  : AxiStreamSlaveType;
   signal ibRssiTspMaster : AxiStreamMasterType;
   signal ibRssiTspSlave  : AxiStreamSlaveType;

   signal obRssiAppMaster : AxiStreamMasterType;
   signal obRssiAppSlave  : AxiStreamSlaveType;
   signal ibRssiAppMaster : AxiStreamMasterType;
   signal ibRssiAppSlave  : AxiStreamSlaveType;

   signal keepAliveMaster : AxiStreamMasterType;
   signal keepAliveSlave  : AxiStreamSlaveType;

   signal ibUdpMasterMask : AxiStreamMasterType;
   signal ibUdpSlaveMask  : AxiStreamSlaveType;

   signal localIp  : slv(31 downto 0);
   signal localMac : slv(47 downto 0);

   signal statusReg : slv(6 downto 0);
   signal linkUp    : sl;

begin

   mac        <= localMac;
   rssiLinkUp <= linkUp;

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
         axiClkRst           => axilRst,
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
         axilRst         => axilRst,
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
         ibClientMasters(0) => ibUdpMasters(0),
         ibClientMasters(1) => ibUdpMasterMask,
         ibClientSlaves(0)  => ibUdpSlaves(0),
         ibClientSlaves(1)  => ibUdpSlaveMask,
         -- AXI-Lite Interface
         axilReadMaster     => axilReadMasters(1),
         axilReadSlave      => axilReadSlaves(1),
         axilWriteMaster    => axilWriteMasters(1),
         axilWriteSlave     => axilWriteSlaves(1),
         -- Clock and Reset
         clk                => axilClk,
         rst                => axilRst);

   U_AxiStreamMux : entity work.AxiStreamMux
      generic map (
         TPD_G        => TPD_G,
         NUM_SLAVES_G => 2)
      port map (
         -- Clock and reset
         axisClk         => axilClk,
         axisRst         => axilRst,
         -- Slaves
         sAxisMasters(0) => ibUdpMasters(1),
         sAxisMasters(1) => keepAliveMaster,
         sAxisSlaves(0)  => ibUdpSlaves(1),
         sAxisSlaves(1)  => keepAliveSlave,
         -- Master
         mAxisMaster     => ibUdpMasterMask,
         mAxisSlave      => ibUdpSlaveMask);

   GEN_VEC : for i in CLIENT_SIZE_C-1 downto 0 generate

      U_Resize_OB : entity work.AxiStreamResize
         generic map (
            -- General Configurations
            TPD_G               => TPD_G,
            READY_EN_G          => true,
            -- AXI Stream Port Configurations
            SLAVE_AXI_CONFIG_G  => EMAC_AXIS_CONFIG_C,
            MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
         port map (
            -- Clock and reset
            axisClk     => axilClk,
            axisRst     => axilRst,
            -- Slave Port
            sAxisMaster => obUdpMasters(i),
            sAxisSlave  => obUdpSlaves(i),
            -- Master Port
            mAxisMaster => obClientMasters(i),
            mAxisSlave  => obClientSlaves(i));

      U_Resize_IB : entity work.AxiStreamResize
         generic map (
            -- General Configurations
            TPD_G               => TPD_G,
            READY_EN_G          => true,
            -- AXI Stream Port Configurations
            SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
            MASTER_AXI_CONFIG_G => EMAC_AXIS_CONFIG_C)
         port map (
            -- Clock and reset
            axisClk     => axilClk,
            axisRst     => axilRst,
            -- Slave Port
            sAxisMaster => ibClientMasters(i),
            sAxisSlave  => ibClientSlaves(i),
            -- Master Port
            mAxisMaster => ibUdpMasters(i),
            mAxisSlave  => ibUdpSlaves(i));

   end generate GEN_VEC;

   U_EthTrafficSwitch : entity work.EthTrafficSwitch
      generic map (
         TPD_G => TPD_G)
      port map(
         -- Clock and reset
         axisClk        => axilClk,
         axisRst        => axilRst,
         -- Controls Interface
         rssiLinkUp     => linkUp,
         -- UDP Interface
         sUdpMasters    => obClientMasters,
         sUdpSlaves     => obClientSlaves,
         mUdpMasters    => ibClientMasters,
         mUdpSlaves     => ibClientSlaves,
         -- RSSI Transport Interface
         sRssiTspMaster => obRssiTspMaster,
         sRssiTspSlave  => obRssiTspSlave,
         mRssiTspMaster => ibRssiTspMaster,
         mRssiTspSlave  => ibRssiTspSlave,
         -- RSSI Application Interface
         sRssiAppMaster => obRssiAppMaster,
         sRssiAppSlave  => obRssiAppSlave,
         mRssiAppMaster => ibRssiAppMaster,
         mRssiAppSlave  => ibRssiAppSlave,
         -- DMA Interface
         sDmaMaster     => rssiIbMaster,
         sDmaSlave      => rssiIbSlave,
         mDmaMaster     => rssiObMaster,
         mDmaSlave      => rssiObSlave);

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
         TSP_AXIS_CONFIG_G   => APP_AXIS_CONFIG_C)
      port map (
         clk_i            => axilClk,
         rst_i            => axilRst,
         -- Transport Layer Interface
         sTspAxisMaster_i => ibRssiTspMaster,
         sTspAxisSlave_o  => ibRssiTspSlave,
         mTspAxisMaster_o => obRssiTspMaster,
         mTspAxisSlave_i  => obRssiTspSlave,
         -- Application Layer Interface
         sAppAxisMaster_i => ibRssiAppMaster,
         sAppAxisSlave_o  => ibRssiAppSlave,
         mAppAxisMaster_o => obRssiAppMaster,
         mAppAxisSlave_i  => obRssiAppSlave,
         -- High level  Application side interface
         openRq_i         => '0',                -- Enabled via software
         closeRq_i        => '0',
         inject_i         => '0',
         -- AXI-Lite Interface
         axiClk_i         => axilClk,
         axiRst_i         => axilRst,
         axilReadMaster   => axilReadMasters(2),
         axilReadSlave    => axilReadSlaves(2),
         axilWriteMaster  => axilWriteMasters(2),
         axilWriteSlave   => axilWriteSlaves(2),
         -- Internal statuses
         statusReg_o      => statusReg);

   process(axilClk)
   begin
      if rising_edge(axilClk) then
         linkUp <= statusReg(0) after TPD_G;
      end if;
   end process;

end mapping;
