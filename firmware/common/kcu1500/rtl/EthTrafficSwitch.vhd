-------------------------------------------------------------------------------
-- File       : EthTrafficSwitch.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: Ethernet Traffic Switch for routing either RAW UDP or RSSI+UDP
-------------------------------------------------------------------------------
-- This file is part of 'SLAC Firmware Standard Library'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'SLAC Firmware Standard Library', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.StdRtlPkg.all;
use work.AxiStreamPkg.all;
use work.SsiPkg.all;
use work.AppPkg.all;

entity EthTrafficSwitch is
   generic (
      TPD_G : time := 1 ns);
   port (
      -- Clock and reset
      axisClk        : in  sl;
      axisRst        : in  sl;
      -- Controls Interface
      rssiLinkUp     : in  sl;
      -- UDP Interface
      sUdpMasters    : in  AxiStreamMasterArray(CLIENT_SIZE_C-1 downto 0);
      sUdpSlaves     : out AxiStreamSlaveArray(CLIENT_SIZE_C-1 downto 0);
      mUdpMasters    : out AxiStreamMasterArray(CLIENT_SIZE_C-1 downto 0);
      mUdpSlaves     : in  AxiStreamSlaveArray(CLIENT_SIZE_C-1 downto 0);
      -- RSSI Transport Interface
      sRssiTspMaster : in  AxiStreamMasterType;
      sRssiTspSlave  : out AxiStreamSlaveType;
      mRssiTspMaster : out AxiStreamMasterType;
      mRssiTspSlave  : in  AxiStreamSlaveType;
      -- RSSI Application Interface
      sRssiAppMaster : in  AxiStreamMasterType;
      sRssiAppSlave  : out AxiStreamSlaveType;
      mRssiAppMaster : out AxiStreamMasterType;
      mRssiAppSlave  : in  AxiStreamSlaveType;
      -- DMA Interface
      sDmaMaster     : in  AxiStreamMasterType;
      sDmaSlave      : out AxiStreamSlaveType;
      mDmaMaster     : out AxiStreamMasterType;
      mDmaSlave      : in  AxiStreamSlaveType);
end EthTrafficSwitch;

architecture rtl of EthTrafficSwitch is

   constant DEMUX_ROUTES_C : Slv8Array(CLIENT_SIZE_C-1 downto 0) := (
      0 => "--------",
      1 => x"C0");

   constant MUX_ROUTES_C : Slv8Array(CLIENT_SIZE_C-1 downto 0) := (
      0 => "--------",
      1 => "--------");

   type RegType is record
      sUdpSlaves     : AxiStreamSlaveArray(CLIENT_SIZE_C-1 downto 0);
      mUdpMasters    : AxiStreamMasterArray(CLIENT_SIZE_C-1 downto 0);
      sRssiTspSlave  : AxiStreamSlaveType;
      mRssiTspMaster : AxiStreamMasterType;
      sRssiAppSlave  : AxiStreamSlaveType;
      mRssiAppMaster : AxiStreamMasterType;
      sDmaSlaves     : AxiStreamSlaveArray(CLIENT_SIZE_C-1 downto 0);
      mDmaMasters    : AxiStreamMasterArray(CLIENT_SIZE_C-1 downto 0);
   end record RegType;

   constant REG_INIT_C : RegType := (
      sUdpSlaves     => (others => AXI_STREAM_SLAVE_INIT_C),
      mUdpMasters    => (others => AXI_STREAM_MASTER_INIT_C),
      sRssiTspSlave  => AXI_STREAM_SLAVE_INIT_C,
      mRssiTspMaster => AXI_STREAM_MASTER_INIT_C,
      sRssiAppSlave  => AXI_STREAM_SLAVE_INIT_C,
      mRssiAppMaster => AXI_STREAM_MASTER_INIT_C,
      sDmaSlaves     => (others => AXI_STREAM_SLAVE_INIT_C),
      mDmaMasters    => (others => AXI_STREAM_MASTER_INIT_C));

   signal r   : RegType := REG_INIT_C;
   signal rin : RegType;

   signal sDmaMasters : AxiStreamMasterArray(CLIENT_SIZE_C-1 downto 0);
   signal sDmaSlaves  : AxiStreamSlaveArray(CLIENT_SIZE_C-1 downto 0);
   signal mDmaMasters : AxiStreamMasterArray(CLIENT_SIZE_C-1 downto 0);
   signal mDmaSlaves  : AxiStreamSlaveArray(CLIENT_SIZE_C-1 downto 0);

