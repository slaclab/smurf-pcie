-------------------------------------------------------------------------------
-- File       : SmurfC1100RssiOffload10GbE.vhd
-- Company    : SLAC National Accelerator Laboratory
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
use surf.AxiPkg.all;
use surf.AxiLitePkg.all;
use surf.AxiStreamPkg.all;
use surf.SsiPkg.all;

library axi_pcie_core;

use work.AppPkg.all;

entity SmurfC1100RssiOffload10GbE is
   generic (
      TPD_G        : time := 1 ns;
      BUILD_INFO_G : BuildInfoType);
   port (
      ---------------------
      --  Application Ports
      ---------------------
      -- QSFP[0] Ports
      qsfp0RefClkP : in    sl;
      qsfp0RefClkN : in    sl;
      qsfp0RxP     : in    slv(3 downto 0);
      qsfp0RxN     : in    slv(3 downto 0);
      qsfp0TxP     : out   slv(3 downto 0);
      qsfp0TxN     : out   slv(3 downto 0);
      -- QSFP[1] Ports
      qsfp1RefClkP : in    sl;
      qsfp1RefClkN : in    sl;
      qsfp1RxP     : in    slv(3 downto 0);
      qsfp1RxN     : in    slv(3 downto 0);
      qsfp1TxP     : out   slv(3 downto 0);
      qsfp1TxN     : out   slv(3 downto 0);
      -- HBM Ports
      hbmCatTrip   : out   sl := '0';  -- HBM Catastrophic Over temperature Output signal to Satellite Controller: active HIGH indicator to Satellite controller to indicate the HBM has exceeds its maximum allowable temperature
      --------------
      --  Core Ports
      --------------
      -- Card Management Solution (CMS) Interface
      cmsUartRxd   : in    sl;
      cmsUartTxd   : out   sl;
      cmsGpio      : in    slv(3 downto 0);
      -- System Ports
      userClkP     : in    sl;
      userClkN     : in    sl;
      hbmRefClkP   : in    sl;
      hbmRefClkN   : in    sl;
      -- SI5394 Ports
      si5394Scl    : inout sl;
      si5394Sda    : inout sl;
      si5394IrqL   : in    sl;
      si5394LolL   : in    sl;
      si5394LosL   : in    sl;
      si5394RstL   : out   sl;
      -- PCIe Ports
      pciRstL      : in    sl;
      pciRefClkP   : in    slv(1 downto 0);
      pciRefClkN   : in    slv(1 downto 0);
      pciRxP       : in    slv(15 downto 0);
      pciRxN       : in    slv(15 downto 0);
      pciTxP       : out   slv(15 downto 0);
      pciTxN       : out   slv(15 downto 0));
end SmurfC1100RssiOffload10GbE;

