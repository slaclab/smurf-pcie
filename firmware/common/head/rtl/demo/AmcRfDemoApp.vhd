-------------------------------------------------------------------------------
-- Title      : 
-------------------------------------------------------------------------------
-- File       : AmcRfDemoApp.vhd
-- Author     : Uros Legat  <ulegat@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2016-02-25
-- Last update: 2016-08-04
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.StdRtlPkg.all;
use work.AxiStreamPkg.all;
use work.SsiPkg.all;
use work.AxiLitePkg.all;
use work.TimingPkg.all;
use work.AmcCarrierPkg.all;
use work.jesd204bpkg.all;

library unisim;
use unisim.vcomponents.all;

entity AmcRfDemoApp is
   generic (
      TPD_G            : time            := 1 ns;
      AXI_ERROR_RESP_G : slv(1 downto 0) := AXI_RESP_DECERR_C;      
      SIMULATION_G     : boolean         := false;                -- True=Speedup the resets for simulation   
      DSP_CLK_2X_G     : boolean         := false;                -- True=370MHz SysGen DSP clock, False=185MHz SysGen DSP clock
      AMC_MSB_G        : integer range 0 to 1 := 1;            -- Select bays: Dual core (1:0), Bay1 (1:1), Bay0 (0:0)
      AMC_LSB_G        : integer range 0 to 1 := 0             -- Select bays: Dual core (1:0), Bay1 (1:1), Bay0 (0:0)
      );
   port (
      ----------------------
      -- Top Level Interface
      ----------------------
      -- AXI-Lite Interface (regClk domain)
      -- Address Range = [0x80000000:0xFFFFFFFF]
      regClk               : out   sl;
      regRst               : out   sl;
      regReadMaster        : in    AxiLiteReadMasterType;
      regReadSlave         : out   AxiLiteReadSlaveType;
      regWriteMaster       : in    AxiLiteWriteMasterType;
      regWriteSlave        : out   AxiLiteWriteSlaveType;
      -- Timing Interface (timingClk domain) 
      timingClk            : out   sl;
      timingRst            : out   sl;
      timingBus            : in    TimingBusType;
      -- Diagnostic Interface (diagnosticClk domain)
      diagnosticClk        : out   sl;
      diagnosticRst        : out   sl;
      diagnosticBus        : out   DiagnosticBusType;
      -- Raw Diagnostic Interface (diagnosticRawClks domains)
      waveformClk          : in    sl;
      waveformRst          : in    sl;
      obAppWaveformMasters : out   WaveformMasterArrayType;
      obAppWaveformSlaves  : in    WaveformSlaveArrayType;
      ibAppWaveformMasters : in    WaveformMasterArrayType;
      ibAppWaveformSlaves  : out   WaveformSlaveArrayType;
      -- Reference Clocks and Resets
      recTimingClk         : in    sl;
      recTimingRst         : in    sl;
      ref156MHzClk         : in    sl;
      ref156MHzRst         : in    sl;
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
      trigHw : in slv(AMC_MSB_G downto AMC_LSB_G)
   );
end AmcRfDemoApp;

