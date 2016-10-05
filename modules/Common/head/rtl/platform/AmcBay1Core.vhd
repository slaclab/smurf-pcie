-------------------------------------------------------------------------------
-- Title      : AMC1 LLRF Module (SD-376-396-17)
-------------------------------------------------------------------------------
-- File       : AmcBay1Core.vhd
-- Author     : Uros Legat  <ulegat@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2015-12-07
-- Last update: 2016-02-11
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
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.I2cPkg.all;
use work.jesd204bpkg.all;

library unisim;
use unisim.vcomponents.all;

entity AmcBay1Core is
   generic (
      TPD_G            : time             := 1 ns;
      SIMULATION_G     : boolean          := false;
      AXI_ERROR_RESP_G : slv(1 downto 0)  := AXI_RESP_DECERR_C;
      AXI_BASE_ADDR_G  : slv(31 downto 0) := (others => '0');

      -- Number of serial lanes: 1 to 16    
      L_RX_G           : positive              := 6;
      --
      DAC_DATA_WIDTH_G : integer range 1 to 32 := 16
      );
   port (

      -- ADC Clock and Reset
      adcClk          : out sl;
      adcRst          : out sl;
      adcClk2x        : out sl;
      adcRst2x        : out sl;
      
      -- Sample data output (adcClk domain: Use if external data acquisition core is attached)
      adcValids       : out slv(L_RX_G-1 downto 0);
      adcValues       : out sampleDataArray(L_RX_G-1 downto 0);
      -- AXI-Lite Interface
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType;

      -----------------------
      -- Application Ports --
      -----------------------
      -- JESD High Speed Ports
      jesdRxP     : in  slv(L_RX_G-1 downto 0);
      jesdRxN     : in  slv(L_RX_G-1 downto 0);
      jesdTxP     : out slv(L_RX_G-1 downto 0);
      jesdTxN     : out slv(L_RX_G-1 downto 0);
      -- JESD Reference Ports
      jesdClkP    : in  sl;
      jesdClkN    : in  sl;
      jesdSysRefP : in  sl;
      jesdSysRefN : in  sl;
      -- JESD ADC Sync Ports
      jesdSyncP   : out slv(L_RX_G/2-1 downto 0);
      jesdSyncN   : out slv(L_RX_G/2-1 downto 0);

      -- ADC,LMK,DAC SPI Ports
      spiSclk_o  : out   sl;
      spiSdi_o   : out   sl;
      spiSdo_i   : in    sl;
      spiSdio_io : inout sl;
      spiCsL_o   : out   Slv(4 downto 0);

      -- Attenuator serial ports
      attSclk_o    : out sl;
      attSdi_o     : out sl;
      attLatchEn_o : out slv(3 downto 0);
      
      -- JESD sample data in (little endian none byte swapped)    
      extDacValues_i : in  slv((2*DAC_DATA_WIDTH_G)-1 downto 0);
      extDacClk_i    : in  sl;
      extDacRst_i    : in  sl;
      
      -- LVDS DAC data ports
      dacDataP : out slv(DAC_DATA_WIDTH_G-1 downto 0);
      dacDataN : out slv(DAC_DATA_WIDTH_G-1 downto 0);

      -- LVDS DAC Sample clock (DAC samples data on both edges)
      dacDckP : out sl;
      dacDckN : out sl
      );
end AmcBay1Core;

