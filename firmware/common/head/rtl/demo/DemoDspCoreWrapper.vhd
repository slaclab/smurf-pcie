-------------------------------------------------------------------------------
-- Title      : System Generator core wrapper
-------------------------------------------------------------------------------
-- File       : DemoDspCoreWrapper.vhd
-- Author     : Larry Ruckman  <ruckman@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2016-02-25
-- Last update: 2016-08-22
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- 
-------------------------------------------------------------------------------
-- This file is part of 'LCLS2 LLRF Development'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 LLRF Development', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.StdRtlPkg.all;
use work.AxiLitePkg.all;
use work.Jesd204bPkg.all;

library unisim;
use unisim.vcomponents.all;

entity DemoDspCoreWrapper is
   generic (
      TPD_G        : time     := 1 ns;
      DSP_CLK_2X_G : boolean  := false
   );
   port (
      -- JESD Interface
      jesdClk        : in  sl;
      jesdRst        : in  sl;
      
      jesdClk2x      : in  sl;
      jesdRst2x      : in  sl;
      
      adcHs          : in  sampleDataArray(5 downto 0);
      dacHs          : out sampleDataArray(1 downto 0);
      debug          : out Slv32Array(3 downto 0);
            
      -- AXI-Lite Port
      axiClk         : in  sl;
      axiRst         : in  sl;
      axiReadMaster  : in  AxiLiteReadMasterType;
      axiReadSlave   : out AxiLiteReadSlaveType;
      axiWriteMaster : in  AxiLiteWriteMasterType;
      axiWriteSlave  : out AxiLiteWriteSlaveType);
end DemoDspCoreWrapper;

architecture mapping of DemoDspCoreWrapper is
   
   signal readMaster  : AxiLiteReadMasterType;
   signal readSlave   : AxiLiteReadSlaveType;
   signal writeMaster : AxiLiteWriteMasterType;
   signal writeSlave  : AxiLiteWriteSlaveType;
   signal jesdRstL    : sl;
   -- 1x

   -- 2x
   signal adcHsSync2x : Slv16Array(5 downto 0);
   signal debugSync2x : Slv16Array(3 downto 0);   
   signal dacHs2x     : Slv16Array(1 downto 0);

