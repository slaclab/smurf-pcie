# Source common setup script
source ${PWD}/setup_common.csh

# Python Package directories
setenv APP_DIR  ${PWD}/../firmware/common/CryoApp/AppCore/python
setenv DSP_DIR  ${PWD}/../firmware/common/DspCoreLib/CryoDetCmbHcd/python
setenv TOP_DIR  ${PWD}/../firmware/targets/CryoDetCmbHcdBpEth/python

# Setup python path
setenv PYTHONPATH ${TOP_DIR}:${DSP_DIR}:${APP_DIR}:${PYTHONPATH}
