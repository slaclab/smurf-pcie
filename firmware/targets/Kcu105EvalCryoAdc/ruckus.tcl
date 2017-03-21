############################
# DO NOT EDIT THE CODE BELOW
############################

# Load RUCKUS environment and library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load submodules' code and constraints
loadRuckusTcl $::env(TOP_DIR)/submodules

# Load target's source code and constraints
loadSource      -dir  "$::DIR_PATH/hdl/"
loadConstraints -dir  "$::DIR_PATH/hdl/"

#Remove unused constraints
remove_files  -fileset constrs_1 $::env(TOP_DIR)/submodules/amc-carrier-core/AmcCarrierCore/xdc/AmcCarrierCorePlacement.xdc
remove_files  -fileset constrs_1 $::env(TOP_DIR)/submodules/amc-carrier-core/AmcCarrierCore/xdc/AmcCarrierAppPorts.xdc
remove_files  -fileset constrs_1 $::env(TOP_DIR)/submodules/amc-carrier-core/AppTop/xdc/AppTop.xdc
remove_files  -fileset constrs_1 $::env(TOP_DIR)/submodules/amc-carrier-core/AppHardware/AmcEmpty/xdc/AmcEmptyBay0Pinout.xdc
remove_files  -fileset constrs_1 $::env(TOP_DIR)/submodules/amc-carrier-core/AppHardware/AmcEmpty/xdc/AmcEmptyBay1Pinout.xdc