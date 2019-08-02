-------------------------------------------------------------------------------
-- File       : Kcu105TenGigE.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2015-04-08
-- Last update: 2019-08-01
-------------------------------------------------------------------------------
-- Description: Example using 10G-BASER Protocol
-------------------------------------------------------------------------------
-- This file is part of 'Example Project Firmware'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'Example Project Firmware', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.StdRtlPkg.all;
use work.AxiStreamPkg.all;
use work.AxiLitePkg.all;
use work.EthMacPkg.all;

library unisim;
use unisim.vcomponents.all;

entity Kcu105TenGigE is
   generic (
      TPD_G         : time    := 1 ns;
      BUILD_INFO_G  : BuildInfoType;
      SIM_SPEEDUP_G : boolean := false;
      SIMULATION_G  : boolean := false);
   port (
      -- Misc. IOs
      extRst          : in  sl;
      led             : out slv(7 downto 0);
      gpioDip         : in  slv(3 downto 0);
      -- FMC Ports
      fmcLed          : out slv(3 downto 0);
      fmcSfpLossL     : in  slv(3 downto 0);
      fmcTxFault      : in  slv(3 downto 0);
      fmcSfpTxDisable : out slv(3 downto 0);
      fmcSfpRateSel   : out slv(3 downto 0);
      fmcSfpModDef0   : out slv(3 downto 0);
      fmcRxP          : in  slv(3 downto 0);
      fmcRxN          : in  slv(3 downto 0);
      fmcTxP          : out slv(3 downto 0);
      fmcTxN          : out slv(3 downto 0);
      -- SFP Ports
      sfpClkP         : in  sl;
      sfpClkN         : in  sl;
      sfpRxP          : in  slv(1 downto 0);
      sfpRxN          : in  slv(1 downto 0);
      sfpTxP          : out slv(1 downto 0);
      sfpTxN          : out slv(1 downto 0));
end Kcu105TenGigE;

