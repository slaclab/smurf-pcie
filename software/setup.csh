###################
# Setup environment
###################
source /afs/slac/g/reseng/rogue/pre-release/setup_env.csh
#source /afs/slac/g/reseng/rogue/v2.12.0/setup_env.csh

# Python Package directories
setenv PCIE_DIR ${PWD}/../firmware/submodules/axi-pcie-core/python
setenv SURF_DIR ${PWD}/../firmware/submodules/surf/python

# Setup python path
setenv PYTHONPATH ${PWD}/python:${PCIE_DIR}:${SURF_DIR}:${PYTHONPATH}
