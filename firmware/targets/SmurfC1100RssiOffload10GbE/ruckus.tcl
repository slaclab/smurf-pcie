# Load RUCKUS environment and library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load common and sub-module ruckus.tcl files
loadRuckusTcl $::env(TOP_DIR)/submodules/surf
loadRuckusTcl $::env(TOP_DIR)/submodules/axi-pcie-core/hardware/XilinxVariumC1100
loadRuckusTcl $::env(TOP_DIR)/submodules/axi-pcie-core/hardware/XilinxVariumC1100/pcie-extended
loadRuckusTcl $::env(TOP_DIR)/common/C1100

# Load local source Code and constraints
loadSource      -dir "$::DIR_PATH/hdl"
loadConstraints -dir "$::DIR_PATH/hdl"
