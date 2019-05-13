-------------------------------------------------------------------------------
-- File       : AppDataProcessor.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: AppDataProcessor File
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
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.AppPkg.all;

entity AppDataProcessor is
   generic (
      TPD_G           : time    := 1 ns;
      SW_LOOPBACK_G   : boolean := false;
      AXI_BASE_ADDR_G : slv(31 downto 0));
   port (
      -- -- Streaming Interfaces
      linkUp          : in  sl;
      sAxisMaster     : in  AxiStreamMasterType;
      sAxisSlave      : out AxiStreamSlaveType;
      mAxisMaster     : out AxiStreamMasterType;
      mAxisSlave      : in  AxiStreamSlaveType;
      loopbackMaster  : in  AxiStreamMasterType;
      loopbackSlave   : out AxiStreamSlaveType;
      -- AXI-Lite Interface
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType);
end AppDataProcessor;

architecture mapping of AppDataProcessor is

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_RSSI_C-1 downto 0) := genAxiLiteConfig(NUM_RSSI_C, AXI_BASE_ADDR_G, 19, 16);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_RSSI_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_RSSI_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_RSSI_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_RSSI_C-1 downto 0);

   signal ibMaster : AxiStreamMasterType;
   signal ibSlave  : AxiStreamSlaveType;
   signal obMaster : AxiStreamMasterType;
   signal obSlave  : AxiStreamSlaveType;

begin

   ---------
   -- Inputs
   ---------
   SW_LOOPBACK : if SW_LOOPBACK_G generate
      ibMaster      <= loopbackMaster;
      loopbackSlave <= ibSlave;
      sAxisSlave    <= AXI_STREAM_SLAVE_FORCE_C;
   end generate;
   FW_LOOPBACK : if (not SW_LOOPBACK_G) generate
      ibMaster      <= sAxisMaster;
      sAxisSlave    <= ibSlave;
      loopbackSlave <= AXI_STREAM_SLAVE_FORCE_C;
   end generate;

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

   -----------------------------
   -- Generic AXI Stream Monitor
   -----------------------------
   U_AXIS_MON : entity work.AxiStreamMonAxiL
      generic map(
         TPD_G            => TPD_G,
         COMMON_CLK_G     => true,
         AXIS_CLK_FREQ_G  => 156.25E+6,
         AXIS_NUM_SLOTS_G => 2,
         AXIS_CONFIG_G    => APP_AXIS_CONFIG_C)
      port map(
         -- AXIS Stream Interface
         axisClk          => axilClk,
         axisRst          => axilRst,
         axisMasters(0)   => ibMaster,
         axisMasters(1)   => obMaster,
         axisSlaves(0)    => ibSlave,
         axisSlaves(1)    => obSlave,
         -- AXI lite slave port for register access
         axilClk          => axilClk,
         axilRst          => axilRst,
         sAxilWriteMaster => axilWriteMasters(0),
         sAxilWriteSlave  => axilWriteSlaves(0),
         sAxilReadMaster  => axilReadMasters(0),
         sAxilReadSlave   => axilReadSlaves(0));

   -----------------------------
   -- Generic AXI Stream Monitor
   -----------------------------
   U_PktMon : entity work.AppDataProcessorPktMon
      generic map(
         TPD_G => TPD_G)
      port map(
         -- AXIS Stream Interface
         ibMaster        => ibMaster,
         ibSlave         => ibSlave,
         -- AXI lite slave port for register access
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilWriteMaster => axilWriteMasters(1),
         axilWriteSlave  => axilWriteSlaves(1),
         axilReadMaster  => axilReadMasters(1),
         axilReadSlave   => axilReadSlaves(1));

   ------------------------------
   -- Placeholder for future code
   ------------------------------
   obMaster <= ibMaster;
   ibSlave  <= obSlave;

   ----------
   -- Outputs
   ----------
   mAxisMaster <= obMaster;
   obSlave     <= mAxisSlave;

end mapping;
