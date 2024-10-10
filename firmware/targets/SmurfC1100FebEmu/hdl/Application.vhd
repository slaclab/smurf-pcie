-------------------------------------------------------------------------------
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- This file is part of 'lcls2-pgp-pcie-apps'.
-- It is subject to the license terms in the LICENSE.txt file found in the
-- top-level directory of this distribution and at:
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
-- No part of 'lcls2-pgp-pcie-apps', including this file,
-- may be copied, modified, propagated, or distributed except according to
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiLitePkg.all;
use surf.AxiStreamPkg.all;

entity Application is
   generic (
      TPD_G             : time := 1 ns;
      BUILD_INFO_G      : BuildInfoType;
      DMA_AXIS_CONFIG_G : AxiStreamConfigType);
   port (
      ------------------------
      --  Top Level Interfaces
      ------------------------
      -- AXI-Lite Clock and Reset
      axilClk      : in  sl;
      axilRst      : in  sl;
      -- DMA Interface (dmaClk domain)
      dmaClk       : in  sl;
      dmaRst       : in  sl;
      dmaIbMasters : out AxiStreamMasterArray(5 downto 0);
      dmaIbSlaves  : in  AxiStreamSlaveArray(5 downto 0);
      dmaObMasters : in  AxiStreamMasterArray(5 downto 0);
      dmaObSlaves  : out AxiStreamSlaveArray(5 downto 0);
      ------------------
      --  Hardware Ports
      ------------------
      -- QSFP[0] Ports
      qsfp0RefClkP : in  sl;
      qsfp0RefClkN : in  sl;
      qsfp0RxP     : in  slv(3 downto 0);
      qsfp0RxN     : in  slv(3 downto 0);
      qsfp0TxP     : out slv(3 downto 0);
      qsfp0TxN     : out slv(3 downto 0);
      -- QSFP[1] Ports
      qsfp1RefClkP : in  sl;
      qsfp1RefClkN : in  sl;
      qsfp1RxP     : in  slv(3 downto 0);
      qsfp1RxN     : in  slv(3 downto 0);
      qsfp1TxP     : out slv(3 downto 0);
      qsfp1TxN     : out slv(3 downto 0));
end Application;

