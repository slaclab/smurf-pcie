-------------------------------------------------------------------------------
-- Title      : System Generator core wrapper for Cryo
-------------------------------------------------------------------------------
-- File       : SysGenWrapper.vhd
-- Author     : Larry Ruckman  <ruckman@slac.stanford.edu>
-- Modified   : Uros Legat <ulegat@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2015-09-25
-- Last update: 2015-09-25
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

entity SysGenWrapper is
   generic (
      TPD_G          : time     := 1 ns;
      
      -- AXI lite number of address bits
      ADDR_WIDTH_G   : positive := 8;   
      L_ADC_G        : positive := 6; 
      L_DAC_G        : positive := 2     
   );
   port (
      -- Core Clock and Reset
      jesdClk         : in  sl;  -- 185 MHz
      jesdRst         : in  sl;
      jesdClk370      : in  sl;  -- 370 MHz
      jesdClk370Rst   : in  sl;      
      
      adc            : in  sampleDataArray(L_ADC_G-1 downto 0);
      dac            : out sampleDataArray(L_DAC_G-1 downto 0);
      debug          : out sampleDataArray(1 downto 0);
      -- AXI-Lite Port
      axiClk         : in  sl;
      axiRst         : in  sl;
      axiReadMaster  : in  AxiLiteReadMasterType;
      axiReadSlave   : out AxiLiteReadSlaveType;
      axiWriteMaster : in  AxiLiteWriteMasterType;
      axiWriteSlave  : out AxiLiteWriteSlaveType);
end SysGenWrapper;

architecture mapping of SysGenWrapper is
   
   -- Data swap bytes and 
   --signal  adcDataSwap     : sampleDataArray(L_ADC_G-1 downto 0);
   signal  todsp_adcdata   : sampleDataArray(L_ADC_G-1 downto 0);
      
   signal  fromdsp_dacdata : sampleDataArray(L_DAC_G-1 downto 0);
   signal  fromdsp_debug   : sampleDataArray(1 downto 0);
   
   signal readMaster  : AxiLiteReadMasterType;
   signal readSlave   : AxiLiteReadSlaveType;
   signal writeMaster : AxiLiteWriteMasterType;
   signal writeSlave  : AxiLiteWriteSlaveType;
   
   
   -- Active low reset
   signal jesdRstL : sl;
   
begin

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
         
   ---------------------------------------------
   -- ADC data processing and synchronization
   -- Note: This module does only 1:1 mapping 
   -- Module is not asynchroneus
   ---------------------------------------------

   -- Data format: 31|MSB0|LSB0|MSB1|LSB1|0 
   todsp_adcdata <= adc;
   dac <= fromdsp_dacdata;
   debug <= fromdsp_debug;

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
         todsp_adcdata0_0        => todsp_adcdata(0)(15 downto 0),
         todsp_adcdata0_1        => todsp_adcdata(0)(31 downto 16),
         
         todsp_adcdata1_0        => todsp_adcdata(1)(15 downto 0),
         todsp_adcdata1_1        => todsp_adcdata(1)(31 downto 16),
         
         todsp_adcdata2_0        => todsp_adcdata(2)(15 downto 0),
         todsp_adcdata2_1        => todsp_adcdata(2)(31 downto 16),
         
         todsp_adcdata3_0        => todsp_adcdata(3)(15 downto 0),
         todsp_adcdata3_1        => todsp_adcdata(3)(31 downto 16),
         
         todsp_adcdata4_0        => todsp_adcdata(4)(15 downto 0),
         todsp_adcdata4_1        => todsp_adcdata(4)(31 downto 16),
         
         todsp_adcdata5_0        => todsp_adcdata(5)(15 downto 0),
         todsp_adcdata5_1        => todsp_adcdata(5)(31 downto 16),
         
         -- DAC Channels
         fromdsp_dacdata0_0      => fromdsp_dacdata(0)(15 downto 0),
         fromdsp_dacdata0_1      => fromdsp_dacdata(0)(31 downto 16),
         
         fromdsp_dacdata1_0      => fromdsp_dacdata(1)(15 downto 0),
         fromdsp_dacdata1_1      => fromdsp_dacdata(1)(31 downto 16),
         
         -- Debug Channels
         fromdsp_debug0_0      => fromdsp_debug(0)(15 downto 0),
         fromdsp_debug0_1      => fromdsp_debug(0)(31 downto 16),
         
         fromdsp_debug1_0      => fromdsp_debug(1)(15 downto 0),
         fromdsp_debug1_1      => fromdsp_debug(1)(31 downto 16),
         

         -- AXI-Lite Interface
         dspcore_s_axi_awaddr  => writeMaster.awaddr(ADDR_WIDTH_G-1 downto 0),
         dspcore_s_axi_awvalid => writeMaster.awvalid,
         dspcore_s_axi_wdata   => writeMaster.wdata,
         dspcore_s_axi_wstrb   => writeMaster.wstrb,
         dspcore_s_axi_wvalid  => writeMaster.wvalid,
         dspcore_s_axi_bready  => writeMaster.bready,
         dspcore_s_axi_araddr  => readMaster.araddr(ADDR_WIDTH_G-1 downto 0),
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
------------------------------------------
end mapping;