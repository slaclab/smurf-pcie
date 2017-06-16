##############################################################################
## This file is part of 'DUNE Development Firmware'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'DUNE Development Firmware', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################

##############################
# Get variables and procedures
##############################
source -quiet $::env(RUCKUS_DIR)/vivado_env_var.tcl
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Bypass the debug chipscope generation
return

############################
## Open the synthesis design
############################
open_run synth_1

###############################
## Set the name of the ILA core
###############################
set ilaName u_ila_0

##################
## Create the core
##################
CreateDebugCore ${ilaName}

#######################
## Set the record depth
#######################
set_property C_DATA_DEPTH 1024 [get_debug_cores ${ilaName}]

#################################
## Set the clock for the ILA core
#################################
SetDebugCoreClk ${ilaName} {U_AppTop/U_AmcBay[1].U_JesdCore/jesdClk}

#######################
## Set the debug Probes
#######################
ConfigProbe ${ilaName} {U_AppTop/U_AmcBay[1].U_JesdCore/adcValids[*]}
ConfigProbe ${ilaName} {U_AppTop/U_AmcBay[1].U_JesdCore/adcValues[0][*]}
ConfigProbe ${ilaName} {U_AppTop/U_AmcBay[1].U_JesdCore/adcValues[1][*]}
ConfigProbe ${ilaName} {U_AppTop/U_AmcBay[1].U_JesdCore/adcValues[2][*]}
ConfigProbe ${ilaName} {U_AppTop/U_AmcBay[1].U_JesdCore/adcValues[3][*]}


ConfigProbe ${ilaName} {U_AppTop/U_AmcBay[1].U_JesdCore/U_Jesd/EN_TX_CORE.U_Jesd204bTx/GEN_REG_I.GEN_LANE[0].s_regSampleDataIn_reg[0]__0[*]}
ConfigProbe ${ilaName} {U_AppTop/U_AmcBay[1].U_JesdCore/U_Jesd/EN_TX_CORE.U_Jesd204bTx/GEN_TX[0].U_JesdTxLane/sampleData_i[*]}

##########################
## Write the port map file
##########################
WriteDebugProbes ${ilaName} ${PROJ_DIR}/images/debug_probes_${PRJ_VERSION}.ltx