begin
   --
   --
   -- 1x CLK
   --
   --
   GEN_1X_CLK : if DSP_CLK_2X_G = false generate
   ------------------------------------------------------------
      jesdRstL <= not(jesdRst);

      ----------------------
      -- ASYNC AXI-Lite Jump
      ----------------------
      U_AxiLiteAsync : entity work.AxiLiteAsync
         generic map (
            TPD_G => TPD_G)
         port map (
            -- Slave Port
            sAxiClk         => axiClk,
            sAxiClkRst      => axiRst,
            sAxiReadMaster  => axiReadMaster,
            sAxiReadSlave   => axiReadSlave,
            sAxiWriteMaster => axiWriteMaster,
            sAxiWriteSlave  => axiWriteSlave,
            -- Master Port
            mAxiClk         => jesdClk,
            mAxiClkRst      => jesdRst,
            mAxiReadMaster  => readMaster,
            mAxiReadSlave   => readSlave,
            mAxiWriteMaster => writeMaster,
            mAxiWriteSlave  => writeSlave);  

      -----------
      -- DSP Core
      -----------
      U_DspCore : entity work.DspCore
         port map (
            -- Clock and Resets
            clk                   => jesdClk,
            rst(0)                => jesdRst,
            dspcore_aresetn       => jesdRstL,
            -- ADC Channels
            adcbay1_0             => adcHs(0),
            adcbay1_1             => adcHs(1),
            adcbay1_2             => adcHs(2),
            adcbay1_3             => adcHs(3),
            adcbay1_4             => adcHs(4),
            adcbay1_5             => adcHs(5),
            -- DAC Channels
            dacbay1_0             => dacHs(0),
            dacbay1_1             => dacHs(1),            
            -- Debug output ports
            debugbay1_0           => debug(0),
            debugbay1_1           => debug(1),
            debugbay1_2           => debug(2),
            debugbay1_3           => debug(3),
            
            -- AXI-Lite Interface
            dspcore_s_axi_awaddr  => writeMaster.awaddr(11 downto 0),
            dspcore_s_axi_awvalid => writeMaster.awvalid,
            dspcore_s_axi_wdata   => writeMaster.wdata,
            dspcore_s_axi_wstrb   => writeMaster.wstrb,
            dspcore_s_axi_wvalid  => writeMaster.wvalid,
            dspcore_s_axi_bready  => writeMaster.bready,
            dspcore_s_axi_araddr  => readMaster.araddr(11 downto 0),
            dspcore_s_axi_arvalid => readMaster.arvalid,
            dspcore_s_axi_rready  => readMaster.rready,
            dspcore_s_axi_awready => writeSlave.awready,
            dspcore_s_axi_wready  => writeSlave.wready,
            dspcore_s_axi_bresp   => writeSlave.bresp,
            dspcore_s_axi_bvalid  => writeSlave.bvalid,
            dspcore_s_axi_arready => readSlave.arready,
            dspcore_s_axi_rdata   => readSlave.rdata,
            dspcore_s_axi_rresp   => readSlave.rresp,
            dspcore_s_axi_rvalid  => readSlave.rvalid); 
   ------------------------------------------------------------
   end generate  GEN_1X_CLK;
   
   --
   --
   -- 2x CLK
   --
   --
   GEN_2X_CLK : if DSP_CLK_2X_G = true generate
   ------------------------------------------------------------
      jesdRstL <= not(jesdRst2x);

      ----------------------
      -- ASYNC AXI-Lite Jump
      ----------------------
      U_AxiLiteAsync : entity work.AxiLiteAsync
         generic map (
            TPD_G => TPD_G)
         port map (
            -- Slave Port
            sAxiClk         => axiClk,
            sAxiClkRst      => axiRst,
            sAxiReadMaster  => axiReadMaster,
            sAxiReadSlave   => axiReadSlave,
            sAxiWriteMaster => axiWriteMaster,
            sAxiWriteSlave  => axiWriteSlave,
            -- Master Port
            mAxiClk         => jesdClk2x,
            mAxiClkRst      => jesdRst2x,
            mAxiReadMaster  => readMaster,
            mAxiReadSlave   => readSlave,
            mAxiWriteMaster => writeMaster,
            mAxiWriteSlave  => writeSlave); 
      
      ----------------------
      -- Input sync and processing
      ----------------------      
      SYNC_ADC :
      for i in 5 downto 0 generate
         
         -- Bay1 - Synchronize to Bay1 clk2x
         U_Jesd32bTo16b_bay1: entity work.Jesd32bTo16b
         generic map (
            TPD_G => TPD_G)
         port map (
            wrClk    => jesdClk,
            wrRst    => jesdRst,
            validIn  => '1',
            dataIn   => adcHs(i),
            rdClk    => jesdClk2x,
            rdRst    => jesdRst2x,
            validOut => open,
            dataOut  => adcHsSync2x(i));         
      end generate SYNC_ADC;         

      -----------
      -- DSP Core
      -----------
      U_DspCore : entity work.DspCore
         port map (
            -- Clock and Resets
            clk                   => jesdClk2x,
            rst(0)                => jesdRst2x,
            dspcore_aresetn       => jesdRstL,
            -- ADC Channels
            adcbay1_0             => adcHsSync2x(0),
            adcbay1_1             => adcHsSync2x(1),
            adcbay1_2             => adcHsSync2x(2),
            adcbay1_3             => adcHsSync2x(3),
            adcbay1_4             => adcHsSync2x(4),
            adcbay1_5             => adcHsSync2x(5),
            -- DAC Channels
            dacbay1_0             => dacHs2x(0),
            dacbay1_1             => dacHs2x(1),            
            -- Debug output ports
            debugbay1_0           => debugSync2x(0),
            debugbay1_1           => debugSync2x(1),
            debugbay1_2           => debugSync2x(2),
            debugbay1_3           => debugSync2x(3),
            
            -- AXI-Lite Interface
            dspcore_s_axi_awaddr  => writeMaster.awaddr(11 downto 0),
            dspcore_s_axi_awvalid => writeMaster.awvalid,
            dspcore_s_axi_wdata   => writeMaster.wdata,
            dspcore_s_axi_wstrb   => writeMaster.wstrb,
            dspcore_s_axi_wvalid  => writeMaster.wvalid,
            dspcore_s_axi_bready  => writeMaster.bready,
            dspcore_s_axi_araddr  => readMaster.araddr(11 downto 0),
            dspcore_s_axi_arvalid => readMaster.arvalid,
            dspcore_s_axi_rready  => readMaster.rready,
            dspcore_s_axi_awready => writeSlave.awready,
            dspcore_s_axi_wready  => writeSlave.wready,
            dspcore_s_axi_bresp   => writeSlave.bresp,
            dspcore_s_axi_bvalid  => writeSlave.bvalid,
            dspcore_s_axi_arready => readSlave.arready,
            dspcore_s_axi_rdata   => readSlave.rdata,
            dspcore_s_axi_rresp   => readSlave.rresp,
            dspcore_s_axi_rvalid  => readSlave.rvalid);   

      ----------------------
      -- Output sync and processing
      ---------------------- 

      -- Debug ports      
      SYNC_DEBUG :
      for i in 3 downto 0 generate
         U_Jesd16bTo32b: entity work.Jesd16bTo32b
         generic map (
            TPD_G => TPD_G)
         port map (
            wrClk    => jesdClk2x,
            wrRst    => jesdRst2x,
            validIn  => '1',
            dataIn   => debugSync2x(i),
            rdClk    => jesdClk,
            rdRst    => jesdRst,
            validOut => open,
            dataOut  => debug(i));
      end generate SYNC_DEBUG;
      
      -- DAC
      SYNC_HSDAC :
      for i in 1 downto 0 generate
         -- Bay1 - Synchronize to Bay1 clk
         U_Jesd16bTo32b_bay1: entity work.Jesd16bTo32b
         generic map (
            TPD_G => TPD_G)
         port map (
            wrClk    => jesdClk2x,
            wrRst    => jesdRst2x,
            validIn  => '1',
            dataIn   => dacHs2x(i),
            rdClk    => jesdClk,
            rdRst    => jesdRst,
            validOut => open,
            dataOut  => dacHs(i));         
      end generate SYNC_HSDAC;

   ------------------------------------------------------------
   end generate  GEN_2X_CLK;
--
   
end mapping;
