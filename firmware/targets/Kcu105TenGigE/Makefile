# Define release
ifndef RELEASE
export RELEASE = all
endif

# Define target output
target: prom

# Define Firmware Version Number
export PRJ_VERSION = 0x00000221

# Define target part
export PRJ_PART = XCKU040-FFVA1156-2-E

# Using a non-standard target directory structure, 
# which requires me to define the TOP_DIR path
export TOP_DIR = $(abspath $(PWD)/../..)

# Define release
export RELEASE = Kcu105TenGigE

# Use top level makefile
include $(TOP_DIR)/submodules/ruckus/system_vivado.mk
