-------------------------------------------------------------------------------
-- Title      : 
-------------------------------------------------------------------------------
-- File       : AmcCarrierDemoPgp.vhd
-- Author     : Uros Legat <ulegat@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory (Cosylab)
-- Created    : 2015-07-10
-- Last update: 2016-03-10
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Firmware Target's Top Level
--              Note! This target contains a work around.
--
-------------------------------------------------------------------------------
-- This file is part of 'LCLS2 LLRF Development'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 LLRF Development', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.StdRtlPkg.all;
use work.AxiStreamPkg.all;
use work.SsiPkg.all;
use work.AxiLitePkg.all;
use work.axiPkg.all;
use work.jesd204bpkg.all;
use work.Pgp2bPkg.all;

use work.AmcCarrierPkg.all;
use work.TimingPkg.all;

library unisim;
use unisim.vcomponents.all;

entity AmcCarrierDemoPgp is
   generic (
      TPD_G             : time    := 1 ns;
      SIM_SPEEDUP_G     : boolean := false;
      SIMULATION_G      : boolean := false;
      -- PGP Config
      PGP_REFCLK_FREQ_G : real    := 156.25E6;
      PGP_LINE_RATE_G   : real    := 3.125E9;
      -- AXIL Config
      AXIL_CLK_FREQ_G   : real    := 156.25E6;
      -- AXIS Config
      AXIS_CLK_FREQ_G   : real    := 185.0E6;

      --JESD configuration
      -----------------------------------------------------
      -- Test tx module instead of GTX
      TEST_G                : boolean                    := false;
      -- TRUE  Internal SYSREF
      -- FALSE External SYSREF
      SYSREF_GEN_G          : boolean                    := false;
      LINE_RATE_G           : real                       := 7.40E9;
      -- The JESD module supports values: 1,2,4(four byte GT word only)
      F_G                   : positive                   := 2;
      -- K*F/GT_WORD_SIZE_C has to be integer     
      K_G                   : positive                   := 32;
      -- Number of serial lanes: 1 to 16    
      L_RX_G                : positive                   := 6;
      L_TX_G                : positive                   := 2;
      L_AXI_G               : positive                   := 2;  -- DAC Signal generator RAM size 
      GEN_BRAM_ADDR_WIDTH_G : integer range 1 to (2**24) := 12);

   port (



      -----------------------
      -- Application Ports --
      -----------------------
      -- -- AMC's JESD Ports
      jesdRxP : in  Slv6Array(1 downto 1);
      jesdRxN : in  Slv6Array(1 downto 1);
      jesdTxP : out Slv6Array(1 downto 1);
      jesdTxN : out Slv6Array(1 downto 1);

      jesdClkP : in Slv1Array(1 downto 1);
      jesdClkN : in Slv1Array(1 downto 1);

      -- AMC's System Reference Ports
      sysRefP : in Slv1Array(1 downto 1);
      sysRefN : in Slv1Array(1 downto 1);

      -- AMC's Sync Ports
      -- JESD receiver sending sync to ADCs (Used in all subclass modes)
      -- '1' - synchronisation OK
      -- '0' - synchronisation Not OK - synchronisation request
      syncOutP : out Slv3Array(1 downto 1);
      syncOutN : out Slv3Array(1 downto 1);

      -- JESD transmitter receiving sync from DAC (Used in all subclass modes)
      -- '1' - synchronisation OK
      -- '0' - synchronisation Not OK - synchronisation request      
      syncInP : in Slv1Array(1 downto 1);
      syncInN : in Slv1Array(1 downto 1);

      -- ADC and LMK SPI config interface
      spiSclk_o  : out   sl;
      spiSdi_o   : out   sl;
      spiSdo_i   : in    sl;
      spiSdio_io : inout sl;
      spiCsL_o   : out   slv(3 downto 0);

      -- DAC SPI config interface
      spiSclkDac_o  : out   sl;
      spiSdioDac_io : inout sl;
      spiCsLDac_o   : out   sl;

      -- External HW Acquisition trigger
      trigHW : in sl;

      -- Debug Signals connected to RTM -- 
      -------------------------------------------------------------------
      rtmLsP   : out slv(31 downto 24);
      rtmLsN   : out slv(31 downto 24);
      -- RTM's High Speed Ports
      -- PGP MGT signals (SFP)
      rtmHsRxP : in  sl;
      rtmHsRxN : in  sl;
      rtmHsTxP : out sl;
      rtmHsTxN : out sl;
      genClkP  : in  sl;
      genClkN  : in  sl;

      ----------------
      -- Core Ports --
      ----------------   
      -- -- -- Common Fabricate Clock
      -- -- fabClkP       : in    sl;
      -- -- fabClkN       : in    sl;
      -- -- -- XAUI Ports
      -- -- xauiRxP       : in    slv(3 downto 0);
      -- -- xauiRxN       : in    slv(3 downto 0);
      -- -- xauiTxP       : out   slv(3 downto 0);
      -- -- xauiTxN       : out   slv(3 downto 0);
      -- -- xauiClkP      : in    sl;
      -- -- xauiClkN      : in    sl;
      -- -- -- Backplane MPS Ports
      -- -- mpsClkIn      : in    sl;
      -- -- mpsClkOut     : out   sl;
      -- -- mpsBusRxP     : in    slv(14 downto 1);
      -- -- mpsBusRxN     : in    slv(14 downto 1);
      -- -- mpsTxP        : out   sl;
      -- -- mpsTxN        : out   sl;
      -- -- -- LCLS Timing Ports
      -- -- timingRxP     : in    sl;
      -- -- timingRxN     : in    sl;
      -- -- timingTxP     : out   sl;
      -- -- timingTxN     : out   sl;
      -- -- timingClkInP  : in    sl;
      -- -- timingClkInN  : in    sl;
      -- -- timingClkOutP : out   sl;
      -- -- timingClkOutN : out   sl;
      -- -- timingClkSel  : out   sl;
      -- -- timingClkScl  : inout sl;
      -- -- timingClkSda  : inout sl;
      -- -- -- Crossbar Ports
      -- -- xBarSin       : out   slv(1 downto 0);
      -- -- xBarSout      : out   slv(1 downto 0);
      -- -- xBarConfig    : out   sl;
      -- -- xBarLoad      : out   sl;
      -- Secondary AMC Auxiliary Power Enable Port
      enAuxPwrL     : out   sl;
      -- -- -- IPMC Ports
      -- -- ipmcScl       : inout sl;
      -- -- ipmcSda       : inout sl;
      -- -- -- Configuration PROM Ports
      -- -- calScl        : inout sl;
      -- -- calSda        : inout sl;
      -- DDR3L SO-DIMM Ports
      ddrClkP       : in    sl;
      ddrClkN       : in    sl;
      ddrDm         : out   slv(7 downto 0);
      ddrDqsP       : inout slv(7 downto 0);
      ddrDqsN       : inout slv(7 downto 0);
      ddrDq         : inout slv(63 downto 0);
      ddrA          : out   slv(15 downto 0);
      ddrBa         : out   slv(2 downto 0);
      ddrCsL        : out   slv(1 downto 0);
      ddrOdt        : out   slv(1 downto 0);
      ddrCke        : out   slv(1 downto 0);
      ddrCkP        : out   slv(1 downto 0);
      ddrCkN        : out   slv(1 downto 0);
      ddrWeL        : out   sl;
      ddrRasL       : out   sl;
      ddrCasL       : out   sl;
      ddrRstL       : out   sl;
      ddrAlertL     : in    sl;
      ddrPg         : in    sl;
      ddrPwrEnL     : out   sl);
      -- ddrScl        : inout sl;
      -- ddrSda        : inout sl;
      -- -- -- SYSMON Ports
      -- -- vPIn          : in    sl;
      -- -- vNIn          : in    sl);
