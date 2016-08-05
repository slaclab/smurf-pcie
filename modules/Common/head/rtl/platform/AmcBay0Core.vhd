-------------------------------------------------------------------------------
-- Title      : AMC0 LLRF Module (SD-376-396-16)
-------------------------------------------------------------------------------
-- File       : AmcBay0Core.vhd
-- Author     : Uros Legat  <ulegat@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2015-12-07
-- Last update: 2016-03-11
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

entity AmcBay0Core is
   generic (
      TPD_G            : time             := 1 ns;
      SIMULATION_G     : boolean          := false;
      AXI_ERROR_RESP_G : slv(1 downto 0)  := AXI_RESP_DECERR_C;
      AXI_BASE_ADDR_G  : slv(31 downto 0) := (others => '0');

      -- Number of serial lanes: 1 to 16    
      L_RX_G : positive := 6
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
      dacValues       : in  Slv16Array(2 downto 0);
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

      -- ADC,LMK,SPI Ports
      spiSclk_o  : out   sl;
      spiSdi_o   : out   sl;
      spiSdo_i   : in    sl;
      spiSdio_io : inout sl;
      spiCsL_o   : out   Slv(3 downto 0);

      -- Attenuator serial ports
      attSclk_o    : out sl;
      attSdi_o     : out sl;
      attLatchEn_o : out slv(5 downto 0);

      -- SPI DAC ports
      dacSclk_o : out sl;
      dacSdi_o  : out sl;
      dacCsL_o  : out slv(2 downto 0)
      );
end AmcBay0Core;

