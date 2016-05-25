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

set_property PACKAGE_PIN B6 [get_ports {ethTxP}]
set_property PACKAGE_PIN B5 [get_ports {ethTxN}]
set_property PACKAGE_PIN A4 [get_ports {ethRxP}]
set_property PACKAGE_PIN A3 [get_ports {ethRxN}]

####################################
## Application Timing Constraints ##
####################################

create_generated_clock -name ethPhyClk [get_pins {U_Core/U_Eth/U_10GigE/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]

set_clock_groups -asynchronous -group [get_clocks {axilClk}] -group [get_clocks {ethPhyClk}] 
set_clock_groups -asynchronous -group [get_clocks {axilClk}] -group [get_clocks {xauiRef}] 

create_clock -period 5.405 -name jesdRefClk0 [get_ports {jesdClkP[0]}]
create_clock -period 5.405 -name jesdRefClk1 [get_ports {jesdClkP[1]}]

create_clock -period 6.400 -name pgpRefClk   [get_ports {rtmPgpClkP}]

create_generated_clock -name jesd0_185MHz   [get_pins {U_App/U_AMC0/U_ClockManager/MmcmGen.U_Mmcm/CLKOUT0}]
create_generated_clock -name jesd1_185MHz   [get_pins {U_App/U_AMC1/U_ClockManager/MmcmGen.U_Mmcm/CLKOUT0}]
create_generated_clock -name jesd1_370MHz   [get_pins {U_App/U_AMC1/U_ClockManager/MmcmGen.U_Mmcm/CLKOUT1}]
create_generated_clock -name tapClk_277MHz  [get_pins {U_App/U_AMC1/U_ClockManager/MmcmGen.U_Mmcm/CLKOUT2}]

set_clock_groups -asynchronous -group [get_clocks {fabClk}] -group [get_clocks {jesdRefClk0}]
set_clock_groups -asynchronous -group [get_clocks {fabClk}] -group [get_clocks {jesdRefClk1}] 
set_clock_groups -asynchronous -group [get_clocks {fabClk}] -group [get_clocks {jesd0_185MHz}] 
set_clock_groups -asynchronous -group [get_clocks {fabClk}] -group [get_clocks {jesd1_185MHz}]
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
set_clock_groups -asynchronous -group [get_clocks {tapClk_277MHz}] -group [get_clocks {jesd1_370MHz}]

##########################
## Misc. Configurations ##
##########################
