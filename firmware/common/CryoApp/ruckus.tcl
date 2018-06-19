# Load RUCKUS library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

if { [info exists ::env(CRYO_DET_TYPE)] != 1 } {
   puts "\n\nERROR: CRYO_DET_TYPE is not defined in $::env(PROJ_DIR)/Makefile\n\n"; exit -1
}

# Load Source Code
loadRuckusTcl "$::DIR_PATH/AppCore"
loadRuckusTcl "$::DIR_PATH/../shared"
loadRuckusTcl "$::DIR_PATH/../DspCoreLib/$::env(CRYO_DET_TYPE)"
