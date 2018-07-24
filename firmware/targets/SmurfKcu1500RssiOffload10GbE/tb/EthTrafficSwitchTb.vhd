-------------------------------------------------------------------------------
-- File       : EthTrafficSwitchTb.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-01-29
-- Last update: 2018-03-25
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- This file is part of 'ATLAS FTK DF DEV'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'ATLAS FTK DF DEV', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.StdRtlPkg.all;
use work.AxiPkg.all;
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.AxiPciePkg.all;
use work.EthMacPkg.all;
use work.AppPkg.all;
use work.SsiPkg.all;

entity EthTrafficSwitchTb is end EthTrafficSwitchTb;

architecture testbed of EthTrafficSwitchTb is

   constant CLK_PERIOD_C : time := 10 ns;
   constant TPD_G        : time := CLK_PERIOD_C/4;

   type RegType is record
      cnt        : slv(31 downto 0);
      axisMaster : AxiStreamMasterType;
   end record RegType;
   constant REG_INIT_C : RegType := (
      cnt        => (others => '0'),
      axisMaster => AXI_STREAM_MASTER_INIT_C);

   signal r   : RegType := REG_INIT_C;
   signal rin : RegType;

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_LINKS_C-1 downto 0) := (others => AXI_LITE_WRITE_MASTER_INIT_C);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_LINKS_C-1 downto 0)  := (others => AXI_LITE_WRITE_SLAVE_EMPTY_DECERR_C);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_LINKS_C-1 downto 0)  := (others => AXI_LITE_READ_MASTER_INIT_C);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_LINKS_C-1 downto 0)   := (others => AXI_LITE_READ_SLAVE_EMPTY_DECERR_C);

   signal dmaObMasters : AxiStreamMasterArray(7 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal dmaObSlaves  : AxiStreamSlaveArray(7 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);

   signal rssiLinkUp    : slv(NUM_RSSI_C-1 downto 0)                  := (others => '0');
   signal rssiIbMasters : AxiStreamMasterArray(NUM_AXIS_C-1 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal rssiIbSlaves  : AxiStreamSlaveArray(NUM_AXIS_C-1 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);
   signal rssiObMasters : AxiStreamMasterArray(NUM_AXIS_C-1 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal rssiObSlaves  : AxiStreamSlaveArray(NUM_AXIS_C-1 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);

   signal macMasters : AxiStreamMasterArray(1 downto 0) := (others => AXI_STREAM_MASTER_INIT_C);
   signal macSlaves  : AxiStreamSlaveArray(1 downto 0)  := (others => AXI_STREAM_SLAVE_FORCE_C);
   
   signal clk     : sl := '0';
   signal rst     : sl := '1';
   signal cfgDone : sl := '0';

begin

   -----------------------------
   -- Generate clocks and resets
   -----------------------------
   U_ClkRst : entity work.ClkRst
      generic map (
         CLK_PERIOD_G      => CLK_PERIOD_C,
         RST_START_DELAY_G => 0 ns,  -- Wait this long into simulation before asserting reset
         RST_HOLD_TIME_G   => 1000 ns)  -- Hold reset for this long)
      port map (
         clkP => clk,
         rst  => rst);

   ---------------------
   -- Application Module
   ---------------------
   U_Application : entity work.Application
      generic map (
         TPD_G => TPD_G)
      port map (
         -- DMA Interface (dmaClk domain)
         dmaClk          => clk,
         dmaRst          => rst,
         dmaObMasters    => dmaObMasters,
         dmaObSlaves     => dmaObSlaves,
         dmaIbMasters    => open,
         dmaIbSlaves     => (others => AXI_STREAM_SLAVE_FORCE_C),
         -- Memory bus (dmaClk domain)
         memReady        => (others => '1'),
         memWriteMasters => open,
         memWriteSlaves  => (others => AXI_WRITE_SLAVE_FORCE_C),
         memReadMasters  => open,
         memReadSlaves   => (others => AXI_READ_SLAVE_FORCE_C),
         -- RSSI Interface (axilClk domain)
         rssiLinkUp      => rssiLinkUp,
         rssiIbMasters   => rssiIbMasters,
         rssiIbSlaves    => rssiIbSlaves,
         rssiObMasters   => rssiObMasters,
         rssiObSlaves    => rssiObSlaves,
         -- AXI-Lite Interface (axilClk domain)
         axilClk         => clk,
         axilRst         => rst,
         axilReadMaster  => AXI_LITE_READ_MASTER_INIT_C,
         axilReadSlave   => open,
         axilWriteMaster => AXI_LITE_WRITE_MASTER_INIT_C,
         axilWriteSlave  => open);

   ------------
   -- ETH Lanes
   ------------

   U_Lane : entity work.EthLane
      generic map (
         TPD_G           => TPD_G,
         AXI_BASE_ADDR_G => x"0000_0000")
      port map (
         -- RSSI Interface (axilClk domain)
         rssiLinkUp      => rssiLinkUp((RSSI_PER_LINK_C-1)+(RSSI_PER_LINK_C*0) downto (RSSI_PER_LINK_C*0)),
         rssiIbMasters   => rssiIbMasters((AXIS_PER_LINK_C-1)+(AXIS_PER_LINK_C*0) downto (AXIS_PER_LINK_C*0)),
         rssiIbSlaves    => rssiIbSlaves((AXIS_PER_LINK_C-1)+(AXIS_PER_LINK_C*0) downto (AXIS_PER_LINK_C*0)),
         rssiObMasters   => rssiObMasters((AXIS_PER_LINK_C-1)+(AXIS_PER_LINK_C*0) downto (AXIS_PER_LINK_C*0)),
         rssiObSlaves    => rssiObSlaves((AXIS_PER_LINK_C-1)+(AXIS_PER_LINK_C*0) downto (AXIS_PER_LINK_C*0)),
         -- PHY Interface (axilClk domain)
         macObMaster     => macMasters(0),
         macObSlave      => macSlaves(0),
         macIbMaster     => macMasters(1),
         macIbSlave      => macSlaves(1),
         phyReady        => '1',
         mac             => open,
         -- AXI-Lite Interface (axilClk domain)
         axilClk         => clk,
         axilRst         => rst,
         axilReadMaster  => axilReadMasters(0),
         axilReadSlave   => axilReadSlaves(0),
         axilWriteMaster => axilWriteMasters(0),
         axilWriteSlave  => axilWriteSlaves(0));


   ----------------------
   -- IPv4/ARP/UDP Engine
   ----------------------
   U_UDP : entity work.UdpEngineWrapper
      generic map (
         -- Simulation Generics
         TPD_G          => TPD_G,
         -- UDP Server Generics
         SERVER_EN_G    => true,
         SERVER_SIZE_G  => RSSI_PER_LINK_C,
         SERVER_PORTS_G => (
            0           => 8192,
            1           => 8193,
            2           => 8194,
            3           => 8195,
            4           => 8196,
            5           => 8197),
         -- UDP Client Generics
         CLIENT_EN_G    => false)
      port map (
         -- Local Configurations
         localMac        => x"BA98_7654_3210",
         localIp         => x"0201_A8C0",
         -- Interface to Ethernet Media Access Controller (MAC)
         obMacMaster     => macMasters(1),
         obMacSlave      => macSlaves(1),
         ibMacMaster     => macMasters(0),
         ibMacSlave      => macSlaves(0),
         -- Interface to UDP Server engine(s)
         obServerMasters => open,
         obServerSlaves  => (others=>AXI_STREAM_SLAVE_FORCE_C),
         ibServerMasters => (others=>AXI_STREAM_MASTER_INIT_C),
         ibServerSlaves  => open,
         -- Clock and Reset
         clk             => clk,
         rst             => rst);
         
   -------------------------------
   -- Generate different addresses
   -------------------------------
   comb : process (cfgDone, dmaObSlaves, r, rst) is
      variable v : RegType;
   begin
      -- Latch the current value
      v := r;

      if (dmaObSlaves(0).tReady = '1') then
         v.axisMaster.tValid := '0';
         v.axisMaster.tUser  := (others => '0');
         v.axisMaster.tLast  := '0';
      end if;

      -- Check if ready to move data
      if (v.axisMaster.tValid = '0') and (cfgDone = '1') then

         -- Send data
         v.axisMaster.tValid             := '1';
         v.axisMaster.tData(31 downto 0) := r.cnt;

         -- Increment the counter
         v.cnt := r.cnt + 1;

         -- Check for SOF
         if (r.cnt = 0) then

            -- Set the SOF flag
            v.axisMaster.tUser(1) := '1';

            -- Update the tDest
            if r.axisMaster.tDest = 23 then
               v.axisMaster.tDest := (others => '0');
            else
               v.axisMaster.tDest := r.axisMaster.tDest + 1;
            end if;

         end if;

         -- Check for EOF
         if (r.cnt = 15) then
            -- Set the EOF flag
            v.axisMaster.tLast := '1';
            -- Reset the counter
            v.cnt              := (others => '0');
         end if;

      end if;

      -- Reset
      if (rst = '1') then
         v                  := REG_INIT_C;
         v.axisMaster.tDest := x"FF";
      end if;

      -- Register the variable for next clock cycle
      rin <= v;

      -- Outputs
      dmaObMasters(0)          <= r.axisMaster;
      dmaObMasters(7 downto 1) <= (others => AXI_STREAM_MASTER_INIT_C);

   end process comb;

   seq : process (clk) is
   begin
      if rising_edge(clk) then
         r <= rin after TPD_G;
      end if;
   end process seq;


   test : process is
      variable i  : natural;
      variable ch : natural;
   begin

      wait until rst = '1';
      wait until rst = '0';

      -- Configure the MAC/IP/bypRssi
      report "Configure the MAC/IP/bypRssi ...." severity warning;
      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0000_0000"), x"FFFF_EEEE", true);  -- MAC[47:32]
      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0000_0004"), x"AAAA_BBBB", true);  -- MAC[31:0]
      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0000_0008"), x"0101_A8C0", true);  -- 192.168.1.1
      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0000_000C"), x"FFFF_FFFF", true);  -- bypass all RSSI
      report ".... done!" severity warning;

      -- Configure the UDP remote IP/ports
      report "Configure the UDP remote IP/ports ...." severity warning;
      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0001_0000"), x"0000_0020", true);  -- port = 8192
      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0001_0004"), x"0201_A8C0", true);  -- 192.168.1.2

      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0001_0008"), x"0000_1020", true);  -- port = 8193
      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0001_000C"), x"0201_A8C0", true);  -- 192.168.1.2

      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0001_0010"), x"0000_2020", true);  -- port = 8194
      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0001_0014"), x"0201_A8C0", true);  -- 192.168.1.2

      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0001_0018"), x"0000_3020", true);  -- port = 8195
      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0001_001C"), x"0201_A8C0", true);  -- 192.168.1.2

      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0001_0020"), x"0000_4020", true);  -- port = 8196
      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0001_0024"), x"0201_A8C0", true);  -- 192.168.1.2

      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0001_0028"), x"0000_5020", true);  -- port = 8197
      axiLiteBusSimWrite(clk, axilWriteMasters(0), axilWriteSlaves(0), (x"0001_002C"), x"0201_A8C0", true);  -- 192.168.1.2
      report ".... done!" severity warning;


      report "cfgDone = 0x1" severity warning;
      cfgDone <= '1';

   end process test;



end testbed;
