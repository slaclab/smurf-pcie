# Setup environment
#source /afs/slac/g/reseng/rogue/master/setup_env.sh
#source /afs/slac/g/reseng/rogue/v2.2.0/setup_env.sh
source /afs/slac/g/lcls/package/pyrogue/rogue/current/setup_env.sh

# Python Package directories
export SURF_DIR=${PWD}/../../firmware/submodules/surf
export AMCC_DIR=${PWD}/../../firmware/submodules/amc-carrier-core
export TIMING_DIR=${PWD}/../../firmware/submodules/lcls-timing-core
export APPCORE_DIR=${PWD}/../../firmware/common/CryoApp/AppCore
export CRYODSP_DIR=${PWD}/../../firmware/common/DspCoreLib/CryoDetCmb
export TOP_DIR=${PWD}/../../firmware/targets/CryoCmbRtmEth

# Setup python path
export PYTHONPATH=${PWD}/python:${SURF_DIR}/python:${AMCC_DIR}/python:${TIMING_DIR}/python:${APPCORE_DIR}/python:${CRYODSP_DIR}/python:${TOP_DIR}/python:${PYTHONPATH}
