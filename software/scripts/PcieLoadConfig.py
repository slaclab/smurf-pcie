#!/usr/bin/env python3
#-----------------------------------------------------------------------------
# This file is part of the 'Development Board Examples'. It is subject to 
# the license terms in the LICENSE.txt file found in the top-level directory 
# of this distribution and at: 
#    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
# No part of the 'Development Board Examples', including this file, may be 
# copied, modified, propagated, or distributed except according to the terms 
# contained in the LICENSE.txt file.
#-----------------------------------------------------------------------------

import sys
import argparse
import pyrogue as pr
import rogue.hardware.axi
import SmurfKcu1500RssiOffload as smurf

#################################################################

# Convert str to bool
argBool = lambda s: s.lower() in ['true', 't', 'yes', '1']

# Set the argument parser
parser = argparse.ArgumentParser()

# Add arguments
parser.add_argument(
    "--dev", 
    type     = str,
    required = False,
    default  = '/dev/datadev_0',
    help     = "path to device",
) 

parser.add_argument(
    "--yaml", 
    type     = str,
    required = False,
    default  = 'config/pcie_rssi_config.yml',
    help     = "path to YAML configuration",
) 

# Get the arguments
args = parser.parse_args()

#################################################################

# Set base
base = pr.Root(name='pcie',description='')    

# Create the stream interface
memMap = rogue.hardware.axi.AxiMemMap(args.dev)

# Add Base Device
base.add(smurf.Core(memBase=memMap))

# Start the system
base.start(pollEn=True,initRead=True)

# Print the AxiVersion Summary
base.Core.AxiPcieCore.AxiVersion.printStatus()

# # Reset the Application Firmware
# base.Core.AxiPcieCore.AxiVersion.UserRst()

# Load the YAML file
print( 'Loading %s YAML file' % args.yaml);
base.ReadConfig(args.yaml) 
    
# Close
base.stop()
exit()   