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
            description  = "Triggers signal generator when the signal generator is in trigger mode (not ppe",
            offset       =  0x080,
            bitSize      =  1,
            bitOffset    =  1,
            base         = pr.UInt,
            mode         = "RW",
            hidden       =  True,
        ))        
        
        self.add(pr.RemoteVariable(    
            name         = "Ch0MuxSel",
            description  = "Mux Selects for Ch0 ADC & DAC Only",
            offset       =  0x080,
            bitSize      =  2,
            bitOffset    =  2,
            mode         = "RW",
            enum         = {
                0 : "AtoDThru",
                1 : "DACMem",
				2 : "DUC",
				3 : "SineGen",
            },
        ))        
		
        self.add(pr.RemoteVariable(   
            name         = "Ch0B1CjEn",
            description  = "Selects whether or not to conjugate the NCO Sine term for complex multiply",
            offset       =  0x084,
            bitSize      =  1,
            bitOffset    =  0,
            mode         = "RW",
            enum         = {
                0 : "CH0_B1_Norm",
                1 : "CH0_B1_Conj",
            },
        ))        

        self.add(pr.RemoteVariable(   
            name         = "Ch0B2CjEn",
            description  = "Selects whether or not to conjugate the NCO Sine term for complex multiply",
            offset       =  0x084,
            bitSize      =  1,
            bitOffset    =  1,
            mode         = "RW",
            enum         = {
                0 : "CH0_B2_Norm",
                1 : "CH0_B2_Conj",
            },
        ))        

        self.add(pr.RemoteVariable(    
            name         = "Ch0FLO1",
            description  = "Sets DDS frequency for LO1",
            offset       =  0x088,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "WO",
        ))
		
        self.add(pr.RemoteVariable(    
            name         = "Ch0FLO2",
            description  = "Sets DDS frequency for LO2",
            offset       =  0x08C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "WO",
        ))

        self.add(pr.RemoteVariable(    
            name         = "SineGenPhsInc",
            description  = "Sets DDS frequency (via phase increment value)for Prog IQ Sinewave Generator",
            offset       =  0x090,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "WO",
        ))

        self.add(pr.RemoteVariable(    
            name         = "LO1_Poff",
            description  = "LO1 Phase offset setting",
            offset       =  0x094,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "WO",
        ))

        self.add(pr.RemoteVariable(    
            name         = "LO2_Poff",
            description  = "LO2 Phase offset setting",
            offset       =  0x098,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "WO",
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
        @self.command(description="Starts the signal generator pattern",)
        def CmdClearErrors():    
            self.StartSigGenReg.set(1)
            self.StartSigGenReg.set(0)        
        