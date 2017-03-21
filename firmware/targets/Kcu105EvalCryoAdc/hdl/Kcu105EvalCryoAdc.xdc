##############################################################################
## This file is part of 'LCLS2 Common Carrier Core'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'LCLS2 Common Carrier Core', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################

set_property -dict { PACKAGE_PIN AN8 IOSTANDARD LVCMOS18 } [get_ports { extRst }]

set_property -dict { PACKAGE_PIN AP8 IOSTANDARD LVCMOS18 } [get_ports { led[0] }]
set_property -dict { PACKAGE_PIN H23 IOSTANDARD LVCMOS18 } [get_ports { led[1] }]
set_property -dict { PACKAGE_PIN P20 IOSTANDARD LVCMOS18 } [get_ports { led[2] }]
set_property -dict { PACKAGE_PIN P21 IOSTANDARD LVCMOS18 } [get_ports { led[3] }]
set_property -dict { PACKAGE_PIN N22 IOSTANDARD LVCMOS18 } [get_ports { led[4] }]
set_property -dict { PACKAGE_PIN M22 IOSTANDARD LVCMOS18 } [get_ports { led[5] }]
set_property -dict { PACKAGE_PIN R23 IOSTANDARD LVCMOS18 } [get_ports { led[6] }]
set_property -dict { PACKAGE_PIN P23 IOSTANDARD LVCMOS18 } [get_ports { led[7] }]

set_property PACKAGE_PIN U4 [get_ports ethTxP]
set_property PACKAGE_PIN U3 [get_ports ethTxN]
set_property PACKAGE_PIN T2 [get_ports ethRxP]
set_property PACKAGE_PIN T1 [get_ports ethRxN]

set_property PACKAGE_PIN N4 [get_ports {jesdTxP[0]}] ; #J22 
set_property PACKAGE_PIN N3 [get_ports {jesdTxN[0]}] ; #J22 PIN 
set_property PACKAGE_PIN M2 [get_ports {jesdRxP[0]}] ; #J22 PIN A14
set_property PACKAGE_PIN M1 [get_ports {jesdRxN[0]}] ; #J22 PIN A15
set_property PACKAGE_PIN L4 [get_ports {jesdTxP[1]}] ; #J22 PIN
set_property PACKAGE_PIN L3 [get_ports {jesdTxN[1]}] ; #J22 PIN
set_property PACKAGE_PIN K2 [get_ports {jesdRxP[1]}] ; #J22 PIN B16
set_property PACKAGE_PIN K1 [get_ports {jesdRxN[1]}] ; #J22 PIN B17
set_property PACKAGE_PIN F6 [get_ports {jesdTxP[2]}] ; #J22 PIN
set_property PACKAGE_PIN F5 [get_ports {jesdTxN[2]}] ; #J22 PIN
set_property PACKAGE_PIN E4 [get_ports {jesdRxP[2]}] ; #J22 PIN C6
set_property PACKAGE_PIN E3 [get_ports {jesdRxN[2]}] ; #J22 PIN C7
set_property PACKAGE_PIN C4 [get_ports {jesdTxP[3]}] ; #J22 PIN
set_property PACKAGE_PIN C3 [get_ports {jesdTxN[3]}] ; #J22 PIN
set_property PACKAGE_PIN B2 [get_ports {jesdRxP[3]}] ; #J22 PIN A6
set_property PACKAGE_PIN B1 [get_ports {jesdRxN[3]}] ; #J22 PIN A7

set_property PACKAGE_PIN K6 [get_ports {jesdClkP}]
set_property PACKAGE_PIN K5 [get_ports {jesdClkN}]

set_property -dict { PACKAGE_PIN A13 IOSTANDARD LVDS DIFF_TERM TRUE } [get_ports {jesdSysRefP}] 
set_property -dict { PACKAGE_PIN A12 IOSTANDARD LVDS DIFF_TERM TRUE } [get_ports {jesdSysRefN}]

set_property -dict { PACKAGE_PIN J8  IOSTANDARD LVDS  } [get_ports {jesdRxSyncP}] 
set_property -dict { PACKAGE_PIN H8  IOSTANDARD LVDS  } [get_ports {jesdRxSyncN}] 

# Extras on FMC
set_property -dict { PACKAGE_PIN B10} [get_ports {jesdRxSyncLed}]

set_property -dict { PACKAGE_PIN H21} [get_ports {fmcCtrl[0]}]
set_property -dict { PACKAGE_PIN G21} [get_ports {fmcCtrl[1]}]

set_property PACKAGE_PIN P6 [get_ports clkRefP]
set_property PACKAGE_PIN P5 [get_ports clkRefN]

set_property PACKAGE_PIN H27 [get_ports smaGpioP]
set_property PACKAGE_PIN G27 [get_ports smaGpioN]
set_property PACKAGE_PIN D23 [get_ports smaClkP]
set_property PACKAGE_PIN C23 [get_ports smaClkN]

set_property -dict { PACKAGE_PIN AL14} [get_ports {debug[0]}]
set_property -dict { PACKAGE_PIN AM14} [get_ports {debug[1]}]

# BITSTREAM Configurations
set_property BITSTREAM.CONFIG.CONFIGRATE   6  [current_design] 
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 8  [current_design]

# StdLib
set_property ASYNC_REG TRUE [get_cells -hierarchical *crossDomainSyncReg_reg*]

# Timing Constraints 
create_clock -name clkRefP  -period  6.400 [get_ports {clkRefP}]
#create_clock -name jesdClkP -period  6.400 [get_ports {jesdClkP}]
create_clock -name jesdClkP -period  3.256 [get_ports {jesdClkP}]
#create_clock -name jesdClkP -period  3.200 [get_ports {jesdClkP}]

create_generated_clock -name jesdClk [get_pins {U_jesd/U_ClockManager/MmcmGen.U_Mmcm/CLKOUT0}]
create_generated_clock -name axilClk [get_pins {U_Core/TenGigEthGthUltraScaleWrapper_Inst/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]
create_generated_clock -name dnaClk  [get_pins {U_Core/AxiVersion_Inst/GEN_DEVICE_DNA.DeviceDna_1/GEN_ULTRA_SCALE.DeviceDnaUltraScale_Inst/BUFGCE_DIV_Inst/O}]

set_clock_groups -asynchronous   -group [get_clocks {axilClk}] -group [get_clocks {dnaClk}]
set_clock_groups -asynchronous   -group [get_clocks {axilClk}] -group [get_clocks {jesdClk}]


