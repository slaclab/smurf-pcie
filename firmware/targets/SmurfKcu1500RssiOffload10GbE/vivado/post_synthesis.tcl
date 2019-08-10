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
SetDebugCoreClk ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/ethClk}

#######################
## Set the debug Probes
#######################

# Flow Control
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/ethStatus[rxCrcErrorCnt]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/ethStatus[rxOverFlow]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/ethStatus[rxPauseCnt]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/ethStatus[txPauseCnt]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/flowCtrl[pause]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_RxFifo/U_Fifo/mDropWrite}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_RxFifo/U_Fifo/mTermFrame}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_RxFifo/U_Fifo/overflow}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_RxFifo/U_Fifo/sAxisCtrl[overflow]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_RxFifo/U_Fifo/sAxisCtrl[pause]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_RxFifo/U_Fifo/sTermFrame}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_RxFifo/U_Fifo/sAxisRst}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_RxFifo/U_Fifo/sAxisReset}

ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcDataValid}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcGood}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcInit}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcReset}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcShift0}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcShift1}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/endDetect}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/endShift0}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/endShift1}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/frameShift0}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/frameShift1}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/frameShift2}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/frameShift3}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/frameShift4}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/frameShift5}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/intAdvance}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/intFirstLine}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/intLastLine}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/lastSOF}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/nxtCrcValid}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/rxCountEn}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/rxCrcError}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/rxdAlign}


#ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcDataWidth[*]}
#ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcFifoIn[*]}
#ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcFifoOut[*]}
#ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcIn[*]}
#ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcOut[*]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcWidthDly0[*]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcWidthDly1[*]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcWidthDly2[*]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/crcWidthDly3[*]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/dlyRxd[*]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/macData[*]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/macSize[*]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/nxtCrcWidth[*]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/phyRxc[*]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/phyRxcDly[*]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/phyRxd[*]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/phyRxdata[*]}
ConfigProbe ${ilaName} {U_Hardware/U_EthPhyMac/GEN_LANE[0].GEN_10G.U_ETH/U_MAC/U_Rx/U_Import/U_10G.U_XGMII/phyRxChar[*]}

##########################
## Write the port map file
##########################
WriteDebugProbes ${ilaName} 