architecture mapping of AmcRfDemoApp is

   -----------------Axi Lite--------------------------
   constant AXI_BASE_ADDR_C : slv(31 downto 0) := x"80000000";

   constant NUM_AXI_MASTERS_C : natural := 5;

   constant AMC0_INDEX_C         : natural := 0;
   constant AMC1_INDEX_C         : natural := 1;
   constant DAQ_MUX0_INDEX_C     : natural := 2;
   constant DAQ_MUX1_INDEX_C     : natural := 3;
   constant SYSGEN_INDEX_C       : natural := 4;

   constant AMC0_BASE_ADDR_C   : slv(31 downto 0) := x"00000000" + AXI_BASE_ADDR_C;
   constant AMC1_BASE_ADDR_C   : slv(31 downto 0) := x"01000000" + AXI_BASE_ADDR_C;
   constant DAQ_MUX0_ADDR_C    : slv(31 downto 0) := x"02000000" + AXI_BASE_ADDR_C;
   constant DAQ_MUX1_ADDR_C    : slv(31 downto 0) := x"03000000" + AXI_BASE_ADDR_C;
   constant SYSGEN_BASE_ADDR_C : slv(31 downto 0) := x"04000000" + AXI_BASE_ADDR_C;
   
   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := (
      AMC0_INDEX_C     => (
         baseAddr      => AMC0_BASE_ADDR_C,
         addrBits      => 24,
         connectivity  => X"FFFF"),
      AMC1_INDEX_C     => (
         baseAddr      => AMC1_BASE_ADDR_C,
         addrBits      => 24,
         connectivity  => X"FFFF"),
      DAQ_MUX0_INDEX_C => (
         baseAddr      => DAQ_MUX0_ADDR_C,
         addrBits      => 24,
         connectivity  => X"FFFF"),
      DAQ_MUX1_INDEX_C => (
         baseAddr      => DAQ_MUX1_ADDR_C,
         addrBits      => 24,
         connectivity  => X"FFFF"),
      SYSGEN_INDEX_C   => (
         baseAddr      => SYSGEN_BASE_ADDR_C,
         addrBits      => 24,
         connectivity  => X"FFFF"));
         
   signal writeMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal writeSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal readMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal readSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

   -- Internal signals
   signal adcClk        : slv(AMC_MSB_G downto AMC_LSB_G);
   signal adcRst        : slv(AMC_MSB_G downto AMC_LSB_G);
   signal adcClk2x      : slv(AMC_MSB_G downto AMC_LSB_G);
   signal adcRst2x      : slv(AMC_MSB_G downto AMC_LSB_G);
   signal adcValids     : Slv6Array(AMC_MSB_G downto AMC_LSB_G);
   signal adcValues     : sampleDataVectorArray(AMC_MSB_G downto AMC_LSB_G, 5 downto 0);
   signal dacValues     : sampleDataVectorArray(AMC_MSB_G downto AMC_LSB_G, 1 downto 0);
   signal debug         : Slv32VectorArray(AMC_MSB_G downto AMC_LSB_G, 3 downto 0);
   signal dataValid     : Slv12Array(AMC_MSB_G downto AMC_LSB_G);

   signal axilClk : sl;
   signal axilRst : sl;

   -- DAQ Triggers
   signal trigCascIn : Slv(AMC_MSB_G downto AMC_LSB_G);
   signal trigCascOut: Slv(AMC_MSB_G downto AMC_LSB_G);
   signal timeStamp  : slv(63 downto 0);
   signal sRtmLsP    : Slv8Array(AMC_MSB_G downto AMC_LSB_G);
   signal sRtmLsN    : Slv8Array(AMC_MSB_G downto AMC_LSB_G);

