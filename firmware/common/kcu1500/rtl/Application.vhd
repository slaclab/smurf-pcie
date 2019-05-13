-------------------------------------------------------------------------------
-- File       : Application.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: Application File
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

entity Application is
   generic (
      TPD_G           : time := 1 ns;
      AXI_BASE_ADDR_G : slv(31 downto 0));
   port (
      -- DMA Interfaces (dmaClk domain)
      dmaClk          : in  sl;
      dmaRst          : in  sl;
      dmaObMasters    : in  AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      dmaObSlaves     : out AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      dmaIbMasters    : out AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      dmaIbSlaves     : in  AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      -- AXI-Lite Interface (axilClk domain)
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType;
      -- RSSI Interface (axilClk domain)
      rssiLinkUp      : in  slv(NUM_RSSI_C-1 downto 0);
      rssiIbMasters   : out AxiStreamMasterArray(NUM_AXIS_C-1 downto 0);
      rssiIbSlaves    : in  AxiStreamSlaveArray(NUM_AXIS_C-1 downto 0);
      rssiObMasters   : in  AxiStreamMasterArray(NUM_AXIS_C-1 downto 0);
      rssiObSlaves    : out AxiStreamSlaveArray(NUM_AXIS_C-1 downto 0));
end Application;

architecture mapping of Application is

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_RSSI_C-1 downto 0) := genAxiLiteConfig(NUM_RSSI_C, AXI_BASE_ADDR_G, 22, 19);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_RSSI_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_RSSI_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_RSSI_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_RSSI_C-1 downto 0);

begin

   ---------------------
   -- AXI-Lite Crossbar
   ---------------------
   U_XBAR : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 1,
         NUM_MASTER_SLOTS_G => NUM_RSSI_C,
         MASTERS_CONFIG_G   => AXI_CONFIG_C)
      port map (
         axiClk              => axilClk,
         axiClkRst           => axilRst,
         sAxiWriteMasters(0) => axilWriteMaster,
         sAxiWriteSlaves(0)  => axilWriteSlave,
         sAxiReadMasters(0)  => axilReadMaster,
         sAxiReadSlaves(0)   => axilReadSlave,
         mAxiWriteMasters    => axilWriteMasters,
         mAxiWriteSlaves     => axilWriteSlaves,
         mAxiReadMasters     => axilReadMasters,
         mAxiReadSlaves      => axilReadSlaves);

   --------------------
   -- Application Lanes
   --------------------
   GEN_VEC : for i in NUM_RSSI_C-1 downto 0 generate

      U_Lane : entity work.AppLane
         generic map (
            TPD_G           => TPD_G,
            LANE_G          => i,
            AXI_BASE_ADDR_G => AXI_CONFIG_C(i).baseAddr)
         port map (
            -- DMA Interfaces (dmaClk domain)
            dmaClk          => dmaClk,
            dmaRst          => dmaRst,
            dmaObMaster     => dmaObMasters(i),
            dmaObSlave      => dmaObSlaves(i),
            dmaIbMaster     => dmaIbMasters(i),
            dmaIbSlave      => dmaIbSlaves(i),
            -- RSSI Interface (axilClk domain)
            rssiLinkUp      => rssiLinkUp(i),
            rssiIbMasters   => rssiIbMasters((APP_STREAMS_C-1)+(APP_STREAMS_C*i) downto (APP_STREAMS_C*i)),
            rssiIbSlaves    => rssiIbSlaves((APP_STREAMS_C-1)+(APP_STREAMS_C*i) downto (APP_STREAMS_C*i)),
            rssiObMasters   => rssiObMasters((APP_STREAMS_C-1)+(APP_STREAMS_C*i) downto (APP_STREAMS_C*i)),
            rssiObSlaves    => rssiObSlaves((APP_STREAMS_C-1)+(APP_STREAMS_C*i) downto (APP_STREAMS_C*i)),
            -- AXI-Lite Interface (axilClk domain)
            axilClk         => axilClk,
            axilRst         => axilRst,
            axilReadMaster  => axilReadMasters(i),
            axilReadSlave   => axilReadSlaves(i),
            axilWriteMaster => axilWriteMasters(i),
            axilWriteSlave  => axilWriteSlaves(i));

   end generate GEN_VEC;

end mapping;