end AmcCarrierDemoPgp;

architecture top_level of AmcCarrierDemoPgp is

   -- AmcCarrierCore Configuration Constants
   constant TIMING_MODE_C       : boolean             := TIMING_MODE_186MHZ_C;
   constant APP_TYPE_C          : AppType             := APP_LLRF_TYPE_C;
   constant DIAGNOSTIC_SIZE_C   : positive            := 2;  -- 2 AXI stream outputs from two selected ADC channels
   constant DIAGNOSTIC_CONFIG_C : AxiStreamConfigType := ssiAxiStreamConfig(4);  -- 4 Bytes of data width

   constant PGP_REFCLK_PERIOD_C : real := 1.0 / PGP_REFCLK_FREQ_G;
   constant PGP_CLK_FREQ_C      : real := PGP_LINE_RATE_G / 20.0;

   -- AXI-Lite Interface (appClk domain)
   signal regClk         : sl;
   signal regRst         : sl;
   signal regReadMaster  : AxiLiteReadMasterType;
   signal regReadSlave   : AxiLiteReadSlaveType;
   signal regWriteMaster : AxiLiteWriteMasterType;
   signal regWriteSlave  : AxiLiteWriteSlaveType;

   -- Timing Interface (timingClk domain) 
   signal timingClk : sl;
   signal timingRst : sl;
   signal timingBus : TimingBusType;

   -- pgp clk
   signal pgpClk        : sl;
   signal pgpRst        : sl;
   signal pgpRefClkDiv2 : sl;
   signal pgpRefClk     : sl;
   signal pgpRefClkG    : sl;
   signal pgpMmcmRst    : sl;
   signal powerOnReset  : sl;


   -- Diagnostic Interface (diagnosticClk domain)
   signal diagnosticClk        : sl;
   signal diagnosticRst        : sl;
   signal diagnosticBus        : DiagnosticBusType;
   signal diagnosticMasters    : AxiStreamMasterArray(DIAGNOSTIC_SIZE_C-1 downto 0);
   signal diagnosticSlaves     : AxiStreamSlaveArray(DIAGNOSTIC_SIZE_C-1 downto 0);
   signal diagnosticCtrl       : AxiStreamCtrlArray(DIAGNOSTIC_SIZE_C-1 downto 0);
   signal bufDiagnosticMasters : AxiStreamMasterArray(DIAGNOSTIC_SIZE_C-1 downto 0);
   signal bufDiagnosticSlaves  : AxiStreamSlaveArray(DIAGNOSTIC_SIZE_C-1 downto 0);
   signal bufDiagnosticCtrl    : AxiStreamCtrlArray(DIAGNOSTIC_SIZE_C-1 downto 0);

   signal axiClk         : sl;
   signal axiRst         : sl;
   signal axiWriteMaster : AxiWriteMasterType;
   signal axiWriteSlave  : AxiWriteSlaveType;
   signal axiReadMaster  : AxiReadMasterType;
   signal axiReadSlave   : AxiReadSlaveType;

   -- Reference Clocks and Resets
   signal refTimingClk : sl;
   signal refTimingRst : sl;
   signal ref156MHzClk : sl;
   signal ref156MHzRst : sl;

   signal masterResetPgp : sl;
   signal masterResetAxi : sl;
   signal resetDDR       : sl;
