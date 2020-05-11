-------------------------------------------------------------------------------
-- File       : SmurfSlacPgpCardG4RssiOffload10GbE.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- DMA Mapping:
--
--    DMA[Lane=0][TDEST=udpObDest]: UDP[Lane=0]
--    DMA[Lane=1][TDEST=udpObDest]: UDP[Lane=1]
--    DMA[Lane=2][TDEST=udpObDest]: UDP[Lane=2]
--    DMA[Lane=3][TDEST=udpObDest]: UDP[Lane=3]
--    DMA[Lane=4][TDEST=udpObDest]: UDP[Lane=4]
--    DMA[Lane=5][TDEST=udpObDest]: UDP[Lane=5]
--
--    DMA[Lane=6][TDEST=0x00:0x07]: RSSI[Lane=0][TDEST=0x00:0x07]
--    DMA[Lane=6][TDEST=0x08:0x0F]: RSSI[Lane=0][TDEST=0x80:0x87]
--
--    DMA[Lane=6][TDEST=0x10:0x17]: RSSI[Lane=1][TDEST=0x00:0x07]
--    DMA[Lane=6][TDEST=0x18:0x1F]: RSSI[Lane=1][TDEST=0x80:0x87]
--
--    DMA[Lane=6][TDEST=0x20:0x27]: RSSI[Lane=2][TDEST=0x00:0x07]
--    DMA[Lane=6][TDEST=0x28:0x2F]: RSSI[Lane=2][TDEST=0x80:0x87]
--
--    DMA[Lane=6][TDEST=0x30:0x37]: RSSI[Lane=3][TDEST=0x00:0x07]
--    DMA[Lane=6][TDEST=0x38:0x3F]: RSSI[Lane=3][TDEST=0x80:0x87]
--
--    DMA[Lane=6][TDEST=0x40:0x47]: RSSI[Lane=4][TDEST=0x00:0x07]
--    DMA[Lane=6][TDEST=0x48:0x4F]: RSSI[Lane=4][TDEST=0x80:0x87]
--
--    DMA[Lane=6][TDEST=0x50:0x57]: RSSI[Lane=5][TDEST=0x00:0x07]
--    DMA[Lane=6][TDEST=0x58:0x5F]: RSSI[Lane=5][TDEST=0x80:0x87]
--
-------------------------------------------------------------------------------
-- Note: udpObDest default is 0xC1 (refer to UdpDebug.vhd)
-------------------------------------------------------------------------------
-- This file is part of 'SMURF PCIE'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'SMURF PCIE', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiLitePkg.all;
use surf.AxiStreamPkg.all;

library axi_pcie_core;

use work.AppPkg.all;

library unisim;
use unisim.vcomponents.all;

entity SmurfSlacPgpCardG4RssiOffload10GbE is
   generic (
      TPD_G        : time := 1 ns;
      BUILD_INFO_G : BuildInfoType);
   port (
      ---------------------
      --  Application Ports
      ---------------------
      -- QSFP[1:0] Ports
      qsfpRefClkP : in  sl;
      qsfpRefClkN : in  sl;
      qsfp0RxP    : in  slv(3 downto 0);
      qsfp0RxN    : in  slv(3 downto 0);
      qsfp0TxP    : out slv(3 downto 0);
      qsfp0TxN    : out slv(3 downto 0);
      qsfp1RxP    : in  slv(3 downto 0);
      qsfp1RxN    : in  slv(3 downto 0);
      qsfp1TxP    : out slv(3 downto 0);
      qsfp1TxN    : out slv(3 downto 0);
      --------------
      --  Core Ports
      --------------
      -- System Ports
      emcClk      : in  sl;
      -- Boot Memory Ports 
      flashCsL    : out sl;
      flashMosi   : out sl;
      flashMiso   : in  sl;
      flashHoldL  : out sl;
      flashWp     : out sl;
      -- PCIe Ports
      pciRstL     : in  sl;
      pciRefClkP  : in  sl;
      pciRefClkN  : in  sl;
      pciRxP      : in  slv(7 downto 0);
      pciRxN      : in  slv(7 downto 0);
      pciTxP      : out slv(7 downto 0);
      pciTxN      : out slv(7 downto 0));
end SmurfSlacPgpCardG4RssiOffload10GbE;

architecture top_level of SmurfSlacPgpCardG4RssiOffload10GbE is

   constant CLK_FREQUENCY_C : real := 156.25E+6;  -- units of Hz

   constant NUM_AXIL_MASTERS_C : natural := 5;

   constant AXIL_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXIL_MASTERS_C-1 downto 0) := (
      0               => (
         baseAddr     => x"0008_0000",
         addrBits     => 19,
         connectivity => x"FFFF"),
      1               => (
         baseAddr     => x"0010_0000",
         addrBits     => 20,
         connectivity => x"FFFF"),
      2               => (
         baseAddr     => x"0020_0000",
         addrBits     => 21,
         connectivity => x"FFFF"),
      3               => (
         baseAddr     => x"0040_0000",
         addrBits     => 22,
         connectivity => x"FFFF"),
      4               => (
         baseAddr     => x"0080_0000",
         addrBits     => 23,
         connectivity => x"FFFF"));


   signal axilReadMaster  : AxiLiteReadMasterType;
   signal axilReadSlave   : AxiLiteReadSlaveType;
   signal axilWriteMaster : AxiLiteWriteMasterType;
   signal axilWriteSlave  : AxiLiteWriteSlaveType;

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXIL_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXIL_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXIL_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXIL_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

   signal axilClk   : sl;
   signal axilRst   : sl;
   signal axilReset : sl;

   signal dmaClk       : sl;
   signal dmaRst       : sl;
   signal dmaObMasters : AxiStreamMasterArray(NUM_RSSI_C downto 0);
   signal dmaObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C downto 0);
   signal dmaIbMasters : AxiStreamMasterArray(NUM_RSSI_C downto 0);
   signal dmaIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C downto 0);

