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

   constant FPGA_VERSION_C : std_logic_vector(31 downto 0) := x"00000002";  -- MAKE_VERSION

   constant BUILD_STAMP_C : string := "AmcCarrierDemoRtmEth: Vivado v2016.2 (x86_64) Built Tue Nov  1 16:14:43 PDT 2016 by ulegat";

end Version;

-------------------------------------------------------------------------------
-- Revision History:
--
-- 11/01/2016 (0x00000001): Initial Build
-- 11/01/2016 (0x00000002): 2.1 TAGs
--
-------------------------------------------------------------------------------

