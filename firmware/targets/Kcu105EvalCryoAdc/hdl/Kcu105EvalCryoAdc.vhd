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
      jesdRxSyncLed : out sl;
      
      jesdSysRefP  : in sl;
      jesdSysRefN  : in sl;      
      
      -- Control ports
      fmcCtrl : out slv(1 downto 0);
      
      -- 10G-BaseR ETH Ports
      ethRxP   : in  sl;
      ethRxN   : in  sl;
      ethTxP   : out sl;
      ethTxN   : out sl);
end Kcu105MpsCentralNode;

architecture top_level of Kcu105MpsCentralNode is

   constant NUM_AXI_MASTERS_C : natural := 2;

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, AXI_BASE_ADDR_G, 30, 28);  -- [0x8FFFFFFF:0x80000000]

   constant REG_INDEX_C  : natural := 0;
   constant JESD_INDEX_C : natural := 1;
   --
   signal axilReadMaster  : AxiLiteReadMasterType;
   signal axilReadSlave   : AxiLiteReadSlaveType;
   signal axilWriteMaster : AxiLiteWriteMasterType;
   signal axilWriteSlave  : AxiLiteWriteSlaveType;
   --
   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   
   -- Internal signals   signal jesdClk   : sl;
   signal jesdRst   : sl;
   signal jesdClk2x : sl; 
   signal jesdRst2x : sl; 
   signal axilClk  : sl;
   signal axilRst  : sl;   
   signal phyReady : sl;
   signal adcValids : slv(GT_LANE_G-1 downto 0);
   signal adcValues : sampleDataArray(GT_LANE_G-1 downto 0);
   
   signal s_control : slv(31 downto 0);
   
   -- JESD
   signal jesdSysRef  : sl;
   signal jesdRxSync  : sl;   
   
begin

   ----------------------------------------------------------------
   -- JESD Buffers
   ----------------------------------------------------------------
   IBUFDS_SysRef : IBUFDS
      port map (
         I  => jesdSysRefP,
         IB => jesdSysRefN,
         O  => jesdSysRef);
         
   GEN_RX_SYNC :

   OBUFDS_RxSync : OBUFDS
      port map (
         I  => jesdRxSync,
         O  => jesdRxSyncP,
         OB => jesdRxSyncN);


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

   ---------------------
   -- AXI-Lite Crossbar
   ---------------------
   U_XBAR : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         DEC_ERROR_RESP_G   => AXI_ERROR_RESP_G,
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
         
   ----------------------
   -- Registers
   ----------------------         
   U_KcuReg: entity work.KcuReg
      generic map (
         TPD_G            => TPD_G,
         AXI_ERROR_RESP_G => AXI_ERROR_RESP_G)
      port map (
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMasters(REG_INDEX_C),
         axilReadSlave   => axilReadSlaves(REG_INDEX_C),
         axilWriteMaster => axilWriteMasters(REG_INDEX_C),
         axilWriteSlave  => axilWriteSlaves(REG_INDEX_C),
         devClk          => jesdClk,
         devRst          => jesdRst,
         control_o       => s_control,
         data_i          => adcValues);
   
   fmcCtrl(0) <= s_control(0);
   fmcCtrl(1) <= s_control(1);
   
   ----------------------
   -- Jesd
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
         jesdTxSync      => '0',
         adcValids       => adcValids,
         adcValues       => adcValues,
         dacValids       => (others => '0'),
         dacValues       => (others => (others=>'0')),
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMasters(JESD_INDEX_C),
         axilReadSlave   => axilReadSlaves(JESD_INDEX_C),
         axilWriteMaster => axilWriteMasters(JESD_INDEX_C),
         axilWriteSlave  => axilWriteSlaves(JESD_INDEX_C),
         jesdRxP         => jesdRxP,
         jesdRxN         => jesdRxN,
         jesdTxP         => jesdTxP,
         jesdTxN         => jesdTxN,
         jesdClkP        => jesdClkP,
         jesdClkN        => jesdClkN);


   -- Output assignment
   led(7) <= phyReady;
   led(6) <= jesdRst;
   led(5) <= extRst;
   -- led(4) <= '0'; 
   -- led(3) <= '0';
   led(2) <= jesdSysRef;   
   led(1) <= jesdRxSync;
   led(0) <= '0';   
   
   jesdRxSyncLed <= jesdRxSync;
   
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
      PERIOD_IN_G  => 3.2E-9,
      PERIOD_OUT_G => 0.5)-- 1 MHz
   port map (
      clk => jesdClk,
      rst => jesdRst,
      o   => led(4));  
   
   -- smaGpioP <= mpsTest(7);              -- J36
   -- smaGpioN <= mpsTest(2);              -- J37
   -- smaClkP  <= mpsTest(1);              -- J34
   -- smaClkN  <= mpsTest(0);              -- J35

end top_level;
