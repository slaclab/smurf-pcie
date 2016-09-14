-------------------------------------------------------------------------------
-- Title      : 
-------------------------------------------------------------------------------
-- File       : AmcCarrierDemoRtmEth.vhd
-- Author     : Larry Ruckman  <ruckman@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2016-04-20
-- Last update: 2016-04-20
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

entity AmcCarrierDemoRtmEth is
   generic (
      TPD_G            : time    := 1 ns; 
      SIM_SPEEDUP_G    : boolean := false;              -- True=Speedup the resets for simulation   
      DSP_CLK_2X_G     : boolean := false;              -- True=370MHz SysGen DSP clock, False=185MHz SysGen DSP clock
      ETH_10G_G        : boolean := false;              -- false = 1 GigE, true = 10 GigE
      AMC_MSB_G        : integer range 0 to 1 := 1;     -- Select bays MSB: Dual core (1:0), Bay1 (1:1), Bay0 (0:0)
      AMC_LSB_G        : integer range 0 to 1 := 0      -- Select bays MSB: Dual core (1:0), Bay1 (1:1), Bay0 (0:0)
   );
   port (
      -----------------------
      -- Application Ports --
      -----------------------
      -- JESD High Speed Ports
      jesdRxP              : in    Slv6Array(AMC_MSB_G downto AMC_LSB_G);
      jesdRxN              : in    Slv6Array(AMC_MSB_G downto AMC_LSB_G);
      jesdTxP              : out   Slv6Array(AMC_MSB_G downto AMC_LSB_G);
      jesdTxN              : out   Slv6Array(AMC_MSB_G downto AMC_LSB_G);
      -- JESD Reference Ports
      jesdClkP             : in    slv(AMC_MSB_G downto AMC_LSB_G);
      jesdClkN             : in    slv(AMC_MSB_G downto AMC_LSB_G);
      jesdSysRefP          : in    slv(AMC_MSB_G downto AMC_LSB_G);
      jesdSysRefN          : in    slv(AMC_MSB_G downto AMC_LSB_G);
      -- JESD ADC ADC Sync Ports
      jesdSyncOutP         : out   Slv3Array(AMC_MSB_G downto AMC_LSB_G);
      jesdSyncOutN         : out   Slv3Array(AMC_MSB_G downto AMC_LSB_G);
      jesdSyncInP          : in    slv(AMC_MSB_G downto AMC_LSB_G);
      jesdSyncInN          : in    slv(AMC_MSB_G downto AMC_LSB_G);
      -- ADC and LMK SPI config interface
      spiSclk_o            : out   slv(AMC_MSB_G downto AMC_LSB_G);
      spiSdi_o             : out   slv(AMC_MSB_G downto AMC_LSB_G);
      spiSdo_i             : in    slv(AMC_MSB_G downto AMC_LSB_G);
      spiSdio_io           : inout slv(AMC_MSB_G downto AMC_LSB_G);
      spiCsL_o             : out   Slv4Array(AMC_MSB_G downto AMC_LSB_G);
      -- DAC SPI config interface
      spiSclkDac_o  : out   slv(AMC_MSB_G downto AMC_LSB_G);
      spiSdioDac_io : inout slv(AMC_MSB_G downto AMC_LSB_G);
      spiCsLDac_o   : out   slv(AMC_MSB_G downto AMC_LSB_G);

      ------------------------------------------------      
      -- RTM ports + Only one debug pulse output per bay from ADC Ch0
      ------------------------------------------------      
      rtmLsP : out slv(33+2*AMC_MSB_G downto 32+2*AMC_LSB_G);
      rtmLsN : out slv(33+2*AMC_MSB_G downto 32+2*AMC_LSB_G);
      
      -- External HW Acquisition trigger
      trigHw : in slv(AMC_MSB_G downto AMC_LSB_G);
      ----------------
      -- Core Ports --
      ----------------   
      -- Common Fabricate Clock
      fabClkP          : in    sl;
      fabClkN          : in    sl;
      -- RTM Ethernet Ports
      ethRxP           : in    sl;
      ethRxN           : in    sl;
      ethTxP           : out   sl;
      ethTxN           : out   sl;
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
end AmcCarrierDemoRtmEth;

architecture top_level of AmcCarrierDemoRtmEth is

   -- AmcCarrierCore Configuration Constants
   constant APP_TYPE_C    : AppType := APP_LLRF_TYPE_C;

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

   -- Waveform interface
   signal waveformClk          : sl;
   signal waveformRst          : sl;
   signal obAppWaveformMasters : WaveformMasterArrayType;
   signal obAppWaveformSlaves  : WaveformSlaveArrayType;
   signal ibAppWaveformMasters : WaveformMasterArrayType;
   signal ibAppWaveformSlaves  : WaveformSlaveArrayType;

   -- Reference Clocks and Resets
   signal recTimingClk : sl;
   signal recTimingRst : sl;
   signal ref156MHzClk : sl;
   signal ref156MHzRst : sl;

begin

   U_App : entity work.AmcRfDemoApp
      generic map (
         TPD_G         => TPD_G,
         SIMULATION_G  => SIM_SPEEDUP_G,
         DSP_CLK_2X_G  => DSP_CLK_2X_G,
         AMC_MSB_G     => AMC_MSB_G,
         AMC_LSB_G     => AMC_LSB_G)
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
         -- Waveform interface (waveformClk clock domain)
         waveformClk          => waveformClk,
         waveformRst          => waveformRst,
         obAppWaveformMasters => obAppWaveformMasters,
         obAppWaveformSlaves  => obAppWaveformSlaves,
         ibAppWaveformMasters => ibAppWaveformMasters,
         ibAppWaveformSlaves  => ibAppWaveformSlaves,
         -- Reference Clocks and Resets
         recTimingClk         => recTimingClk,
         recTimingRst         => recTimingRst,
         ref156MHzClk         => ref156MHzClk,
         ref156MHzRst         => ref156MHzRst,
         -----------------------
         -- Application Ports --
         -----------------------
         jesdRxP              => jesdRxP,
         jesdRxN              => jesdRxN,
         jesdTxP              => jesdTxP,
         jesdTxN              => jesdTxN,
         jesdClkP             => jesdClkP,
         jesdClkN             => jesdClkN,
         jesdSysRefP          => jesdSysRefP,
         jesdSysRefN          => jesdSysRefN,
         jesdSyncOutP         => jesdSyncOutP,
         jesdSyncOutN         => jesdSyncOutN,
         jesdSyncInP          => jesdSyncInP,
         jesdSyncInN          => jesdSyncInN,
         spiSclk_o            => spiSclk_o,
         spiSdi_o             => spiSdi_o,
         spiSdo_i             => spiSdo_i,
         spiSdio_io           => spiSdio_io,
         spiCsL_o             => spiCsL_o,
         spiSclkDac_o         => spiSclkDac_o,
         spiSdioDac_io        => spiSdioDac_io,
         spiCsLDac_o          => spiCsLDac_o,
         rtmLsP               => rtmLsP,
         rtmLsN               => rtmLsN,
         trigHw               => trigHw);    

   U_Core : entity work.DebugRtmEthAmcCarrierCore
      generic map (
         TPD_G            => TPD_G,
         SIM_SPEEDUP_G    => SIM_SPEEDUP_G,
         ETH_10G_G        => ETH_10G_G)
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
         -- Waveform interface (waveformClk clock domain)
         waveformClk          => waveformClk,
         waveformRst          => waveformRst,
         obAppWaveformMasters => obAppWaveformMasters,
         obAppWaveformSlaves  => obAppWaveformSlaves,
         ibAppWaveformMasters => ibAppWaveformMasters,
         ibAppWaveformSlaves  => ibAppWaveformSlaves,
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
         -- RTM ETH Ports
         ethRxP               => ethRxP,
         ethRxN               => ethRxN,
         ethTxP               => ethTxP,
         ethTxN               => ethTxN,
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
