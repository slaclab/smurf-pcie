##############################################################################
## This file is part of 'SMURF PCIE'.
## It is subject to the license terms in the LICENSE.txt file found in the
## top-level directory of this distribution and at:
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
## No part of 'SMURF PCIE', including this file,
## may be copied, modified, propagated, or distributed except according to
## the terms contained in the LICENSE.txt file.
##############################################################################

#######################
# Placement Constraints
#######################

set_property USER_SLR_ASSIGNMENT SLR1 [get_cells {U_Hardware}]
set_property USER_SLR_ASSIGNMENT SLR0 [get_cells {U_HbmDmaBuffer}]
set_property USER_SLR_ASSIGNMENT SLR0 [get_cells {U_Core/U_AxiPcieDma/REAL_PCIE.U_V2Gen}]
set_property USER_SLR_ASSIGNMENT SLR0 [get_cells {U_Core/U_AxiPcieDma/REAL_PCIE.U_XBAR}]

# SLR1: Left Side = NORTH_WEST_GRP (region defined in XilinxAlveoU55cCore.xdc)

# SLR1: Right Side = NORTH_EAST_GRP (region defined in XilinxAlveoU55cCore.xdc)

# SLR0: Left Side = SOUTH_WEST_GRP (region defined in XilinxAlveoU55cCore.xdc)
add_cells_to_pblock [get_pblocks SOUTH_WEST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[0].U_AxiFifo]]
add_cells_to_pblock [get_pblocks SOUTH_WEST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[1].U_AxiFifo]]
add_cells_to_pblock [get_pblocks SOUTH_WEST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[2].U_AxiFifo]]
add_cells_to_pblock [get_pblocks SOUTH_WEST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[3].U_AxiFifo]]

add_cells_to_pblock [get_pblocks SOUTH_WEST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[0].U_HbmAxiFifo]]
add_cells_to_pblock [get_pblocks SOUTH_WEST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[1].U_HbmAxiFifo]]
add_cells_to_pblock [get_pblocks SOUTH_WEST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[2].U_HbmAxiFifo]]
add_cells_to_pblock [get_pblocks SOUTH_WEST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[3].U_HbmAxiFifo]]

# SLR0: Right Side = SOUTH_EAST_GRP (region defined in XilinxAlveoU55cCore.xdc)
add_cells_to_pblock [get_pblocks SOUTH_EAST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[4].U_AxiFifo]]
add_cells_to_pblock [get_pblocks SOUTH_EAST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[5].U_AxiFifo]]
add_cells_to_pblock [get_pblocks SOUTH_EAST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[6].U_AxiFifo]]
add_cells_to_pblock [get_pblocks SOUTH_EAST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[7].U_AxiFifo]]

add_cells_to_pblock [get_pblocks SOUTH_EAST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[4].U_HbmAxiFifo]]
add_cells_to_pblock [get_pblocks SOUTH_EAST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[5].U_HbmAxiFifo]]
add_cells_to_pblock [get_pblocks SOUTH_EAST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[6].U_HbmAxiFifo]]
add_cells_to_pblock [get_pblocks SOUTH_EAST_GRP] [get_cells [list U_HbmDmaBuffer/GEN_FIFO[7].U_HbmAxiFifo]]

######################
# Timing Constraints #
######################

set_property HIGH_PRIORITY true [get_nets {U_axilClk/clkOut[0]}]

set_clock_groups -asynchronous -group [get_clocks qsfp0RefClkP] \
                               -group [get_clocks -of_objects [get_pins {U_Hardware/U_EthPhyMac/U_QSFP0/GEN_LANE[*].TenGigEthGtyUltraScale_Inst/U_TenGigEthGtyUltraScaleCore/inst/i_TenGigEthGtyUltraScale156p25MHzCore_gt/inst/gen_gtwizard_gtye4_top.TenGigEthGtyUltraScale156p25MHzCore_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[1].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]] \
                               -group [get_clocks -of_objects [get_pins {U_Hardware/U_EthPhyMac/U_QSFP0/GEN_LANE[*].TenGigEthGtyUltraScale_Inst/U_TenGigEthGtyUltraScaleCore/inst/i_TenGigEthGtyUltraScale156p25MHzCore_gt/inst/gen_gtwizard_gtye4_top.TenGigEthGtyUltraScale156p25MHzCore_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[1].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] \
                               -group [get_clocks -of_objects [get_pins {U_Hardware/U_EthPhyMac/U_QSFP0/GEN_LANE[*].TenGigEthGtyUltraScale_Inst/U_TenGigEthGtyUltraScaleCore/inst/i_TenGigEthGtyUltraScale156p25MHzCore_gt/inst/gen_gtwizard_gtye4_top.TenGigEthGtyUltraScale156p25MHzCore_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[1].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]]

set_clock_groups -asynchronous -group [get_clocks qsfp1RefClkP] \
                               -group [get_clocks -of_objects [get_pins {U_Hardware/U_EthPhyMac/U_QSFP1/GEN_LANE[*].TenGigEthGtyUltraScale_Inst/U_TenGigEthGtyUltraScaleCore/inst/i_TenGigEthGtyUltraScale156p25MHzCore_gt/inst/gen_gtwizard_gtye4_top.TenGigEthGtyUltraScale156p25MHzCore_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[1].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]] \
                               -group [get_clocks -of_objects [get_pins {U_Hardware/U_EthPhyMac/U_QSFP1/GEN_LANE[*].TenGigEthGtyUltraScale_Inst/U_TenGigEthGtyUltraScaleCore/inst/i_TenGigEthGtyUltraScale156p25MHzCore_gt/inst/gen_gtwizard_gtye4_top.TenGigEthGtyUltraScale156p25MHzCore_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[1].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] \
                               -group [get_clocks -of_objects [get_pins {U_Hardware/U_EthPhyMac/U_QSFP1/GEN_LANE[*].TenGigEthGtyUltraScale_Inst/U_TenGigEthGtyUltraScaleCore/inst/i_TenGigEthGtyUltraScale156p25MHzCore_gt/inst/gen_gtwizard_gtye4_top.TenGigEthGtyUltraScale156p25MHzCore_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[1].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLKPCS}]]
