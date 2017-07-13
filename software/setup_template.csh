# Setup enivorment
source /afs/slac/g/reseng/rogue/master/setup_env.csh
#source /afs/slac/g/reseng/rogue/v2.1.0/setup_env.csh

# Python Package directories
setenv SURF_DIR     ${PWD}/../firmware/submodules/surf
setenv AMCC_DIR     ${PWD}/../firmware/submodules/amc-carrier-core/
setenv TIMING_DIR   ${PWD}/../firmware/submodules/lcls-timing-core
setenv APPCORE_DIR  ${PWD}/..//firmware/common/CryoApp/AppCore
setenv CRYODSP_DIR  ${PWD}/../firmware/common/DspCoreLib/CryoDet
setenv TOP_DIR      ${PWD}/../firmware/targets/CryoRtmEth

# Setup python path
setenv PYTHONPATH ${PWD}/python:${SURF_DIR}/python:${AMCC_DIR}/python:${TIMING_DIR}/python:${APPCORE_DIR}/python:${CRYODSP_DIR}/python:${TOP_DIR}/python:${PYTHONPATH}
