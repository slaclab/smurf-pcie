-------------------------------------------------------------------------------
-- File       : SmurfKcu1500RssiOffload.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-02-06
-- Last update: 2018-02-06
-------------------------------------------------------------------------------
-- Description: 
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
use work.AxiPciePkg.all;
use work.AppPkg.all;

library unisim;
use unisim.vcomponents.all;

entity SmurfKcu1500RssiOffload is
   generic (
      TPD_G        : time := 1 ns;
      BUILD_INFO_G : BuildInfoType);
   port (
      ---------------------
      --  Application Ports
      ---------------------
      -- QSFP[0] Ports
      qsfp0RefClkP : in    slv(1 downto 0);
      qsfp0RefClkN : in    slv(1 downto 0);
      qsfp0RxP     : in    slv(3 downto 0);
      qsfp0RxN     : in    slv(3 downto 0);
      qsfp0TxP     : out   slv(3 downto 0);
      qsfp0TxN     : out   slv(3 downto 0);
      -- QSFP[1] Ports
      qsfp1RefClkP : in    slv(1 downto 0);
      qsfp1RefClkN : in    slv(1 downto 0);
      qsfp1RxP     : in    slv(3 downto 0);
      qsfp1RxN     : in    slv(3 downto 0);
      qsfp1TxP     : out   slv(3 downto 0);
      qsfp1TxN     : out   slv(3 downto 0);
      --------------
      --  Core Ports
      --------------
      -- System Ports
      emcClk       : in    sl;
      userClkP     : in    sl;
      userClkN     : in    sl;
      swDip        : in    slv(3 downto 0);
      led          : out   slv(7 downto 0);
      -- QSFP[0] Ports
      qsfp0RstL    : out   sl;
      qsfp0LpMode  : out   sl;
      qsfp0ModSelL : out   sl;
      qsfp0ModPrsL : in    sl;
      -- QSFP[1] Ports
      qsfp1RstL    : out   sl;
      qsfp1LpMode  : out   sl;
      qsfp1ModSelL : out   sl;
      qsfp1ModPrsL : in    sl;
      -- Boot Memory Ports 
      flashCsL     : out   sl;
      flashMosi    : out   sl;
      flashMiso    : in    sl;
      flashHoldL   : out   sl;
      flashWp      : out   sl;
      -- DDR Ports
      ddrClkP      : in    slv(3 downto 0);
      ddrClkN      : in    slv(3 downto 0);
      ddrOut       : out   DdrOutArray(3 downto 0);
      ddrInOut     : inout DdrInOutArray(3 downto 0);
      -- PCIe Ports
      pciRstL      : in    sl;
      pciRefClkP   : in    sl;
      pciRefClkN   : in    sl;
      pciRxP       : in    slv(7 downto 0);
      pciRxN       : in    slv(7 downto 0);
      pciTxP       : out   slv(7 downto 0);
      pciTxN       : out   slv(7 downto 0));
end SmurfKcu1500RssiOffload;

architecture top_level of SmurfKcu1500RssiOffload is

   constant NUM_AXI_MASTERS_C : natural := 2;

   constant HW_INDEX_C      : natural := 0;
   constant OFFLOAD_INDEX_C : natural := 1;

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, BAR0_BASE_ADDR_C, 23, 22);

   signal axilClk   : sl;
   signal axilRst   : sl;
   signal axilReset : sl;

   signal axilReadMaster  : AxiLiteReadMasterType;
   signal axilReadSlave   : AxiLiteReadSlaveType;
   signal axilWriteMaster : AxiLiteWriteMasterType;
   signal axilWriteSlave  : AxiLiteWriteSlaveType;

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

   signal dmaClk : sl;
   signal dmaRst : sl;

   signal dmaObMasters : AxiStreamMasterArray(7 downto 0);
   signal dmaObSlaves  : AxiStreamSlaveArray(7 downto 0);
   signal dmaIbMasters : AxiStreamMasterArray(7 downto 0);
   signal dmaIbSlaves  : AxiStreamSlaveArray(7 downto 0);

   signal rssiLinkUp    : slv(NUM_RSSI_C-1 downto 0);
   signal rssiIbMasters : AxiStreamMasterArray(NUM_AXIS_C-1 downto 0);
   signal rssiIbSlaves  : AxiStreamSlaveArray(NUM_AXIS_C-1 downto 0);
   signal rssiObMasters : AxiStreamMasterArray(NUM_AXIS_C-1 downto 0);
   signal rssiObSlaves  : AxiStreamSlaveArray(NUM_AXIS_C-1 downto 0);

   signal memReady        : slv(3 downto 0);
   signal memWriteMasters : AxiWriteMasterArray(15 downto 0);
   signal memWriteSlaves  : AxiWriteSlaveArray(15 downto 0);
   signal memReadMasters  : AxiReadMasterArray(15 downto 0);
   signal memReadSlaves   : AxiReadSlaveArray(15 downto 0);

