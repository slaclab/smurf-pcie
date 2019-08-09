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

use work.StdRtlPkg.all;
use work.AxiStreamPkg.all;
use work.AxiLitePkg.all;
use work.EthMacPkg.all;
use work.TenGigEthPkg.all;
use work.AppPkg.all;

library unisim;
use unisim.vcomponents.all;

entity EthPhyWrapper is
   generic (
      TPD_G           : time := 1 ns;
      AXI_BASE_ADDR_G : slv(31 downto 0));
   port (
      -- Local Configurations
      localMac        : in  Slv48Array(NUM_RSSI_C-1 downto 0);
      -- Streaming DMA Interface 
      dmaIbMasters    : out AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      dmaIbSlaves     : in  AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      dmaObMasters    : in  AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      dmaObSlaves     : out AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      -- Slave AXI-Lite Interface 
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType;
      -- Misc. Signals
      phyReady        : out slv(NUM_RSSI_C-1 downto 0);
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

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_RSSI_C-1 downto 0) := genAxiLiteConfig(NUM_RSSI_C, AXI_BASE_ADDR_G, 16, 12);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_RSSI_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_RSSI_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_RSSI_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_RSSI_C-1 downto 0);

   signal refClk                  : slv(1 downto 0);
   attribute dont_touch           : string;
   attribute dont_touch of refClk : signal is "TRUE";

begin

   ---------------------
   -- AXI-Lite Crossbar
   ---------------------
   U_XBAR : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 1,
         NUM_MASTER_SLOTS_G => NUM_RSSI_C,
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

   ----------------
   -- 10GigE Module 
   ----------------
   U_QSFP0 : entity work.TenGigEthGthUltraScaleWrapper
      generic map (
         TPD_G         => TPD_G,
         NUM_LANE_G    => 4,
         EN_AXI_REG_G  => true,
         -- AXI Streaming Configurations
         AXIS_CONFIG_G => (others => EMAC_AXIS_CONFIG_C))
      port map (
         -- Local Configurations
         localMac            => localMac(3 downto 0),
         -- Streaming DMA Interface 
         dmaClk              => (others => axilClk),
         dmaRst              => (others => axilRst),
         dmaIbMasters        => dmaIbMasters(3 downto 0),
         dmaIbSlaves         => dmaIbSlaves(3 downto 0),
         dmaObMasters        => dmaObMasters(3 downto 0),
         dmaObSlaves         => dmaObSlaves(3 downto 0),
         -- Slave AXI-Lite Interface 
         axiLiteClk          => (others => axilClk),
         axiLiteRst          => (others => axilRst),
         axiLiteReadMasters  => axilReadMasters(3 downto 0),
         axiLiteReadSlaves   => axilReadSlaves(3 downto 0),
         axiLiteWriteMasters => axilWriteMasters(3 downto 0),
         axiLiteWriteSlaves  => axilWriteSlaves(3 downto 0),
         -- Misc. Signals
         extRst              => axilRst,
         phyReady            => phyReady(3 downto 0),
         -- MGT Clock Port
         gtClkP              => qsfp0RefClkP(0),
         gtClkN              => qsfp0RefClkN(0),
         -- MGT Ports
         gtTxP               => qsfp0TxP,
         gtTxN               => qsfp0TxN,
         gtRxP               => qsfp0RxP,
         gtRxN               => qsfp0RxN);

   U_QSFP1 : entity work.TenGigEthGthUltraScaleWrapper
      generic map (
         TPD_G         => TPD_G,
         NUM_LANE_G    => 4,
         EN_AXI_REG_G  => true,
         -- AXI Streaming Configurations
         AXIS_CONFIG_G => (others => EMAC_AXIS_CONFIG_C))
      port map (
         -- Local Configurations
         localMac            => localMac(7 downto 4),
         -- Streaming DMA Interface 
         dmaClk              => (others => axilClk),
         dmaRst              => (others => axilRst),
         dmaIbMasters        => dmaIbMasters(7 downto 4),
         dmaIbSlaves         => dmaIbSlaves(7 downto 4),
         dmaObMasters        => dmaObMasters(7 downto 4),
         dmaObSlaves         => dmaObSlaves(7 downto 4),
         -- Slave AXI-Lite Interface 
         axiLiteClk          => (others => axilClk),
         axiLiteRst          => (others => axilRst),
         axiLiteReadMasters  => axilReadMasters(7 downto 4),
         axiLiteReadSlaves   => axilReadSlaves(7 downto 4),
         axiLiteWriteMasters => axilWriteMasters(7 downto 4),
         axiLiteWriteSlaves  => axilWriteSlaves(7 downto 4),
         -- Misc. Signals
         extRst              => axilRst,
         phyReady            => phyReady(7 downto 4),
         -- MGT Clock Port
         gtClkP              => qsfp1RefClkP(0),
         gtClkN              => qsfp1RefClkN(0),
         -- MGT Ports
         gtTxP               => qsfp1TxP,
         gtTxN               => qsfp1TxN,
         gtRxP               => qsfp1RxP,
         gtRxN               => qsfp1RxN);

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

end mapping;
