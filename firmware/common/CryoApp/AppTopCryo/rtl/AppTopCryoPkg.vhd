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

   type AppTopJesdRouteCryoType  is array (6 downto 0) of natural;
   type AppTopJesdRouteCryoArray  is array (1 downto 0) of AppTopJesdRouteCryoType;

   
   constant JESD_ROUTES_CRYO_INIT_C : AppTopJesdRouteCryoType := (
      0 => 0,
      1 => 1,
      2 => 2,
      3 => 3,
      4 => 4,
      5 => 5,
      6 => 6,
      7 => 7,
      8 => 8,
      9 => 9);

   constant JESD_CH0_CH1_CRYO_SWAP_C : AppTopJesdRouteCryoType := (
      0 => 1,  -- Swap CH0 and CH1 to match the front panel labels
      1 => 0,  -- Swap CH0 and CH1 to match the front panel labels
      2 => 2,
      3 => 3,
      4 => 4,
      5 => 5,
      6 => 7,
      7 => 6,
      8 => 9,
      9 => 8);   

   type DacSigCtrlCryoType is record
      start : slv(9 downto 0);
   end record;
   type DacSigCtrlCryoArray is array (natural range <>) of DacSigCtrlCryoType;
   constant DAC_SIG_CTRL_INIT_CRYO_C : DacSigCtrlCryoType := (
      start => (others => '0'));

   type DacSigStatusCryoType is record
      running : slv(9 downto 0);
   end record;
   type DacSigStatusCryoArray is array (natural range <>) of DacSigStatusCryoType;
   constant DAC_SIG_STATUS_INIT_CRYO_C : DacSigStatusCryoType := (
      running => (others => '0'));

end package AppTopCryoPkg;

