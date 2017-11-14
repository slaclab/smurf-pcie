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

        
class CryoChannel:
    def __init__(   self, 
            name        = "Cryo frequency cord", 
            description = "Note: This module is read-only with respect to sysgen", 
            hidden      = False,
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        ##############################
        # Configuration registers (RO from Sysgen)
        ##############################          
        # Cryo channel frequency word
        self.addRemoteVariables(   
            name         = "feedbackEnable",
            description  = "Enable feedback on this channel",
            offset       =  0x1000,
            bitSize      =  1,
            bitOffset    =  32,
            base         = pr.UInt,
            mode         = "RW",
        )

        self.addRemoteVariables(   
            name         = "amplitdueScale",
            description  = "Amplitdue scale",
            offset       =  0x0,
            bitSize      =  4,
            bitOffset    =  24,
            base         = pr.UInt,
            mode         = "RW",
        )

        self.addRemoteVariables(   
            name         = "centerFrequency",
            description  = "Center frequency",
            offset       =  0x0,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        )
	
        # Cryo channel ETA
        self.addRemoteVariables(   
            name         = "ETA",
            description  = "ETA",
            offset       =  0x800,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        )

        ##############################
        # Readback register (WO from Sysgen)
        ##############################          
        # Cryo channel readback frequency error
        self.addRemoteVariables(   
            name         = "frequencyError",
            description  = "Frequency error",
            #offset       =  0x0000,
            offset       =  0x1000,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        )

        # Cryo channel readback loop filter output
        self.addRemoteVariables(   
            name         = "loopFilterOutput",
            description  = "Loop filter output",
            #offset       =  0x0800,
            offset       =  0x1800,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        )


class CryoFrequencyBand(pr.Device):
    def __init__(   self, 
            name        = "CryoFrequencyBand", 
            description = "Note: This module is read-only with respect to sysgen", 
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        
#        ##############################
#        # Devices
#        ##############################          
        for i in range(512):
            self.add(CryoChannel(
                name   = ('CryoChannel[%d]'%i), 
                offset = (i*0x4), 
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
        self.add(CryoFrequencyBand(
            name   = 'CryoFrequencyBand', 
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
        
