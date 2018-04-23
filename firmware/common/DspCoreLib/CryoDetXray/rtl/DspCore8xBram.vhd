-------------------------------------------------------------------------------
-- File       : DspCore8xBram.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2017-10-24
-- Last update: 2018-03-30
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

entity DspCore8xBram is
   generic (
      TPD_G           : time             := 1 ns;
      AXI_BASE_ADDR_G : slv(31 downto 0) := (others => '0'));
   port (
      -- BRAM Interface
      jesdClk         : in  sl;
      jesdRst         : in  sl;
      ramWe           : in  slv(7 downto 0);
      ramAddr         : in  slv((8*8)-1 downto 0);
      ramDin          : in  slv((32*8)-1 downto 0);
      ramDout         : out slv((32*8)-1 downto 0);
      -- AXI-Lite Interface
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType);
end DspCore8xBram;

architecture mapping of DspCore8xBram is

   constant NUM_AXI_MASTERS_C : natural := 8;

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, AXI_BASE_ADDR_G, 20, 12);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

begin

   ---------------------
   -- AXI-Lite Crossbar
   ---------------------
   U_XBAR : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         NUM_SLAVE_SLOTS_G  => 1,
         NUM_MASTER_SLOTS_G => NUM_AXI_MASTERS_C,
         MASTERS_CONFIG_G   => AXI_CONFIG_C)
      port map (
         axiClk              => axilClk,
         axiClkRst           => axilRst,
         sAxiWriteMasters(0) => axilWriteMaster,
         sAxiWriteSlaves(0)  => axilWriteSlave,
         sAxiReadMasters(0)  => axilReadMaster,
         sAxiReadSlaves(0)   => axilReadSlave,
         mAxiWriteMasters    => axilWriteMasters,
         mAxiWriteSlaves     => axilWriteSlaves,
         mAxiReadMasters     => axilReadMasters,
         mAxiReadSlaves      => axilReadSlaves);

   GEN_VEC :
   for i in (NUM_AXI_MASTERS_C-1) downto 0 generate
      --------------------------------          
      -- AXI-Lite Shared Memory Module
      --------------------------------          
      U_Mem : entity work.AxiDualPortRam
         generic map (
            TPD_G        => TPD_G,
            BRAM_EN_G    => true,
            REG_EN_G     => true,  -- true = 2 cycle read access latency, but higher performance
            AXI_WR_EN_G  => true,
            SYS_WR_EN_G  => true,
            COMMON_CLK_G => false,
            ADDR_WIDTH_G => 8,
            DATA_WIDTH_G => 32)
         port map (
            -- Clock and Reset
            clk            => jesdClk,
            rst            => jesdRst,
            we             => ramWe(i),
            addr           => ramAddr((8*(i+1))-1 downto (8*i)),
            din            => ramDin((32*(i+1))-1 downto (32*i)),
            dout           => ramDout((32*(i+1))-1 downto (32*i)),
            -- AXI-Lite Interface
            axiClk         => axilClk,
            axiRst         => axilRst,
            axiReadMaster  => axilReadMasters(i),
            axiReadSlave   => axilReadSlaves(i),
            axiWriteMaster => axilWriteMasters(i),
            axiWriteSlave  => axilWriteSlaves(i));
   end generate GEN_VEC;

end mapping;
