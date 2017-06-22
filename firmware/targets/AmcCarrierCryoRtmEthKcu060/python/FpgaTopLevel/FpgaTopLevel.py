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
                ):
        super(self.__class__, self).__init__(name, description, memBase, offset, hidden, expand=expand)
        
        self.add(AmcCarrierCore(offset=0x00000000, enableBsa=False))
        self.add(AppTop(        offset=0x80000000, numRxLanes=[10,0], numTxLanes=[10,0])) #BAY[0] only
        # self.add(AppTop(        offset=0x80000000, numRxLanes=[0,10], numTxLanes=[0,10])) #BAY[1] only
    