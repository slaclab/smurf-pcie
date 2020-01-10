# Load RUCKUS library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load Source Code
loadSource -dir "$::DIR_PATH/rtl"
loadIpCore -dir "$::DIR_PATH/ip"

# Load Simulation
loadSource -sim_only -dir "$::DIR_PATH/tb"
set_property top {UdpLargeDataBufferTb} [get_filesets sim_1]