architecture mapping of AmcBay1Core is

   constant NUM_AXI_MASTERS_C : natural := 11;

   constant JESD_INDEX_C    : natural := 0;
   constant ADC_0_INDEX_C   : natural := 1;
   constant ADC_1_INDEX_C   : natural := 2;
   constant ADC_2_INDEX_C   : natural := 3;
   constant LMK_INDEX_C     : natural := 4;
   constant DAC_INDEX_C     : natural := 5;
   constant ATT_0_INDEX_C   : natural := 6;
   constant ATT_1_INDEX_C   : natural := 7;
   constant ATT_2_INDEX_C   : natural := 8;
   constant ATT_3_INDEX_C   : natural := 9;
   constant SIG_GEN_INDEX_C : natural := 10;

   constant JESD_BASE_ADDR_C    : slv(31 downto 0) := X"0000_0000" + AXI_BASE_ADDR_G;
   constant ADC0_BASE_ADDR_C    : slv(31 downto 0) := X"0010_0000" + AXI_BASE_ADDR_G;
   constant ADC1_BASE_ADDR_C    : slv(31 downto 0) := X"0020_0000" + AXI_BASE_ADDR_G;
   constant ADC2_BASE_ADDR_C    : slv(31 downto 0) := X"0030_0000" + AXI_BASE_ADDR_G;
   constant LMK_BASE_ADDR_C     : slv(31 downto 0) := X"0040_0000" + AXI_BASE_ADDR_G;
   constant DAC_BASE_ADDR_C     : slv(31 downto 0) := X"0050_0000" + AXI_BASE_ADDR_G;
   constant ATT_0_BASE_ADDR_C   : slv(31 downto 0) := X"0060_0000" + AXI_BASE_ADDR_G;
   constant ATT_1_BASE_ADDR_C   : slv(31 downto 0) := X"0060_0010" + AXI_BASE_ADDR_G;
   constant ATT_2_BASE_ADDR_C   : slv(31 downto 0) := X"0060_0020" + AXI_BASE_ADDR_G;
   constant ATT_3_BASE_ADDR_C   : slv(31 downto 0) := X"0060_0030" + AXI_BASE_ADDR_G;
   constant SIG_GEN_BASE_ADDR_C : slv(31 downto 0) := X"0070_0000" + AXI_BASE_ADDR_G;

   --
   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := (
      JESD_INDEX_C    => (
         baseAddr     => JESD_BASE_ADDR_C,
         addrBits     => 20,
         connectivity => X"FFFF"),
      ADC_0_INDEX_C   => (
         baseAddr     => ADC0_BASE_ADDR_C,
         addrBits     => 20,
         connectivity => X"FFFF"),
      ADC_1_INDEX_C   => (
         baseAddr     => ADC1_BASE_ADDR_C,
         addrBits     => 20,
         connectivity => X"FFFF"),
      ADC_2_INDEX_C   => (
         baseAddr     => ADC2_BASE_ADDR_C,
         addrBits     => 20,
         connectivity => X"FFFF"),
      DAC_INDEX_C     => (
         baseAddr     => DAC_BASE_ADDR_C,
         addrBits     => 20,
         connectivity => X"FFFF"),
      LMK_INDEX_C     => (
         baseAddr     => LMK_BASE_ADDR_C,
         addrBits     => 20,
         connectivity => X"FFFF"),
      ATT_0_INDEX_C   => (
         baseAddr     => ATT_0_BASE_ADDR_C,
         addrBits     => 4,
         connectivity => X"FFFF"),
      ATT_1_INDEX_C   => (
         baseAddr     => ATT_1_BASE_ADDR_C,
         addrBits     => 4,
         connectivity => X"FFFF"),
      ATT_2_INDEX_C   => (
         baseAddr     => ATT_2_BASE_ADDR_C,
         addrBits     => 4,
         connectivity => X"FFFF"),
      ATT_3_INDEX_C   => (
         baseAddr     => ATT_3_BASE_ADDR_C,
         addrBits     => 4,
         connectivity => X"FFFF"),
      SIG_GEN_INDEX_C => (
         baseAddr     => SIG_GEN_BASE_ADDR_C,
         addrBits     => 20,
         connectivity => X"FFFF"));
   --
   signal writeMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal writeSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal readMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal readSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   --
   signal refClkDiv2   : sl;
   signal refClk       : sl;
   signal amcClk       : sl;
   signal amcRst       : sl;
   signal jesdClk      : sl;
   signal jesdRst      : sl;
   signal jesdClk2x    : sl;
   signal jesdRst2x    : sl;
   signal dlyRefClk    : sl;
   signal dlyRefRst    : sl;   

   signal jesdMmcmLocked : sl;
   signal jesdSysRef     : sl;
   signal jesdSync       : sl;

   -------------------------------------------------------------------------------------------------
   -- SPI
   -------------------------------------------------------------------------------------------------   
   constant NUM_COMMON_SPI_CHIPS_C : positive range 1 to 8 := 5;
   signal sclkVec                  : slv(NUM_COMMON_SPI_CHIPS_C-1 downto 0);
   signal doutVec                  : slv(NUM_COMMON_SPI_CHIPS_C-1 downto 0);
   signal csbVec                   : slv(NUM_COMMON_SPI_CHIPS_C-1 downto 0);

   signal muxSDin  : sl;
   signal muxSClk  : sl;
   signal muxSDout : sl;
   signal lmkSDin  : sl;

   -------------------------------------------------------------------------------------------------
   -- Attn Serial
   -------------------------------------------------------------------------------------------------   
   constant NUM_ATTN_CHIPS_C : positive range 1 to 8 := 4;
   signal attSclkVec         : slv(NUM_ATTN_CHIPS_C-1 downto 0);
   signal attDoutVec         : slv(NUM_ATTN_CHIPS_C-1 downto 0);
   signal attCsbVec          : slv(NUM_ATTN_CHIPS_C-1 downto 0);
   signal attLEnVec          : slv(NUM_ATTN_CHIPS_C-1 downto 0);

   signal attMuxSClk  : sl;
   signal attMuxSDout : sl;

   -------------------------------------------------------------------------------------------------
   -- LVDS DAC 
   -------------------------------------------------------------------------------------------------
   signal s_dacData    : slv(DAC_DATA_WIDTH_G-1 downto 0);
   signal s_dacDataDly : slv(DAC_DATA_WIDTH_G-1 downto 0);

   signal s_load         : slv(DAC_DATA_WIDTH_G-1 downto 0);
   signal s_tapDelaySet  : Slv9Array(DAC_DATA_WIDTH_G-1 downto 0);
   signal s_tapDelayStat : Slv9Array(DAC_DATA_WIDTH_G-1 downto 0);

