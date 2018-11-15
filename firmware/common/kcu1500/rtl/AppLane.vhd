-------------------------------------------------------------------------------
-- File       : AppLane.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: AppLane File
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
use work.AppPkg.all;

entity AppLane is
   generic (
      TPD_G           : time    := 1 ns;
      LANE_G          : natural := 0;
      AXI_BASE_ADDR_G : slv(31 downto 0));
   port (
      -- DMA Interfaces (dmaClk domain)
      dmaClk          : in  sl;
      dmaRst          : in  sl;
      dmaObMaster     : in  AxiStreamMasterType;
      dmaObSlave      : out AxiStreamSlaveType;
      dmaIbMaster     : out AxiStreamMasterType;
      dmaIbSlave      : in  AxiStreamSlaveType;
      -- AXI-Lite Interface (axilClk domain)
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType;
      -- RSSI Interface (axilClk domain)
      rssiLinkUp      : in  sl;
      rssiIbMasters   : out AxiStreamMasterArray(APP_STREAMS_C-1 downto 0);
      rssiIbSlaves    : in  AxiStreamSlaveArray(APP_STREAMS_C-1 downto 0);
      rssiObMasters   : in  AxiStreamMasterArray(APP_STREAMS_C-1 downto 0);
      rssiObSlaves    : out AxiStreamSlaveArray(APP_STREAMS_C-1 downto 0));
end AppLane;

architecture mapping of AppLane is

   signal appIbMaster  : AxiStreamMasterType;
   signal appIbSlave   : AxiStreamSlaveType;
   signal appIbMasters : AxiStreamMasterArray(APP_STREAMS_C-1 downto 0);
   signal appIbSlaves  : AxiStreamSlaveArray(APP_STREAMS_C-1 downto 0);

   signal tapIbMaster : AxiStreamMasterType;
   signal tapIbSlave  : AxiStreamSlaveType;

   signal loopbackMaster : AxiStreamMasterType;
   signal loopbackSlave  : AxiStreamSlaveType;

   signal tapObMaster : AxiStreamMasterType;
   signal tapObSlave  : AxiStreamSlaveType;

   signal appObMasters : AxiStreamMasterArray(APP_STREAMS_C-1 downto 0);
   signal appObSlaves  : AxiStreamSlaveArray(APP_STREAMS_C-1 downto 0);
   signal appObMaster  : AxiStreamMasterType;
   signal appObSlave   : AxiStreamSlaveType;

