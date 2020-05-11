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
      -- Clocks and Resets
      axilClk      : in  sl;
      axilRst      : in  sl;
      dmaClk       : in  sl;
      dmaRst       : in  sl;
      -- UDP Config Interface (axilClk domain)
      udpDest      : in  slv(7 downto 0);
      -- DMA Interface (dmaClk domain)
      dmaObMaster  : in  AxiStreamMasterType;
      dmaObSlave   : out AxiStreamSlaveType;
      dmaIbMaster  : out AxiStreamMasterType;
      dmaIbSlave   : in  AxiStreamSlaveType;
      -- UDP Interface (axilClk domain)
      udpIbMaster  : out AxiStreamMasterType := AXI_STREAM_MASTER_INIT_C;
      udpIbSlave   : in  AxiStreamSlaveType;
      udpObMaster  : in  AxiStreamMasterType;
      udpObSlave   : out AxiStreamSlaveType  := AXI_STREAM_SLAVE_FORCE_C;
      -- RSSI Interface (axilClk domain)
      rssiIbMaster : out AxiStreamMasterType := AXI_STREAM_MASTER_INIT_C;
      rssiIbSlave  : in  AxiStreamSlaveType;
      rssiObMaster : in  AxiStreamMasterType;
      rssiObSlave  : out AxiStreamSlaveType  := AXI_STREAM_SLAVE_FORCE_C);
end DmaAsyncFifo;

architecture mapping of DmaAsyncFifo is

   constant MUX_ROUTES_C : Slv8Array(CLIENT_SIZE_C-1 downto 0) := (
      0 => "--------",
      1 => "--------");

   signal dmaIbMasters : AxiStreamMasterArray(1 downto 0);
   signal dmaIbSlaves  : AxiStreamSlaveArray(1 downto 0);

   signal axilReset : sl;
   signal dmaReset  : sl;

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

   U_dmaRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => dmaClk,
         rstIn  => dmaRst,
         rstOut => dmaReset);

   -----------------------------------------------------------------
   --             DMA Path: APP->DMA
   -----------------------------------------------------------------

   U_IB_DMA_1 : entity surf.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         -- FIFO configurations
         MEMORY_TYPE_G       => "distributed",
         GEN_SYNC_FIFO_G     => false,
         FIFO_ADDR_WIDTH_G   => 5,
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => axilClk,
         sAxisRst    => axilReset,
         sAxisMaster => rssiObMaster,
         sAxisSlave  => rssiObSlave,
         -- Master Port
         mAxisClk    => dmaClk,
         mAxisRst    => dmaReset,
         mAxisMaster => dmaIbMasters(1),
         mAxisSlave  => dmaIbSlaves(1));

   U_IB_DMA_0 : entity surf.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         -- FIFO configurations
         MEMORY_TYPE_G       => "distributed",
         GEN_SYNC_FIFO_G     => false,
         FIFO_ADDR_WIDTH_G   => 5,
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => EMAC_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => axilClk,
         sAxisRst    => axilReset,
         sAxisMaster => udpObMaster,
         sAxisSlave  => udpObSlave,
         -- Master Port
         mAxisClk    => dmaClk,
         mAxisRst    => dmaReset,
         mAxisMaster => dmaIbMasters(0),
         mAxisSlave  => dmaIbSlaves(0));

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
         axisClk      => dmaClk,
         axisRst      => dmaReset,
         -- Slaves
         sAxisMasters => dmaIbMasters,
         sAxisSlaves  => dmaIbSlaves,
         -- Master
         mAxisMaster  => dmaIbMaster,
         mAxisSlave   => dmaIbSlave);

   -----------------------------------------------------------------
   --             DMA Path: DMA->APP
   -----------------------------------------------------------------

   U_OB_DMA : entity surf.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         -- FIFO configurations
         MEMORY_TYPE_G       => "distributed",
         GEN_SYNC_FIFO_G     => false,
         FIFO_ADDR_WIDTH_G   => 5,
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => dmaClk,
         sAxisRst    => dmaReset,
         sAxisMaster => dmaObMaster,
         sAxisSlave  => dmaObSlave,
         -- Master Port
         mAxisClk    => axilClk,
         mAxisRst    => axilReset,
         mAxisMaster => rssiIbMaster,
         mAxisSlave  => rssiIbSlave);

end mapping;
