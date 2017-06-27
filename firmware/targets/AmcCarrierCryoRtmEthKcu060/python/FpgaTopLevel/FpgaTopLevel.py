#!/usr/bin/env python
#-----------------------------------------------------------------------------
# Title      : PyRogue AMC Carrier Cryo Demo Board Application
#-----------------------------------------------------------------------------
# File       : AppCore.py
# Created    : 2017-04-03
#-----------------------------------------------------------------------------
# Description:
# PyRogue AMC Carrier Cryo Demo Board Application
#-----------------------------------------------------------------------------
# This file is part of the rogue software platform. It is subject to
# the license terms in the LICENSE.txt file found in the top-level directory
# of this distribution and at:
#    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
# No part of the rogue software platform, including this file, may be
# copied, modified, propagated, or distributed except according to the terms
# contained in the LICENSE.txt file.
#-----------------------------------------------------------------------------

import pyrogue as pr

from AmcCarrierCore import *
from AppTop import *

class FpgaTopLevel(pr.Device):
    def __init__(   self, 
                    name        = "FpgaTopLevel", 
                    description = "FPGA Top-Level", 
                    memBase     =  None, 
                    offset      =  0x0, 
                    hidden      =  False,
                    expand      =  True,
                    ipAddr      = "10.0.1.101",
                ):
        super(self.__class__, self).__init__(name, description, memBase, offset, hidden, expand=expand)

        # Create srp interface
        #  - This system uses UDP(port 8193, size 1500) + RSSI + Pack and SRP v3
        srp = rogue.protocols.srp.SrpV3()
        urp = pr.protocols.UdpRssiPack( ipAddr, 8193, 1500 )
        pr.streamConnectBiDir( srp, urp.application(0) )

        # Create stream interface
        # - This system uses UDP(port 8194, size 1500) + RSSI + Pack
        self.stream = pr.protocols.UdpRssiPack( ipAddr, 8194, 1500 )

        # Add devices
        self.add(AmcCarrierCore(    memBase    =  srp,
                                    offset     =  0x00000000,
                                    enableBsa  =  False
                               ))

        #BAY[0] only
        self.add(AppTop(            memBase    =  srp,
                                    offset     =  0x80000000,
                                    numRxLanes =  [10,0],
                                    numTxLanes =  [10,0]
                               ))

        #BAY[1] only
        #self.add(AppTop(            offset     =  0x80000000,
        #                            numRxLanes =  [0,10],
        #                            numTxLanes =  [0,10]
        #                       ))

    # Define trigger command
    def Trigger(self):
        # BAY[0] DaqMux software trigger command 
        self.AppTop.DaqMuxV2[0].TriggerDaq.call()
        
        # BAY[1] DaqMux software trigger command 
        #self.AppTop.DaqMuxV2[1].TriggerDaq.call()
