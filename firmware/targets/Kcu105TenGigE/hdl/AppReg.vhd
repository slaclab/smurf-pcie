-------------------------------------------------------------------------------
-- File       : AppReg.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2017-02-15
-- Last update: 2019-08-01
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------
-- This file is part of 'Example Project Firmware'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'Example Project Firmware', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.StdRtlPkg.all;
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.SsiPkg.all;
use work.EthMacPkg.all;

entity AppReg is
   generic (
      TPD_G             : time    := 1 ns;
      BUILD_INFO_G      : BuildInfoType;
      PRBS_TX_BATCHER_G : boolean := false;
      CLK_FREQUENCY_G   : real    := 156.25E+6;
      XIL_DEVICE_G      : string  := "7SERIES");
   port (
      -- Clock and Reset
      clk             : in  sl;
      rst             : in  sl;
      -- AXI-Lite interface
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      -- Communication AXI-Lite Interface
      commWriteMaster : out AxiLiteWriteMasterType;
      commWriteSlave  : in  AxiLiteWriteSlaveType;
      commReadMaster  : out AxiLiteReadMasterType;
      commReadSlave   : in  AxiLiteReadSlaveType;
      -- ETH PHY AXI-Lite Interface
      phyWriteMaster  : out AxiLiteWriteMasterType;
      phyWriteSlave   : in  AxiLiteWriteSlaveType;
      phyReadMaster   : out AxiLiteReadMasterType;
      phyReadSlave    : in  AxiLiteReadSlaveType;
      -- PBRS Interface
      pbrsTxMaster    : out AxiStreamMasterType;
      pbrsTxSlave     : in  AxiStreamSlaveType;
      pbrsRxMaster    : in  AxiStreamMasterType;
      pbrsRxSlave     : out AxiStreamSlaveType;
      -- HLS Interface
      hlsTxMaster     : out AxiStreamMasterType := AXI_STREAM_MASTER_INIT_C;
      hlsTxSlave      : in  AxiStreamSlaveType;
      hlsRxMaster     : in  AxiStreamMasterType;
      hlsRxSlave      : out AxiStreamSlaveType  := AXI_STREAM_SLAVE_FORCE_C;
      -- MB Interface
      mbTxMaster      : out AxiStreamMasterType := AXI_STREAM_MASTER_INIT_C;
      mbTxSlave       : in  AxiStreamSlaveType;
      -- ADC Ports
      vPIn            : in  sl;
      vNIn            : in  sl);
end AppReg;

architecture mapping of AppReg is

   constant NUM_AXI_MASTERS_C : natural := 5;

   constant VERSION_INDEX_C : natural := 0;
   constant PRBS_TX_INDEX_C : natural := 1;
   constant PRBS_RX_INDEX_C : natural := 2;
   constant COMM_INDEX_C    : natural := 3;
   constant PHY_INDEX_C     : natural := 4;

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := (
      VERSION_INDEX_C => (
         baseAddr     => x"0000_0000",
         addrBits     => 16,
         connectivity => x"FFFF"),
      PRBS_TX_INDEX_C => (
         baseAddr     => x"0004_0000",
         addrBits     => 16,
         connectivity => x"FFFF"),
      PRBS_RX_INDEX_C => (
         baseAddr     => x"0005_0000",
         addrBits     => 16,
         connectivity => x"FFFF"),
      COMM_INDEX_C    => (
         baseAddr     => x"0007_0000",
         addrBits     => 16,
         connectivity => x"FFFF"),
      PHY_INDEX_C     => (
         baseAddr     => x"8000_0000",
         addrBits     => 31,
         connectivity => x"FFFF"));

   signal mAxilWriteMaster : AxiLiteWriteMasterType;
   signal mAxilWriteSlave  : AxiLiteWriteSlaveType;
   signal mAxilReadMaster  : AxiLiteReadMasterType;
   signal mAxilReadSlave   : AxiLiteReadSlaveType;

   signal mAxilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal mAxilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_SLAVE_EMPTY_DECERR_C);
   signal mAxilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal mAxilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_SLAVE_EMPTY_DECERR_C);

