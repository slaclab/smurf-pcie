# Setup enivorment
source /afs/slac/g/reseng/rogue/v1.2.0/setup_env.sh

# Python Package directories
export APP_DIR=${PWD}/../firmware/common/
export CORE_DIR=${PWD}/../firmware/submodules/lcls-timing-dsp-core
export SURF_DIR=${PWD}/../firmware/submodules/surf
export AMCC_DIR=${PWD}/../firmware/submodules/amc-carrier-core/AmcCarrierCore
export BSA_DIR=${PWD}/../firmware/submodules/amc-carrier-core/BsaCore
export TIMING_DIR=${PWD}/../firmware/submodules/lcls-timing-core
export MPS_DIR=${PWD}/../firmware/submodules/amc-carrier-core/AppMps
export APPTOP_DIR=${PWD}/../firmware/submodules/amc-carrier-core/AppTop
export SIGGEN_DIR=${PWD}/../firmware/submodules/amc-carrier-core/DacSigGen
export DAQMUX_DIR=${PWD}/../firmware/submodules/amc-carrier-core/DaqMuxV2
#export DEMOAPP_DIR=${PWD}/../firmware/common/DemoBoardCryoApp
export APPCORE_DIR=${PWD}/..//firmware/common/CryoApp/AppCore
export CRYOCORE_DIR=${PWD}/../firmware/submodules/amc-carrier-core/AppHardware/AmcCryo
export CRYODSP_DIR=${PWD}/../firmware/common/DspCoreLib/CryoDetEth

# Setup python path
export PYTHONPATH=${PWD}/python:${SURF_DIR}/python:${CORE_DIR}/python:${APP_DIR}/python:${AMCC_DIR}/python:${BSA_DIR}/python:${TIMING_DIR}/python:${MPS_DIR}/python:${APPTOP_DIR}/python:${SIGGEN_DIR}/python:${DAQMUX_DIR}/python:${APPCORE_DIR}/python:${CRYOCORE_DIR}/python:${CRYODSP_DIR}/python:${PYTHONPATH}
