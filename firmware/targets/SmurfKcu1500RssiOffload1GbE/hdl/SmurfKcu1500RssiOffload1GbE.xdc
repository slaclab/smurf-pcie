##############################################################################
## This file is part of 'SLAC PGP Gen3 Card'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'SLAC PGP Gen3 Card', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################

set_property USER_SLR_ASSIGNMENT SLR1 [get_cells {U_Hardware}]
set_property USER_SLR_ASSIGNMENT SLR0 [get_cells {U_Application}]

create_generated_clock -name ethClk125MHz  [get_pins {U_Hardware/U_EthPhyMac/U_MMCM/MmcmGen.U_Mmcm/CLKOUT0}] 
create_generated_clock -name ethClk62p5MHz [get_pins {U_Hardware/U_EthPhyMac/U_MMCM/MmcmGen.U_Mmcm/CLKOUT1}] 

set_clock_groups -asynchronous -group [get_clocks {userClkP}] -group [get_clocks {ethClk125MHz}]  -group [get_clocks {qsfp0RefClkP0}] 
set_clock_groups -asynchronous -group [get_clocks {userClkP}] -group [get_clocks {qsfp1RefClkP0}] 
