##############################################################################
## This file is part of 'ATLAS RD53 DEV'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'ATLAS RD53 DEV', including this file, 
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
SetDebugCoreClk ${ilaName} {axilClk}

#######################
## Set the debug Probes
#######################

ConfigProbe ${ilaName} {axilRst}
ConfigProbe ${ilaName} {dmaRst}

ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/dmaObMaster[tDest][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/dmaObMaster[tValid]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/dmaObSlave[tReady]}

ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/appIbMaster[tDest][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/appIbMaster[tValid]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/appIbSlave[tReady]}

ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/rssiIbMasters[*][tDest][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/rssiIbMasters[*][tValid]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/rssiIbSlaves[*][tReady]}

ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/rssiObMasters[*][tDest][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/rssiObMasters[*][tValid]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/rssiObSlaves[*][tReady]}

ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/appObMaster[tDest][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/appObMaster[tValid]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/appObSlave[tReady]}

ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/dmaIbMaster[tDest][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/dmaIbMaster[tValid]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].U_Lane/dmaIbSlave[tReady]}


##########################
## Write the port map file
##########################
WriteDebugProbes ${ilaName} 