architecture mapping of AmcBay0Core is

   constant NUM_AXI_MASTERS_C : natural := 15;

   constant JESD_INDEX_C    : natural := 0;
   constant ADC_0_INDEX_C   : natural := 1;
   constant ADC_1_INDEX_C   : natural := 2;
   constant ADC_2_INDEX_C   : natural := 3;
   constant LMK_INDEX_C     : natural := 4;
   constant ATT_0_INDEX_C   : natural := 5;
   constant ATT_1_INDEX_C   : natural := 6;
   constant ATT_2_INDEX_C   : natural := 7;
   constant ATT_3_INDEX_C   : natural := 8;
   constant ATT_4_INDEX_C   : natural := 9;
   constant ATT_5_INDEX_C   : natural := 10;
   constant DAC_0_INDEX_C   : natural := 11;
   constant DAC_1_INDEX_C   : natural := 12;
   constant DAC_2_INDEX_C   : natural := 13;
   constant DAC_MUX_INDEX_C : natural := 14;

   constant JESD_BASE_ADDR_C    : slv(31 downto 0) := X"0000_0000" + AXI_BASE_ADDR_G;
   constant ADC0_BASE_ADDR_C    : slv(31 downto 0) := X"0010_0000" + AXI_BASE_ADDR_G;
   constant ADC1_BASE_ADDR_C    : slv(31 downto 0) := X"0020_0000" + AXI_BASE_ADDR_G;
   constant ADC2_BASE_ADDR_C    : slv(31 downto 0) := X"0030_0000" + AXI_BASE_ADDR_G;
   constant LMK_BASE_ADDR_C     : slv(31 downto 0) := X"0040_0000" + AXI_BASE_ADDR_G;
   constant ATT_0_BASE_ADDR_C   : slv(31 downto 0) := X"0050_0000" + AXI_BASE_ADDR_G;
   constant ATT_1_BASE_ADDR_C   : slv(31 downto 0) := X"0050_0010" + AXI_BASE_ADDR_G;
   constant ATT_2_BASE_ADDR_C   : slv(31 downto 0) := X"0050_0020" + AXI_BASE_ADDR_G;
   constant ATT_3_BASE_ADDR_C   : slv(31 downto 0) := X"0050_0030" + AXI_BASE_ADDR_G;
   constant ATT_4_BASE_ADDR_C   : slv(31 downto 0) := X"0050_0040" + AXI_BASE_ADDR_G;
   constant ATT_5_BASE_ADDR_C   : slv(31 downto 0) := X"0050_0050" + AXI_BASE_ADDR_G;
   constant DAC_0_BASE_ADDR_C   : slv(31 downto 0) := X"0060_0000" + AXI_BASE_ADDR_G;
   constant DAC_1_BASE_ADDR_C   : slv(31 downto 0) := X"0060_0010" + AXI_BASE_ADDR_G;
   constant DAC_2_BASE_ADDR_C   : slv(31 downto 0) := X"0060_0020" + AXI_BASE_ADDR_G;
   constant DAC_MUX_BASE_ADDR_C : slv(31 downto 0) := X"0060_0030" + AXI_BASE_ADDR_G;

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
      ATT_4_INDEX_C   => (
         baseAddr     => ATT_4_BASE_ADDR_C,
         addrBits     => 4,
         connectivity => X"FFFF"),
      ATT_5_INDEX_C   => (
         baseAddr     => ATT_5_BASE_ADDR_C,
         addrBits     => 4,
         connectivity => X"FFFF"),
      DAC_0_INDEX_C   => (
         baseAddr     => DAC_0_BASE_ADDR_C,
         addrBits     => 4,
         connectivity => X"FFFF"),
      DAC_1_INDEX_C   => (
         baseAddr     => DAC_1_BASE_ADDR_C,
         addrBits     => 4,
         connectivity => X"FFFF"),
      DAC_2_INDEX_C   => (
         baseAddr     => DAC_2_BASE_ADDR_C,
         addrBits     => 4,
         connectivity => X"FFFF"),
      DAC_MUX_INDEX_C => (
         baseAddr     => DAC_MUX_BASE_ADDR_C,
         addrBits     => 4,
         connectivity => X"FFFF"));  

   signal writeMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal writeSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal readMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal readSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

   signal refClkDiv2     : sl;
   signal refClk         : sl;
   signal amcClk         : sl;
   signal amcRst         : sl;
   signal jesdClk        : sl;
   signal jesdRst        : sl;
   signal jesdClk2x      : sl;
   signal jesdRst2x      : sl;
   signal jesdMmcmLocked : sl;
   signal jesdSysRef     : sl;
   signal jesdSync       : sl;

   -------------------------------------------------------------------------------------------------
   -- SPI
   -------------------------------------------------------------------------------------------------   
   constant NUM_COMMON_SPI_CHIPS_C : positive range 1 to 8 := 4;
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
   constant NUM_ATTN_CHIPS_C : positive range 1 to 8 := 6;
   signal attSclkVec         : slv(NUM_ATTN_CHIPS_C-1 downto 0);
   signal attDoutVec         : slv(NUM_ATTN_CHIPS_C-1 downto 0);
   signal attCsbVec          : slv(NUM_ATTN_CHIPS_C-1 downto 0);
   signal attLEnVec          : slv(NUM_ATTN_CHIPS_C-1 downto 0);
   signal attMuxSClk         : sl;
   signal attMuxSDout        : sl;

   -------------------------------------------------------------------------------------------------
   -- DAC SPI
   -------------------------------------------------------------------------------------------------   
   constant NUM_DAC_CHIPS_C : positive range 1 to 8 := 3;
   signal dacSclkVec        : slv(NUM_DAC_CHIPS_C-1 downto 0);
   signal dacDoutVec        : slv(NUM_DAC_CHIPS_C-1 downto 0);
   signal dacCsbVec         : slv(NUM_DAC_CHIPS_C-1 downto 0);
   signal dacMuxSClk        : sl;
   signal dacMuxSDout       : sl;

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

   -- 
   U_ClockManager : entity work.ClockManagerUltraScale
   generic map (
      TPD_G              => TPD_G,
      TYPE_G             => "MMCM",
      INPUT_BUFG_G       => false,
      FB_BUFG_G          => true,
      NUM_CLOCKS_G       => 2,
      BANDWIDTH_G        => "OPTIMIZED",
      CLKIN_PERIOD_G     => 5.698,
      DIVCLK_DIVIDE_G    => 1,
      CLKFBOUT_MULT_F_G  => 6.000,
      CLKOUT0_DIVIDE_F_G => 6.000,
      CLKOUT0_RST_HOLD_G => 16,
      CLKOUT1_DIVIDE_G => 3,
      CLKOUT1_RST_HOLD_G => 32        
   )
   port map (
      clkIn     => amcClk,
      rstIn     => amcRst,
      clkOut(0) => jesdClk,   -- 185 MHz
      clkOut(1) => jesdClk2x, -- 370 MHz    
      rstOut(0) => jesdRst,
      rstOut(1) => jesdRst2x,         
      locked    => jesdMmcmLocked
   );

   -- Clock out assignment
   adcClk   <= jesdClk;
   adcRst   <= jesdRst;
   adcClk2x <= jesdClk2x;
   adcRst2x <= jesdRst2x;

   -------------
   -- JESD block
   -------------
   U_Jesd : entity work.PlatformLlrfJesdBay0
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

   GEN_VEC :
   for i in L_RX_G/2-1 downto 0 generate
      U_OBUFDS : OBUFDS
         port map (
            I  => jesdSync,
            O  => jesdSyncP(i),
            OB => jesdSyncN(i));
   end generate GEN_VEC;

   ----------------------------------------------------------------
   -- SPI interface ADCs and LMK 
   ----------------------------------------------------------------
   GEN_SPI_CHIPS : for I in NUM_COMMON_SPI_CHIPS_C-1 downto 0 generate
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
            axiReadMaster  => readMasters(ADC_0_INDEX_C+I),
            axiReadSlave   => readSlaves(ADC_0_INDEX_C+I),
            axiWriteMaster => writeMasters(ADC_0_INDEX_C+I),
            axiWriteSlave  => writeSlaves(ADC_0_INDEX_C+I),
            coreSclk       => sclkVec(I),
            coreSDin       => muxSDin,
            coreSDout      => doutVec(I),
            coreCsb        => csbVec(I));
   end generate GEN_SPI_CHIPS;

   -- Input mux from "IO" port if LMK and from "I" port for ADCs 
   muxSDin <= lmkSDin when csbVec = "0111" else spiSdo_i;

   -- Output mux
   with csbVec select
      muxSclk <= sclkVec(0) when "1110",
      sclkVec(1)            when "1101",
      sclkVec(2)            when "1011",
      sclkVec(3)            when "0111",
      '0'                   when others;

   with csbVec select
      muxSDout <= doutVec(0) when "1110",
      doutVec(1)             when "1101",
      doutVec(2)             when "1011",
      doutVec(3)             when "0111",
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
      AxiSerAttnMaster_INST : entity work.AxiSerAttnMaster
         generic map (
            TPD_G             => TPD_G,
            AXI_ERROR_RESP_G  => AXI_ERROR_RESP_G,
            DATA_SIZE_G       => 6,
            CLK_PERIOD_G      => 6.4E-9,
            SPI_SCLK_PERIOD_G => 1.0E-6)  -- 1MHz
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
   with attCsbVec select
      attMuxSclk <= attSclkVec(0) when "111110",
      attSclkVec(1)               when "111101",
      attSclkVec(2)               when "111011",
      attSclkVec(3)               when "110111",
      attSclkVec(4)               when "101111",
      attSclkVec(5)               when "011111",
      '0'                         when others;

   with attCsbVec select
      attMuxSDout <= attDoutVec(0) when "111110",
      attDoutVec(1)                when "111101",
      attDoutVec(2)                when "111011",
      attDoutVec(3)                when "110111",
      attDoutVec(4)                when "101111",
      attDoutVec(5)                when "011111",
      '0'                          when others;

   -- Outputs                   
   attSclk_o    <= attMuxSclk;
   attSdi_o     <= attMuxSDout;
   attLatchEn_o <= attLEnVec;

   -----------------------------
   -- SPI DAC modules
   -----------------------------
   GEN_DAC_CHIPS : for I in NUM_DAC_CHIPS_C-1 downto 0 generate
      AxiSerAttnMaster_INST : entity work.AxiSerAttnMaster
         generic map (
            TPD_G             => TPD_G,
            AXI_ERROR_RESP_G  => AXI_ERROR_RESP_G,
            DATA_SIZE_G       => 16,
            CLK_PERIOD_G      => 6.4E-9,
            SPI_SCLK_PERIOD_G => 1.0E-6)  -- 1MHz
         port map (
            axiClk         => axilClk,
            axiRst         => axilRst,
            axiReadMaster  => readMasters(DAC_0_INDEX_C+I),
            axiReadSlave   => readSlaves(DAC_0_INDEX_C+I),
            axiWriteMaster => writeMasters(DAC_0_INDEX_C+I),
            axiWriteSlave  => writeSlaves(DAC_0_INDEX_C+I),
            coreSclk       => dacSclkVec(I),
            coreSDin       => '0',
            coreSDout      => dacDoutVec(I),
            coreCsb        => dacCsbVec(I),
            coreLEn        => open);
   end generate GEN_DAC_CHIPS;

   -- Output mux
   with dacCsbVec select
      dacMuxSclk <= dacSclkVec(0) when "110",
      dacSclkVec(1)               when "101",
      dacSclkVec(2)               when "011",
      '0'                         when others;

   with dacCsbVec select
      dacMuxSDout <= dacDoutVec(0) when "110",
      dacDoutVec(1)                when "101",
      dacDoutVec(2)                when "011",
      '0'                          when others;
   
   U_Dac : entity work.AmcBay0DacMux
      generic map (
         TPD_G            => TPD_G,
         AXI_ERROR_RESP_G => AXI_ERROR_RESP_G)
      port map (
         -- AXI-Lite Interface
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => readMasters(DAC_MUX_INDEX_C),
         axilReadSlave   => readSlaves(DAC_MUX_INDEX_C),
         axilWriteMaster => writeMasters(DAC_MUX_INDEX_C),
         axilWriteSlave  => writeSlaves(DAC_MUX_INDEX_C),
         -- External AXI-Module interface
         clk             => jesdClk,
         rst             => jesdRst,
         dacValues       => dacValues,
         dacSclk_i       => dacMuxSclk,
         dacSdi_i        => dacMuxSDout,
         dacCsL_i        => dacCsbVec,
         -- Slow DAC's SPI Ports
         dacSclk_o       => dacSclk_o,
         dacSdi_o        => dacSdi_o,
         dacCsL_o        => dacCsL_o);

end mapping;
