-------------------------------------------------------------------------------
-- File       : EthPhyWrapper.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2015-04-08
-- Last update: 2018-05-10
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
      TPD_G : time := 1 ns);
   port (
      -- Local Configurations
      localMac     : in  Slv48Array(NUM_LINKS_C-1 downto 0) := (others => MAC_ADDR_INIT_C);
      -- Streaming DMA Interface 
      dmaClk       : in  sl;
      dmaRst       : in  sl;
      dmaIbMasters : out AxiStreamMasterArray(NUM_LINKS_C-1 downto 0);
      dmaIbSlaves  : in  AxiStreamSlaveArray(NUM_LINKS_C-1 downto 0);
      dmaObMasters : in  AxiStreamMasterArray(NUM_LINKS_C-1 downto 0);
      dmaObSlaves  : out AxiStreamSlaveArray(NUM_LINKS_C-1 downto 0);
      -- Misc. Signals
      extRst       : in  sl;
      phyReady     : out slv(NUM_LINKS_C-1 downto 0);
      ---------------------
      --  Hardware Ports
      ---------------------    
      -- QSFP[0] Ports
      qsfp0RefClkP : in  slv(1 downto 0);
      qsfp0RefClkN : in  slv(1 downto 0);
      qsfp0RxP     : in  slv(3 downto 0);
      qsfp0RxN     : in  slv(3 downto 0);
      qsfp0TxP     : out slv(3 downto 0);
      qsfp0TxN     : out slv(3 downto 0);
      -- QSFP[1] Ports
      qsfp1RefClkP : in  slv(1 downto 0);
      qsfp1RefClkN : in  slv(1 downto 0);
      qsfp1RxP     : in  slv(3 downto 0);
      qsfp1RxN     : in  slv(3 downto 0);
      qsfp1TxP     : out slv(3 downto 0);
      qsfp1TxN     : out slv(3 downto 0));

end EthPhyWrapper;

architecture mapping of EthPhyWrapper is

   signal qplllock      : slv(1 downto 0);
   signal qplloutclk    : slv(1 downto 0);
   signal qplloutrefclk : slv(1 downto 0);

   signal qplllockVec      : slv(7 downto 0);
   signal qplloutclkVec    : slv(7 downto 0);
   signal qplloutrefclkVec : slv(7 downto 0);

   signal qpllRst    : slv(1 downto 0);
   signal qpllRstVec : slv(7 downto 0) := (others => '0');

   signal coreClk : slv(1 downto 0);
   signal coreRst : slv(1 downto 0);

   signal coreClkVec : slv(7 downto 0);
   signal coreRstVec : slv(7 downto 0);

   signal refClk : slv(1 downto 0);

   signal ethRxP : slv(7 downto 0);
   signal ethRxN : slv(7 downto 0);
   signal ethTxP : slv(7 downto 0);
   signal ethTxN : slv(7 downto 0);

   attribute dont_touch           : string;
   attribute dont_touch of refClk : signal is "TRUE";

