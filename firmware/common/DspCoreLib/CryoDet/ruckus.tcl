############################
# DO NOT EDIT THE CODE BELOW
############################

# Load RUCKUS environment and library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load target's source code and constraints
loadSource -dir  "$::DIR_PATH/rtl/"
loadSource -path "$::DIR_PATH/simulink/netlist/dspcore.dcp"

# Force synth_1 to be stale between runs incase the sysgen .DCP file changes ( work around for a bug in Vivado)
exec touch [get_files {DspCoreWrapper.vhd}]
