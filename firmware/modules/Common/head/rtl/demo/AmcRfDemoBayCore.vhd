-------------------------------------------------------------------------------
-- Title      : AMC RF Demo board Bay 0 or 1 (6xJESD ADC, 2xDAC).
-------------------------------------------------------------------------------
-- File       : AmcRfDemoBayCore.vhd
-- Author     : Uros Legat <ulegat@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory (Cosylab)
-- Created    : 2015-09-23
-- Last update: 2016-03-10
-- Platform   : LCLS2 Common Plaform Carrier
--              AMC ADC/Analog demo
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
--    Configured for 4-byte operation: GT_WORD_SIZE_C=4
--    6 lane JESD receiver ADC
--    2 lane JESD transmitter DAC
--    2 lane Signal generator (For DAC outputs)
--    SPI: 1 LMK chip, 3 ADC chips, and 1 DAC chip
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

library unisim;
use unisim.vcomponents.all;

use work.StdRtlPkg.all;
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.jesd204bPkg.all;

entity AmcRfDemoBayCore is
   generic (
      TPD_G            : time             := 1 ns;
      SIMULATION_G     : boolean          := false;
      AXI_ERROR_RESP_G : slv(1 downto 0)  := AXI_RESP_DECERR_C;
      AXI_BASE_ADDR_G  : slv(31 downto 0) := (others => '0');

      --JESD configuration
      -----------------------------------------------------
      -- Test tx module instead of GTX
      TEST_G       : boolean := false;
      -- TRUE  Internal SYSREF
      -- FALSE External SYSREF
      SYSREF_GEN_G : boolean := false;

      LINE_RATE_G : real := 7.40E9;

      -- The JESD module supports values: 1,2,4(four byte GT word only)
      F_G                   : positive                   := 2;
      -- K*F/GT_WORD_SIZE_C has to be integer     
      K_G                   : positive                   := 32;
      -- Number of serial lanes: 1 to 16    
      L_RX_G                : positive                   := 6;
      L_TX_G                : positive                   := 2;
      -- DAC Signal generator RAM size 
      GEN_BRAM_ADDR_WIDTH_G : integer range 1 to (2**24) := 8 -- Reduced to 8-bits (Used only for debug)
   );
   port (
      -- ADC Clock and Reset
      adcClk          : out sl;
      adcRst          : out sl;
      adcClk2x        : out sl;
      adcRst2x        : out sl;

      -- Sample data output
      adcValids       : out slv(L_RX_G-1 downto 0);
      adcValues       : out sampleDataArray(L_RX_G-1 downto 0);

      -- Sample data input
      dacValues       : in sampleDataArray(L_TX_G-1 downto 0);

      -----------------------
      -- Application Ports --
      -----------------------
      -- -- AMC's JESD Ports
      jesdRxP     : in  slv(L_RX_G-1 downto 0);
      jesdRxN     : in  slv(L_RX_G-1 downto 0);
      jesdTxP     : out slv(L_RX_G-1 downto 0);
      jesdTxN     : out slv(L_RX_G-1 downto 0);
      -- JESD Reference Ports
      jesdClkP    : in  sl;
      jesdClkN    : in  sl;
      -- AMC's System Reference Ports
      jesdSysRefP : in  sl;
      jesdSysRefN : in  sl;
      -- AMC's Sync Ports
      -- JESD receiver sending sync to ADCs (Used in all subclass modes)
      -- '1' - synchronisation OK
      -- '0' - synchronisation Not OK - synchronisation request
      jesdSyncOutP   : out slv(L_RX_G/2-1 downto 0);
      jesdSyncOutN   : out slv(L_RX_G/2-1 downto 0);

      -- JESD transmitter receiving sync from DAC (Used in all subclass modes)
      -- '1' - synchronisation OK
      -- '0' - synchronisation Not OK - synchronisation request      
      jesdSyncInP : in sl;
      jesdSyncInN : in sl;

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

      -- Debug Signals connected to RTM -- 
      -------------------------------------------------------------------
      rtmLsP : out slv(L_RX_G+L_TX_G-1 downto 0);
      rtmLsN : out slv(L_RX_G+L_TX_G-1 downto 0);

      -- AXI-Lite Interface
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType
   );