------  
begin

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
         mAxiWriteMasters    => writeMasters,
         mAxiWriteSlaves     => writeSlaves,
         mAxiReadMasters     => readMasters,
         mAxiReadSlaves      => readSlaves);

   ----------------
   -- JESD Clocking
   ----------------
   U_IBUFDS_GTE3 : IBUFDS_GTE3
      generic map (
         REFCLK_EN_TX_PATH  => '0',
         REFCLK_HROW_CK_SEL => "00",    -- 2'b00: ODIV2 = O
         REFCLK_ICNTL_RX    => "00")
      port map (
         I     => jesdClkP,
         IB    => jesdClkN,
         CEB   => '0',
         ODIV2 => refClkDiv2,           -- 185 MHz, Frequency the same as jesdRefClk
         O     => refClk);              -- 185 MHz     

   U_BUFG_GT : BUFG_GT
      port map (
         I       => refClkDiv2,         -- 185 MHz
         CE      => '1',
         CLR     => '0',
         CEMASK  => '1',
         CLRMASK => '1',
         DIV     => "000",              -- Divide by 1
         O       => amcClk);            -- 185 MHz

   U_PwrUpRst : entity work.PwrUpRst
      generic map (
         TPD_G          => TPD_G,
         SIM_SPEEDUP_G  => SIMULATION_G,
         IN_POLARITY_G  => '1',
         OUT_POLARITY_G => '1')
      port map (
         clk    => amcClk,
         rstOut => amcRst);

   U_ClockManager : entity work.ClockManagerUltraScale
      generic map (
         TPD_G              => TPD_G,
         TYPE_G             => "MMCM",
         INPUT_BUFG_G       => false,
         FB_BUFG_G          => true,
         NUM_CLOCKS_G       => 3,
         BANDWIDTH_G        => "OPTIMIZED",
         CLKIN_PERIOD_G     => 5.698,
         DIVCLK_DIVIDE_G    => 1,
         CLKFBOUT_MULT_F_G  => 6.000,
         CLKOUT0_DIVIDE_F_G => 6.000,
         CLKOUT0_RST_HOLD_G => 16,
         CLKOUT1_DIVIDE_G   => 3,
         CLKOUT1_RST_HOLD_G => 32,
         CLKOUT2_DIVIDE_G   => 4,
         CLKOUT2_RST_HOLD_G => 32
         )
      port map (
         clkIn     => amcClk,
         rstIn     => amcRst,
         clkOut(0) => jesdClk,          -- 185 MHz
         clkOut(1) => jesdClk2x,        -- 370 MHz
         clkOut(2) => dlyRefClk,        -- 277.5 MHz         
         rstOut(0) => jesdRst,
         rstOut(1) => jesdRst2x,
         rstOut(2) => dlyRefRst,         
         locked    => jesdMmcmLocked);
   
   -- Clock out assignment
   adcClk   <= jesdClk;
   adcRst   <= jesdRst;
   adcClk2x <= jesdClk2x;
   adcRst2x <= jesdRst2x;
   
   -------------
   -- JESD block
   -------------
   U_Jesd : entity work.PlatformLlrfJesdBay1
      generic map (
         TPD_G            => TPD_G,
         TEST_G           => SIMULATION_G,
         SYSREF_GEN_G     => SIMULATION_G,
         AXI_ERROR_RESP_G => AXI_ERROR_RESP_G,
         -- F_G              => F_G,
         -- K_G              => K_G,
         L_RX_G           => L_RX_G)
      port map (
         stableClk      => axilClk,
         refClk         => refClk,
         -----------------------------------
         gtTxP          => jesdTxP,
         gtTxN          => jesdTxN,
         gtRxP          => jesdRxP,
         gtRxN          => jesdRxN,
         -----------------------------------
         devClk_i       => jesdClk,
         devClk2_i      => jesdClk,
         devRst_i       => jesdRst,
         devClkActive_i => jesdMmcmLocked,

         axilClk           => axilClk,
         axilRst           => axilRst,
         axilReadMasterRx  => readMasters(JESD_INDEX_C),
         axilReadSlaveRx   => readSlaves(JESD_INDEX_C),
         axilWriteMasterRx => writeMasters(JESD_INDEX_C),
         axilWriteSlaveRx  => writeSlaves(JESD_INDEX_C),

         sampleDataArr_o => adcValues,
         dataValidVec_o  => adcValids,
         sysRef_i        => jesdSysRef,
         nSync_o         => jesdSync);

   IBUFDS_SysRef : IBUFDS
      port map (
         I  => jesdSysRefP,
         IB => jesdSysRefN,
         O  => jesdSysRef);

   GEN_JESD_VEC :
   for i in L_RX_G/2-1 downto 0 generate
      U_OBUFDS : OBUFDS
         port map (
            I  => jesdSync,
            O  => jesdSyncP(i),
            OB => jesdSyncN(i));
   end generate GEN_JESD_VEC;

   ----------------------------------------------------------------
   -- SPI interface ADCs and LMK
   ----------------------------------------------------------------
   GEN_SPI_CHIPS : for I in 3 downto 0 generate
      U_AXI_SPI : entity work.AxiSpiMaster
         generic map (
            TPD_G             => TPD_G,
            ADDRESS_SIZE_G    => 15,
            DATA_SIZE_G       => 8,
            CLK_PERIOD_G      => 6.4E-9,
            SPI_SCLK_PERIOD_G => 100.0E-6)
         port map (
            axiClk         => axilClk,
            axiRst         => axilRst,
            axiReadMaster  => readMasters(ADC_0_INDEX_C+I),
            axiReadSlave   => readSlaves(ADC_0_INDEX_C+I),
            axiWriteMaster => writeMasters(ADC_0_INDEX_C+I),
            axiWriteSlave  => writeSlaves(ADC_0_INDEX_C+I),
            coreSclk       => sclkVec(I),
            coreSDin       => muxSDin,
            coreSDout      => doutVec(I),
            coreCsb        => csbVec(I));
   end generate GEN_SPI_CHIPS;

   ----------------------------------------------------------------
   -- SPI interface LVDS DAC
   ----------------------------------------------------------------
   U_AXI_SPI_DAC : entity work.AxiSpiMaster
      generic map (
         TPD_G             => TPD_G,
         ADDRESS_SIZE_G    => 7,
         DATA_SIZE_G       => 8,
         CLK_PERIOD_G      => 6.4E-9,
         SPI_SCLK_PERIOD_G => 100.0E-6)
      port map (
         axiClk         => axilClk,
         axiRst         => axilRst,
         axiReadMaster  => readMasters(DAC_INDEX_C),
         axiReadSlave   => readSlaves(DAC_INDEX_C),
         axiWriteMaster => writeMasters(DAC_INDEX_C),
         axiWriteSlave  => writeSlaves(DAC_INDEX_C),
         coreSclk       => sclkVec(4),
         coreSDin       => muxSDin,
         coreSDout      => doutVec(4),
         coreCsb        => csbVec(4));

   -- Input mux from "IO" port if LMK and from "I" port for ADCs 
   muxSDin <= lmkSDin when csbVec = "10111" else spiSdo_i;

   -- Output mux
   with csbVec select
      muxSclk <= sclkVec(0) when "11110",
      sclkVec(1)            when "11101",
      sclkVec(2)            when "11011",
      sclkVec(3)            when "10111",
      sclkVec(4)            when "01111",
      '0'                   when others;

   with csbVec select
      muxSDout <= doutVec(0) when "11110",
      doutVec(1)             when "11101",
      doutVec(2)             when "11011",
      doutVec(3)             when "10111",
      doutVec(4)             when "01111",
      '0'                    when others;
   -- Outputs 
   spiSclk_o <= muxSclk;
   spiSdi_o  <= muxSDout;

   ADC_SDIO_IOBUFT : IOBUF
      port map (
         I  => '0',
         O  => lmkSDin,
         IO => spiSdio_io,
         T  => muxSDout);

   -- Active low chip selects
   spiCsL_o <= csbVec;

   -----------------------------
   -- Serial Attenuator modules
   -----------------------------
   GEN_ATT_CHIPS : for I in NUM_ATTN_CHIPS_C-1 downto 0 generate
      U_ATT_SPI : entity work.AxiSerAttnMaster
         generic map (
            TPD_G             => TPD_G,
            AXI_ERROR_RESP_G  => AXI_ERROR_RESP_G,
            DATA_SIZE_G       => 6,
            CLK_PERIOD_G      => 6.4E-9,
            SPI_SCLK_PERIOD_G => 1.0E-6)  -- 10KHz
         port map (
            axiClk         => axilClk,
            axiRst         => axilRst,
            axiReadMaster  => readMasters(ATT_0_INDEX_C+I),
            axiReadSlave   => readSlaves(ATT_0_INDEX_C+I),
            axiWriteMaster => writeMasters(ATT_0_INDEX_C+I),
            axiWriteSlave  => writeSlaves(ATT_0_INDEX_C+I),
            coreSclk       => attSclkVec(I),
            coreSDin       => '0',
            coreSDout      => attDoutVec(I),
            coreCsb        => attCsbVec(I),
            coreLEn        => attLEnVec(I));
   end generate GEN_ATT_CHIPS;

   -- Output mux
   with attcsbVec select
      attMuxSclk <= attSclkVec(0) when "1110",
      attSclkVec(1)               when "1101",
      attSclkVec(2)               when "1011",
      attSclkVec(3)               when "0111",
      '0'                         when others;

   with attcsbVec select
      attMuxSDout <= attDoutVec(0) when "1110",
      attDoutVec(1)                when "1101",
      attDoutVec(2)                when "1011",
      attDoutVec(3)                when "0111",
      '0'                          when others;

   -- Outputs                   
   attSclk_o    <= attMuxSclk;
   attSdi_o     <= attMuxSDout;
   --attLatchEn_o   <= attCsbVec;
   attLatchEn_o <= attLEnVec;

   ---------------------------------------------------------
   -- LVDS DAC Signal generator one channel
   -- Clock domain jesdClk2x (~370MHz)
   ---------------------------------------------------------
   U_DAC_SIG_GEN : entity work.LvdsDacSigGen
      generic map (
         TPD_G            => TPD_G,
         AXI_BASE_ADDR_G  => SIG_GEN_BASE_ADDR_C,
         AXI_ERROR_RESP_G => AXI_ERROR_RESP_G,
         DATA_WIDTH_G     => DAC_DATA_WIDTH_G)
      port map (
         axiClk          => axilClk,
         axiRst          => axilRst,
         devClk2x_i      => jesdClk2x,
         devRst2x_i      => jesdRst2x,
         
         -- External dac port
         devClk_i        => extDacClk_i,
         devRst_i        => extDacRst_i,
         extData_i       => extDacValues_i,
         
         axilReadMaster  => readMasters(SIG_GEN_INDEX_C),
         axilReadSlave   => readSlaves(SIG_GEN_INDEX_C),
         axilWriteMaster => writeMasters(SIG_GEN_INDEX_C),
         axilWriteSlave  => writeSlaves(SIG_GEN_INDEX_C),
         -- Delay control
         load_o          => s_load,
         tapDelaySet_o   => s_tapDelaySet,
         tapDelayStat_i  => s_tapDelayStat,

         sampleData_o => s_dacData);
   
   GEN_DLY_OUT :
      for i in DAC_DATA_WIDTH_G-1 downto 0 generate
         OutputTapDelay_INST: entity work.OutputTapDelay
         generic map (
            TPD_G              => TPD_G,
            REFCLK_FREQUENCY_G => 370.0)
         port map (
            clk_i    => jesdClk2x,
            rst_i    => jesdRst2x,
            load_i   => s_load(i),
            tapSet_i => s_tapDelaySet(i),
            tapGet_o => s_tapDelayStat(i),
            data_i   => s_dacData(i),
            data_o   => s_dacDataDly(i));
   end generate GEN_DLY_OUT;

   GEN_LVDS_OUT :
   for I in DAC_DATA_WIDTH_G-1 downto 0 generate
      U_OBUFDS : OBUFDS
         port map (
            I  => s_dacDataDly(I),
            O  => dacDataP(I),
            OB => dacDataN(I));
   end generate GEN_LVDS_OUT;

   -- Samples on both edges of jesdClk (~185MHz). Sample rate = jesdClk2x (~370MHz)
   U_CLK_DIFF_BUF : entity work.ClkOutBufDiff
      generic map (
         TPD_G        => TPD_G,
         XIL_DEVICE_G => "ULTRASCALE")
      port map (
         rstIn   => jesdRst,
         clkIn   => jesdClk,
         clkOutP => dacDckP,
         clkOutN => dacDckN);

end mapping;
