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
import setupLibPaths

import sys
import time
import argparse

import pyrogue
import pyrogue.pydm

import SmurfPcie.SmurfFebEmu as febEmu

# rogue.Logging.setLevel(rogue.Logging.Warning)
# #rogue.Logging.setFilter("pyrogue.rssi",rogue.Logging.Info)
# rogue.Logging.setFilter("pyrogue.utilities.prbs.PrbsRx",rogue.Logging.Info)
# #rogue.Logging.setFilter("pyrogue.packetizer",rogue.Logging.Info)
# # # rogue.Logging.setLevel(rogue.Logging.Debug)

#################################################################

if __name__ == "__main__":

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
        "--guiType",
        type     = str,
        required = False,
        default  = 'PyDM',
        help     = "Sets the GUI type (PyDM or None)",
    )

    parser.add_argument(
        "--febConfig",
        type     = str,
        required = False,
        default  = 'config/SmurfFebEmu/4kHz_8320B.yml',
        help     = "path to YAML configuration",
    )

    # Get the arguments
    args = parser.parse_args()

    #################################################################

    if args.allLane == 0:
        laneList = [args.lane]
    else:
        laneList = range(args.allLane)

    with febEmu.Root(
        laneList   = laneList,
        febConfig  = args.febConfig,
        pollEn     = args.pollEn,
        initRead   = args.initRead,
    ) as root:

        ######################
        # Development PyDM GUI
        ######################
        if (args.guiType == 'PyDM'):
            pyrogue.pydm.runPyDM(
                serverList = root.zmqServer.address,
                sizeX      = 800,
                sizeY      = 800,
            )

        #################
        # No GUI
        #################
        elif (args.guiType == 'None'):
            print("Running without GUI...")
            pyrogue.waitCntrlC()

        ####################
        # Undefined GUI type
        ####################
        else:
            raise ValueError("Invalid GUI type (%s)" % (args.guiType) )

    #################################################################
