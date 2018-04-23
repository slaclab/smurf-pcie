-------------------------------------------------------------------------------
-- File       : DspCoreWrapper.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2017-06-28
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
use work.Jesd204bPkg.all;
use work.AppTopPkg.all;

entity DspCoreWrapper is
   generic (
      TPD_G            : time             := 1 ns;
      AXI_BASE_ADDR_G  : slv(31 downto 0) := (others => '0'));
   port (
      -- JESD Clocks and resets   
      jesdClk         : in  slv(1 downto 0);
      jesdRst         : in  slv(1 downto 0);
      -- ADC/DAC/Debug Interface (jesdClk[1:0] domain)
      adcValids       : in  Slv10Array(1 downto 0);
      adcValues       : in  sampleDataVectorArray(1 downto 0, 9 downto 0);
      dacValids       : out Slv10Array(1 downto 0);
      dacValues       : out sampleDataVectorArray(1 downto 0, 9 downto 0);
      debugValids     : out Slv4Array(1 downto 0);
      debugValues     : out sampleDataVectorArray(1 downto 0, 3 downto 0);
      -- DAC Signal Generator Interface (jesdClk[1:0] domain)
      dacSigCtrl      : out DacSigCtrlArray(1 downto 0);
      dacSigStatus    : in  DacSigStatusArray(1 downto 0);
      dacSigValids    : in  Slv10Array(1 downto 0);
      dacSigValues    : in  sampleDataVectorArray(1 downto 0, 9 downto 0);
      -- Digital I/O Interface
      startRamp       : in  sl;
      selectRamp      : in  sl;
      rampCnt         : in  slv(31 downto 0);
      -- AXI-Lite Port
      axilClk         : in  sl;
      axilRst         : in  sl;
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType);
end DspCoreWrapper;

architecture mapping of DspCoreWrapper is

   component dspcore
      port (
         adc0                       : in  std_logic_vector (31 downto 0);
         adc1                       : in  std_logic_vector (31 downto 0);
         adc10                      : in  std_logic_vector (31 downto 0);
         adc11                      : in  std_logic_vector (31 downto 0);
         adc12                      : in  std_logic_vector (31 downto 0);
         adc13                      : in  std_logic_vector (31 downto 0);
         adc14                      : in  std_logic_vector (31 downto 0);
         adc15                      : in  std_logic_vector (31 downto 0);
         adc2                       : in  std_logic_vector (31 downto 0);
         adc3                       : in  std_logic_vector (31 downto 0);
         adc4                       : in  std_logic_vector (31 downto 0);
         adc5                       : in  std_logic_vector (31 downto 0);
         adc6                       : in  std_logic_vector (31 downto 0);
         adc7                       : in  std_logic_vector (31 downto 0);
         adc8                       : in  std_logic_vector (31 downto 0);
         adc9                       : in  std_logic_vector (31 downto 0);
         krelay                     : in  std_logic_vector (1 downto 0);
         lemo1                      : in  std_logic_vector (0 to 0);
         rst                        : in  std_logic_vector (0 to 0);
         siggen0                    : in  std_logic_vector (31 downto 0);
         siggen1                    : in  std_logic_vector (31 downto 0);
         dsp_axi_lite_clk           : in  std_logic;
         dsp_clk                    : in  std_logic;
         dsp_axi_lite_aresetn       : in  std_logic;
         dsp_axi_lite_s_axi_awaddr  : in  std_logic_vector (11 downto 0);
         dsp_axi_lite_s_axi_awvalid : in  std_logic;
         dsp_axi_lite_s_axi_wdata   : in  std_logic_vector (31 downto 0);
         dsp_axi_lite_s_axi_wstrb   : in  std_logic_vector (3 downto 0);
         dsp_axi_lite_s_axi_wvalid  : in  std_logic;
         dsp_axi_lite_s_axi_bready  : in  std_logic;
         dsp_axi_lite_s_axi_araddr  : in  std_logic_vector (11 downto 0);
         dsp_axi_lite_s_axi_arvalid : in  std_logic;
         dsp_axi_lite_s_axi_rready  : in  std_logic;
         dac0                       : out std_logic_vector (31 downto 0);
         dac1                       : out std_logic_vector (31 downto 0);
         dac10                      : out std_logic_vector (31 downto 0);
         dac11                      : out std_logic_vector (31 downto 0);
         dac12                      : out std_logic_vector (31 downto 0);
         dac13                      : out std_logic_vector (31 downto 0);
         dac14                      : out std_logic_vector (31 downto 0);
         dac15                      : out std_logic_vector (31 downto 0);
         dac2                       : out std_logic_vector (31 downto 0);
         dac3                       : out std_logic_vector (31 downto 0);
         dac4                       : out std_logic_vector (31 downto 0);
         dac5                       : out std_logic_vector (31 downto 0);
         dac6                       : out std_logic_vector (31 downto 0);
         dac7                       : out std_logic_vector (31 downto 0);
         dac8                       : out std_logic_vector (31 downto 0);
         dac9                       : out std_logic_vector (31 downto 0);
         debug0                     : out std_logic_vector (31 downto 0);
         debug1                     : out std_logic_vector (31 downto 0);
         debug2                     : out std_logic_vector (31 downto 0);
         debug3                     : out std_logic_vector (31 downto 0);
         debug4                     : out std_logic_vector (31 downto 0);
         debug5                     : out std_logic_vector (31 downto 0);
         debug6                     : out std_logic_vector (31 downto 0);
         debug7                     : out std_logic_vector (31 downto 0);
         lemo2                      : out std_logic_vector (0 to 0);
         selectramp                 : out std_logic_vector (0 to 0);
         siggenstart                : out std_logic_vector (0 to 0);
         startramp                  : out std_logic_vector (0 to 0);
         dsp_axi_lite_s_axi_awready : out std_logic;
         dsp_axi_lite_s_axi_wready  : out std_logic;
         dsp_axi_lite_s_axi_bresp   : out std_logic_vector (1 downto 0);
         dsp_axi_lite_s_axi_bvalid  : out std_logic;
         dsp_axi_lite_s_axi_arready : out std_logic;
         dsp_axi_lite_s_axi_rdata   : out std_logic_vector (31 downto 0);
         dsp_axi_lite_s_axi_rresp   : out std_logic_vector (1 downto 0);
         dsp_axi_lite_s_axi_rvalid  : out std_logic
         );
   end component;

   signal axilRstL    : sl;
   signal rstL        : sl;
   signal sigGenStart : sl;

   signal adc    : Slv32Array(15 downto 0);
   signal dac    : Slv32Array(15 downto 0);
   signal debug  : Slv32Array(7 downto 0);
   signal sigGen : Slv32Array(1 downto 0);

