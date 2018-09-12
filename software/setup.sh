###################
# Setup environment
###################
source /afs/slac/g/reseng/rogue/pre-release/setup_env.sh
#source /afs/slac/g/reseng/rogue/v2.12.0/setup_env.sh

# Python Package directories
export PCIE_DIR=${PWD}/../firmware/submodules/axi-pcie-core/python
export SURF_DIR=${PWD}/../firmware/submodules/surf/python

# Setup python path
export PYTHONPATH=${PWD}/python:${PCIE_DIR}:${SURF_DIR}:${PYTHONPATH}
