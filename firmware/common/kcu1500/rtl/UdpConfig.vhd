-------------------------------------------------------------------------------
-- File       : UdpConfig.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- This file is part of 'SLAC PGP Gen3 Card'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'SLAC PGP Gen3 Card', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiLitePkg.all;
use surf.AxiStreamPkg.all;
use surf.SsiPkg.all;

use work.AppPkg.all;

entity UdpConfig is
   generic (
      TPD_G : time := 1 ns);
   port (
      keepAliveMaster : out AxiStreamMasterType;
      keepAliveSlave  : in  AxiStreamSlaveType;
      -- AXI-Lite Register Interface (axilClk domain)
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType);
end UdpConfig;

architecture rtl of UdpConfig is

   type RegType is record
      enKeepAlive     : sl;
      keepAliveMaster : AxiStreamMasterType;
      keepAliveConfig : slv(31 downto 0);
      cnt             : slv(31 downto 0);
      axilReadSlave   : AxiLiteReadSlaveType;
      axilWriteSlave  : AxiLiteWriteSlaveType;
   end record;

   constant REG_INIT_C : RegType := (
      enKeepAlive     => '0',
      keepAliveMaster => AXI_STREAM_MASTER_INIT_C,
      keepAliveConfig => (others => '1'),
      cnt             => (others => '0'),
      axilReadSlave   => AXI_LITE_READ_SLAVE_INIT_C,
      axilWriteSlave  => AXI_LITE_WRITE_SLAVE_INIT_C);

   signal r   : RegType := REG_INIT_C;
   signal rin : RegType;

   signal axilReset : sl;

begin

   U_axilRst : entity surf.RstPipeline
      generic map (
         TPD_G => TPD_G)
      port map (
         clk    => axilClk,
         rstIn  => axilRst,
         rstOut => axilReset);

   --------------------- 
   -- AXI Lite Interface
   --------------------- 
   comb : process (axilReadMaster, axilReset, axilWriteMaster, keepAliveSlave,
                   r) is
      variable v      : RegType;
      variable regCon : AxiLiteEndPointType;
   begin
      -- Latch the current value
      v := r;

      -- Flow control
      if keepAliveSlave.tReady = '1' then
         v.keepAliveMaster.tValid := '0';
      end if;

      -- Determine the transaction type
      axiSlaveWaitTxn(regCon, axilWriteMaster, axilReadMaster, v.axilWriteSlave, v.axilReadSlave);

      -- Map the read registers
      axiSlaveRegister(regCon, x"0C", 0, v.enKeepAlive);
      axiSlaveRegister(regCon, x"10", 0, v.keepAliveConfig);

      -- Closeout the transaction
      axiSlaveDefault(regCon, v.axilWriteSlave, v.axilReadSlave, AXI_RESP_DECERR_C);

      -- Generate keep alive message for direct UDP interface
      if (r.keepAliveConfig /= v.keepAliveConfig) or (r.enKeepAlive = '0') then
         v.cnt := r.keepAliveConfig;
      elsif r.cnt = r.keepAliveConfig then
         v.cnt                    := (others => '0');
         v.keepAliveMaster.tValid := '1';
      else
         v.cnt := r.cnt + 1;
      end if;

      -- Only send 1 byte for keep alive
      v.keepAliveMaster.tUser(SSI_SOF_C) := '1';  -- SOF
      v.keepAliveMaster.tLast            := '1';  -- EOF
      v.keepAliveMaster.tKeep            := toSlv(1, AXI_STREAM_MAX_TKEEP_WIDTH_C);  -- 1 byte

      -- Synchronous Reset
      if (axilReset = '1') then
         v := REG_INIT_C;
      end if;

      -- Register the variable for next clock cycle
      rin <= v;

      -- Outputs
      keepAliveMaster <= r.keepAliveMaster;
      axilWriteSlave  <= r.axilWriteSlave;
      axilReadSlave   <= r.axilReadSlave;

   end process comb;

   seq : process (axilClk) is
   begin
      if (rising_edge(axilClk)) then
         r <= rin after TPD_G;
      end if;
   end process seq;

end rtl;
