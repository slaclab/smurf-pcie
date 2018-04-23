# Source common setup script
source ${PWD}/setup_common.csh

# Python Package directories
setenv APP_DIR  ${PWD}/../firmware/common/CryoApp/AppCore/python
setenv DSP_DIR  ${PWD}/../firmware/common/DspCoreLib/CryoDetXray/python
setenv TOP_DIR  ${PWD}/../firmware/targets/CryoXrayBpEth/python

# Setup python path
setenv PYTHONPATH ${TOP_DIR}:${DSP_DIR}:${APP_DIR}:${PYTHONPATH}
