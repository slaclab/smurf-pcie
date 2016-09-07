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
set_property PACKAGE_PIN F6 [get_ports {jesdTxP[1][0]}]
set_property PACKAGE_PIN F5 [get_ports {jesdTxN[1][0]}]
set_property PACKAGE_PIN E4 [get_ports {jesdRxP[1][0]}]
set_property PACKAGE_PIN E3 [get_ports {jesdRxN[1][0]}]
set_property PACKAGE_PIN D6 [get_ports {jesdTxP[1][1]}]
set_property PACKAGE_PIN D5 [get_ports {jesdTxN[1][1]}]
set_property PACKAGE_PIN D2 [get_ports {jesdRxP[1][1]}]
set_property PACKAGE_PIN D1 [get_ports {jesdRxN[1][1]}]
                           
set_property PACKAGE_PIN N4 [get_ports {jesdTxP[1][2]}]
set_property PACKAGE_PIN N3 [get_ports {jesdTxN[1][2]}]
set_property PACKAGE_PIN M2 [get_ports {jesdRxP[1][2]}]
set_property PACKAGE_PIN M1 [get_ports {jesdRxN[1][2]}]
set_property PACKAGE_PIN L4 [get_ports {jesdTxP[1][3]}]
set_property PACKAGE_PIN L3 [get_ports {jesdTxN[1][3]}]
set_property PACKAGE_PIN K2 [get_ports {jesdRxP[1][3]}]
set_property PACKAGE_PIN K1 [get_ports {jesdRxN[1][3]}]
                           
set_property PACKAGE_PIN J4 [get_ports {jesdTxP[1][4]}]
set_property PACKAGE_PIN J3 [get_ports {jesdTxN[1][4]}]
set_property PACKAGE_PIN H2 [get_ports {jesdRxP[1][4]}]
set_property PACKAGE_PIN H1 [get_ports {jesdRxN[1][4]}]
set_property PACKAGE_PIN G4 [get_ports {jesdTxP[1][5]}]
set_property PACKAGE_PIN G3 [get_ports {jesdTxN[1][5]}]
set_property PACKAGE_PIN F2 [get_ports {jesdRxP[1][5]}]
set_property PACKAGE_PIN F1 [get_ports {jesdRxN[1][5]}]

set_property PACKAGE_PIN M6 [get_ports {jesdClkP[1]}]
set_property PACKAGE_PIN M5 [get_ports {jesdClkN[1]}]
 
set_property -dict { PACKAGE_PIN AC34 IOSTANDARD LVDS DIFF_TERM TRUE } [get_ports {jesdSysRefP[1]}] 
set_property -dict { PACKAGE_PIN AD34 IOSTANDARD LVDS DIFF_TERM TRUE } [get_ports {jesdSysRefN[1]}] 
set_property -dict { PACKAGE_PIN AM22 IOSTANDARD LVDS DIFF_TERM TRUE } [get_ports {jesdSyncInP[1]}] 
set_property -dict { PACKAGE_PIN AN22 IOSTANDARD LVDS DIFF_TERM TRUE } [get_ports {jesdSyncInN[1]}] 
set_property -dict { PACKAGE_PIN Y31  IOSTANDARD LVDS  } [get_ports {jesdSyncOutP[1][0]}] 
set_property -dict { PACKAGE_PIN Y32  IOSTANDARD LVDS  } [get_ports {jesdSyncOutN[1][0]}]  
set_property -dict { PACKAGE_PIN AF20 IOSTANDARD LVDS  } [get_ports {jesdSyncOutP[1][1]}] 
set_property -dict { PACKAGE_PIN AG20 IOSTANDARD LVDS  } [get_ports {jesdSyncOutN[1][1]}]  
set_property -dict { PACKAGE_PIN AM21 IOSTANDARD LVDS  } [get_ports {jesdSyncOutP[1][2]}] 
set_property -dict { PACKAGE_PIN AN21 IOSTANDARD LVDS  } [get_ports {jesdSyncOutN[1][2]}]

# # AMC's JTAG Ports jtagPri[1][0-4] remapped for SPI 
set_property -dict { PACKAGE_PIN AP9  IOSTANDARD LVCMOS25 PULLUP true} [get_ports {spiSdio_io[1]}] 
set_property -dict { PACKAGE_PIN AL10 IOSTANDARD LVCMOS25 PULLUP true} [get_ports {spiSclk_o[1]}] 
set_property -dict { PACKAGE_PIN AM10 IOSTANDARD LVCMOS25 PULLUP true} [get_ports {spiSdi_o[1]}] 
set_property -dict { PACKAGE_PIN AH9  IOSTANDARD LVCMOS25 PULLUP true} [get_ports {spiSdo_i[1]}] 
set_property -dict { PACKAGE_PIN AH8  IOSTANDARD LVCMOS25 PULLUP true} [get_ports {spiCsL_o[1][0]}]

 # AMC's Spare Ports remapped for SPI
 set_property -dict { PACKAGE_PIN Y23  IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiCsL_o[1][1]}] 
 set_property -dict { PACKAGE_PIN AA23 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiCsL_o[1][2]}] 
 set_property -dict { PACKAGE_PIN AA24 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiCsL_o[1][3]}]
 set_property -dict { PACKAGE_PIN W25  IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiSclkDac_o[1]}] 
 set_property -dict { PACKAGE_PIN Y25  IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiCsLDac_o[1]}]
 set_property -dict { PACKAGE_PIN W23  IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiSdioDac_io[1]}] 
                                  
 # Hardware trigger                
 set_property -dict { PACKAGE_PIN W24 IOSTANDARD LVCMOS18 } [get_ports {trigHW[1]}]