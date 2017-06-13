# Load RUCKUS environment and library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load local Source Code and constraints
loadSource      -dir  "$::DIR_PATH/rtl/"
loadConstraints -dir  "$::DIR_PATH/xdc/"

loadSource      -path "$::DIR_PATH/coregen/JesdCryoCoreLeftColumn/JesdCryoCoreLeftColumn.dcp"
#loadIpCore      -path "$::DIR_PATH/coregen/JesdCryoCoreLeftColumn/JesdCryoCoreLeftColumn.xci"

loadSource      -path "$::DIR_PATH/coregen/JesdCryoCoreRightColumn/JesdCryoCoreRightColumn.dcp"
#loadIpCore      -path "$::DIR_PATH/coregen/JesdCryoCoreRightColumn/JesdCryoCoreRightColumn.xci"