end AmcRfDemoBayCore;

architecture top_level_app of AmcRfDemoBayCore is

   -------------------------------------------------------------------------------------------------
   -- SPI
   -------------------------------------------------------------------------------------------------   
   constant NUM_COMMON_SPI_CHIPS_C : positive range 1 to 8 := 4;
   signal coreSclk                 : slv(NUM_COMMON_SPI_CHIPS_C-1 downto 0);
   signal coreSDout                : slv(NUM_COMMON_SPI_CHIPS_C-1 downto 0);
   signal coreCsb                  : slv(NUM_COMMON_SPI_CHIPS_C-1 downto 0);

   signal muxSDin  : sl;
   signal muxSClk  : sl;
   signal muxSDout : sl;

   signal lmkSDin : sl;

   signal spiSDinDac  : sl;
   signal spiSDoutDac : sl;

   -------------------------------------------------------------------------------------------------
   -- JESD constants and signals
   -------------------------------------------------------------------------------------------------
   signal s_sysRef    : sl;
   signal s_sysRefOut : sl;
   signal s_nsyncADC  : sl;
   signal s_nsyncDAC  : sl;
   -- QPLL
   signal qPllLock    : sl;

   -------------------------------------------------------------------------------------------------
   -- Clock Signals
   -------------------------------------------------------------------------------------------------
   signal jesdRefClkDiv2 : sl;
   signal jesdRefClk     : sl;
   signal jesdRefClkG    : sl;
   signal jesdClk        : sl;
   signal jesdRst        : sl;
   signal jesdClk2x      : sl;
   signal jesdRst2x      : sl;
   signal jesdMmcmRst    : sl;
   signal jesdMmcmLocked : sl;

   -------------------------------------------------------------------------------------------------
   -- AXI Lite Config and Signals
   -------------------------------------------------------------------------------------------------
   constant NUM_AXI_MASTERS_C : natural := 8;

   constant JESD_AXIL_RX_INDEX_C : natural := 0;
   constant JESD_AXIL_TX_INDEX_C : natural := 1;
   constant DISP_AXIL_INDEX_C    : natural := 2;
   constant ADC_0_INDEX_C        : natural := 3;
   constant ADC_1_INDEX_C        : natural := 4;
   constant ADC_2_INDEX_C        : natural := 5;
   constant LMK_INDEX_C          : natural := 6;
   constant DAC_INDEX_C          : natural := 7;

   constant JESD_AXIL_RX_BASE_ADDR_C : slv(31 downto 0) := X"0010_0000" + AXI_BASE_ADDR_G;
   constant JESD_AXIL_TX_BASE_ADDR_C : slv(31 downto 0) := X"0020_0000" + AXI_BASE_ADDR_G;
   constant DISP_AXIL_BASE_ADDR_C    : slv(31 downto 0) := X"0030_0000" + AXI_BASE_ADDR_G;
   constant ADC_0_BASE_ADDR_C        : slv(31 downto 0) := X"0040_0000" + AXI_BASE_ADDR_G;
   constant ADC_1_BASE_ADDR_C        : slv(31 downto 0) := X"0050_0000" + AXI_BASE_ADDR_G;
   constant ADC_2_BASE_ADDR_C        : slv(31 downto 0) := X"0060_0000" + AXI_BASE_ADDR_G;
   constant LMK_BASE_ADDR_C          : slv(31 downto 0) := X"0070_0000" + AXI_BASE_ADDR_G;
   constant DAC_BASE_ADDR_C          : slv(31 downto 0) := X"0080_0000" + AXI_BASE_ADDR_G;
   
   constant AXI_CROSSBAR_MASTERS_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := (
      JESD_AXIL_RX_INDEX_C => (
         baseAddr          => JESD_AXIL_RX_BASE_ADDR_C,
         addrBits          => 12,
         connectivity      => X"FFFF"),
      JESD_AXIL_TX_INDEX_C => (
         baseAddr          => JESD_AXIL_TX_BASE_ADDR_C,
         addrBits          => 12,
         connectivity      => X"FFFF"),
      DISP_AXIL_INDEX_C    => (
         baseAddr          => DISP_AXIL_BASE_ADDR_C,
         addrBits          => 20,
         connectivity      => X"FFFF"),
      ADC_0_INDEX_C        => (
         baseAddr          => ADC_0_BASE_ADDR_C,
         addrBits          => 20,
         connectivity      => X"FFFF"),
      ADC_1_INDEX_C        => (
         baseAddr          => ADC_1_BASE_ADDR_C,
         addrBits          => 20,
         connectivity      => X"FFFF"),
      ADC_2_INDEX_C        => (
         baseAddr          => ADC_2_BASE_ADDR_C,
         addrBits          => 20,
         connectivity      => X"FFFF"),
      LMK_INDEX_C          => (
         baseAddr          => LMK_BASE_ADDR_C,
         addrBits          => 20,
         connectivity      => X"FFFF"),
      DAC_INDEX_C          => (
         baseAddr          => DAC_BASE_ADDR_C,
         addrBits          => 12,
         connectivity      => X"FFFF"));

   signal locAxilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal locAxilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal locAxilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal locAxilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

   -- Sample data
   signal s_sampleDataArrOut      : sampleDataArray(L_RX_G-1 downto 0);
   signal s_dataValidVec          : slv(L_RX_G-1 downto 0);
   signal dacMuxSel               : sl;
   signal s_sampleDataArrInSigGen : sampleDataArray(L_TX_G-1 downto 0);
   signal s_sampleDataArrIn       : sampleDataArray(L_TX_G-1 downto 0);

   -- Debug data from SysGen
   signal s_debugArrOut : sampleDataArray(1 downto 0);

   -------------------------------------------------------------------------------------------------
   -- Debug RX and TX digital pulses for latency measurements
   -------------------------------------------------------------------------------------------------   
   signal s_rxPulse : slv(L_RX_G-1 downto 0);
   signal s_txPulse : slv(L_TX_G-1 downto 0);

