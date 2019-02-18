###################
# Setup environment
###################
source /afs/slac.stanford.edu/g/reseng/rogue/anaconda/rogue_pre-release.sh

# Python Package directories
TOP=/usr/local/controls/Applications/smurf/cmb_Det/smurf-pcie/master/software
export AMCC_DIR=${TOP}/../firmware/submodules/amc-carrier-core/python
export PCIE_DIR=${TOP}/../firmware/submodules/axi-pcie-core/python
export TIMING_DIR=${TOP}/../firmware/submodules/lcls-timing-core/python
export SURF_DIR=${TOP}/../firmware/submodules/surf/python

# Setup python path
export PYTHONPATH=${TOP}/python:${AMCC_DIR}:${PCIE_DIR}:${TIMING_DIR}:${SURF_DIR}:${PYTHONPATH}
