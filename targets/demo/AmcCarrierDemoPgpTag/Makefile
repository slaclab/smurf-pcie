
# Define target output
target: prom

# Define target part
export PRJ_PART = XCKU040-FFVA1156-2-E

# Using a non-standard target directory structure, 
# which requires me to define the TOP_DIR path
export TOP_DIR = $(abspath $(PWD)/../../..)

# List of build core directories.
export MODULE_DIRS = $(PROJ_DIR)/../../../modules/StdLibV1.0 \
                     $(PROJ_DIR)/../../../modules/AmcCarrierCoreV1.0  \
                     $(PROJ_DIR)/../../../modules/TimingCoreV1.0/LCLS-II/core \
                     $(PROJ_DIR)/../../../modules/MgtLibV1.0/gthUltraScale \
                     $(PROJ_DIR)/../../../modules/pgp2bV1.0/core \
                     $(PROJ_DIR)/../../../modules/pgp2bV1.0/gthUltraScale \
                     $(PROJ_DIR)/../../../modules/Jesd204bCoreV1.0 \
                     $(PROJ_DIR)/../../../modules/Common \
                     $(PROJ_DIR)/../../../modules/DspCoreLib/CryoDet \
                     $(PROJ_DIR)

# Use top level makefile
include ../../../modules/StdLib/build/system_vivado_v1.mk
