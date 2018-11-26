-------------------------------------------------------------------------------
-- File       : AppLane.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-02-06
-- Last update: 2018-11-26
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
use work.AxiPciePkg.all;
use work.AppPkg.all;

library unisim;
use unisim.vcomponents.all;

entity AppLane is
   generic (
      TPD_G           : time             := 1 ns;
      LANE_G          : natural          := 0;
      AXI_BASE_ADDR_G : slv(31 downto 0) := BAR0_BASE_ADDR_C);
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
      rssiLinkUp      : in  slv(RSSI_PER_LINK_C-1 downto 0);
      rssiIbMasters   : out AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
      rssiIbSlaves    : in  AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0);
      rssiObMasters   : in  AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
      rssiObSlaves    : out AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0));
end AppLane;

architecture mapping of AppLane is

   function TdestRoutes return Slv8Array is
      variable retConf : Slv8Array(RSSI_PER_LINK_C-1 downto 0);
   begin
      for i in RSSI_PER_LINK_C-1 downto 0 loop
         retConf(i) := toSlv((32*LANE_G)+i, 8);
      end loop;
      return retConf;
   end function;

   signal appObMasters : AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
   signal appObSlaves  : AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0);
   signal appIbMasters : AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
   signal appIbSlaves  : AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0);

   signal dmaObMasters : AxiStreamMasterArray(RSSI_PER_LINK_C-1 downto 0);
   signal dmaObSlaves  : AxiStreamSlaveArray(RSSI_PER_LINK_C-1 downto 0);
   signal dmaIbMasters : AxiStreamMasterArray(RSSI_PER_LINK_C-1 downto 0);
   signal dmaIbSlaves  : AxiStreamSlaveArray(RSSI_PER_LINK_C-1 downto 0);

   signal loopbackMasters : AxiStreamMasterArray(RSSI_PER_LINK_C-1 downto 0);
   signal loopbackSlaves  : AxiStreamSlaveArray(RSSI_PER_LINK_C-1 downto 0);

begin

   GEN_PACKER : for i in RSSI_PER_LINK_C-1 downto 0 generate

      U_PackerV2 : entity work.AxiPcieDmaLanePackVer2
         generic map (
            TPD_G               => TPD_G,
            APP_STREAMS_G       => APP_STREAMS_C,
            APP_STREAM_ROUTES_G => APP_STREAM_ROUTES_C,
            APP_STREAM_CONFIG_G => APP_STREAM_CONFIG_C)
         port map (
            -- Application Interfaces (RAW AXI Stream)
            appClk       => axilClk,
            appRst       => axilRst,
            appObMasters => appObMasters((APP_STREAMS_C-1)+(APP_STREAMS_C*i) downto (APP_STREAMS_C*i)),
            appObSlaves  => appObSlaves((APP_STREAMS_C-1)+(APP_STREAMS_C*i) downto (APP_STREAMS_C*i)),
            appIbMasters => appIbMasters((APP_STREAMS_C-1)+(APP_STREAMS_C*i) downto (APP_STREAMS_C*i)),
            appIbSlaves  => appIbSlaves((APP_STREAMS_C-1)+(APP_STREAMS_C*i) downto (APP_STREAMS_C*i)),
            -- DMA Interface (PackerV2 encoded, 128-bit AXI Stream)
            dmaClk       => dmaClk,
            dmaRst       => dmaRst,
            dmaObMaster  => dmaObMasters(i),
            dmaObSlave   => dmaObSlaves(i),
            dmaIbMaster  => dmaIbMasters(i),
            dmaIbSlave   => dmaIbSlaves(i));

   end generate GEN_PACKER;

   BYP_MUX : if (RSSI_PER_LINK_C = 1) generate

      dmaIbMaster    <= dmaIbMasters(0);
      dmaIbSlaves(0) <= dmaIbSlave;

      dmaObMasters(0) <= dmaObMaster;
      dmaObSlave      <= dmaObSlaves(0);

   end generate;

   MUX_DMA_LANES : if (RSSI_PER_LINK_C /= 1) generate

      U_AxiStreamMux : entity work.AxiStreamMux
         generic map (
            TPD_G                => TPD_G,
            NUM_SLAVES_G         => RSSI_PER_LINK_C,
            MODE_G               => "ROUTED",
            TDEST_ROUTES_G       => TdestRoutes,
            ILEAVE_EN_G          => true,
            ILEAVE_ON_NOTVALID_G => true,
            ILEAVE_REARB_G       => (2048/DMA_AXIS_CONFIG_C.TDATA_BYTES_C),
            PIPE_STAGES_G        => 1)
         port map (
            -- Clock and reset
            axisClk      => dmaClk,
            axisRst      => dmaRst,
            -- Slaves
            sAxisMasters => dmaIbMasters,
            sAxisSlaves  => dmaIbSlaves,
            -- Master
            mAxisMaster  => dmaIbMaster,
            mAxisSlave   => dmaIbSlave);

      U_AxiStreamDeMux : entity work.AxiStreamDeMux
         generic map (
            TPD_G          => TPD_G,
            PIPE_STAGES_G  => 1,
            NUM_MASTERS_G  => RSSI_PER_LINK_C,
            MODE_G         => "ROUTED",
            TDEST_ROUTES_G => TdestRoutes)
         port map (
            -- Clock and reset
            axisClk      => dmaClk,
            axisRst      => dmaRst,
            -- Slaves
            sAxisMaster  => dmaObMaster,
            sAxisSlave   => dmaObSlave,
            -- Master
            mAxisMasters => dmaObMasters,
            mAxisSlaves  => dmaObSlaves);

   end generate;

   U_Tx : entity work.AppLaneTx
      generic map (
         TPD_G => TPD_G)
      port map (
         -- DMA Interfaces (axilClk domain)
         appIbMasters    => appIbMasters,
         appIbSlaves     => appIbSlaves,
         -- Loop Interfaces (axilClk domain)
         loopbackMasters => loopbackMasters,
         loopbackSlaves  => loopbackSlaves,
         -- RSSI Interface (axilClk domain)
         axilClk         => axilClk,
         axilRst         => axilRst,
         rssiLinkUp      => rssiLinkUp,
         rssiIbMasters   => rssiIbMasters,
         rssiIbSlaves    => rssiIbSlaves);

   U_Rx : entity work.AppLaneRx
      generic map (
         TPD_G           => TPD_G,
         LANE_G          => LANE_G,
         AXI_BASE_ADDR_G => AXI_BASE_ADDR_G)
      port map (
         -- DMA Interfaces (axilClk domain)
         appObMasters    => appObMasters,
         appObSlaves     => appObSlaves,
         -- Loop Interfaces (axilClk domain)
         loopbackMasters => loopbackMasters,
         loopbackSlaves  => loopbackSlaves,
         -- RSSI Interface (axilClk domain)
         rssiLinkUp      => rssiLinkUp,
         rssiObMasters   => rssiObMasters,
         rssiObSlaves    => rssiObSlaves,
         -- AXI-Lite Interface (axilClk domain)
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMaster,
         axilReadSlave   => axilReadSlave,
         axilWriteMaster => axilWriteMaster,
         axilWriteSlave  => axilWriteSlave);

end mapping;
