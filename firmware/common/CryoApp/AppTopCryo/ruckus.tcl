# Load RUCKUS environment and library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load local Source Code and constraints
loadSource      -dir  "$::DIR_PATH/rtl/"


loadSource      -path "$::DIR_PATH/coregen/AppTopJesd204bCoregenCryo.dcp"
#loadSource    -path "$::DIR_PATH/coregen/AppTopJesd204bCoregenCryo.xci"
