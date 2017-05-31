# Setup enivorment
source /afs/slac/g/reseng/rogue/v1.2.0/setup_env.csh

# Python Package directories
setenv APP_DIR      ${PWD}/../firmware/common/
setenv CORE_DIR     ${PWD}/../firmware/submodules/lcls-timing-dsp-core
setenv SURF_DIR     ${PWD}/../firmware/submodules/surf
setenv AMCC_DIR     ${PWD}/../firmware/submodules/amc-carrier-core/AmcCarrierCore
setenv BSA_DIR      ${PWD}/../firmware/submodules/amc-carrier-core/BsaCore
setenv TIMING_DIR   ${PWD}/../firmware/submodules/lcls-timing-core
setenv MPS_DIR      ${PWD}/../firmware/submodules/amc-carrier-core/AppMps
setenv APPTOP_DIR   ${PWD}/../firmware/submodules/amc-carrier-core/AppTop
setenv SIGGEN_DIR   ${PWD}/../firmware/submodules/amc-carrier-core/DacSigGen
setenv DAQMUX_DIR   ${PWD}/../firmware/submodules/amc-carrier-core/DaqMuxV2
setenv APPCORE_DIR  ${PWD}/..//firmware/common/CryoApp/AppCore
setenv CRYOCORE_DIR ${PWD}/../firmware/submodules/amc-carrier-core/AppHardware/AmcCryo
setenv CRYODSP_DIR  ${PWD}/../firmware/common/DspCoreLib/CryoDetEth

# Setup python path
setenv PYTHONPATH ${PWD}/python:${SURF_DIR}/python:${CORE_DIR}/python:${APP_DIR}/python:${AMCC_DIR}/python:${BSA_DIR}/python:${TIMING_DIR}/python:${MPS_DIR}/python:${APPTOP_DIR}/python:${SIGGEN_DIR}/python:${DAQMUX_DIR}/python:${APPCORE_DIR}/python:${CRYOCORE_DIR}/python:${CRYODSP_DIR}/python:${PYTHONPATH}
