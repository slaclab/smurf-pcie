-------------------------------------------------------------------------------
-- Title      : 
-------------------------------------------------------------------------------
-- File       : AmcCarrierDemoEth.vhd
-- Author     : Uros Legat  <ulegat@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2016-05-25
-- Last update: 2016-05-25
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Firmware Target's Top Level
-- 
-- Note: Common-to-Application interface defined in HPS ESD: LCLSII-2.7-ES-0536
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
use work.TimingPkg.all;
use work.AmcCarrierPkg.all;

entity AmcCarrierDemoEth is
   generic (
      TPD_G         : time    := 1 ns;
      SIMULATION_G  : boolean := false;
      SIM_SPEEDUP_G : boolean := false);
   port (
      -----------------------
      -- Application Ports --
      -----------------------
      -- JESD High Speed Ports
      jesdRxP          : in    Slv6Array(1 downto 0);
      jesdRxN          : in    Slv6Array(1 downto 0);
      jesdTxP          : out   Slv6Array(1 downto 0);
      jesdTxN          : out   Slv6Array(1 downto 0);
      -- JESD Reference Ports
      jesdClkP         : in    slv(1 downto 0);
      jesdClkN         : in    slv(1 downto 0);
      jesdSysRefP      : in    slv(1 downto 0);
      jesdSysRefN      : in    slv(1 downto 0);
      -- JESD ADC Sync Ports
      jesdSyncP        : out   Slv3Array(1 downto 0);
      jesdSyncN        : out   Slv3Array(1 downto 0);
      -- ADC and LMK SPI config interface
      spiSclk_o        : out   slv(1 downto 0);
      spiSdi_o         : out   slv(1 downto 0);
      spiSdo_i         : in    slv(1 downto 0);
      spiSdio_io       : inout slv(1 downto 0);
      spiCsL_o         : out   Slv5Array(1 downto 0);
      -- Attenuator serial ports
      attSclk_o        : out   slv(1 downto 0);
      attSdi_o         : out   slv(1 downto 0);
      attLatchEn_o     : out   slv6Array(1 downto 0);
      ------------------------------------------------
      -- Bay 0 Only ports
      ------------------------------------------------
      -- SPI DAC ports
      dacSclk_o        : out   sl;
      dacSdi_o         : out   sl;
      dacCsL_o         : out   slv(2 downto 0);
      ------------------------------------------------
      -- Bay 1 Only ports
      ------------------------------------------------    
      -- LVDS DAC data ports
      dacDataP         : out   slv(15 downto 0);
      dacDataN         : out   slv(15 downto 0);
      -- LVDS DAC Sample clock (DAC samples data on both edges)
      dacDckP          : out   sl;
      dacDckN          : out   sl;
      timingTrig       : out   sl;
      fpgaInterlock    : out   sl;
      ----------------
      -- Core Ports --
      ----------------   
      -- Common Fabricate Clock
      fabClkP          : in    sl;
      fabClkN          : in    sl;
      -- XAUI Ports
      xauiRxP          : in    slv(3 downto 0);
      xauiRxN          : in    slv(3 downto 0);
      xauiTxP          : out   slv(3 downto 0);
      xauiTxN          : out   slv(3 downto 0);
      xauiClkP         : in    sl;
      xauiClkN         : in    sl;
      -- Backplane MPS Ports
      mpsClkIn         : in    sl;
      mpsClkOut        : out   sl;
      mpsBusRxP        : in    slv(14 downto 1);
      mpsBusRxN        : in    slv(14 downto 1);
      mpsTxP           : out   sl;
      mpsTxN           : out   sl;
      -- LCLS Timing Ports
      timingRxP        : in    sl;
      timingRxN        : in    sl;
      timingTxP        : out   sl;
      timingTxN        : out   sl;
      timingRefClkInP  : in    sl;
      timingRefClkInN  : in    sl;
      timingRecClkOutP : out   sl;
      timingRecClkOutN : out   sl;
      timingClkSel     : out   sl;
      timingClkScl     : inout sl;
      timingClkSda     : inout sl;
      -- Crossbar Ports
      xBarSin          : out   slv(1 downto 0);
      xBarSout         : out   slv(1 downto 0);
      xBarConfig       : out   sl;
      xBarLoad         : out   sl;
      -- Secondary AMC Auxiliary Power Enable Port
      enAuxPwrL        : out   sl;
      -- IPMC Ports
      ipmcScl          : inout sl;
      ipmcSda          : inout sl;
      -- Configuration PROM Ports
      calScl           : inout sl;
      calSda           : inout sl;
      -- DDR3L SO-DIMM Ports
      ddrClkP          : in    sl;
      ddrClkN          : in    sl;
      ddrDm            : out   slv(7 downto 0);
      ddrDqsP          : inout slv(7 downto 0);
      ddrDqsN          : inout slv(7 downto 0);
      ddrDq            : inout slv(63 downto 0);
      ddrA             : out   slv(15 downto 0);
      ddrBa            : out   slv(2 downto 0);
      ddrCsL           : out   slv(1 downto 0);
      ddrOdt           : out   slv(1 downto 0);
      ddrCke           : out   slv(1 downto 0);
      ddrCkP           : out   slv(1 downto 0);
      ddrCkN           : out   slv(1 downto 0);
      ddrWeL           : out   sl;
      ddrRasL          : out   sl;
      ddrCasL          : out   sl;
      ddrRstL          : out   sl;
      ddrAlertL        : in    sl;
      ddrPg            : in    sl;
      ddrPwrEnL        : out   sl;
      ddrScl           : inout sl;
      ddrSda           : inout sl;
      -- SYSMON Ports
      vPIn             : in    sl;
      vNIn             : in    sl);
