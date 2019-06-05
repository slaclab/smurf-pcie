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

use work.StdRtlPkg.all;
use work.AxiPkg.all;
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
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
      qsfp0RefClkP : in  slv(1 downto 0);
      qsfp0RefClkN : in  slv(1 downto 0);
      qsfp0RxP     : in  slv(3 downto 0);
      qsfp0RxN     : in  slv(3 downto 0);
      qsfp0TxP     : out slv(3 downto 0);
      qsfp0TxN     : out slv(3 downto 0);
      -- QSFP[1] Ports
      qsfp1RefClkP : in  slv(1 downto 0);
      qsfp1RefClkN : in  slv(1 downto 0);
      qsfp1RxP     : in  slv(3 downto 0);
      qsfp1RxN     : in  slv(3 downto 0);
      qsfp1TxP     : out slv(3 downto 0);
      qsfp1TxN     : out slv(3 downto 0);
      --------------
      --  Core Ports
      --------------
      -- System Ports
      emcClk       : in  sl;
      userClkP     : in  sl;
      userClkN     : in  sl;
      -- QSFP[0] Ports
      qsfp0RstL    : out sl;
      qsfp0LpMode  : out sl;
      qsfp0ModSelL : out sl;
      qsfp0ModPrsL : in  sl;
      -- QSFP[1] Ports
      qsfp1RstL    : out sl;
      qsfp1LpMode  : out sl;
      qsfp1ModSelL : out sl;
      qsfp1ModPrsL : in  sl;
      -- Boot Memory Ports 
      flashCsL     : out sl;
      flashMosi    : out sl;
      flashMiso    : in  sl;
      flashHoldL   : out sl;
      flashWp      : out sl;
      -- PCIe Ports
      pciRstL      : in  sl;
      pciRefClkP   : in  sl;
      pciRefClkN   : in  sl;
      pciRxP       : in  slv(7 downto 0);
      pciRxN       : in  slv(7 downto 0);
      pciTxP       : out slv(7 downto 0);
      pciTxN       : out slv(7 downto 0));
end SmurfKcu1500RssiOffload10GbE;

architecture top_level of SmurfKcu1500RssiOffload10GbE is

   constant CLK_FREQUENCY_C : real := 125.0E+6;  -- units of Hz

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

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXIL_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXIL_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXIL_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXIL_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

   signal userClk156      : sl;
   signal axilClk         : sl;
   signal axilRst         : sl;
   signal axilReset       : sl;
   signal axilReadMaster  : AxiLiteReadMasterType;
   signal axilReadSlave   : AxiLiteReadSlaveType;
   signal axilWriteMaster : AxiLiteWriteMasterType;
   signal axilWriteSlave  : AxiLiteWriteSlaveType;

   signal dmaClk       : sl;
   signal dmaRst       : sl;
   signal dmaObMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal dmaObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal dmaIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal dmaIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal rssiLinkUp    : slv(NUM_RSSI_C-1 downto 0);
   signal rssiIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal rssiIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal rssiObMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal rssiObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal devIbMaster : AxiStreamMasterType;
   signal devIbSlave  : AxiStreamSlaveType;
   signal devObMaster : AxiStreamMasterType;
   signal devObSlave  : AxiStreamSlaveType;

begin

   -----------------------
   -- AXI-Lite Clock/Reset
   -----------------------
   U_axilClk : entity work.ClockManagerUltraScale
      generic map(
         TPD_G              => TPD_G,
         TYPE_G             => "MMCM",
         INPUT_BUFG_G       => true,
         FB_BUFG_G          => true,
         RST_IN_POLARITY_G  => '1',
         NUM_CLOCKS_G       => 1,
         -- MMCM attributes
         CLKIN_PERIOD_G     => 6.4,     -- 156.25 MHz
         CLKFBOUT_MULT_G    => 8,       -- 1.25GHz = 8 x 156.25 MHz
         CLKOUT0_DIVIDE_F_G => 10.0)    -- 125MHz (must match CLK_FREQUENCY_C)
      port map(
         -- Clock Input
         clkIn     => userClk156,
         rstIn     => dmaRst,
         -- Clock Outputs
         clkOut(0) => axilClk,
         -- Reset Outputs
         rstOut(0) => axilReset);

   U_axilRst : entity work.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axilClk,
         rstIn  => axilReset,
         rstOut => axilRst);

   ---------------------
   -- PCIE/DMA Interface
   ---------------------
   U_Core : entity work.XilinxKcu1500Core
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
         -- DMA Interfaces  (dmaClk domain)
         dmaClk         => dmaClk,
         dmaRst         => dmaRst,
         dmaObMasters   => dmaObMasters,
         dmaObSlaves    => dmaObSlaves,
         dmaIbMasters   => dmaIbMasters,
         dmaIbSlaves    => dmaIbSlaves,
         -- Application AXI-Lite Interfaces [0x00080000:0x00FFFFFF] (appClk domain)
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

   --------------------------------
   -- dmaClk<-->axilClk ASYNC FIFOs
   --------------------------------
   U_DmaAsyncFifo : entity work.DmaAsyncFifo
      generic map (
         TPD_G => TPD_G)
      port map (
         -- DMA Interface (dmaClk domain)
         dmaClk        => dmaClk,
         dmaRst        => dmaRst,
         dmaObMasters  => dmaObMasters,
         dmaObSlaves   => dmaObSlaves,
         dmaIbMasters  => dmaIbMasters,
         dmaIbSlaves   => dmaIbSlaves,
         -- DMA Interface (axilClk domain)
         axilClk       => axilClk,
         axilRst       => axilRst,
         rssiIbMasters => rssiIbMasters,
         rssiIbSlaves  => rssiIbSlaves,
         rssiObMasters => rssiObMasters,
         rssiObSlaves  => rssiObSlaves);

   ----------------
   -- AXI-Lite XBAR
   ----------------
   U_XBAR : entity work.AxiLiteCrossbar
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
         ETH_10G_G       => true,       -- true = 10 GbE
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
         -- RSSI Interface (axilClk domain)
         rssiIbMasters   => rssiIbMasters,
         rssiIbSlaves    => rssiIbSlaves,
         rssiObMasters   => rssiObMasters,
         rssiObSlaves    => rssiObSlaves,
         rssiLinkUp      => rssiLinkUp,
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
