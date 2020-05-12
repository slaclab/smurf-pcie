-------------------------------------------------------------------------------
-- File       : DataDmaAsyncFifo.vhd
-- Company    : SLAC National Accelerator Laboratory
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

entity DataDmaAsyncFifo is
   generic (
      TPD_G : time := 1 ns);
   port (
      -- Clocks and Resets
      axilClk     : in  sl;
      axilRst     : in  sl;
      dmaClk      : in  sl;
      dmaRst      : in  sl;
      -- UDP Config Interface (axilClk domain)
      udpDest     : in  slv(7 downto 0);
      -- DMA Interface (dmaClk domain)
      dmaObMaster : in  AxiStreamMasterType;
      dmaObSlave  : out AxiStreamSlaveType;
      dmaIbMaster : out AxiStreamMasterType;
      dmaIbSlave  : in  AxiStreamSlaveType;
      -- UDP Interface (axilClk domain)
      udpIbMaster : out AxiStreamMasterType;
      udpIbSlave  : in  AxiStreamSlaveType;
      udpObMaster : in  AxiStreamMasterType;
      udpObSlave  : out AxiStreamSlaveType);
end DataDmaAsyncFifo;

architecture mapping of DataDmaAsyncFifo is

   signal udpRxMaster : AxiStreamMasterType;

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

   UDP_OB_MUX : process (udpDest, udpObMaster) is
      variable master : AxiStreamMasterType;
   begin

      -- Init
      master := udpObMaster;

      -- Force the TDEST
      master.tDest := udpDest;

      -- Outputs
      udpRxMaster <= master;

   end process;

   U_IB_DMA : entity surf.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         INT_PIPE_STAGES_G   => 1,
         PIPE_STAGES_G       => 1,
         -- FIFO configurations
         MEMORY_TYPE_G       => "block",
         GEN_SYNC_FIFO_G     => false,
         FIFO_ADDR_WIDTH_G   => 9,
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => EMAC_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => axilClk,
         sAxisRst    => axilReset,
         sAxisMaster => udpRxMaster,
         sAxisSlave  => udpObSlave,
         -- Master Port
         mAxisClk    => dmaClk,
         mAxisRst    => dmaReset,
         mAxisMaster => dmaIbMaster,
         mAxisSlave  => dmaIbSlave);

   -----------------------------------------------------------------
   --             DMA Path: DMA->APP
   -----------------------------------------------------------------

   U_OB_DMA : entity surf.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         INT_PIPE_STAGES_G   => 1,
         PIPE_STAGES_G       => 1,
         -- FIFO configurations
         MEMORY_TYPE_G       => "block",
         GEN_SYNC_FIFO_G     => false,
         FIFO_ADDR_WIDTH_G   => 9,
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => EMAC_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => dmaClk,
         sAxisRst    => dmaReset,
         sAxisMaster => dmaObMaster,
         sAxisSlave  => dmaObSlave,
         -- Master Port
         mAxisClk    => axilClk,
         mAxisRst    => axilReset,
         mAxisMaster => udpIbMaster,
         mAxisSlave  => udpIbSlave);

end mapping;
