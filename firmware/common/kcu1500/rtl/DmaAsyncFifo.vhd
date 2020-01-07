-------------------------------------------------------------------------------
-- File       : DmaAsyncFifo.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: DmaAsyncFifo File
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
use surf.AxiStreamPkg.all;
use surf.EthMacPkg.all;

use work.AppPkg.all;

entity DmaAsyncFifo is
   generic (
      TPD_G : time := 1 ns);
   port (
      -- UDP Outbound Config Interface (axiClk domain)
      udpObMuxSel    : in  sl;
      udpObDest      : in  slv(7 downto 0);
      -- Primary DMA Interface (dmaPriClk domain)
      dmaPriClk      : in  sl;
      dmaPriRst      : in  sl;
      dmaPriObMaster : in  AxiStreamMasterType;
      dmaPriObSlave  : out AxiStreamSlaveType;
      dmaPriIbMaster : out AxiStreamMasterType;
      dmaPriIbSlave  : in  AxiStreamSlaveType;
      -- Secondary DMA Interface (dmaSecClk domain)
      dmaSecClk      : in  sl;
      dmaSecRst      : in  sl;
      dmaSecObMaster : in  AxiStreamMasterType;
      dmaSecObSlave  : out AxiStreamSlaveType;
      dmaSecIbMaster : out AxiStreamMasterType;
      dmaSecIbSlave  : in  AxiStreamSlaveType;
      -- UDP Interface (axiClk/axilClk domain)
      axiClk         : in  sl;
      axiRst         : in  sl;
      udpIbMaster    : out AxiStreamMasterType;  -- Same clock domain as UdpEngine
      udpIbSlave     : in  AxiStreamSlaveType;
      udpObMaster    : in  AxiStreamMasterType;  -- Same clock domain as UdpLargeDataBuffer
      udpObSlave     : out AxiStreamSlaveType;
      -- RSSI Interface (axilClk domain)
      axilClk        : in  sl;
      axilRst        : in  sl;
      rssiIbMaster   : out AxiStreamMasterType;
      rssiIbSlave    : in  AxiStreamSlaveType;
      rssiObMaster   : in  AxiStreamMasterType;
      rssiObSlave    : out AxiStreamSlaveType);
end DmaAsyncFifo;

architecture mapping of DmaAsyncFifo is

   constant MUX_ROUTES_C : Slv8Array(CLIENT_SIZE_C-1 downto 0) := (
      0 => "--------",
      1 => "--------");

   signal rssiTxMaster : AxiStreamMasterType;
   signal rssiTxSlave  : AxiStreamSlaveType;

   signal rssiRxMaster : AxiStreamMasterType;
   signal rssiRxSlave  : AxiStreamSlaveType;

   signal dmaPriIbMasters : AxiStreamMasterArray(1 downto 0);
   signal dmaPriIbSlaves  : AxiStreamSlaveArray(1 downto 0);

   signal udpObMasters : AxiStreamMasterArray(1 downto 0);
   signal udpObSlaves  : AxiStreamSlaveArray(1 downto 0);

   signal udpRxMasters : AxiStreamMasterArray(1 downto 0);
   signal udpRxSlaves  : AxiStreamSlaveArray(1 downto 0);

   signal udpTxMaster : AxiStreamMasterType;
   signal udpTxSlave  : AxiStreamSlaveType;

   signal axilReset   : sl;
   signal axiReset    : sl;
   signal dmaPriReset : sl;
   signal dmaSecReset : sl;

   signal muxSel : sl;
   signal obDest : slv(7 downto 0);

