##############################################################################
## This file is part of 'SLAC PGP Gen3 Card'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'SLAC PGP Gen3 Card', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################

set_property USER_SLR_ASSIGNMENT SLR0 [get_cells {U_Core}]
set_property USER_SLR_ASSIGNMENT SLR1 [get_cells {U_Hardware}]

set_clock_groups -asynchronous -group [get_clocks qsfp0RefClkP0] -group [get_clocks -of_objects [get_pins {U_Hardware/U_EthPhyMac/U_QSFP0/GEN_LANE[*].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]]
set_clock_groups -asynchronous -group [get_clocks qsfp1RefClkP0] -group [get_clocks -of_objects [get_pins {U_Hardware/U_EthPhyMac/U_QSFP1/GEN_LANE[*].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]]
