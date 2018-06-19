-------------------------------------------------------------------------------
-- Title      : Demo Board Cryo Application Core
-------------------------------------------------------------------------------
-- File       : AppCore.vhd
-- Author     : Larry Ruckman  <ruckman@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2016-11-11
-- Last update: 2018-04-25
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
use work.AppTopPkg.all;

entity AppCore is
   generic (
      TPD_G            : time             := 1 ns;
      SIM_SPEEDUP_G    : boolean          := false;
      SIMULATION_G     : boolean          := false;
      AXI_BASE_ADDR_G  : slv(31 downto 0) := x"80000000";
      AXI_ERROR_RESP_G : slv(1 downto 0)  := AXI_RESP_SLVERR_C;
      JESD_USR_DIV_G   : natural          := 4);
   port (
      -- Clocks and resets   
      jesdClk             : in    slv(1 downto 0);
      jesdRst             : in    slv(1 downto 0);
      jesdClk2x           : in    slv(1 downto 0);
      jesdRst2x           : in    slv(1 downto 0);
      jesdUsrClk          : in    slv(1 downto 0);
      jesdUsrRst          : in    slv(1 downto 0);
      -- DaqMux/Trig Interface (timingClk domain) 
      freezeHw            : out   slv(1 downto 0);
      timingTrig          : in    TimingTrigType;
      trigHw              : out   slv(1 downto 0);
      trigCascBay         : in    slv(1 downto 0);
      -- JESD SYNC Interface (jesdClk[1:0] domain)
      jesdSysRef          : out   slv(1 downto 0);
      jesdRxSync          : in    slv(1 downto 0);
      jesdTxSync          : out   slv(1 downto 0);
      -- ADC/DAC/Debug Interface (jesdClk[1:0] domain)
      adcValids           : in    Slv10Array(1 downto 0);
      adcValues           : in    sampleDataVectorArray(1 downto 0, 9 downto 0);
      dacValids           : out   Slv10Array(1 downto 0);
      dacValues           : out   sampleDataVectorArray(1 downto 0, 9 downto 0);
      debugValids         : out   Slv4Array(1 downto 0);
      debugValues         : out   sampleDataVectorArray(1 downto 0, 3 downto 0);
      -- DAC Signal Generator Interface
      -- If SIG_GEN_LANE_MODE_G = '0', (jesdClk[1:0] domain)
      -- If SIG_GEN_LANE_MODE_G = '1', (jesdClk2x[1:0] domain)
      dacSigCtrl          : out   DacSigCtrlArray(1 downto 0);
      dacSigStatus        : in    DacSigStatusArray(1 downto 0);
      dacSigValids        : in    Slv10Array(1 downto 0);
      dacSigValues        : in    sampleDataVectorArray(1 downto 0, 9 downto 0);
      -- AXI-Lite Interface (axilClk domain) [0x8FFFFFFF:0x80000000]
      axilClk             : in    sl;
      axilRst             : in    sl;
      axilReadMaster      : in    AxiLiteReadMasterType;
      axilReadSlave       : out   AxiLiteReadSlaveType;
      axilWriteMaster     : in    AxiLiteWriteMasterType;
      axilWriteSlave      : out   AxiLiteWriteSlaveType;
      ----------------------
      -- Top Level Interface
      ----------------------
      -- Timing Interface (timingClk domain) 
      timingClk           : in    sl;
      timingRst           : in    sl;
      timingBus           : in    TimingBusType;
      timingPhy           : out   TimingPhyType;
      timingPhyClk        : in    sl;
      timingPhyRst        : in    sl;
      -- Diagnostic Interface (diagnosticClk domain)
      diagnosticClk       : out   sl;
      diagnosticRst       : out   sl;
      diagnosticBus       : out   DiagnosticBusType;
      -- Backplane Messaging Interface  (axilClk domain)
      obBpMsgClientMaster : out   AxiStreamMasterType;
      obBpMsgClientSlave  : in    AxiStreamSlaveType;
      ibBpMsgClientMaster : in    AxiStreamMasterType;
      ibBpMsgClientSlave  : out   AxiStreamSlaveType;
      obBpMsgServerMaster : out   AxiStreamMasterType;
      obBpMsgServerSlave  : in    AxiStreamSlaveType;
      ibBpMsgServerMaster : in    AxiStreamMasterType;
      ibBpMsgServerSlave  : out   AxiStreamSlaveType;
      -- Application Debug Interface (axilClk domain)
      obAppDebugMaster    : out   AxiStreamMasterType;
      obAppDebugSlave     : in    AxiStreamSlaveType;
      ibAppDebugMaster    : in    AxiStreamMasterType;
      ibAppDebugSlave     : out   AxiStreamSlaveType;
      -- MPS Concentrator Interface (ref156MHzClk domain)
      mpsObMasters        : in    AxiStreamMasterArray(14 downto 0);
      mpsObSlaves         : out   AxiStreamSlaveArray(14 downto 0);
      -- Misc. Interface
      ipmiBsi             : in    BsiBusType;
      gthFabClk           : in    sl;
      ethPhyReady         : in    sl;
      -----------------------
      -- Application Ports --
      -----------------------      
      -- AMC's JTAG Ports
      jtagPri             : inout Slv5Array(1 downto 0);
      jtagSec             : inout Slv5Array(1 downto 0);
      -- AMC's FPGA Clock Ports
      fpgaClkP            : inout Slv2Array(1 downto 0);
      fpgaClkN            : inout Slv2Array(1 downto 0);
      -- AMC's System Reference Ports
      sysRefP             : inout Slv4Array(1 downto 0);
      sysRefN             : inout Slv4Array(1 downto 0);
      -- AMC's Sync Ports
      syncInP             : inout Slv4Array(1 downto 0);
      syncInN             : inout Slv4Array(1 downto 0);
      syncOutP            : inout Slv10Array(1 downto 0);
      syncOutN            : inout Slv10Array(1 downto 0);
      -- AMC's Spare Ports
      spareP              : inout Slv16Array(1 downto 0);
      spareN              : inout Slv16Array(1 downto 0);
      -- AMC's IO Ports kcu60 only 
      amcIoP              : inout Slv4Array(1 downto 0);
      amcIoN              : inout Slv4Array(1 downto 0);
      -- RTM's Low Speed Ports
      rtmLsP              : inout slv(53 downto 0);
      rtmLsN              : inout slv(53 downto 0);
      -- RTM's High Speed Ports
      rtmHsRxP            : in    sl;
      rtmHsRxN            : in    sl;
      rtmHsTxP            : out   sl := '0';
      rtmHsTxN            : out   sl := '1';
      -- RTM's Clock Reference 
      genClkP             : in    sl;
      genClkN             : in    sl);
