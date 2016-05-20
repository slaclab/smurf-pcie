-------------------------------------------------------------------------------
-- Title      : 
-------------------------------------------------------------------------------
-- File       : PgpFrontEnd.vhd
-- Author     : Benjamin Reese  <bareese@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2013-08-22
-- Last update: 2015-10-13
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- This file is part of 'LCLS2 LLRF Development'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 LLRF Development', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

use work.StdRtlPkg.all;
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.Pgp2bPkg.all;

entity PgpFrontEnd is
   
   generic (
      TPD_G                  : time    := 1 ns;
      SIMULATION_G           : boolean := false;
      PGP_REFCLK_FREQ_G      : real    := 156.25E6;
      PGP_LINE_RATE_G        : real    := 3.125E9;
      PGP_CLK_FREQ_G         : real    := 156.25E6;
      AXIL_CLK_FREQ_G        : real    := 156.25E6;
      AXIS_CLK_FREQ_G        : real    := 185.0E6;
      AXIS_FIFO_ADDR_WIDTH_G : integer := 9;
      CASCADE_SIZE_G         : integer range 1 to (2**24) := 1;
      AXIS_CONFIG_G          : AxiStreamConfigType
      );
   port (
      stableClk : in sl;

      pgpRefClk : in sl;
      pgpClk    : in sl;
      pgpClkRst : in sl;

      -- PGP MGT signals
      pgpGtRxN : in  sl;                -- SFP+ 
      pgpGtRxP : in  sl;
      pgpGtTxN : out sl;
      pgpGtTxP : out sl;
      --
      masterReset : out sl;
      
      -- AXI-Lite master register interface
      axilClk         : in  sl;
      axilClkRst      : in  sl;
      axilWriteMaster : out AxiLiteWriteMasterType;
      axilWriteSlave  : in  AxiLiteWriteSlaveType;
      axilReadMaster  : out AxiLiteReadMasterType;
      axilReadSlave   : in  AxiLiteReadSlaveType;

      -- AXI Stream data interface
      axisClk       : in  sl; -- Unused
      axisClkRst    : in  sl; -- Unused
      axisTxMasters : in  AxiStreamMasterArray(1 downto 0);
      axisTxSlaves  : out AxiStreamSlaveArray(1 downto 0);
      axisTxCtrl    : out AxiStreamCtrlArray(1 downto 0); -- Unused

      leds : out slv(1 downto 0));


end entity PgpFrontEnd;

architecture rtl of PgpFrontEnd is

   constant PGP_REFCLK_PERIOD_C : real := 1.0 / PGP_REFCLK_FREQ_G;

   -------------------------------------------------------------------------------------------------
   -- PGP MGT PLL Config
   -------------------------------------------------------------------------------------------------
