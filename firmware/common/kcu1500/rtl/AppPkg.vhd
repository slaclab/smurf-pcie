-------------------------------------------------------------------------------
-- File       : AppPkg.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: Package file for Application
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

library surf;
use surf.StdRtlPkg.all;
use surf.AxiStreamPkg.all;

package AppPkg is

   constant NUM_RSSI_C    : positive := 6;  -- 6 RSSI clients (1 RSSI per link)
   constant CLIENT_SIZE_C : positive := 2;  -- 2 clients per link

   constant APP_AXIS_CONFIG_C : AxiStreamConfigType := (
      TSTRB_EN_C    => false,
      TDATA_BYTES_C => 8,               -- 64-bit interface
      TDEST_BITS_C  => 8,               -- 256 TDEST
      TID_BITS_C    => 0,
      TKEEP_MODE_C  => TKEEP_COMP_C,
      TUSER_BITS_C  => 4,
      TUSER_MODE_C  => TUSER_FIRST_LAST_C);

   constant APP_STREAM_CONFIG_C : AxiStreamConfigArray(0 downto 0) := (others => APP_AXIS_CONFIG_C);

   constant CLIENT_PORTS_C : PositiveArray(CLIENT_SIZE_C-1 downto 0) := (
      0 => 9000,
      1 => 9001);

end package AppPkg;
