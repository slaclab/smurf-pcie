# Define target output
target: prom

# Define target part
export PRJ_PART = XCKU040-FFVA1156-2-E

# Define the tags
export STDLIB_TAG  = head
export AMC_TAG     = head
export MGT_TAG     = head
export PGP_TAG     = head
export SALT_TAG    = head
export N25Q_TAG    = head
export SY56040_TAG = head
export BSA_TAG     = head
export TIMING_TAG  = head
export ETH_TAG     = head
export RSSI_TAG    = head
export JESD_TAG    = head
export MBLAZE_TAG  = head
# Local tags
export COMMON_TAG     = head
export MR_CORE_TAG    = head
export SSRL_CORE_TAG  = 1.0

# Using a non-standard StdLib directory structure, 
# which requires me to define the VIVADO_BUILD_DIR path
export VIVADO_BUILD_DIR = $(abspath $(PWD)/../../../modules/StdLib/$(STDLIB_TAG)/build)

# Using a non-standard target directory structure, 
# which requires me to define the TOP_DIR path
export TOP_DIR = $(abspath $(PWD)/../../..)

# List of build core directories.
export MODULE_DIRS = $(PROJ_DIR)/../../../modules/AmcCarrierCore/$(AMC_TAG)  \
                     $(PROJ_DIR)/../../../modules/StdLib/$(STDLIB_TAG) \
                     $(PROJ_DIR)/../../../modules/MgtLib/$(MGT_TAG)/gthUltraScale \
                     $(PROJ_DIR)/../../../modules/pgp2b/$(PGP_TAG)/core \
                     $(PROJ_DIR)/../../../modules/pgp2b/$(PGP_TAG)/gthUltraScale \
                     $(PROJ_DIR)/../../../modules/SaltCore/$(SALT_TAG)/core  \
                     $(PROJ_DIR)/../../../modules/SaltCore/$(SALT_TAG)/xilinxUltraScale  \
                     $(PROJ_DIR)/../../../modules/AxiMicronN25QCore/$(N25Q_TAG) \
                     $(PROJ_DIR)/../../../modules/AxiSy56040Core/$(SY56040_TAG) \
                     $(PROJ_DIR)/../../../modules/BsaCore/$(BSA_TAG) \
                     $(PROJ_DIR)/../../../modules/TimingCore/$(TIMING_TAG)/LCLS-I \
                     $(PROJ_DIR)/../../../modules/TimingCore/$(TIMING_TAG)/LCLS-II/core \
                     $(PROJ_DIR)/../../../modules/TimingCore/$(TIMING_TAG)/LCLS-II/gthUltraScale \
                     $(PROJ_DIR)/../../../modules/EthernetLib/$(ETH_TAG)/UdpEngine \
                     $(PROJ_DIR)/../../../modules/EthernetLib/$(ETH_TAG)/IpV4Engine \
                     $(PROJ_DIR)/../../../modules/EthernetLib/$(ETH_TAG)/TenGigEthCore/core \
                     $(PROJ_DIR)/../../../modules/EthernetLib/$(ETH_TAG)/TenGigEthCore/gthUltraScale \
                     $(PROJ_DIR)/../../../modules/EthernetLib/$(ETH_TAG)/GigEthCore/core \
                     $(PROJ_DIR)/../../../modules/EthernetLib/$(ETH_TAG)/GigEthCore/gthUltraScale \
                     $(PROJ_DIR)/../../../modules/EthernetLib/$(ETH_TAG)/XauiCore/core \
                     $(PROJ_DIR)/../../../modules/EthernetLib/$(ETH_TAG)/XauiCore/gthUltraScale \
                     $(PROJ_DIR)/../../../modules/EthernetLib/$(ETH_TAG)/EthMacCore \
                     $(PROJ_DIR)/../../../modules/RssiCore/$(RSSI_TAG) \
                     $(PROJ_DIR)/../../../modules/Jesd204bCore/$(JESD_TAG) \
                     $(PROJ_DIR)/../../../modules/MissionReadinessCore/$(MR_CORE_TAG) \
                     $(PROJ_DIR)/../../../modules/Common/$(COMMON_TAG) \
                     $(PROJ_DIR)/../../../modules/DspCoreLib/CryoDetEth  \
                     $(PROJ_DIR)

# Use top level makefile
include ../../../modules/StdLib/$(STDLIB_TAG)/build/system_vivado_v1.mk
