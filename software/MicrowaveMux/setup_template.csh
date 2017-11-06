# Setup environment
#source /afs/slac/g/reseng/rogue/master/setup_env.csh
#source /afs/slac/g/reseng/rogue/v2.2.0/setup_env.csh
source /afs/slac/g/lcls/package/pyrogue/rogue/current/setup_env.csh

# Python Package directories
setenv SURF_DIR     ${PWD}/../../firmware/submodules/surf
setenv AMCC_DIR     ${PWD}/../../firmware/submodules/amc-carrier-core/
setenv TIMING_DIR   ${PWD}/../../firmware/submodules/lcls-timing-core
setenv APPCORE_DIR  ${PWD}/../..//firmware/common/MicrowaveMuxApp/AppCore
setenv DSP_DIR      ${PWD}/../../firmware/common/DspCoreLib/MicrowaveMux
setenv TOP_DIR      ${PWD}/../../firmware/targets/MicrowaveMuxBpEth

# Setup python path
setenv PYTHONPATH ${PWD}/python:${SURF_DIR}/python:${AMCC_DIR}/python:${TIMING_DIR}/python:${APPCORE_DIR}/python:${DSP_DIR}/python:${TOP_DIR}/python:${PYTHONPATH}
