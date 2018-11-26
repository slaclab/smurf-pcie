# Load RUCKUS environment and library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load common and sub-module ruckus.tcl files
loadRuckusTcl $::env(PROJ_DIR)/../../submodules/surf
loadRuckusTcl $::env(PROJ_DIR)/../../submodules/axi-pcie-core
loadRuckusTcl $::env(PROJ_DIR)/../../common/kcu1500

# Load local source Code and constraints
loadSource      -dir "$::DIR_PATH/hdl"
loadConstraints -dir "$::DIR_PATH/hdl"


set_property STEPS.POWER_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
set_property STEPS.POST_PLACE_POWER_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
