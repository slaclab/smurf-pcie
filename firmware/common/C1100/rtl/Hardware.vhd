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
      ---------------------
      --  Hardware Ports
      ---------------------
      -- QSFP[0] Ports
      qsfp0RefClkP    : in  sl;
      qsfp0RefClkN    : in  sl;
      qsfp0RxP        : in  slv(3 downto 0);
      qsfp0RxN        : in  slv(3 downto 0);
      qsfp0TxP        : out slv(3 downto 0);
      qsfp0TxN        : out slv(3 downto 0);
      -- QSFP[1] Ports
      qsfp1RefClkP    : in  sl;
      qsfp1RefClkN    : in  sl;
      qsfp1RxP        : in  slv(3 downto 0);
      qsfp1RxN        : in  slv(3 downto 0);
      qsfp1TxP        : out slv(3 downto 0);
      qsfp1TxN        : out slv(3 downto 0));
end Hardware;

architecture mapping of Hardware is

   constant PHY_INDEX_C       : natural := NUM_RSSI_C;
   constant NUM_AXI_MASTERS_C : natural := NUM_RSSI_C+1;

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, AXI_BASE_ADDR_G, 20, 16);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

   signal macObMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal macObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal macIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal macIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal udpObMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal udpObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal rssiIbMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal rssiIbSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal rssiObMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal rssiObSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal localMac : Slv48Array(NUM_RSSI_C-1 downto 0);
   signal localIp  : Slv32Array(NUM_RSSI_C-1 downto 0);

   signal axilReset   : sl;
   signal dmaPriReset : sl;
   signal dmaSecReset : sl;

begin

   U_axilRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axilClk,
         rstIn  => axilRst,
         rstOut => axilReset);

   U_dmaPriRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => dmaPriClk,
         rstIn  => dmaPriRst,
         rstOut => dmaPriReset);

   U_dmaSecRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => dmaSecClk,
         rstIn  => dmaSecRst,
         rstOut => dmaSecReset);

   GEN_FIFO : for i in NUM_RSSI_C-1 downto 0 generate

      U_DMA_to_RSSI : entity surf.AxiStreamFifoV2
         generic map (
            -- General Configurations
            TPD_G               => TPD_G,
            INT_PIPE_STAGES_G   => 1,
            PIPE_STAGES_G       => 1,
            -- FIFO configurations
            MEMORY_TYPE_G       => "distributed",
            GEN_SYNC_FIFO_G     => false,
            FIFO_ADDR_WIDTH_G   => 4,
            -- AXI Stream Port Configurations
            SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
            MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
         port map (
            -- Slave Port
            sAxisClk    => dmaPriClk,
            sAxisRst    => dmaPriReset,
            sAxisMaster => dmaPriObMasters(i),
            sAxisSlave  => dmaPriObSlaves(i),
            -- Master Port
            mAxisClk    => axilClk,
            mAxisRst    => axilReset,
            mAxisMaster => rssiIbMasters(i),
            mAxisSlave  => rssiIbSlaves(i));

      U_RSSI_to_DMA : entity surf.AxiStreamFifoV2
         generic map (
            -- General Configurations
            TPD_G               => TPD_G,
            INT_PIPE_STAGES_G   => 1,
            PIPE_STAGES_G       => 1,
            -- FIFO configurations
            MEMORY_TYPE_G       => "distributed",
            GEN_SYNC_FIFO_G     => false,
            FIFO_ADDR_WIDTH_G   => 4,
            -- AXI Stream Port Configurations
            SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
            MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
         port map (
            -- Slave Port
            sAxisClk    => axilClk,
            sAxisRst    => axilReset,
            sAxisMaster => rssiObMasters(i),
            sAxisSlave  => rssiObSlaves(i),
            -- Master Port
            mAxisClk    => dmaPriClk,
            mAxisRst    => dmaPriReset,
            mAxisMaster => dmaPriIbMasters(i),
            mAxisSlave  => dmaPriIbSlaves(i));

      -- Unused DMA stream
      dmaSecObSlaves(i) <= AXI_STREAM_SLAVE_FORCE_C;

      U_RAW_UDP_to_DMA : entity surf.AxiStreamFifoV2
         generic map (
            -- General Configurations
            TPD_G               => TPD_G,
            INT_PIPE_STAGES_G   => 1,
            PIPE_STAGES_G       => 1,
            -- FIFO configurations
            MEMORY_TYPE_G       => "distributed",
            GEN_SYNC_FIFO_G     => false,
            FIFO_ADDR_WIDTH_G   => 4,
            -- AXI Stream Port Configurations
            SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
            MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
         port map (
            -- Slave Port
            sAxisClk    => axilClk,
            sAxisRst    => axilReset,
            sAxisMaster => udpObMasters(i),
            sAxisSlave  => udpObSlaves(i),
            -- Master Port
            mAxisClk    => dmaSecClk,
            mAxisRst    => dmaSecReset,
            mAxisMaster => dmaSecIbMasters(i),
            mAxisSlave  => dmaSecIbSlaves(i));

   end generate GEN_FIFO;

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
            MEMORY_TYPE_G   => "ultra",
            AXI_BASE_ADDR_G => AXI_CONFIG_C(i).baseAddr)
         port map (
            -- RSSI Interface (axilClk domain)
            rssiIbMaster    => rssiIbMasters(i),
            rssiIbSlave     => rssiIbSlaves(i),
            rssiObMaster    => rssiObMasters(i),
            rssiObSlave     => rssiObSlaves(i),
            -- UDP Interface (axiClk/axilClk domain)
            axiClk          => axilClk,
            axiRst          => axilReset,
            udpIbMaster     => AXI_STREAM_MASTER_INIT_C,  -- Unused in EthLane.vhd
            udpIbSlave      => open,
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

end mapping;
