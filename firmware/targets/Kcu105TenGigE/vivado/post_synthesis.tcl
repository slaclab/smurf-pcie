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
SetDebugCoreClk ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/ethClk}

#######################
## Set the debug Probes
#######################

ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/flowCtrl[pause]}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/ethStatus[txPauseCnt]}

ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/macMaster[tData][*]}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/macMaster[tKeep][*]}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/macMaster[tUser][*]}

ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/curState[*]}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/exportWordCnt[*]}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/intData[*]}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/intLastValidByte[*]}
# ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/macAddress[*]}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/nxtMaskIn[*]}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/phyTxc[*]}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/phyTxd[*]}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/stateCount[*]}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/crcDataValid}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/crcInit}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/crcReset}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/frameShift0}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/frameShift1}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/intAdvance}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/intDump}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/intError}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/intLastLine}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/intPad}
# ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/intRunt}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/macMaster[tLast]}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/macMaster[tValid]}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/macSlave[tReady]}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/nxtEOF}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/nxtError}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/nxtState}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/stateCountRst}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/txCountEn}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/txEnable0}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/txEnable1}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/txEnable2}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/txEnable3}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/txLinkNotReady}
ConfigProbe ${ilaName} {U_SFP/GEN_LANE[0].TenGigEthGthUltraScale_Inst/U_MAC/U_Tx/U_Export/U_10G.U_XGMII/txUnderRun}


##########################
## Write the port map file
##########################
WriteDebugProbes ${ilaName} 