begin

   -- Secondary AMC's Auxiliary Power (Default to allows active for the time being)
   -- Note: Install R1063 if you want the FPGA to control AUX power
   enAuxPwrL <= '0';

   -------------------------------------------------------------------------------------------------
   -- Set up clocks
   -------------------------------------------------------------------------------------------------

   -------------------------------------------------------------------------------------------------
   -- Main APP
   -------------------------------------------------------------------------------------------------
   U_App : entity work.AmcRfDemoApp
      generic map (
         TPD_G                 => TPD_G,
         SIM_SPEEDUP_G         => SIM_SPEEDUP_G,
         DIAGNOSTIC_SIZE_G     => DIAGNOSTIC_SIZE_C,
         DIAGNOSTIC_CONFIG_G   => DIAGNOSTIC_CONFIG_C,
         SIMULATION_G          => SIMULATION_G,
         TEST_G                => TEST_G,
         SYSREF_GEN_G          => SYSREF_GEN_G,
         LINE_RATE_G           => LINE_RATE_G,
         F_G                   => F_G,
         K_G                   => K_G,
         L_RX_G                => L_RX_G,
         L_TX_G                => L_TX_G,
         L_AXI_G               => L_AXI_G,
         GEN_BRAM_ADDR_WIDTH_G => GEN_BRAM_ADDR_WIDTH_G)
      port map (
         jesdRxP       => jesdRxP,
         jesdRxN       => jesdRxN,
         jesdTxP       => jesdTxP,
         jesdTxN       => jesdTxN,
         jesdClkP      => jesdClkP,
         jesdClkN      => jesdClkN,
         sysRefP       => sysRefP,
         sysRefN       => sysRefN,
         syncOutP      => syncOutP,
         syncOutN      => syncOutN,
         syncInP       => syncInP,
         syncInN       => syncInN,
         spiSclk_o     => spiSclk_o,
         spiSdi_o      => spiSdi_o,
         spiSdo_i      => spiSdo_i,
         spiSdio_io    => spiSdio_io,
         spiCsL_o      => spiCsL_o,
         spiSclkDac_o  => spiSclkDac_o,
         spiSdioDac_io => spiSdioDac_io,
         spiCsLDac_o   => spiCsLDac_o,
         trigHW        => trigHW,
         rtmLsP        => rtmLsP,
         rtmLsN        => rtmLsN,

         ----------------------
         -- Top Level Interface
         ----------------------
         -- AXI-Lite Interface (regClk domain)
         regClk            => regClk,     -- pgpclk
         regRst            => regRst,
         regReadMaster     => regReadMaster,
         regReadSlave      => regReadSlave,
         regWriteMaster    => regWriteMaster,
         regWriteSlave     => regWriteSlave,
         -- Timing Interface (timingClk domain) 
         timingClk         => timingClk,  --jesd clk
         timingRst         => timingRst,
         timingBus         => timingBus,
         -- Diagnostic Interface (diagnosticClk domain)
         diagnosticClk     => diagnosticClk,
         diagnosticRst     => diagnosticRst,
         diagnosticBus     => diagnosticBus,
         diagnosticMasters => diagnosticMasters,
         diagnosticSlaves  => diagnosticSlaves,
         diagnosticCtrl    => diagnosticCtrl,
         -- Reference Clocks and Resets
         recTimingClk      => '0',
         recTimingRst      => '0',
         ref156MHzClk      => pgpClk,
         ref156MHzRst      => pgpRst);


   -------------------------------------------------------------------------------------------------
   -- Clocking
   -------------------------------------------------------------------------------------------------
   PGPREFCLK_IBUFDS_GTE3 : IBUFDS_GTE3
      port map (
         I     => genClkP,
         IB    => genClkN,
         CEB   => '0',
         ODIV2 => pgpRefClkDiv2,
         O     => pgpRefClk);

   PGPREFCLK_BUFG_GT : BUFG_GT
      port map (
         I       => pgpRefClkDiv2,
         CE      => '1',
         CLR     => '0',
         CEMASK  => '1',
         CLRMASK => '1',
         DIV     => "000",
         O       => pgpRefClkG);

   PwrUpRst_1 : entity work.PwrUpRst
      generic map (
         TPD_G          => TPD_G,
         SIM_SPEEDUP_G  => SIMULATION_G,
         IN_POLARITY_G  => '1',
         OUT_POLARITY_G => '1')
      port map (
         clk    => pgpRefClkG,
         rstOut => powerOnReset);

   pgpMmcmRst <= powerOnReset;

   ClockManager7_PGP : entity work.ClockManager7
      generic map (
         TPD_G              => TPD_G,
         TYPE_G             => "MMCM",
         INPUT_BUFG_G       => false,
         FB_BUFG_G          => true,
         NUM_CLOCKS_G       => 1,
         BANDWIDTH_G        => "OPTIMIZED",
         CLKIN_PERIOD_G     => PGP_REFCLK_PERIOD_C*1.0E9,
         DIVCLK_DIVIDE_G    => 1,
         CLKFBOUT_MULT_F_G  => 6.375,
         CLKOUT0_DIVIDE_F_G => 6.375,
         CLKOUT0_RST_HOLD_G => 16)
      port map (
         clkIn     => pgpRefClkG,
         rstIn     => pgpMmcmRst,
         clkOut(0) => pgpClk,
         rstOut(0) => pgpRst);

   -------------------------------------------------------------------------------------------------
   -- PGP block
   -------------------------------------------------------------------------------------------------
   PgpFrontEnd_1 : entity work.PgpFrontEnd
      generic map (
         TPD_G                  => TPD_G,
         SIMULATION_G           => SIMULATION_G,
         PGP_REFCLK_FREQ_G      => PGP_REFCLK_FREQ_G,
         PGP_LINE_RATE_G        => PGP_LINE_RATE_G,
         AXIL_CLK_FREQ_G        => AXIL_CLK_FREQ_G,
         AXIS_CLK_FREQ_G        => AXIS_CLK_FREQ_G,
         AXIS_FIFO_ADDR_WIDTH_G => 9,
         CASCADE_SIZE_G         => 1,
         AXIS_CONFIG_G          => SSI_PGP2B_CONFIG_C)
      port map (
         stableClk       => pgpRefClkG,
         pgpRefClk       => pgpRefClk,
         pgpClk          => pgpClk,
         pgpClkRst       => pgpRst,
         pgpGtRxN        => rtmHsRxN,
         pgpGtRxP        => rtmHsRxP,
         pgpGtTxN        => rtmHsTxN,
         pgpGtTxP        => rtmHsTxP,
         axilClk         => regClk,
         axilClkRst      => regRst,
         masterReset     => masterResetPgp,
         axilWriteMaster => regWriteMaster,
         axilWriteSlave  => regWriteSlave,
         axilReadMaster  => regReadMaster,
         axilReadSlave   => regReadSlave,
         axisClk         => diagnosticClk,         -- Not used no AXIS fifo
         axisClkRst      => diagnosticRst,         -- Not used no AXIS fifo
         axisTxMasters   => bufDiagnosticMasters,  -- Have to be synced with pgp clk
         axisTxSlaves    => bufDiagnosticSlaves,   -- Have to be synced with pgp clk
         axisTxCtrl      => bufDiagnosticCtrl,
         leds            => open);    

   -- Note! This is a work around. Not to be used in final version nor production! TODO Remove FIX ME ! 
   -- Reset DDR FIFO before requesting next transaction.
   -- Master reset from AxiVersion is used for this purpose.
   RstSync_INST : entity work.RstSync
      generic map (
         TPD_G           => TPD_G,
         RELEASE_DELAY_G => 16)
      port map (
         clk      => axiClk,
         asyncRst => masterResetPgp,
         syncRst  => masterResetAxi);

   resetDDR <= masterResetAxi or axiRst;
   -------------------------------------------------------------------------------------------------
   -- DDR FIFO block
   -------------------------------------------------------------------------------------------------
   AdcDdrFifo_1 : entity work.DebugAmcAdcDdrFifo
      generic map (
         TPD_G => TPD_G)
      port map (
         sAxisClk       => diagnosticClk,
         sAxisRst       => diagnosticRst,
         sAxisMaster    => diagnosticMasters,
         sAxisSlave     => diagnosticSlaves,
         sAxisCtrl      => diagnosticCtrl,
         axiClk         => axiClk,
         axiRst         => resetDDR,    -- axiRst
         axiWriteMaster => axiWriteMaster,
         axiWriteSlave  => axiWriteSlave,
         axiReadMaster  => axiReadMaster,
         axiReadSlave   => axiReadSlave,
         mAxisClk       => pgpClk,
         mAxisRst       => pgpRst,
         mAxisMaster    => bufDiagnosticMasters,
         mAxisSlave     => bufDiagnosticSlaves);


   -------------------------------------------------------------------------------------------------
   -- DDR block
   -------------------------------------------------------------------------------------------------
   U_DdrMem : entity work.DebugRtmPgpAmcCarrierDdrMem
      generic map (
         TPD_G            => TPD_G,
         AXI_ERROR_RESP_G => AXI_RESP_DECERR_C,
         FSBL_G           => false,
         SIM_SPEEDUP_G    => false)
      port map (
         axilClk        => regClk,
         axilRst        => regRst,
--          axilReadMaster  => axilReadMaster,
--          axilReadSlave   => axilReadSlave,
--          axilWriteMaster => axilWriteMaster,
--          axilWriteSlave  => axilWriteSlave,
         memReady       => open,
         memError       => open,
         axiClk         => axiClk,
         axiRst         => axiRst,
         axiWriteMaster => axiWriteMaster,
         axiWriteSlave  => axiWriteSlave,
         axiReadMaster  => axiReadMaster,
         axiReadSlave   => axiReadSlave,
         ddrClkP        => ddrClkP,
         ddrClkN        => ddrClkN,
         ddrDm          => ddrDm,
         ddrDqsP        => ddrDqsP,
         ddrDqsN        => ddrDqsN,
         ddrDq          => ddrDq,
         ddrA           => ddrA,
         ddrBa          => ddrBa,
         ddrCsL         => ddrCsL,
         ddrOdt         => ddrOdt,
         ddrCke         => ddrCke,
         ddrCkP         => ddrCkP,
         ddrCkN         => ddrCkN,
         ddrWeL         => ddrWeL,
         ddrRasL        => ddrRasL,
         ddrCasL        => ddrCasL,
         ddrRstL        => ddrRstL,
         ddrAlertL      => ddrAlertL,
         ddrPg          => ddrPg,
         ddrPwrEnL      => ddrPwrEnL);


end top_level;