architecture top_level of SmurfC1100RssiOffload10GbE is

   constant NUM_AXIL_MASTERS_C : natural := 5;

   constant AXIL_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXIL_MASTERS_C-1 downto 0) := (
      0               => (
         baseAddr     => x"0010_0000",
         addrBits     => 20,
         connectivity => x"FFFF"),
      1               => (
         baseAddr     => x"0020_0000",
         addrBits     => 20,
         connectivity => x"FFFF"),
      2               => (
         baseAddr     => x"0030_0000",
         addrBits     => 20,
         connectivity => x"FFFF"),
      3               => (
         baseAddr     => x"0040_0000",
         addrBits     => 20,
         connectivity => x"FFFF"),
      4               => (
         baseAddr     => x"0080_0000",
         addrBits     => 23,
         connectivity => x"FFFF"));

   signal bar0WriteMasters : AxiLiteWriteMasterArray(1 downto 0);
   signal bar0WriteSlaves  : AxiLiteWriteSlaveArray(1 downto 0) := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal bar0ReadMasters  : AxiLiteReadMasterArray(1 downto 0);
   signal bar0ReadSlaves   : AxiLiteReadSlaveArray(1 downto 0)  := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

   signal axilClk          : sl;
   signal axilRst          : sl;
   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXIL_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXIL_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXIL_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXIL_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

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

   signal buffIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal buffIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal hbmRefClk : sl;
   signal userClk   : sl;

   signal cmsHbmCatTrip : sl                    := '0';
   signal cmsHbmTemp    : Slv7Array(1 downto 0) := (others => b"0000000");

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
         NUM_CLOCKS_G       => 1,
         -- MMCM attributes
         BANDWIDTH_G        => "OPTIMIZED",
         CLKIN_PERIOD_G     => 10.0,    -- 100MHz
         DIVCLK_DIVIDE_G    => 8,       -- 12.5MHz = 100MHz/8
         CLKFBOUT_MULT_F_G  => 96.875,  -- 1210.9375MHz = 96.875 x 12.5MHz
         CLKOUT0_DIVIDE_F_G => 7.75)    -- 156.25MHz = 1210.9375MHz/7.75
      port map(
         -- Clock Input
         clkIn     => userClk,
         rstIn     => dmaPriRst,
         -- Clock Outputs
         clkOut(0) => axilClk,
         -- Reset Outputs
         rstOut(0) => axilRst);

   ---------------------
   -- PCIE/DMA Interface
   ---------------------
   U_Core : entity axi_pcie_core.XilinxVariumC1100Core
      generic map (
         TPD_G              => TPD_G,
         BUILD_INFO_G       => BUILD_INFO_G,
         QSFP_CDR_DISABLE_G => true,  -- TRUE: 25G CDR doesn't work with this line rate (CDR margin is too large)
         DMA_AXIS_CONFIG_G  => APP_AXIS_CONFIG_C,
         DMA_SIZE_G         => NUM_RSSI_C)
      port map (
         ------------------------
         --  Top Level Interfaces
         ------------------------
         userClk        => userClk,
         hbmRefClk      => hbmRefClk,
         -- DMA Interfaces
         dmaClk         => dmaPriClk,
         dmaRst         => dmaPriRst,
         dmaObMasters   => dmaPriObMasters,
         dmaObSlaves    => dmaPriObSlaves,
         dmaIbMasters   => dmaPriIbMasters,
         dmaIbSlaves    => dmaPriIbSlaves,
         -- Application AXI-Lite Interfaces [0x00080000:0x00FFFFFF] (appClk domain)
         appClk         => axilClk,
         appRst         => axilRst,
         appReadMaster  => bar0ReadMasters(0),
         appReadSlave   => bar0ReadSlaves(0),
         appWriteMaster => bar0WriteMasters(0),
         appWriteSlave  => bar0WriteSlaves(0),
         --------------
         --  Core Ports
         --------------
         -- Card Management Solution (CMS) Interface
         cmsHbmCatTrip  => cmsHbmCatTrip,
         cmsHbmTemp     => cmsHbmTemp,
         cmsUartRxd     => cmsUartRxd,
         cmsUartTxd     => cmsUartTxd,
         cmsGpio        => cmsGpio,
         -- System Ports
         userClkP       => userClkP,
         userClkN       => userClkN,
         hbmRefClkP     => hbmRefClkP,
         hbmRefClkN     => hbmRefClkN,
         -- SI5394 Ports
         si5394Scl      => si5394Scl,
         si5394Sda      => si5394Sda,
         si5394IrqL     => si5394IrqL,
         si5394LolL     => si5394LolL,
         si5394LosL     => si5394LosL,
         si5394RstL     => si5394RstL,
         -- PCIe Ports
         pciRstL        => pciRstL,
         pciRefClkP(0)  => pciRefClkP(0),
         pciRefClkN(0)  => pciRefClkN(0),
         pciRxP         => pciRxP(7 downto 0),
         pciRxN         => pciRxN(7 downto 0),
         pciTxP         => pciTxP(7 downto 0),
         pciTxN         => pciTxN(7 downto 0));

   U_ExtendedCore : entity axi_pcie_core.XilinxVariumC1100PcieExtendedCore
      generic map (
         TPD_G             => TPD_G,
         BUILD_INFO_G      => BUILD_INFO_G,
         DMA_BURST_BYTES_G => 4096,
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
         appRst         => axilRst,
         appReadMaster  => bar0ReadMasters(1),
         appReadSlave   => bar0ReadSlaves(1),
         appWriteMaster => bar0WriteMasters(1),
         appWriteSlave  => bar0WriteSlaves(1),
         --------------
         --  Core Ports
         --------------
         -- Extended PCIe Ports
         pciRstL        => pciRstL,
         pciRefClkP(0)  => pciRefClkP(1),
         pciRefClkN(0)  => pciRefClkN(1),
         pciRxP         => pciRxP(15 downto 8),
         pciRxN         => pciRxN(15 downto 8),
         pciTxP         => pciTxP(15 downto 8),
         pciTxN         => pciTxN(15 downto 8));

   -----------------------
   -- RAW UDP Large Buffer
   -----------------------
   U_HbmDmaBuffer : entity axi_pcie_core.HbmDmaBuffer
      generic map (
         TPD_G             => TPD_G,
         DMA_SIZE_G        => NUM_RSSI_C,
         DMA_AXIS_CONFIG_G => APP_AXIS_CONFIG_C,
         AXIL_BASE_ADDR_G  => AXIL_CONFIG_C(0).baseAddr)
      port map (
         -- Card Management Solution (CMS) Interface
         cmsHbmCatTrip   => cmsHbmCatTrip,
         cmsHbmTemp      => cmsHbmTemp,
         -- HBM Interface
         userClk         => userClk,
         hbmRefClk       => hbmRefClk,
         hbmCatTrip      => hbmCatTrip,
         -- AXI-Lite Interface (axilClk domain)
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMasters(0),
         axilReadSlave   => axilReadSlaves(0),
         axilWriteMaster => axilWriteMasters(0),
         axilWriteSlave  => axilWriteSlaves(0),
         -- Trigger Event streams (eventClk domain)
         eventClk        => (others => dmaSecClk),
         eventTrigMsgCtrl=> open,
         -- AXI Stream Interface (axisClk domain)
         axisClk         => (others => dmaSecClk),
         axisRst         => (others => dmaSecRst),
         sAxisMasters    => buffIbMasters,
         sAxisSlaves     => buffIbSlaves,
         mAxisMasters    => dmaSecIbMasters,
         mAxisSlaves     => dmaSecIbSlaves);

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
         axiClkRst        => axilRst,
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
         dmaSecIbMasters => buffIbMasters,
         dmaSecIbSlaves  => buffIbSlaves,
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
