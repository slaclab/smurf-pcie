-------------------------------------------------------------------------------
-- File       : SmurfKcu1500RssiOffload10GbE.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- This file is part of 'axi-pcie-dev'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'axi-pcie-dev', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiPkg.all;
use surf.AxiLitePkg.all;
use surf.AxiStreamPkg.all;
use surf.SsiPkg.all;

library axi_pcie_core;
use axi_pcie_core.MigPkg.all;

use work.AppPkg.all;

entity SmurfKcu1500RssiOffload10GbE is
   generic (
      TPD_G        : time := 1 ns;
      BUILD_INFO_G : BuildInfoType);
   port (
      ---------------------
      --  Application Ports
      ---------------------
      -- QSFP[0] Ports
      qsfp0RefClkP  : in    slv(1 downto 0);
      qsfp0RefClkN  : in    slv(1 downto 0);
      qsfp0RxP      : in    slv(3 downto 0);
      qsfp0RxN      : in    slv(3 downto 0);
      qsfp0TxP      : out   slv(3 downto 0);
      qsfp0TxN      : out   slv(3 downto 0);
      -- QSFP[1] Ports
      qsfp1RefClkP  : in    slv(1 downto 0);
      qsfp1RefClkN  : in    slv(1 downto 0);
      qsfp1RxP      : in    slv(3 downto 0);
      qsfp1RxN      : in    slv(3 downto 0);
      qsfp1TxP      : out   slv(3 downto 0);
      qsfp1TxN      : out   slv(3 downto 0);
      -- DDR Ports
      ddrClkP       : in    slv(3 downto 0);
      ddrClkN       : in    slv(3 downto 0);
      ddrOut        : out   DdrOutArray(3 downto 0);
      ddrInOut      : inout DdrInOutArray(3 downto 0);
      --------------
      --  Core Ports
      --------------
      -- System Ports
      emcClk        : in    sl;
      userClkP      : in    sl;
      userClkN      : in    sl;
      -- QSFP[0] Ports
      qsfp0RstL     : out   sl;
      qsfp0LpMode   : out   sl;
      qsfp0ModSelL  : out   sl;
      qsfp0ModPrsL  : in    sl;
      -- QSFP[1] Ports
      qsfp1RstL     : out   sl;
      qsfp1LpMode   : out   sl;
      qsfp1ModSelL  : out   sl;
      qsfp1ModPrsL  : in    sl;
      -- Boot Memory Ports 
      flashCsL      : out   sl;
      flashMosi     : out   sl;
      flashMiso     : in    sl;
      flashHoldL    : out   sl;
      flashWp       : out   sl;
      -- PCIe Ports
      pciRstL       : in    sl;
      pciRefClkP    : in    sl;
      pciRefClkN    : in    sl;
      pciRxP        : in    slv(7 downto 0);
      pciRxN        : in    slv(7 downto 0);
      pciTxP        : out   slv(7 downto 0);
      pciTxN        : out   slv(7 downto 0);
      -- Extended PCIe Ports 
      pciExtRefClkP : in    sl;
      pciExtRefClkN : in    sl;
      pciExtRxP     : in    slv(7 downto 0);
      pciExtRxN     : in    slv(7 downto 0);
      pciExtTxP     : out   slv(7 downto 0);
      pciExtTxN     : out   slv(7 downto 0));
end SmurfKcu1500RssiOffload10GbE;

