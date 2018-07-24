##############################################################################
## This file is part of 'SLAC PGP Gen3 Card'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'SLAC PGP Gen3 Card', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################

create_generated_clock -name ethClk125MHz  [get_pins {U_Hardware/U_EthPhyMac/U_MMCM/MmcmGen.U_Mmcm/CLKOUT0}] 
create_generated_clock -name ethClk62p5MHz [get_pins {U_Hardware/U_EthPhyMac/U_MMCM/MmcmGen.U_Mmcm/CLKOUT1}] 

set_clock_groups -asynchronous -group [get_clocks {qsfp0RefClkP0}] -group [get_clocks {ethClk125MHz}] 
set_clock_groups -asynchronous -group [get_clocks {qsfp0RefClkP0}] -group [get_clocks {ethClk62p5MHz}] 

# create_generated_clock -name ethRxClk0 [get_pins {U_Hardware/U_10GigE_0/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_TenGigEthGthUltraScaleCore/U0/TenGigEthGthUltraScale156p25MHzCore_local_clock_reset_block/rxusrclk2_bufg_gt_i/O}]
# create_generated_clock -name ethRxClk1 [get_pins {U_Hardware/U_10GigE_0/GEN_LANE[1].TenGigEthGthUltraScale_Inst/U_TenGigEthGthUltraScaleCore/U0/TenGigEthGthUltraScale156p25MHzCore_local_clock_reset_block/rxusrclk2_bufg_gt_i/O}]
# create_generated_clock -name ethRxClk2 [get_pins {U_Hardware/U_10GigE_0/GEN_LANE[2].TenGigEthGthUltraScale_Inst/U_TenGigEthGthUltraScaleCore/U0/TenGigEthGthUltraScale156p25MHzCore_local_clock_reset_block/rxusrclk2_bufg_gt_i/O}]
# create_generated_clock -name ethRxClk3 [get_pins {U_Hardware/U_10GigE_0/GEN_LANE[3].TenGigEthGthUltraScale_Inst/U_TenGigEthGthUltraScaleCore/U0/TenGigEthGthUltraScale156p25MHzCore_local_clock_reset_block/rxusrclk2_bufg_gt_i/O}]

# create_generated_clock -name ethRxClk4 [get_pins {U_Hardware/U_10GigE_1/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_TenGigEthGthUltraScaleCore/U0/TenGigEthGthUltraScale156p25MHzCore_local_clock_reset_block/rxusrclk2_bufg_gt_i/O}]
# create_generated_clock -name ethRxClk5 [get_pins {U_Hardware/U_10GigE_1/GEN_LANE[1].TenGigEthGthUltraScale_Inst/U_TenGigEthGthUltraScaleCore/U0/TenGigEthGthUltraScale156p25MHzCore_local_clock_reset_block/rxusrclk2_bufg_gt_i/O}]
# create_generated_clock -name ethRxClk6 [get_pins {U_Hardware/U_10GigE_1/GEN_LANE[2].TenGigEthGthUltraScale_Inst/U_TenGigEthGthUltraScaleCore/U0/TenGigEthGthUltraScale156p25MHzCore_local_clock_reset_block/rxusrclk2_bufg_gt_i/O}]
# create_generated_clock -name ethRxClk7 [get_pins {U_Hardware/U_10GigE_1/GEN_LANE[3].TenGigEthGthUltraScale_Inst/U_TenGigEthGthUltraScaleCore/U0/TenGigEthGthUltraScale156p25MHzCore_local_clock_reset_block/rxusrclk2_bufg_gt_i/O}]

# create_generated_clock -name ethTxClk0 [get_pins {U_Hardware/U_10GigE_0/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]
# create_generated_clock -name ethTxClk1 [get_pins {U_Hardware/U_10GigE_0/GEN_LANE[1].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]
# create_generated_clock -name ethTxClk2 [get_pins {U_Hardware/U_10GigE_0/GEN_LANE[2].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]
# create_generated_clock -name ethTxClk3 [get_pins {U_Hardware/U_10GigE_0/GEN_LANE[3].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]

# create_generated_clock -name ethTxClk4 [get_pins {U_Hardware/U_10GigE_1/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]
# create_generated_clock -name ethTxClk5 [get_pins {U_Hardware/U_10GigE_1/GEN_LANE[1].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]
# create_generated_clock -name ethTxClk6 [get_pins {U_Hardware/U_10GigE_1/GEN_LANE[2].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]
# create_generated_clock -name ethTxClk7 [get_pins {U_Hardware/U_10GigE_1/GEN_LANE[3].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]

# set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks {qsfp0RefClkP0}] -group [get_clocks -include_generated_clocks {userClkP}] -group [get_clocks ethTxClk0] -group [get_clocks ethRxClk0]
# set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks {qsfp0RefClkP0}] -group [get_clocks -include_generated_clocks {userClkP}] -group [get_clocks ethTxClk1] -group [get_clocks ethRxClk1]
# set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks {qsfp0RefClkP0}] -group [get_clocks -include_generated_clocks {userClkP}] -group [get_clocks ethTxClk2] -group [get_clocks ethRxClk2]
# set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks {qsfp0RefClkP0}] -group [get_clocks -include_generated_clocks {userClkP}] -group [get_clocks ethTxClk3] -group [get_clocks ethRxClk3]

# set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks {qsfp1RefClkP0}] -group [get_clocks -include_generated_clocks {userClkP}] -group [get_clocks ethTxClk4] -group [get_clocks ethRxClk4]
# set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks {qsfp1RefClkP0}] -group [get_clocks -include_generated_clocks {userClkP}] -group [get_clocks ethTxClk5] -group [get_clocks ethRxClk5]
# set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks {qsfp1RefClkP0}] -group [get_clocks -include_generated_clocks {userClkP}] -group [get_clocks ethTxClk6] -group [get_clocks ethRxClk6]
# set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks {qsfp1RefClkP0}] -group [get_clocks -include_generated_clocks {userClkP}] -group [get_clocks ethTxClk7] -group [get_clocks ethRxClk7]
