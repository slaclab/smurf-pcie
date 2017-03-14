##############################################################################
## This file is part of 'LCLS2 MPS Firmware'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'LCLS2 MPS Firmware', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################

##############################
# Get variables and procedures
##############################
source -quiet $::env(RUCKUS_DIR)/vivado_env_var.tcl
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

############################
## Open the synthesis design
############################
open_run synth_1

###############################
## Set the name of the ILA core
###############################
set clk250 u_ila_0

##################
## Create the core
##################
CreateDebugCore ${clk250}

#######################
## Set the record depth
#######################
set_property C_DATA_DEPTH 2048 [get_debug_cores ${clk250}]

#################################
## Set the clock for the ILA core
#################################
SetDebugCoreClk ${clk250} {U_Central/U_MpsAppTimeout/clk}

#######################
## Set the debug Probes
#######################

#ConfigProbe ${ilaName} {[*]}
ConfigProbe ${clk250} {U_Central/GEN_VEC[0].U_MpsMessageRx/mpsMessage[valid]}
ConfigProbe ${clk250} {U_Central/GEN_VEC[0].U_MpsMessageRx/mpsMessage[inputType]}
ConfigProbe ${clk250} {U_Central/GEN_VEC[0].U_MpsMessageRx/mpsMessage[appId][*]}
ConfigProbe ${clk250} {U_Central/GEN_VEC[0].U_MpsMessageRx/mpsMessage[message][0][*]}
ConfigProbe ${clk250} {U_Central/GEN_VEC[0].U_MpsMessageRx/mpsMessage[message][1][*]}
ConfigProbe ${clk250} {U_Central/GEN_VEC[0].U_MpsMessageRx/mpsMessage[message][2][*]}
ConfigProbe ${clk250} {U_Central/GEN_VEC[0].U_MpsMessageRx/mpsMessage[message][3][*]}
ConfigProbe ${clk250} {U_Central/GEN_VEC[0].U_MpsMessageRx/mpsMessage[message][4][*]}
ConfigProbe ${clk250} {U_Central/GEN_VEC[0].U_MpsMessageRx/mpsMessage[message][5][*]}
ConfigProbe ${clk250} {U_Central/GEN_VEC[0].U_MpsMessageRx/mpsMessage[message][6][*]}
ConfigProbe ${clk250} {U_Central/GEN_VEC[0].U_MpsMessageRx/mpsMessage[message][7][*]}

ConfigProbe ${clk250} {U_Central/U_MpsAppTimeout/s_timestamp[0][*]}
ConfigProbe ${clk250} {U_Central/U_MpsAppTimeout/mpsMessage_i[0][valid]}
ConfigProbe ${clk250} {U_Central/U_MpsAppTimeout/mpsMessage_i[0][appId][*]}
ConfigProbe ${clk250} {U_Central/U_MpsAppTimeout/mpsMessage_i[0][timeStamp][*]}

#################################


ConfigProbe ${clk250} {U_Central/U_MpsSwUpdateEngine/U_StreamOut/sAxisMaster[tData][*]}
ConfigProbe ${clk250} {U_Central/U_MpsSwUpdateEngine/U_StreamOut/sAxisMaster[tUser][*]}
ConfigProbe ${clk250} {U_Central/U_MpsSwUpdateEngine/U_StreamOut/sAxisMaster[tLast]}
ConfigProbe ${clk250} {U_Central/U_MpsSwUpdateEngine/U_StreamOut/sAxisMaster[tValid]}
ConfigProbe ${clk250} {U_Central/U_MpsSwUpdateEngine/U_StreamOut/sAxisCtrl[pause]}
ConfigProbe ${clk250} {U_Central/U_MpsSwUpdateEngine/U_StreamOut/sAxisCtrl[overflow]}
ConfigProbe ${clk250} {U_Central/U_MpsSwUpdateEngine/pulse1MHz_i}
ConfigProbe ${clk250} {U_Central/U_MpsSwUpdateEngine/pulse360Hz_i}
ConfigProbe ${clk250} {U_Central/U_MpsSwUpdateEngine/statRegister_o[swBusy]}
ConfigProbe ${clk250} {U_Central/U_MpsSwUpdateEngine/statRegister_o[swLossErr]}

##########################
## Write the port map file
##########################
WriteDebugProbes ${clk250} ${PROJ_DIR}/images/debug_probes.ltx

# delete_debug_port [get_debug_ports [GetCurrentProbe ${clk250}]]
# write_debug_probes -force $::env(PROJ_DIR)/debug_probes.ltx