begin

   U_OB_DMA : entity work.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         INT_PIPE_STAGES_G   => 0,
         PIPE_STAGES_G       => 0,
         SLAVE_READY_EN_G    => true,
         VALID_THOLD_G       => 1,
         -- FIFO configurations
         BRAM_EN_G           => false,
         USE_BUILT_IN_G      => false,
         GEN_SYNC_FIFO_G     => false,
         FIFO_ADDR_WIDTH_G   => 4,
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => dmaClk,
         sAxisRst    => dmaRst,
         sAxisMaster => dmaObMaster,
         sAxisSlave  => dmaObSlave,
         -- Master Port
         mAxisClk    => axilClk,
         mAxisRst    => axilRst,
         mAxisMaster => appIbMaster,
         mAxisSlave  => appIbSlave);

   U_AxiStreamDeMux : entity work.AxiStreamDeMux
      generic map (
         TPD_G          => TPD_G,
         PIPE_STAGES_G  => 1,
         NUM_MASTERS_G  => APP_STREAMS_C,
         MODE_G         => "ROUTED",
         TDEST_ROUTES_G => APP_STREAM_ROUTES_C)
      port map (
         -- Clock and reset
         axisClk      => axilClk,
         axisRst      => axilRst,
         -- Slaves
         sAxisMaster  => appIbMaster,
         sAxisSlave   => appIbSlave,
         -- Master
         mAxisMasters => appIbMasters,
         mAxisSlaves  => appIbSlaves);

   APP_IB_ROUTER : process (appIbMasters, loopbackSlave, rssiIbSlaves) is
      variable i : natural;
   begin
      -- Loop through the channels
      for i in APP_STREAMS_C-1 downto 0 loop
         -- Check for the Application data streams
         if (i = APP_ASYNC_IDX_C) then
            -- Reroute traffic to inbound data processing
            loopbackMaster   <= appIbMasters(i);
            appIbSlaves(i)   <= loopbackSlave;
            -- Reroute traffic to outbound data processing
            rssiIbMasters(i) <= AXI_STREAM_MASTER_INIT_C;
         else
            rssiIbMasters(i) <= appIbMasters(i);
            appIbSlaves(i)   <= rssiIbSlaves(i);
         end if;
      end loop;
   end process APP_IB_ROUTER;

   U_AppDataProc : entity work.AppDataProcessor
      generic map (
         TPD_G           => TPD_G,
         AXI_BASE_ADDR_G => AXI_BASE_ADDR_G)
      port map (
         -- Streaming Interfaces
         linkUp          => rssiLinkUp,
         sAxisMaster     => tapIbMaster,
         sAxisSlave      => tapIbSlave,
         mAxisMaster     => tapObMaster,
         mAxisSlave      => tapObSlave,
         loopbackMaster  => loopbackMaster,
         loopbackSlave   => loopbackSlave,
         -- AXI-Lite Interface
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMaster,
         axilReadSlave   => axilReadSlave,
         axilWriteMaster => axilWriteMaster,
         axilWriteSlave  => axilWriteSlave);

   APP_OB_ROUTER : process (appObSlaves, rssiObMasters, tapIbSlave,
                            tapObMaster) is
      variable i : natural;
   begin
      -- Loop through the channels
      for i in APP_STREAMS_C-1 downto 0 loop
         -- Check for the Application data streams
         if (i = APP_ASYNC_IDX_C) then
            -- Reroute traffic to inbound data processing
            tapIbMaster     <= rssiObMasters(i);
            rssiObSlaves(i) <= tapIbSlave;
            -- Reroute traffic to outbound data processing
            appObMasters(i) <= tapObMaster;
            tapObSlave      <= appObSlaves(i);
         else
            appObMasters(i) <= rssiObMasters(i);
            rssiObSlaves(i) <= appObSlaves(i);
         end if;
      end loop;
   end process APP_OB_ROUTER;

   U_AxiStreamMux : entity work.AxiStreamMux
      generic map (
         TPD_G                => TPD_G,
         NUM_SLAVES_G         => APP_STREAMS_C,
         MODE_G               => "ROUTED",
         TDEST_ROUTES_G       => APP_STREAM_ROUTES_C,
         ILEAVE_EN_G          => true,
         ILEAVE_ON_NOTVALID_G => true,
         ILEAVE_REARB_G       => (2048/APP_AXIS_CONFIG_C.TDATA_BYTES_C),
         PIPE_STAGES_G        => 1)
      port map (
         -- Clock and reset
         axisClk      => axilClk,
         axisRst      => axilRst,
         -- Slaves
         sAxisMasters => appObMasters,
         sAxisSlaves  => appObSlaves,
         -- Master
         mAxisMaster  => appObMaster,
         mAxisSlave   => appObSlave);

   U_IB_DMA : entity work.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         INT_PIPE_STAGES_G   => 0,
         PIPE_STAGES_G       => 0,
         SLAVE_READY_EN_G    => true,
         VALID_THOLD_G       => 1,
         -- FIFO configurations
         BRAM_EN_G           => false,
         USE_BUILT_IN_G      => false,
         GEN_SYNC_FIFO_G     => false,
         FIFO_ADDR_WIDTH_G   => 4,
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => APP_AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => APP_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => axilClk,
         sAxisRst    => axilRst,
         sAxisMaster => appObMaster,
         sAxisSlave  => appObSlave,
         -- Master Port
         mAxisClk    => dmaClk,
         mAxisRst    => dmaRst,
         mAxisMaster => dmaIbMaster,
         mAxisSlave  => dmaIbSlave);

end mapping;
