-------------------------------------------------------------------------------
-- File       : EthPhyWrapper.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------
-- This file is part of 'SLAC Firmware Standard Library'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'SLAC Firmware Standard Library', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiStreamPkg.all;
use surf.AxiLitePkg.all;
use surf.EthMacPkg.all;
use surf.TenGigEthPkg.all;

use work.AppPkg.all;

library unisim;
use unisim.vcomponents.all;

entity EthPhyWrapper is
   generic (
      TPD_G           : time := 1 ns;
      AXI_BASE_ADDR_G : slv(31 downto 0));
   port (
      -- Local Configurations
      localMac        : out Slv48Array(NUM_RSSI_C-1 downto 0);
      localIp         : out Slv32Array(NUM_RSSI_C-1 downto 0);
      udpToPhyRoute   : in  Slv8Array(NUM_RSSI_C-1 downto 0);
      -- Streaming DMA Interface 
      udpIbMasters    : out AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      udpIbSlaves     : in  AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      udpObMasters    : in  AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      udpObSlaves     : out AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      -- Slave AXI-Lite Interface 
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType;
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
end EthPhyWrapper;

architecture mapping of EthPhyWrapper is

   constant NUM_AXI_MASTERS_C : natural := 16;

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, AXI_BASE_ADDR_G, 16, 12);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_MASTER_INIT_C);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0)  := (others => AXI_LITE_WRITE_SLAVE_EMPTY_SLVERR_C);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_MASTER_INIT_C);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0)   := (others => AXI_LITE_READ_SLAVE_EMPTY_SLVERR_C);

   signal phyIbMasters : AxiStreamMasterArray(7 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal phyIbSlaves  : AxiStreamSlaveArray(7 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);
   signal phyObMasters : AxiStreamMasterArray(7 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal phyObSlaves  : AxiStreamSlaveArray(7 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);

   signal mac : Slv48Array(7 downto 0) := (others => (others => '0'));
   signal ip  : Slv32Array(7 downto 0) := (others => (others => '0'));

   signal axilReset : sl;

   signal dmaClk     : slv(7 downto 0);
   signal dmaRst     : slv(7 downto 0);
   signal axiLiteClk : slv(7 downto 0);
   signal axiLiteRst : slv(7 downto 0);

   signal gtRefClk     : sl;
   signal gtRefClkBufg : sl;

begin

   dmaClk <= (others => axilClk);
   dmaRst <= (others => axilReset);

   axiLiteClk <= (others => axilClk);
   axiLiteRst <= (others => axilReset);

   -------------------------------
   -- TODO: Add routing logic here 
   -------------------------------
   localMac <= mac(NUM_RSSI_C-1 downto 0);
   localIp  <= ip(NUM_RSSI_C-1 downto 0);

   udpIbMasters                       <= phyObMasters(NUM_RSSI_C-1 downto 0);
   phyObSlaves(NUM_RSSI_C-1 downto 0) <= udpIbSlaves;

   phyIbMasters(NUM_RSSI_C-1 downto 0) <= udpObMasters;
   udpObSlaves                         <= phyIbSlaves(NUM_RSSI_C-1 downto 0);

   -----------------
   -- Reset Pipeline
   -----------------
   U_axilRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axilClk,
         rstIn  => axilRst,
         rstOut => axilReset);

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

   ----------------
   -- 10GigE Module 
   ----------------
   U_QSFP0 : entity surf.TenGigEthGthUltraScaleWrapper
      generic map (
         TPD_G         => TPD_G,
         NUM_LANE_G    => 4,
         EN_AXI_REG_G  => true,
         EXT_REF_G     => false,        -- false: Use gtClkP/gtClkN
         -- AXI Streaming Configurations
         AXIS_CONFIG_G => (others => EMAC_AXIS_CONFIG_C))
      port map (
         -- Local Configurations
         localMac            => mac(3 downto 0),
         -- Streaming DMA Interface 
         dmaClk              => dmaClk(3 downto 0),
         dmaRst              => dmaRst(3 downto 0),
         dmaIbMasters        => phyObMasters(3 downto 0),
         dmaIbSlaves         => phyObSlaves(3 downto 0),
         dmaObMasters        => phyIbMasters(3 downto 0),
         dmaObSlaves         => phyIbSlaves(3 downto 0),
         -- Slave AXI-Lite Interface 
         axiLiteClk          => axiLiteClk(3 downto 0),
         axiLiteRst          => axiLiteRst(3 downto 0),
         axiLiteReadMasters  => axilReadMasters(3 downto 0),
         axiLiteReadSlaves   => axilReadSlaves(3 downto 0),
         axiLiteWriteMasters => axilWriteMasters(3 downto 0),
         axiLiteWriteSlaves  => axilWriteSlaves(3 downto 0),
         -- Misc. Signals
         extRst              => axilReset,
         -- MGT Clock Port
         gtClkP              => qsfpRefClkP,
         gtClkN              => qsfpRefClkN,
         gtClk               => gtRefClk,
         coreClk             => gtRefClkBufg,
         -- MGT Ports
         gtTxP               => qsfp0TxP,
         gtTxN               => qsfp0TxN,
         gtRxP               => qsfp0RxP,
         gtRxN               => qsfp0RxN);

   U_QSFP1 : entity surf.TenGigEthGthUltraScaleWrapper
      generic map (
         TPD_G         => TPD_G,
         NUM_LANE_G    => 4,
         EN_AXI_REG_G  => true,
         EXT_REF_G     => true,         -- true: Use gtRefClk/gtRefClkBufg
         -- AXI Streaming Configurations
         AXIS_CONFIG_G => (others => EMAC_AXIS_CONFIG_C))
      port map (
         -- Local Configurations
         localMac            => mac(7 downto 4),
         -- Streaming DMA Interface 
         dmaClk              => dmaClk(7 downto 4),
         dmaRst              => dmaRst(7 downto 4),
         dmaIbMasters        => phyObMasters(7 downto 4),
         dmaIbSlaves         => phyObSlaves(7 downto 4),
         dmaObMasters        => phyIbMasters(7 downto 4),
         dmaObSlaves         => phyIbSlaves(7 downto 4),
         -- Slave AXI-Lite Interface 
         axiLiteClk          => axiLiteClk(7 downto 4),
         axiLiteRst          => axiLiteRst(7 downto 4),
         axiLiteReadMasters  => axilReadMasters(7 downto 4),
         axiLiteReadSlaves   => axilReadSlaves(7 downto 4),
         axiLiteWriteMasters => axilWriteMasters(7 downto 4),
         axiLiteWriteSlaves  => axilWriteSlaves(7 downto 4),
         -- Misc. Signals
         extRst              => axilReset,
         -- MGT Clock Port
         gtRefClk            => gtRefClk,
         gtRefClkBufg        => gtRefClkBufg,
         -- MGT Ports
         gtTxP               => qsfp1TxP,
         gtTxN               => qsfp1TxN,
         gtRxP               => qsfp1RxP,
         gtRxN               => qsfp1RxN);

   GEN_VEC : for i in 7 downto 0 generate

      U_EthConfig : entity work.EthConfig
         generic map (
            TPD_G => TPD_G)
         port map (
            localIp         => ip(i),
            localMac        => mac(i),
            gtTxPreCursor   => open,
            gtTxPostCursor  => open,
            gtTxDiffCtrl    => open,
            -- AXI-Lite Register Interface (axilClk domain)
            axilClk         => axilClk,
            axilRst         => axilReset,
            axilReadMaster  => axilReadMasters(i+8),
            axilReadSlave   => axilReadSlaves(i+8),
            axilWriteMaster => axilWriteMasters(i+8),
            axilWriteSlave  => axilWriteSlaves(i+8));

   end generate GEN_VEC;

end mapping;
