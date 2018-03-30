-------------------------------------------------------------------------------
-- File       : DspCoreWrapperBram.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2017-11-13
-- Last update: 2017-12-06
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------
-- This file is part of 'LCLS2 AMC Carrier Firmware'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 AMC Carrier Firmware', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.StdRtlPkg.all;
use work.AxiLitePkg.all;
use work.Jesd204bPkg.all;

entity DspCoreWrapperAdcMux is
   generic (
      TPD_G            : time            := 1 ns);
   port (
      -- ADC Interface
      jesdClk         : in  slv(1 downto 0);
      jesdRst         : in  slv(1 downto 0);
      adcValidIn      : in  Slv10Array(1 downto 0);
      adcValueIn      : in  sampleDataVectorArray(1 downto 0, 9 downto 0);
      adcValidOut     : out Slv10Array(1 downto 0);
      adcValueOut     : out sampleDataVectorArray(1 downto 0, 9 downto 0);
      -- AXI-Lite Interface
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType);
end DspCoreWrapperAdcMux;

architecture rtl of DspCoreWrapperAdcMux is

   constant REMAP_INIT_C : Slv4Array(9 downto 0) := (
      9 => x"9",
      8 => x"8",
      7 => x"7",
      6 => x"6",
      5 => x"5",
      4 => x"4",
      3 => x"3",
      2 => x"2",
      1 => x"1",
      0 => x"0");

   type RegType is record
      remap0         : Slv4Array(9 downto 0);
      remap1         : Slv4Array(9 downto 0);
      axilReadSlave  : AxiLiteReadSlaveType;
      axilWriteSlave : AxiLiteWriteSlaveType;
   end record;

   constant REG_INIT_C : RegType := (
      remap0         => REMAP_INIT_C,
      remap1         => REMAP_INIT_C,
      axilReadSlave  => AXI_LITE_READ_SLAVE_INIT_C,
      axilWriteSlave => AXI_LITE_WRITE_SLAVE_INIT_C);

   signal r   : RegType := REG_INIT_C;
   signal rin : RegType;

   signal remap0 : Slv4Array(9 downto 0) := REMAP_INIT_C;
   signal remap1 : Slv4Array(9 downto 0) := REMAP_INIT_C;

begin

   GEN_VEC :
   for i in 9 downto 0 generate

      process(jesdClk)
      begin
         if rising_edge(jesdClk(0)) then
            adcValidOut(0)(i) <= adcValidIn(0)(conv_integer(remap0(i))) after TPD_G;
            adcValueOut(0, i) <= adcValueIn(0, conv_integer(remap0(i))) after TPD_G;
         end if;
      end process;

      process(jesdClk)
      begin
         if rising_edge(jesdClk(1)) then
            adcValidOut(1)(i) <= adcValidIn(1)(conv_integer(remap1(i))) after TPD_G;
            adcValueOut(1, i) <= adcValueIn(1, conv_integer(remap1(i))) after TPD_G;
         end if;
      end process;

      U_Sync0 : entity work.SynchronizerVector
         generic map (
            TPD_G   => TPD_G,
            WIDTH_G => 4)
         port map (
            clk     => jesdClk(0),
            dataIn  => r.remap0(i),
            dataOut => remap0(i));

      U_Sync1 : entity work.SynchronizerVector
         generic map (
            TPD_G   => TPD_G,
            WIDTH_G => 4)
         port map (
            clk     => jesdClk(1),
            dataIn  => r.remap1(i),
            dataOut => remap1(i));

   end generate GEN_VEC;

   comb : process (axilReadMaster, axilWriteMaster, r) is
      variable v      : RegType;
      variable regCon : AxiLiteEndPointType;
   begin
      -- Latch the current value
      v := r;

      -- Determine the transaction type
      axiSlaveWaitTxn(regCon, axilWriteMaster, axilReadMaster, v.axilWriteSlave, v.axilReadSlave);

      for i in 9 downto 0 loop

         -- Map the registers
         axiSlaveRegister(regCon, toSlv(4*i+0, 12), 0, v.remap0(i));
         axiSlaveRegister(regCon, toSlv(4*i+256, 12), 0, v.remap1(i));

         -- Prevent out of range
         if (v.remap0(i) > 9) then
            -- Keep previous value
            v.remap0(i) := r.remap0(i);
         end if;

         -- Prevent out of range
         if (v.remap1(i) > 9) then
            -- Keep previous value
            v.remap1(i) := r.remap1(i);
         end if;

      end loop;

      -- Closeout the transaction
      axiSlaveDefault(regCon, v.axilWriteSlave, v.axilReadSlave, AXI_RESP_SLVERR_C);

      -- Register the variable for next clock cycle
      rin <= v;

      -- Outputs
      axilWriteSlave <= r.axilWriteSlave;
      axilReadSlave  <= r.axilReadSlave;

   end process comb;

   seq : process (axilClk) is
   begin
      if (rising_edge(axilClk)) then
         r <= rin after TPD_G;
      end if;
   end process seq;

end rtl;
