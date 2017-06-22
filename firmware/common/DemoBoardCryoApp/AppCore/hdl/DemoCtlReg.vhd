-------------------------------------------------------------------------------
-- Title      : Axi-lite interface for register access  
-------------------------------------------------------------------------------
-- File       : DemoCtlReg.vhd
-- Author     : Uros Legat  <ulegat@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2016-01-15
-- Last update: 2016-01-19
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:  
--        
------------------------------------------------------------------------------
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
use work.AxiLitePkg.all;

entity DemoCtlReg is
generic (
   -- General Configurations
   TPD_G                : time            := 1 ns;
   AXI_ERROR_RESP_G     : slv(1 downto 0) := AXI_RESP_SLVERR_C);
port (

   -- Axi-Lite Register Interface (axilClk domain)
   axilClk        : in sl;
   axilRst        : in sl;
   axilReadMaster  : in  AxiLiteReadMasterType  := AXI_LITE_READ_MASTER_INIT_C;
   axilReadSlave   : out AxiLiteReadSlaveType;
   axilWriteMaster : in  AxiLiteWriteMasterType := AXI_LITE_WRITE_MASTER_INIT_C;
   axilWriteSlave  : out AxiLiteWriteSlaveType;

   -- Dev Clk
   devClk   : in sl;
   devRst   : in sl;

   -- Software registers
   muxSel_o : out sl
);   
end DemoCtlReg;

architecture rtl of DemoCtlReg is

   type RegType is record
      -- Control (RW)
      muxSel : sl;

      -- AXI lite
      axilReadSlave  : AxiLiteReadSlaveType;
      axilWriteSlave : AxiLiteWriteSlaveType;
      --
   end record;
  
   constant REG_INIT_C : RegType := (
      -- Control (RW)
      muxSel => '0',
      
      -- AXI lite      
      axilReadSlave  => AXI_LITE_READ_SLAVE_INIT_C,
      axilWriteSlave => AXI_LITE_WRITE_SLAVE_INIT_C);

   signal r   : RegType := REG_INIT_C;
   signal rin : RegType;

   -- Integer address

begin
  
   ------------------------------------
   -- Register Space
   ------------------------------------
   comb : process (axilReadMaster, axilRst, axilWriteMaster, r) is
      variable v      : RegType;
      variable regCon : AxiLiteEndpointType;
   begin
      -- Latch the current value
      v := r;

      ------------------------      
      -- AXI-Lite Transactions
      ------------------------      

      -- Determine the transaction type
      axiSlaveWaitTxn(regCon, axilWriteMaster, axilReadMaster, v.axilWriteSlave, v.axilReadSlave);

      -- General
      -------------------------------------------------------------------------
      -- Control
      axiSlaveRegister(regCon, x"00000", 0, v.muxSel);
      
      -- Closeout the transaction
      axiSlaveDefault(regCon,v.axilWriteSlave, v.axilReadSlave, AXI_ERROR_RESP_G);

      --------
      -- Reset
      --------
      if (axilRst = '1') then
         v := REG_INIT_C;
      end if;

      -- Register the variable for next clock cycle
      rin <= v;

      -- Outputs 
      axilReadSlave   <= r.axilReadSlave;
      axilWriteSlave  <= r.axilWriteSlave;
      
   end process comb;

   seq : process (axilClk) is
   begin
      if (rising_edge(axilClk)) then
         r <= rin after TPD_G;
      end if;
   end process seq;

  -- Input Sync assignment
  ---------------------------------------------------------------------------

  -- Output Sync assignment
  ----------------------------------------------------
  
   U_Sync_Out0 : entity work.SynchronizerVector
      generic map (
         TPD_G => TPD_G,
         WIDTH_G  => 1
         )
      port map (
         clk        => devClk,
         rst        => devRst,
         dataIn(0)  => r.muxSel,   
         dataOut(0) => muxSel_o);
---------------------------------------------------------------------
end rtl;
