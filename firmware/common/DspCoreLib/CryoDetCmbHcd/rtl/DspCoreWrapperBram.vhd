-------------------------------------------------------------------------------
-- File       : DspCoreWrapperBram.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2017-11-13
-- Last update: 2017-11-13
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

entity DspCoreWrapperBram is
   generic (
      TPD_G            : time             := 1 ns;
      AXI_BASE_ADDR_G  : slv(31 downto 0) := (others => '0'));
   port (
      -- BRAM Interface
      jesdClk         : in  sl;
      jesdRst         : in  sl;
      ramWe           : in  slv(15 downto 0);
      ramAddr         : in  Slv7Array(15 downto 0);
      ramDin          : in  Slv32Array(15 downto 0);
      ramDout         : out Slv32Array(15 downto 0);
      -- AXI-Lite Interface
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType);
end DspCoreWrapperBram;

architecture mapping of DspCoreWrapperBram is

   constant NUM_AXI_MASTERS_C : natural := 16;

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, AXI_BASE_ADDR_G, 16, 9);

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

-- Not sure why this works but pervious sysgen write only
--   (vec 15:8) were not working
-- TODO recombine to single GEN_VEC
--   set AXI_WR_EN_G, SYS_WR_EN_G from higher level  
   GEN_VEC_SYS_RO :
   for i in (NUM_AXI_MASTERS_C/2-1) downto 0 generate
      --------------------------------          
      -- AXI-Lite Shared Memory Module
      --------------------------------          
      U_Mem : entity work.AxiDualPortRam
         generic map (
            TPD_G            => TPD_G,
            BRAM_EN_G        => true,
            REG_EN_G         => true,  -- true = 2 cycle read access latency
            AXI_WR_EN_G      => true,
            SYS_WR_EN_G      => false,
            COMMON_CLK_G     => false,
            ADDR_WIDTH_G     => 7,
            DATA_WIDTH_G     => 32)
         port map (
            -- Clock and Reset
            clk            => jesdClk,
            rst            => jesdRst,
            we             => ramWe(i),
            addr           => ramAddr(i),
            din            => ramDin(i),
            dout           => ramDout(i),
            -- AXI-Lite Interface
            axiClk         => axilClk,
            axiRst         => axilRst,
            axiReadMaster  => axilReadMasters(i),
            axiReadSlave   => axilReadSlaves(i),
            axiWriteMaster => axilWriteMasters(i),
            axiWriteSlave  => axilWriteSlaves(i));
   end generate GEN_VEC_SYS_RO;

   GEN_VEC_AXI_RO :
   for i in (NUM_AXI_MASTERS_C-1) downto (NUM_AXI_MASTERS_C/2) generate
      --------------------------------          
      -- AXI-Lite Shared Memory Module
      --------------------------------          
      U_Mem : entity work.AxiDualPortRam
         generic map (
            TPD_G            => TPD_G,
            BRAM_EN_G        => true,
            REG_EN_G         => true,  -- true = 2 cycle read access latency
            AXI_WR_EN_G      => false,
            SYS_WR_EN_G      => true,
            COMMON_CLK_G     => false,
            ADDR_WIDTH_G     => 7,
            DATA_WIDTH_G     => 32)
         port map (
            -- Clock and Reset
            clk            => jesdClk,
            rst            => jesdRst,
            --we             => ramWe(i),
            we             => '1',
            addr           => ramAddr(i),
            din            => ramDin(i),
            dout           => ramDout(i),
            -- AXI-Lite Interface
            axiClk         => axilClk,
            axiRst         => axilRst,
            axiReadMaster  => axilReadMasters(i),
            axiReadSlave   => axilReadSlaves(i),
            axiWriteMaster => axilWriteMasters(i),
            axiWriteSlave  => axilWriteSlaves(i));
   end generate GEN_VEC_AXI_RO;

end mapping;
