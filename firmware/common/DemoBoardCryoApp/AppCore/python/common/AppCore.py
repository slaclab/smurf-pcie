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

from AppHardware.AmcCryoDemo import *
from DspCoreLib.SysgenCryo import *

class AppCore(pr.Device):
    def __init__(   self, 
                    name        = "AppCore", 
                    description = "AMC Carrier Cryo Demo Board Application", 
                    memBase     =  None, 
                    offset      =  0x0, 
                    hidden      =  False,
                    expand      =  True
                ):
        super(self.__class__, self).__init__(name, description, memBase, offset, hidden, expand)

        ##############################
        # Variables
        ##############################

        #for i in range(2):
        #    self.add(AmcCryoDemoCore(
        #                                name         = "AmcCryoDemoCore_%i" % (i),
        #                                offset       =  0x00000000 + (i * 0x00100000),
        #                            ))
        self.add(AmcCryoDemoCore(
                                    name         = "AmcCryoDemoCore_1",
                                    offset       =  0x00100000,
                                ))

        self.add(SysgenCryo(
                                offset       =  0x01000000
                            ))

        self.addVariables(  name         = "DacMuxSel",
                            description  = "Select between: 0 System Generator to DAC, 1 Signal Generator to DAC.",
                            offset       =  0x02000000,
                            bitSize      =  1,
                            bitOffset    =  0x00,
                            base         = "hex",
                            mode         = "RO",
                            number       =  2,
                            stride       =  0x01000000,
)
