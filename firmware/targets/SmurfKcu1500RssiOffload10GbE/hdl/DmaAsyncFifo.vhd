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

use work.StdRtlPkg.all;
use work.AxiStreamPkg.all;
use work.AppPkg.all;

entity DmaAsyncFifo is
   generic (
      TPD_G : time := 1 ns);
   port (
      -- DMA Interface (dmaClk domain)
      dmaClk        : in  sl;
      dmaRst        : in  sl;
      dmaObMasters  : in  AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      dmaObSlaves   : out AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      dmaIbMasters  : out AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      dmaIbSlaves   : in  AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      -- DMA Interface (axilClk domain)
      axilClk       : in  sl;
      axilRst       : in  sl;
      rssiIbMasters : out AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      rssiIbSlaves  : in  AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      rssiObMasters : in  AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      rssiObSlaves  : out AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0));
end DmaAsyncFifo;

architecture mapping of DmaAsyncFifo is

begin

   GEN_VEC : for i in NUM_RSSI_C-1 downto 0 generate

      U_OB_DMA : entity work.AxiStreamFifoV2
         generic map (
            -- General Configurations
            TPD_G               => TPD_G,
            -- FIFO configurations
            BRAM_EN_G           => false,
            GEN_SYNC_FIFO_G     => false,
            FIFO_ADDR_WIDTH_G   => 4,
            -- AXI Stream Port Configurations
            SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
            MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
         port map (
            -- Slave Port
            sAxisClk    => dmaClk,
            sAxisRst    => dmaRst,
            sAxisMaster => dmaObMasters(i),
            sAxisSlave  => dmaObSlaves(i),
            -- Master Port
            mAxisClk    => axilClk,
            mAxisRst    => axilRst,
            mAxisMaster => rssiIbMasters(i),
            mAxisSlave  => rssiIbSlaves(i));

      U_IB_DMA : entity work.AxiStreamFifoV2
         generic map (
            -- General Configurations
            TPD_G               => TPD_G,
            -- FIFO configurations
            BRAM_EN_G           => false,
            GEN_SYNC_FIFO_G     => false,
            FIFO_ADDR_WIDTH_G   => 4,
            -- AXI Stream Port Configurations
            SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
            MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
         port map (
            -- Slave Port
            sAxisClk    => axilClk,
            sAxisRst    => axilRst,
            sAxisMaster => rssiObMasters(i),
            sAxisSlave  => rssiObSlaves(i),
            -- Master Port
            mAxisClk    => dmaClk,
            mAxisRst    => dmaRst,
            mAxisMaster => dmaIbMasters(i),
            mAxisSlave  => dmaIbSlaves(i));

   end generate GEN_VEC;

end mapping;
