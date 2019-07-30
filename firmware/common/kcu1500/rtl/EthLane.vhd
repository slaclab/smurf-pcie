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
      rssiLinkUp      : out slv(NUM_RSSI_C-1 downto 0);
      rssiIbMasters   : in  AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      rssiIbSlaves    : out AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      rssiObMasters   : out AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      rssiObSlaves    : in  AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
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

   -- constant WINDOW_ADDR_SIZE_C : positive := 3;     -- 8 buffers (2^3)
   constant WINDOW_ADDR_SIZE_C : positive := 4;     -- 16 buffers (2^4)
   
   -- constant MAX_SEG_SIZE_C     : positive := 1024;  -- Standard frame chucking
   constant MAX_SEG_SIZE_C     : positive := 8192;  -- Jumbo frame chucking

   constant NUM_AXI_MASTERS_C : natural := (2+NUM_RSSI_C);

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, AXI_BASE_ADDR_G, 20, 16);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

   signal obUdpMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal obUdpSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal ibUdpMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal ibUdpSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal obClientMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal obClientSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal ibClientMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal ibClientSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal obRssiTspMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal obRssiTspSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal ibRssiTspMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal ibRssiTspSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal obRssiAppMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal obRssiAppSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal ibRssiAppMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal ibRssiAppSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal localIp  : slv(31 downto 0);
   signal localMac : slv(47 downto 0);
   signal bypRssi  : slv(NUM_RSSI_C-1 downto 0);

   signal statusReg : Slv7Array(NUM_RSSI_C-1 downto 0);
   signal linkUp    : slv(NUM_RSSI_C-1 downto 0);

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
         phyReady        => phyReady,
         localIp         => localIp,
         localMac        => localMac,
         bypRssi         => bypRssi,
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
         CLIENT_SIZE_G  => NUM_RSSI_C,
         CLIENT_PORTS_G => (
            0           => 9000,
            1           => 9001,
            2           => 9002,
            3           => 9003,
            4           => 9004,
            5           => 9005,
            6           => 9006,
            7           => 9007))
      port map (
         -- Local Configurations
         localMac        => localMac,
         localIp         => localIp,
         -- Interface to Ethernet Media Access Controller (MAC)
         obMacMaster     => macObMaster,
         obMacSlave      => macObSlave,
         ibMacMaster     => macIbMaster,
         ibMacSlave      => macIbSlave,
         -- Interface to UDP Client engine(s)
         obClientMasters => obUdpMasters,
         obClientSlaves  => obUdpSlaves,
         ibClientMasters => ibUdpMasters,
         ibClientSlaves  => ibUdpSlaves,
         -- AXI-Lite Interface
         axilReadMaster  => axilReadMasters(1),
         axilReadSlave   => axilReadSlaves(1),
         axilWriteMaster => axilWriteMasters(1),
         axilWriteSlave  => axilWriteSlaves(1),
         -- Clock and Reset
         clk             => axilClk,
         rst             => axilRst);

   GEN_LANE : for i in NUM_RSSI_C-1 downto 0 generate

      U_OB_FIFO : entity work.AxiStreamFifoV2
         generic map (
            -- General Configurations
            TPD_G               => TPD_G,
            -- FIFO configurations
            BRAM_EN_G           => true,
            GEN_SYNC_FIFO_G     => true,
            FIFO_ADDR_WIDTH_G   => 9,
            -- AXI Stream Port Configurations
            SLAVE_AXI_CONFIG_G  => EMAC_AXIS_CONFIG_C,
            MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
         port map (
            -- Slave Port
            sAxisClk    => axilClk,
            sAxisRst    => axilRst,
            sAxisMaster => obUdpMasters(i),
            sAxisSlave  => obUdpSlaves(i),
            -- Master Port
            mAxisClk    => axilClk,
            mAxisRst    => axilRst,
            mAxisMaster => obClientMasters(i),
            mAxisSlave  => obClientSlaves(i));

      U_IB_FIFO : entity work.AxiStreamFifoV2
         generic map (
            -- General Configurations
            TPD_G               => TPD_G,
            -- FIFO configurations
            BRAM_EN_G           => true,
            GEN_SYNC_FIFO_G     => true,
            FIFO_ADDR_WIDTH_G   => 9,
            -- AXI Stream Port Configurations
            SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
            MASTER_AXI_CONFIG_G => EMAC_AXIS_CONFIG_C)
         port map (
            -- Slave Port
            sAxisClk    => axilClk,
            sAxisRst    => axilRst,
            sAxisMaster => ibClientMasters(i),
            sAxisSlave  => ibClientSlaves(i),
            -- Master Port
            mAxisClk    => axilClk,
            mAxisRst    => axilRst,
            mAxisMaster => ibUdpMasters(i),
            mAxisSlave  => ibUdpSlaves(i));

      U_EthTrafficSwitch : entity work.EthTrafficSwitch
         generic map (
            TPD_G => TPD_G)
         port map(
            -- Clock and reset
            axisClk        => axilClk,
            axisRst        => axilRst,
            -- Controls Interface
            rssiLinkUp     => linkUp(i),
            bypRssi        => bypRssi(i),
            -- UDP Interface
            sUdpMaster     => obClientMasters(i),
            sUdpSlave      => obClientSlaves(i),
            mUdpMaster     => ibClientMasters(i),
            mUdpSlave      => ibClientSlaves(i),
            -- RSSI Transport Interface
            sRssiTspMaster => obRssiTspMasters(i),
            sRssiTspSlave  => obRssiTspSlaves(i),
            mRssiTspMaster => ibRssiTspMasters(i),
            mRssiTspSlave  => ibRssiTspSlaves(i),
            -- RSSI Application Interface
            sRssiAppMaster => obRssiAppMasters(i),
            sRssiAppSlave  => obRssiAppSlaves(i),
            mRssiAppMaster => ibRssiAppMasters(i),
            mRssiAppSlave  => ibRssiAppSlaves(i),
            -- DMA Interface
            sDmaMaster     => rssiIbMasters(i),
            sDmaSlave      => rssiIbSlaves(i),
            mDmaMaster     => rssiObMasters(i),
            mDmaSlave      => rssiObSlaves(i));

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
            MAX_CUM_ACK_CNT_G   => 1,   -- 0x1 for HW-to-HW communication
            APP_AXIS_CONFIG_G   => APP_STREAM_CONFIG_C,
            TSP_AXIS_CONFIG_G   => APP_AXIS_CONFIG_C)
         port map (
            clk_i            => axilClk,
            rst_i            => axilRst,
            -- Transport Layer Interface
            sTspAxisMaster_i => ibRssiTspMasters(i),
            sTspAxisSlave_o  => ibRssiTspSlaves(i),
            mTspAxisMaster_o => obRssiTspMasters(i),
            mTspAxisSlave_i  => obRssiTspSlaves(i),
            -- Application Layer Interface
            sAppAxisMaster_i => ibRssiAppMasters(i),
            sAppAxisSlave_o  => ibRssiAppSlaves(i),
            mAppAxisMaster_o => obRssiAppMasters(i),
            mAppAxisSlave_i  => obRssiAppSlaves(i),
            -- High level  Application side interface
            openRq_i         => '0',    -- Enabled via software
            closeRq_i        => bypRssi(i),
            inject_i         => '0',
            -- AXI-Lite Interface
            axiClk_i         => axilClk,
            axiRst_i         => axilRst,
            axilReadMaster   => axilReadMasters(i+2),
            axilReadSlave    => axilReadSlaves(i+2),
            axilWriteMaster  => axilWriteMasters(i+2),
            axilWriteSlave   => axilWriteSlaves(i+2),
            -- Internal statuses
            statusReg_o      => statusReg(i));

      process(axilClk)
      begin
         if rising_edge(axilClk) then
            linkUp(i) <= statusReg(i)(0) after TPD_G;
         end if;
      end process;

   end generate GEN_LANE;

end mapping;
