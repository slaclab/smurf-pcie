##############################################################################
## This file is part of 'Example Project Firmware'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'Example Project Firmware', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################
# I/O Port Mapping

set_property -dict { PACKAGE_PIN AN8 IOSTANDARD LVCMOS18 } [get_ports { extRst }]

set_property -dict { PACKAGE_PIN AP8 IOSTANDARD LVCMOS18 } [get_ports { led[0] }]
set_property -dict { PACKAGE_PIN H23 IOSTANDARD LVCMOS18 } [get_ports { led[1] }]
set_property -dict { PACKAGE_PIN P20 IOSTANDARD LVCMOS18 } [get_ports { led[2] }]
set_property -dict { PACKAGE_PIN P21 IOSTANDARD LVCMOS18 } [get_ports { led[3] }]
set_property -dict { PACKAGE_PIN N22 IOSTANDARD LVCMOS18 } [get_ports { led[4] }]
set_property -dict { PACKAGE_PIN M22 IOSTANDARD LVCMOS18 } [get_ports { led[5] }]
set_property -dict { PACKAGE_PIN R23 IOSTANDARD LVCMOS18 } [get_ports { led[6] }]
set_property -dict { PACKAGE_PIN P23 IOSTANDARD LVCMOS18 } [get_ports { led[7] }]

set_property -dict { PACKAGE_PIN AN16 IOSTANDARD LVCMOS12 } [get_ports { gpioDip[0] }]
set_property -dict { PACKAGE_PIN AN19 IOSTANDARD LVCMOS12 } [get_ports { gpioDip[1] }]
set_property -dict { PACKAGE_PIN AP18 IOSTANDARD LVCMOS12 } [get_ports { gpioDip[2] }]
set_property -dict { PACKAGE_PIN AN14 IOSTANDARD LVCMOS12 } [get_ports { gpioDip[3] }]

set_property PACKAGE_PIN U4 [get_ports { sfpTxP[0] }]
set_property PACKAGE_PIN U3 [get_ports { sfpTxN[0] }]
set_property PACKAGE_PIN T2 [get_ports { sfpRxP[0] }]
set_property PACKAGE_PIN T1 [get_ports { sfpRxN[0] }]

set_property PACKAGE_PIN W4 [get_ports { sfpTxP[1] }]
set_property PACKAGE_PIN W3 [get_ports { sfpTxN[1] }]
set_property PACKAGE_PIN V2 [get_ports { sfpRxP[1] }]
set_property PACKAGE_PIN V1 [get_ports { sfpRxN[1] }]

set_property PACKAGE_PIN P6 [get_ports sfpClkP]
set_property PACKAGE_PIN P5 [get_ports sfpClkN]

set_property -dict { PACKAGE_PIN C22 IOSTANDARD LVCMOS18 } [get_ports { fmcLed[0] }]
set_property -dict { PACKAGE_PIN C21 IOSTANDARD LVCMOS18 } [get_ports { fmcLed[1] }]
set_property -dict { PACKAGE_PIN E23 IOSTANDARD LVCMOS18 } [get_ports { fmcLed[2] }]
set_property -dict { PACKAGE_PIN E22 IOSTANDARD LVCMOS18 } [get_ports { fmcLed[3] }]

set_property -dict { PACKAGE_PIN A10 IOSTANDARD LVCMOS18 } [get_ports { fmcSfpLossL[0] }]
set_property -dict { PACKAGE_PIN K11 IOSTANDARD LVCMOS18 } [get_ports { fmcSfpLossL[1] }]
set_property -dict { PACKAGE_PIN E8  IOSTANDARD LVCMOS18 } [get_ports { fmcSfpLossL[2] }]
set_property -dict { PACKAGE_PIN L12 IOSTANDARD LVCMOS18 } [get_ports { fmcSfpLossL[3] }]

