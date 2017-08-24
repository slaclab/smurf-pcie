# Load RUCKUS library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load Source Code
loadRuckusTcl "$::DIR_PATH/AppCore"
loadRuckusTcl "$::DIR_PATH/../DspCoreLib/MicrowaveMux"