end AmcCarrierDemoEth;

architecture top_level of AmcCarrierDemoEth is

   -- AmcCarrierCore Configuration Constants
   constant TIMING_MODE_C            : boolean                                                   := TIMING_MODE_119MHZ_C;
   constant APP_TYPE_C               : AppType                                                   := APP_LLRF_TYPE_C;
   constant DIAGNOSTIC_RAW_STREAMS_C : positive                                                  := 4;
   constant DIAGNOSTIC_RAW_CONFIGS_C : AxiStreamConfigArray(DIAGNOSTIC_RAW_STREAMS_C-1 downto 0) := (others => ssiAxiStreamConfig(4));

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

   -- Diagnostic Interface (diagnosticClk domain)
   signal diagnosticClk : sl;
   signal diagnosticRst : sl;
   signal diagnosticBus : DiagnosticBusType;

   -- Raw Diagnostic Interface (diagnosticRawClks domains)
   signal diagnosticRawClks    : slv(DIAGNOSTIC_RAW_STREAMS_C-1 downto 0);
   signal diagnosticRawRsts    : slv(DIAGNOSTIC_RAW_STREAMS_C-1 downto 0);
   signal diagnosticRawMasters : AxiStreamMasterArray(DIAGNOSTIC_RAW_STREAMS_C-1 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal diagnosticRawSlaves  : AxiStreamSlaveArray(DIAGNOSTIC_RAW_STREAMS_C-1 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);
   signal diagnosticRawCtrl    : AxiStreamCtrlArray(DIAGNOSTIC_RAW_STREAMS_C-1 downto 0)   := (others => AXI_STREAM_CTRL_UNUSED_C);

   -- Reference Clocks and Resets
   signal recTimingClk : sl;
   signal recTimingRst : sl;
   signal ref156MHzClk : sl;
   signal ref156MHzRst : sl;

begin

   U_App : entity work.AmcCarrierMrLlrfApp
      generic map (
         TPD_G         => TPD_G,
         SIMULATION_G  => SIMULATION_G,
         TIMING_MODE_G => TIMING_MODE_C)
      port map (
         ----------------------
         -- Top Level Interface
         ----------------------
         -- AXI-Lite Interface (regClk domain)
         regClk               => regClk,
         regRst               => regRst,
         regReadMaster        => regReadMaster,
         regReadSlave         => regReadSlave,
         regWriteMaster       => regWriteMaster,
         regWriteSlave        => regWriteSlave,
         -- Timing Interface (timingClk domain) 
         timingClk            => timingClk,
         timingRst            => timingRst,
         timingBus            => timingBus,
         -- Diagnostic Interface (diagnosticClk domain)
         diagnosticClk        => diagnosticClk,
         diagnosticRst        => diagnosticRst,
         diagnosticBus        => diagnosticBus,
         -- Raw Diagnostic Interface (diagnosticRawClks domains)
         diagnosticRawClks    => diagnosticRawClks,
         diagnosticRawRsts    => diagnosticRawRsts,
         diagnosticRawMasters => diagnosticRawMasters,
         diagnosticRawSlaves  => diagnosticRawSlaves,
         diagnosticRawCtrl    => diagnosticRawCtrl,
         -- Reference Clocks and Resets
         recTimingClk         => recTimingClk,
         recTimingRst         => recTimingRst,
         ref156MHzClk         => ref156MHzClk,
         ref156MHzRst         => ref156MHzRst,
         -----------------------
         -- Application Ports --
         -----------------------
         -- JESD High Speed Ports
         jesdRxP              => jesdRxP,
         jesdRxN              => jesdRxN,
         jesdTxP              => jesdTxP,
         jesdTxN              => jesdTxN,
         -- JESD Reference Ports
         jesdClkP             => jesdClkP,
         jesdClkN             => jesdClkN,
         jesdSysRefP          => jesdSysRefP,
         jesdSysRefN          => jesdSysRefN,
         -- JESD ADC Sync Ports
         jesdSyncP            => jesdSyncP,
         jesdSyncN            => jesdSyncN,
         -- LMK and ADC SPI Ports
         spiSclk_o            => spiSclk_o,
         spiSdi_o             => spiSdi_o,
         spiSdo_i             => spiSdo_i,
         spiSdio_io           => spiSdio_io,
         spiCsL_o             => spiCsL_o,
         -- Attenuator
         attSclk_o            => attSclk_o,
         attSdi_o             => attSdi_o,
         attLatchEn_o         => attLatchEn_o,
         -- Bay 0
         -- SPI DAC
         dacSclk_o            => dacSclk_o,
         dacSdi_o             => dacSdi_o,
         dacCsL_o             => dacCsL_o,
         -- Bay 1
         -- LVDS DAC data ports
         dacDataP             => dacDataP,
         dacDataN             => dacDataN,
         -- LVDS DAC Sample clock (DAC samples data on both edges)
         dacDckP              => dacDckP,
         dacDckN              => dacDckN,
         timingTrig           => timingTrig,
         fpgaInterlock        => fpgaInterlock);   

   U_Core : entity work.AmcCarrierCore
      generic map (
         TPD_G                    => TPD_G,
         SIM_SPEEDUP_G            => SIM_SPEEDUP_G,
         TIMING_MODE_G            => TIMING_MODE_C,
         DIAGNOSTIC_RAW_STREAMS_G => DIAGNOSTIC_RAW_STREAMS_C,
         DIAGNOSTIC_RAW_CONFIGS_G => DIAGNOSTIC_RAW_CONFIGS_C)
      port map (
         ----------------------
         -- Top Level Interface
         ----------------------
         -- AXI-Lite Interface (regClk domain)
         regClk               => regClk,
         regRst               => regRst,
         regReadMaster        => regReadMaster,
         regReadSlave         => regReadSlave,
         regWriteMaster       => regWriteMaster,
         regWriteSlave        => regWriteSlave,
         -- Timing Interface (timingClk domain) 
         timingClk            => timingClk,
         timingRst            => timingRst,
         timingBus            => timingBus,
         -- Diagnostic Interface (diagnosticClk domain)
         diagnosticClk        => diagnosticClk,
         diagnosticRst        => diagnosticRst,
         diagnosticBus        => diagnosticBus,
         -- Raw Diagnostic Interface (diagnosticRawClks domains)
         diagnosticRawClks    => diagnosticRawClks,
         diagnosticRawRsts    => diagnosticRawRsts,
         diagnosticRawMasters => diagnosticRawMasters,
         diagnosticRawSlaves  => diagnosticRawSlaves,
         diagnosticRawCtrl    => diagnosticRawCtrl,
         -- Reference Clocks and Resets
         recTimingClk         => recTimingClk,
         recTimingRst         => recTimingRst,
         ref156MHzClk         => ref156MHzClk,
         ref156MHzRst         => ref156MHzRst,
         ----------------
         -- Core Ports --
         ----------------   
         -- Common Fabricate Clock
         fabClkP              => fabClkP,
         fabClkN              => fabClkN,
         -- XAUI Ports
         xauiRxP              => xauiRxP,
         xauiRxN              => xauiRxN,
         xauiTxP              => xauiTxP,
         xauiTxN              => xauiTxN,
         xauiClkP             => xauiClkP,
         xauiClkN             => xauiClkN,
         -- Backplane MPS Ports
         mpsClkIn             => mpsClkIn,
         mpsClkOut            => mpsClkOut,
         mpsBusRxP            => mpsBusRxP,
         mpsBusRxN            => mpsBusRxN,
         mpsTxP               => mpsTxP,
         mpsTxN               => mpsTxN,
         -- LCLS Timing Ports
         timingRxP            => timingRxP,
         timingRxN            => timingRxN,
         timingTxP            => timingTxP,
         timingTxN            => timingTxN,
         timingRefClkInP      => timingRefClkInP,
         timingRefClkInN      => timingRefClkInN,
         timingRecClkOutP     => timingRecClkOutP,
         timingRecClkOutN     => timingRecClkOutN,
         timingClkSel         => timingClkSel,
         timingClkScl         => timingClkScl,
         timingClkSda         => timingClkSda,
         -- Crossbar Ports
         xBarSin              => xBarSin,
         xBarSout             => xBarSout,
         xBarConfig           => xBarConfig,
         xBarLoad             => xBarLoad,
         -- Secondary AMC Auxiliary Power Enable Port
         enAuxPwrL            => enAuxPwrL,
         -- IPMC Ports
         ipmcScl              => ipmcScl,
         ipmcSda              => ipmcSda,
         -- Configuration PROM Ports
         calScl               => calScl,
         calSda               => calSda,
         -- DDR3L SO-DIMM Ports
         ddrClkP              => ddrClkP,
         ddrClkN              => ddrClkN,
         ddrDqsP              => ddrDqsP,
         ddrDqsN              => ddrDqsN,
         ddrDm                => ddrDm,
         ddrDq                => ddrDq,
         ddrA                 => ddrA,
         ddrBa                => ddrBa,
         ddrCsL               => ddrCsL,
         ddrOdt               => ddrOdt,
         ddrCke               => ddrCke,
         ddrCkP               => ddrCkP,
         ddrCkN               => ddrCkN,
         ddrWeL               => ddrWeL,
         ddrRasL              => ddrRasL,
         ddrCasL              => ddrCasL,
         ddrRstL              => ddrRstL,
         ddrPwrEnL            => ddrPwrEnL,
         ddrPg                => ddrPg,
         ddrAlertL            => ddrAlertL,
         ddrScl               => ddrScl,
         ddrSda               => ddrSda,
         -- SYSMON Ports
         vPIn                 => vPIn,
         vNIn                 => vNIn);

end top_level;
