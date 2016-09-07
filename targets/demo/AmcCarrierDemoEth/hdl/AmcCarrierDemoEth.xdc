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

# RTM Latency Measurement Debug Pulses
set_property -dict {PACKAGE_PIN P21 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100} [get_ports {rtmLsN[32]}]
set_property -dict {PACKAGE_PIN N22 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100} [get_ports {rtmLsP[33]}]
set_property -dict {PACKAGE_PIN M22 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100} [get_ports {rtmLsN[33]}]
set_property -dict {PACKAGE_PIN R23 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100} [get_ports {rtmLsP[34]}]
set_property -dict {PACKAGE_PIN P23 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100} [get_ports {rtmLsN[34]}]
set_property -dict {PACKAGE_PIN R25 IOSTANDARD LVDS_25 DIFF_TERM_ADV TERM_100} [get_ports {rtmLsP[35]}]

# Ethernet
set_property PACKAGE_PIN B6 [get_ports {ethTxP}]
set_property PACKAGE_PIN B5 [get_ports {ethTxN}]
set_property PACKAGE_PIN A4 [get_ports {ethRxP}]
set_property PACKAGE_PIN A3 [get_ports {ethRxN}]

####################################
## Application Timing Constraints ##
####################################

#create_clock -period 5.405 -name jesdRefClk0 [get_ports {jesdClkP[0]}]
#create_clock -period 5.405 -name jesdRefClk1 [get_ports {jesdClkP[1]}]
create_clock -period 5.698 -name jesdRefClk0 [get_ports {jesdClkP[0]}]
create_clock -period 5.698 -name jesdRefClk1 [get_ports {jesdClkP[1]}]

create_clock -period 6.400 -name pgpRefClk   [get_ports {rtmPgpClkP}]

create_generated_clock -name jesd0_185MHz   [get_pins {U_App/GEN_AMC[0]/U_AMC/U_ClockManager/MmcmGen.U_Mmcm/CLKOUT0}]
create_generated_clock -name jesd1_185MHz   [get_pins {U_App/GEN_AMC[1]/U_AMC/U_ClockManager/MmcmGen.U_Mmcm/CLKOUT0}]
create_generated_clock -name jesd0_370MHz   [get_pins {U_App/GEN_AMC[0]/U_AMC/U_ClockManager/MmcmGen.U_Mmcm/CLKOUT1}]
create_generated_clock -name jesd1_370MHz   [get_pins {U_App/GEN_AMC[1]/U_AMC/U_ClockManager/MmcmGen.U_Mmcm/CLKOUT1}]

set_clock_groups -asynchronous -group [get_clocks {fabClk}] -group [get_clocks {jesdRefClk0}]
set_clock_groups -asynchronous -group [get_clocks {fabClk}] -group [get_clocks {jesdRefClk1}] 
set_clock_groups -asynchronous -group [get_clocks {fabClk}] -group [get_clocks {jesd0_185MHz}] 
set_clock_groups -asynchronous -group [get_clocks {fabClk}] -group [get_clocks {jesd1_185MHz}]
set_clock_groups -asynchronous -group [get_clocks {fabClk}] -group [get_clocks {jesd0_370MHz}]
set_clock_groups -asynchronous -group [get_clocks {fabClk}] -group [get_clocks {jesd1_370MHz}]  

set_clock_groups -asynchronous -group [get_clocks {ddrIntClk0}]   -group [get_clocks {jesd0_185MHz}]
set_clock_groups -asynchronous -group [get_clocks {ddrIntClk0}]   -group [get_clocks {jesd1_185MHz}]
set_clock_groups -asynchronous -group [get_clocks {axilClk}]      -group [get_clocks {jesd0_185MHz}]
set_clock_groups -asynchronous -group [get_clocks {axilClk}]      -group [get_clocks {jesd1_185MHz}]
set_clock_groups -asynchronous -group [get_clocks {axilClk}]      -group [get_clocks {jesd1_370MHz}]
set_clock_groups -asynchronous -group [get_clocks {jesd0_185MHz}] -group [get_clocks {jesd1_370MHz}]
set_clock_groups -asynchronous -group [get_clocks {jesd1_185MHz}] -group [get_clocks {jesd1_370MHz}]
set_clock_groups -asynchronous -group [get_clocks {jesd0_185MHz}] -group [get_clocks {jesd1_185MHz}]

set_clock_groups -asynchronous -group [get_clocks {ddrIntClk0}] -group [get_clocks {jesd0_185MHz}] 
set_clock_groups -asynchronous -group [get_clocks {ddrIntClk0}] -group [get_clocks {jesd1_185MHz}]

# 1Gb Ethernet clock constraints
create_generated_clock -name ethClk125MHz  [get_pins {U_Core/U_Eth/GEN_1GigE.U_1GigE/U_MMCM/MmcmGen.U_Mmcm/CLKOUT0}] 
create_generated_clock -name ethClk62p5MHz [get_pins {U_Core/U_Eth/GEN_1GigE.U_1GigE/U_MMCM/MmcmGen.U_Mmcm/CLKOUT1}] 
set_clock_groups -asynchronous -group [get_clocks {xauiRef}] -group [get_clocks {ethClk125MHz}] 
set_clock_groups -asynchronous -group [get_clocks {xauiRef}] -group [get_clocks {ethClk62p5MHz}] 
set_clock_groups -asynchronous -group [get_clocks {axilClk}] -group [get_clocks {ethClk125MHz}] 
set_clock_groups -asynchronous -group [get_clocks {axilClk}] -group [get_clocks {ethClk62p5MHz}] 
set_clock_groups -asynchronous -group [get_clocks {axilClk}] -group [get_clocks {xauiRef}] 