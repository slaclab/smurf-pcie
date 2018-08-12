-------------------------------------------------------------------------------
-- File       : AppLaneRx.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-02-06
-- Last update: 2018-08-02
-------------------------------------------------------------------------------
-- Description: AppLaneRx File
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

entity AppLaneRx is
   generic (
      TPD_G           : time             := 1 ns;
      LANE_G          : natural          := 0;
      AXI_BASE_ADDR_G : slv(31 downto 0) := BAR0_BASE_ADDR_C);
   port (
      -- DMA Interfaces (axilClk domain)
      appObMasters    : out AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
      appObSlaves     : in  AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0);
      -- Loop Interfaces (axilClk domain)
      loopbackMasters : in  AxiStreamMasterArray(RSSI_PER_LINK_C-1 downto 0);
      loopbackSlaves  : out AxiStreamSlaveArray(RSSI_PER_LINK_C-1 downto 0);
      -- RSSI Interface (axilClk domain)
      rssiLinkUp      : in  slv(RSSI_PER_LINK_C-1 downto 0);
      rssiObMasters   : in  AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
      rssiObSlaves    : out AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0);
      -- AXI-Lite Interface (axilClk domain)
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType);
end AppLaneRx;

architecture mapping of AppLaneRx is

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(RSSI_PER_LINK_C-1 downto 0) := genAxiLiteConfig(RSSI_PER_LINK_C, AXI_BASE_ADDR_G, 19, 16);

   signal axilWriteMasters : AxiLiteWriteMasterArray(RSSI_PER_LINK_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(RSSI_PER_LINK_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(RSSI_PER_LINK_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(RSSI_PER_LINK_C-1 downto 0);

   signal tapIbMasters : AxiStreamMasterArray(RSSI_PER_LINK_C-1 downto 0);
   signal tapIbSlaves  : AxiStreamSlaveArray(RSSI_PER_LINK_C-1 downto 0);

   signal tapObMasters : AxiStreamMasterArray(RSSI_PER_LINK_C-1 downto 0);
   signal tapObSlaves  : AxiStreamSlaveArray(RSSI_PER_LINK_C-1 downto 0);

   signal masters : AxiStreamMasterArray(AXIS_PER_LINK_C-1 downto 0);
   signal slaves  : AxiStreamSlaveArray(AXIS_PER_LINK_C-1 downto 0);

begin

   process (rssiObMasters, slaves, tapIbSlaves, tapObMasters) is
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
               tapIbMasters(i)   <= rssiObMasters(idx);
               rssiObSlaves(idx) <= tapIbSlaves(i);
               -- Reroute traffic to outbound data processing
               masters(idx)      <= tapObMasters(i);
               tapObSlaves(i)    <= slaves(idx);
            else
               masters(idx)      <= rssiObMasters(idx);
               rssiObSlaves(idx) <= slaves(idx);
            end if;
         end loop;
      end loop;
   end process;

   U_XBAR : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 1,
         NUM_MASTER_SLOTS_G => RSSI_PER_LINK_C,
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

   GEN_VEC :
   for i in RSSI_PER_LINK_C-1 downto 0 generate

      U_AppDataProc : entity work.AppDataProcessor
         generic map (
            TPD_G           => TPD_G,
            AXI_BASE_ADDR_G => AXI_CONFIG_C(i).baseAddr)
         port map (
            -- Streaming Interfaces
            linkUp          => rssiLinkUp(i),
            sAxisMaster     => tapIbMasters(i),
            sAxisSlave      => tapIbSlaves(i),
            mAxisMaster     => tapObMasters(i),
            mAxisSlave      => tapObSlaves(i),
            loopbackMaster  => loopbackMasters(i),
            loopbackSlave   => loopbackSlaves(i),
            -- AXI-Lite Interface
            axilClk         => axilClk,
            axilRst         => axilRst,
            axilReadMaster  => axilReadMasters(i),
            axilReadSlave   => axilReadSlaves(i),
            axilWriteMaster => axilWriteMasters(i),
            axilWriteSlave  => axilWriteSlaves(i));
   end generate GEN_VEC;

   GEN_LANE :
   for i in AXIS_PER_LINK_C-1 downto 0 generate
      U_ASYNC : entity work.AxiStreamFifoV2
         generic map (
            -- General Configurations
            TPD_G               => TPD_G,
            INT_PIPE_STAGES_G   => 1,
            PIPE_STAGES_G       => 1,
            SLAVE_READY_EN_G    => true,
            VALID_THOLD_G       => (2048/APP_AXIS_CONFIG_C.TDATA_BYTES_C),  -- Hold until enough to burst into the interleaving MUX
            VALID_BURST_MODE_G  => true,
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
            sAxisMaster => masters(i),
            sAxisSlave  => slaves(i),
            -- Master Port
            mAxisClk    => axilClk,
            mAxisRst    => axilRst,
            mAxisMaster => appObMasters(i),
            mAxisSlave  => appObSlaves(i));
   end generate GEN_LANE;

end mapping;
