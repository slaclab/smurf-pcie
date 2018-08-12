-------------------------------------------------------------------------------
-- File       : AppLaneTx.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-02-06
-- Last update: 2018-08-02
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
      -- DMA Interfaces (axilClk domain)
      appIbMasters    : in  AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
      appIbSlaves     : out AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0);
      -- Loop Interfaces (axilClk domain)
      loopbackMasters : out AxiStreamMasterArray(RSSI_PER_LINK_C-1 downto 0);
      loopbackSlaves  : in  AxiStreamSlaveArray(RSSI_PER_LINK_C-1 downto 0);
      -- RSSI Interface (axilClk domain)
      axilClk         : in  sl;
      axilRst         : in  sl;
      rssiLinkUp      : in  slv(RSSI_PER_LINK_C-1 downto 0);
      rssiIbMasters   : out AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
      rssiIbSlaves    : in  AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0));
end AppLaneTx;

architecture mapping of AppLaneTx is

   signal txMasters : AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
   signal txSlaves  : AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0);

begin

   GEN_LANE :
   for i in AXIS_PER_LINK_C-1 downto 0 generate
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
            GEN_SYNC_FIFO_G     => true,
            FIFO_ADDR_WIDTH_G   => 9,
            -- AXI Stream Port Configurations
            SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
            MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
         port map (
            -- Slave Port
            sAxisClk    => axilClk,
            sAxisRst    => axilRst,
            sAxisMaster => appIbMasters(i),
            sAxisSlave  => appIbSlaves(i),
            -- Master Port
            mAxisClk    => axilClk,
            mAxisRst    => axilRst,
            mAxisMaster => txMasters(i),
            mAxisSlave  => txSlaves(i));
   end generate GEN_LANE;

   process (loopbackSlaves, rssiIbSlaves, txMasters) is
      variable i   : natural;
      variable j   : natural;
      variable idx : natural;
   begin
      -- Loop through the channels
      for i in RSSI_PER_LINK_C-1 downto 0 loop
         for j in APP_STREAMS_C-1 downto 0 loop
            -- Calculate index
            idx := (i*APP_STREAMS_C) + j;
            -- Check for the Application data streams
            if (j = APP_ASYNC_IDX_C) then
               -- Reroute traffic to inbound data processing
               loopbackMasters(i) <= txMasters(idx);
               txSlaves(idx)      <= loopbackSlaves(i);
               -- Reroute traffic to outbound data processing
               rssiIbMasters(idx) <= AXI_STREAM_MASTER_INIT_C;
            else
               rssiIbMasters(idx) <= txMasters(idx);
               txSlaves(idx)      <= rssiIbSlaves(idx);
            end if;
         end loop;
      end loop;
   end process;

end mapping;
