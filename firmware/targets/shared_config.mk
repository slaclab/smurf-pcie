# Define Firmware Version: v4.1.0.0
export PRJ_VERSION = 0x04010000

# Define release
ifndef RELEASE
export RELEASE = all
endif

# Define target output
target: prom