--   constant PGP_GTX_CPLL_CFG_C : Gtx7CPllCfgType := getGtx7CPllCfg(PGP_REFCLK_FREQ_G, PGP_LINE_RATE_G);

   -------------------------------------------------------------------------------------------------
   -- AXI Lite Config and Signals
   -------------------------------------------------------------------------------------------------
   constant NUM_AXI_MASTERS_C : natural := 3;

   constant VERSION_INDEX_C : natural := 0;
   constant PGP_AXI_INDEX_C : natural := 1;
   constant APP_INDEX_C     : natural := 2;
   
   constant VERSION_ADDR_C      : slv(31 downto 0) := X"00000000";
   constant PGP_AXI_BASE_ADDR_C : slv(31 downto 0) := X"01000000";
   constant APP_ADDR_C          : slv(31 downto 0) := X"80000000";
      
   constant AXI_CROSSBAR_MASTERS_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := (
      VERSION_INDEX_C => (
         baseAddr     => VERSION_ADDR_C,
         addrBits     => 14,
         connectivity => X"0001"),
      PGP_AXI_INDEX_C => (
         baseAddr     => PGP_AXI_BASE_ADDR_C,
         addrBits     => 14,
         connectivity => X"0001"),
      APP_INDEX_C     => (
         baseAddr     => APP_ADDR_C,
         addrBits     => 31,
         connectivity => X"0001"));

   signal mAxilWriteMaster : AxiLiteWriteMasterType;
   signal mAxilWriteSlave  : AxiLiteWriteSlaveType;
   signal mAxilReadMaster  : AxiLiteReadMasterType;
   signal mAxilReadSlave   : AxiLiteReadSlaveType;

   signal sAxilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal sAxilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal sAxilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal sAxilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

   -------------------------------------------------------------------------------------------------
   -- PGP Signals and Virtual Channels
   -------------------------------------------------------------------------------------------------
   signal pgpTxIn      : Pgp2bTxInType;
   signal pgpTxOut     : Pgp2bTxOutType;
   signal pgpRxIn      : Pgp2bRxInType;
   signal pgpRxOut     : Pgp2bRxOutType;
   signal pgpTxMasters : AxiStreamMasterArray(3 downto 0) := (others=>AXI_STREAM_MASTER_INIT_C);
   signal pgpTxSlaves  : AxiStreamSlaveArray(3 downto 0)  := (others=>AXI_STREAM_SLAVE_FORCE_C);
   signal pgpRxMasters : AxiStreamMasterArray(3 downto 0) := (others=>AXI_STREAM_MASTER_INIT_C);
   signal pgpRxCtrl    : AxiStreamCtrlArray(3 downto 0)   := (others=>AXI_STREAM_CTRL_UNUSED_C);
   
