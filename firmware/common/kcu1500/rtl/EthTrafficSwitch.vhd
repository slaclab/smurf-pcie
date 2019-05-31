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
      bypRssi        : in  sl;
      -- UDP Interface
      sUdpMaster     : in  AxiStreamMasterType;
      sUdpSlave      : out AxiStreamSlaveType;
      mUdpMaster     : out AxiStreamMasterType;
      mUdpSlave      : in  AxiStreamSlaveType;
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

   type RegType is record
      sUdpSlave      : AxiStreamSlaveType;
      mUdpMaster     : AxiStreamMasterType;
      sRssiTspSlave  : AxiStreamSlaveType;
      mRssiTspMaster : AxiStreamMasterType;
      sRssiAppSlave  : AxiStreamSlaveType;
      mRssiAppMaster : AxiStreamMasterType;
      sDmaSlave      : AxiStreamSlaveType;
      mDmaMaster     : AxiStreamMasterType;

   end record RegType;

   constant REG_INIT_C : RegType := (
      sUdpSlave      => AXI_STREAM_SLAVE_INIT_C,
      mUdpMaster     => AXI_STREAM_MASTER_INIT_C,
      sRssiTspSlave  => AXI_STREAM_SLAVE_INIT_C,
      mRssiTspMaster => AXI_STREAM_MASTER_INIT_C,
      sRssiAppSlave  => AXI_STREAM_SLAVE_INIT_C,
      mRssiAppMaster => AXI_STREAM_MASTER_INIT_C,
      sDmaSlave      => AXI_STREAM_SLAVE_INIT_C,
      mDmaMaster     => AXI_STREAM_MASTER_INIT_C);

   signal r   : RegType := REG_INIT_C;
   signal rin : RegType;

begin

   comb : process (axisRst, bypRssi, mDmaSlave, mRssiAppSlave, mRssiTspSlave,
                   mUdpSlave, r, rssiLinkUp, sDmaMaster, sRssiAppMaster,
                   sRssiTspMaster, sUdpMaster) is
      variable v : RegType;
      variable i : natural;
   begin
      -- Latch the current value
      v := r;

      -- Reset strobing signals
      v.sUdpSlave.tReady     := '0';
      v.sRssiTspSlave.tReady := '0';
      v.sRssiAppSlave.tReady := '0';
      v.sDmaSlave.tReady     := '0';

      -- Update tValid variable
      if mUdpSlave.tReady = '1' then
         v.mUdpMaster.tValid := '0';
      end if;

      -- Update tValid variable
      if mRssiTspSlave.tReady = '1' then
         v.mRssiTspMaster.tValid := '0';
      end if;

      -- Update tValid variable
      if mRssiAppSlave.tReady = '1' then
         v.mRssiAppMaster.tValid := '0';
      end if;

      -- Update tValid variable
      if mDmaSlave.tReady = '1' then
         v.mDmaMaster.tValid := '0';
      end if;

      -- Check if we are bypassing the RSSI engine and sending RAW UPD to DMA for FSBL communication
      if (bypRssi = '1') then

         -- Connect sUdp -> mDma
         if (v.mDmaMaster.tValid = '0') and (sUdpMaster.tValid = '1') then
            -- Accept the data
            v.sUdpSlave.tReady := '1';
            -- Move the data
            v.mDmaMaster       := sUdpMaster;
            -- Force the TDEST = 0x0
            v.mDmaMaster.tDest := x"00";
         end if;

         -- Connect sDma -> mUdp
         if (v.mUdpMaster.tValid = '0') and (sDmaMaster.tValid = '1') then
            -- Accept the data
            v.sDmaSlave.tReady := '1';
            -- Move the data
            v.mUdpMaster       := sDmaMaster;
         end if;

         -- Prevent DMA back pressure unused TDESTs
         v.sDmaSlave.tReady := '1';

         -- Terminate the RSSI TSP interfaces
         v.sRssiTspSlave  := AXI_STREAM_SLAVE_FORCE_C;
         v.mRssiTspMaster := AXI_STREAM_MASTER_INIT_C;

         -- Terminate the RSSI TSP interfaces
         v.sRssiAppSlave  := AXI_STREAM_SLAVE_FORCE_C;
         v.mRssiAppMaster := AXI_STREAM_MASTER_INIT_C;

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

         -- Check if RSSI Link is up
         if (rssiLinkUp = '1') then

            -- Connect sRssiApp -> mDma
            if (v.mDmaMaster.tValid = '0') and (sRssiAppMaster.tValid = '1') then
               -- Accept the data
               v.sRssiAppSlave.tReady := '1';
               -- Move the data
               v.mDmaMaster           := sRssiAppMaster;
            end if;

            -- Connect sDma -> mRssiApp
            if (v.mRssiAppMaster.tValid = '0') and (sDmaMaster.tValid = '1') then
               -- Accept the data
               v.sDmaSlave.tReady := '1';
               -- Move the data
               v.mRssiAppMaster   := sDmaMaster;
            end if;

         else

            -- Prevent DMA/RSSI back pressure
            v.sRssiAppSlave.tReady := '1';
            v.sDmaSlave.tReady     := '1';

         end if;

      end if;

      -- Combinatorial outputs before the reset
      sUdpSlave     <= v.sUdpSlave;
      sRssiTspSlave <= v.sRssiTspSlave;
      sRssiAppSlave <= v.sRssiAppSlave;
      sDmaSlave     <= v.sDmaSlave;

      -- Registered Outputs
      mUdpMaster     <= r.mUdpMaster;
      mRssiTspMaster <= r.mRssiTspMaster;
      mRssiAppMaster <= r.mRssiAppMaster;
      mDmaMaster     <= r.mDmaMaster;

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

end rtl;