begin

   -----------------
   -- System Mapping
   -----------------
   regClk  <= ref156MHzClk;
   regRst  <= ref156MHzRst;
   axilClk <= ref156MHzClk;
   axilRst <= ref156MHzRst;

   timingClk <= recTimingClk;
   timingRst <= recTimingRst;

   diagnosticClk <= adcClk(1);
   diagnosticRst <= adcRst(1);
   diagnosticBus <= DIAGNOSTIC_BUS_INIT_C;

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
         axiClk    => axilClk,
         axiClkRst => axilRst,

         sAxiWriteMasters(0) => regWriteMaster,
         sAxiWriteSlaves(0)  => regWriteSlave,
         sAxiReadMasters(0)  => regReadMaster,
         sAxiReadSlaves(0)   => regReadSlave,

         mAxiWriteMasters => writeMasters,
         mAxiWriteSlaves  => writeSlaves,
         mAxiReadMasters  => readMasters,
         mAxiReadSlaves   => readSlaves);

   ------------------------------       
   -- AMC Demo board dual core
   ------------------------------
   GEN_AMC : for i in AMC_MSB_G downto AMC_LSB_G generate
      U_AMC: entity work.AmcRfDemoBayCore
      generic map (
         TPD_G                 => TPD_G,
         SIMULATION_G          => SIMULATION_G,
         AXI_ERROR_RESP_G      => AXI_ERROR_RESP_G,
         AXI_BASE_ADDR_G       => AXI_CONFIG_C(AMC0_INDEX_C+i).baseAddr)
      port map (
         adcClk          => adcClk(i),
         adcRst          => adcRst(i),
         adcClk2x        => adcClk2x(i),
         adcRst2x        => adcRst2x(i),
         adcValids       => adcValids(i),
         adcValues(0)    => adcValues(i, 0),
         adcValues(1)    => adcValues(i, 1),
         adcValues(2)    => adcValues(i, 2),
         adcValues(3)    => adcValues(i, 3),
         adcValues(4)    => adcValues(i, 4),
         adcValues(5)    => adcValues(i, 5),
         dacValues(0)    => dacValues(i, 0),
         dacValues(1)    => dacValues(i, 1),         
         jesdRxP         => jesdRxP(i),
         jesdRxN         => jesdRxN(i),
         jesdTxP         => jesdTxP(i),
         jesdTxN         => jesdTxN(i),
         jesdClkP        => jesdClkP(i),
         jesdClkN        => jesdClkN(i),
         jesdSysRefP     => jesdSysRefP(i),
         jesdSysRefN     => jesdSysRefN(i),
         jesdSyncOutP    => jesdSyncOutP(i),
         jesdSyncOutN    => jesdSyncOutN(i),
         jesdSyncInP     => jesdSyncInP(i),
         jesdSyncInN     => jesdSyncInN(i),
         spiSclk_o       => spiSclk_o(i),
         spiSdi_o        => spiSdi_o(i),
         spiSdo_i        => spiSdo_i(i),
         spiSdio_io      => spiSdio_io(i),
         spiCsL_o        => spiCsL_o(i),
         spiSclkDac_o    => spiSclkDac_o(i),
         spiSdioDac_io   => spiSdioDac_io(i),
         spiCsLDac_o     => spiCsLDac_o(i),
         rtmLsP          => sRtmLsP(i),      
         rtmLsN          => sRtmLsN(i),     
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => readMasters(AMC0_INDEX_C+i),
         axilReadSlave   => readSlaves(AMC0_INDEX_C+i),
         axilWriteMaster => writeMasters(AMC0_INDEX_C+i),
         axilWriteSlave  => writeSlaves(AMC0_INDEX_C+i));
      
      -- RTM debug signal output assignment
         rtmLsP(32+2*i) <= sRtmLsP(i)(0); -- Output only ch0 Pulses (RX pulse and TX pulse)
         rtmLsP(33+2*i) <= sRtmLsP(i)(6); -- Output only ch0 Pulses (RX pulse and TX pulse)         
         rtmLsN(32+2*i) <= sRtmLsN(i)(0); -- Output only ch0 Pulses (RX pulse and TX pulse)
         rtmLsN(33+2*i) <= sRtmLsN(i)(6); -- Output only ch0 Pulses (RX pulse and TX pulse)  

      ------------------
      -- AMC DAQ MUX V2 dual core
      ------------------
      U_DaqMuxV2_Bay0 : entity work.DaqMuxV2
      generic map (
         TPD_G            => TPD_G,
         AXI_ERROR_RESP_G => AXI_ERROR_RESP_G,
         N_DATA_IN_G      => 12,
         N_DATA_OUT_G     => 4)
      port map (
         axiClk                        => axilClk,
         axiRst                        => axilRst,
         devClk_i                      => adcClk(i),
         devRst_i                      => adcRst(i),
         trigHw_i                      => trigHw(i), -- Mask in configuration if not used
         trigCasc_i                    => trigCascIn(i),
         trigCasc_o                    => trigCascOut(i),
         freezeHw_i                    => trigHw(i), -- Mask in configuration if not used
         timeStamp_i                   => (others => '1'), -- Time stamp disconnected
         axilReadMaster                => readMasters(DAQ_MUX0_INDEX_C+i),
         axilReadSlave                 => readSlaves(DAQ_MUX0_INDEX_C+i),
         axilWriteMaster               => writeMasters(DAQ_MUX0_INDEX_C+i),
         axilWriteSlave                => writeSlaves(DAQ_MUX0_INDEX_C+i),
         sampleDataArr_i(0)            => adcValues(i, 0),
         sampleDataArr_i(1)            => adcValues(i, 1),
         sampleDataArr_i(2)            => adcValues(i, 2),
         sampleDataArr_i(3)            => adcValues(i, 3),
         sampleDataArr_i(4)            => adcValues(i, 4),
         sampleDataArr_i(5)            => adcValues(i, 5),
         sampleDataArr_i(6)            => dacValues(i, 0),
         sampleDataArr_i(7)            => dacValues(i, 1),
         sampleDataArr_i(8)            => debug(i, 0),
         sampleDataArr_i(9)            => debug(i, 1),
         sampleDataArr_i(10)           => debug(i, 2),
         sampleDataArr_i(11)           => debug(i, 3),
         dataValidVec_i                => dataValid(i),
         wfClk_i                       => waveformClk,
         wfRst_i                       => waveformRst,
         rxAxisMasterArr_o             => obAppWaveformMasters(i),          -- AXIS DDR Interface
         rxAxisSlaveArr_i(0)           => obAppWaveformSlaves(i)(0).slave,  -- AXIS DDR Interface
         rxAxisSlaveArr_i(1)           => obAppWaveformSlaves(i)(1).slave,  -- AXIS DDR Interface
         rxAxisSlaveArr_i(2)           => obAppWaveformSlaves(i)(2).slave,  -- AXIS DDR Interface
         rxAxisSlaveArr_i(3)           => obAppWaveformSlaves(i)(3).slave,  -- AXIS DDR Interface                                                                       
         rxAxisCtrlArr_i(0)            => obAppWaveformSlaves(i)(0).ctrl,
         rxAxisCtrlArr_i(1)            => obAppWaveformSlaves(i)(1).ctrl,
         rxAxisCtrlArr_i(2)            => obAppWaveformSlaves(i)(2).ctrl,
         rxAxisCtrlArr_i(3)            => obAppWaveformSlaves(i)(3).ctrl);  -- AXIS DDR Interface   
      --
      trigCascIn(i) <= ite(AMC_MSB_G=AMC_MSB_G, '0' , trigCascOut(AMC_MSB_G - i));
      dataValid(i)(5 downto 0)  <= adcValids(i);
      dataValid(i)(11 downto 6) <= (others => adcValids(i)(0));
      --

   end generate GEN_AMC;
   
   -- If Both cores enabled
   DUAL_CORE : if AMC_MSB_G = 1 and AMC_LSB_G = 0 generate
   
         -- Bay0: Loopback
         dacValues(0,0) <= adcValues(0,0);
         dacValues(0,1) <= adcValues(0,1);
         debug(0,0)     <= (others => '0');
         debug(0,1)     <= (others => '0');
         debug(0,2)     <= (others => '0');
         debug(0,3)     <= (others => '0');
         
         
         -- Bay 1: Attach sysgen
         U_DemoDspCoreWrapper: entity work.DemoDspCoreWrapper
         generic map (
            TPD_G        => TPD_G,
            DSP_CLK_2X_G => DSP_CLK_2X_G)
         port map (
            jesdClk        => adcClk(1),
            jesdRst        => adcRst(1),
            jesdClk2x      => adcClk2x(1),
            jesdRst2x      => adcRst2x(1),
            adcHs(0)       => adcValues(1,0),
            adcHs(1)       => adcValues(1,1),
            adcHs(2)       => adcValues(1,2),
            adcHs(3)       => adcValues(1,3),            
            adcHs(4)       => adcValues(1,4),
            adcHs(5)       => adcValues(1,5),            
            dacHs(0)       => dacValues(1,0),
            dacHs(1)       => dacValues(1,1),            
            debug(0)       => debug(1,0),
            debug(1)       => debug(1,1),
            debug(2)       => debug(1,2),
            debug(3)       => debug(1,3),
            axiClk         => axilClk,
            axiRst         => axilRst,
            axiReadMaster  => readMasters(SYSGEN_INDEX_C),
            axiReadSlave   => readSlaves(SYSGEN_INDEX_C),
            axiWriteMaster => writeMasters(SYSGEN_INDEX_C),
            axiWriteSlave  => writeSlaves(SYSGEN_INDEX_C));
 
   end generate DUAL_CORE;  

   -- If Bay 1 core enabled
   BAY1_CORE : if AMC_MSB_G = 1 and AMC_LSB_G = 1 generate
         -- Bay 1: Attach sysgen
         U_DemoDspCoreWrapper: entity work.DemoDspCoreWrapper
         generic map (
            TPD_G        => TPD_G,
            DSP_CLK_2X_G => DSP_CLK_2X_G)
         port map (
            jesdClk        => adcClk(1),
            jesdRst        => adcRst(1),
            jesdClk2x      => adcClk2x(1),
            jesdRst2x      => adcRst2x(1),
            adcHs(0)       => adcValues(1,0),
            adcHs(1)       => adcValues(1,1),
            adcHs(2)       => adcValues(1,2),
            adcHs(3)       => adcValues(1,3),            
            adcHs(4)       => adcValues(1,4),
            adcHs(5)       => adcValues(1,5),            
            dacHs(0)       => dacValues(1,0),
            dacHs(1)       => dacValues(1,1),            
            debug(0)       => debug(1,0),
            debug(1)       => debug(1,1),
            debug(2)       => debug(1,2),
            debug(3)       => debug(1,3),
            axiClk         => axilClk,
            axiRst         => axilRst,
            axiReadMaster  => readMasters(SYSGEN_INDEX_C),
            axiReadSlave   => readSlaves(SYSGEN_INDEX_C),
            axiWriteMaster => writeMasters(SYSGEN_INDEX_C),
            axiWriteSlave  => writeSlaves(SYSGEN_INDEX_C));
    end generate BAY1_CORE;   
   
   -- If Bay 0 core enabled
   BAY0_CORE : if AMC_MSB_G = 0 and AMC_LSB_G = 0 generate
         -- Bay0: Loopback
         dacValues(0,0) <= adcValues(0,0);
         dacValues(0,1) <= adcValues(0,1);
         debug(0,0)     <= (others => '0');
         debug(0,1)     <= (others => '0');
         debug(0,2)     <= (others => '0');
         debug(0,3)     <= (others => '0');   
   end generate BAY0_CORE; 

end mapping;
