-------------------------------------------------------------------------------
-- File       : UdpLargeDataBufferTb.vhd
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: Simulation Testbed for testing the UdpLargeDataBuffer module
-------------------------------------------------------------------------------
-- This file is part of 'Camera link gateway'.
-- It is subject to the license terms in the LICENSE.txt file found in the
-- top-level directory of this distribution and at:
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
-- No part of 'Camera link gateway', including this file,
-- may be copied, modified, propagated, or distributed except according to
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiPkg.all;
use surf.AxiLitePkg.all;
use surf.AxiStreamPkg.all;
use surf.EthMacPkg.all;
use surf.SsiPkg.all;

library axi_pcie_core;
use axi_pcie_core.MigPkg.all;

entity UdpLargeDataBufferTb is end UdpLargeDataBufferTb;

architecture testbed of UdpLargeDataBufferTb is

   constant TPD_G : time := 1 ns;

   constant NUM_DDR_C   : positive                  := 1;
   constant DDR_WIDTH_C : PositiveArray(3 downto 0) := (0 => 72, 1 => 64, 2 => 72, 3 => 72);

   component Ddr4ModelWrapper
      generic (
         DDR_WIDTH_G : positive);
      port (
         c0_ddr4_dq       : inout slv;
         c0_ddr4_dqs_c    : inout slv;
         c0_ddr4_dqs_t    : inout slv;
         c0_ddr4_adr      : in    slv(16 downto 0);
         c0_ddr4_ba       : in    slv(1 downto 0);
         c0_ddr4_bg       : in    slv(0 to 0);
         c0_ddr4_reset_n  : in    sl;
         c0_ddr4_act_n    : in    sl;
         c0_ddr4_ck_c     : in    slv(0 to 0);
         c0_ddr4_ck_t     : in    slv(0 to 0);
         c0_ddr4_cke      : in    slv(0 to 0);
         c0_ddr4_cs_n     : in    slv(0 to 0);
         c0_ddr4_dm_dbi_n : inout slv;
         c0_ddr4_odt      : in    slv(0 to 0));
   end component;

   signal axiClk : sl := '0';
   signal axiRst : sl := '1';

   signal runEnable : sl := '0';

   signal ddrClockP : sl := '0';
   signal ddrClockN : sl := '1';
   signal ddrClkP   : slv(NUM_DDR_C-1 downto 0);
   signal ddrClkN   : slv(NUM_DDR_C-1 downto 0);
   signal ddrOut    : DdrOutArray(NUM_DDR_C-1 downto 0);
   signal ddrInOut  : DdrInOutArray(NUM_DDR_C-1 downto 0);

   signal ddrClk          : slv(NUM_DDR_C-1 downto 0) := (others => '0');
   signal ddrRst          : slv(NUM_DDR_C-1 downto 0) := (others => '1');
   signal ddrWriteMasters : AxiWriteMasterArray(NUM_DDR_C-1 downto 0);
   signal ddrWriteSlaves  : AxiWriteSlaveArray(NUM_DDR_C-1 downto 0);
   signal ddrReadMasters  : AxiReadMasterArray(NUM_DDR_C-1 downto 0);
   signal ddrReadSlaves   : AxiReadSlaveArray(NUM_DDR_C-1 downto 0);

   signal ddrIbMasters : AxiStreamMasterArray(2*NUM_DDR_C-1 downto 0);
   signal ddrIbSlaves  : AxiStreamSlaveArray(2*NUM_DDR_C-1 downto 0);
   signal ddrObMasters : AxiStreamMasterArray(2*NUM_DDR_C-1 downto 0);
   signal ddrObSlaves  : AxiStreamSlaveArray(2*NUM_DDR_C-1 downto 0);

   signal ibSize    : Slv32Array(2*NUM_DDR_C-1 downto 0);
   signal ibSizeMax : Slv32Array(2*NUM_DDR_C-1 downto 0);
   signal ibSizeMin : Slv32Array(2*NUM_DDR_C-1 downto 0);

   signal obSize    : Slv32Array(2*NUM_DDR_C-1 downto 0);
   signal obSizeMax : Slv32Array(2*NUM_DDR_C-1 downto 0);
   signal obSizeMin : Slv32Array(2*NUM_DDR_C-1 downto 0);

   signal updated  : slv(2*NUM_DDR_C-1 downto 0) := (others => '0');
   signal errorDet : slv(2*NUM_DDR_C-1 downto 0) := (others => '0');

   signal passed : sl := '0';
   signal failed : sl := '0';

