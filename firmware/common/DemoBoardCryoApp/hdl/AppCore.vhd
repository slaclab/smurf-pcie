-------------------------------------------------------------------------------
-- Title      :
-------------------------------------------------------------------------------
-- File       : AppCore.vhd
-- Author     : Larry Ruckman  <ruckman@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2016-11-11
-- Last update: 2016-11-15
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Application Core's Top Level
--
-- Note: Common-to-Application interface defined in HPS ESD: LCLSII-2.7-ES-0536
--
-------------------------------------------------------------------------------
-- This file is part of 'LCLS2 AMC Carrier Firmware'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 AMC Carrier Firmware', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.StdRtlPkg.all;
use work.AxiStreamPkg.all;
use work.AxiLitePkg.all;
use work.TimingPkg.all;
use work.AmcCarrierPkg.all;
use work.jesd204bpkg.all;
use work.AppTopPkg.all;

entity AppCore is
   generic (
      TPD_G            : time             := 1 ns;
      SIM_SPEEDUP_G    : boolean          := false;
      SIMULATION_G     : boolean          := false;
      AXI_CLK_FREQ_G   : real             := 156.25E+6;
      AXI_BASE_ADDR_G  : slv(31 downto 0) := x"80000000";
      AXI_ERROR_RESP_G : slv(1 downto 0)  := AXI_RESP_SLVERR_C);      
   port (
      -- Clocks and resets   
      jesdClk          : in    slv(1 downto 0);
      jesdRst          : in    slv(1 downto 0);
      jesdClk2x        : in    slv(1 downto 0);
      jesdRst2x        : in    slv(1 downto 0);
      -- DaqMux/Trig Interface (recTimingClk domain) 
      freezeHw         : out   slv(1 downto 0);
      evrTrig          : in    AppTopTrigType;
      userTrig         : out   slv(1 downto 0);
      -- JESD SYNC Interface (jesdClk[1:0] domain)
      jesdSysRef       : out   slv(1 downto 0);
      jesdRxSync       : in    slv(1 downto 0);
      jesdTxSync       : out   slv(1 downto 0);
      -- ADC/DAC/Debug Interface (jesdClk[1:0] domain)
      adcValids        : in    Slv7Array(1 downto 0);
      adcValues        : in    sampleDataVectorArray(1 downto 0, 6 downto 0);
      dacValids        : out   Slv7Array(1 downto 0);
      dacValues        : out   sampleDataVectorArray(1 downto 0, 6 downto 0);
      debugValids      : out   Slv4Array(1 downto 0);
      debugValues      : out   sampleDataVectorArray(1 downto 0, 3 downto 0);
      -- DAC Signal Generator Interface (jesdClk[1:0] domain)
      dacSigCtrl       : out   DacSigCtrlArray(1 downto 0);
      dacSigStatus     : in    DacSigStatusArray(1 downto 0);
      dacSigValids     : in    Slv7Array(1 downto 0);
      dacSigValues     : in    sampleDataVectorArray(1 downto 0, 6 downto 0);
      -- AXI-Lite Interface (axilClk domain) [0x8FFFFFFF:0x80000000]
      axilClk          : in    sl;
      axilRst          : in    sl;
      axilReadMaster   : in    AxiLiteReadMasterType;
      axilReadSlave    : out   AxiLiteReadSlaveType;
      axilWriteMaster  : in    AxiLiteWriteMasterType;
      axilWriteSlave   : out   AxiLiteWriteSlaveType;
      ----------------------
      -- Top Level Interface
      ----------------------
      -- Timing Interface (recTimingClk domain) 
      timingBus        : in    TimingBusType;
      timingPhy        : out   TimingPhyType;
      timingPhyClk     : in    sl;
      timingPhyRst     : in    sl;
      -- Diagnostic Interface (diagnosticClk domain)
      diagnosticClk    : out   sl;
      diagnosticRst    : out   sl;
      diagnosticBus    : out   DiagnosticBusType;
      -- Backplane Messaging Interface (bpMsgClk domain)
      bpMsgClk         : out   sl;
      bpMsgRst         : out   sl;
      bpMsgBus         : in    BpMsgBusArray(BP_MSG_SIZE_C-1 downto 0);
      -- Application Debug Interface (ref156MHzClk domain)
      obAppDebugMaster : out   AxiStreamMasterType;
      obAppDebugSlave  : in    AxiStreamSlaveType;
      ibAppDebugMaster : in    AxiStreamMasterType;
      ibAppDebugSlave  : out   AxiStreamSlaveType;
      -- BSI Interface (bsiClk domain) 
      bsiClk           : out   sl;
      bsiRst           : out   sl;
      bsiBus           : in    BsiBusType;
      -- MPS Concentrator Interface (ref156MHzClk domain)
      mpsObMasters     : in    AxiStreamMasterArray(14 downto 0);
      mpsObSlaves      : out   AxiStreamSlaveArray(14 downto 0);
      -- Reference Clocks and Resets
      recTimingClk     : in    sl;
      recTimingRst     : in    sl;
      ref125MHzClk     : in    sl;
      ref125MHzRst     : in    sl;
      ref156MHzClk     : in    sl;
      ref156MHzRst     : in    sl;
      ref312MHzClk     : in    sl;
      ref312MHzRst     : in    sl;
      ref625MHzClk     : in    sl;
      ref625MHzRst     : in    sl;
      gthFabClk        : in    sl;
      ethPhyReady      : in    sl;
      -----------------------
      -- Application Ports --
      -----------------------
      -- AMC's JTAG Ports
      jtagPri          : inout Slv5Array(1 downto 0);
      jtagSec          : inout Slv5Array(1 downto 0);
      -- AMC's FPGA Clock Ports
      fpgaClkP         : inout Slv2Array(1 downto 0);
      fpgaClkN         : inout Slv2Array(1 downto 0);
      -- AMC's System Reference Ports
      sysRefP          : inout Slv4Array(1 downto 0);
      sysRefN          : inout Slv4Array(1 downto 0);
      -- AMC's Sync Ports
      syncInP          : inout Slv4Array(1 downto 0);
      syncInN          : inout Slv4Array(1 downto 0);
      syncOutP         : inout Slv10Array(1 downto 0);
      syncOutN         : inout Slv10Array(1 downto 0);
      -- AMC's Spare Ports
      spareP           : inout Slv16Array(1 downto 0);
      spareN           : inout Slv16Array(1 downto 0);
      -- RTM's Low Speed Ports
      rtmLsP           : inout slv(53 downto 0);
      rtmLsN           : inout slv(53 downto 0);
      -- RTM's High Speed Ports
      rtmHsRxP         : in    sl;
      rtmHsRxN         : in    sl;
      rtmHsTxP         : out   sl;
      rtmHsTxN         : out   sl;
      genClkP          : in    sl;
      genClkN          : in    sl);