begin
   -------------------------------------------------------------------------------------------------
   -- AXI Stream input assignment
   -------------------------------------------------------------------------------------------------
   ADC_AXI_STREAMS : for i in 1 downto 0 generate
      pgpTxMasters(i+1) <= axisTxMasters(i);
      axisTxSlaves(i)   <= pgpTxSlaves(i+1);
   end generate ADC_AXI_STREAMS;

   -------------------------------------------------------------------------------------------------
   -- PGP / MGT
   -------------------------------------------------------------------------------------------------
   REAL_PGP : if (not SIMULATION_G) generate
      
      Pgp2bGthUltra_1 : entity work.Pgp2bGthUltra
         generic map (
            TPD_G             => TPD_G,
            PAYLOAD_CNT_TOP_G => 7,
            VC_INTERLEAVE_G   => 0,
            NUM_VC_EN_G       => 3)
         port map (
            stableClk        => stableClk,
            gtRefClk         => pgpRefClk,
            pgpGtTxP         => pgpGtTxP,
            pgpGtTxN         => pgpGtTxN,
            pgpGtRxP         => pgpGtRxP,
            pgpGtRxN         => pgpGtRxN,
            pgpTxReset       => pgpClkRst,
            pgpTxRecClk      => open,
            pgpTxClk         => pgpClk,
            pgpTxMmcmLocked  => '1',
            pgpRxReset       => pgpClkRst,
            pgpRxRecClk      => open,
            pgpRxClk         => pgpClk,
            pgpRxMmcmLocked  => '1',
            pgpRxIn          => pgpRxIn,
            pgpRxOut         => pgpRxOut,
            pgpTxIn          => pgpTxIn,
            pgpTxOut         => pgpTxOut,
            pgpTxMasters     => pgpTxMasters,
            pgpTxSlaves      => pgpTxSlaves,
            pgpRxMasters     => pgpRxMasters,
            pgpRxMasterMuxed => open,
            pgpRxCtrl        => pgpRxCtrl);

   end generate REAL_PGP;

   SIM_PGP : if (SIMULATION_G) generate
      PgpSimModel_1 : entity work.PgpSimModel
         generic map (
            TPD_G      => TPD_G,
            LANE_CNT_G => 2)
         port map (
            pgpTxClk         => pgpClk,
            pgpTxClkRst      => pgpClkRst,
            pgpTxIn          => pgpTxIn,
            pgpTxOut         => pgpTxOut,
            pgpTxMasters     => pgpTxMasters,
            pgpTxSlaves      => pgpTxSlaves,
            pgpRxClk         => pgpClk,
            pgpRxClkRst      => pgpClkRst,
            pgpRxIn          => pgpRxIn,
            pgpRxOut         => pgpRxOut,
            pgpRxMasters     => pgpRxMasters,
            pgpRxMasterMuxed => open,
            pgpRxCtrl        => pgpRxCtrl);
   end generate SIM_PGP;

   -------------------------------------------------------------------------------------------------
   -- SSI to AXI-Lite module on PGP VC 0
   -------------------------------------------------------------------------------------------------
   SsiAxiLiteMaster_1 : entity work.SsiAxiLiteMaster
      generic map (
         TPD_G               => TPD_G,
         SLAVE_READY_EN_G    => false,
         EN_32BIT_ADDR_G     => true,
         BRAM_EN_G           => true,
         USE_BUILT_IN_G      => false,
         GEN_SYNC_FIFO_G     => false,
         FIFO_ADDR_WIDTH_G   => 9,
         FIFO_PAUSE_THRESH_G => 2**8,
         AXI_STREAM_CONFIG_G => SSI_PGP2B_CONFIG_C)
      port map (
         sAxisClk            => pgpClk,
         sAxisRst            => pgpClkRst,
         sAxisMaster         => pgpRxMasters(0),
         sAxisSlave          => open,
         sAxisCtrl           => pgpRxCtrl(0),
         mAxisClk            => pgpClk,
         mAxisRst            => pgpClkRst,
         mAxisMaster         => pgpTxMasters(0),
         mAxisSlave          => pgpTxSlaves(0),
         axiLiteClk          => axilClk,
         axiLiteRst          => axilClkRst,
         mAxiLiteWriteMaster => mAxilWriteMaster,
         mAxiLiteWriteSlave  => mAxilWriteSlave,
         mAxiLiteReadMaster  => mAxilReadMaster,
         mAxiLiteReadSlave   => mAxilReadSlave);

   -------------------------------------------------------------------------------------------------
   -- Top Axi Crossbar
   -------------------------------------------------------------------------------------------------
   AxiCrossbar : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 1,
         NUM_MASTER_SLOTS_G => NUM_AXI_MASTERS_C,
         MASTERS_CONFIG_G   => AXI_CROSSBAR_MASTERS_CONFIG_C)
      port map (
         axiClk              => axilClk,
         axiClkRst           => axilClkRst,
         sAxiWriteMasters(0) => mAxilWriteMaster,
         sAxiWriteSlaves(0)  => mAxilWriteSlave,
         sAxiReadMasters(0)  => mAxilReadMaster,
         sAxiReadSlaves(0)   => mAxilReadSlave,
         mAxiWriteMasters    => sAxilWriteMasters,
         mAxiWriteSlaves     => sAxilWriteSlaves,
         mAxiReadMasters     => sAxilReadMasters,
         mAxiReadSlaves      => sAxilReadSlaves);
 
   -------------------------------------------------------------------------------------------------
   -- Put version info on AXI Bus
   -------------------------------------------------------------------------------------------------
   AxiVersion_1 : entity work.AxiVersion
      generic map (
         TPD_G            => TPD_G,
         EN_DEVICE_DNA_G  => false,
         XIL_DEVICE_G     => "ULTRASCALE",
         EN_DS2411_G      => false,
         EN_ICAP_G        => false,
         AUTO_RELOAD_EN_G => false)
      port map (
         axiClk         => axilClk,
         axiRst         => axilClkRst,
         masterReset    => masterReset,
         axiReadMaster  => sAxilReadMasters(VERSION_INDEX_C),
         axiReadSlave   => sAxilReadSlaves(VERSION_INDEX_C),
         axiWriteMaster => sAxilWriteMasters(VERSION_INDEX_C),
         axiWriteSlave  => sAxilWriteSlaves(VERSION_INDEX_C));

   -------------------------------------------------------------------------------------------------
   -- AXIL 1 is PGP-AXIL interface
   -------------------------------------------------------------------------------------------------
   Pgp2bAxi_1 : entity work.Pgp2bAxi
      generic map (
         TPD_G              => TPD_G,
         COMMON_TX_CLK_G    => (PGP_CLK_FREQ_G = AXIL_CLK_FREQ_G),
         COMMON_RX_CLK_G    => (PGP_CLK_FREQ_G = AXIL_CLK_FREQ_G),
         WRITE_EN_G         => false,
         AXI_CLK_FREQ_G     => AXIL_CLK_FREQ_G,
         STATUS_CNT_WIDTH_G => 32,
         ERROR_CNT_WIDTH_G  => 16)
      port map (
         pgpTxClk        => pgpClk,
         pgpTxClkRst     => pgpClkRst,
         pgpTxIn         => pgpTxIn,
         pgpTxOut        => pgpTxOut,
         pgpRxClk        => pgpClk,
         pgpRxClkRst     => pgpClkRst,
         pgpRxIn         => pgpRxIn,
         pgpRxOut        => pgpRxOut,
         axilClk         => axilClk,
         axilRst         => axilClkRst,
         axilReadMaster  => sAxilReadMasters(PGP_AXI_INDEX_C),
         axilReadSlave   => sAxilReadSlaves(PGP_AXI_INDEX_C),
         axilWriteMaster => sAxilWriteMasters(PGP_AXI_INDEX_C),
         axilWriteSlave  => sAxilWriteSlaves(PGP_AXI_INDEX_C));

   leds(0) <= pgpRxOut.linkReady;
   leds(1) <= pgpTxOut.linkReady;

   -------------------------------------------------------------------------------------------------
   -- AXIL is external APP port
   -------------------------------------------------------------------------------------------------
   axilWriteMaster               <= sAxilWriteMasters(APP_INDEX_C);
   sAxilWriteSlaves(APP_INDEX_C) <= axilWriteSlave;
   axilReadMaster                <= sAxilReadMasters(APP_INDEX_C);
   sAxilReadSlaves(APP_INDEX_C)  <= axilReadSlave; 
   
   -- AXIS_FIFOS : for i in 1 downto 0 generate
      -- AxiStreamFifo_1 : entity work.AxiStreamFifo
         -- generic map (
            -- TPD_G               => TPD_G,
-- --            INT_PIPE_STAGES_G   => INT_PIPE_STAGES_G,
-- --            PIPE_STAGES_G       => PIPE_STAGES_G,
            -- SLAVE_READY_EN_G    => true,
            -- VALID_THOLD_G       => 1,
            -- BRAM_EN_G           => true,
            -- USE_BUILT_IN_G      => false,
            -- GEN_SYNC_FIFO_G     => false,
            -- CASCADE_SIZE_G      => CASCADE_SIZE_G,
            -- FIFO_ADDR_WIDTH_G   => AXIS_FIFO_ADDR_WIDTH_G,
            -- FIFO_FIXED_THRESH_G => true,
            -- FIFO_PAUSE_THRESH_G => 1, --2**(AXIS_FIFO_ADDR_WIDTH_G-1),
-- --            CASCADE_PAUSE_SEL_G => CASCADE_PAUSE_SEL_G,
            -- SLAVE_AXI_CONFIG_G  => AXIS_CONFIG_G,
            -- MASTER_AXI_CONFIG_G => SSI_PGP2B_CONFIG_C)
         -- port map (
            -- sAxisClk    => axisClk,
            -- sAxisRst    => axisClkRst,
            -- sAxisMaster => axisTxMasters(i),
            -- sAxisSlave  => axisTxSlaves(i),
            -- sAxisCtrl   => axisTxCtrl(i),
            -- mAxisClk    => pgpClk,
            -- mAxisRst    => pgpClkRst,
            -- mAxisMaster => pgpTxMasters(i+1),
            -- mAxisSlave  => pgpTXSlaves(i+1)  );
   -- end generate AXIS_FIFOS;


end architecture rtl;
