# Setup enivorment
source /afs/slac/g/reseng/rogue/v2.0.0/setup_env.sh

# Python Package directories
export APP_DIR=${PWD}/../firmware/common
export CORE_DIR=${PWD}/../firmware/submodules/lcls-timing-dsp-core
export SURF_DIR=${PWD}/../firmware/submodules/surf
export AMCC_DIR=${PWD}/../firmware/submodules/amc-carrier-core
export TIMING_DIR=${PWD}/../firmware/submodules/lcls-timing-core
export APPCORE_DIR=${PWD}/..//firmware/common/CryoApp/AppCore
export CRYODSP_DIR=${PWD}/../firmware/common/DspCoreLib/CryoDetEth

# Setup python path
export PYTHONPATH=${PWD}/python:${SURF_DIR}/python:${CORE_DIR}/python:${APP_DIR}/python:${AMCC_DIR}/python:${TIMING_DIR}/python:${APPCORE_DIR}/python:${CRYODSP_DIR}/python:${PYTHONPATH}
