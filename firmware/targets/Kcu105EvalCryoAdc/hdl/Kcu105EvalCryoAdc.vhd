-------------------------------------------------------------------------------
-- Title      : 
-------------------------------------------------------------------------------
-- File       : Kcu105MpsCentralNode.vhd
-- Author     : Larry Ruckman  <ruckman@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2016-01-25
-- Last update: 2016-03-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
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

library unisim;
use unisim.vcomponents.all;

entity Kcu105MpsCentralNode is
   generic (
      TPD_G            : time             := 1 ns;
      BUILD_INFO_G     : BuildInfoType;
      AXI_ERROR_RESP_G : slv(1 downto 0)  := AXI_RESP_DECERR_C;
      MAC_ADDR_G       : slv(47 downto 0) := MAC_ADDR_INIT_C;
      IP_ADDR_G        : slv(31 downto 0) := x"0A02A8C0";
      PGP_SIZE_G       : positive := 13);
   port (
      -- XADC Ports
      vPIn     : in  sl;
      vNIn     : in  sl;
      -- System Ports
      extRst   : in  sl;
      led      : out slv(7 downto 0);
      clkRefP  : in  sl;                -- 156.25 MHz
      clkRefN  : in  sl;
      -- gpioSw   : in  slv(3 downto 0);
      smaGpioP : out sl;
      smaGpioN : out sl;
      smaClkP  : out sl;
      smaClkN  : out sl;
      
      -- Jesd Ports
      jesdRxP   : in  slv(3 downto 0);
      jesdRxN   : in  slv(3 downto 0);
      jesdTxP   : out slv(3 downto 0);
      jesdTxN   : out slv(3 downto 0);
      
      jesdClkP  : in sl;
      jesdClkN  : in sl;

      jesdRxSyncP : out sl;   
      jesdRxSyncN : out sl;
      
      -- Control ports
      fmcCtrl : out slv(1 downto 0);
      
      -- 10G-BaseR ETH Ports
      ethRxP   : in  sl;
      ethRxN   : in  sl;
      ethTxP   : out sl;
      ethTxN   : out sl);
end Kcu105MpsCentralNode;

architecture top_level of Kcu105MpsCentralNode is
   
   signal axilReadMaster  : AxiLiteReadMasterType;
   signal axilReadSlave   : AxiLiteReadSlaveType;
   signal axilWriteMaster : AxiLiteWriteMasterType;
   signal axilWriteSlave  : AxiLiteWriteSlaveType;

   signal jesdClk   : sl;
   signal jesdRst   : sl;
   signal jesdClk2x : sl; 
   signal jesdRst2x : sl; 
   signal axilClk  : sl;
   signal axilRst  : sl;   
   signal phyReady : sl;

   
begin

   --------------
   -- Core Module
   --------------
   U_Core : entity work.Kcu105Core
      generic map (
         TPD_G            => TPD_G,
         BUILD_INFO_G     => BUILD_INFO_G,
         AXI_ERROR_RESP_G => AXI_ERROR_RESP_G,
         MAC_ADDR_G       => MAC_ADDR_G,
         IP_ADDR_G        => IP_ADDR_G)
      port map (
         -- Top Level Interface
         axilClk        => axilClk,
         axilRst        => axilRst,
         axilReadMaster  => axilReadMaster,
         axilReadSlave   => axilReadSlave,
         axilWriteMaster => axilWriteMaster,
         axilWriteSlave  => axilWriteSlave,
                       
         -- XADC Ports
         vPIn           => vPIn,
         vNIn           => vNIn,
         -- System Ports
         extRst         => extRst,
         clkRefP        => clkRefP,
         clkRefN        => clkRefN,
         phyReady       => phyReady,
         -- 10G-BaseR ETH Ports
         ethRxP         => ethRxP,
         ethRxN         => ethRxN,
         ethTxP         => ethTxP,
         ethTxN         => ethTxN);

   ----------------------
   -- Application
   ----------------------
   U_jesd : entity work.KcuJesd
   generic map (
      TPD_G              => TPD_G,
      AXI_ERROR_RESP_G   => AXI_ERROR_RESP_G,
      AXI_BASE_ADDR_G    => AXI_BASE_ADDR_G,
      JESD_DRP_EN_G      => JESD_DRP_EN_G,
      JESD_RX_LANE_G     => JESD_RX_LANE_G,
      JESD_TX_LANE_G     => JESD_TX_LANE_G,
      JESD_RX_POLARITY_G => JESD_RX_POLARITY_G,
      JESD_TX_POLARITY_G => JESD_TX_POLARITY_G,
      JESD_RX_ROUTES_G   => JESD_RX_ROUTES_G,
      JESD_TX_ROUTES_G   => JESD_TX_ROUTES_G,
      JESD_REF_SEL_G     => JESD_REF_SEL_G)
   port map (
      jesdClk         => jesdClk,
      jesdRst         => jesdRst,
      jesdClk2x       => jesdClk2x,
      jesdRst2x       => jesdRst2x,
      jesdSysRef      => jesdSysRef,
      jesdRxSync      => jesdRxSync,
      jesdTxSync      => jesdTxSync,
      adcValids       => adcValids,
      adcValues       => adcValues,
      dacValids       => (others => '0'),
      dacValues       => (others => (others=>'0')),
      axilClk         => axilClk,
      axilRst         => axilRst,
      axilReadMaster  => axilReadMaster,
      axilReadSlave   => axilReadSlave,
      axilWriteMaster => axilWriteMaster,
      axilWriteSlave  => axilWriteSlave,
      jesdRxP         => jesdRxP,
      jesdRxN         => jesdRxN,
      jesdTxP         => jesdTxP,
      jesdTxN         => jesdTxN,
      jesdClkP        => jesdClkP,
      jesdClkN        => jesdClkN);



   led(7) <= phyReady;
   led(6) <= pgpRst0;
   led(5) <= extRst;
   -- led(4) <= '0'; 
   -- led(3) <= '0';
   led(2) <= '0';   
   led(1) <= '0';
   led(0) <= '0';   
   
   U_axi_Heartbeat: entity work.Heartbeat
   generic map (
      TPD_G        => TPD_G,
      USE_DSP48_G  => "yes",
      PERIOD_IN_G  => 6.4E-9,
      PERIOD_OUT_G => 0.5)-- 1 MHz
   port map (
      clk => axilClk,
      rst => axilRst,
      o   => led(3)); 
   
   U_pgp_Heartbeat: entity work.Heartbeat
   generic map (
      TPD_G        => TPD_G,
      USE_DSP48_G  => "yes",
      PERIOD_IN_G  => 4.0E-9,
      PERIOD_OUT_G => 0.5)-- 1 MHz
   port map (
      clk => pgpClk,
      rst => pgpRst0,
      o   => led(4));  
   
   smaGpioP <= mpsTest(7);              -- J36
   smaGpioN <= mpsTest(2);              -- J37
   smaClkP  <= mpsTest(1);              -- J34
   smaClkN  <= mpsTest(0);              -- J35

end top_level;
