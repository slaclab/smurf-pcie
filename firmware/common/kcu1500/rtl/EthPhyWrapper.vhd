-------------------------------------------------------------------------------
-- File       : EthPhyWrapper.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description:
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiStreamPkg.all;
use surf.AxiLitePkg.all;
use surf.EthMacPkg.all;
use surf.TenGigEthPkg.all;

use work.AppPkg.all;

library unisim;
use unisim.vcomponents.all;

entity EthPhyWrapper is
   generic (
      TPD_G           : time := 1 ns;
      AXI_BASE_ADDR_G : slv(31 downto 0));
   port (
      -- Local Configurations
      localMac        : out Slv48Array(NUM_RSSI_C-1 downto 0);
      localIp         : out Slv32Array(NUM_RSSI_C-1 downto 0);
      udpToPhyRoute   : in  Slv8Array(NUM_RSSI_C-1 downto 0);
      -- Streaming DMA Interface
      udpIbMasters    : out AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      udpIbSlaves     : in  AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      udpObMasters    : in  AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      udpObSlaves     : out AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      -- Slave AXI-Lite Interface
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType;
      ---------------------
      --  Hardware Ports
      ---------------------
      -- QSFP[0] Ports
      qsfp0RefClkP    : in  slv(1 downto 0);
      qsfp0RefClkN    : in  slv(1 downto 0);
      qsfp0RxP        : in  slv(3 downto 0);
      qsfp0RxN        : in  slv(3 downto 0);
      qsfp0TxP        : out slv(3 downto 0);
      qsfp0TxN        : out slv(3 downto 0);
      -- QSFP[1] Ports
      qsfp1RefClkP    : in  slv(1 downto 0);
      qsfp1RefClkN    : in  slv(1 downto 0);
      qsfp1RxP        : in  slv(3 downto 0);
      qsfp1RxN        : in  slv(3 downto 0);
      qsfp1TxP        : out slv(3 downto 0);
      qsfp1TxN        : out slv(3 downto 0));
end EthPhyWrapper;

