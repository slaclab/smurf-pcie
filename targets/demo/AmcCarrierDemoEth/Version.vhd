------------------------------------------------------------------------------
-- This file is part of 'LCLS2 LLRF Development'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 LLRF Development', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package Version is

   constant FPGA_VERSION_C : std_logic_vector(31 downto 0) := x"00000005";  -- MAKE_VERSION

   constant BUILD_STAMP_C : string := "AmcCarrierDemoEth: Vivado v2016.2 (x86_64) Built Fri Sep 16 09:22:13 PDT 2016 by ulegat";

end Version;

-------------------------------------------------------------------------------
-- Revision History:
--
-- 09/09/2016 (0x00000001): Initial Build without Sysgen
-- 09/12/2016 (0x00000002): With Sysgen
-- 09/14/2016 (0x00000003): New yaml
-- 09/15/2016 (0x00000004): Updated diffswing xci - Works
-- 09/15/2016 (0x00000005): Updated diffswing dcp - Does not work
-------------------------------------------------------------------------------

