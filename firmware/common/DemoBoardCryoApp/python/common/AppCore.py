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

from AmcCryoDemo.AmcCryoDemoCore import *
from DspCoreLib.SysgenCryo import *

class AppCore(pr.Device):
    def __init__(self, name="AppCore", description="AMC Carrier Cryo Demo Board Application", memBase=None, offset=0x0, hidden=False):
        super(self.__class__, self).__init__(name, description, memBase, offset, hidden)

        ##############################
        # Variables
        ##############################

        for i in range(2):
            self.add(AmcCryoDemoCore(
                                    name         = "AmcCryoDemoCore_%i" % (i),
                                    offset       =  0x00000000 + (i * 0x00100000),
                                ))

        self.add(SysgenCryo(
                                offset       =  0x01000000
                            ))

        for i in range(2):
            self.add(pr.Variable(   name         = "DacMuxSel_%i" % (i),
                                    description  = "Select between: 0 System Generator to DAC, 1 Signal Generator to DAC. DaqMuxSel %i" % (i),
                                    offset       =  0x02000000 + (i * 0x01000000),
                                    bitSize      =  1,
                                    bitOffset    =  0x00,
                                    base         = "hex",
                                    mode         = "RO",
                                ))