architecture mapping of EthPhyWrapper is


   constant NUM_AXI_MASTERS_C : natural := 16;

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, AXI_BASE_ADDR_G, 16, 12);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_MASTER_INIT_C);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0)  := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_MASTER_INIT_C);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0)   := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

   signal phyIbMasters : AxiStreamMasterArray(7 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal phyIbSlaves  : AxiStreamSlaveArray(7 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);
   signal phyObMasters : AxiStreamMasterArray(7 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal phyObSlaves  : AxiStreamSlaveArray(7 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);

   signal mac : Slv48Array(7 downto 0) := (others => (others => '0'));
   signal ip  : Slv32Array(7 downto 0) := (others => (others => '0'));

   signal axilReset : sl;

   signal gtTxPreCursor  : Slv5Array(7 downto 0);
   signal gtTxPostCursor : Slv5Array(7 downto 0);
   signal gtTxDiffCtrl   : Slv4Array(7 downto 0);

   signal phyToUdpRoute : Slv8Array(7 downto 0);

   signal dmaClk     : slv(7 downto 0);
   signal dmaRst     : slv(7 downto 0);
   signal axiLiteClk : slv(7 downto 0);
   signal axiLiteRst : slv(7 downto 0);

   signal refClk                  : slv(1 downto 0);
   attribute dont_touch           : string;
   attribute dont_touch of refClk : signal is "TRUE";

begin

   dmaClk <= (others => axilClk);
   dmaRst <= (others => axilReset);

   axiLiteClk <= (others => axilClk);
   axiLiteRst <= (others => axilReset);

   -------------------------------
   -- TODO: Add routing logic here
   -------------------------------
   localMac <= mac(NUM_RSSI_C-1 downto 0);
   localIp  <= ip(NUM_RSSI_C-1 downto 0);

   udpIbMasters                       <= phyObMasters(NUM_RSSI_C-1 downto 0);
   phyObSlaves(NUM_RSSI_C-1 downto 0) <= udpIbSlaves;

   phyIbMasters(NUM_RSSI_C-1 downto 0) <= udpObMasters;
   udpObSlaves                         <= phyIbSlaves(NUM_RSSI_C-1 downto 0);

   -- ROUTE_TABLE : process (udpToPhyRoute) is
   -- variable route : Slv8Array(7 downto 0);
   -- begin
   -- -- Init
   -- route := (others => x"FF");

   -- -- Create the PHY-to-UDP route table
   -- for i in NUM_RSSI_C-1 downto 0 loop
   -- route(conv_integer(udpToPhyRoute(i))) := toSlv(i, 8);
   -- end loop;

   -- -- Outputs
   -- phyToUdpRoute <= route;

   -- end process;

   -- process(axilClk)
   -- begin
   -- if rising_edge(axilClk) then
   -- for i in 7 downto 0 loop
   -- if phyToUdpRoute(i) /= x"FF" then
   -- localMac(conv_integer(phyToUdpRoute(i))) <= mac(i) after TPD_G;
   -- localIp(conv_integer(phyToUdpRoute(i)))  <= ip(i)  after TPD_G;
   -- end if;
   -- end loop;
   -- end if;
   -- end process;

   -- U_IbRouter : entity work.AxiStreamRouter
   -- generic map (
   -- TPD_G                 => TPD_G,
   -- NUM_SLAVES_G          => 8,
   -- NUM_MASTERS_G         => NUM_RSSI_C,
   -- SLAVES_PIPE_STAGES_G  => 1,
   -- MASTERS_PIPE_STAGES_G => 1)
   -- port map (
   -- -- Clock and reset
   -- axisClk      => axilClk,
   -- axisRst      => axilReset,
   -- -- Routing Configuration
   -- routeConfig  => phyToUdpRoute,
   -- -- Slave Interfaces
   -- sAxisMasters => phyObMasters,
   -- sAxisSlaves  => phyObSlaves,
   -- -- Master Interfaces
   -- mAxisMasters => udpIbMasters,
   -- mAxisSlaves  => udpIbSlaves);

   -- U_ObRouter : entity work.AxiStreamRouter
   -- generic map (
   -- TPD_G                 => TPD_G,
   -- NUM_SLAVES_G          => NUM_RSSI_C,
   -- NUM_MASTERS_G         => 8,
   -- SLAVES_PIPE_STAGES_G  => 1,
   -- MASTERS_PIPE_STAGES_G => 1)
   -- port map (
   -- -- Clock and reset
   -- axisClk      => axilClk,
   -- axisRst      => axilReset,
   -- -- Routing Configuration
   -- routeConfig  => udpToPhyRoute,
   -- -- Slave Interfaces
   -- sAxisMasters => udpObMasters,
   -- sAxisSlaves  => udpObSlaves,
   -- -- Master Interfaces
   -- mAxisMasters => phyIbMasters,
   -- mAxisSlaves  => phyIbSlaves);

   -----------------
   -- Reset Pipeline
   -----------------
   U_axilRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axilClk,
         rstIn  => axilRst,
         rstOut => axilReset);

   ---------------------
   -- AXI-Lite Crossbar
   ---------------------
   U_XBAR : entity surf.AxiLiteCrossbar
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

   ----------------
   -- 10GigE Module
   ----------------
   U_QSFP0 : entity surf.TenGigEthGthUltraScaleWrapper
      generic map (
         TPD_G         => TPD_G,
         NUM_LANE_G    => 4,
         EN_AXI_REG_G  => true,
         -- AXI Streaming Configurations
         AXIS_CONFIG_G => (others => EMAC_AXIS_CONFIG_C))
      port map (
         -- Local Configurations
         localMac            => mac(3 downto 0),
         -- Streaming DMA Interface
         dmaClk              => dmaClk(3 downto 0),
         dmaRst              => dmaRst(3 downto 0),
         dmaIbMasters        => phyObMasters(3 downto 0),
         dmaIbSlaves         => phyObSlaves(3 downto 0),
         dmaObMasters        => phyIbMasters(3 downto 0),
         dmaObSlaves         => phyIbSlaves(3 downto 0),
         -- Slave AXI-Lite Interface
         axiLiteClk          => axiLiteClk(3 downto 0),
         axiLiteRst          => axiLiteRst(3 downto 0),
         axiLiteReadMasters  => axilReadMasters(3 downto 0),
         axiLiteReadSlaves   => axilReadSlaves(3 downto 0),
         axiLiteWriteMasters => axilWriteMasters(3 downto 0),
         axiLiteWriteSlaves  => axilWriteSlaves(3 downto 0),
         -- Misc. Signals
         extRst              => axilReset,
         -- Transceiver Debug Interface
--         gtTxPreCursor       => gtTxPreCursor(3 downto 0),
--         gtTxPostCursor      => gtTxPostCursor(3 downto 0),
--         gtTxDiffCtrl        => gtTxDiffCtrl(3 downto 0),
         -- MGT Clock Port
         gtClkP              => qsfp0RefClkP(0),
         gtClkN              => qsfp0RefClkN(0),
         -- MGT Ports
         gtTxP               => qsfp0TxP,
         gtTxN               => qsfp0TxN,
         gtRxP               => qsfp0RxP,
         gtRxN               => qsfp0RxN);

   U_QSFP1 : entity surf.TenGigEthGthUltraScaleWrapper
      generic map (
         TPD_G         => TPD_G,
         NUM_LANE_G    => 4,
         EN_AXI_REG_G  => true,
         -- AXI Streaming Configurations
         AXIS_CONFIG_G => (others => EMAC_AXIS_CONFIG_C))
      port map (
         -- Local Configurations
         localMac            => mac(7 downto 4),
         -- Streaming DMA Interface
         dmaClk              => dmaClk(7 downto 4),
         dmaRst              => dmaRst(7 downto 4),
         dmaIbMasters        => phyObMasters(7 downto 4),
         dmaIbSlaves         => phyObSlaves(7 downto 4),
         dmaObMasters        => phyIbMasters(7 downto 4),
         dmaObSlaves         => phyIbSlaves(7 downto 4),
         -- Slave AXI-Lite Interface
         axiLiteClk          => axiLiteClk(7 downto 4),
         axiLiteRst          => axiLiteRst(7 downto 4),
         axiLiteReadMasters  => axilReadMasters(7 downto 4),
         axiLiteReadSlaves   => axilReadSlaves(7 downto 4),
         axiLiteWriteMasters => axilWriteMasters(7 downto 4),
         axiLiteWriteSlaves  => axilWriteSlaves(7 downto 4),
         -- Misc. Signals
         extRst              => axilReset,
         -- Transceiver Debug Interface
--         gtTxPreCursor       => gtTxPreCursor(7 downto 4),
--         gtTxPostCursor      => gtTxPostCursor(7 downto 4),
--         gtTxDiffCtrl        => gtTxDiffCtrl(7 downto 4),
         -- MGT Clock Port
         gtClkP              => qsfp1RefClkP(0),
         gtClkN              => qsfp1RefClkN(0),
         -- MGT Ports
         gtTxP               => qsfp1TxP,
         gtTxN               => qsfp1TxN,
         gtRxP               => qsfp1RxP,
         gtRxN               => qsfp1RxN);

   -- U_QSFP1 : entity surf.TenGigEthGthUltraScaleWrapper
   -- generic map (
   -- TPD_G         => TPD_G,
   -- NUM_LANE_G    => 2,
   -- EN_AXI_REG_G  => true,
   -- -- AXI Streaming Configurations
   -- AXIS_CONFIG_G => (others => EMAC_AXIS_CONFIG_C))
   -- port map (
   -- -- Local Configurations
   -- localMac            => mac(5 downto 4),
   -- -- Streaming DMA Interface
   -- dmaClk              => dmaClk(5 downto 4),
   -- dmaRst              => dmaRst(5 downto 4),
   -- dmaIbMasters        => phyObMasters(5 downto 4),
   -- dmaIbSlaves         => phyObSlaves(5 downto 4),
   -- dmaObMasters        => phyIbMasters(5 downto 4),
   -- dmaObSlaves         => phyIbSlaves(5 downto 4),
   -- -- Slave AXI-Lite Interface
   -- axiLiteClk          => axiLiteClk(5 downto 4),
   -- axiLiteRst          => axiLiteRst(5 downto 4),
   -- axiLiteReadMasters  => axilReadMasters(5 downto 4),
   -- axiLiteReadSlaves   => axilReadSlaves(5 downto 4),
   -- axiLiteWriteMasters => axilWriteMasters(5 downto 4),
   -- axiLiteWriteSlaves  => axilWriteSlaves(5 downto 4),
   -- -- Misc. Signals
   -- extRst              => axilReset,
   -- -- MGT Clock Port
   -- gtClkP              => qsfp1RefClkP(0),
   -- gtClkN              => qsfp1RefClkN(0),
   -- -- MGT Ports
   -- gtTxP               => qsfp1TxP(1 downto 0),
   -- gtTxN               => qsfp1TxN(1 downto 0),
   -- gtRxP               => qsfp1RxP(1 downto 0),
   -- gtRxN               => qsfp1RxN(1 downto 0));

   -- U_GTH_TERM : entity surf.Gthe3ChannelDummy
   -- generic map (
   -- TPD_G   => TPD_G,
   -- WIDTH_G => 2)
   -- port map (
   -- refClk => axilRst,
   -- gtTxP  => qsfp1TxP(3 downto 2),
   -- gtTxN  => qsfp1TxN(3 downto 2),
   -- gtRxP  => qsfp1RxP(3 downto 2),
   -- gtRxN  => qsfp1RxN(3 downto 2));

   --------------------
   -- Unused GTH Clocks
   --------------------
   U_QsfpRef0 : IBUFDS_GTE3
      port map (
         I   => qsfp0RefClkP(1),
         IB  => qsfp0RefClkN(1),
         CEB => '0',
         O   => refClk(0));

   U_QsfpRef1 : IBUFDS_GTE3
      port map (
         I   => qsfp1RefClkP(1),
         IB  => qsfp1RefClkN(1),
         CEB => '0',
         O   => refClk(1));

   GEN_VEC : for i in 7 downto 0 generate

      U_EthConfig : entity work.EthConfig
         generic map (
            TPD_G => TPD_G)
         port map (
            localIp         => ip(i),
            localMac        => mac(i),
            gtTxPreCursor   => gtTxPreCursor(i),
            gtTxPostCursor  => gtTxPostCursor(i),
            gtTxDiffCtrl    => gtTxDiffCtrl(i),
            -- AXI-Lite Register Interface (axilClk domain)
            axilClk         => axilClk,
            axilRst         => axilReset,
            axilReadMaster  => axilReadMasters(i+8),
            axilReadSlave   => axilReadSlaves(i+8),
            axilWriteMaster => axilWriteMasters(i+8),
            axilWriteSlave  => axilWriteSlaves(i+8));

   end generate GEN_VEC;

end mapping;