architecture top_level of SmurfKcu1500RssiOffload10GbE is

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

   signal bar0WriteMasters : AxiLiteWriteMasterArray(1 downto 0);
   signal bar0WriteSlaves  : AxiLiteWriteSlaveArray(1 downto 0) := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal bar0ReadMasters  : AxiLiteReadMasterArray(1 downto 0);
   signal bar0ReadSlaves   : AxiLiteReadSlaveArray(1 downto 0)  := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXIL_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXIL_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXIL_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXIL_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

   signal userClk156 : sl;
   signal axilClk    : sl;
   signal axilRst    : sl;
   signal axilReset  : sl;

   signal dmaPriClk       : sl;
   signal dmaPriRst       : sl;
   signal dmaPriObMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal dmaPriObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal dmaPriIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal dmaPriIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal dmaSecClk       : sl;
   signal dmaSecRst       : sl;
   signal dmaSecObMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal dmaSecObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal dmaSecIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal dmaSecIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal axiClk          : sl;
   signal axiRst          : sl;
   signal axiReset        : sl;
   signal ddrClk          : slv((NUM_RSSI_C/2)-1 downto 0);
   signal ddrRst          : slv((NUM_RSSI_C/2)-1 downto 0);
   signal ddrWriteMasters : AxiWriteMasterArray((NUM_RSSI_C/2)-1 downto 0);
   signal ddrWriteSlaves  : AxiWriteSlaveArray((NUM_RSSI_C/2)-1 downto 0);
   signal ddrReadMasters  : AxiReadMasterArray((NUM_RSSI_C/2)-1 downto 0);
   signal ddrReadSlaves   : AxiReadSlaveArray((NUM_RSSI_C/2)-1 downto 0);

