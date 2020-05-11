##############################################################################
## This file is part of 'SMURF PCIE'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'SMURF PCIE', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################

set_property USER_SLR_ASSIGNMENT SLR0 [get_cells {U_Core}]
set_property USER_SLR_ASSIGNMENT SLR0 [get_cells {U_ExtendedCore}]

set_property USER_SLR_ASSIGNMENT SLR1 [get_cells {U_Hardware/GEN_LANE[0].U_Lane}]
set_property USER_SLR_ASSIGNMENT SLR1 [get_cells {U_Hardware/GEN_LANE[1].U_Lane}]
set_property USER_SLR_ASSIGNMENT SLR1 [get_cells {U_Hardware/GEN_LANE[2].U_Lane}]
set_property USER_SLR_ASSIGNMENT SLR1 [get_cells {U_Hardware/GEN_LANE[3].U_Lane}]
set_property USER_SLR_ASSIGNMENT SLR0 [get_cells {U_Hardware/GEN_LANE[4].U_Lane}]
set_property USER_SLR_ASSIGNMENT SLR0 [get_cells {U_Hardware/GEN_LANE[5].U_Lane}]

set_property USER_SLR_ASSIGNMENT SLR1 [get_cells {U_Hardware/GEN_VEC[0].U_Buffer}]
set_property USER_SLR_ASSIGNMENT SLR1 [get_cells {U_Hardware/GEN_VEC[1].U_Buffer}]
set_property USER_SLR_ASSIGNMENT SLR0 [get_cells {U_Hardware/GEN_VEC[2].U_Buffer}]

set_clock_groups -asynchronous -group [get_clocks qsfp0RefClkP0] -group [get_clocks -of_objects [get_pins {U_Hardware/U_EthPhyMac/U_QSFP0/GEN_LANE[*].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]]
set_clock_groups -asynchronous -group [get_clocks qsfp1RefClkP0] -group [get_clocks -of_objects [get_pins {U_Hardware/U_EthPhyMac/U_QSFP1/GEN_LANE[*].TenGigEthGthUltraScale_Inst/U_TenGigEthRst/CLK156_BUFG_GT/O}]]

set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins U_axilClk/MmcmGen.U_Mmcm/CLKOUT0]] -group [get_clocks -of_objects [get_pins U_axilClk/MmcmGen.U_Mmcm/CLKOUT1]] -group [get_clocks -of_objects [get_pins U_Mig/U_Mig0/U_MIG/inst/u_ddr4_infrastructure/gen_mmcme3.u_mmcme_adv_inst/CLKOUT0]]
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins U_axilClk/MmcmGen.U_Mmcm/CLKOUT0]] -group [get_clocks -of_objects [get_pins U_axilClk/MmcmGen.U_Mmcm/CLKOUT1]] -group [get_clocks -of_objects [get_pins U_Mig/U_Mig1/U_MIG/inst/u_ddr4_infrastructure/gen_mmcme3.u_mmcme_adv_inst/CLKOUT0]]
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins U_axilClk/MmcmGen.U_Mmcm/CLKOUT0]] -group [get_clocks -of_objects [get_pins U_axilClk/MmcmGen.U_Mmcm/CLKOUT1]] -group [get_clocks -of_objects [get_pins U_Mig/U_Mig2/U_MIG/inst/u_ddr4_infrastructure/gen_mmcme3.u_mmcme_adv_inst/CLKOUT0]]
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins U_axilClk/MmcmGen.U_Mmcm/CLKOUT0]] -group [get_clocks -of_objects [get_pins U_axilClk/MmcmGen.U_Mmcm/CLKOUT1]] -group [get_clocks -of_objects [get_pins U_Mig/U_Mig3/U_MIG/inst/u_ddr4_infrastructure/gen_mmcme3.u_mmcme_adv_inst/CLKOUT0]]

set_property HIGH_PRIORITY true [get_nets {U_axilClk/clkOut[0]}]
set_property HIGH_PRIORITY true [get_nets {U_axilClk/clkOut[1]}]
set_property HIGH_PRIORITY true [get_nets {ddrClk[0]}]
set_property HIGH_PRIORITY true [get_nets {ddrClk[1]}]
set_property HIGH_PRIORITY true [get_nets {ddrClk[2]}]

