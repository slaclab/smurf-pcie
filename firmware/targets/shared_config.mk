# Define Firmware Version: v3.2.0.0
export PRJ_VERSION = 0x03020000

# Define release
ifndef RELEASE
export RELEASE = all
endif

# Define target output
target: prom
