
# Python Package directories
setenv AMCC_DIR     ${PWD}/../../firmware/submodules/amc-carrier-core/python
setenv PCIE_DIR     ${PWD}/../../firmware/submodules/axi-pcie-core/python
setenv TIMING_DIR   ${PWD}/../../firmware/submodules/lcls-timing-core/python
setenv SURF_DIR     ${PWD}/../../firmware/submodules/surf/python

# Setup python path
setenv PYTHONPATH ${PWD}/python:${AMCC_DIR}:${PCIE_DIR}:${TIMING_DIR}:${SURF_DIR}:${PYTHONPATH}
