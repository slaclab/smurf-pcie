-------------------------------------------------------------------------------
-- Title      : System Generator core wrapper 370 clock
-------------------------------------------------------------------------------
-- File       : SysGenWrapper370.vhd
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

entity SysGenWrapper370 is
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
end SysGenWrapper370;

architecture mapping of SysGenWrapper370 is
   
   -- Data swap bytes and 
   signal todsp_adcdata   : Slv16Array(L_ADC_G-1 downto 0);
   signal fromdsp_dacdata : Slv16Array(L_DAC_G-1 downto 0);
   signal fromdsp_debug   : Slv16Array(1 downto 0);
   
   signal readMaster  : AxiLiteReadMasterType;
   signal readSlave   : AxiLiteReadSlaveType;
   signal writeMaster : AxiLiteWriteMasterType;
   signal writeSlave  : AxiLiteWriteSlaveType;
   
   
   -- Active low reset
   signal jesdClk370RstL : sl;
   
begin

   jesdClk370RstL <= not(jesdClk370Rst);
   
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
         mAxiClk         => jesdClk370,
         mAxiClkRst      => jesdClk370Rst,
         mAxiReadMaster  => readMaster,
         mAxiReadSlave   => readSlave,
         mAxiWriteMaster => writeMaster,
         mAxiWriteSlave  => writeSlave);  
         
   ---------------------------------------------
   -- ADC data processing and synchronization
   ---------------------------------------------
   
   GEN_0 : for I in L_ADC_G-1 downto 0 generate
      Jesd32bTo16b_INST: entity work.Jesd32bTo16b
      generic map (
         TPD_G => TPD_G)
      port map (
         wrClk    => jesdClk,
         wrRst    => jesdRst,
         validIn  => '1',
         dataIn   => adc(I),
         rdClk    => jesdClk370,
         rdRst    => jesdClk370Rst,
         validOut => open,
         dataOut  => todsp_adcdata(I));
   end generate GEN_0;


   -----------
   -- DSP Core
   -----------
   U_DspCore : entity work.DspCore
      port map (
         -- Clock and Resets
         clk                   => jesdClk370,
         rst(0)                => jesdClk370Rst,
         dspcore_aresetn       => jesdClk370RstL,
         
         -- ADC Channels
         todsp_adcdata0        => todsp_adcdata(0),
         todsp_adcdata1        => todsp_adcdata(1),
         todsp_adcdata2        => todsp_adcdata(2),
         todsp_adcdata3        => todsp_adcdata(3),
         todsp_adcdata4        => todsp_adcdata(4),
         todsp_adcdata5        => todsp_adcdata(5),
         -- DAC Channels
         fromdsp_dacdata0      => fromdsp_dacdata(0),
         fromdsp_dacdata1      => fromdsp_dacdata(1),
         
        -- Debug Channels
         fromdsp_debug0      => fromdsp_debug(0),
         fromdsp_debug1      => fromdsp_debug(1),

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
   
   GEN_1 : for I in L_DAC_G-1 downto 0 generate
      Jesd16bTo32b_INST: entity work.Jesd16bTo32b
      generic map (
         TPD_G => TPD_G)
      port map (
         wrClk    => jesdClk370,
         wrRst    => jesdClk370Rst,
         validIn  => '1',
         dataIn   => fromdsp_dacdata(I),
         rdClk    => jesdClk,
         rdRst    => jesdRst,
         validOut => open,
         dataOut  => dac(I));
   end generate GEN_1;
   
   GEN_2 : for I in 1 downto 0 generate
      Jesd16bTo32b_INST: entity work.Jesd16bTo32b
      generic map (
         TPD_G => TPD_G)
      port map (
         wrClk    => jesdClk370,
         wrRst    => jesdClk370Rst,
         validIn  => '1',
         dataIn   => fromdsp_debug(I),
         rdClk    => jesdClk,
         rdRst    => jesdRst,
         validOut => open,
         dataOut  => debug(I));
   end generate GEN_2;

end mapping;