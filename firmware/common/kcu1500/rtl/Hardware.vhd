-------------------------------------------------------------------------------
-- File       : Hardware.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: Hardware File
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
use work.EthMacPkg.all;
use work.AppPkg.all;

entity Hardware is
   generic (
      TPD_G           : time    := 1 ns;
      ETH_10G_G       : boolean := true;
      AXI_BASE_ADDR_G : slv(31 downto 0));
   port (
      ------------------------      
      --  Top Level Interfaces
      ------------------------    
      -- AXI-Lite Interface
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType;
      -- RSSI Interface (axilClk domain)
      rssiLinkUp      : out slv(NUM_RSSI_C-1 downto 0);
      rssiIbMasters   : in  AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      rssiIbSlaves    : out AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      rssiObMasters   : out AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
      rssiObSlaves    : in  AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
      ---------------------
      --  Hardware Ports
      ---------------------    
      -- QSFP[0] Ports
      qsfp0RefClkP    : in  slv(1 downto 0);
      qsfp0RefClkN    : in  slv(1 downto 0);
      qsfp0RxP        : in  slv(3 downto 0);
      qsfp0RxN        : in  slv(3 downto 0);
      qsfp0TxP        : out slv(3 downto 0);
      qsfp0TxN        : out slv(3 downto 0);
      -- QSFP[1] Ports
      qsfp1RefClkP    : in  slv(1 downto 0);
      qsfp1RefClkN    : in  slv(1 downto 0);
      qsfp1RxP        : in  slv(3 downto 0);
      qsfp1RxN        : in  slv(3 downto 0);
      qsfp1TxP        : out slv(3 downto 0);
      qsfp1TxN        : out slv(3 downto 0));
end Hardware;

architecture mapping of Hardware is

   signal macObMaster : AxiStreamMasterType;
   signal macObSlave  : AxiStreamSlaveType;
   signal macIbMaster : AxiStreamMasterType;
   signal macIbSlave  : AxiStreamSlaveType;

   signal linkUp    : slv(NUM_RSSI_C-1 downto 0);
   signal ibMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal ibSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);
   signal obMasters : AxiStreamMasterArray(NUM_RSSI_C-1 downto 0);
   signal obSlaves  : AxiStreamSlaveArray(NUM_RSSI_C-1 downto 0);

   signal extRst   : sl;
   signal phyReady : sl;
   signal localMac : slv(47 downto 0);

begin

   -----------------
   -- Power Up Reset
   -----------------
   U_PwrUpRst : entity work.PwrUpRst
      generic map (
         TPD_G => TPD_G)
      port map (
         arst   => axilRst,
         clk    => axilClk,
         rstOut => extRst);

   --------------------------------------------
   -- 10 GigE (or 1 GigE) Modules for QSFP[1:0]
   --------------------------------------------
   U_EthPhyMac : entity work.EthPhyWrapper
      generic map (
         TPD_G     => TPD_G,
         ETH_10G_G => ETH_10G_G)
      port map (
         -- Local Configurations
         localMac     => localMac,
         -- Streaming DMA Interface 
         dmaClk       => axilClk,
         dmaRst       => axilRst,
         dmaIbMaster  => macObMaster,
         dmaIbSlave   => macObSlave,
         dmaObMaster  => macIbMaster,
         dmaObSlave   => macIbSlave,
         -- Misc. Signals
         extRst       => extRst,
         phyReady     => phyReady,
         ---------------------
         --  Hardware Ports
         ---------------------    
         -- QSFP[0] Ports
         qsfp0RefClkP => qsfp0RefClkP,
         qsfp0RefClkN => qsfp0RefClkN,
         qsfp0RxP     => qsfp0RxP,
         qsfp0RxN     => qsfp0RxN,
         qsfp0TxP     => qsfp0TxP,
         qsfp0TxN     => qsfp0TxN,
         -- QSFP[1] Ports
         qsfp1RefClkP => qsfp1RefClkP,
         qsfp1RefClkN => qsfp1RefClkN,
         qsfp1RxP     => qsfp1RxP,
         qsfp1RxN     => qsfp1RxN,
         qsfp1TxN     => qsfp1TxN,
         qsfp1TxP     => qsfp1TxP);

   ------------
   -- ETH Lanes
   ------------
   U_Lane : entity work.EthLane
      generic map (
         TPD_G           => TPD_G,
         CLK_FREQUENCY_G => ite(ETH_10G_G, 156.25E+6, 125.0E+6),
         AXI_BASE_ADDR_G => AXI_BASE_ADDR_G)
      port map (
         -- RSSI Interface (axilClk domain)
         rssiLinkUp      => linkUp,
         rssiIbMasters   => ibMasters,
         rssiIbSlaves    => ibSlaves,
         rssiObMasters   => obMasters,
         rssiObSlaves    => obSlaves,
         -- PHY Interface (axilClk domain)
         macObMaster     => macObMaster,
         macObSlave      => macObSlave,
         macIbMaster     => macIbMaster,
         macIbSlave      => macIbSlave,
         phyReady        => phyReady,
         mac             => localMac,
         -- AXI-Lite Interface (axilClk domain)
         axilClk         => axilClk,
         axilRst         => axilRst,
         axilReadMaster  => axilReadMaster,
         axilReadSlave   => axilReadSlave,
         axilWriteMaster => axilWriteMaster,
         axilWriteSlave  => axilWriteSlave);

   -----------------------------------------------------------------
   -- Adding Pipelining to help with making timing between SLR0/SLR1
   -----------------------------------------------------------------
   GEN_VEC : for i in NUM_RSSI_C-1 downto 0 generate

      U_IbPipe : entity work.AxiStreamPipeline
         generic map (
            TPD_G         => TPD_G,
            PIPE_STAGES_G => 1)
         port map (
            axisClk     => axilClk,
            axisRst     => axilRst,
            sAxisMaster => rssiIbMasters(i),
            sAxisSlave  => rssiIbSlaves(i),
            mAxisMaster => ibMasters(i),
            mAxisSlave  => ibSlaves(i));

      U_ObPipe : entity work.AxiStreamPipeline
         generic map (
            TPD_G         => TPD_G,
            PIPE_STAGES_G => 1)
         port map (
            axisClk     => axilClk,
            axisRst     => axilRst,
            sAxisMaster => obMasters(i),
            sAxisSlave  => obSlaves(i),
            mAxisMaster => rssiObMasters(i),
            mAxisSlave  => rssiObSlaves(i));

   end generate GEN_VEC;

   process(axilClk)
   begin
      if rising_edge(axilClk) then
         rssiLinkUp <= linkUp after TPD_G;  -- Adding Pipelining to help with making timing between SLR0/SLR1
      end if;
   end process;

end mapping;
