-------------------------------------------------------------------------------
-- File       : EthLane.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-02-06
-- Last update: 2018-03-16
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
use work.AxiPciePkg.all;
use work.EthMacPkg.all;
use work.AppPkg.all;

entity EthLane is
   generic (
      TPD_G            : time             := 1 ns;
      AXI_BASE_ADDR_G  : slv(31 downto 0) := BAR0_BASE_ADDR_C);
   port (
      -- RSSI Interface (axilClk domain)
      rssiLinkUp      : out slv(RSSI_PER_LINK_C-1 downto 0);
      rssiIbMasters   : in  AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
      rssiIbSlaves    : out AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0);
      rssiObMasters   : out AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
      rssiObSlaves    : in  AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0);
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

   constant WINDOW_ADDR_SIZE_C  : positive                                        := 2;
   constant APP_STREAM_CONFIG_C : AxiStreamConfigArray(RSSI_STREAMS_C-1 downto 0) := (others => DMA_AXIS_CONFIG_C);

   constant NUM_AXI_MASTERS_C : natural := (2+RSSI_PER_LINK_C);

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, AXI_BASE_ADDR_G, 19, 16);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

   signal obClientMasters : AxiStreamMasterArray(RSSI_PER_LINK_C-1 downto 0);
   signal obClientSlaves  : AxiStreamSlaveArray(RSSI_PER_LINK_C-1 downto 0);
   signal ibClientMasters : AxiStreamMasterArray(RSSI_PER_LINK_C-1 downto 0);
   signal ibClientSlaves  : AxiStreamSlaveArray(RSSI_PER_LINK_C-1 downto 0);

   signal obRssiTspMasters : AxiStreamMasterArray(RSSI_PER_LINK_C-1 downto 0);
   signal obRssiTspSlaves  : AxiStreamSlaveArray(RSSI_PER_LINK_C-1 downto 0);
   signal ibRssiTspMasters : AxiStreamMasterArray(RSSI_PER_LINK_C-1 downto 0);
   signal ibRssiTspSlaves  : AxiStreamSlaveArray(RSSI_PER_LINK_C-1 downto 0);

   signal obRssiAppMasters : AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
   signal obRssiAppSlaves  : AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0);
   signal ibRssiAppMasters : AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
   signal ibRssiAppSlaves  : AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0);

   signal localIp  : slv(31 downto 0);
   signal localMac : slv(47 downto 0);
   signal bypRssi  : slv(RSSI_PER_LINK_C-1 downto 0);

   signal statusReg : Slv7Array(RSSI_PER_LINK_C-1 downto 0);
   signal linkUp    : slv(RSSI_PER_LINK_C-1 downto 0);

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
         TPD_G            => TPD_G)
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
         CLIENT_SIZE_G  => RSSI_PER_LINK_C,
         CLIENT_PORTS_G => (
            0           => 9000,
            1           => 9001,
            2           => 9002,
            3           => 9003,
            4           => 9004,
            5           => 9005))
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
         obClientMasters => obClientMasters,
         obClientSlaves  => obClientSlaves,
         ibClientMasters => ibClientMasters,
         ibClientSlaves  => ibClientSlaves,
         -- AXI-Lite Interface
         axilReadMaster  => axilReadMasters(1),
         axilReadSlave   => axilReadSlaves(1),
         axilWriteMaster => axilWriteMasters(1),
         axilWriteSlave  => axilWriteSlaves(1),
         -- Clock and Reset
         clk             => axilClk,
         rst             => axilRst);

   GEN_LANE : for i in RSSI_PER_LINK_C-1 downto 0 generate

      U_EthTrafficSwitch : entity work.EthTrafficSwitch
         generic map (
            TPD_G => TPD_G)
         port map(
            -- Clock and reset
            axisClk         => axilClk,
            axisRst         => axilRst,
            -- Controls Interface
            rssiLinkUp      => linkUp(i),
            bypRssi         => bypRssi(i),
            -- UDP Interface
            sUdpMaster      => obClientMasters(i),
            sUdpSlave       => obClientSlaves(i),
            mUdpMaster      => ibClientMasters(i),
            mUdpSlave       => ibClientSlaves(i),
            -- RSSI Transport Interface
            sRssiTspMaster  => obRssiTspMasters(i),
            sRssiTspSlave   => obRssiTspSlaves(i),
            mRssiTspMaster  => ibRssiTspMasters(i),
            mRssiTspSlave   => ibRssiTspSlaves(i),
            -- RSSI Application Interface
            sRssiAppMasters => obRssiAppMasters((RSSI_STREAMS_C-1)+(RSSI_STREAMS_C*i) downto (RSSI_STREAMS_C*i)),
            sRssiAppSlaves  => obRssiAppSlaves((RSSI_STREAMS_C-1)+(RSSI_STREAMS_C*i) downto (RSSI_STREAMS_C*i)),
            mRssiAppMasters => ibRssiAppMasters((RSSI_STREAMS_C-1)+(RSSI_STREAMS_C*i) downto (RSSI_STREAMS_C*i)),
            mRssiAppSlaves  => ibRssiAppSlaves((RSSI_STREAMS_C-1)+(RSSI_STREAMS_C*i) downto (RSSI_STREAMS_C*i)),
            -- DMA Interface
            sDmaMasters     => rssiIbMasters((RSSI_STREAMS_C-1)+(RSSI_STREAMS_C*i) downto (RSSI_STREAMS_C*i)),
            sDmaSlaves      => rssiIbSlaves((RSSI_STREAMS_C-1)+(RSSI_STREAMS_C*i) downto (RSSI_STREAMS_C*i)),
            mDmaMasters     => rssiObMasters((RSSI_STREAMS_C-1)+(RSSI_STREAMS_C*i) downto (RSSI_STREAMS_C*i)),
            mDmaSlaves      => rssiObSlaves((RSSI_STREAMS_C-1)+(RSSI_STREAMS_C*i) downto (RSSI_STREAMS_C*i)));

      --------------------------
      -- Software's RSSI Clients
      --------------------------
      U_RssiClient : entity work.RssiCoreWrapper
         generic map (
            TPD_G               => TPD_G,
            APP_ILEAVE_EN_G     => true,
            APP_STREAMS_G       => RSSI_STREAMS_C,
            APP_STREAM_ROUTES_G => (
               0                => X"00",       -- TDEST 0 routed to stream 0 (SRPv3)
               1                => X"80",       -- TDEST x80 routed to stream 1 (Raw Data)
               2                => X"81",       -- TDEST x81 routed to stream 1 (Raw Data)
               3                => X"82",       -- TDEST x82 routed to stream 1 (Raw Data)
               4                => X"83",       -- TDEST x83 routed to stream 1 (Raw Data)
               5                => X"84",       -- TDEST x84 routed to stream 1 (Raw Data)
               6                => X"85",       -- TDEST x85 routed to stream 1 (Raw Data)
               7                => X"86",       -- TDEST x86 routed to stream 1 (Raw Data)
               8                => X"87",       -- TDEST x87 routed to stream 1 (Raw Data)
               9                => "11------"), -- TDEST 0xC0-0xFF routed to stream 2 (Application)   
            CLK_FREQUENCY_G     => APP_CLK_FREQ_C,
            TIMEOUT_UNIT_G      => 1.0E-3,  -- In units of seconds 
            SERVER_G            => false,  -- false = Client mode
            RETRANSMIT_ENABLE_G => true,
            WINDOW_ADDR_SIZE_G  => WINDOW_ADDR_SIZE_C,
            MAX_NUM_OUTS_SEG_G  => (2**WINDOW_ADDR_SIZE_C),
            PIPE_STAGES_G       => 1,
            APP_AXIS_CONFIG_G   => APP_STREAM_CONFIG_C,
            TSP_AXIS_CONFIG_G   => EMAC_AXIS_CONFIG_C,
            RETRANS_TOUT_G      => 100,    -- unit depends on TIMEOUT_UNIT_G  
            ACK_TOUT_G          => 50,  -- unit depends on TIMEOUT_UNIT_G 
            NULL_TOUT_G         => 400,    -- unit depends on TIMEOUT_UNIT_G 
            MAX_RETRANS_CNT_G   => 1,   -- 0x1 for HW-to-HW communication
            MAX_CUM_ACK_CNT_G   => 1)  -- 0x1 for HW-to-HW communication         
         port map (
            clk_i             => axilClk,
            rst_i             => axilRst,
            -- Transport Layer Interface
            sTspAxisMaster_i  => ibRssiTspMasters(i),
            sTspAxisSlave_o   => ibRssiTspSlaves(i),
            mTspAxisMaster_o  => obRssiTspMasters(i),
            mTspAxisSlave_i   => obRssiTspSlaves(i),
            -- Application Layer Interface
            sAppAxisMasters_i => ibRssiAppMasters((RSSI_STREAMS_C-1)+(RSSI_STREAMS_C*i) downto (RSSI_STREAMS_C*i)),
            sAppAxisSlaves_o  => ibRssiAppSlaves((RSSI_STREAMS_C-1)+(RSSI_STREAMS_C*i) downto (RSSI_STREAMS_C*i)),
            mAppAxisMasters_o => obRssiAppMasters((RSSI_STREAMS_C-1)+(RSSI_STREAMS_C*i) downto (RSSI_STREAMS_C*i)),
            mAppAxisSlaves_i  => obRssiAppSlaves((RSSI_STREAMS_C-1)+(RSSI_STREAMS_C*i) downto (RSSI_STREAMS_C*i)),
            -- High level  Application side interface
            openRq_i          => '0',   -- Enabled via software
            closeRq_i         => bypRssi(i),
            inject_i          => '0',
            -- AXI-Lite Interface
            axiClk_i          => axilClk,
            axiRst_i          => axilRst,
            axilReadMaster    => axilReadMasters(i+2),
            axilReadSlave     => axilReadSlaves(i+2),
            axilWriteMaster   => axilWriteMasters(i+2),
            axilWriteSlave    => axilWriteSlaves(i+2),
            -- Internal statuses
            statusReg_o       => statusReg(i));

      process(axilClk)
      begin
         if rising_edge(axilClk) then
            linkUp(i) <= statusReg(i)(0) after TPD_G;
         end if;
      end process;

   end generate GEN_LANE;

end mapping;
