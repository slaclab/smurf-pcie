-------------------------------------------------------------------------------
-- File       : EthConfig.vhd
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

use work.StdRtlPkg.all;
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.SsiPkg.all;
use work.AppPkg.all;

entity EthConfig is
   generic (
      TPD_G : time := 1 ns);
   port (
      localIp         : out slv(31 downto 0);  -- big endianness
      localMac        : out slv(47 downto 0);  -- big endianness
      keepAliveMaster : out AxiStreamMasterType;
      keepAliveSlave  : in  AxiStreamSlaveType;
      -- AXI-Lite Register Interface (axilClk domain)
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType);
end EthConfig;

architecture rtl of EthConfig is

   type RegType is record
      enKeepAlive     : sl;
      keepAliveMaster : AxiStreamMasterType;
      keepAliveConfig : slv(31 downto 0);
      cnt             : slv(31 downto 0);
      localIp         : slv(31 downto 0);
      localMac        : slv(47 downto 0);
      axilReadSlave   : AxiLiteReadSlaveType;
      axilWriteSlave  : AxiLiteWriteSlaveType;
   end record;

   constant REG_INIT_C : RegType := (
      enKeepAlive     => '0',
      keepAliveMaster => AXI_STREAM_MASTER_INIT_C,
      keepAliveConfig => (others => '1'),
      cnt             => (others => '0'),
      localIp         => (others => '0'),  -- big endianness
      localMac        => (others => '0'),  -- big endianness
      axilReadSlave   => AXI_LITE_READ_SLAVE_INIT_C,
      axilWriteSlave  => AXI_LITE_WRITE_SLAVE_INIT_C);

   signal r   : RegType := REG_INIT_C;
   signal rin : RegType;

begin

   --------------------- 
   -- AXI Lite Interface
   --------------------- 
   comb : process (axilReadMaster, axilRst, axilWriteMaster, keepAliveSlave, r) is
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
      axiSlaveRegister(regCon, x"00", 0, v.localMac);
      axiSlaveRegister(regCon, x"08", 0, v.localIp);
      axiSlaveRegister(regCon, x"0C", 0, v.enKeepAlive);
      axiSlaveRegister(regCon, x"10", 0, v.keepAliveConfig);

      axiSlaveRegisterR(regCon, x"80", 0, toSlv(NUM_RSSI_C, 32));
      axiSlaveRegisterR(regCon, x"84", 0, toSlv(CLIENT_SIZE_C, 32));
      axiSlaveRegisterR(regCon, x"88", 0, toSlv(CLIENT_PORTS_C(0), 32));
      axiSlaveRegisterR(regCon, x"8C", 0, toSlv(CLIENT_PORTS_C(1), 32));

      -- Closeout the transaction
      axiSlaveDefault(regCon, v.axilWriteSlave, v.axilReadSlave, AXI_RESP_DECERR_C);

      -- Generate keep alive message for direct UDP interface
      if (r.keepAliveConfig /= v.keepAliveConfig) or (r.enKeepAlive = '0') then
         v.cnt := r.keepAliveConfig;
      elsif r.cnt = r.keepAliveConfig then
         v.cnt                              := (others => '0');
         v.keepAliveMaster.tValid           := '1';
      else
         v.cnt := r.cnt + 1;
      end if;
      
      -- Only send 1 byte for keep alive
      v.keepAliveMaster.tUser(SSI_SOF_C) := '1'; -- SOF
      v.keepAliveMaster.tLast            := '1'; -- EOF
      v.keepAliveMaster.tKeep            := toSlv(1, AXI_STREAM_MAX_TKEEP_WIDTH_C); -- 1 byte

      -- Synchronous Reset
      if (axilRst = '1') then
         v := REG_INIT_C;
      end if;

      -- Register the variable for next clock cycle
      rin <= v;

      -- Outputs
      keepAliveMaster <= r.keepAliveMaster;
      axilWriteSlave  <= r.axilWriteSlave;
      axilReadSlave   <= r.axilReadSlave;
      localIp         <= r.localIp;
      localMac        <= r.localMac;

   end process comb;

   seq : process (axilClk) is
   begin
      if (rising_edge(axilClk)) then
         r <= rin after TPD_G;
      end if;
   end process seq;

end rtl;