architecture mapping of Application is

   constant NUM_LANES_C : positive := 6;

   constant ETH_MAC_C : Slv48Array(AXIS_SIZE_C-1 downto 0) := (
      0 => x"00FFFF_564400",            -- 00:44:56:FF:FF:00
      1 => x"01FFFF_564400",            -- 00:44:56:FF:FF:01
      2 => x"02FFFF_564400",            -- 00:44:56:FF:FF:02
      3 => x"03FFFF_564400",            -- 00:44:56:FF:FF:03
      4 => x"04FFFF_564400",            -- 00:44:56:FF:FF:04
      5 => x"05FFFF_564400");           -- 00:44:56:FF:FF:05

   constant ETH_IP_C : Slv32Array(AXIS_SIZE_C-1 downto 0) := (
      0 => x"0A_02_A8_C0",              -- 192.168.2.10
      1 => x"0B_02_A8_C0",              -- 192.168.2.11
      2 => x"0C_02_A8_C0",              -- 192.168.2.12
      3 => x"0D_02_A8_C0",              -- 192.168.2.13
      4 => x"0E_02_A8_C0",              -- 192.168.2.14
      5 => x"0F_02_A8_C0");             -- 192.168.2.15

   signal obMacMasters : AxiStreamMasterArray(NUM_LANES_C-1 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal obMacSlaves  : AxiStreamSlaveArray(NUM_LANES_C-1 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);
   signal ibMacMasters : AxiStreamMasterArray(NUM_LANES_C-1 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal ibMacSlaves  : AxiStreamSlaveArray(NUM_LANES_C-1 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);

   signal phyWriteMasters : AxiLiteWriteMasterArray(NUM_LANES_C-1 downto 0) := (others => AXI_LITE_WRITE_MASTER_INIT_C);
   signal phyWriteSlaves  : AxiLiteWriteSlaveArray(NUM_LANES_C-1 downto 0)  := (others => AXI_LITE_WRITE_SLAVE_EMPTY_DECERR_C);
   signal phyReadMasters  : AxiLiteReadMasterArray(NUM_LANES_C-1 downto 0)  := (others => AXI_LITE_READ_MASTER_INIT_C);
   signal phyReadSlaves   : AxiLiteReadSlaveArray(NUM_LANES_C-1 downto 0)   := (others => AXI_LITE_READ_SLAVE_EMPTY_DECERR_C);

   signal dbgWriteMasters : AxiLiteWriteMasterArray(NUM_LANES_C-1 downto 0) := (others => AXI_LITE_WRITE_MASTER_INIT_C);
   signal dbgWriteSlaves  : AxiLiteWriteSlaveArray(NUM_LANES_C-1 downto 0)  := (others => AXI_LITE_WRITE_SLAVE_EMPTY_DECERR_C);
   signal dbgReadMasters  : AxiLiteReadMasterArray(NUM_LANES_C-1 downto 0)  := (others => AXI_LITE_READ_MASTER_INIT_C);
   signal dbgReadSlaves   : AxiLiteReadSlaveArray(NUM_LANES_C-1 downto 0)   := (others => AXI_LITE_READ_SLAVE_EMPTY_DECERR_C);


begin

   ------------------
   -- 10 GigE Modules
   ------------------
   U_QSFP0 : entity surf.TenGigEthGtyUltraScaleWrapper
      generic map (
         TPD_G        => TPD_G,
         NUM_LANE_G   => 4,
         EN_AXI_REG_G => true)
      port map (
         -- Local Configurations
         localMac            => ETH_MAC_C(3 downto 0),
         -- Streaming DMA Interface
         dmaClk              => axilClk,
         dmaRst              => axilRst,
         dmaIbMasters        => obMacMasters(3 downto 0),
         dmaIbSlaves         => obMacSlaves(3 downto 0),
         dmaObMasters        => ibMacMasters(3 downto 0),
         dmaObSlaves         => ibMacSlaves(3 downto 0),
         -- Misc. Signals
         extRst              => axilRst,
         -- Slave AXI-Lite Interface
         axiLiteClk          => axilClk,
         axiLiteRst          => axilRst,
         axiLiteReadMasters  => phyReadMasters(3 downto 0),
         axiLiteReadSlaves   => phyReadSlaves(3 downto 0),
         axiLiteWriteMasters => phyWriteMasters(3 downto 0),
         axiLiteWriteSlaves  => phyWriteSlaves(3 downto 0),
         -- MGT Clock Port
         gtClkP              => qsfp0RefClkP,
         gtClkN              => qsfp0RefClkN,
         -- MGT Ports
         gtTxP               => qsfp0TxP,
         gtTxN               => qsfp0TxN,
         gtRxP               => qsfp0RxP,
         gtRxN               => qsfp0RxN);

   U_QSFP1 : entity surf.TenGigEthGtyUltraScaleWrapper
      generic map (
         TPD_G        => TPD_G,
         NUM_LANE_G   => 2,
         EN_AXI_REG_G => true)
      port map (
         -- Local Configurations
         localMac            => ETH_MAC_C(5 downto 4),
         -- Streaming DMA Interface
         dmaClk              => axilClk,
         dmaRst              => axilRst,
         dmaIbMasters        => obMacMasters(5 downto 4),
         dmaIbSlaves         => obMacSlaves(5 downto 4),
         dmaObMasters        => ibMacMasters(5 downto 4),
         dmaObSlaves         => ibMacSlaves(5 downto 4),
         -- Misc. Signals
         extRst              => axilRst,
         -- Slave AXI-Lite Interface
         axiLiteClk          => axilClk,
         axiLiteRst          => axilRst,
         axiLiteReadMasters  => phyReadMasters(5 downto 4),
         axiLiteReadSlaves   => phyReadSlaves(5 downto 4),
         axiLiteWriteMasters => phyWriteMasters(5 downto 4),
         axiLiteWriteSlaves  => phyWriteSlaves(5 downto 4),
         -- MGT Clock Port
         gtClkP              => qsfp1RefClkP,
         gtClkN              => qsfp1RefClkN,
         -- MGT Ports
         gtTxP               => qsfp1TxP,
         gtTxN               => qsfp1TxN,
         gtRxP               => qsfp1RxP,
         gtRxN               => qsfp1RxN);

   --------------------
   -- Unused QSFP Links
   --------------------
   U_TERM : entity surf.Gtye4ChannelDummy
      generic map (
         TPD_G   => TPD_G,
         WIDTH_G => 2)
      port map (
         refClk => axilClk,
         gtRxP  => qsfp1RxP(3 downto 2),
         gtRxN  => qsfp1RxN(3 downto 2),
         gtTxP  => qsfp1TxP(3 downto 2),
         gtTxN  => qsfp1TxN(3 downto 2));

   --------------
   -- Application Lane
   --------------
   GEN_LANE :
   for i in NUM_LANES_C-1 downto 0 generate

      ------------------------------------------------
      -- Backdoor debugging path if RSSI link locks up
      ------------------------------------------------
      U_SRPv3 : entity surf.SrpV3AxiLite
         generic map (
            TPD_G               => TPD_G,
            SLAVE_READY_EN_G    => true,
            GEN_SYNC_FIFO_G     => false,
            AXI_STREAM_CONFIG_G => DMA_AXIS_CONFIG_G)
         port map (
            -- Streaming Slave (Rx) Interface (sAxisClk domain)
            sAxisClk         => dmaClk,
            sAxisRst         => dmaRst,
            sAxisMaster      => dmaObMasters(i),
            sAxisSlave       => dmaObSlaves(i),
            -- Streaming Master (Tx) Data Interface (mAxisClk domain)
            mAxisClk         => dmaClk,
            mAxisRst         => dmaRst,
            mAxisMaster      => dmaIbMasters(i),
            mAxisSlave       => dmaIbSlaves(i),
            -- Master AXI-Lite Interface (axilClk domain)
            axilClk          => axilClk,
            axilRst          => axilRst,
            mAxilReadMaster  => dbgReadMasters(i),
            mAxilReadSlave   => dbgReadSlaves(i),
            mAxilWriteMaster => dbgWriteMasters(i),
            mAxilWriteSlave  => dbgWriteSlaves(i));

      -------------------
      -- Application Lane
      -------------------
      U_Lane : entity work.AppLane
         generic map (
            TPD_G        => TPD_G,
            BUILD_INFO_G => BUILD_INFO_G)
         port map (
            -- Local Configurations
            localMac       => ETH_MAC_C(i),
            localIp        => ETH_IP_C(i),
            -- ETH PHY AXI Stream Interfaces
            obMacMaster    => obMacMasters(i),
            obMacSlave     => obMacSlaves(i),
            ibMacMaster    => ibMacMasters(i),
            ibMacSlave     => ibMacSlaves(i),
            -- ETH PHY AXI-Lite Interfaces
            phyReadMaster  => phyReadMasters(i),
            phyReadSlave   => phyReadSlaves(i),
            phyWriteMaster => phyWriteMasters(i),
            phyWriteSlave  => phyWriteSlaves(i),
            -- Backdoor AXI-Lite Interfaces
            dbgReadMaster  => dbgReadMasters(i),
            dbgReadSlave   => dbgReadSlaves(i),
            dbgWriteMaster => dbgWriteMasters(i),
            dbgWriteSlave  => dbgWriteSlaves(i));

   end generate GEN_LANE;

end mapping;
