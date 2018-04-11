# Load RUCKUS library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

if { [info exists ::env(CRYO_DET_TYPE)] != 1 } {
   puts "\n\nERROR: CRYO_DET_TYPE is not defined in $::env(PROJ_DIR)/Makefile\n\n"; exit -1
}

# Load Source Code
loadRuckusTcl "$::DIR_PATH/AppCore"
loadRuckusTcl "$::DIR_PATH/../DspCoreLib/$::env(CRYO_DET_TYPE)"

set_property strategy Performance_ExplorePostRoutePhysOpt [get_runs impl_1]

set_property STEPS.POWER_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
set_property STEPS.POST_PLACE_POWER_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]

set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY rebuilt [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.RETIMING          on      [get_runs synth_1]