begin

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

   -----------------
   -- Power Up Reset
   -----------------
   U_PwrUpRst0 : entity work.PwrUpRst
      generic map (
         TPD_G      => TPD_G,
         DURATION_G => 15625000)        -- 100 ms
      port map (
         arst   => extRst,
         clk    => coreClk(0),
         rstOut => coreRst(0));

   U_PwrUpRst1 : entity work.PwrUpRst
      generic map (
         TPD_G      => TPD_G,
         DURATION_G => 15625000)        -- 100 ms
      port map (
         arst   => extRst,
         clk    => coreClk(1),
         rstOut => coreRst(1));

   ----------------------
   -- Common Clock Module 
   ----------------------
   U_QPLL0 : entity work.TenGigEthGthUltraScaleClk
      generic map (
         TPD_G             => TPD_G,
         QPLL_REFCLK_SEL_G => "001")
      port map (
         -- MGT Clock Port (156.25 MHz)
         gtClkP        => qsfp0RefClkP(0),
         gtClkN        => qsfp0RefClkN(0),
         coreClk       => coreClk(0),
         coreRst       => coreRst(0),
         -- Quad PLL Ports
         qplllock      => qplllock(0),
         qplloutclk    => qplloutclk(0),
         qplloutrefclk => qplloutrefclk(0),
         qpllRst       => qpllRst(0));

   qpllRst(0) <= uOr(qpllRstVec(3 downto 0)) and not(qPllLock(0));

   U_QPLL1 : entity work.TenGigEthGthUltraScaleClk
      generic map (
         TPD_G             => TPD_G,
         QPLL_REFCLK_SEL_G => "001")
      port map (
         -- MGT Clock Port (156.25 MHz)
         gtClkP        => qsfp1RefClkP(0),
         gtClkN        => qsfp1RefClkN(0),
         coreClk       => coreClk(1),
         coreRst       => coreRst(1),
         -- Quad PLL Ports
         qplllock      => qplllock(1),
         qplloutclk    => qplloutclk(1),
         qplloutrefclk => qplloutrefclk(1),
         qpllRst       => qpllRst(1));

   qpllRst(1) <= uOr(qpllRstVec(7 downto 4)) and not(qPllLock(1));

   --------------------------------
   -- Mapping QSFP[1:0] to ETH[7:0]
   --------------------------------
   MAP_QSFP : for i in 3 downto 0 generate
      -- QSFP[0] to ETH[3:0]
      coreClkVec(i+0)       <= coreClk(0);
      coreRstVec(i+0)       <= coreRst(0);
      qplllockVec(i+0)      <= qplllock(0);
      qplloutclkVec(i+0)    <= qplloutclk(0);
      qplloutrefclkVec(i+0) <= qplloutrefclk(0);
      ethRxP(i+0)           <= qsfp0RxP(i);
      ethRxN(i+0)           <= qsfp0RxN(i);
      qsfp0TxP(i)           <= ethTxP(i+0);
      qsfp0TxN(i)           <= ethTxN(i+0);
      -- QSFP[1] to ETH[7:4]
      coreClkVec(i+4)       <= coreClk(1);
      coreRstVec(i+4)       <= coreRst(1);
      qplllockVec(i+4)      <= qplllock(1);
      qplloutclkVec(i+4)    <= qplloutclk(1);
      qplloutrefclkVec(i+4) <= qplloutrefclk(1);
      ethRxP(i+4)           <= qsfp1RxP(i);
      ethRxN(i+4)           <= qsfp1RxN(i);
      qsfp1TxP(i)           <= ethTxP(i+4);
      qsfp1TxN(i)           <= ethTxN(i+4);
   end generate MAP_QSFP;

   ----------------
   -- 10GigE Module 
   ----------------
   GEN_LANE :
   for i in 0 to NUM_LINKS_C-1 generate

      TenGigEthGthUltraScale_Inst : entity work.TenGigEthGthUltraScale
         generic map (
            TPD_G         => TPD_G,
            -- AXI-Lite Configurations
            EN_AXI_REG_G  => false,
            -- AXI Streaming Configurations
            AXIS_CONFIG_G => EMAC_AXIS_CONFIG_C)
         port map (
            -- Local Configurations
            localMac      => localMac(i),
            -- Streaming DMA Interface 
            dmaClk        => dmaClk,
            dmaRst        => dmaRst,
            dmaIbMaster   => dmaIbMasters(i),
            dmaIbSlave    => dmaIbSlaves(i),
            dmaObMaster   => dmaObMasters(i),
            dmaObSlave    => dmaObSlaves(i),
            -- Misc. Signals
            coreClk       => coreClkVec(i),
            extRst        => coreRstVec(i),
            phyReady      => phyReady(i),
            -- Quad PLL Ports
            qplllock      => qplllockVec(i),
            qplloutclk    => qplloutclkVec(i),
            qplloutrefclk => qplloutrefclkVec(i),
            -- MGT Ports
            gtTxP         => ethTxP(i),
            gtTxN         => ethTxN(i),
            gtRxP         => ethRxP(i),
            gtRxN         => ethRxN(i));

   end generate GEN_LANE;

   GEN_GTH_TERM : if (NUM_LINKS_C /= 8) generate
      U_GTH : entity work.Gthe3ChannelDummy
         generic map (
            TPD_G   => TPD_G,
            WIDTH_G => (8-NUM_LINKS_C))
         port map (
            refClk => dmaClk,
            gtTxP  => ethTxP(7 downto NUM_LINKS_C),
            gtTxN  => ethTxN(7 downto NUM_LINKS_C),
            gtRxP  => ethRxP(7 downto NUM_LINKS_C),
            gtRxN  => ethRxN(7 downto NUM_LINKS_C));
   end generate;

end mapping;
