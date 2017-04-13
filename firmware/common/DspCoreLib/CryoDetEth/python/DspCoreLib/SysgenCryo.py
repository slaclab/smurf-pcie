#!/usr/bin/env python
#-----------------------------------------------------------------------------
# Title      : PyRogue Sysgen Cryo Module
#-----------------------------------------------------------------------------
# File       : SysgenCryo.py
# Created    : 2017-04-04
#-----------------------------------------------------------------------------
# Description:
# PyRogue Sysgen Cryo Module
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

class SysgenCryo(pr.Device):
    def __init__(   self,       
                    name        = "SysgenCryo",
                    description = "Sysgen Cryo Module",
                    memBase     =  None,
                    offset      =  0x00,
                    hidden      =  False,
                ):
        super(self.__class__, self).__init__(name, description, memBase, offset, hidden, )

        ##############################
        # Variables
        ##############################

        self.addVariable(   name         = "Revision",
                            description  = "Sysgen Revision Register",
                            offset       =  0x00,
                            bitSize      =  32,
                            bitOffset    =  0x00,
                            base         = "hex",
                            mode         = "RO",
                        )

        self.addVariables(  name         = "Status",
                            description  = "Status Registers",
                            offset       =  0x04,
                            bitSize      =  32,
                            bitOffset    =  0x00,
                            base         = "hex",
                            mode         = "RO",
                            number       =  8,
                            stride       =  4,
                        )

        self.addVariables(  name         = "Config",
                            description  = "Config Registers",
                            offset       =  0x800,
                            bitSize      =  32,
                            bitOffset    =  0x00,
                            base         = "hex",
                            mode         = "RW",
                            number       =  8,
                            stride       =  4,
                        )

        self.addVariable(   name         = "Scratchpad",
                            description  = "Scratchpad Register defines the bus size",
                            offset       =  0xFFC,
                            bitSize      =  32,
                            bitOffset    =  0x00,
                            base         = "hex",
                            mode         = "RW",
                        )