-------------------------------------------------------------------------------
-- File       : UdpDebug.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: UdpDebug File
-------------------------------------------------------------------------------
-- This file is part of 'axi-pcie-core'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'axi-pcie-core', including this file, 
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

use work.AppPkg.all;

entity UdpDebug is
   generic (
      TPD_G : time := 1 ns);
   port (
      userClk         : in  sl;
      -- Clock and Reset
      axiClk          : in  sl;
      axiRst          : in  sl;
      -- UDP Outbound Config Interface
      udpObMuxSel     : out sl;
      udpObDest       : out slv(7 downto 0);
      udpToPhyRoute   : out Slv8Array(NUM_RSSI_C-1 downto 0);  -- UserClk Domain
      -- AXI-Lite Interface 
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType);
end UdpDebug;

architecture mapping of UdpDebug is

   type RegType is record
      udpObMuxSel    : sl;
      udpObDest      : slv(7 downto 0);
      udpToPhyRoute  : Slv8Array(5 downto 0);
      axilReadSlave  : AxiLiteReadSlaveType;
      axilWriteSlave : AxiLiteWriteSlaveType;
   end record;

   constant REG_INIT_C : RegType := (
      udpObMuxSel    => '1',  -- '1'= secondary DMA (default), '0' = primary DMA,
      udpObDest      => x"C1",
      udpToPhyRoute  => (0 => x"00", 1 => x"01", 2 => x"02", 3 => x"03", 4 => x"04", 5 => x"05"),
      axilReadSlave  => AXI_LITE_READ_SLAVE_INIT_C,
      axilWriteSlave => AXI_LITE_WRITE_SLAVE_INIT_C);

   signal r   : RegType := REG_INIT_C;
   signal rin : RegType;

begin

   --------------------- 
   -- AXI Lite Interface
   --------------------- 
   comb : process (axiRst, axilReadMaster, axilWriteMaster, r) is
      variable v      : RegType;
      variable regCon : AxiLiteEndPointType;
   begin
      -- Latch the current value
      v := r;

      -- Determine the transaction type
      axiSlaveWaitTxn(regCon, axilWriteMaster, axilReadMaster, v.axilWriteSlave, v.axilReadSlave);

      -- Map the read registers
      axiSlaveRegister(regCon, x"00", 0, v.udpObMuxSel);
      axiSlaveRegister(regCon, x"04", 0, v.udpObDest);

      axiSlaveRegisterR(regCon, x"10", 0, toSlv(NUM_RSSI_C, 32));
      axiSlaveRegisterR(regCon, x"14", 0, toSlv(CLIENT_SIZE_C, 32));
      axiSlaveRegisterR(regCon, x"18", 0, toSlv(CLIENT_PORTS_C(0), 32));
      axiSlaveRegisterR(regCon, x"1C", 0, toSlv(CLIENT_PORTS_C(1), 32));

      axiSlaveRegister(regCon, x"80", 0, v.udpToPhyRoute(0));
      axiSlaveRegister(regCon, x"84", 0, v.udpToPhyRoute(1));
      axiSlaveRegister(regCon, x"88", 0, v.udpToPhyRoute(2));
      axiSlaveRegister(regCon, x"8C", 0, v.udpToPhyRoute(3));

      axiSlaveRegister(regCon, x"90", 0, v.udpToPhyRoute(4));
      axiSlaveRegister(regCon, x"94", 0, v.udpToPhyRoute(5));

      for i in 5 downto 0 loop
         v.udpToPhyRoute(i)(7 downto 3) := (others => '0');
      end loop;

      -- Closeout the transaction
      axiSlaveDefault(regCon, v.axilWriteSlave, v.axilReadSlave, AXI_RESP_DECERR_C);

      -- Synchronous Reset
      if (axiRst = '1') then
         v := REG_INIT_C;
      end if;

      -- Register the variable for next clock cycle
      rin <= v;

      -- Outputs
      axilWriteSlave <= r.axilWriteSlave;
      axilReadSlave  <= r.axilReadSlave;
      udpObMuxSel    <= r.udpObMuxSel;
      udpObDest      <= r.udpObDest;

   end process comb;

   seq : process (axiClk) is
   begin
      if (rising_edge(axiClk)) then
         r <= rin after TPD_G;
      end if;
   end process seq;

   GEN_VEC : for i in NUM_RSSI_C-1 downto 0 generate

      U_Sync : entity surf.SynchronizerVector
         generic map (
            TPD_G   => TPD_G,
            WIDTH_G => 8)
         port map (
            clk     => userClk,
            dataIn  => r.udpToPhyRoute(i),
            dataOut => udpToPhyRoute(i));

   end generate GEN_VEC;

end mapping;