begin

   ---------------------
   -- PCIE/DMA Interface
   ---------------------
   U_Core : entity work.XilinxKcu1500Core
      generic map (
         TPD_G        => TPD_G,
         BUILD_INFO_G => BUILD_INFO_G,
         DMA_SIZE_G   => 8)
      port map (
         ------------------------      
         --  Top Level Interfaces
         ------------------------        
         -- System Clock and Reset
         sysClk          => dmaClk,
         sysRst          => dmaRst,
         userClk156      => axilClk,
         userSwDip       => open,
         userLed         => x"01",
         -- DMA Interfaces
         dmaObMasters    => dmaObMasters,
         dmaObSlaves     => dmaObSlaves,
         dmaIbMasters    => dmaIbMasters,
         dmaIbSlaves     => dmaIbSlaves,
         -- AXI-Lite Interface
         appClk          => axilClk,
         appRst          => axilRst,
         appReadMaster   => axilReadMaster,
         appReadSlave    => axilReadSlave,
         appWriteMaster  => axilWriteMaster,
         appWriteSlave   => axilWriteSlave,
         -- Memory bus (sysClk domain)
         memReady        => memReady,
         memWriteMasters => memWriteMasters,
         memWriteSlaves  => memWriteSlaves,
         memReadMasters  => memReadMasters,
         memReadSlaves   => memReadSlaves,
         --------------
         --  Core Ports
         --------------   
         -- System Ports
         emcClk          => emcClk,
         userClkP        => userClkP,
         userClkN        => userClkN,
         swDip           => swDip,
         led             => led,
         -- QSFP[0] Ports
         qsfp0RstL       => qsfp0RstL,
         qsfp0LpMode     => qsfp0LpMode,
         qsfp0ModSelL    => qsfp0ModSelL,
         qsfp0ModPrsL    => qsfp0ModPrsL,
         -- QSFP[1] Ports
         qsfp1RstL       => qsfp1RstL,
         qsfp1LpMode     => qsfp1LpMode,
         qsfp1ModSelL    => qsfp1ModSelL,
         qsfp1ModPrsL    => qsfp1ModPrsL,
         -- Boot Memory Ports 
         flashCsL        => flashCsL,
         flashMosi       => flashMosi,
         flashMiso       => flashMiso,
         flashHoldL      => flashHoldL,
         flashWp         => flashWp,
         -- DDR Ports
         ddrClkP         => ddrClkP,
         ddrClkN         => ddrClkN,
         ddrOut          => ddrOut,
         ddrInOut        => ddrInOut,
         -- PCIe Ports 
         pciRstL         => pciRstL,
         pciRefClkP      => pciRefClkP,
         pciRefClkN      => pciRefClkN,
         pciRxP          => pciRxP,
         pciRxN          => pciRxN,
         pciTxP          => pciTxP,
         pciTxN          => pciTxN);

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
         DEC_ERROR_RESP_G   => BAR0_ERROR_RESP_C,
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

   ---------------------
   -- Application Module
   ---------------------
   U_Application : entity work.Application
      generic map (
         TPD_G            => TPD_G,
         AXI_BASE_ADDR_G  => AXI_CONFIG_C(OFFLOAD_INDEX_C).baseAddr)
      port map (
         -- DMA Interface (dmaClk domain)
         dmaClk          => dmaClk,
         dmaRst          => dmaRst,
         dmaObMasters    => dmaObMasters,
         dmaObSlaves     => dmaObSlaves,
         dmaIbMasters    => dmaIbMasters,
         dmaIbSlaves     => dmaIbSlaves,
         -- Memory bus (dmaClk domain)
         memReady        => memReady,
         memWriteMasters => memWriteMasters,
         memWriteSlaves  => memWriteSlaves,
         memReadMasters  => memReadMasters,
         memReadSlaves   => memReadSlaves,
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
         TPD_G            => TPD_G,
         AXI_BASE_ADDR_G  => AXI_CONFIG_C(HW_INDEX_C).baseAddr)
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
