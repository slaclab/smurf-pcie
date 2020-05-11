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

library surf;
use surf.StdRtlPkg.all;
use surf.AxiPkg.all;
use surf.AxiLitePkg.all;
use surf.AxiStreamPkg.all;
use surf.EthMacPkg.all;

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
      -- AXI-Lite Interface
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType;
      -- DMA Interface
      dmaClk          : in  sl;
      dmaRst          : in  sl;
      dmaObMasters    : in  AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      dmaObSlaves     : out AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      dmaIbMasters    : out AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      dmaIbSlaves     : in  AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      ---------------------
      --  Hardware Ports
      ---------------------    
      -- QSFP[1:0] Ports
      qsfpRefClkP     : in  sl;
      qsfpRefClkN     : in  sl;
      qsfp0RxP        : in  slv(3 downto 0);
      qsfp0RxN        : in  slv(3 downto 0);
      qsfp0TxP        : out slv(3 downto 0);
      qsfp0TxN        : out slv(3 downto 0);
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
   constant BUFF_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_RSSI_C+2 downto 0)        := genAxiLiteConfig(NUM_RSSI_C+3, AXI_CONFIG_C(BUFF_INDEX_C).baseAddr, 16, 12);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

   signal buffWriteMasters : AxiLiteWriteMasterArray(NUM_RSSI_C+2 downto 0) := (others => AXI_LITE_WRITE_MASTER_INIT_C);
   signal buffWriteSlaves  : AxiLiteWriteSlaveArray(NUM_RSSI_C+2 downto 0)  := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal buffReadMasters  : AxiLiteReadMasterArray(NUM_RSSI_C+2 downto 0)  := (others => AXI_LITE_READ_MASTER_INIT_C);
   signal buffReadSlaves   : AxiLiteReadSlaveArray(NUM_RSSI_C+2 downto 0)   := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

   signal macObMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal macObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal macIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal macIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal udpIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal udpIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal udpObMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal udpObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal rssiIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal rssiIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal rssiObMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal rssiObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal localMac : Slv48Array(NUM_RSSI_C-1 downto 0);
   signal localIp  : Slv32Array(NUM_RSSI_C-1 downto 0);

   signal udpObDest     : slv(7 downto 0);
   signal udpToPhyRoute : Slv8Array(NUM_RSSI_C-1 downto 0);

   signal axilReset : sl;

begin

   U_axilRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axilClk,
         rstIn  => axilRst,
         rstOut => axilReset);

   ------------------
   -- DMA ASYNC FIFOs
   ------------------
   GEN_DMA : for i in NUM_RSSI_C-1 downto 0 generate
      U_DmaAsyncFifo : entity work.DmaAsyncFifo
         generic map (
            TPD_G => TPD_G)
         port map (
            -- Clocks and Resets
            axilClk      => axilClk,
            axilRst      => axilReset,
            dmaClk       => dmaClk,
            dmaRst       => dmaRst,
            -- UDP Config Interface (axilClk domain)
            udpDest      => udpObDest,
            -- DMA Interface (dmaClk domain)
            dmaObMaster  => dmaObMasters(i),
            dmaObSlave   => dmaObSlaves(i),
            dmaIbMaster  => dmaIbMasters(i),
            dmaIbSlave   => dmaIbSlaves(i),
            -- UDP Interface (axilClk domain)
            udpIbMaster  => udpIbMasters(i),
            udpIbSlave   => udpIbSlaves(i),
            udpObMaster  => udpObMasters(i),
            udpObSlave   => udpObSlaves(i),
            -- RSSI Interface (axilClk domain)
            rssiIbMaster => rssiIbMasters(i),
            rssiIbSlave  => rssiIbSlaves(i),
            rssiObMaster => rssiObMasters(i),
            rssiObSlave  => rssiObSlaves(i));
   end generate GEN_DMA;

   ---------------------
   -- AXI-Lite Crossbar
   ---------------------
   U_XBAR : entity surf.AxiLiteCrossbar
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

   U_XBAR_BUFFER : entity surf.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 1,
         NUM_MASTER_SLOTS_G => NUM_RSSI_C+3,
         MASTERS_CONFIG_G   => BUFF_CONFIG_C)
      port map (
         axiClk              => axilClk,
         axiClkRst           => axilReset,
         sAxiWriteMasters(0) => axilWriteMasters(BUFF_INDEX_C),
         sAxiWriteSlaves(0)  => axilWriteSlaves(BUFF_INDEX_C),
         sAxiReadMasters(0)  => axilReadMasters(BUFF_INDEX_C),
         sAxiReadSlaves(0)   => axilReadSlaves(BUFF_INDEX_C),
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

   ------------
   -- ETH Lanes
   ------------
   GEN_LANE : for i in NUM_RSSI_C-1 downto 0 generate

      U_Lane : entity work.EthLane
         generic map (
            TPD_G              => TPD_G,
            CLK_FREQUENCY_G    => CLK_FREQUENCY_G,
            -----------------------------------------------
            -- WINDOW_ADDR_SIZE_G => 3,    -- 8 buffers (2^3)
            WINDOW_ADDR_SIZE_G => 4,    -- 16 buffers (2^4)
            -----------------------------------------------
            MAX_SEG_SIZE_G     => 1024,
            -- MAX_SEG_SIZE_G     => 8192,
            -----------------------------------------------
            AXI_BASE_ADDR_G    => AXI_CONFIG_C(i).baseAddr)
         port map (
            -- RSSI Interface (axilClk domain)
            rssiIbMaster    => rssiIbMasters(i),
            rssiIbSlave     => rssiIbSlaves(i),
            rssiObMaster    => rssiObMasters(i),
            rssiObSlave     => rssiObSlaves(i),
            -- UDP Interface (axiClk/axilClk domain)
            axiClk          => axilClk,
            axiRst          => axilReset,
            udpIbMaster     => udpIbMasters(i),
            udpIbSlave      => udpIbSlaves(i),
            udpObMaster     => udpObMasters(i),
            udpObSlave      => udpObSlaves(i),
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

   U_Debug : entity work.UdpDebug
      generic map (
         TPD_G => TPD_G)
      port map (
         userClk         => axilClk,
         -- Clock and Reset
         axiClk          => axilClk,
         axiRst          => axilReset,
         -- UDP Outbound Config Interface
         udpObMuxSel     => open,
         udpObDest       => udpObDest,
         udpToPhyRoute   => udpToPhyRoute,
         -- AXI-Lite Interface 
         axilReadMaster  => buffReadMasters(NUM_RSSI_C),
         axilReadSlave   => buffReadSlaves(NUM_RSSI_C),
         axilWriteMaster => buffWriteMasters(NUM_RSSI_C),
         axilWriteSlave  => buffWriteSlaves(NUM_RSSI_C));

end mapping;
