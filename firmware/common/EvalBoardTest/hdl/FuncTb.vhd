-------------------------------------------------------------------------------
-- Title      : 
-------------------------------------------------------------------------------
-- File       : MpsCnToutTestTb.vhd
-- Author     : Uros Legat  <ulegat@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2015-09-15
-- Last update: 2015-09-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Simulation Testbed for testing LCLS-II's Cn Tout engine
-------------------------------------------------------------------------------
-- This file is part of 'LCLS2 MPS Firmware'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 MPS Firmware', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.StdRtlPkg.all;
use work.Jesd204bPkg.all;

entity FuncTb is end FuncTb;

architecture testbed of FuncTb is

   constant CLK_PERIOD_C : time := 4 ns;
   constant CLK_FREQ_C   : real := 250.0E+6;
   constant TPD_C        : time := CLK_PERIOD_C/4;
      
   signal clk       : sl                  := '0';
   signal rst       : sl                  := '0';
   signal data_i    : slv((GT_WORD_SIZE_C*8)-1 downto 0):=x"00000000";
   signal data_o    : slv((GT_WORD_SIZE_C*8)-1 downto 0):=x"00000000";
   signal sel       : sl                  := '0'; 
   
begin

   -- U_ClkRst : entity work.ClkRst
      -- generic map (
         -- CLK_PERIOD_G      => CLK_PERIOD_C,
         -- RST_START_DELAY_G => 0 ns,     -- Wait this long into simulation before asserting reset
         -- RST_HOLD_TIME_G   => 1000 ns)  -- Hold reset for this long)
      -- port map (
         -- clkP => clk,
         -- clkN => open,
         -- rst  => rst,
         -- rstL => open);
    
   
   AxiLiteProcess : process
   
   begin

      data_i <=  x"00000001"; 
      data_o <=  invData(data_i, 2, 4);
      wait for CLK_PERIOD_C*5;   
      data_i <=  x"00020003";    
      data_o <=  invData(data_i, 2, 4);
      wait for CLK_PERIOD_C*5;   
      data_i <=  x"00040005";    
      data_o <=  invData(data_i, 2, 4);
      wait for CLK_PERIOD_C*5;   
      data_i <=  x"00060007";    
      data_o <=  invData(data_i, 2, 4);
      --                         
      wait for CLK_PERIOD_C*5;   
      data_i <=  x"80008001";    
      data_o <=  invData(data_i, 2, 4);
      wait for CLK_PERIOD_C*5;   
      data_i <=  x"80028003";    
      data_o <=  invData(data_i, 2, 4);
      wait for CLK_PERIOD_C*5;   
      data_i <=  x"80048005";    
      data_o <=  invData(data_i, 2, 4);
      wait for CLK_PERIOD_C*5;   
      data_i <=  x"80068007";    
      data_o <=  invData(data_i, 2, 4);
      wait for CLK_PERIOD_C*5;   
      --                         
      wait for CLK_PERIOD_C*5;   
      data_i <=  x"7fff7ffe";    
      data_o <=  invData(data_i, 2, 4);
      wait for CLK_PERIOD_C*5;   
      data_i <=  x"7ffd7ffc";    
      data_o <=  invData(data_i, 2, 4);
      wait for CLK_PERIOD_C*5;   
      data_i <=  x"7ffb7ffa";    
      data_o <=  invData(data_i, 2, 4);
      wait for CLK_PERIOD_C*5;   
      data_i <=  x"7ff97ff8";    
      data_o <=  invData(data_i, 2, 4);
      wait for CLK_PERIOD_C*5;      
   end process;
   
end testbed;
