-------------------------------------------------------------------------------
-- File       : Hardware.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: Hardware File
-------------------------------------------------------------------------------
-- This file is part of 'axi-pcie-core'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'axi-pcie-core', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.StdRtlPkg.all;

use work.AxiPkg.all;
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.EthMacPkg.all;
use work.AppPkg.all;

entity Hardware is
   generic (
      TPD_G           : time := 1 ns;
      CLK_FREQUENCY_G : real := 156.25E+6;  -- units of Hz
      AXI_BASE_ADDR_G : slv(31 downto 0));
   port (
      ------------------------      
      --  Top Level Interfaces
      ------------------------    
      -- AXI-Lite Interface (axilClk domain)
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType;
      -- Primary DMA Interface (dmaPriClk domain)
      dmaPriClk       : in  sl;
      dmaPriRst       : in  sl;
      dmaPriObMasters : in  AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      dmaPriObSlaves  : out AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      dmaPriIbMasters : out AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      dmaPriIbSlaves  : in  AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      -- Secondary DMA Interface (dmaSecClk domain)
      dmaSecClk       : in  sl;
      dmaSecRst       : in  sl;
      dmaSecObMasters : in  AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      dmaSecObSlaves  : out AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      dmaSecIbMasters : out AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      dmaSecIbSlaves  : in  AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      -- DDR Interface (ddrClk domain)
      ddrClk          : in  slv((NUM_RSSI_C/2)-1 downto 0);
      ddrRst          : in  slv((NUM_RSSI_C/2)-1 downto 0);
      ddrWriteMasters : out AxiWriteMasterArray((NUM_RSSI_C/2)-1 downto 0);
      ddrWriteSlaves  : in  AxiWriteSlaveArray((NUM_RSSI_C/2)-1 downto 0);
      ddrReadMasters  : out AxiReadMasterArray((NUM_RSSI_C/2)-1 downto 0);
      ddrReadSlaves   : in  AxiReadSlaveArray((NUM_RSSI_C/2)-1 downto 0);
      -- User AXI Clock and Reset
      axiClk          : in  sl;
      axiRst          : in  sl;
      ---------------------
      --  Hardware Ports
      ---------------------    
      -- QSFP[0] Ports
      qsfp0RefClkP    : in  slv(1 downto 0);
      qsfp0RefClkN    : in  slv(1 downto 0);
      qsfp0RxP        : in  slv(3 downto 0);
      qsfp0RxN        : in  slv(3 downto 0);
      qsfp0TxP        : out slv(3 downto 0);
      qsfp0TxN        : out slv(3 downto 0);
      -- QSFP[1] Ports
      qsfp1RefClkP    : in  slv(1 downto 0);
      qsfp1RefClkN    : in  slv(1 downto 0);
      qsfp1RxP        : in  slv(3 downto 0);
      qsfp1RxN        : in  slv(3 downto 0);
      qsfp1TxP        : out slv(3 downto 0);
      qsfp1TxN        : out slv(3 downto 0));
end Hardware;

architecture mapping of Hardware is

   constant NUM_AXI_MASTERS_C : natural := NUM_RSSI_C+2;

   constant PHY_INDEX_C  : natural := NUM_RSSI_C;
   constant BUFF_INDEX_C : natural := NUM_RSSI_C+1;

   constant AXI_CONFIG_C  : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, AXI_BASE_ADDR_G, 20, 16);
   constant BUFF_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_RSSI_C downto 0)          := genAxiLiteConfig(NUM_RSSI_C+1, AXI_CONFIG_C(BUFF_INDEX_C).baseAddr, 16, 12);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

   signal buffWriteMaster : AxiLiteWriteMasterType := AXI_LITE_WRITE_MASTER_INIT_C;
   signal buffWriteSlave  : AxiLiteWriteSlaveType  := AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C;
   signal buffReadMaster  : AxiLiteReadMasterType  := AXI_LITE_READ_MASTER_INIT_C;
   signal buffReadSlave   : AxiLiteReadSlaveType   := AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C;

   signal buffWriteMasters : AxiLiteWriteMasterArray(NUM_RSSI_C downto 0) := (others => AXI_LITE_WRITE_MASTER_INIT_C);
   signal buffWriteSlaves  : AxiLiteWriteSlaveArray(NUM_RSSI_C downto 0)  := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal buffReadMasters  : AxiLiteReadMasterArray(NUM_RSSI_C downto 0)  := (others => AXI_LITE_READ_MASTER_INIT_C);
   signal buffReadSlaves   : AxiLiteReadSlaveArray(NUM_RSSI_C downto 0)   := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

   signal macObMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal macObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal macIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal macIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal udpIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal udpIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal ddrIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal ddrIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal ddrObMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal ddrObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal rssiIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal rssiIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal rssiObMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal rssiObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal localMac : Slv48Array(NUM_RSSI_C-1 downto 0);
   signal localIp  : Slv32Array(NUM_RSSI_C-1 downto 0);

   signal udpObMuxSel   : sl;
   signal udpObDest     : slv(7 downto 0);
   signal udpToPhyRoute : Slv8Array(NUM_RSSI_C-1 downto 0);

   signal axilReset : sl;
   signal axiReset  : sl;