begin

   -----------------------
   -- AXI-Lite Clock/Reset
   -----------------------
   U_axilClk : entity surf.ClockManagerUltraScale
      generic map(
         TPD_G             => TPD_G,
         TYPE_G            => "PLL",
         INPUT_BUFG_G      => true,
         FB_BUFG_G         => true,
         RST_IN_POLARITY_G => '1',
         NUM_CLOCKS_G      => 1,
         -- MMCM attributes
         BANDWIDTH_G       => "OPTIMIZED",
         CLKIN_PERIOD_G    => 4.0,      -- 250 MHz
         CLKFBOUT_MULT_G   => 5,        -- 1.25GHz = 5 x 250 MHz
         CLKOUT0_DIVIDE_G  => 8)        -- 156.25MHz = 1.25GHz/8
      port map(
         -- Clock Input
         clkIn     => dmaClk,
         rstIn     => dmaRst,
         -- Clock Outputs
         clkOut(0) => axilClk,
         -- Reset Outputs
         rstOut(0) => axilReset);

   U_axilRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axilClk,
         rstIn  => axilReset,
         rstOut => axilRst);

   ---------------------
   -- PCIE/DMA Interface
   ---------------------
   U_Core : entity axi_pcie_core.SlacPgpCardG4Core
      generic map (
         TPD_G             => TPD_G,
         BUILD_INFO_G      => BUILD_INFO_G,
         DMA_AXIS_CONFIG_G => APP_AXIS_CONFIG_C,
         DMA_SIZE_G        => NUM_RSSI_C+1)
      port map (
         ------------------------      
         --  Top Level Interfaces
         ------------------------        
         -- DMA Interfaces
         dmaClk         => dmaClk,
         dmaRst         => dmaRst,
         dmaObMasters   => dmaObMasters,
         dmaObSlaves    => dmaObSlaves,
         dmaIbMasters   => dmaIbMasters,
         dmaIbSlaves    => dmaIbSlaves,
         -- AXI-Lite Interface
         appClk         => axilClk,
         appRst         => axilRst,
         appReadMaster  => axilReadMaster,
         appReadSlave   => axilReadSlave,
         appWriteMaster => axilWriteMaster,
         appWriteSlave  => axilWriteSlave,
         --------------
         --  Core Ports
         --------------   
         -- System Ports
         emcClk         => emcClk,
         -- Boot Memory Ports 
         flashCsL       => flashCsL,
         flashMosi      => flashMosi,
         flashMiso      => flashMiso,
         flashHoldL     => flashHoldL,
         flashWp        => flashWp,
         -- PCIe Ports 
         pciRstL        => pciRstL,
         pciRefClkP     => pciRefClkP,
         pciRefClkN     => pciRefClkN,
         pciRxP         => pciRxP,
         pciRxN         => pciRxN,
         pciTxP         => pciTxP,
         pciTxN         => pciTxN);

   ----------------
   -- AXI-Lite XBAR
   ----------------
   U_XBAR : entity surf.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 1,
         NUM_MASTER_SLOTS_G => NUM_AXIL_MASTERS_C,
         MASTERS_CONFIG_G   => AXIL_CONFIG_C)
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

   ------------------
   -- RSSI/ETH Module
   ------------------
   U_Hardware : entity work.Hardware
      generic map (
         TPD_G           => TPD_G,
         CLK_FREQUENCY_G => CLK_FREQUENCY_C,
         AXI_BASE_ADDR_G => AXIL_CONFIG_C(4).baseAddr)
      port map (
         ------------------------      
         --  Top Level Interfaces
         ------------------------         
         -- AXI-Lite Interface (axilClk domain)
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMasters(4),
         axilReadSlave   => axilReadSlaves(4),
         axilWriteMaster => axilWriteMasters(4),
         axilWriteSlave  => axilWriteSlaves(4),
         -- DMA Interface (dmaClk domain)
         dmaClk          => dmaClk,
         dmaRst          => dmaRst,
         dmaObMasters    => dmaObMasters,
         dmaObSlaves     => dmaObSlaves,
         dmaIbMasters    => dmaIbMasters,
         dmaIbSlaves     => dmaIbSlaves,
         ------------------
         --  Hardware Ports
         ------------------       
         -- QSFP[1:0] Ports
         qsfpRefClkP     => qsfpRefClkP,
         qsfpRefClkN     => qsfpRefClkN,
         qsfp0RxP        => qsfp0RxP,
         qsfp0RxN        => qsfp0RxN,
         qsfp0TxP        => qsfp0TxP,
         qsfp0TxN        => qsfp0TxN,
         qsfp1RxP        => qsfp1RxP,
         qsfp1RxN        => qsfp1RxN,
         qsfp1TxP        => qsfp1TxP,
         qsfp1TxN        => qsfp1TxN);

end top_level;