architecture top_level of Kcu105TenGigE is

   constant AXIS_SIZE_C : positive := 6;

   signal txMasters : AxiStreamMasterArray(AXIS_SIZE_C-1 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal txSlaves  : AxiStreamSlaveArray(AXIS_SIZE_C-1 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);
   signal rxMasters : AxiStreamMasterArray(AXIS_SIZE_C-1 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal rxSlaves  : AxiStreamSlaveArray(AXIS_SIZE_C-1 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);

   signal phyWriteMasters : AxiLiteWriteMasterArray(AXIS_SIZE_C-1 downto 0) := (others => AXI_LITE_WRITE_MASTER_INIT_C);
   signal phyWriteSlaves  : AxiLiteWriteSlaveArray(AXIS_SIZE_C-1 downto 0)  := (others => AXI_LITE_WRITE_SLAVE_EMPTY_DECERR_C);
   signal phyReadMasters  : AxiLiteReadMasterArray(AXIS_SIZE_C-1 downto 0)  := (others => AXI_LITE_READ_MASTER_INIT_C);
   signal phyReadSlaves   : AxiLiteReadSlaveArray(AXIS_SIZE_C-1 downto 0)   := (others => AXI_LITE_READ_SLAVE_EMPTY_DECERR_C);

   signal gtRefClk     : sl;
   signal gtRefClkBufg : sl;
   signal clk          : sl;
   signal rst          : sl;
   signal reset        : sl;
   signal phyReady     : slv(AXIS_SIZE_C-1 downto 0) := (others => '0');
   signal dmaClk       : slv(AXIS_SIZE_C-1 downto 0) := (others => '0');
   signal dmaRst       : slv(AXIS_SIZE_C-1 downto 0) := (others => '0');

   signal ethMac : Slv48Array(AXIS_SIZE_C-1 downto 0) := (others => x"000000564400");  -- 00:44:56:00:00:XX
   signal ethIp  : Slv32Array(AXIS_SIZE_C-1 downto 0) := (others => x"0002A8C0");  -- 192.168.2.XX


begin

   dmaClk <= (others => clk);
   dmaRst <= (others => rst);

   -----------------
   -- Power Up Reset
   -----------------
   PwrUpRst_Inst : entity work.PwrUpRst
      generic map (
         TPD_G => TPD_G)
      port map (
         arst   => extRst,
         clk    => clk,
         rstOut => reset);

   ------------------
   -- 10 GigE Modules
   ------------------
   U_SFP : entity work.TenGigEthGthUltraScaleWrapper
      generic map (
         TPD_G         => TPD_G,
         NUM_LANE_G    => 2,
         EXT_REF_G     => false,
         EN_AXI_REG_G  => true,
         -- AXI Streaming Configurations
         AXIS_CONFIG_G => (others => EMAC_AXIS_CONFIG_C))
      port map (
         -- Local Configurations
         localMac            => ethMac(1 downto 0),
         -- Streaming DMA Interface 
         dmaClk              => dmaClk(1 downto 0),
         dmaRst              => dmaRst(1 downto 0),
         dmaIbMasters        => rxMasters(1 downto 0),
         dmaIbSlaves         => rxSlaves(1 downto 0),
         dmaObMasters        => txMasters(1 downto 0),
         dmaObSlaves         => txSlaves(1 downto 0),
         -- Slave AXI-Lite Interface 
         axiLiteClk          => dmaClk(1 downto 0),
         axiLiteRst          => dmaRst(1 downto 0),
         axiLiteReadMasters  => phyReadMasters(1 downto 0),
         axiLiteReadSlaves   => phyReadSlaves(1 downto 0),
         axiLiteWriteMasters => phyWriteMasters(1 downto 0),
         axiLiteWriteSlaves  => phyWriteSlaves(1 downto 0),
         -- Misc. Signals
         extRst              => reset,
         coreClk             => clk,
         coreRst             => rst,
         phyReady            => phyReady(1 downto 0),
         gtClk               => gtRefClk,
         -- MGT Clock Port
         gtClkP              => sfpClkP,
         gtClkN              => sfpClkN,
         -- MGT Ports
         gtTxP               => sfpTxP,
         gtTxN               => sfpTxN,
         gtRxP               => sfpRxP,
         gtRxN               => sfpRxN);

   U_FMC : entity work.TenGigEthGthUltraScaleWrapper
      generic map (
         TPD_G         => TPD_G,
         NUM_LANE_G    => 4,
         EXT_REF_G     => true,
         EN_AXI_REG_G  => true,
         -- AXI Streaming Configurations
         AXIS_CONFIG_G => (others => EMAC_AXIS_CONFIG_C))
      port map (
         -- Local Configurations
         localMac            => ethMac(5 downto 2),
         -- Streaming DMA Interface 
         dmaClk              => dmaClk(5 downto 2),
         dmaRst              => dmaRst(5 downto 2),
         dmaIbMasters        => rxMasters(5 downto 2),
         dmaIbSlaves         => rxSlaves(5 downto 2),
         dmaObMasters        => txMasters(5 downto 2),
         dmaObSlaves         => txSlaves(5 downto 2),
         -- Slave AXI-Lite Interface 
         axiLiteClk          => dmaClk(5 downto 2),
         axiLiteRst          => dmaRst(5 downto 2),
         axiLiteReadMasters  => phyReadMasters(5 downto 2),
         axiLiteReadSlaves   => phyReadSlaves(5 downto 2),
         axiLiteWriteMasters => phyWriteMasters(5 downto 2),
         axiLiteWriteSlaves  => phyWriteSlaves(5 downto 2),
         -- Misc. Signals
         extRst              => rst,
         coreClk             => open,
         coreRst             => open,
         phyReady            => phyReady(5 downto 2),
         -- MGT Clock Port
         gtRefClk            => gtRefClk,
         gtRefClkBufg        => clk,
         -- MGT Ports
         gtTxP               => fmcTxP,
         gtTxN               => fmcTxN,
         gtRxP               => fmcRxP,
         gtRxN               => fmcRxN);

   -------------------
   -- Application Core
   -------------------
   GEN_VEC :
   for i in (AXIS_SIZE_C-1) downto 0 generate
   -- for i in 0 downto 0 generate -- quick build for lane0 only

      U_App : entity work.AppCore
         generic map (
            TPD_G           => TPD_G,
            BUILD_INFO_G    => BUILD_INFO_G,
            XIL_DEVICE_G    => "BYPASS",
            APP_TYPE_G      => "ETH",
            AXIS_SIZE_G     => 1,
            APP_ILEAVE_EN_G => true,
            JUMBO_G         => true,
            DHCP_G          => false)
         port map (
            -- Clock and Reset
            clk            => dmaClk(i),
            rst            => dmaRst(i),
            -- ETH Configurations
            ethMac         => ethMac(i),
            ethIp          => ethIp(i),
            phyWriteMaster => phyWriteMasters(i),
            phyWriteSlave  => phyWriteSlaves(i),
            phyReadMaster  => phyReadMasters(i),
            phyReadSlave   => phyReadSlaves(i),
            -- AXIS interface
            txMasters(0)   => txMasters(i),
            txSlaves(0)    => txSlaves(i),
            rxMasters(0)   => rxMasters(i),
            rxSlaves(0)    => rxSlaves(i),
            -- ADC Ports
            vPIn           => '0',
            vNIn           => '0');

      ethMac(i)(47 downto 40) <= toSlv(10+i, 8);
      ethIp(i)(31 downto 24)  <= toSlv(10+i, 8);

   end generate GEN_VEC;

   ----------------
   -- Misc. Signals
   ----------------
   led(7)          <= '1';
   led(6)          <= not(extRst);
   led(5 downto 0) <= phyReady;

   fmcLed          <= not(fmcSfpLossL);
   fmcSfpTxDisable <= (others => '0');
   fmcSfpRateSel   <= (others => '1');
   fmcSfpModDef0   <= (others => '0');

end top_level;
