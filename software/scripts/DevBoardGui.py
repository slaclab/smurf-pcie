#!/usr/bin/env python3
#-----------------------------------------------------------------------------
# Title      : PyRogue DevBoardGui Module
#-----------------------------------------------------------------------------
# File       : DevBoardGui.py
# Author     : Larry Ruckman <ruckman@slac.stanford.edu>
# Created    : 2017-02-15
# Last update: 2017-02-15
#-----------------------------------------------------------------------------
# Description:
# Rogue interface to DEV board
#-----------------------------------------------------------------------------
# This file is part of the 'Development Board Examples'. It is subject to
# the license terms in the LICENSE.txt file found in the top-level directory
# of this distribution and at:
#    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
# No part of the 'Development Board Examples', including this file, may be
# copied, modified, propagated, or distributed except according to the terms
# contained in the LICENSE.txt file.
#-----------------------------------------------------------------------------
import setupLibPaths
import pyrogue as pr
import SmurfPcie.DevBoard as devBoard
import pyrogue.gui
import pyrogue.protocols
import pyrogue.utilities.prbs
import rogue.hardware.axi
import sys
import argparse

# rogue.Logging.setLevel(rogue.Logging.Warning)
# #rogue.Logging.setFilter("pyrogue.rssi",rogue.Logging.Info)
# rogue.Logging.setFilter("pyrogue.utilities.prbs.PrbsRx",rogue.Logging.Info)
# #rogue.Logging.setFilter("pyrogue.packetizer",rogue.Logging.Info)
# # # rogue.Logging.setLevel(rogue.Logging.Debug)

#################################################################

# Convert str to bool
argBool = lambda s: s.lower() in ['true', 't', 'yes', '1']

# Set the argument parser
parser = argparse.ArgumentParser()

# Add arguments

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
    "--loopback",
    type     = argBool,
    required = False,
    default  = False,
    help     = "SW loopback of PRBS stream",
)

parser.add_argument(
    "--swRx",
    type     = argBool,
    required = False,
    default  = False,
    help     = "SW loopback of PRBS stream",
)

parser.add_argument(
    "--swTx",
    type     = argBool,
    required = False,
    default  = False,
    help     = "SW loopback of PRBS stream",
)

parser.add_argument(
    "--lane",
    type     = int,
    required = False,
    default  = 0,
    help     = "DMA Lane",
)

parser.add_argument(
    "--allLane",
    type     = int,
    required = False,
    default  = 0,
    help     = "load all the lanes",
)

parser.add_argument(
    "--ip",
    type     = str,
    required = False,
    default  = '',
    help     = '',
)

parser.add_argument('--html', help='Use html for tables', action="store_true")
# Get the arguments
args = parser.parse_args()

# Set base
rootTop = devBoard.TopLevel(
    name        = 'System',
    description = 'Front End Board',
    ip          = args.ip if args.ip != "" else None,
    loopback    = args.loopback,
    swRx        = args.swRx,
    swTx        = args.swTx,
    lane        = args.lane,
    allLane     = args.allLane,
)

#################################################################

# Start the system
rootTop.start()

# # Print the AxiVersion Summary
# rootTop.Fpga.AxiVersion.printStatus()

# Create GUI
appTop = pr.gui.application(sys.argv)
guiTop = pr.gui.GuiTop()
guiTop.addTree(rootTop)
guiTop.resize(800, 800)

print("Starting GUI...\n");

# Run gui
appTop.exec_()

#################################################################

# Stop mesh after gui exits
rootTop.stop()
exit()

#################################################################