begin

   ---------------------------
   -- AXI-Lite Crossbar Module
   ---------------------------         
   U_XBAR : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 2,
         NUM_MASTER_SLOTS_G => NUM_AXI_MASTERS_C,
         MASTERS_CONFIG_G   => AXI_CONFIG_C)
      port map (
         sAxiWriteMasters(0) => axilWriteMaster,
         sAxiWriteMasters(1) => mAxilWriteMaster,
         sAxiWriteSlaves(0)  => axilWriteSlave,
         sAxiWriteSlaves(1)  => mAxilWriteSlave,
         sAxiReadMasters(0)  => axilReadMaster,
         sAxiReadMasters(1)  => mAxilReadMaster,
         sAxiReadSlaves(0)   => axilReadSlave,
         sAxiReadSlaves(1)   => mAxilReadSlave,
         mAxiWriteMasters    => mAxilWriteMasters,
         mAxiWriteSlaves     => mAxilWriteSlaves,
         mAxiReadMasters     => mAxilReadMasters,
         mAxiReadSlaves      => mAxilReadSlaves,
         axiClk              => clk,
         axiClkRst           => rst);

   ---------------------------
   -- AXI-Lite: Version Module
   ---------------------------            
   U_AxiVersion : entity work.AxiVersion
      generic map (
         TPD_G           => TPD_G,
         CLK_PERIOD_G    => (1.0/CLK_FREQUENCY_G),
         BUILD_INFO_G    => BUILD_INFO_G,
         XIL_DEVICE_G    => XIL_DEVICE_G,
         EN_DEVICE_DNA_G => false)
      port map (
         axiReadMaster  => mAxilReadMasters(VERSION_INDEX_C),
         axiReadSlave   => mAxilReadSlaves(VERSION_INDEX_C),
         axiWriteMaster => mAxilWriteMasters(VERSION_INDEX_C),
         axiWriteSlave  => mAxilWriteSlaves(VERSION_INDEX_C),
         axiClk         => clk,
         axiRst         => rst);

   -------------------
   -- AXI-Lite PRBS RX
   -------------------
   U_SsiPrbsTx : entity work.SsiPrbsTx
      generic map (
         TPD_G                      => TPD_G,
         AXI_DEFAULT_PKT_LEN_G      => X"000000FF"
         MASTER_AXI_PIPE_STAGES_G   => 1,
         PRBS_SEED_SIZE_G           => 128,
         -- MASTER_AXI_STREAM_CONFIG_G => ssiAxiStreamConfig(16))
         MASTER_AXI_STREAM_CONFIG_G => EMAC_AXIS_CONFIG_C)
      port map (
         mAxisClk        => clk,
         mAxisRst        => rst,
         mAxisMaster     => pbrsTxMaster,
         mAxisSlave      => pbrsTxSlave,
         locClk          => clk,
         locRst          => rst,
         axilReadMaster  => mAxilReadMasters(PRBS_TX_INDEX_C),
         axilReadSlave   => mAxilReadSlaves(PRBS_TX_INDEX_C),
         axilWriteMaster => mAxilWriteMasters(PRBS_TX_INDEX_C),
         axilWriteSlave  => mAxilWriteSlaves(PRBS_TX_INDEX_C));

   -------------------
   -- AXI-Lite PRBS RX
   -------------------
   U_SsiPrbsRx : entity work.SsiPrbsRx
      generic map (
         TPD_G                     => TPD_G,
         SLAVE_AXI_PIPE_STAGES_G   => 1,
         PRBS_SEED_SIZE_G          => 128,
         -- SLAVE_AXI_STREAM_CONFIG_G => ssiAxiStreamConfig(16))
         SLAVE_AXI_STREAM_CONFIG_G => EMAC_AXIS_CONFIG_C)
      port map (
         sAxisClk       => clk,
         sAxisRst       => rst,
         sAxisMaster    => pbrsRxMaster,
         sAxisSlave     => pbrsRxSlave,
         axiClk         => clk,
         axiRst         => rst,
         axiReadMaster  => mAxilReadMasters(PRBS_RX_INDEX_C),
         axiReadSlave   => mAxilReadSlaves(PRBS_RX_INDEX_C),
         axiWriteMaster => mAxilWriteMasters(PRBS_RX_INDEX_C),
         axiWriteSlave  => mAxilWriteSlaves(PRBS_RX_INDEX_C));

   -----------------------------------------------
   -- Map the AXI-Lite to Communication Monitoring
   -----------------------------------------------
   commReadMaster                 <= mAxilReadMasters(COMM_INDEX_C);
   mAxilReadSlaves(COMM_INDEX_C)  <= commReadSlave;
   commWriteMaster                <= mAxilWriteMasters(COMM_INDEX_C);
   mAxilWriteSlaves(COMM_INDEX_C) <= commWriteSlave;

   -----------------------------------------------
   -- Map the AXI-Lite to Ethernet PHY Monitoring
   -----------------------------------------------
   phyReadMaster                 <= mAxilReadMasters(PHY_INDEX_C);
   mAxilReadSlaves(PHY_INDEX_C)  <= phyReadSlave;
   phyWriteMaster                <= mAxilWriteMasters(PHY_INDEX_C);
   mAxilWriteSlaves(PHY_INDEX_C) <= phyWriteSlave;

end mapping;