begin
   
   -- Assign external clocks
   adcClk   <= jesdClk;
   adcRst   <= jesdRst;
   adcClk2x <= jesdClk2x;
   adcRst2x <= jesdRst2x;

   -------------------------------------------------------------------------------------------------
   -- Application Top Axi Crossbar
   -------------------------------------------------------------------------------------------------
   U_TopAxiCrossbar : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 1,
         NUM_MASTER_SLOTS_G => NUM_AXI_MASTERS_C,
         MASTERS_CONFIG_G   => AXI_CROSSBAR_MASTERS_CONFIG_C)
      port map (
         axiClk              => axilClk,
         axiClkRst           => axilRst,
         sAxiWriteMasters(0) => axilWriteMaster,
         sAxiWriteSlaves(0)  => axilWriteSlave,
         sAxiReadMasters(0)  => axilReadMaster,
         sAxiReadSlaves(0)   => axilReadSlave,
         mAxiWriteMasters    => locAxilWriteMasters,
         mAxiWriteSlaves     => locAxilWriteSlaves,
         mAxiReadMasters     => locAxilReadMasters,
         mAxiReadSlaves      => locAxilReadSlaves);

   -------------------------------------------------------------------------------------------------
   -- JESD Clocking
   -------------------------------------------------------------------------------------------------
   U_IBUFDS_GTE2 : IBUFDS_GTE3
      port map (
         I     => jesdClkP,
         IB    => jesdClkN,
         CEB   => '0',
         ODIV2 => jesdRefClkDiv2,       -- 185 MHz, Frequency the same as jesdRefClk
         O     => jesdRefClk);          -- 185 MHz     


   U_JESD_BUFG_GT : BUFG_GT
      port map (
         I       => jesdRefClkDiv2,     -- 185 MHz
         CE      => '1',
         CLR     => '0',
         CEMASK  => '1',
         CLRMASK => '1',
         DIV     => "000",
         O       => jesdRefClkG);       -- 185 MHz

   U_JesdPwrUpRst : entity work.PwrUpRst
      generic map (
         TPD_G          => TPD_G,
         SIM_SPEEDUP_G  => SIMULATION_G,
         IN_POLARITY_G  => '1',
         OUT_POLARITY_G => '1')
      port map (
         clk    => jesdRefClkG,
         rstOut => jesdMmcmRst); 


   -- -- 370 MHz
   U_ClockManager : entity work.ClockManagerUltraScale
      generic map (
         TPD_G              => TPD_G,
         TYPE_G             => "MMCM",
         INPUT_BUFG_G       => false,
         FB_BUFG_G          => true,
         NUM_CLOCKS_G       => 2,
         BANDWIDTH_G        => "OPTIMIZED",
         CLKIN_PERIOD_G     => 5.405,
         DIVCLK_DIVIDE_G    => 1,
         CLKFBOUT_MULT_F_G  => 6.000,
         CLKOUT0_DIVIDE_F_G => 6.000,
         CLKOUT0_RST_HOLD_G => 16,
         CLKOUT1_DIVIDE_G => 3,
         CLKOUT1_RST_HOLD_G => 32        
      )
      port map (
         clkIn     => jesdRefClkG,
         rstIn     => jesdMmcmRst,
         clkOut(0) => jesdClk,   -- 185 MHz
         clkOut(1) => jesdClk2x, -- 370 MHz    
         rstOut(0) => jesdRst,
         rstOut(1) => jesdRst2x,         
         locked    => jesdMmcmLocked
      );

   -------------------------------------------------------------------------------------------------
   -- JESD block
   -------------------------------------------------------------------------------------------------   
   U_Jesd204bGthWrapper : entity work.Jesd204bGthWrapper
      generic map (
         TPD_G => TPD_G,

         -- Test tx module instead of GTX
         TEST_G       => TEST_G,
         -- Internal SYSREF SYSREF_GEN_G= TRUE else 
         -- External SYSREF
         SYSREF_GEN_G => SYSREF_GEN_G,

         -- AXI
         AXI_ERROR_RESP_G => AXI_RESP_SLVERR_C,

         -- JESD
         F_G    => F_G,
         K_G    => K_G,
         L_RX_G => L_RX_G
         )
      port map (

         stableClk => axilClk,          -- Onboard clock always present
         refClk    => jesdRefClk,

         devClk_i  => jesdClk,          -- both same
         devClk2_i => jesdClk,          -- both same
         devRst_i  => jesdRst,

         devClkActive_i => jesdMmcmLocked,

         -----------------------------------
         gtTxP  => jesdTxP,
         gtTxN  => jesdTxN,
         gtRxP  => jesdRxP,
         gtRxN  => jesdRxN,

         axiClk => axilClk,
         axiRst => axilRst,

         axilReadMasterRx  => locAxilReadMasters(JESD_AXIL_RX_INDEX_C),
         axilReadSlaveRx   => locAxilReadSlaves(JESD_AXIL_RX_INDEX_C),
         axilWriteMasterRx => locAxilWriteMasters(JESD_AXIL_RX_INDEX_C),
         axilWriteSlaveRx  => locAxilWriteSlaves(JESD_AXIL_RX_INDEX_C),

         axilReadMasterTx  => locAxilReadMasters(JESD_AXIL_TX_INDEX_C),
         axilReadSlaveTx   => locAxilReadSlaves(JESD_AXIL_TX_INDEX_C),
         axilWriteMasterTx => locAxilWriteMasters(JESD_AXIL_TX_INDEX_C),
         axilWriteSlaveTx  => locAxilWriteSlaves(JESD_AXIL_TX_INDEX_C),

         -- AXI stream interface not used because of external DAQ module 
         rxAxisMasterArr => open,
         rxCtrlArr       => (others => AXI_STREAM_CTRL_INIT_C),

         -- RX sample data out
         sampleDataArr_o => adcValues,
         dataValidVec_o  => adcValids,

         -- TX sample data in      
         sampleDataArr_i => s_sampleDataArrIn,

         sysRef_i => s_sysRef,
         sysRef_o => s_sysRefOut,
         nSync_o  => s_nSyncADC,
         nSync_i  => s_nSyncDAC,

         rxPulse_o => s_rxPulse,
         txPulse_o => s_txPulse,

         ledsRx_o => open,
         ledsTx_o => open,

         qPllLock_o => qPllLock         -- Disconected debug port (read from status register () ) 
         );

   -------------------------------------------------------------------------------------------------
   -- DAC Signal Generator block
   -------------------------------------------------------------------------------------------------    
   U_DacSignalGenerator : entity work.DacSignalGenerator
      generic map (
         TPD_G            => TPD_G,
         AXI_ERROR_RESP_G => AXI_RESP_SLVERR_C,
         AXI_BASE_ADDR_G  => DISP_AXIL_BASE_ADDR_C,
         ADDR_WIDTH_G     => GEN_BRAM_ADDR_WIDTH_G,
         DATA_WIDTH_G     => (GT_WORD_SIZE_C*8),
         L_G              => L_TX_G)
      port map (
         axiClk          => axilClk,
         axiRst          => axilRst,
         devClk_i        => jesdClk,
         devRst_i        => jesdRst,
         axilReadMaster  => locAxilReadMasters(DISP_AXIL_INDEX_C),
         axilReadSlave   => locAxilReadSlaves(DISP_AXIL_INDEX_C),
         axilWriteMaster => locAxilWriteMasters(DISP_AXIL_INDEX_C),
         axilWriteSlave  => locAxilWriteSlaves(DISP_AXIL_INDEX_C),
         sampleDataArr_o => s_sampleDataArrInSigGen,
         enable_o        => dacMuxSel
         );

   -- DAC input Multiplexer
   -- If any of the DAC Signal generator lanes are enabled the 
   -- DAC Signal generator is selected 
   s_sampleDataArrIn <= dacValues when dacMuxSel = '0' else
                        s_sampleDataArrInSigGen;

   ----------------------------------------------------------------
   -- Put sync and sysref on differential io buffer
   ----------------------------------------------------------------
   U_IBUFDS_rsysref : IBUFDS
      generic map (
         DIFF_TERM    => false,
         IBUF_LOW_PWR => true,
         IOSTANDARD   => "DEFAULT")
      port map (
         I  => jesdSysRefP,
         IB => jesdSysRefN,
         O  => s_sysRef
         );

   -- ADC Sync outputs are all combined
   U_OBUFDS_nsync0 : OBUFDS
      generic map (
         IOSTANDARD => "DEFAULT",
         SLEW       => "SLOW"
         )
      port map (
         I  => s_nsyncADC,
         O  => jesdSyncOutP(0),
         OB => jesdSyncOutN(0)
         );

   U_OBUFDS_nsync1 : OBUFDS
      generic map (
         IOSTANDARD => "DEFAULT",
         SLEW       => "SLOW"
         )
      port map (
         I  => s_nSyncADC,
         O  => jesdSyncOutP(1),
         OB => jesdSyncOutN(1)
         );

   U_OBUFDS_nsync2 : OBUFDS
      generic map (
         IOSTANDARD => "DEFAULT",
         SLEW       => "SLOW"
         )
      port map (
         I  => s_nSyncADC,
         O  => jesdSyncOutP(2),
         OB => jesdSyncOutN(2)
         );

   U_IBUFDS_nsync0 : IBUFDS
      generic map (
         DIFF_TERM    => false,
         IBUF_LOW_PWR => true,
         IOSTANDARD   => "DEFAULT")
      port map (
         I  => jesdSyncInP,
         IB => jesdSyncInN,
         O  => s_nSyncDAC
         );

   ----------------------------------------------------------------
   -- SPI interface ADCs and LMK 
   ----------------------------------------------------------------
   gen_dcSpiChips : for I in NUM_COMMON_SPI_CHIPS_C-1 downto 0 generate
      AxiSpiMaster_INST : entity work.AxiSpiMaster
         generic map (
            TPD_G             => TPD_G,
            ADDRESS_SIZE_G    => 15,
            DATA_SIZE_G       => 8,
            CLK_PERIOD_G      => 6.4E-9,
            SPI_SCLK_PERIOD_G => 100.0E-6)
         port map (
            axiClk         => axilClk,
            axiRst         => axilRst,
            axiReadMaster  => locAxilReadMasters(ADC_0_INDEX_C+I),
            axiReadSlave   => locAxilReadSlaves(ADC_0_INDEX_C+I),
            axiWriteMaster => locAxilWriteMasters(ADC_0_INDEX_C+I),
            axiWriteSlave  => locAxilWriteSlaves(ADC_0_INDEX_C+I),
            coreSclk       => coreSclk(I),
            coreSDin       => muxSDin,
            coreSDout      => coreSDout(I),
            coreCsb        => coreCsb(I));
   end generate gen_dcSpiChips;

   -- Input mux from "IO" port if LMK and from "I" port for ADCs 
   muxSDin <= lmkSDin when coreCsb = "0111" else spiSdo_i;

   -- Output mux
   with coreCsb select
      muxSclk <= coreSclk(0) when "1110",
      coreSclk(1)            when "1101",
      coreSclk(2)            when "1011",
      coreSclk(3)            when "0111",
      '0'                    when others;
   
   with coreCsb select
      muxSDout <= coreSDout(0) when "1110",
      coreSDout(1)             when "1101",
      coreSDout(2)             when "1011",
      coreSDout(3)             when "0111",
      '0'                      when others;

   -- Outputs 
   spiSclk_o <= muxSclk;
   spiSdi_o  <= muxSDout;

   U_ADC_SDIO_IOBUFT : IOBUF
      port map (
         I  => '0',
         O  => lmkSDin,
         IO => spiSdio_io,
         T  => muxSDout);

   -- Active low chip selects
   spiCsL_o <= coreCsb;

   ----------------------------------------------------------------
   -- SPI interface DAC
   ----------------------------------------------------------------  
   U_dacAxiSpiMaster : entity work.AxiSpiMaster
      generic map (
         TPD_G             => TPD_G,
         ADDRESS_SIZE_G    => 7,
         DATA_SIZE_G       => 16,
         CLK_PERIOD_G      => 6.4E-9,
         SPI_SCLK_PERIOD_G => 100.0E-6)
      port map (
         axiClk         => axilClk,
         axiRst         => axilRst,
         axiReadMaster  => locAxilReadMasters(DAC_INDEX_C),
         axiReadSlave   => locAxilReadSlaves(DAC_INDEX_C),
         axiWriteMaster => locAxilWriteMasters(DAC_INDEX_C),
         axiWriteSlave  => locAxilWriteSlaves(DAC_INDEX_C),
         coreSclk       => spiSclkDac_o,
         coreSDin       => spiSDinDac,
         coreSDout      => spiSDoutDac,
         coreCsb        => spiCsLDac_o);

   U_DAC_SDIO_IOBUFT : IOBUF
      port map (
         I  => '0',
         O  => spiSDinDac,
         IO => spiSdioDac_io,
         T  => spiSDoutDac);   

   -------------------------------------------------------------------------------------------------
   -- Debug outputs
   -------------------------------------------------------------------------------------------------

   -- Digital outputs for latency measurements

   -- 6 Lane RX pulses (generated from comparing thersholds)
   gen_rxLanes : for I in L_RX_G-1 downto 0 generate
      U_OBUFDSPulseOut_rx : OBUFDS
         generic map (
            IOSTANDARD => "DEFAULT",
            SLEW       => "SLOW"
            )
         port map (
            I  => s_rxPulse(I),
            O  => rtmLsP(I),
            OB => rtmLsN(I)
            );
   end generate gen_rxLanes;

   -- 2 Lane TX pulses (digital square wave signal)
   gen_txLanes : for I in L_TX_G-1 downto 0 generate
      U_OBUFDSPulseOut_tx : OBUFDS
         generic map (
            IOSTANDARD => "DEFAULT",
            SLEW       => "SLOW"
            )
         port map (
            I  => s_txPulse(I),
            O  => rtmLsP(L_RX_G+I),
            OB => rtmLsN(L_RX_G+I)
            );
   end generate gen_txLanes;

end top_level_app;
