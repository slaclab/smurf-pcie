------------------------------------------------------------------------------
-- This file is part of 'LCLS2 LLRF Firmware'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 LLRF Firmware', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.StdRtlPkg.all;
use work.AxiLitePkg.all;

--------------------------------------------------------------------------------
entity  tbAxiSerAttnMaster is

end entity ;
--------------------------------------------------------------------------------


architecture Bhv of tbAxiSerAttnMaster is
  -----------------------------
  -- Port Signals 
  -----------------------------
   constant CLK_PERIOD_C : time    := 10 ns;
   constant TPD_C        : time    := 1 ns;

   -- Clocking
   signal   clk_i                 : sl := '0';
   signal   rst_i                 : sl := '0';

   signal   axiReadMaster     : AxiLiteReadMasterType   := AXI_LITE_READ_MASTER_INIT_C;
   signal   axiReadSlave      : AxiLiteReadSlaveType;--    := AXI_LITE_READ_SLAVE_INIT_C ;
   signal   axiWriteMaster    : AxiLiteWriteMasterType  := AXI_LITE_WRITE_MASTER_INIT_C;
   signal   axiWriteSlave     : AxiLiteWriteSlaveType;--   := AXI_LITE_WRITE_SLAVE_INIT_C;
   signal   coreSclk          : sl;--:='0';
   signal   coreSDin          : sl:='0';
   signal   coreSDout         : sl;--:='0';
   signal   coreCsb           : sl;--:='0';
   signal   coreLEn           : sl;--:='0';

  
begin  -- architecture Bhv

   -- Generate clocks and resets
   DDR_ClkRst_Inst : entity work.ClkRst
   generic map (
     CLK_PERIOD_G      => CLK_PERIOD_C,
     RST_START_DELAY_G => 1 ns,     -- Wait this long into simulation before asserting reset
     RST_HOLD_TIME_G   => 1000 ns)  -- Hold reset for this long)
   port map (
     clkP => clk_i,
     clkN => open,
     rst  => rst_i,
     rstL => open);

   -----------------------------
   -- component instantiation 
   -----------------------------
   AxiSerAttnMaster_INST: entity work.AxiSerAttnMaster
   generic map (
      TPD_G             => 1 ns)
   port map (
      axiClk         => clk_i,
      axiRst         => rst_i,
      axiReadMaster  => axiReadMaster,
      axiReadSlave   => axiReadSlave,
      axiWriteMaster => axiWriteMaster,
      axiWriteSlave  => axiWriteSlave,
      coreSclk       => coreSclk,
      coreSDin       => coreSDin,
      coreSDout      => coreSDout,
      coreCsb        => coreCsb,
      coreLEn        => coreLEn);

   StimuliProcess : process
   begin
      wait until rst_i = '0';

      wait for CLK_PERIOD_C*200;
      axiWriteMaster.awvalid <= '1';
      axiWriteMaster.wvalid  <= '1';      
      wait for CLK_PERIOD_C*10;
      axiWriteMaster.awvalid <= '0';
      axiWriteMaster.wvalid  <= '0';
     
     
      wait for CLK_PERIOD_C*500;
      axiWriteMaster.awvalid <= '1';
      axiWriteMaster.wvalid  <= '1';      
      wait for CLK_PERIOD_C*10;
      axiWriteMaster.awvalid <= '0';
      axiWriteMaster.wvalid  <= '0';
      
      wait;
   end process StimuliProcess;
  
end architecture Bhv;