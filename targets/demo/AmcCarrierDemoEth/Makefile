
# Define target output
target: prom

# Define target part
export PRJ_PART = XCKU040-FFVA1156-2-E

# Using a non-standard target directory structure, 
# which requires me to define the TOP_DIR path
export TOP_DIR = $(abspath $(PWD)/../../..)

# List of build core directories.
export MODULE_DIRS = $(PROJ_DIR)/../../../modules/AmcCarrierCore  \
                     $(PROJ_DIR)/../../../modules/StdLib \
                     $(PROJ_DIR)/../../../modules/MgtLib/gthUltraScale \
                     $(PROJ_DIR)/../../../modules/pgp2b/core \
                     $(PROJ_DIR)/../../../modules/pgp2b/gthUltraScale \
                     $(PROJ_DIR)/../../../modules/SaltCore/core  \
                     $(PROJ_DIR)/../../../modules/SaltCore/xilinxUltraScale  \
                     $(PROJ_DIR)/../../../modules/AxiMicronN25QCore \
                     $(PROJ_DIR)/../../../modules/AxiSy56040Core \
                     $(PROJ_DIR)/../../../modules/BsaCore \
                     $(PROJ_DIR)/../../../modules/TimingCore/LCLS-I \
                     $(PROJ_DIR)/../../../modules/TimingCore/LCLS-II/core \
                     $(PROJ_DIR)/../../../modules/TimingCore/LCLS-II/gthUltraScale \
                     $(PROJ_DIR)/../../../modules/EthernetLib/UdpEngine \
                     $(PROJ_DIR)/../../../modules/EthernetLib/IpV4Engine \
                     $(PROJ_DIR)/../../../modules/EthernetLib/XauiCore/core \
                     $(PROJ_DIR)/../../../modules/EthernetLib/XauiCore/gthUltraScale \
                     $(PROJ_DIR)/../../../modules/EthernetLib/EthMacCore \
                     $(PROJ_DIR)/../../../modules/RssiCore \
                     $(PROJ_DIR)/../../../modules/Jesd204bCore \
                     $(PROJ_DIR)/../../../modules/DspCoreLib/LlrfMissionReadiness \
                     $(PROJ_DIR)/../../../modules/MissionReadinessCore \
                     $(PROJ_DIR)/../../../modules/Common \
                     $(PROJ_DIR)

# Use top level makefile
include ../../../modules/StdLib/build/system_vivado_v1.mk
