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

   constant NUM_AXI_MASTERS_C : natural := 2;

   constant HW_INDEX_C      : natural := 0;
   constant OFFLOAD_INDEX_C : natural := 1;

   constant AXIL_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, x"0080_0000", 23, 22);

   signal axilClk          : sl;
   signal axilRst          : sl;
   signal axilReset        : sl;
   signal axilReadMaster   : AxiLiteReadMasterType;
   signal axilReadSlave    : AxiLiteReadSlaveType;
   signal axilWriteMaster  : AxiLiteWriteMasterType;
   signal axilWriteSlave   : AxiLiteWriteSlaveType;
   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

   signal dmaClk       : sl;
   signal dmaRst       : sl;
   signal dmaObMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal dmaObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal dmaIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal dmaIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal rssiLinkUp    : slv(NUM_RSSI_C-1 downto 0);
   signal rssiIbMasters : AxiStreamMasterArray(NUM_AXIS_C-1 downto 0);
   signal rssiIbSlaves  : AxiStreamSlaveArray(NUM_AXIS_C-1 downto 0);
   signal rssiObMasters : AxiStreamMasterArray(NUM_AXIS_C-1 downto 0);
   signal rssiObSlaves  : AxiStreamSlaveArray(NUM_AXIS_C-1 downto 0);

begin

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
         userClk156     => axilClk,
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

   U_axilReset : entity work.RstSync
      generic map (
         TPD_G => TPD_G)
      port map (
         clk      => axilClk,
         asyncRst => dmaRst,
         syncRst  => axilReset);

   U_axilRst : entity work.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axilClk,
         rstIn  => axilReset,
         rstOut => axilRst);

   ---------------------
   -- AXI-Lite Crossbar
   ---------------------
   U_XBAR : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 1,
         NUM_MASTER_SLOTS_G => NUM_AXI_MASTERS_C,
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

   ---------------------
   -- Application Module
   ---------------------
   U_Application : entity work.Application
      generic map (
         TPD_G           => TPD_G,
         AXI_BASE_ADDR_G => AXIL_CONFIG_C(OFFLOAD_INDEX_C).baseAddr)
      port map (
         -- DMA Interface (dmaClk domain)
         dmaClk          => dmaClk,
         dmaRst          => dmaRst,
         dmaObMasters    => dmaObMasters,
         dmaObSlaves     => dmaObSlaves,
         dmaIbMasters    => dmaIbMasters,
         dmaIbSlaves     => dmaIbSlaves,
         -- RSSI Interface (axilClk domain)
         rssiLinkUp      => rssiLinkUp,
         rssiIbMasters   => rssiIbMasters,
         rssiIbSlaves    => rssiIbSlaves,
         rssiObMasters   => rssiObMasters,
         rssiObSlaves    => rssiObSlaves,
         -- AXI-Lite Interface (axilClk domain)
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMasters(OFFLOAD_INDEX_C),
         axilReadSlave   => axilReadSlaves(OFFLOAD_INDEX_C),
         axilWriteMaster => axilWriteMasters(OFFLOAD_INDEX_C),
         axilWriteSlave  => axilWriteSlaves(OFFLOAD_INDEX_C));

   ------------------
   -- RSSI/ETH Module
   ------------------
   U_Hardware : entity work.Hardware
      generic map (
         TPD_G           => TPD_G,
         ETH_10G_G       => true,       -- true = 10 GbE
         AXI_BASE_ADDR_G => AXIL_CONFIG_C(HW_INDEX_C).baseAddr)
      port map (
         ------------------------      
         --  Top Level Interfaces
         ------------------------    
         -- AXI-Lite Interface (axilClk domain)
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMasters(HW_INDEX_C),
         axilReadSlave   => axilReadSlaves(HW_INDEX_C),
         axilWriteMaster => axilWriteMasters(HW_INDEX_C),
         axilWriteSlave  => axilWriteSlaves(HW_INDEX_C),
         -- RSSI Interface (axilClk domain)
         rssiLinkUp      => rssiLinkUp,
         rssiIbMasters   => rssiIbMasters,
         rssiIbSlaves    => rssiIbSlaves,
         rssiObMasters   => rssiObMasters,
         rssiObSlaves    => rssiObSlaves,
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
