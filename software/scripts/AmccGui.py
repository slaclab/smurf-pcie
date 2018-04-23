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

from FpgaTopLevel import *

#################################################################

# Convert str to bool
argBool = lambda s: s.lower() in ['true', 't', 'yes', '1']

# Set the argument parser
parser = argparse.ArgumentParser()

# Add arguments
parser.add_argument(
    "--simGui", 
    type     = argBool,
    required = False,
    default  = False,
    help     = "Enable hardware emulation",
)  

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
    "--pollEn", 
    type     = argBool,
    required = False,
    default  = True,
    help     = "auto-polling",
)  

# Get the arguments
args = parser.parse_args()

#################################################################

# Set base
base = pr.Root(name='AMCc',description='')    

# Add Base Device
base.add(FpgaTopLevel(
    simGui       = args.simGui,
    commType     = args.commType,
    ipAddr       = args.ipAddr,
    pcieRssiLink = (int(args.slot)-2),
))

# Start the system
base.start(
    pollEn   = args.pollEn,
)

# Print the AxiVersion Summary
base.FpgaTopLevel.AmcCarrierCore.AxiVersion.printStatus()

# Create GUI
appTop = PyQt4.QtGui.QApplication(sys.argv)
appTop.setStyle('Fusion')
guiTop = pyrogue.gui.GuiTop(group='rootMesh')
guiTop.addTree(base)
guiTop.resize(800, 1000)

print("Starting GUI...\n");

# Run GUI
appTop.exec_()    
    
# Close
base.stop()
exit()   