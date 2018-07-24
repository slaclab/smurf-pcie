-------------------------------------------------------------------------------
-- File       : AppLane.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-02-06
-- Last update: 2018-05-14
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

   signal loopbackMasters : AxiStreamMasterArray(RSSI_PER_LINK_C-1 downto 0);
   signal loopbackSlaves  : AxiStreamSlaveArray(RSSI_PER_LINK_C-1 downto 0);

begin

   U_Tx : entity work.AppLaneTx
      generic map (
         TPD_G => TPD_G)
      port map (
         -- DMA Interfaces (dmaClk domain)
         dmaClk          => dmaClk,
         dmaRst          => dmaRst,
         dmaObMaster     => dmaObMaster,
         dmaObSlave      => dmaObSlave,
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
         -- DMA Interfaces (dmaClk domain)
         dmaClk          => dmaClk,
         dmaRst          => dmaRst,
         dmaIbMaster     => dmaIbMaster,
         dmaIbSlave      => dmaIbSlave,
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
