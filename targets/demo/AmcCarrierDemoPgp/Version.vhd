------------------------------------------------------------------------------
-- This file is part of 'LCLS2 LLRF Development'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 LLRF Development', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

package Version is

constant FPGA_VERSION_C : std_logic_vector(31 downto 0) := x"00000008"; -- MAKE_VERSION

constant BUILD_STAMP_C : string := "AmcRfDemoBoard: Vivado v2015.3 (x86_64) Built Tue Mar  1 13:52:48 PST 2016 by ulegat";

end Version;

-------------------------------------------------------------------------------
-- Revision History:
--
-- 07/10/2015 (0x00000001): No header Debug
-- 07/10/2015 (0x00000002): Header Debug
-- 07/10/2015 (0x00000003): Header and pure data
-- 07/10/2015 (0x00000004): 16Gb transfer works with DDR FIFO reset workaround.
-- 07/10/2015 (0x00000005): v4 + sysgen running on 185M.
-- 07/10/2015 (0x00000006): Cryo.
-- 07/10/2015 (0x00000007): Cryo and SysGen readout
-------------------------------------------------------------------------------

