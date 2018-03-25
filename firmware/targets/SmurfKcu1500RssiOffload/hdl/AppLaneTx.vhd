-------------------------------------------------------------------------------
-- File       : AppLaneTx.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-02-06
-- Last update: 2018-03-25
-------------------------------------------------------------------------------
-- Description: AppLaneTx File
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

use work.AxiPkg.all;
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.AxiPciePkg.all;
use work.AppPkg.all;

library unisim;
use unisim.vcomponents.all;

entity AppLaneTx is
   generic (
      TPD_G : time := 1 ns);
   port (
      -- DMA Interfaces (dmaClk domain)
      dmaClk        : in  sl;
      dmaRst        : in  sl;
      dmaObMaster   : in  AxiStreamMasterType;
      dmaObSlave    : out AxiStreamSlaveType;
      -- RSSI Interface (axilClk domain)
      axilClk       : in  sl;
      axilRst       : in  sl;
      rssiLinkUp    : in  slv(RSSI_PER_LINK_C-1 downto 0);
      rssiIbMasters : out AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
      rssiIbSlaves  : in  AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0));
end AppLaneTx;

architecture mapping of AppLaneTx is

   signal txMaster : AxiStreamMasterType;
   signal txSlave  : AxiStreamSlaveType;

   signal txMasterSof : AxiStreamMasterType;
   signal txSlaveSof  : AxiStreamSlaveType;

begin

   U_ASYNC : entity work.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         INT_PIPE_STAGES_G   => 1,
         PIPE_STAGES_G       => 1,
         SLAVE_READY_EN_G    => true,
         VALID_THOLD_G       => 1,
         -- FIFO configurations
         BRAM_EN_G           => true,
         GEN_SYNC_FIFO_G     => false,
         FIFO_ADDR_WIDTH_G   => 9,
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => DMA_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => DMA_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => dmaClk,
         sAxisRst    => dmaRst,
         sAxisMaster => dmaObMaster,
         sAxisSlave  => dmaObSlave,
         -- Master Port
         mAxisClk    => axilClk,
         mAxisRst    => axilRst,
         mAxisMaster => txMaster,
         mAxisSlave  => txSlave);

   -- U_SOF : entity work.SsiInsertSof
   -- generic map (
   -- TPD_G               => TPD_G,
   -- COMMON_CLK_G        => true,
   -- SLAVE_FIFO_G        => false,
   -- MASTER_FIFO_G       => false,
   -- SLAVE_AXI_CONFIG_G  => DMA_AXIS_CONFIG_C,
   -- MASTER_AXI_CONFIG_G => DMA_AXIS_CONFIG_C)
   -- port map (
   -- -- Slave Port
   -- sAxisClk    => axilClk,
   -- sAxisRst    => axilRst,
   -- sAxisMaster => txMaster,
   -- sAxisSlave  => txSlave,
   -- -- Master Port
   -- mAxisClk    => axilClk,
   -- mAxisRst    => axilRst,
   -- mAxisMaster => txMasterSof,
   -- mAxisSlave  => txSlaveSof);

   txMasterSof <= txMaster;
   txSlaveSof  <= txSlave;

   U_DeMux : entity work.AxiStreamDeMux
      generic map (
         TPD_G         => TPD_G,
         NUM_MASTERS_G => AXIS_PER_LINK_C,
         MODE_G        => "INDEXED",
         PIPE_STAGES_G => 1,
         TDEST_HIGH_G  => 4,
         TDEST_LOW_G   => 0)
      port map (
         -- Clock and reset
         axisClk      => axilClk,
         axisRst      => axilRst,
         -- Slave         
         sAxisMaster  => txMasterSof,
         sAxisSlave   => txSlaveSof,
         -- Masters
         mAxisMasters => rssiIbMasters,
         mAxisSlaves  => rssiIbSlaves);

end mapping;