begin

   -----------------------
   -- AXI-Lite Clock/Reset
   -----------------------
   U_axilClk : entity surf.ClockManagerUltraScale
      generic map(
         TPD_G              => TPD_G,
         TYPE_G             => "MMCM",
         INPUT_BUFG_G       => true,
         FB_BUFG_G          => true,
         RST_IN_POLARITY_G  => '1',
         NUM_CLOCKS_G       => 2,
         -- MMCM attributes
         CLKIN_PERIOD_G     => 6.4,     -- 156.25 MHz
         CLKFBOUT_MULT_G    => 8,       -- 1.25GHz = 8 x 156.25 MHz
         -- CLKOUT0_DIVIDE_F_G => 10.0,  -- 125 MHz (125 MHz x 128b = 16.0Gb/s > 10GbE)
         CLKOUT0_DIVIDE_F_G => 12.5,  -- 100 MHz (100 MHz x 128b = 12.8Gb/s > 10GbE)
         CLKOUT1_DIVIDE_G   => 8)  -- 156.25 MHz (must match CLK_FREQUENCY_C)
      port map(
         -- Clock Input
         clkIn     => userClk156,
         rstIn     => dmaPriRst,
         -- Clock Outputs
         clkOut(0) => axiClk,
         clkOut(1) => axilClk,
         -- Reset Outputs
         rstOut(0) => axiRst,
         rstOut(1) => axilRst);

   U_axiRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axiClk,
         rstIn  => axiRst,
         rstOut => axiReset);

   U_axilRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axilClk,
         rstIn  => axilRst,
         rstOut => axilReset);

   -----------------
   -- MIG[0] IP Core
   -----------------         
   U_Mig0 : entity axi_pcie_core.Mig0
      generic map (
         TPD_G => TPD_G)
      port map (
         extRst         => dmaPriRst,
         -- AXI MEM Interface
         axiClk         => ddrClk(2),
         axiRst         => ddrRst(2),
         axiWriteMaster => ddrWriteMasters(2),
         axiWriteSlave  => ddrWriteSlaves(2),
         axiReadMaster  => ddrReadMasters(2),
         axiReadSlave   => ddrReadSlaves(2),
         -- DDR Ports
         ddrClkP        => ddrClkP(0),
         ddrClkN        => ddrClkN(0),
         ddrOut         => ddrOut(0),
         ddrInOut       => ddrInOut(0));

   -----------------
   -- MIG[2] IP Core
   -----------------         
   U_Mig2 : entity axi_pcie_core.Mig2
      generic map (
         TPD_G => TPD_G)
      port map (
         extRst         => dmaPriRst,
         -- AXI MEM Interface
         axiClk         => ddrClk(1),
         axiRst         => ddrRst(1),
         axiWriteMaster => ddrWriteMasters(1),
         axiWriteSlave  => ddrWriteSlaves(1),
         axiReadMaster  => ddrReadMasters(1),
         axiReadSlave   => ddrReadSlaves(1),
         -- DDR Ports
         ddrClkP        => ddrClkP(2),
         ddrClkN        => ddrClkN(2),
         ddrOut         => ddrOut(2),
         ddrInOut       => ddrInOut(2));

   -----------------
   -- MIG[3] IP Core
   -----------------
   U_Mig3 : entity axi_pcie_core.Mig3
      generic map (
         TPD_G => TPD_G)
      port map (
         extRst         => dmaPriRst,
         -- AXI MEM Interface 
         axiClk         => ddrClk(0),
         axiRst         => ddrRst(0),
         axiWriteMaster => ddrWriteMasters(0),
         axiWriteSlave  => ddrWriteSlaves(0),
         axiReadMaster  => ddrReadMasters(0),
         axiReadSlave   => ddrReadSlaves(0),
         -- DDR Ports
         ddrClkP        => ddrClkP(3),
         ddrClkN        => ddrClkN(3),
         ddrOut         => ddrOut(3),
         ddrInOut       => ddrInOut(3));

   ---------------------
   -- PCIE/DMA Interface
   ---------------------
   U_Core : entity axi_pcie_core.XilinxKcu1500Core
      generic map (
         TPD_G             => TPD_G,
         BUILD_INFO_G      => BUILD_INFO_G,
         DMA_AXIS_CONFIG_G => APP_AXIS_CONFIG_C,
         DMA_SIZE_G        => NUM_RSSI_C)
      port map (
         ------------------------      
         --  Top Level Interfaces
         ------------------------        
         userClk156     => userClk156,
         -- DMA Interfaces
         dmaClk         => dmaPriClk,
         dmaRst         => dmaPriRst,
         dmaObMasters   => dmaPriObMasters,
         dmaObSlaves    => dmaPriObSlaves,
         dmaIbMasters   => dmaPriIbMasters,
         dmaIbSlaves    => dmaPriIbSlaves,
         -- Application AXI-Lite Interfaces [0x00080000:0x00FFFFFF] (appClk domain)
         appClk         => axilClk,
         appRst         => axilReset,
         appReadMaster  => bar0ReadMasters(0),
         appReadSlave   => bar0ReadSlaves(0),
         appWriteMaster => bar0WriteMasters(0),
         appWriteSlave  => bar0WriteSlaves(0),
         --------------
         --  Core Ports
         --------------   
         -- System Ports
         emcClk         => emcClk,
         userClkP       => userClkP,
         userClkN       => userClkN,
         -- QSFP[0] Ports
         qsfp0RstL      => qsfp0RstL,
         qsfp0LpMode    => qsfp0LpMode,
         qsfp0ModSelL   => qsfp0ModSelL,
         qsfp0ModPrsL   => qsfp0ModPrsL,
         -- QSFP[1] Ports
         qsfp1RstL      => qsfp1RstL,
         qsfp1LpMode    => qsfp1LpMode,
         qsfp1ModSelL   => qsfp1ModSelL,
         qsfp1ModPrsL   => qsfp1ModPrsL,
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

   U_ExtendedCore : entity axi_pcie_core.XilinxKcu1500PcieExtendedCore
      generic map (
         TPD_G             => TPD_G,
         BUILD_INFO_G      => BUILD_INFO_G,
         DMA_AXIS_CONFIG_G => APP_AXIS_CONFIG_C,
         DMA_SIZE_G        => NUM_RSSI_C)
      port map (
         ------------------------      
         --  Top Level Interfaces
         ------------------------        
         -- DMA Interfaces
         dmaClk         => dmaSecClk,
         dmaRst         => dmaSecRst,
         dmaObMasters   => dmaSecObMasters,
         dmaObSlaves    => dmaSecObSlaves,
         dmaIbMasters   => dmaSecIbMasters,
         dmaIbSlaves    => dmaSecIbSlaves,
         -- Application AXI-Lite Interfaces [0x00080000:0x00FFFFFF] (appClk domain)
         appClk         => axilClk,
         appRst         => axilReset,
         appReadMaster  => bar0ReadMasters(1),
         appReadSlave   => bar0ReadSlaves(1),
         appWriteMaster => bar0WriteMasters(1),
         appWriteSlave  => bar0WriteSlaves(1),
         --------------
         --  Core Ports
         --------------   
         -- Extended PCIe Ports 
         pciRstL        => pciRstL,
         pciExtRefClkP  => pciExtRefClkP,
         pciExtRefClkN  => pciExtRefClkN,
         pciExtRxP      => pciExtRxP,
         pciExtRxN      => pciExtRxN,
         pciExtTxP      => pciExtTxP,
         pciExtTxN      => pciExtTxN);

   ----------------
   -- AXI-Lite XBAR
   ----------------
   U_XBAR : entity surf.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 2,
         NUM_MASTER_SLOTS_G => NUM_AXIL_MASTERS_C,
         MASTERS_CONFIG_G   => AXIL_CONFIG_C)
      port map (
         axiClk           => axilClk,
         axiClkRst        => axilReset,
         sAxiWriteMasters => bar0WriteMasters,
         sAxiWriteSlaves  => bar0WriteSlaves,
         sAxiReadMasters  => bar0ReadMasters,
         sAxiReadSlaves   => bar0ReadSlaves,
         mAxiWriteMasters => axilWriteMasters,
         mAxiWriteSlaves  => axilWriteSlaves,
         mAxiReadMasters  => axilReadMasters,
         mAxiReadSlaves   => axilReadSlaves);

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
         axilRst         => axilReset,
         axilReadMaster  => axilReadMasters(4),
         axilReadSlave   => axilReadSlaves(4),
         axilWriteMaster => axilWriteMasters(4),
         axilWriteSlave  => axilWriteSlaves(4),
         -- Primary DMA Interface (dmaPriClk domain)
         dmaPriClk       => dmaPriClk,
         dmaPriRst       => dmaPriRst,
         dmaPriObMasters => dmaPriObMasters,
         dmaPriObSlaves  => dmaPriObSlaves,
         dmaPriIbMasters => dmaPriIbMasters,
         dmaPriIbSlaves  => dmaPriIbSlaves,
         -- Secondary DMA Interface (dmaSecClk domain)
         dmaSecClk       => dmaSecClk,
         dmaSecRst       => dmaSecRst,
         dmaSecObMasters => dmaSecObMasters,
         dmaSecObSlaves  => dmaSecObSlaves,
         dmaSecIbMasters => dmaSecIbMasters,
         dmaSecIbSlaves  => dmaSecIbSlaves,
         -- DDR Memory Interface (ddrClk domain)
         ddrClk          => ddrClk,
         ddrRst          => ddrRst,
         ddrWriteMasters => ddrWriteMasters,
         ddrWriteSlaves  => ddrWriteSlaves,
         ddrReadMasters  => ddrReadMasters,
         ddrReadSlaves   => ddrReadSlaves,
         -- User AXI Clock and Reset
         axiClk          => axiClk,
         axiRst          => axiReset,
         ------------------
         --  Hardware Ports
         ------------------       
         -- QSFP[0] Ports
         qsfp0RefClkP    => qsfp0RefClkP,
         qsfp0RefClkN    => qsfp0RefClkN,
         qsfp0RxP        => qsfp0RxP,
         qsfp0RxN        => qsfp0RxN,
         qsfp0TxP        => qsfp0TxP,
         qsfp0TxN        => qsfp0TxN,
         -- QSFP[1] Ports
         qsfp1RefClkP    => qsfp1RefClkP,
         qsfp1RefClkN    => qsfp1RefClkN,
         qsfp1RxP        => qsfp1RxP,
         qsfp1RxN        => qsfp1RxN,
         qsfp1TxP        => qsfp1TxP,
         qsfp1TxN        => qsfp1TxN);

end top_level;