set_property -dict { PACKAGE_PIN C24 IOSTANDARD LVCMOS18 } [get_ports { fmcTxFault[0] }]
set_property -dict { PACKAGE_PIN B10 IOSTANDARD LVCMOS18 } [get_ports { fmcTxFault[1] }]
set_property -dict { PACKAGE_PIN K8  IOSTANDARD LVCMOS18 } [get_ports { fmcTxFault[2] }]
set_property -dict { PACKAGE_PIN F8  IOSTANDARD LVCMOS18 } [get_ports { fmcTxFault[3] }]

set_property -dict { PACKAGE_PIN D24 IOSTANDARD LVCMOS18 } [get_ports { fmcSfpTxDisable[0] }]
set_property -dict { PACKAGE_PIN C9  IOSTANDARD LVCMOS18 } [get_ports { fmcSfpTxDisable[1] }]
set_property -dict { PACKAGE_PIN L8  IOSTANDARD LVCMOS18 } [get_ports { fmcSfpTxDisable[2] }]
set_property -dict { PACKAGE_PIN C13 IOSTANDARD LVCMOS18 } [get_ports { fmcSfpTxDisable[3] }]

set_property -dict { PACKAGE_PIN D8  IOSTANDARD LVCMOS18 } [get_ports { fmcSfpRateSel[0] }]
set_property -dict { PACKAGE_PIN J11 IOSTANDARD LVCMOS18 } [get_ports { fmcSfpRateSel[1] }]
set_property -dict { PACKAGE_PIN J8  IOSTANDARD LVCMOS18 } [get_ports { fmcSfpRateSel[2] }]
set_property -dict { PACKAGE_PIN K12 IOSTANDARD LVCMOS18 } [get_ports { fmcSfpRateSel[3] }]

set_property -dict { PACKAGE_PIN C8  IOSTANDARD LVCMOS18 } [get_ports { fmcSfpModDef0[0] }]
set_property -dict { PACKAGE_PIN E10 IOSTANDARD LVCMOS18 } [get_ports { fmcSfpModDef0[1] }]
set_property -dict { PACKAGE_PIN H8  IOSTANDARD LVCMOS18 } [get_ports { fmcSfpModDef0[2] }]
set_property -dict { PACKAGE_PIN L13 IOSTANDARD LVCMOS18 } [get_ports { fmcSfpModDef0[3] }]

# 1st SFP channel on FMC card
set_property PACKAGE_PIN F6 [get_ports fmcTxP[0]]
set_property PACKAGE_PIN F5 [get_ports fmcTxN[0]]
set_property PACKAGE_PIN E4 [get_ports fmcRxP[0]]
set_property PACKAGE_PIN E3 [get_ports fmcRxN[0]]

# 2nd SFP channel on FMC card
set_property PACKAGE_PIN D6 [get_ports fmcTxP[1]]
set_property PACKAGE_PIN D5 [get_ports fmcTxN[1]]
set_property PACKAGE_PIN D2 [get_ports fmcRxP[1]]
set_property PACKAGE_PIN D1 [get_ports fmcRxN[1]]

# 3rd SFP channel on FMC card
set_property PACKAGE_PIN C4 [get_ports fmcTxP[2]]
set_property PACKAGE_PIN C3 [get_ports fmcTxN[2]]
set_property PACKAGE_PIN B2 [get_ports fmcRxP[2]]
set_property PACKAGE_PIN B1 [get_ports fmcRxN[2]]

# 4th SFP channel on FMC card
set_property PACKAGE_PIN B6 [get_ports fmcTxP[3]]
set_property PACKAGE_PIN B5 [get_ports fmcTxN[3]]
set_property PACKAGE_PIN A4 [get_ports fmcRxP[3]]
set_property PACKAGE_PIN A3 [get_ports fmcRxN[3]]

# Timing Constraints 
create_clock -name sfpClkP -period  6.400 [get_ports {sfpClkP}]

set_clock_groups -asynchronous -group [get_clocks sfpClkP] -group [get_clocks -of_objects [get_pins {U_FMC/GEN_LANE[*].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]]
set_clock_groups -asynchronous -group [get_clocks sfpClkP] -group [get_clocks -of_objects [get_pins {U_SFP/GEN_LANE[*].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]]

# BITSTREAM Configurations
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design] 
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 1 [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE No [current_design]
