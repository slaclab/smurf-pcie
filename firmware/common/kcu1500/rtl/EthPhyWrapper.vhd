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

   signal axilWriteMasters : AxiLiteWriteMasterArray(7 downto 0) := (others => AXI_LITE_WRITE_MASTER_INIT_C);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(7 downto 0)  := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal axilReadMasters  : AxiLiteReadMasterArray(7 downto 0)  := (others => AXI_LITE_READ_MASTER_INIT_C);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(7 downto 0)   := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

   signal ibMasters : AxiStreamMasterArray(7 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal ibSlaves  : AxiStreamSlaveArray(7 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);
   signal obMasters : AxiStreamMasterArray(7 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal obSlaves  : AxiStreamSlaveArray(7 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);

   signal mac   : Slv48Array(7 downto 0) := (others => (others => '0'));
   signal ready : slv(7 downto 0)        := (others => '0');

   signal dmaClk : slv(7 downto 0) := (others => '0');
   signal dmaRst : slv(7 downto 0) := (others => '1');

   signal axilReset : sl;

   signal refClk                  : slv(1 downto 0);
   attribute dont_touch           : string;
   attribute dont_touch of refClk : signal is "TRUE";

begin

   -------------------------------
   -- TODO: Add routing logic here 
   -------------------------------
   dmaClk(NUM_RSSI_C-1 downto 0) <= (others => axilClk);
   dmaRst(NUM_RSSI_C-1 downto 0) <= (others => axilReset);

   mac(NUM_RSSI_C-1 downto 0) <= localMac;
   phyReady                   <= ready(NUM_RSSI_C-1 downto 0);

   dmaIbMasters                    <= ibMasters(NUM_RSSI_C-1 downto 0);
   ibSlaves(NUM_RSSI_C-1 downto 0) <= dmaIbSlaves;

   obMasters(NUM_RSSI_C-1 downto 0) <= dmaObMasters;
   dmaObSlaves                      <= obSlaves(NUM_RSSI_C-1 downto 0);

   -----------------
   -- Reset Pipeline
   -----------------
   U_axilRst : entity work.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axilClk,
         rstIn  => axilRst,
         rstOut => axilReset);

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
         axiClkRst           => axilReset,
         sAxiWriteMasters(0) => axilWriteMaster,
         sAxiWriteSlaves(0)  => axilWriteSlave,
         sAxiReadMasters(0)  => axilReadMaster,
         sAxiReadSlaves(0)   => axilReadSlave,
         mAxiWriteMasters    => axilWriteMasters(NUM_RSSI_C-1 downto 0),
         mAxiWriteSlaves     => axilWriteSlaves(NUM_RSSI_C-1 downto 0),
         mAxiReadMasters     => axilReadMasters(NUM_RSSI_C-1 downto 0),
         mAxiReadSlaves      => axilReadSlaves(NUM_RSSI_C-1 downto 0));

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
         localMac            => mac(3 downto 0),
         -- Streaming DMA Interface 
         dmaClk              => dmaClk(3 downto 0),
         dmaRst              => dmaRst(3 downto 0),
         dmaIbMasters        => ibMasters(3 downto 0),
         dmaIbSlaves         => ibSlaves(3 downto 0),
         dmaObMasters        => obMasters(3 downto 0),
         dmaObSlaves         => obSlaves(3 downto 0),
         -- Slave AXI-Lite Interface 
         axiLiteClk          => dmaClk(3 downto 0),
         axiLiteRst          => dmaRst(3 downto 0),
         axiLiteReadMasters  => axilReadMasters(3 downto 0),
         axiLiteReadSlaves   => axilReadSlaves(3 downto 0),
         axiLiteWriteMasters => axilWriteMasters(3 downto 0),
         axiLiteWriteSlaves  => axilWriteSlaves(3 downto 0),
         -- Misc. Signals
         extRst              => axilReset,
         phyReady            => ready(3 downto 0),
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
         localMac            => mac(7 downto 4),
         -- Streaming DMA Interface 
         dmaClk              => dmaClk(7 downto 4),
         dmaRst              => dmaRst(7 downto 4),
         dmaIbMasters        => ibMasters(7 downto 4),
         dmaIbSlaves         => ibSlaves(7 downto 4),
         dmaObMasters        => obMasters(7 downto 4),
         dmaObSlaves         => obSlaves(7 downto 4),
         -- Slave AXI-Lite Interface 
         axiLiteClk          => dmaClk(7 downto 4),
         axiLiteRst          => dmaRst(7 downto 4),
         axiLiteReadMasters  => axilReadMasters(7 downto 4),
         axiLiteReadSlaves   => axilReadSlaves(7 downto 4),
         axiLiteWriteMasters => axilWriteMasters(7 downto 4),
         axiLiteWriteSlaves  => axilWriteSlaves(7 downto 4),
         -- Misc. Signals
         extRst              => axilReset,
         phyReady            => ready(7 downto 4),
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
