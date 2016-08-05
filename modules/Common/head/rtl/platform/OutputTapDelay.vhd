-------------------------------------------------------------------------------
-- Title      : ODLAY Module (Ultrascale)
-------------------------------------------------------------------------------
-- File       : OutputTapDelay.vhd
-- Author     : Uros Legat  <ulegat@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2016-03-11
-- Last update: 2016-03-11
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: The ODELAYE3 Ultrascale
--              - Non cascaded
--              - Variable load delay type (VAR_LOAD)
--              - When load_i = '1' the tapSet_i is applied
--              - tapGet_o shows the delay setting status
--              - Taps,load and refclk can b asynchronous
--              - refClk input frequency range in MHz (200.0-2400.0)
-------------------------------------------------------------------------------
-- This file is part of 'LCLS2 LLRF Development'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 LLRF Development', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.StdRtlPkg.all;

library unisim;
use unisim.vcomponents.all;

entity OutputTapDelay is
   generic (
      TPD_G              : time := 1 ns;
      -- refClk input frequency range in MHz (200.0-2400.0)
      REFCLK_FREQUENCY_G : real := 200.0
   );
   port (
      -- Delay refclk can be asynchronous to input tap settings
      -- Clock input frequency range in MHz (200.0-2400.0)
      refClk_i   : in sl; 
      refRst_i   : in sl;

      -- When load_i = '1' the tapSet_i is applied
      clk_i      : in sl; 
      rst_i      : in sl;
      load_i     : in sl;
      tapSet_i   : in slv(8 downto 0);
      tapGet_o   : out slv(8 downto 0); -- Tap status
      --
      data_i     : in sl;
      data_o     : out sl
   );
end OutputTapDelay;

architecture rtl of OutputTapDelay is

   signal s_tapGet : slv(8 downto 0);
   signal s_tapSet : slv(8 downto 0);
   signal s_load   : sl;

------  
begin
   -- Synchronisation to refclk_i
   U_Synchronizer0: entity work.Synchronizer
   generic map (
      TPD_G          => TPD_G)
   port map (
      clk     => refClk_i,
      rst     => refRst_i,
      dataIn  => load_i,
      dataOut => s_load);

   
   U_Synchronizer1: entity work.SynchronizerFifo
   generic map (
      TPD_G        => TPD_G,
      DATA_WIDTH_G => 9
      )
   port map (
      wr_clk => clk_i,
      din    => tapSet_i,
      rd_clk => refClk_i,
      dout   => s_tapSet
   );
   
   -- Synchronisation to clk_i
   U_Synchronizer2: entity work.SynchronizerFifo
   generic map (
      TPD_G        => TPD_G,
      DATA_WIDTH_G => 9
      )
   port map (
      wr_clk => refClk_i,
      din    => s_tapGet,
      rd_clk => clk_i,
      dout   => tapGet_o
   );
  
   -- Odelay module
      U_ODELAYE3 : ODELAYE3
         generic map (
            CASCADE          => "NONE",
            DELAY_FORMAT     => "COUNT",
            DELAY_TYPE       => "VAR_LOAD",
            DELAY_VALUE      => 0,
            IS_CLK_INVERTED  => '0',
            IS_RST_INVERTED  => '0',
            REFCLK_FREQUENCY => REFCLK_FREQUENCY_G,
            UPDATE_MODE      => "ASYNC")
         port map (
            CE          => '0',         -- CE increments or decrements tap delay (Not used in VAR_LOAD type)
            CLK         => refClk_i,
            RST         => refRst_i,
            -- No cascade
            CASC_OUT    => open,        -- Disabled (Not cascaded)
            CASC_IN     => '1',         -- Disabled (Not cascaded)
            CASC_RETURN => '1',         -- Disabled (Not cascaded)

            -- Data INOUT
            ODATAIN     => data_i,
            DATAOUT     => data_o,
            --
            CNTVALUEOUT => s_tapGet,   -- Tap delay indicator
            CNTVALUEIN  => s_tapSet,   -- Tap delay setting
            --
            EN_VTC      => '0',         -- Disable voltage temperature compensation! (Not used in VAR_LOAD type)
            INC         => '1',         -- Increment or decrement flag - not used (Not used in VAR_LOAD type)
            LOAD        => s_load);
            
end rtl;