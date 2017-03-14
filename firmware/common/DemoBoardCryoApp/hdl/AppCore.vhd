-------------------------------------------------------------------------------
-- Title      : Demo Board Cryo Application Core
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
      AXI_BASE_ADDR_G  : slv(31 downto 0) := x"80000000";
      AXI_ERROR_RESP_G : slv(1 downto 0)  := AXI_RESP_SLVERR_C;
      -- True=370MHz SysGen DSP clock, False=185MHz SysGen DSP clock
      DSP_CLK_2X_G     : boolean          := false);
   port (
      -- Clocks and resets   
      jesdClk             : in    slv(1 downto 0);
      jesdRst             : in    slv(1 downto 0);
      jesdClk2x           : in    slv(1 downto 0);
      jesdRst2x           : in    slv(1 downto 0);
      -- DaqMux/Trig Interface (timingClk domain) 
      freezeHw            : out   slv(1 downto 0);
      evrTrig             : in    AppTopTrigType;
      trigHw              : out   slv(1 downto 0);
      -- JESD SYNC Interface (jesdClk[1:0] domain)
      jesdSysRef          : out   slv(1 downto 0);
      jesdRxSync          : in    slv(1 downto 0);
      jesdTxSync          : out   slv(1 downto 0);
      -- ADC/DAC/Debug Interface (jesdClk[1:0] domain)
      adcValids           : in    Slv7Array(1 downto 0);
      adcValues           : in    sampleDataVectorArray(1 downto 0, 6 downto 0);
      dacValids           : out   Slv7Array(1 downto 0);
      dacValues           : out   sampleDataVectorArray(1 downto 0, 6 downto 0);
      debugValids         : out   Slv4Array(1 downto 0);
      debugValues         : out   sampleDataVectorArray(1 downto 0, 3 downto 0);
      -- DAC Signal Generator Interface
      -- If SIG_GEN_LANE_MODE_G = '0', (jesdClk[1:0] domain)
      -- If SIG_GEN_LANE_MODE_G = '1', (jesdClk2x[1:0] domain)
      dacSigCtrl          : out   DacSigCtrlArray(1 downto 0);
      dacSigStatus        : in    DacSigStatusArray(1 downto 0);
      dacSigValids        : in    Slv7Array(1 downto 0);
      dacSigValues        : in    sampleDataVectorArray(1 downto 0, 6 downto 0);
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

   constant AMC_INDEX_C  : natural := 0;
   constant DSP_INDEX_C  : natural := 1;
   constant CFG_INDEX0_C : natural := 2;
   constant CFG_INDEX1_C : natural := 3;
   
   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

   -- Internal signals
   signal s_extTrig      : slv(1 downto 0);
   signal s_muxSel       : slv(1 downto 0);
   signal s_dacDspValues : sampleDataVectorArray(1 downto 0, 1 downto 0);
   signal s_dacDspValids : Slv2Array(1 downto 0);  
   
begin

   -- Unconnected outs
   dacSigCtrl <= (others => DAC_SIG_CTRL_INIT_C);

   diagnosticClk <= axilClk;
   diagnosticRst <= axilRst;
   diagnosticBus <= DIAGNOSTIC_BUS_INIT_C;

   obBpMsgClientMaster <= AXI_STREAM_MASTER_INIT_C;
   ibBpMsgClientSlave  <= AXI_STREAM_SLAVE_FORCE_C;

   obBpMsgServerMaster <= AXI_STREAM_MASTER_INIT_C;
   ibBpMsgServerSlave  <= AXI_STREAM_SLAVE_FORCE_C;

   obAppDebugMaster <= AXI_STREAM_MASTER_INIT_C;
   ibAppDebugSlave  <= AXI_STREAM_SLAVE_FORCE_C;

   mpsObSlaves <= (others => AXI_STREAM_SLAVE_FORCE_C);
   dacSigCtrl  <= (others => DAC_SIG_CTRL_INIT_C);
   timingPhy   <= TIMING_PHY_INIT_C;
   
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
   U_DUAL_AMC: entity work.AmcCryoDemoDualCore
      generic map (
         TPD_G            => TPD_G,
         AXI_CLK_FREQ_G   => 156.25E+6,
         AXI_ERROR_RESP_G => AXI_ERROR_RESP_G,
         AXI_BASE_ADDR_G  => AXI_BASE_ADDR_G)
      port map (
         -- User ports
         
         amcTrigHw       => s_extTrig,
         jesdSysRef      => jesdSysRef,
         jesdRxSync      => jesdRxSync,
         jesdTxSync      => jesdTxSync,
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMasters(AMC_INDEX_C),
         axilReadSlave   => axilReadSlaves(AMC_INDEX_C),
         axilWriteMaster => axilWriteMasters(AMC_INDEX_C),
         axilWriteSlave  => axilWriteSlaves(AMC_INDEX_C),
         -----------------------
         -- Application Ports --
         -----------------------
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

   -- DaqMux/Trig Interface
   -- trigPulse 0 and 1 Daq Bay0,1
   -- External trigger is asynchronous but it gets synced to timingClk in DadMuxV2.
   GEN_TRIG :
   for i in 1 downto 0 generate
      -- Daq triggers freeze
      trigHw(i)    <= s_extTrig(i) or evrTrig.trigPulse(i);   
      freezeHw(i)  <= s_extTrig(i) or evrTrig.trigPulse(i);
      --
   end generate GEN_TRIG;
   
   ----------------
   -- System generator wrapper
   -- Bay 1 only
   ----------------   

   -- Bay0: Loopback
   s_dacDspValues(0,0) <= adcValues(0,0);
   s_dacDspValues(0,1) <= adcValues(0,1);
   debugValues(0,0)    <= (others => '0');
   debugValues(0,1)    <= (others => '0');
   debugValues(0,2)    <= (others => '0');
   debugValues(0,3)    <= (others => '0');
   s_dacDspValids(0)   <= (others => '1'); 
   
   -- Bay1: Attach sysgen
   U_DemoDspCoreWrapper: entity work.DemoDspCoreWrapper
      generic map (
         TPD_G        => TPD_G,
         DSP_CLK_2X_G => DSP_CLK_2X_G)
      port map (
         jesdClk        => jesdClk(1),
         jesdRst        => jesdRst(1),
         jesdClk2x      => jesdClk2x(1),
         jesdRst2x      => jesdRst2x(1),
         adcHs(0)       => adcValues(1,0),
         adcHs(1)       => adcValues(1,1),
         adcHs(2)       => adcValues(1,2),
         adcHs(3)       => adcValues(1,3),            
         adcHs(4)       => adcValues(1,4),
         adcHs(5)       => adcValues(1,5),            
         dacHs(0)       => s_dacDspValues(1,0),
         dacHs(1)       => s_dacDspValues(1,1),            
         debug(0)       => debugValues(1,0),
         debug(1)       => debugValues(1,1),
         debug(2)       => debugValues(1,2),
         debug(3)       => debugValues(1,3),
         axiClk         => axilClk,
         axiRst         => axilRst,
         axiReadMaster  => axilReadMasters(DSP_INDEX_C),
         axiReadSlave   => axilReadSlaves(DSP_INDEX_C),
         axiWriteMaster => axilWriteMasters(DSP_INDEX_C),
         axiWriteSlave  => axilWriteSlaves(DSP_INDEX_C));
   --   
   s_dacDspValids(1)       <= (others => '1');


   GEN_BAY :
   for i in 1 downto 0 generate
   
      ----------------
      -- Register interface
      ----------------    
      U_DemoCtlReg: entity work.DemoCtlReg
      generic map (
         TPD_G            => TPD_G,
         AXI_ERROR_RESP_G => AXI_ERROR_RESP_G)
      port map (
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMasters(CFG_INDEX0_C+i),
         axilReadSlave   => axilReadSlaves(CFG_INDEX0_C+i),
         axilWriteMaster => axilWriteMasters(CFG_INDEX0_C+i),
         axilWriteSlave  => axilWriteSlaves(CFG_INDEX0_C+i),
         devClk          => jesdClk(i),
         devRst          => jesdRst(i),
         muxSel_o        => s_muxSel(i));
         
      --------------
      -- DAC Multiplexer 
      -- Chooses between System generator (0) or
      -- Signal generator (1)
      --------------
      dacValues(i,0) <= s_dacDspValues(i,0)  when s_muxSel(i)='0' else
                           dacSigValues(i,0); 
      dacValues(i,1) <= s_dacDspValues(i,1)  when s_muxSel(i)='0' else
                           dacSigValues(i,1);                          
      dacValids(i)(1 downto 0) <= s_dacDspValids(i)  when s_muxSel(i)='0' else
                                  dacSigValids(i)(1 downto 0); 
           
   end generate GEN_BAY;
   
   ----------------
   -- No RTM core
   ----------------   
   RtmEmptyCore_INST: entity work.RtmEmptyCore
      generic map (
         TPD_G            => TPD_G,
         AXI_ERROR_RESP_G => AXI_ERROR_RESP_G)
      port map (
         axilClk         => axilClk,
         axilRst         => axilRst,
         rtmLsP          => rtmLsP,
         rtmLsN          => rtmLsN,
         genClkP         => genClkP,
         genClkN         => genClkN);

-------------------------------------------------------------------
end mapping;
