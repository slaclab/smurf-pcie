###################
# Setup environment
###################
#source /afs/slac/g/reseng/rogue/v2.8.3/setup_env.csh
source /afs/slac/g/reseng/rogue/pre-release/setup_env.csh
#source /afs/slac/g/reseng/rogue/master/setup_env.csh

# Python Package directories
setenv AMCC_DIR     ${PWD}/../firmware/submodules/amc-carrier-core/python
setenv PCIE_DIR     ${PWD}/../firmware/submodules/axi-pcie-core/python
setenv TIMING_DIR   ${PWD}/../firmware/submodules/lcls-timing-core/python
setenv SURF_DIR     ${PWD}/../firmware/submodules/surf/python

# Setup python path
setenv PYTHONPATH ${PWD}/python:${AMCC_DIR}:${PCIE_DIR}:${TIMING_DIR}:${SURF_DIR}:${PYTHONPATH}