end AppCore;

architecture mapping of AppCore is

   constant NUM_AXI_MASTERS_C : natural := 4;

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, AXI_BASE_ADDR_G, 28, 24);  -- [0x8FFFFFFF:0x80000000]

   constant AMC_INDEX_C : natural := 0;
   constant DSP_INDEX_C : natural := 1;
   constant RTM_INDEX_C : natural := 2;
   constant REG_INDEX_C : natural := 3;

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

   signal dacSigTrigArm   : sl;
   signal dacSigTrigDelay : slv(23 downto 0);

   signal startRamp  : sl;
   signal selectRamp : sl;
   signal rampCnt    : slv(31 downto 0);

   signal s_dacValues : sampleDataVectorArray(1 downto 0, 9 downto 0);

begin

   DAC_HACK :                           -- tie all DAC to DAC0 output
   for i in 3 downto 0 generate
      dacValues(0, (2*i))   <= s_dacValues(0, 0);
      dacValues(0, (2*i)+1) <= s_dacValues(0, 1);

      dacValues(1, (2*i))   <= s_dacValues(0, 0);
      dacValues(1, (2*i)+1) <= s_dacValues(0, 1);
   end generate DAC_HACK;
   ---------------------
   -- Unused Connections
   ---------------------
   diagnosticClk <= axilClk;
   diagnosticRst <= axilRst;
   diagnosticBus <= DIAGNOSTIC_BUS_INIT_C;

   obBpMsgClientMaster <= AXI_STREAM_MASTER_INIT_C;
   ibBpMsgClientSlave  <= AXI_STREAM_SLAVE_FORCE_C;

   obBpMsgServerMaster <= AXI_STREAM_MASTER_INIT_C;
   ibBpMsgServerSlave  <= AXI_STREAM_SLAVE_FORCE_C;

   mpsObSlaves <= (others => AXI_STREAM_SLAVE_FORCE_C);
   timingPhy   <= TIMING_PHY_INIT_C;

   trigHw(1)   <= timingTrig.trigPulse(1);
   freezeHw(1) <= timingTrig.trigPulse(1);

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

   ----------------
   -- AMC Interface
   ----------------
   U_DUAL_AMC : entity work.AmcMicrowaveMuxDualCore
      generic map (
         TPD_G           => TPD_G,
         AXI_CLK_FREQ_G  => 156.25E+6,
         AXI_BASE_ADDR_G => AXI_CONFIG_C(AMC_INDEX_C).baseAddr)
      port map (
         jesdclk         => jesdclk,
         jesdSysRef      => jesdSysRef,
         jesdRxSync      => jesdRxSync,
         jesdTxSync      => jesdTxSync,
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMasters(AMC_INDEX_C),
         axilReadSlave   => axilReadSlaves(AMC_INDEX_C),
         axilWriteMaster => axilWriteMasters(AMC_INDEX_C),
         axilWriteSlave  => axilWriteSlaves(AMC_INDEX_C),
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

   -------------------         
   -- SYSGEN Interface
   -------------------     
   U_SysGen : entity work.DspCoreWrapper
      generic map (
         TPD_G           => TPD_G,
         AXI_BASE_ADDR_G => AXI_CONFIG_C(DSP_INDEX_C).baseAddr)
      port map (
         -- JESD Clocks and resets   
         jesdClk          => jesdClk,
         jesdRst          => jesdRst,
         -- ADC/DAC/Debug Interface (jesdClk[1:0] domain)
         adcValids        => adcValids,
         adcValues        => adcValues,
         dacValids        => dacValids,
         dacValues        => s_dacValues,
         debugValids      => debugValids,
         debugValues      => debugValues,
         -- DAC Signal Generator Interface (jesdClk[1:0] domain)
         dacSigCtrl       => dacSigCtrl,
         dacSigStatus     => dacSigStatus,
         dacSigValids     => dacSigValids,
         dacSigValues     => dacSigValues,
         -- Digital I/O Interface
         startRamp        => startRamp,
         selectRamp       => selectRamp,
         rampCnt          => rampCnt,
         -- Input timing interface (timingClk domain)
         timingClk        => timingClk,
         timingRst        => timingRst,
         timingTimestamp  => timingBus.message.timestamp,
         -- Application Debug Interface (axilClk domain)
         obAppDebugMaster => obAppDebugMaster,
         obAppDebugSlave  => obAppDebugSlave,
         ibAppDebugMaster => ibAppDebugMaster,
         ibAppDebugSlave  => ibAppDebugSlave,
         -- AXI-Lite Port
         axilClk          => axilClk,
         axilRst          => axilRst,
         axilReadMaster   => axilReadMasters(DSP_INDEX_C),
         axilReadSlave    => axilReadSlaves(DSP_INDEX_C),
         axilWriteMaster  => axilWriteMasters(DSP_INDEX_C),
         axilWriteSlave   => axilWriteSlaves(DSP_INDEX_C));

   ---------------
   -- CRYO-DET RTM
   ---------------
   U_RTM : entity work.RtmCryoDet
      generic map (
         TPD_G           => TPD_G,
         AXI_BASE_ADDR_G => AXI_CONFIG_C(RTM_INDEX_C).baseAddr)
      port map (
         -- JESD Clocks and resets   
         jesdClk         => jesdClk(0),
         jesdRst         => jesdRst(0),
         -- Digital I/O Interface
         startRamp       => startRamp,
         selectRamp      => selectRamp,
         rampCnt         => rampCnt,
         -- AXI-Lite Interface
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMasters(RTM_INDEX_C),
         axilReadSlave   => axilReadSlaves(RTM_INDEX_C),
         axilWriteMaster => axilWriteMasters(RTM_INDEX_C),
         axilWriteSlave  => axilWriteSlaves(RTM_INDEX_C),
         -----------------------
         -- Application Ports --
         -----------------------      
         -- RTM's Low Speed Ports
         rtmLsP          => rtmLsP,
         rtmLsN          => rtmLsN,
         --  RTM's Clock Reference
         genClkP         => genClkP,
         genClkN         => genClkN);

   ------------------
   -- Local Registers
   ------------------   
   U_REG : entity work.AppCoreReg
      generic map (
         TPD_G => TPD_G)
      port map (
         -- Configuration/Status
         dacSigTrigArm   => dacSigTrigArm,
         dacSigTrigDelay => dacSigTrigDelay,
         -- AXI-Lite Interface
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMasters(REG_INDEX_C),
         axilReadSlave   => axilReadSlaves(REG_INDEX_C),
         axilWriteMaster => axilWriteMasters(REG_INDEX_C),
         axilWriteSlave  => axilWriteSlaves(REG_INDEX_C));

   -----------------
   -- Trigger Module
   -----------------
   U_TRIG : entity work.AppCoreTrig
      generic map (
         TPD_G => TPD_G)
      port map (
         jesdClk         => jesdClk(0),
         jesdRst         => jesdRst(0),
         dacSigTrigArm   => dacSigTrigArm,
         dacSigTrigDelay => dacSigTrigDelay,
         dacSigStatus    => dacSigStatus(0),
         -- evrTrig         => evrTrig.trigPulse(0),
         evrTrig         => '0',        -- ignore EVR
         trigHw          => trigHw(0),
         freezeHw        => freezeHw(0));

end mapping;