begin

   U_AxiStreamDeMux : entity work.AxiStreamDeMux
      generic map (
         TPD_G          => TPD_G,
         PIPE_STAGES_G  => 1,
         NUM_MASTERS_G  => CLIENT_SIZE_C,
         MODE_G         => "ROUTED",
         TDEST_ROUTES_G => DEMUX_ROUTES_C)
      port map (
         -- Clock and reset
         axisClk      => axisClk,
         axisRst      => axisRst,
         -- Slaves
         sAxisMaster  => sDmaMaster,
         sAxisSlave   => sDmaSlave,
         -- Master
         mAxisMasters => sDmaMasters,
         mAxisSlaves  => sDmaSlaves);

   comb : process (axisRst, mDmaSlaves, mRssiAppSlave, mRssiTspSlave,
                   mUdpSlaves, r, rssiLinkUp, sDmaMasters, sRssiAppMaster,
                   sRssiTspMaster, sUdpMasters) is
      variable v : RegType;
      variable i : natural;
   begin
      -- Latch the current value
      v := r;

      -- Reset strobing signals
      for i in CLIENT_SIZE_C-1 downto 0 loop
         v.sUdpSlaves(i).tReady := '0';
         v.sDmaSlaves(i).tReady := '0';
      end loop;
      v.sRssiTspSlave.tReady := '0';
      v.sRssiAppSlave.tReady := '0';

      -- Update tValid variable
      for i in CLIENT_SIZE_C-1 downto 0 loop

         if mUdpSlaves(i).tReady = '1' then
            v.mUdpMasters(i).tValid := '0';
         end if;

         if mDmaSlaves(i).tReady = '1' then
            v.mDmaMasters(i).tValid := '0';
         end if;

      end loop;

      -- Update tValid variable
      if mRssiTspSlave.tReady = '1' then
         v.mRssiTspMaster.tValid := '0';
      end if;

      -- Update tValid variable
      if mRssiAppSlave.tReady = '1' then
         v.mRssiAppMaster.tValid := '0';
      end if;

      -- Connect sUdp(1) -> mDma(1)
      if (v.mDmaMasters(1).tValid = '0') and (sUdpMasters(1).tValid = '1') then
         -- Accept the data
         v.sUdpSlaves(1).tReady := '1';
         -- Move the data
         v.mDmaMasters(1)       := sUdpMasters(1);
         -- Force the TDEST = 0xC0
         v.mDmaMasters(1).tDest := x"C0";
      end if;

      -- Connect sDma(1) -> mUdp(1)
      if (v.mUdpMasters(1).tValid = '0') and (sDmaMasters(1).tValid = '1') then
         -- Accept the data
         v.sDmaSlaves(1).tReady := '1';
         -- Move the data
         v.mUdpMasters(1)       := sDmaMasters(1);
      end if;

      -- Connect sUdp(0) -> mRssiTsp
      if (v.mRssiTspMaster.tValid = '0') and (sUdpMasters(0).tValid = '1') then
         -- Accept the data
         v.sUdpSlaves(0).tReady := '1';
         -- Move the data
         v.mRssiTspMaster       := sUdpMasters(0);
      end if;

      -- Connect sRssiTsp -> mUdp(0)
      if (v.mUdpMasters(0).tValid = '0') and (sRssiTspMaster.tValid = '1') then
         -- Accept the data
         v.sRssiTspSlave.tReady := '1';
         -- Move the data
         v.mUdpMasters(0)       := sRssiTspMaster;
      end if;

      -- Check if RSSI Link is up
      if (rssiLinkUp = '1') then

         -- Connect sRssiApp -> mDma(0)
         if (v.mDmaMasters(0).tValid = '0') and (sRssiAppMaster.tValid = '1') then
            -- Accept the data
            v.sRssiAppSlave.tReady := '1';
            -- Move the data
            v.mDmaMasters(0)       := sRssiAppMaster;
         end if;

         -- Connect sDma(0) -> mRssiApp
         if (v.mRssiAppMaster.tValid = '0') and (sDmaMasters(0).tValid = '1') then
            -- Accept the data
            v.sDmaSlaves(0).tReady := '1';
            -- Move the data
            v.mRssiAppMaster       := sDmaMasters(0);
         end if;

      else

         -- Prevent DMA/RSSI back pressure
         v.sRssiAppSlave.tReady := '1';
         v.sDmaSlaves(0).tReady := '1';

      end if;

      -- Combinatorial outputs before the reset
      sUdpSlaves    <= v.sUdpSlaves;
      sRssiTspSlave <= v.sRssiTspSlave;
      sRssiAppSlave <= v.sRssiAppSlave;
      sDmaSlaves    <= v.sDmaSlaves;

      -- Registered Outputs
      mUdpMasters    <= r.mUdpMasters;
      mRssiTspMaster <= r.mRssiTspMaster;
      mRssiAppMaster <= r.mRssiAppMaster;
      mDmaMasters    <= r.mDmaMasters;

      -- Reset
      if (axisRst = '1') then
         v := REG_INIT_C;
      end if;

      -- Register the variable for next clock cycle
      rin <= v;

   end process comb;

   seq : process (axisClk) is
   begin
      if (rising_edge(axisClk)) then
         r <= rin after TPD_G;
      end if;
   end process seq;

   U_AxiStreamMux : entity work.AxiStreamMux
      generic map (
         TPD_G                => TPD_G,
         PIPE_STAGES_G        => 1,
         NUM_SLAVES_G         => CLIENT_SIZE_C,
         MODE_G               => "ROUTED",
         TDEST_ROUTES_G       => MUX_ROUTES_C,
         ILEAVE_EN_G          => true,
         ILEAVE_ON_NOTVALID_G => true,
         ILEAVE_REARB_G       => 128)
      port map (
         -- Clock and reset
         axisClk      => axisClk,
         axisRst      => axisRst,
         -- Slaves
         sAxisMasters => mDmaMasters,
         sAxisSlaves  => mDmaSlaves,
         -- Master
         mAxisMaster  => mDmaMaster,
         mAxisSlave   => mDmaSlave);

end rtl;
