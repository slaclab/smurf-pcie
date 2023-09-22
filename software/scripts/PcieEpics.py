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
import pyrogue.gui
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
    "--pollEn",
    type     = argBool,
    required = False,
    default  = True,
    help     = "auto-polling",
)

parser.add_argument(
    "--initRead",
    type     = argBool,
    required = False,
    default  = True,
    help     = "Enable read all variables at start",
)

parser.add_argument(
    "--prefix",
    type     = str,
    required = False,
    default  = 'pcie_test0',
    help     = "Epics prefix",
)

# Get the arguments
args = parser.parse_args()

#################################################################

# Set base
base = pr.Root(name='pcie',description='', pollEn=args.pollEn,initRead=args.initRead,serverPort=9102)

# Create the stream interface
memMap = rogue.hardware.axi.AxiMemMap(args.dev)

# Add Base Device
base.add(smurf.Core(memBase=memMap,expand=True))

# Start the system
base.start()

# Add epics
from pyrogue.protocols import epics
epics = epics.EpicsCaServer(base=args.prefix, root=base)
print(f"Starting EPICS server using prefix \"{args.prefix}\"")
epics.start()
epics.dump()

# Print the AxiVersion Summary
base.Core.AxiPcieCore.AxiVersion.printStatus()

# Create GUI
#import pyrogue.pydm
#pyrogue.pydm.runPyDM(root=base)

print("Running without GUI...")
pyrogue.waitCntrlC()

# Close
epics.stop()
base.stop()
exit()