begin

   -----------------------------------------------------------------
   --                   Pipelined Resets
   -----------------------------------------------------------------

   U_axilRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axilClk,
         rstIn  => axilRst,
         rstOut => axilReset);

   U_axiRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axiClk,
         rstIn  => axiRst,
         rstOut => axiReset);

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

   -----------------------------------------------------------------
   --             Primary DMA Path: APP->DMA
   -----------------------------------------------------------------

   -- Adding Pipelining to help with making timing between SLR0/SLR1
   U_ObPipe_PriDma : entity surf.AxiStreamPipeline
      generic map (
         TPD_G         => TPD_G,
         PIPE_STAGES_G => 1)
      port map (
         axisClk     => axilClk,
         axisRst     => axilReset,
         sAxisMaster => rssiObMaster,
         sAxisSlave  => rssiObSlave,
         mAxisMaster => rssiRxMaster,
         mAxisSlave  => rssiRxSlave);

   U_IB_DMA_1 : entity surf.AxiStreamFifoV2
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
         sAxisMaster => rssiRxMaster,
         sAxisSlave  => rssiRxSlave,
         -- Master Port
         mAxisClk    => dmaPriClk,
         mAxisRst    => dmaPriReset,
         mAxisMaster => dmaPriIbMasters(1),
         mAxisSlave  => dmaPriIbSlaves(1));

   U_IB_DMA_0 : entity surf.AxiStreamFifoV2
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
         SLAVE_AXI_CONFIG_G  => EMAC_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => axiClk,  -- Same clock domain as UdpLargeDataBuffer
         sAxisRst    => axiReset,
         sAxisMaster => udpRxMasters(0),
         sAxisSlave  => udpRxSlaves(0),
         -- Master Port
         mAxisClk    => dmaPriClk,
         mAxisRst    => dmaPriReset,
         mAxisMaster => dmaPriIbMasters(0),
         mAxisSlave  => dmaPriIbSlaves(0));

   U_AxiStreamMux : entity surf.AxiStreamMux
      generic map (
         TPD_G                => TPD_G,
         PIPE_STAGES_G        => 1,
         NUM_SLAVES_G         => 2,
         MODE_G               => "ROUTED",
         TDEST_ROUTES_G       => MUX_ROUTES_C,
         ILEAVE_EN_G          => true,
         ILEAVE_ON_NOTVALID_G => true,
         ILEAVE_REARB_G       => 128)
      port map (
         -- Clock and reset
         axisClk      => dmaPriClk,
         axisRst      => dmaPriReset,
         -- Slaves
         sAxisMasters => dmaPriIbMasters,
         sAxisSlaves  => dmaPriIbSlaves,
         -- Master
         mAxisMaster  => dmaPriIbMaster,
         mAxisSlave   => dmaPriIbSlave);

   -----------------------------------------------------------------
   --             Primary DMA Path: DMA->APP
   -----------------------------------------------------------------

   U_OB_DMA : entity surf.AxiStreamFifoV2
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
         sAxisMaster => dmaPriObMaster,
         sAxisSlave  => dmaPriObSlave,
         -- Master Port
         mAxisClk    => axilClk,
         mAxisRst    => axilReset,
         mAxisMaster => rssiTxMaster,
         mAxisSlave  => rssiTxSlave);

   -- Adding Pipelining to help with making timing between SLR0/SLR1
   U_IbPipe_PriDma : entity surf.AxiStreamPipeline
      generic map (
         TPD_G         => TPD_G,
         PIPE_STAGES_G => 1)
      port map (
         axisClk     => axilClk,
         axisRst     => axilReset,
         sAxisMaster => rssiTxMaster,
         sAxisSlave  => rssiTxSlave,
         mAxisMaster => rssiIbMaster,
         mAxisSlave  => rssiIbSlave);

   -----------------------------------------------------------------
   --             Secondary DMA Path: APP->DMA
   -----------------------------------------------------------------

   -- Adding Pipelining to help with making timing between SLR0/SLR1
   U_ObPipe_SecDma : entity surf.AxiStreamRepeater
      generic map (
         TPD_G                => TPD_G,
         NUM_MASTERS_G        => 2,
         INPUT_PIPE_STAGES_G  => 1,
         OUTPUT_PIPE_STAGES_G => 1)
      port map (
         -- Clock and reset
         axisClk      => axiClk,
         axisRst      => axiReset,
         -- Slave
         sAxisMaster  => udpObMaster,
         sAxisSlave   => udpObSlave,
         -- Masters
         mAxisMasters => udpObMasters,
         mAxisSlaves  => udpObSlaves);

   process (axiClk) is
   begin
      if (rising_edge(axiClk)) then
         -- Register to help with making timing
         muxSel <= udpObMuxSel after TPD_G;
         obDest <= udpObDest   after TPD_G;
      end if;
   end process;

   UDP_OB_MUX : process (muxSel, obDest, udpObMasters, udpRxSlaves) is
      variable masters : AxiStreamMasterArray(1 downto 0);
      variable slaves  : AxiStreamSlaveArray(1 downto 0);
   begin

      -- Init
      masters := udpObMasters;
      slaves  := udpRxSlaves;

      -- Force the TDEST
      masters(0).tDest := obDest;
      masters(1).tDest := obDest;

      -- Check if forwarding to primary DMA path
      if (muxSel = '0') then  -- Used for testing with computer without PCIe bifurcation 
         -- Blowoff secondary DMA path
         masters(1).tValid := '0';
         slaves(1).tReady  := '1';
      -- Else forwarding to secondary DMA path
      else                              -- Default Configuration 
         -- Blowoff primary DMA path
         masters(0).tValid := '0';
         slaves(0).tReady  := '1';
      end if;

      -- Outputs
      udpRxMasters <= masters;
      udpObSlaves  <= slaves;

   end process;

   U_IB_DMA : entity surf.AxiStreamFifoV2
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
         SLAVE_AXI_CONFIG_G  => EMAC_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => axiClk,  -- Same clock domain as UdpLargeDataBuffer
         sAxisRst    => axiReset,
         sAxisMaster => udpRxMasters(1),
         sAxisSlave  => udpRxSlaves(1),
         -- Master Port
         mAxisClk    => dmaSecClk,
         mAxisRst    => dmaSecReset,
         mAxisMaster => dmaSecIbMaster,
         mAxisSlave  => dmaSecIbSlave);

   -----------------------------------------------------------------
   --             Secondary DMA Path: DMA->APP
   -----------------------------------------------------------------

   U_OB_DMA_SecDma : entity surf.AxiStreamFifoV2
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
         MASTER_AXI_CONFIG_G => EMAC_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => dmaSecClk,
         sAxisRst    => dmaSecReset,
         sAxisMaster => dmaSecObMaster,
         sAxisSlave  => dmaSecObSlave,
         -- Master Port
         mAxisClk    => axilClk,        -- Same clock domain as UdpEngine
         mAxisRst    => axilReset,
         mAxisMaster => udpTxMaster,
         mAxisSlave  => udpTxSlave);

   -----------------------------------------------------------------
   -- Adding Pipelining to help with making timing between SLR0/SLR1
   -----------------------------------------------------------------
   U_IbPipe : entity surf.AxiStreamPipeline
      generic map (
         TPD_G         => TPD_G,
         PIPE_STAGES_G => 1)
      port map (
         axisClk     => axilClk,
         axisRst     => axilReset,
         sAxisMaster => udpTxMaster,
         sAxisSlave  => udpTxSlave,
         mAxisMaster => udpIbMaster,
         mAxisSlave  => udpIbSlave);

end mapping;
