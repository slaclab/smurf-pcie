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
SetDebugCoreClk ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/appClk}

#######################
## Set the debug Probes
#######################

ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/appRst}

ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/ibMaster[tValid]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/ibMaster[tUser][1]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/ibMaster[tData][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/ibMaster[tKeep][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/ibMaster[tLast]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/ibSlave[tReady]}

ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/obMaster[tValid]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/obMaster[tUser][1]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/obMaster[tData][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/obMaster[tKeep][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/obMaster[tLast]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/obSlave[tReady]}

ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMaster[tValid]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMaster[tUser][1]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMaster[tData][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMaster[tKeep][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMaster[tLast]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxSlave[tReady]}

ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMaster[tValid]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMaster[tUser][1]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMaster[tData][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMaster[tKeep][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMaster[tLast]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txSlave[tReady]}

ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[0][tValid]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[0][tUser][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[0][tData][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[0][tKeep][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[0][tLast]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxSlaves[0][tReady]}

ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[0][tValid]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[0][tUser][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[0][tData][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[0][tKeep][*]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[0][tLast]}
ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txSlaves[0][tReady]}

# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[1][tValid]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[1][tUser][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[1][tKeep][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[1][tLast]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxSlaves[1][tReady]}

# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[2][tValid]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[2][tUser][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[2][tKeep][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[2][tLast]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxSlaves[2][tReady]}

# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[3][tValid]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[3][tUser][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[3][tKeep][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[3][tLast]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxSlaves[3][tReady]}

# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[4][tValid]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[4][tUser][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[4][tKeep][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[4][tLast]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxSlaves[4][tReady]}

# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[5][tValid]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[5][tUser][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[5][tKeep][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxMasters[5][tLast]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/rxSlaves[5][tReady]}



# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[1][tValid]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[1][tUser][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[1][tKeep][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[1][tLast]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txSlaves[1][tReady]}

# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[2][tValid]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[2][tUser][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[2][tKeep][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[2][tLast]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txSlaves[2][tReady]}

# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[3][tValid]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[3][tUser][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[3][tKeep][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[3][tLast]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txSlaves[3][tReady]}

# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[4][tValid]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[4][tUser][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[4][tKeep][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[4][tLast]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txSlaves[4][tReady]}

# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[5][tValid]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[5][tUser][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[5][tKeep][*]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txMasters[5][tLast]}
# ConfigProbe ${ilaName} {U_Application/GEN_VEC[0].GEN_LANE.U_Lane/GEN_PACKER[0].U_PackerV2/txSlaves[5][tReady]}

##########################
## Write the port map file
##########################
WriteDebugProbes ${ilaName} 
