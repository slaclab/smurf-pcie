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
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[state][*]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[addr][*]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[tid][*]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[tidDly][*]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[reqSize][*]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[memResp][*]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[timeout]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[eofe]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[frameError]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[verMismatch]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[reqSizeError]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[ignoreMemResp]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[rxRst]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[overflowDet]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/r[skip]}

ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/rxTLastTUser[*]}

ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/axisMaster[tLast]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/axisMaster[tValid]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/axisMaster[tUser][0]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/axisMaster[tUser][1]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/axisSlave[tReady]}

ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/sCtrl[overflow]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/rxCtrl[overflow]}

ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/rxMaster[tLast]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/rxMaster[tValid]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/rxMaster[tUser][0]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/rxMaster[tUser][1]}
ConfigProbe ${ilaName} {U_Core/U_Core/U_Eth/U_RssiServer/U_SRPv3/rxSlave[tReady]}

##########################
## Write the port map file
##########################
WriteDebugProbes ${ilaName} ${PROJ_DIR}/images/debug_probes_${PRJ_VERSION}.ltx
