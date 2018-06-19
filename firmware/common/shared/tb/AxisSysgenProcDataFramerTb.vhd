-------------------------------------------------------------------------------
-- File       : AxisSysgenProcDataFramerTb.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-04-25
-- Last update: 2018-04-25
-------------------------------------------------------------------------------
-- Description: Simulation Testbed for AxisSysgenProcDataFramer
------------------------------------------------------------------------------
-- This file is part of 'LCLS2 Common Carrier Core'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 Common Carrier Core', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.StdRtlPkg.all;
use work.AxiStreamPkg.all;

entity AxisSysgenProcDataFramerTb is
end entity;

architecture testbed of AxisSysgenProcDataFramerTb is

   constant CLK_PERIOD_C : time := 10 ns;
   constant TPD_G        : time := (CLK_PERIOD_C/4);

   type RegType is record
      valid     : sl;
      cnt       : slv(12 downto 0);
      data      : slv(31 downto 0);
      timestamp : slv(63 downto 0);
   end record;

   constant REG_INIT_C : RegType := (
      valid     => '0',
      cnt       => (others => '0'),
      data      => (others => '0'),
      timestamp => (others => '0'));

   signal r   : RegType := REG_INIT_C;
   signal rin : RegType;

   signal clk : sl := '0';
   signal rst : sl := '0';

   signal jesdClk   : slv(7 downto 0);
   signal jesdRst   : slv(7 downto 0);
   signal dataValid : slv(7 downto 0);
   signal timestamp : slv(63 downto 0);
   signal dataIndex : Slv9Array(7 downto 0);
   signal dataI     : Slv32Array(7 downto 0);
   signal dataQ     : Slv32Array(7 downto 0);

begin

   U_ClkRst : entity work.ClkRst
      generic map (
         CLK_PERIOD_G      => CLK_PERIOD_C,
         RST_START_DELAY_G => 1 ns,  -- Wait this long into simulation before asserting reset
         RST_HOLD_TIME_G   => 1000 ns)  -- Hold reset for this long)
      port map (
         clkP => clk,
         rst  => rst);

   ----------------------
   -- Module to be tested
   ----------------------
   U_Core : entity work.AxisSysgenProcDataFramer
      generic map (
         TPD_G => TPD_G)
      port map (
         -- Input timing interface (timingClk domain)
         timingClk       => clk,
         timingRst       => rst,
         timingTimestamp => timestamp,
         -- Input Data Interface (jesdClk domain)
         jesdClk         => jesdClk,
         jesdRst         => jesdRst,
         dataValid       => dataValid,
         dataIndex       => dataIndex,
         dataI           => dataI,
         dataQ           => dataQ,
         -- Output AXIS Interface (axisClk domain)
         axisClk         => clk,
         axisRst         => rst,
         axisMaster      => open,
         axisSlave       => AXI_STREAM_SLAVE_FORCE_C);

   comb : process (clk, r, rst) is
      variable v : RegType;
      variable i : natural;
   begin
      -- Latch the current value
      v := r;

      -- Reset strobes
      v.valid := '0';

      -- Increment the counter
      v.cnt := r.cnt + 1;

      -- Check for roll over
      if (r.cnt < 512) then
         -- Set the flag
         v.valid := '1';
         -- Increment the counter
         v.data  := r.data + 1;
         -- Check for SOF
         if (v.cnt = 0) then
            -- Reset the counter
            v.data      := (others => '0');
            -- Increment the counter
            v.timestamp := r.timestamp + 1;
         end if;
      end if;

      -- Synchronous Reset
      if (rst = '1') then
         v := REG_INIT_C;
      end if;

      -- Register the variable for next clock cycle
      rin <= v;

      -- Outputs
      jesdClk   <= (others => clk);
      jesdRst   <= (others => rst);
      dataValid <= (others => r.valid);
      dataIndex <= (others => r.cnt(9 downto 0));
      dataI     <= (others => r.data);
      dataQ     <= (others => r.data);
      timestamp <= r.timestamp;

   end process comb;

   seq : process (clk) is
   begin
      if (rising_edge(clk)) then
         r <= rin after TPD_G;
      end if;
   end process seq;

end testbed;
