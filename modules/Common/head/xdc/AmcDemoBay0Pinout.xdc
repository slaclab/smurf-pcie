##############################################################################
## This file is part of 'LCLS2 LLRF Development'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'LCLS2 LLRF Development', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################

#######################
## Application Ports ##
#######################

# # RTM's High Speed Ports
set_property PACKAGE_PIN B6 [get_ports {rtmHsTxP}]
set_property PACKAGE_PIN B5 [get_ports {rtmHsTxN}]
set_property PACKAGE_PIN A4 [get_ports {rtmHsRxP}]
set_property PACKAGE_PIN A3 [get_ports {rtmHsRxN}]

# # Spare Clock reference
set_property PACKAGE_PIN P6 [get_ports {genClkP}]
set_property PACKAGE_PIN P5 [get_ports {genClkN}]

# # AMC's JESD Ports
set_property PACKAGE_PIN AN4 [get_ports {jesdTxP[0][0]}]
set_property PACKAGE_PIN AN3 [get_ports {jesdTxN[0][0]}]
set_property PACKAGE_PIN AP2 [get_ports {jesdRxP[0][0]}]
set_property PACKAGE_PIN AP1 [get_ports {jesdRxN[0][0]}]
set_property PACKAGE_PIN AM6 [get_ports {jesdTxP[0][1]}]
set_property PACKAGE_PIN AM5 [get_ports {jesdTxN[0][1]}]
set_property PACKAGE_PIN AM2 [get_ports {jesdRxP[0][1]}]
set_property PACKAGE_PIN AM1 [get_ports {jesdRxN[0][1]}]
                             
set_property PACKAGE_PIN AH6 [get_ports {jesdTxP[0][2]}]
set_property PACKAGE_PIN AH5 [get_ports {jesdTxN[0][2]}]
set_property PACKAGE_PIN AH2 [get_ports {jesdRxP[0][2]}]
set_property PACKAGE_PIN AH1 [get_ports {jesdRxN[0][2]}]
set_property PACKAGE_PIN AG4 [get_ports {jesdTxP[0][3]}]
set_property PACKAGE_PIN AG3 [get_ports {jesdTxN[0][3]}]
set_property PACKAGE_PIN AF2 [get_ports {jesdRxP[0][3]}]
set_property PACKAGE_PIN AF1 [get_ports {jesdRxN[0][3]}]
                             
set_property PACKAGE_PIN AE4 [get_ports {jesdTxP[0][4]}]
set_property PACKAGE_PIN AE3 [get_ports {jesdTxN[0][4]}]
set_property PACKAGE_PIN AD2 [get_ports {jesdRxP[0][4]}]
set_property PACKAGE_PIN AD1 [get_ports {jesdRxN[0][4]}]
set_property PACKAGE_PIN AC4 [get_ports {jesdTxP[0][5]}]
set_property PACKAGE_PIN AC3 [get_ports {jesdTxN[0][5]}]
set_property PACKAGE_PIN AB2 [get_ports {jesdRxP[0][5]}]
set_property PACKAGE_PIN AB1 [get_ports {jesdRxN[0][5]}]

set_property PACKAGE_PIN AB6 [get_ports {jesdClkP[0]}]
set_property PACKAGE_PIN AB5 [get_ports {jesdClkN[0]}]
 
set_property -dict { PACKAGE_PIN AA34 IOSTANDARD LVDS DIFF_TERM TRUE } [get_ports {jesdSysRefP[0]}] 
set_property -dict { PACKAGE_PIN AB34 IOSTANDARD LVDS DIFF_TERM TRUE } [get_ports {jesdSysRefN[0]}] 
set_property -dict { PACKAGE_PIN AN23 IOSTANDARD LVDS DIFF_TERM TRUE } [get_ports {jesdSyncInP[0]}] 
set_property -dict { PACKAGE_PIN AP23 IOSTANDARD LVDS DIFF_TERM TRUE } [get_ports {jesdSyncInN[0]}] 
set_property -dict { PACKAGE_PIN AE25 IOSTANDARD LVDS  } [get_ports {jesdSyncOutP[0][0]}] 
set_property -dict { PACKAGE_PIN AE26 IOSTANDARD LVDS  } [get_ports {jesdSyncOutN[0][0]}]  
set_property -dict { PACKAGE_PIN AJ20 IOSTANDARD LVDS  } [get_ports {jesdSyncOutP[0][1]}] 
set_property -dict { PACKAGE_PIN AK20 IOSTANDARD LVDS  } [get_ports {jesdSyncOutN[0][1]}]  
set_property -dict { PACKAGE_PIN AP24 IOSTANDARD LVDS  } [get_ports {jesdSyncOutP[0][2]}] 
set_property -dict { PACKAGE_PIN AP25 IOSTANDARD LVDS  } [get_ports {jesdSyncOutN[0][2]}]

# # AMC's JTAG Ports jtagPri[1][0-4] remapped for SPI 
set_property -dict { PACKAGE_PIN AK8 IOSTANDARD LVCMOS25 PULLUP true} [get_ports {spiSdio_io[0]}] 
set_property -dict { PACKAGE_PIN AL8 IOSTANDARD LVCMOS25 PULLUP true} [get_ports {spiSclk_o[0]}] 
set_property -dict { PACKAGE_PIN AM9 IOSTANDARD LVCMOS25 PULLUP true} [get_ports {spiSdi_o[0]}] 
set_property -dict { PACKAGE_PIN AJ9 IOSTANDARD LVCMOS25 PULLUP true} [get_ports {spiSdo_i[0]}] 
set_property -dict { PACKAGE_PIN AJ8 IOSTANDARD LVCMOS25 PULLUP true} [get_ports {spiCsL_o[0][0]}]

 # AMC's Spare Ports remapped for SPI
 set_property -dict { PACKAGE_PIN AJ23 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiCsL_o[0][1]}] 
 set_property -dict { PACKAGE_PIN AJ24 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiCsL_o[0][2]}] 
 set_property -dict { PACKAGE_PIN AH22 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiCsL_o[0][3]}]
 set_property -dict { PACKAGE_PIN AK22 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiSclkDac_o[0]}] 
 set_property -dict { PACKAGE_PIN AK23 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiCsLDac_o[0]}]
 set_property -dict { PACKAGE_PIN AJ21 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiSdioDac_io[0]}] 

 # Hardware trigger
 set_property -dict { PACKAGE_PIN AK21 IOSTANDARD LVCMOS18 } [get_ports {trigHW[0]}]