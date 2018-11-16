-------------------------------------------------------------------------------
-- File       : AppDataProcessorPktMon.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: AXI Stream Monitor Module
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

use work.StdRtlPkg.all;
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.SsiPkg.all;
use work.AppPkg.all;

entity AppDataProcessorPktMon is
   generic (
      TPD_G : time := 1 ns);
   port (
      -- AXIS Stream Interface
      ibMaster        : in  AxiStreamMasterType;
      ibSlave         : in  AxiStreamSlaveType;
      -- AXI-Lite Interface
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType);
end AppDataProcessorPktMon;

architecture rtl of AppDataProcessorPktMon is

   type RegType is record
      ibMaster       : AxiStreamMasterType;
      ibSlave        : AxiStreamSlaveType;
      rstCnt         : sl;
      sofErrCnt      : slv(31 downto 0);
      skipErrCnt     : slv(31 downto 0);
      eofeErrCnt     : slv(31 downto 0);
      cnt            : natural range 0 to 4095;
      seqCnt         : slv(31 downto 0);
      header         : Slv64Array(15 downto 0);
      axilWriteSlave : AxiLiteWriteSlaveType;
      axilReadSlave  : AxiLiteReadSlaveType;
   end record;

   constant REG_INIT_C : RegType := (
      ibMaster       => AXI_STREAM_MASTER_INIT_C,
      ibSlave        => AXI_STREAM_SLAVE_INIT_C,
      rstCnt         => '1',
      sofErrCnt      => (others => '0'),
      skipErrCnt     => (others => '0'),
      eofeErrCnt     => (others => '0'),
      cnt            => 0,
      seqCnt         => (others => '0'),
      header         => (others => (others => '0')),
      axilWriteSlave => AXI_LITE_WRITE_SLAVE_INIT_C,
      axilReadSlave  => AXI_LITE_READ_SLAVE_INIT_C);

   signal r   : RegType := REG_INIT_C;
   signal rin : RegType;

begin

   comb : process (axilReadMaster, axilRst, axilWriteMaster, ibMaster, ibSlave,
                   r) is
      variable v      : RegType;
      variable axilEp : AxiLiteEndPointType;
   begin
      -- Latch the current value
      v := r;

      -- Reset strobes
      v.rstCnt := '0';

      -- Determine the transaction type
      axiSlaveWaitTxn(axilEp, axilWriteMaster, axilReadMaster, v.axilWriteSlave, v.axilReadSlave);

      -- Register mapping
      for i in 0 to 15 loop
         axiSlaveRegisterR(axilEp, toSlv((8*i), 12), 0, r.header(i));
      end loop;
      axiSlaveRegister (axilEp, x"080", 0, v.rstCnt);
      axiSlaveRegisterR(axilEp, x"084", 0, r.sofErrCnt);
      axiSlaveRegisterR(axilEp, x"088", 0, r.skipErrCnt);
      axiSlaveRegisterR(axilEp, x"08C", 0, r.eofeErrCnt);

      -- Closeout the transaction
      axiSlaveDefault(axilEp, v.axilWriteSlave, v.axilReadSlave, AXI_RESP_DECERR_C);

      -- Make a local copy (help with timing)
      v.ibMaster := ibMaster;
      v.ibSlave  := ibSlave;

      -- Check for moving data
      if (r.ibMaster.tValid = '1') and (r.ibSlave.tReady = '1') then

         -- Increment the counter
         if (r.cnt /= 4095) then
            v.cnt := r.cnt + 1;
         end if;

         -- Check if header
         if (r.cnt < 16) then
            -- Make a copy of the header for debugging
            v.header(r.cnt) := r.ibMaster.tData(63 downto 0);
         end if;

         -- Check of SOF misaligned
         if (r.cnt = 0) and (ssiGetUserSof(APP_AXIS_CONFIG_C, r.ibMaster) = '0') then
            -- Increment status counter
            v.sofErrCnt := r.sofErrCnt + 1;
            -- Reset the counter to realign the phase alignment
            v.cnt       := 0;
         end if;

         -- Check for sequence counter
         if (r.cnt = 10) then
            -- Make a delayed copy
            v.seqCnt := r.ibMaster.tData(63 downto 32);
            -- Check for sequence counter skipping
            if (v.seqCnt /= (r.seqCnt + 1)) then
               -- Increment status counter
               v.skipErrCnt := r.skipErrCnt + 1;
            end if;
         end if;

         -- Check for EOF
         if (r.ibMaster.tLast = '1') then
            -- Check for EOFE
            if (ssiGetUserEofe(APP_AXIS_CONFIG_C, r.ibMaster) = '1') then
               -- Increment status counter
               v.eofeErrCnt := r.eofeErrCnt + 1;
            end if;
         end if;

      end if;

      -- Outputs
      axilWriteSlave <= r.axilWriteSlave;
      axilReadSlave  <= r.axilReadSlave;

      -- Check if reseting status counters
      if (r.rstCnt = '1') then
         v.sofErrCnt  := (others => '0');
         v.skipErrCnt := (others => '0');
         v.eofeErrCnt := (others => '0');
      end if;

      -- Reset
      if (axilRst = '1') then
         v := REG_INIT_C;
      end if;

      -- Register the variable for next clock cycle
      rin <= v;

   end process comb;

   seq : process (axilClk) is
   begin
      if (rising_edge(axilClk)) then
         r <= rin after TPD_G;
      end if;
   end process seq;

end rtl;
