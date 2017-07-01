#!/usr/bin/env python
#-----------------------------------------------------------------------------
# Title      : PyRogue AMC Carrier Cryo Demo Board Application
#-----------------------------------------------------------------------------
# File       : SysgenCryo.py
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

class SysgenCryo(pr.Device):
    def __init__(   self, 
        name        = "SysgenCryo", 
        description = "Cryo SYSGEN Module", 
        memBase     =  None, 
        offset      =  0x0, 
        hidden      =  False,         
        expand      =  True,
    ):
        super().__init__(
            name        = name,
            description = description,
            memBase     = memBase,
            offset      = offset,
            hidden      = hidden,
            expand      = expand,
        )

        self.addVariable(   
            name         = "VersionNumber",
            description  = "Version Number",
            offset       =  0x000,
            bitSize      =  32,
            bitOffset    =  0,
            base         = "hex",
            mode         = "RO",
        )
        
        self.addVariable(   
            name         = "ScratchPad",
            description  = "Scratch Pad Register",
            offset       =  0xFFC,
            bitSize      =  32,
            bitOffset    =  0,
            base         = "hex",
            mode         = "RW",
        )        
        