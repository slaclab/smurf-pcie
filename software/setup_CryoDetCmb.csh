# Setup environment
source /afs/slac/g/reseng/rogue/master/setup_env.csh
source ${PWD}/setup_common.csh

# Python Package directories
setenv APP_DIR  ${PWD}/../../firmware/common/CryoApp/AppCore/python
setenv DSP_DIR  ${PWD}/../../firmware/common/DspCoreLib/CryoDetCmb/python
setenv TOP_DIR  ${PWD}/../../firmware/targets/CryoCmbBpEth/python

# Setup python path
setenv PYTHONPATH ${TOP_DIR}:${DSP_DIR}:${APP_DIR}:${PYTHONPATH}
