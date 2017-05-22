-------------------------------------------------------------------------------
-- File       : DacSigGenLaneCryo.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2017-22-05
-- Last update: 2017-22-05
-------------------------------------------------------------------------------
-- Description:  Single lane arbitrary periodic signal generator
--               The module contains a AXI-Lite accessible block RAM where the 
--               signal is defined.
--               It has two modes:
--               Triggered and Periodic:
--               Triggered:
--                 When triggered the waveform is output once up to the buffer size
--                 Rising edge is detected on the trigger
--               Periodic: 
--                 When the module is enabled it periodically reads the block RAM contents 
--                 and outputs the contents.
--                 
--               Signal has to be disabled while the period_i or RAM contents is being changed.
--               When disabled is outputs signal ZERO data according to sign format (sign_i)
--                      Sign: '0' - Signed 2's complement, '1' - Offset binary
--
--               Note: The module has been modified for Cryo for 32-bit jesd clock only operation.
--                     Should work at 312.5 MHz.
--               Note: The waveform holds the last value.
-------------------------------------------------------------------------------
-- This file is part of 'LCLS2 Common Carrier Core'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 Common Carrier Core', including this file, 
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

entity DacSigGenLaneCryo is
   generic (
      -- General Configurations
      TPD_G        : time := 1 ns;
      ADDR_WIDTH_G : integer range 1 to 24 := 9
    );
   port (
      -- JESD devClk
      jesdClk         : in  sl;
      jesdRst         : in  sl;
      
      -- AXI lite
      axilClk         : in sl;
      axilRst         : in sl;
      axilReadMaster  : in    AxiLiteReadMasterType;
      axilReadSlave   : out   AxiLiteReadSlaveType;
      axilWriteMaster : in    AxiLiteWriteMasterType;
      axilWriteSlave  : out   AxiLiteWriteSlaveType;

      -- Control generation (Cannot be altered when running)
      enable_i        : in  sl;
      mode_i          : in  sl;
      period_i        : in  slv(ADDR_WIDTH_G-1 downto 0);
      start_i         : in  sl;
      sign_i          : in  sl;
      --
      running_o       : out sl;
      valid_o         : out sl;
      dacSigValues_o  : out slv(31 downto 0)
   );
end DacSigGenLaneCryo;

architecture rtl of DacSigGenLaneCryo is
   
   type StateType is (
      IDLE_S,
      RUNNING_S
   );
   
   -- Register
   type RegType is record
      cnt       : slv(ADDR_WIDTH_G-1 downto 0);
      lastData  : slv(31 downto 0);      
      running   : sl;
      runningD1 : sl;
      state     : StateType;
   end record RegType;

   constant REG_INIT_C : RegType := (
      cnt      => (others => '0'),
      lastData => (others => '0'),      
      running  => '0',
      runningD1=> '0',      
      state    => IDLE_S
   );

   signal r   : RegType := REG_INIT_C;
   signal rin : RegType;

   -- Signals
   signal s_rdEn : sl;
   signal s_ramData    : slv(31 downto 0);
   signal s_startRe    : sl;
  
begin
  
   -- Synchronize and detect rising edge on trigger
   U_Sync : entity work.SynchronizerEdge
   generic map (
      TPD_G        => TPD_G
   )
   port map (
      clk    => jesdClk,   
      dataIn => start_i,  
      risingEdge => s_startRe  -- Rising edge
   );
   
   -- Always read when enabled
   s_rdEn <= enable_i;
   
   AxiDualPortRam_INST: entity work.AxiDualPortRam
   generic map (
      TPD_G        => TPD_G,
      BRAM_EN_G    => true,
      REG_EN_G     => true,
      MODE_G       => "write-first",
      ADDR_WIDTH_G => ADDR_WIDTH_G,
      DATA_WIDTH_G => 32,
      INIT_G       => x"FFFFFFFF")
   port map (
      -- Axi clk domain
      axiClk         => axilClk,
      axiRst         => axilRst,
      axiReadMaster  => axilReadMaster,
      axiReadSlave   => axilReadSlave,
      axiWriteMaster => axilWriteMaster,
      axiWriteSlave  => axilWriteSlave,
      
      
      -- Dev clk domain
      clk            => jesdClk,
      rst            => jesdRst,
      en             => s_rdEn,
      addr           => r.cnt,
      dout           => s_ramData);
      
   -- Address counter
   comb : process (r, jesdRst, period_i, enable_i, mode_i, s_startRe,s_ramData) is
      variable v : RegType;
   begin
      -- Latch the current value
      v := r; 
      -- Delay to align with ram data
      v.runningD1 := r.running;
      
      -- State Machine
      StateMachine : case (r.state) is
         ----------------------------------------------------------------------
         when IDLE_S =>
            v.running := '0';
            v.cnt     := (others => '0');
            -- Wait for a trigger
            if (  (enable_i = '1' and mode_i = '1') or
                  (enable_i = '1' and mode_i = '0' and s_startRe = '1')
            ) then
               -- Next state
               v.state := RUNNING_S;
            end if;         
         when RUNNING_S =>
            v.running := '1';
            --
            if (r.cnt = period_i) then 
               v.cnt := (others => '0');
               if (enable_i = '0') then  -- Disabled go back to idle
                  -- Next state
                  v.state := IDLE_S;
               elsif (mode_i = '0') then -- Triggered mode go back to idle
                  -- Save the last RAM data to hold it 
                  v.lastData := s_ramData;
                  -- Next state
                  v.state := IDLE_S;                  
               end if;
            else 
               v.cnt := r.cnt + 1;    
            end if;   
         
         ----------------------------------------------------------------------
         when others => null;

      ----------------------------------------------------------------------
      end case StateMachine;         
      
      if (jesdRst = '1') then
         v := REG_INIT_C;
      end if;

      -- Register the variable for next clock cycle
      rin <= v;
      
   end process comb;

   seq : process (jesdClk) is
   begin
      if (rising_edge(jesdClk)) then
         r <= rin after TPD_G;
      end if;
   end process seq; 
   
   -- Assign output data
   dacSigValues_o <=s_ramData when r.runningD1 = '1' else 
                  r.lastData;

   
end rtl;