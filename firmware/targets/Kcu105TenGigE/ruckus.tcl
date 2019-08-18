# Load RUCKUS environment and library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load common and sub-module ruckus.tcl files
loadRuckusTcl $::env(PROJ_DIR)/../../submodules/surf

# Load local source Code and constraints
loadSource      -dir "$::DIR_PATH/hdl"
loadConstraints -dir "$::DIR_PATH/hdl"

loadSource -path "$::DIR_PATH/ip/SystemManagementCore.dcp"
# loadIpCore  -path "$::DIR_PATH/ip/SystemManagementCore.xci" 

# Load local SIM source Code
#set_property top {RssiInterleaveTb} [get_filesets sim_1]
set_property top {EthMacTb} [get_filesets sim_1]

#set_property strategy Performance_ExplorePostRoutePhysOpt [get_runs impl_1]
