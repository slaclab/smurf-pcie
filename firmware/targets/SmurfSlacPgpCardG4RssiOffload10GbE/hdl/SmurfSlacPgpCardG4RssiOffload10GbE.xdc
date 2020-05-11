##############################################################################
## This file is part of 'SMURF PCIE'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'SMURF PCIE', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################

set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins U_axilClk/PllGen.U_Pll/CLKOUT0]] -group [get_clocks -of_objects [get_pins U_Core/REAL_PCIE.U_AxiPciePhy/U_AxiPcie/inst/pcie3_ip_i/U0/gt_top_i/phy_clk_i/bufg_gt_userclk/O]]

set_clock_groups -asynchronous -group [get_clocks qsfpRefClkP] -group [get_clocks -of_objects [get_pins {U_Hardware/U_EthPhyMac/U_QSFP0/GEN_LANE[*].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]]
set_clock_groups -asynchronous -group [get_clocks qsfpRefClkP] -group [get_clocks -of_objects [get_pins {U_Hardware/U_EthPhyMac/U_QSFP1/GEN_LANE[*].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]]
