-------------------------------------------------------------------------------
-- File       : EthTrafficSwitch.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-03-16
-- Last update: 2018-03-23
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
      axisClk         : in  sl;
      axisRst         : in  sl;
      -- Controls Interface
      rssiLinkUp      : in  sl;
      bypRssi         : in  sl;
      -- UDP Interface
      sUdpMaster      : in  AxiStreamMasterType;
      sUdpSlave       : out AxiStreamSlaveType;
      mUdpMaster      : out AxiStreamMasterType;
      mUdpSlave       : in  AxiStreamSlaveType;
      -- RSSI Transport Interface
      sRssiTspMaster  : in  AxiStreamMasterType;
      sRssiTspSlave   : out AxiStreamSlaveType;
      mRssiTspMaster  : out AxiStreamMasterType;
      mRssiTspSlave   : in  AxiStreamSlaveType;
      -- RSSI Application Interface
      sRssiAppMasters : in  AxiStreamMasterArray(RSSI_STREAMS_C-1 downto 0);
      sRssiAppSlaves  : out AxiStreamSlaveArray(RSSI_STREAMS_C-1 downto 0);
      mRssiAppMasters : out AxiStreamMasterArray(RSSI_STREAMS_C-1 downto 0);
      mRssiAppSlaves  : in  AxiStreamSlaveArray(RSSI_STREAMS_C-1 downto 0);
      -- DMA Interface
      sDmaMasters     : in  AxiStreamMasterArray(RSSI_STREAMS_C-1 downto 0);
      sDmaSlaves      : out AxiStreamSlaveArray(RSSI_STREAMS_C-1 downto 0);
      mDmaMasters     : out AxiStreamMasterArray(RSSI_STREAMS_C-1 downto 0);
      mDmaSlaves      : in  AxiStreamSlaveArray(RSSI_STREAMS_C-1 downto 0));
end EthTrafficSwitch;

architecture rtl of EthTrafficSwitch is

   type RegType is record
      sUdpSlave       : AxiStreamSlaveType;
      mUdpMaster      : AxiStreamMasterType;
      sRssiTspSlave   : AxiStreamSlaveType;
      mRssiTspMaster  : AxiStreamMasterType;
      sRssiAppSlaves  : AxiStreamSlaveArray(RSSI_STREAMS_C-1 downto 0);
      mRssiAppMasters : AxiStreamMasterArray(RSSI_STREAMS_C-1 downto 0);
      sDmaSlaves      : AxiStreamSlaveArray(RSSI_STREAMS_C-1 downto 0);
      mDmaMasters     : AxiStreamMasterArray(RSSI_STREAMS_C-1 downto 0);

   end record RegType;

   constant REG_INIT_C : RegType := (
      sUdpSlave       => AXI_STREAM_SLAVE_INIT_C,
      mUdpMaster      => AXI_STREAM_MASTER_INIT_C,
      sRssiTspSlave   => AXI_STREAM_SLAVE_INIT_C,
      mRssiTspMaster  => AXI_STREAM_MASTER_INIT_C,
      sRssiAppSlaves  => (others => AXI_STREAM_SLAVE_INIT_C),
      mRssiAppMasters => (others => AXI_STREAM_MASTER_INIT_C),
      sDmaSlaves      => (others => AXI_STREAM_SLAVE_INIT_C),
      mDmaMasters     => (others => AXI_STREAM_MASTER_INIT_C));

   signal r   : RegType := REG_INIT_C;
   signal rin : RegType;

