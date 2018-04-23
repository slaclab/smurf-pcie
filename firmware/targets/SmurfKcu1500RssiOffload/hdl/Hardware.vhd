-------------------------------------------------------------------------------
-- File       : Hardware.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-02-06
-- Last update: 2018-02-06
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

library unisim;
use unisim.vcomponents.all;

entity Hardware is
   generic (
      TPD_G            : time             := 1 ns;
      AXI_BASE_ADDR_G  : slv(31 downto 0) := BAR0_BASE_ADDR_C);
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

   signal ethRefClk : slv(7 downto 0);
   signal ethRxP    : slv(7 downto 0);
   signal ethRxN    : slv(7 downto 0);
   signal ethTxP    : slv(7 downto 0);
   signal ethTxN    : slv(7 downto 0);

   signal macClk       : slv(7 downto 0);
   signal macRst       : slv(7 downto 0);
   signal macObMasters : AxiStreamMasterArray(7 downto 0);
   signal macObSlaves  : AxiStreamSlaveArray(7 downto 0);
   signal macIbMasters : AxiStreamMasterArray(7 downto 0);
   signal macIbSlaves  : AxiStreamSlaveArray(7 downto 0);

   signal phyReady : slv(7 downto 0);
   signal localMac : Slv48Array(7 downto 0);

   signal refClk : slv(1 downto 0);

   attribute dont_touch           : string;
   attribute dont_touch of refClk : signal is "TRUE";

begin

   macClk <= (others => axilClk);
   macRst <= (others => axilRst);

   --------------------
   -- Unused GTH Clocks
   --------------------
   U_QsfpRef0 : IBUFDS_GTE3
      port map (
         I   => qsfp0RefClkP(1),
         IB  => qsfp0RefClkN(1),
         CEB => '0',
         O   => refClk(0));

   U_QsfpRef1 : IBUFDS_GTE3
      port map (
         I   => qsfp1RefClkP(1),
         IB  => qsfp1RefClkN(1),
         CEB => '0',
         O   => refClk(1));

   --------------------------------
   -- Mapping QSFP[1:0] to ETH[7:0]
   --------------------------------
   MAP_QSFP : for i in 3 downto 0 generate
      -- QSFP[0] to ETH[3:0]
      ethRefClk(i+0) <= refClk(0);
      ethRxP(i+0)    <= qsfp0RxP(i);
      ethRxN(i+0)    <= qsfp0RxN(i);
      qsfp0TxP(i)    <= ethTxP(i+0);
      qsfp0TxN(i)    <= ethTxN(i+0);
      -- QSFP[1] to ETH[7:4]
      ethRefClk(i+4) <= refClk(1);
      ethRxP(i+4)    <= qsfp1RxP(i);
      ethRxN(i+4)    <= qsfp1RxN(i);
      qsfp1TxP(i)    <= ethTxP(i+4);
      qsfp1TxN(i)    <= ethTxN(i+4);
   end generate MAP_QSFP;

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

   -----------------------------
   -- 10 GigE Module for QSFP[0]
   -----------------------------
   U_10GigE_0 : entity work.TenGigEthGthUltraScaleWrapper
      generic map (
         TPD_G         => TPD_G,
         NUM_LANE_G    => 4,
         AXIS_CONFIG_G => (others => EMAC_AXIS_CONFIG_C))
      port map (
         -- Local Configurations
         localMac     => localMac(3 downto 0),
         -- Streaming DMA Interface 
         dmaClk       => macClk(3 downto 0),
         dmaRst       => macRst(3 downto 0),
         dmaIbMasters => macObMasters(3 downto 0),
         dmaIbSlaves  => macObSlaves(3 downto 0),
         dmaObMasters => macIbMasters(3 downto 0),
         dmaObSlaves  => macIbSlaves(3 downto 0),
         -- Misc. Signals
         extRst       => axilRst,
         phyReady     => phyReady(3 downto 0),
         -- MGT Clock Port
         gtClkP       => qsfp0RefClkP(0),
         gtClkN       => qsfp0RefClkN(0),
         -- MGT Ports
         gtTxP        => qsfp0TxP,
         gtTxN        => qsfp0TxN,
         gtRxP        => qsfp0RxP,
         gtRxN        => qsfp0RxN);

   -----------------------------
   -- 10 GigE Module for QSFP[1]
   -----------------------------
   U_10GigE_1 : entity work.TenGigEthGthUltraScaleWrapper
      generic map (
         TPD_G         => TPD_G,
         NUM_LANE_G    => 4,
         AXIS_CONFIG_G => (others => EMAC_AXIS_CONFIG_C))
      port map (
         -- Local Configurations
         localMac     => localMac(7 downto 4),
         -- Streaming DMA Interface 
         dmaClk       => macClk(7 downto 4),
         dmaRst       => macRst(7 downto 4),
         dmaIbMasters => macObMasters(7 downto 4),
         dmaIbSlaves  => macObSlaves(7 downto 4),
         dmaObMasters => macIbMasters(7 downto 4),
         dmaObSlaves  => macIbSlaves(7 downto 4),
         -- Misc. Signals
         extRst       => axilRst,
         phyReady     => phyReady(7 downto 4),
         -- MGT Clock Port
         gtClkP       => qsfp1RefClkP(0),
         gtClkN       => qsfp1RefClkN(0),
         -- MGT Ports
         gtTxP        => qsfp1TxP,
         gtTxN        => qsfp1TxN,
         gtRxP        => qsfp1RxP,
         gtRxN        => qsfp1RxN);

   ------------
   -- ETH Lanes
   ------------
   GEN_VEC : for i in 7 downto 0 generate

      GEN_LANE : if (i < NUM_LINKS_C) generate

         U_Lane : entity work.EthLane
            generic map (
               TPD_G            => TPD_G,
               AXI_BASE_ADDR_G  => AXI_CONFIG_C(i).baseAddr)
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

      end generate GEN_LANE;

      BYP_LANE : if (i >= NUM_LINKS_C) generate

         macObSlaves(i)  <= AXI_STREAM_SLAVE_FORCE_C;
         macIbMasters(i) <= AXI_STREAM_MASTER_INIT_C;
         localMac(i)     <= (others => '0');

      end generate BYP_LANE;

   end generate GEN_VEC;

end mapping;