end AppCore;

architecture mapping of AppCore is

   -- Internal signals
   signal s_extTrig : slv(1 downto 0);     
   signal s_evrTrig : slv(1 downto 0);

begin
   
   U_DUAL_AMC: entity work.AmcStriplineBpmDualCore
      generic map (
         TPD_G                    => TPD_G,
         SIM_SPEEDUP_G            => SIM_SPEEDUP_G,
         SIMULATION_G             => SIMULATION_G,
         RING_BUFFER_ADDR_WIDTH_G => 9,
         AXI_CLK_FREQ_G           => AXI_CLK_FREQ_G,
         AXI_ERROR_RESP_G         => AXI_ERROR_RESP_G,
         AXI_BASE_ADDR_G          => AXI_BASE_ADDR_G)
      port map (
         jesdClk         => jesdClk,
         jesdRst         => jesdRst,
         jesdSysRef      => jesdSysRef,
         jesdRxSync      => jesdRxSync,
         adcValids(0)    => adcValids(0)(3 downto 0),
         adcValids(1)    => adcValids(1)(3 downto 0),
         adcValues(0, 0) => adcValues(0, 0),
         adcValues(0, 1) => adcValues(0, 1),
         adcValues(0, 2) => adcValues(0, 2),
         adcValues(0, 3) => adcValues(0, 3),
         adcValues(1, 0) => adcValues(1, 0),
         adcValues(1, 1) => adcValues(1, 1),
         adcValues(1, 2) => adcValues(1, 2),
         adcValues(1, 3) => adcValues(1, 3),         
         dacVcoCtrl      => (others => x"8000"),
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMaster,
         axilReadSlave   => axilReadSlave,
         axilWriteMaster => axilWriteMaster,
         axilWriteSlave  => axilWriteSlave,
         extTrig         => s_extTrig,
         evrTrig         => s_evrTrig,
         jtagPri         => jtagPri,
         jtagSec         => jtagSec,
         fpgaClkP        => fpgaClkP,
         fpgaClkN        => fpgaClkN,
         sysRefP         => sysRefP,
         sysRefN         => sysRefN,
         syncInP         => syncInP,
         syncInN         => syncInN,
         syncOutP        => syncOutP,
         syncOutN        => syncOutN,
         spareP          => spareP,
         spareN          => spareN);

   -- DaqMux/Trig Interface (recTimingClk domain)
   -- trigPulse 0 and 1 Daq Bay0,1
   -- trigPulse 2 and 3 Cal Bay0,1
   GEN_TRIG :
   for i in 1 downto 0 generate
      -- Daq triggers
      userTrig(i)  <= s_extTrig(i) or evrTrig.trigPulse(i);   
      freezeHw(i)  <= s_extTrig(i) or evrTrig.trigPulse(i);
      -- Cal triggers
      s_evrTrig(i)<= s_extTrig(i) or evrTrig.trigPulse(2+i); 
   end generate GEN_TRIG;

   -- Unconnected outs
   jesdTxSync  <= (others => '0');   
   dacValids   <= (others => (others => '0'));
   dacValues   <= (others => (others => x"0000_0000"));
   debugValids <= (others => (others => '0'));
   debugValues <= (others => (others => x"0000_0000"));
   dacSigCtrl  <= (others => DAC_SIG_CTRL_INIT_C);
   timingPhy   <= TIMING_PHY_INIT_C;

   diagnosticClk <= recTimingClk;
   diagnosticRst <= recTimingRst;
   diagnosticBus <= DIAGNOSTIC_BUS_INIT_C;
   
   bpMsgClk         <= '0';
   bpMsgRst         <= '0';
   obAppDebugMaster <= AXI_STREAM_MASTER_INIT_C;
   ibAppDebugSlave  <= AXI_STREAM_SLAVE_FORCE_C;
   bsiClk           <= '0';
   bsiRst           <= '0';
   mpsObSlaves      <= (others => AXI_STREAM_SLAVE_FORCE_C);
   
end mapping;