begin

   axilRstL        <= not(axilRst);
   rstL            <= not(jesdRst(0));
   dacValids       <= (others => (others => '1'));
   dacValues(0, 8) <= (others => '0');
   dacValues(0, 9) <= (others => '0');
   dacValues(1, 8) <= (others => '0');
   dacValues(1, 9) <= (others => '0');
   debugValids     <= (others => (others => '1'));

   JESD_MAP :
   for i in 7 downto 0 generate
      --------------
      -- JESD BAY[0]
      --------------
      adc(i)          <= adcValues(0, i);
      dacValues(0, i) <= dac(i);
      --------------
      -- JESD BAY[1]
      --------------
      U_SyncAdc : entity work.SynchronizerFifo
         generic map (
            TPD_G        => TPD_G,
            DATA_WIDTH_G => 32)
         port map (
            rst    => jesdRst(1),
            -- Write Ports (wr_clk domain)
            wr_clk => jesdClk(1),
            wr_en  => adcValids(1)(i),
            din    => adcValues(1, i),
            -- Read Ports (rd_clk domain)
            rd_clk => jesdClk(0),
            dout   => adc(8+i));

      U_SyncDac : entity work.SynchronizerFifo
         generic map (
            TPD_G        => TPD_G,
            DATA_WIDTH_G => 32)
         port map (
            rst    => jesdRst(0),
            -- Write Ports (wr_clk domain)
            wr_clk => jesdClk(0),
            din    => dac(8+i),
            -- Read Ports (rd_clk domain)
            rd_clk => jesdClk(1),
            dout   => dacValues(1, i));
   end generate JESD_MAP;

   DEBUG_MAP :
   for i in 3 downto 0 generate
      --------------
      -- JESD BAY[0]
      --------------
      debugValues(0, i) <= debug(i);
      --------------
      -- JESD BAY[1]
      --------------
      U_SyncDebug : entity work.SynchronizerFifo
         generic map (
            TPD_G        => TPD_G,
            DATA_WIDTH_G => 32)
         port map (
            rst    => jesdRst(0),
            -- Write Ports (wr_clk domain)
            wr_clk => jesdClk(0),
            din    => debug(4+i),
            -- Read Ports (rd_clk domain)
            rd_clk => jesdClk(1),
            dout   => debugValues(1, i));
   end generate DEBUG_MAP;

   --------------------------
   -- Signal Generator BAY[0]
   --------------------------
   sigGen(0)           <= dacSigValues(0, 0);
   sigGen(1)           <= dacSigValues(0, 1);
   dacSigCtrl(0).start <= (others => sigGenStart);

   -----------------------------------
   -- Signal Generator BAY[1] not used
   -----------------------------------
   dacSigCtrl(1) <= DAC_SIG_CTRL_INIT_C;

   -------------------
   -- System Generator
   -------------------
   U_SysGen : dspcore
      port map (
         -- Clock and Reset
         dsp_clk                    => jesdClk(0),
         rst(0)                     => jesdRst(0),
         -- ADCs Ports (dsp_clk domain)
         adc0                       => adc(0),
         adc1                       => adc(1),
         adc2                       => adc(2),
         adc3                       => adc(3),
         adc4                       => adc(4),
         adc5                       => adc(5),
         adc6                       => adc(6),
         adc7                       => adc(7),
         adc8                       => adc(8),
         adc9                       => adc(9),
         adc10                      => adc(10),
         adc11                      => adc(11),
         adc12                      => adc(12),
         adc13                      => adc(13),
         adc14                      => adc(14),
         adc15                      => adc(15),
         -- DAC Ports (dsp_clk domain)
         dac0                       => dac(0),
         dac1                       => dac(1),
         dac2                       => dac(2),
         dac3                       => dac(3),
         dac4                       => dac(4),
         dac5                       => dac(5),
         dac6                       => dac(6),
         dac7                       => dac(7),
         dac8                       => dac(8),
         dac9                       => dac(9),
         dac10                      => dac(10),
         dac11                      => dac(11),
         dac12                      => dac(12),
         dac13                      => dac(13),
         dac14                      => dac(14),
         dac15                      => dac(15),
         -- DAQ Mux Debug Ports (dsp_clk domain)
         debug0                     => debug(0),
         debug1                     => debug(1),
         debug2                     => debug(2),
         debug3                     => debug(3),
         debug4                     => debug(4),
         debug5                     => debug(5),
         debug6                     => debug(6),
         debug7                     => debug(7),
         -- Signal Generator Ports (dsp_clk domain)
         sigGenStart(0)             => sigGenStart,
         sigGen0                    => sigGen(0),
         sigGen1                    => sigGen(1),
         -- Digital I/O Interface         
         kRelay                     => "00",
         startRamp(0)               => open,
         selectRamp(0)              => open,
         lemo1(0)                   => '0',
         lemo2(0)                   => open,
         -- AXI-Lite Interface (dsp_axi_lite_clk domain)
         dsp_axi_lite_clk           => axilClk,
         dsp_axi_lite_aresetn       => axilRstL,
         dsp_axi_lite_s_axi_awaddr  => axilWriteMaster.awaddr(11 downto 0),
         dsp_axi_lite_s_axi_awvalid => axilWriteMaster.awvalid,
         dsp_axi_lite_s_axi_wdata   => axilWriteMaster.wdata,
         dsp_axi_lite_s_axi_wstrb   => axilWriteMaster.wstrb,
         dsp_axi_lite_s_axi_wvalid  => axilWriteMaster.wvalid,
         dsp_axi_lite_s_axi_bready  => axilWriteMaster.bready,
         dsp_axi_lite_s_axi_araddr  => axilReadMaster.araddr(11 downto 0),
         dsp_axi_lite_s_axi_arvalid => axilReadMaster.arvalid,
         dsp_axi_lite_s_axi_rready  => axilReadMaster.rready,
         dsp_axi_lite_s_axi_awready => axilWriteSlave.awready,
         dsp_axi_lite_s_axi_wready  => axilWriteSlave.wready,
         dsp_axi_lite_s_axi_bresp   => axilWriteSlave.bresp,
         dsp_axi_lite_s_axi_bvalid  => axilWriteSlave.bvalid,
         dsp_axi_lite_s_axi_arready => axilReadSlave.arready,
         dsp_axi_lite_s_axi_rdata   => axilReadSlave.rdata,
         dsp_axi_lite_s_axi_rresp   => axilReadSlave.rresp,
         dsp_axi_lite_s_axi_rvalid  => axilReadSlave.rvalid);

end mapping;
