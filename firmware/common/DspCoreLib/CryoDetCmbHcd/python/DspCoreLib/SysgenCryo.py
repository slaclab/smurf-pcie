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

class SysgenCryoBramReadWrite(pr.Device):
    def __init__(   self, 
            name        = "SysgenCryoBramReadWrite", 
            description = "Note: This module is read-only with respect to sysgen", 
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        ##############################
        # Registers
        ##############################          
        self.addRemoteVariables(   
            name         = "Reg",
            description  = "",
            offset       =  0x0,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
            number       =  128,
            stride       =  4,
            hidden       = True, # Set hidden by default to prevent GUI from starting up slowly
        )
        
class SysgenCryoBramReadOnly(pr.Device):
    def __init__(   self, 
            name        = "SysgenCryoBramReadOnly", 
            description = "Note: This module is Write-only with respect to sysgen", 
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        ##############################
        # Registers
        ##############################          
        self.addRemoteVariables(   
            name         = "Reg",
            description  = "",
            offset       =  0x0,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
            number       =  128,
            stride       =  4,
            hidden       = True, # Set hidden by default to prevent GUI from starting up slowly
        )        

class SysgenCryoBram(pr.Device):
    def __init__(   self, 
            name        = "SysgenCryoBram", 
            description = "Cryo SYSGEN Module", 
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
        
        ##############################
        # Devices
        ##############################          
        for i in range(8):
            self.add(SysgenCryoBramReadWrite(
                name   = ('ReadWrite[%d]'%i), 
                offset = (i*0x1000), 
                expand = False,
            ))              
        
        for i in range(8):
            self.add(SysgenCryoBramReadOnly(
                name   = ('ReadOnly[%d]'%i), 
                offset = (i*0x1000 + 0x8000), 
                expand = False,
            )) 
            
class SysgenCryoBase(pr.Device):
    def __init__(   self, 
            name        = "SysgenCryoBase", 
            description = "Cryo SYSGEN Module", 
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        ##############################
        # Devices
        ##############################        
        self.add(SysgenCryoBram(
            name   = 'Bram', 
            offset = 0x00010000, 
            expand = False,
        ))
        
        ##############################
        # Registers
        ##############################  
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
            name         = "ScratchPad",
            description  = "Scratch Pad Register",
            offset       =  0xFFC,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        
        # ##############################
        # # Commands
        # ##############################
        # @self.command(description="Starts the signal generator pattern",)
        # def CmdClearErrors():    
            # self.StartSigGenReg.set(1)
            # self.StartSigGenReg.set(0)

class SysgenCryo(pr.Device):
    def __init__(   self, 
            name        = "SysgenCryo", 
            numberPairs = 1, 
            description = "Cryo SYSGEN Module", 
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)        
        
        ##############################
        # Devices
        ##############################        
        for i in range(numberPairs):
            if ( i<8 ) and ( i>=0) : 
                self.add(SysgenCryoBase(
                    name   = ('Base[%d]'%i), 
                    offset = (i*0x00100000), 
                    expand = False,
                )) 
        