begin

   U_axilRst : entity work.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axilClk,
         rstIn  => axilRst,
         rstOut => axilReset);

   U_axiRst : entity work.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axiClk,
         rstIn  => axiRst,
         rstOut => axiReset);

   ------------------
   -- DMA ASYNC FIFOs
   ------------------
   GEN_DMA : for i in NUM_RSSI_C-1 downto 0 generate
      U_DmaAsyncFifo : entity work.DmaAsyncFifo
         generic map (
            TPD_G => TPD_G)
         port map (
            -- UDP Outbound Config Interface (axiClk domain)
            udpObMuxSel    => udpObMuxSel,
            udpObDest      => udpObDest,
            -- Primary DMA Interface (dmaPriClk domain)
            dmaPriClk      => dmaPriClk,
            dmaPriRst      => dmaPriRst,
            dmaPriObMaster => dmaPriObMasters(i),
            dmaPriObSlave  => dmaPriObSlaves(i),
            dmaPriIbMaster => dmaPriIbMasters(i),
            dmaPriIbSlave  => dmaPriIbSlaves(i),
            -- Secondary DMA Interface (dmaSecClk domain)
            dmaSecClk      => dmaSecClk,
            dmaSecRst      => dmaSecRst,
            dmaSecObMaster => dmaSecObMasters(i),
            dmaSecObSlave  => dmaSecObSlaves(i),
            dmaSecIbMaster => dmaSecIbMasters(i),
            dmaSecIbSlave  => dmaSecIbSlaves(i),
            -- UDP Interface (axiClk/axilClk domain)
            axiClk         => axiClk,
            axiRst         => axiReset,
            udpIbMaster    => udpIbMasters(i),
            udpIbSlave     => udpIbSlaves(i),
            udpObMaster    => ddrObMasters(i),
            udpObSlave     => ddrObSlaves(i),
            -- RSSI Interface (axilClk domain)
            axilClk        => axilClk,
            axilRst        => axilReset,
            rssiIbMaster   => rssiIbMasters(i),
            rssiIbSlave    => rssiIbSlaves(i),
            rssiObMaster   => rssiObMasters(i),
            rssiObSlave    => rssiObSlaves(i));
   end generate GEN_DMA;

   ---------------------
   -- AXI-Lite Crossbar
   ---------------------
   U_XBAR : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 1,
         NUM_MASTER_SLOTS_G => NUM_AXI_MASTERS_C,
         MASTERS_CONFIG_G   => AXI_CONFIG_C)
      port map (
         axiClk              => axilClk,
         axiClkRst           => axilReset,
         sAxiWriteMasters(0) => axilWriteMaster,
         sAxiWriteSlaves(0)  => axilWriteSlave,
         sAxiReadMasters(0)  => axilReadMaster,
         sAxiReadSlaves(0)   => axilReadSlave,
         mAxiWriteMasters    => axilWriteMasters,
         mAxiWriteSlaves     => axilWriteSlaves,
         mAxiReadMasters     => axilReadMasters,
         mAxiReadSlaves      => axilReadSlaves);

   U_AxiLiteAsync : entity work.AxiLiteAsync
      generic map (
         TPD_G           => TPD_G,
         COMMON_CLK_G    => false,
         NUM_ADDR_BITS_G => 24)
      port map (
         -- Slave Interface
         sAxiClk         => axilClk,
         sAxiClkRst      => axilReset,
         sAxiReadMaster  => axilReadMasters(BUFF_INDEX_C),
         sAxiReadSlave   => axilReadSlaves(BUFF_INDEX_C),
         sAxiWriteMaster => axilWriteMasters(BUFF_INDEX_C),
         sAxiWriteSlave  => axilWriteSlaves(BUFF_INDEX_C),
         -- Master Interface
         mAxiClk         => axiClk,
         mAxiClkRst      => axiReset,
         mAxiReadMaster  => buffReadMaster,
         mAxiReadSlave   => buffReadSlave,
         mAxiWriteMaster => buffWriteMaster,
         mAxiWriteSlave  => buffWriteSlave);

   U_XBAR_BUFFER : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 1,
         NUM_MASTER_SLOTS_G => NUM_RSSI_C+1,
         MASTERS_CONFIG_G   => BUFF_CONFIG_C)
      port map (
         axiClk              => axiClk,
         axiClkRst           => axiReset,
         sAxiWriteMasters(0) => buffWriteMaster,
         sAxiWriteSlaves(0)  => buffWriteSlave,
         sAxiReadMasters(0)  => buffReadMaster,
         sAxiReadSlaves(0)   => buffReadSlave,
         mAxiWriteMasters    => buffWriteMasters,
         mAxiWriteSlaves     => buffWriteSlaves,
         mAxiReadMasters     => buffReadMasters,
         mAxiReadSlaves      => buffReadSlaves);

   --------------------------------------------
   -- 10 GigE Modules for QSFP[1:0]
   --------------------------------------------
   U_EthPhyMac : entity work.EthPhyWrapper
      generic map (
         TPD_G           => TPD_G,
         AXI_BASE_ADDR_G => AXI_CONFIG_C(PHY_INDEX_C).baseAddr)
      port map (
         -- Local Configurations
         localMac        => localMac,
         localIp         => localIp,
         udpToPhyRoute   => udpToPhyRoute,
         -- AXI-Lite Interface (axilClk domain)
         axilClk         => axilClk,
         axilRst         => axilReset,
         axilReadMaster  => axilReadMasters(PHY_INDEX_C),
         axilReadSlave   => axilReadSlaves(PHY_INDEX_C),
         axilWriteMaster => axilWriteMasters(PHY_INDEX_C),
         axilWriteSlave  => axilWriteSlaves(PHY_INDEX_C),
         -- Streaming DMA Interface 
         udpIbMasters    => macObMasters,
         udpIbSlaves     => macObSlaves,
         udpObMasters    => macIbMasters,
         udpObSlaves     => macIbSlaves,
         ---------------------
         --  Hardware Ports
         ---------------------    
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
         qsfp1TxN        => qsfp1TxN,
         qsfp1TxP        => qsfp1TxP);

   ------------
   -- ETH Lanes
   ------------
   GEN_LANE : for i in NUM_RSSI_C-1 downto 0 generate

      U_Lane : entity work.EthLane
         generic map (
            TPD_G           => TPD_G,
            CLK_FREQUENCY_G => CLK_FREQUENCY_G,
            AXI_BASE_ADDR_G => AXI_CONFIG_C(i).baseAddr)
         port map (
            -- RSSI Interface (axilClk domain)
            rssiIbMaster    => rssiIbMasters(i),
            rssiIbSlave     => rssiIbSlaves(i),
            rssiObMaster    => rssiObMasters(i),
            rssiObSlave     => rssiObSlaves(i),
            -- UDP Interface (axiClk/axilClk domain)
            axiClk          => axiClk,
            axiRst          => axiReset,
            udpIbMaster     => udpIbMasters(i),
            udpIbSlave      => udpIbSlaves(i),
            udpObMaster     => ddrIbMasters(i),
            udpObSlave      => ddrIbSlaves(i),
            -- PHY Interface (axilClk domain)
            macObMaster     => macObMasters(i),
            macObSlave      => macObSlaves(i),
            macIbMaster     => macIbMasters(i),
            macIbSlave      => macIbSlaves(i),
            localMac        => localMac(i),
            localIp         => localIp(i),
            -- AXI-Lite Interface (axilClk domain)
            axilClk         => axilClk,
            axilRst         => axilReset,
            axilReadMaster  => axilReadMasters(i),
            axilReadSlave   => axilReadSlaves(i),
            axilWriteMaster => axilWriteMasters(i),
            axilWriteSlave  => axilWriteSlaves(i));

   end generate GEN_LANE;

   GEN_VEC : for i in (NUM_RSSI_C/2)-1 downto 0 generate

      U_Buffer : entity work.UdpLargeDataBuffer
         generic map (
            TPD_G => TPD_G)
         port map (
            -- UDP Large Data Buffer (axiClk domain)
            axiClk           => axiClk,
            axiRst           => axiReset,
            ddrIbMasters     => ddrIbMasters(2*i+1 downto 2*i),
            ddrIbSlaves      => ddrIbSlaves(2*i+1 downto 2*i),
            ddrObMasters     => ddrObMasters(2*i+1 downto 2*i),
            ddrObSlaves      => ddrObSlaves(2*i+1 downto 2*i),
            -- AXI-Lite Interface (axiClk domain)
            axilReadMasters  => buffReadMasters(2*i+1 downto 2*i),
            axilReadSlaves   => buffReadSlaves(2*i+1 downto 2*i),
            axilWriteMasters => buffWriteMasters(2*i+1 downto 2*i),
            axilWriteSlaves  => buffWriteSlaves(2*i+1 downto 2*i),
            -- DDR Memory Interface (ddrClk domain)
            ddrClk           => ddrClk(i),
            ddrRst           => ddrRst(i),
            ddrWriteMaster   => ddrWriteMasters(i),
            ddrWriteSlave    => ddrWriteSlaves(i),
            ddrReadMaster    => ddrReadMasters(i),
            ddrReadSlave     => ddrReadSlaves(i));

   end generate GEN_VEC;

   U_Debug : entity work.UdpDebug
      generic map (
         TPD_G => TPD_G)
      port map (
         userClk         => axilClk,
         -- Clock and Reset
         axiClk          => axiClk,
         axiRst          => axiReset,
         -- UDP Outbound Config Interface
         udpObMuxSel     => udpObMuxSel,
         udpObDest       => udpObDest,
         udpToPhyRoute   => udpToPhyRoute,
         -- AXI-Lite Interface 
         axilReadMaster  => buffReadMasters(NUM_RSSI_C),
         axilReadSlave   => buffReadSlaves(NUM_RSSI_C),
         axilWriteMaster => buffWriteMasters(NUM_RSSI_C),
         axilWriteSlave  => buffWriteSlaves(NUM_RSSI_C));

end mapping;