begin

   comb : process (axisRst, bypRssi, mDmaSlaves, mRssiAppSlaves, mRssiTspSlave,
                   mUdpSlave, r, rssiLinkUp, sDmaMasters, sRssiAppMasters,
                   sRssiTspMaster, sUdpMaster) is
      variable v : RegType;
      variable i : natural;
   begin
      -- Latch the current value
      v := r;

      -- Reset strobing signals
      v.sUdpSlave.tReady     := '0';
      v.sRssiTspSlave.tReady := '0';
      for i in RSSI_STREAMS_C-1 downto 0 loop
         v.sRssiAppSlaves(i).tReady := '0';
         v.sDmaSlaves(i).tReady     := '0';
      end loop;

      -- Update tValid variable
      if mUdpSlave.tReady = '1' then
         v.mUdpMaster.tValid := '0';
      end if;

      -- Update tValid variable
      if mRssiTspSlave.tReady = '1' then
         v.mRssiTspMaster.tValid := '0';
      end if;

      for i in RSSI_STREAMS_C-1 downto 0 loop

         -- Update tValid variable
         if mRssiAppSlaves(i).tReady = '1' then
            v.mRssiAppMasters(i).tValid := '0';
         end if;

         -- Update tValid variable
         if mDmaSlaves(i).tReady = '1' then
            v.mDmaMasters(i).tValid := '0';
         end if;

      end loop;

      -- Check if we are bypassing the RSSI engine and sending RAW UPD to DMA for FSBL communication
      if (bypRssi = '1') then

         -- Connect sUdp -> mDma
         if (v.mDmaMasters(0).tValid = '0') and (sUdpMaster.tValid = '1') then
            -- Accept the data
            v.sUdpSlave.tReady     := '1';
            -- Move the data
            v.mDmaMasters(0)       := sUdpMaster;
            -- Force the TDEST = 0x0
            v.mDmaMasters(0).tDest := x"00";
         end if;

         -- Connect sDma -> mUdp
         if (v.mUdpMaster.tValid = '0') and (sDmaMasters(0).tValid = '1') then
            -- Accept the data
            v.sDmaSlaves(0).tReady := '1';
            -- Move the data
            v.mUdpMaster           := sDmaMasters(0);
         end if;

         -- Prevent DMA back pressure unused TDESTs
         for i in RSSI_STREAMS_C-1 downto 1 loop
            v.sDmaSlaves(i).tReady := '1';
         end loop;

         -- Terminate the RSSI TSP interfaces
         v.sRssiTspSlave.tReady := '1';
         v.mRssiTspMaster       := SSI_MASTER_FORCE_EOFE_C;

         -- Terminate the RSSI TSP interfaces
         for i in RSSI_STREAMS_C-1 downto 0 loop
            v.sRssiAppSlaves(i).tReady := '1';
            v.mRssiAppMasters(i)       := SSI_MASTER_FORCE_EOFE_C;
         end loop;

      else

         -- Connect sUdp -> mRssiTsp
         if (v.mRssiTspMaster.tValid = '0') and (sUdpMaster.tValid = '1') then
            -- Accept the data
            v.sUdpSlave.tReady := '1';
            -- Move the data
            v.mRssiTspMaster   := sUdpMaster;
         end if;

         -- Connect sRssiTsp -> mUdp
         if (v.mUdpMaster.tValid = '0') and (sRssiTspMaster.tValid = '1') then
            -- Accept the data
            v.sRssiTspSlave.tReady := '1';
            -- Move the data
            v.mUdpMaster           := sRssiTspMaster;
         end if;

         for i in RSSI_STREAMS_C-1 downto 0 loop

            -- Check if RSSI Link is up
            if (rssiLinkUp = '1') then

               -- Connect sRssiApp -> mDma
               if (v.mDmaMasters(i).tValid = '0') and (sRssiAppMasters(i).tValid = '1') then
                  -- Accept the data
                  v.sRssiAppSlaves(i).tReady := '1';
                  -- Move the data
                  v.mDmaMasters(i)           := sRssiAppMasters(i);
               end if;

               -- Connect sDma -> mRssiApp
               if (v.mRssiAppMasters(i).tValid = '0') and (sDmaMasters(i).tValid = '1') then
                  -- Accept the data
                  v.sDmaSlaves(i).tReady := '1';
                  -- Move the data
                  v.mRssiAppMasters(i)   := sDmaMasters(i);
               end if;

            else

               -- Prevent DMA/RSSI back pressure
               v.sRssiAppSlaves(i).tReady := '1';
               v.sDmaSlaves(i).tReady     := '1';

            end if;

         end loop;

      end if;

      -- Force write the application-to-RSSI TDESET
      v.mRssiAppMasters(0).tdest := x"00";  -- SRPv3
      for i in RSSI_STREAMS_C-1 downto 1 loop
         -- Terminate defined path
         v.mRssiAppMasters(i).tValid := '0';
         v.mRssiAppMasters(i).tdest  := x"FF";
      end loop;

      -- Combinatorial outputs before the reset
      sUdpSlave      <= v.sUdpSlave;
      sRssiTspSlave  <= v.sRssiTspSlave;
      sRssiAppSlaves <= v.sRssiAppSlaves;
      sDmaSlaves     <= v.sDmaSlaves;

      -- Reset
      if (axisRst = '1') then
         v := REG_INIT_C;
      end if;

      -- Register the variable for next clock cycle
      rin <= v;

      -- Registered Outputs
      mUdpMaster      <= r.mUdpMaster;
      mRssiTspMaster  <= r.mRssiTspMaster;
      mRssiAppMasters <= r.mRssiAppMasters;
      mDmaMasters     <= r.mDmaMasters;

   end process comb;

   seq : process (axisClk) is
   begin
      if (rising_edge(axisClk)) then
         r <= rin after TPD_G;
      end if;
   end process seq;

end rtl;
