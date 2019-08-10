-------------------------------------------------------------------------------
-- File       : DevBoardApp.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: DevBoardApp File
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
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.SsiPkg.all;
use work.AppPkg.all;

entity DevBoardApp is
   generic (
      TPD_G            : time := 1 ns;
      CLK_FREQUENCY_G  : real := 156.25E+6;  -- units of Hz
      AXIL_BASE_ADDR_G : slv(31 downto 0));
   port (
      -- AXI-Lite Interface
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType;
      -- DEV Board Interface (axilClk domain)
      devIbMaster     : in  AxiStreamMasterType;
      devIbSlave      : out AxiStreamSlaveType;
      devObMaster     : out AxiStreamMasterType;
      devObSlave      : in  AxiStreamSlaveType;
      -- DMA Interface (axilClk domain)
      dmaIbMaster     : out AxiStreamMasterType;
      dmaIbSlave      : in  AxiStreamSlaveType;
      dmaObMaster     : in  AxiStreamMasterType;
      dmaObSlave      : out AxiStreamSlaveType);
end DevBoardApp;

architecture mapping of DevBoardApp is

   constant APP_STREAM_ROUTES_C : Slv8Array := (
      0 => X"00",
      1 => X"01");

   constant NUM_AXIL_MASTERS_C : natural := 2;

   constant AXIL_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXIL_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXIL_MASTERS_C, AXIL_BASE_ADDR_G, 14, 12);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXIL_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXIL_MASTERS_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXIL_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXIL_MASTERS_C-1 downto 0);

   signal txMaster : AxiStreamMasterType;
   signal txSlave  : AxiStreamSlaveType;

   signal rxMaster : AxiStreamMasterType;
   signal rxSlave  : AxiStreamSlaveType;

   signal rxMasterResize : AxiStreamMasterType;
   signal rxSlaveResize  : AxiStreamSlaveType;

begin

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

   U_SsiPrbsTx : entity work.SsiPrbsTx
      generic map (
         TPD_G                      => TPD_G,
         GEN_SYNC_FIFO_G            => true,
         MASTER_AXI_PIPE_STAGES_G   => 1,
         PRBS_SEED_SIZE_G           => 128,
         MASTER_AXI_STREAM_CONFIG_G => APP_AXIS_CONFIG_C)
      port map (
         mAxisClk        => axilClk,
         mAxisRst        => axilRst,
         mAxisMaster     => txMaster,
         mAxisSlave      => txSlave,
         locClk          => axilClk,
         locRst          => axilRst,
         trig            => '0',
         packetLength    => X"000000ff",
         tDest           => X"00",
         tId             => X"00",
         axilReadMaster  => axilReadMasters(0),
         axilReadSlave   => axilReadSlaves(0),
         axilWriteMaster => axilWriteMasters(0),
         axilWriteSlave  => axilWriteSlaves(0));

   U_SsiPrbsRx : entity work.SsiPrbsRx
      generic map (
         TPD_G                     => TPD_G,
         GEN_SYNC_FIFO_G           => true,
         SLAVE_AXI_PIPE_STAGES_G   => 1,
         PRBS_SEED_SIZE_G          => 128,
         SLAVE_AXI_STREAM_CONFIG_G => ssiAxiStreamConfig(8))
      port map (
         sAxisClk       => axilClk,
         sAxisRst       => axilRst,
         sAxisMaster    => rxMasterResize,
         sAxisSlave     => rxSlaveResize,
         axiClk         => axilClk,
         axiRst         => axilRst,
         axiReadMaster  => axilReadMasters(1),
         axiReadSlave   => axilReadSlaves(1),
         axiWriteMaster => axilWriteMasters(1),
         axiWriteSlave  => axilWriteSlaves(1));

   U_RxResize : entity work.AxiStreamResize
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => ssiAxiStreamConfig(8))
      port map (
         -- Clock and reset
         axisClk     => axilClk,
         axisRst     => axilRst,
         -- Slave Port
         sAxisMaster => rxMaster,
         sAxisSlave  => rxSlave,
         -- Master Port
         mAxisMaster => rxMasterResize,
         mAxisSlave  => rxSlaveResize);

   U_AxiStreamDeMux : entity work.AxiStreamDeMux
      generic map (
         TPD_G          => TPD_G,
         PIPE_STAGES_G  => 1,
         NUM_MASTERS_G  => 2,
         MODE_G         => "ROUTED",
         TDEST_ROUTES_G => APP_STREAM_ROUTES_C)
      port map (
         -- Clock and reset
         axisClk         => axilClk,
         axisRst         => axilRst,
         -- Slaves
         sAxisMaster     => devIbMaster,
         sAxisSlave      => devIbSlave,
         -- Master
         mAxisMasters(0) => dmaIbMaster,
         mAxisMasters(1) => rxMaster,
         mAxisSlaves(0)  => dmaIbSlave,
         mAxisSlaves(1)  => rxSlave);

   U_AxiStreamMux : entity work.AxiStreamMux
      generic map (
         TPD_G                => TPD_G,
         NUM_SLAVES_G         => 2,
         MODE_G               => "ROUTED",
         TDEST_ROUTES_G       => APP_STREAM_ROUTES_C,
         ILEAVE_EN_G          => true,
         ILEAVE_ON_NOTVALID_G => true,
         ILEAVE_REARB_G       => (1024/APP_AXIS_CONFIG_C.TDATA_BYTES_C) - 3,  -- AxiStreamPacketizer2.PROTO_WORDS_C=3
         PIPE_STAGES_G        => 1)
      port map (
         -- Clock and reset
         axisClk         => axilClk,
         axisRst         => axilRst,
         -- Slaves
         sAxisMasters(0) => dmaObMaster,
         sAxisMasters(1) => txMaster,
         sAxisSlaves(0)  => dmaObSlave,
         sAxisSlaves(1)  => txSlave,
         -- Master
         mAxisMaster     => devObMaster,
         mAxisSlave      => devObSlave);

end mapping;
