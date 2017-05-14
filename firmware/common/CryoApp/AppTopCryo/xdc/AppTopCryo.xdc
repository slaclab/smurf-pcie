##############################################################################
## This file is part of 'LCLS2 AMC Carrier Firmware'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'LCLS2 AMC Carrier Firmware', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################
#######################
## Application Ports ##
#######################

set_property -dict { PACKAGE_PIN M11 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoP[0][0]}] #P12 PIN157
set_property -dict { PACKAGE_PIN N11 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoN[0][0]}] #P12 PIN156
set_property -dict { PACKAGE_PIN B12 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoP[0][1]}] #P12 PIN154
set_property -dict { PACKAGE_PIN C12 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoN[0][1]}] #P12 PIN153
set_property -dict { PACKAGE_PIN E12 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoP[0][2]}] #P12 PIN163
set_property -dict { PACKAGE_PIN F12 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoN[0][2]}] #P12 PIN162
set_property -dict { PACKAGE_PIN H12 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoP[0][3]}] #P12 PIN160
set_property -dict { PACKAGE_PIN I12 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoN[0][3]}] #P12 PIN159

set_property -dict { PACKAGE_PIN K12 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoP[0][0]}] #P14 PIN157
set_property -dict { PACKAGE_PIN L12 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoN[0][0]}] #P14 PIN156
set_property -dict { PACKAGE_PIN N12 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoP[0][1]}] #P14 PIN154
set_property -dict { PACKAGE_PIN O12 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoN[0][1]}] #P14 PIN153
set_property -dict { PACKAGE_PIN A13 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoP[0][2]}] #P14 PIN163
set_property -dict { PACKAGE_PIN B13 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoN[0][2]}] #P14 PIN162
set_property -dict { PACKAGE_PIN D13 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoP[0][3]}] #P14 PIN160
set_property -dict { PACKAGE_PIN E13 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100 } [get_ports {amcIoN[0][3]}] #P14 PIN159

set_property PACKAGE_PIN N29 [get_ports {jesdClkP[0][3]}] ; #P11 PIN88 
set_property PACKAGE_PIN N30 [get_ports {jesdClkN[0][3]}] ; #P11 PIN87 
set_property PACKAGE_PIN J29 [get_ports {jesdClkP[1][3]}] ; #P13 PIN88
set_property PACKAGE_PIN J30 [get_ports {jesdClkN[1][3]}] ; #P13 PIN87