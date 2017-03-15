# Load RUCKUS environment and library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load local Source Code and constraints
loadSource      -dir  "$::DIR_PATH/hdl/"

#loadSource      -path "$::DIR_PATH/coregen/KcuJesd204bCoregen.dcp"
loadSource    -path "$::DIR_PATH/coregen/KcuJesd204bCoregen.xci"
