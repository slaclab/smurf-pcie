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

from AppHardware.MicrowaveMux._microwaveMuxCore import *
from DspCoreLib.SysgenMicrowaveMux import *

class AppCore(pr.Device):
    def __init__(   self, 
            name        = "AppCore", 
            description = "MicrowaveMux Application", 
            numRxLanes  =  [0,0], 
            numTxLanes  =  [0,0],                    
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        for i in range(2):
            if ((numRxLanes[i] > 0) or (numTxLanes[i] > 0)):
                self.add(MicrowaveMuxCore(
                    name    = "MicrowaveMuxCore[%i]" % (i),
                    offset  = (i*0x00100000),
                    expand  = True,
                ))        
        self.add(SysgenMicrowaveMux(offset=0x01000000))
        