-------------------------------------------------------------------------------
-- File       : AppTopPkg.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2016-11-11
-- Last update: 2017-03-10
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- This file is part of 'LCLS2 Common Carrier Core'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 Common Carrier Core', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.StdRtlPkg.all;

package AppTopCryoPkg is

   type DacSigCtrlCryoType is record
      start : slv(7 downto 0);
   end record;
   type DacSigCtrlCryoArray is array (natural range <>) of DacSigCtrlCryoType;
   constant DAC_SIG_CTRL_INIT_CRYO_C : DacSigCtrlCryoType := (
      start => (others => '0'));

   type DacSigStatusCryoType is record
      running : slv(7 downto 0);
   end record;
   type DacSigStatusCryoArray is array (natural range <>) of DacSigStatusCryoType;
   constant DAC_SIG_STATUS_INI_CRYO_C : DacSigStatusCryoType := (
      running => (others => '0'));

end package AppTopCryoPkg;