begin

   U_UserClk : entity surf.ClkRst
      generic map (
         CLK_PERIOD_G      => 10 ns,    -- 156.25 MHz
         RST_START_DELAY_G => 0 ns,
         RST_HOLD_TIME_G   => 1000 ns)
      port map (
         clkP => axiClk,
         rst  => axiRst);

   U_ClkDdr : entity surf.ClkRst
      generic map (
         CLK_PERIOD_G      => 3.333 ns,  -- 300 MHz
         RST_START_DELAY_G => 0 ns,
         RST_HOLD_TIME_G   => 1000 ns)
      port map (
         clkP => ddrClockP,
         clkN => ddrClockN);

   ddrClkP <= (others => ddrClockP);
   ddrClkN <= (others => ddrClockN);

   GEN_DDR_INTF : for i in NUM_DDR_C-1 downto 0 generate
      -- U_Ddr4Model : Ddr4ModelWrapper
      U_Ddr4Model : entity axi_pcie_core.Ddr4ModelWrapper
         generic map (
            DDR_WIDTH_G => DDR_WIDTH_C(i))
         port map (
            c0_ddr4_dq       => ddrInOut(i).dq(DDR_WIDTH_C(i)-1 downto 0),
            c0_ddr4_dqs_t    => ddrInOut(i).dqsT((DDR_WIDTH_C(i)/8)-1 downto 0),
            c0_ddr4_dqs_c    => ddrInOut(i).dqsC((DDR_WIDTH_C(i)/8)-1 downto 0),
            c0_ddr4_adr      => ddrOut(i).addr,
            c0_ddr4_ba       => ddrOut(i).ba,
            c0_ddr4_bg       => ddrOut(i).bg,
            c0_ddr4_reset_n  => ddrOut(i).rstL,
            c0_ddr4_act_n    => ddrOut(i).actL,
            c0_ddr4_ck_c(0)  => ddrOut(i).ckC,
            c0_ddr4_ck_t(0)  => ddrOut(i).ckT,
            c0_ddr4_cke      => ddrOut(i).cke,
            c0_ddr4_cs_n     => ddrOut(i).csL,
            c0_ddr4_dm_dbi_n => ddrInOut(i).dm((DDR_WIDTH_C(i)/8)-1 downto 0),
            c0_ddr4_odt      => ddrOut(i).odt);
   end generate GEN_DDR_INTF;

   U_Mig0 : entity axi_pcie_core.Mig0
      generic map (
         TPD_G => TPD_G)
      port map (
         extRst         => '0',
         -- AXI MEM Interface
         axiClk         => ddrClk(0),
         axiRst         => ddrRst(0),
         axiReady       => runEnable,
         axiWriteMaster => ddrWriteMasters(0),
         axiWriteSlave  => ddrWriteSlaves(0),
         axiReadMaster  => ddrReadMasters(0),
         axiReadSlave   => ddrReadSlaves(0),
         -- DDR Ports
         ddrClkP        => ddrClkP(0),
         ddrClkN        => ddrClkN(0),
         ddrOut         => ddrOut(0),
         ddrInOut       => ddrInOut(0));

   U_Buffer : entity work.UdpLargeDataBuffer
      generic map (
         TPD_G => TPD_G)
      port map (
         -- UDP Large Data Buffer (axiClk domain)
         axiClk         => axiClk,
         axiRst         => axiRst,
         ddrIbMasters   => ddrIbMasters,
         ddrIbSlaves    => ddrIbSlaves,
         ddrObMasters   => ddrObMasters,
         ddrObSlaves    => ddrObSlaves,
         -- DDR Memory Interface (ddrClk domain)
         ddrClk         => ddrClk(0),
         ddrRst         => ddrRst(0),
         ddrWriteMaster => ddrWriteMasters(0),
         ddrWriteSlave  => ddrWriteSlaves(0),
         ddrReadMaster  => ddrReadMasters(0),
         ddrReadSlave   => ddrReadSlaves(0));

   GEN_VEC : for i in 2*NUM_DDR_C-1 downto 0 generate

      U_IbStream : entity surf.SsiPrbsTx
         generic map (
            -- General Configurations
            TPD_G                      => TPD_G,
            AXI_EN_G                   => '0',
            GEN_SYNC_FIFO_G            => true,
            PRBS_SEED_SIZE_G           => 128,
            -- AXI Stream Configurations
            MASTER_AXI_STREAM_CONFIG_G => EMAC_AXIS_CONFIG_C)
         port map (
            -- Master Port (mAxisClk)
            mAxisClk     => axiClk,
            mAxisRst     => axiRst,
            mAxisMaster  => ddrIbMasters(i),
            mAxisSlave   => ddrIbSlaves(i),
            -- Trigger Signal (locClk domain)
            locClk       => axiClk,
            locRst       => axiRst,
            trig         => runEnable,
            packetLength => toSlv((8320/16)-1, 32));

      U_IbMon : entity surf.AxiStreamMon
         generic map(
            TPD_G           => TPD_G,
            COMMON_CLK_G    => true,      -- true if axisClk = statusClk
            AXIS_CLK_FREQ_G => 100.0E+6,  -- units of Hz
            AXIS_CONFIG_G   => EMAC_AXIS_CONFIG_C)
         port map(
            -- AXIS Stream Interface
            axisClk      => axiClk,
            axisRst      => axiRst,
            axisMaster   => ddrIbMasters(i),
            axisSlave    => ddrIbSlaves(i),
            -- Status Clock and reset
            statusClk    => axiClk,
            statusRst    => axiRst,
            -- Status: Frame Size (units of Byte)
            frameSize    => ibSize(i),
            frameSizeMax => ibSizeMax(i),
            frameSizeMin => ibSizeMin(i));

      U_ObMon : entity surf.AxiStreamMon
         generic map(
            TPD_G           => TPD_G,
            COMMON_CLK_G    => true,      -- true if axisClk = statusClk
            AXIS_CLK_FREQ_G => 100.0E+6,  -- units of Hz
            AXIS_CONFIG_G   => EMAC_AXIS_CONFIG_C)
         port map(
            -- AXIS Stream Interface
            axisClk      => axiClk,
            axisRst      => axiRst,
            axisMaster   => ddrObMasters(i),
            axisSlave    => ddrObSlaves(i),
            -- Status Clock and reset
            statusClk    => axiClk,
            statusRst    => axiRst,
            -- Status: Frame Size (units of Byte)
            frameSize    => obSize(i),
            frameSizeMax => obSizeMax(i),
            frameSizeMin => obSizeMin(i));

      SsiPrbsRx_Inst : entity surf.SsiPrbsRx
         generic map (
            -- General Configurations
            TPD_G                      => TPD_G,
            STATUS_CNT_WIDTH_G         => 1,
            GEN_SYNC_FIFO_G            => true,
            PRBS_SEED_SIZE_G           => 128,
            -- AXI Stream Configurations
            SLAVE_AXI_STREAM_CONFIG_G  => EMAC_AXIS_CONFIG_C,
            MASTER_AXI_STREAM_CONFIG_G => ssiAxiStreamConfig(1))  -- create back pressure
         port map (
            -- Streaming RX Data Interface (sAxisClk domain)
            sAxisClk       => axiClk,
            sAxisRst       => axiRst,
            sAxisMaster    => ddrObMasters(i),
            sAxisSlave     => ddrObSlaves(i),
            -- Error Detection Signals (sAxisClk domain)
            updatedResults => updated(i),
            errorDet       => errorDet(i));

   end generate;

   process(axiClk)
   begin
      if rising_edge(axiClk) then
         failed <= uOr(errorDet) after TPD_G;
      end if;
   end process;

   process(failed, passed)
   begin
      if passed = '1' then
         assert false
            report "Simulation Passed!" severity failure;
      elsif failed = '1' then
         assert false
            report "Simulation Failed!" severity failure;
      end if;
   end process;

end testbed;
