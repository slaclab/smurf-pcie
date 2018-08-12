-------------------------------------------------------------------------------
-- File       : AppPkg.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-02-06
-- Last update: 2018-02-06
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

use work.StdRtlPkg.all;
use work.AxiStreamPkg.all;

package AppPkg is

   constant NUM_LINKS_C     : positive := 1;
   constant RSSI_PER_LINK_C : positive := 6;
   constant RSSI_STREAMS_C  : positive := 3;
   constant AXIS_PER_LINK_C : positive := RSSI_PER_LINK_C*RSSI_STREAMS_C;
   constant NUM_AXIS_C      : positive := NUM_LINKS_C*AXIS_PER_LINK_C;
   constant NUM_RSSI_C      : positive := NUM_LINKS_C*RSSI_PER_LINK_C;

   -- Ethernet/AXI-Lite Clock Frequency
   constant APP_CLK_FREQ_C : real := 156.25E+6;  -- units of Hz

end package AppPkg;
