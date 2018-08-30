-------------------------------------------------------------------------------
-- File       : Hardware.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-02-06
-- Last update: 2018-07-27
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
use work.AxiPciePkg.all;
use work.EthMacPkg.all;
use work.AppPkg.all;

entity Hardware is
   generic (
      TPD_G           : time             := 1 ns;
      ETH_10G_G       : boolean          := true;
      AXI_BASE_ADDR_G : slv(31 downto 0) := BAR0_BASE_ADDR_C);
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
      rssiIbMasters   : in  AxiStreamMasterArray(NUM_AXIS_C-1 downto 0);
      rssiIbSlaves    : out AxiStreamSlaveArray(NUM_AXIS_C-1 downto 0);
      rssiObMasters   : out AxiStreamMasterArray(NUM_AXIS_C-1 downto 0);
      rssiObSlaves    : in  AxiStreamSlaveArray(NUM_AXIS_C-1 downto 0);
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

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_LINKS_C-1 downto 0) := genAxiLiteConfig(NUM_LINKS_C, AXI_BASE_ADDR_G, 22, 19);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_LINKS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_LINKS_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_LINKS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_LINKS_C-1 downto 0);

   signal macObMasters : AxiStreamMasterArray(NUM_LINKS_C-1 downto 0);
   signal macObSlaves  : AxiStreamSlaveArray(NUM_LINKS_C-1 downto 0);
   signal macIbMasters : AxiStreamMasterArray(NUM_LINKS_C-1 downto 0);
   signal macIbSlaves  : AxiStreamSlaveArray(NUM_LINKS_C-1 downto 0);

   signal extRst   : sl;
   signal phyReady : slv(NUM_LINKS_C-1 downto 0);
   signal localMac : Slv48Array(NUM_LINKS_C-1 downto 0);

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
         dmaIbMasters => macObMasters,
         dmaIbSlaves  => macObSlaves,
         dmaObMasters => macIbMasters,
         dmaObSlaves  => macIbSlaves,
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

   ---------------------
   -- AXI-Lite Crossbar
   ---------------------
   U_XBAR : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 1,
         NUM_MASTER_SLOTS_G => NUM_LINKS_C,
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

   ------------
   -- ETH Lanes
   ------------
   GEN_VEC : for i in NUM_LINKS_C-1 downto 0 generate

      U_Lane : entity work.EthLane
         generic map (
            TPD_G           => TPD_G,
            CLK_FREQUENCY_G => ite(ETH_10G_G,156.25E+6,125.0E+6),
            AXI_BASE_ADDR_G => AXI_CONFIG_C(i).baseAddr)
         port map (
            -- RSSI Interface (axilClk domain)
            rssiLinkUp      => rssiLinkUp((RSSI_PER_LINK_C-1)+(RSSI_PER_LINK_C*i) downto (RSSI_PER_LINK_C*i)),
            rssiIbMasters   => rssiIbMasters((AXIS_PER_LINK_C-1)+(AXIS_PER_LINK_C*i) downto (AXIS_PER_LINK_C*i)),
            rssiIbSlaves    => rssiIbSlaves((AXIS_PER_LINK_C-1)+(AXIS_PER_LINK_C*i) downto (AXIS_PER_LINK_C*i)),
            rssiObMasters   => rssiObMasters((AXIS_PER_LINK_C-1)+(AXIS_PER_LINK_C*i) downto (AXIS_PER_LINK_C*i)),
            rssiObSlaves    => rssiObSlaves((AXIS_PER_LINK_C-1)+(AXIS_PER_LINK_C*i) downto (AXIS_PER_LINK_C*i)),
            -- PHY Interface (axilClk domain)
            macObMaster     => macObMasters(i),
            macObSlave      => macObSlaves(i),
            macIbMaster     => macIbMasters(i),
            macIbSlave      => macIbSlaves(i),
            phyReady        => phyReady(i),
            mac             => localMac(i),
            -- AXI-Lite Interface (axilClk domain)
            axilClk         => axilClk,
            axilRst         => axilRst,
            axilReadMaster  => axilReadMasters(i),
            axilReadSlave   => axilReadSlaves(i),
            axilWriteMaster => axilWriteMasters(i),
            axilWriteSlave  => axilWriteSlaves(i));

   end generate GEN_VEC;

end mapping;
