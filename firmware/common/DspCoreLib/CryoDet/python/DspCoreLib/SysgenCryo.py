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
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        self.add(pr.RemoteVariable(    
            name         = "VersionNumber",
            description  = "Version Number",
            offset       =  0x000,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        
        self.add(pr.RemoteVariable(   
            name         = "muxSelect",
            description  = "Sets the DAC outputs",
            offset       =  0x080,
            bitSize      =  1,
            bitOffset    =  0,
            mode         = "RW",
            enum         = {
                0 : "Adc",
                1 : "SigGen",
            },
        ))        
        
        self.add(pr.RemoteVariable(    
            name         = "StartSigGenReg",
            description  = "Triggers signal generator when the signal generator is in trigger mode (not periodic)",
            offset       =  0x080,
            bitSize      =  1,
            bitOffset    =  1,
            base         = pr.UInt,
            mode         = "RW",
            hidden       =  True,
        ))        
        
        self.add(pr.RemoteVariable(    
            name         = "ScratchPad",
            description  = "Scratch Pad Register",
            offset       =  0xFFC,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        
        ##############################
        # Commands
        ##############################
        @self.command(name="StartSigGen", description="Starts the signal generator pattern",)
        def CmdClearErrors():    
            self.StartSigGenReg.set(1)
            self.StartSigGenReg.set(0)        
        