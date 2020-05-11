# Load RUCKUS library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load Source Code
loadSource -dir "$::DIR_PATH/rtl"

# Load Simulation
loadSource -sim_only -dir "$::DIR_PATH/tb"
set_property top {UdpLargeDataBufferTb} [get_filesets sim_1]

set_property strategy Performance_ExplorePostRoutePhysOpt [get_runs impl_1]
