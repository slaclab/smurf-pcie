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

import pyrogue as pr
import pyrogue.gui
import PyQt4.QtGui
import sys
import argparse
import time

from FpgaTopLevel import *

#################################################################

# Convert str to bool
argBool = lambda s: s.lower() in ['true', 't', 'yes', '1']

# Set the argument parser
parser = argparse.ArgumentParser()

# Add arguments
parser.add_argument(
    "--commType", 
    type     = str,
    required = True,
    help     = "Sets the communication type",
)

parser.add_argument(
    "--ipAddr", 
    type     = str,
    required = False,
    default  = '10.0.0.100',
    help     = "IP address",
) 

parser.add_argument(
    "--slot", 
    type     = int,
    required = False,
    default  = 2,
    help     = "ATCA slot",
) 

parser.add_argument(
    "--mcs", 
    type     = str,
    required = True,
    help     = "path to MCS file",
)  

# Get the arguments
args = parser.parse_args()

#################################################################

# Set base
base = pr.Root(name='base',description='')    

# Add Base Device
base.add(FpgaTopLevel(
    commType     = args.commType,
    ipAddr       = args.ipAddr,
    pcieRssiLink = (int(args.slot)-2),
))

# Start the system
base.start(pollEn=False)

# Create useful pointers
AxiVersion = base.FpgaTopLevel.AmcCarrierCore.AxiVersion
PROM       = base.FpgaTopLevel.AmcCarrierCore.MicronN25Q

print ( '###################################################')
print ( '#                 Old Firmware                    #')
print ( '###################################################')
AxiVersion.printStatus()

# Program the FPGA's PROM
PROM.LoadMcsFile(args.mcs)

if(PROM._progDone):
    print('\nReloading FPGA firmware from PROM ....')
    AxiVersion.FpgaReload()
    time.sleep(10)
    print('\nReloading FPGA done')

    print ( '###################################################')
    print ( '#                 New Firmware                    #')
    print ( '###################################################')
    AxiVersion.printStatus()
else:
    print('Failed to program FPGA')

base.stop()
exit()


