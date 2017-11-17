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

        
class CryoChannel(pr.Device):
    def __init__(   self, 
            name        = "Cryo frequency cord", 
            description = "Note: This module is read-only with respect to sysgen", 
            hidden      = True,
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        ##############################
        # Configuration registers (RO from Sysgen)
        ##############################          

        # Cryo channel ETA
        self.add(pr.RemoteVariable(   
            name         = "etaMag",
            description  = "ETA mag Fix_16_10",
            offset       =  0x0000,
            bitSize      =  16,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))

        self.add(pr.RemoteVariable(   
            name         = "etaPhase",
            description  = "ETA phase Fix_16_15",
            offset       =  0x0002,
            bitSize      =  16,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))

        # Cryo channel frequency word
        self.add(pr.RemoteVariable(   
            name         = "feedbackEnable",
            description  = "Enable feedback on this channel UFix_1_0",
            offset       =  0x0800,
            bitSize      =  1,
            bitOffset    =  32,
            base         = pr.UInt,
            mode         = "RW",
        ))

        self.add(pr.RemoteVariable(   
            name         = "amplitdueScale",
            description  = "Amplitdue scale UFix_4_0",
            offset       =  0x0800,
            bitSize      =  4,
            bitOffset    =  24,
            base         = pr.UInt,
            mode         = "RW",
        ))

        self.add(pr.RemoteVariable(   
            name         = "centerFrequency",
            description  = "Center frequency UFix_24_24",
            offset       =  0x0800,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
	

        ##############################
        # Readback register (WO from Sysgen)
        ##############################          

        # Cryo channel readback loop filter output
        self.add(pr.RemoteVariable(   
            name         = "loopFilterOutput",
            description  = "Loop filter output UFix_24_24",
            offset       =  0x1000,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))

        self.add(pr.RemoteVariable(   
            name         = "amplitudeReadback",
            description  = "Loop filter output UFix_4_0",
            offset       =  0x1000,
            bitSize      =  4,
            bitOffset    =  24,
            base         = pr.UInt,
            mode         = "RO",
        ))

        # Cryo channel readback frequency error
        self.add(pr.RemoteVariable(   
            name         = "frequencyError",
            description  = "Frequency error Fix_24_23",
            offset       =  0x1800,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))



class CryoChannels(pr.Device):
    def __init__(   self, 
            name        = "CryoFrequencyBand", 
            description = "Note: This module is read-only with respect to sysgen", 
            hidden      = True,
            **kwargs):
        super().__init__(name=name, description=description, hidden=hidden, **kwargs)

        
#        ##############################
#        # Devices
#        ##############################          
        for i in range(512):
            self.add(CryoChannel(
                name   = ('CryoChannel[%d]'%i), 
                offset = (i*0x4), 
                expand = False,
            ))              
            
class CryoFreqBand(pr.Device):
    def __init__(   self, 
            name        = "SysgenCryoBase", 
            description = "Cryo SYSGEN Module", 
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        ##############################
        # Devices
        ##############################        
        self.add(CryoChannels(
            name   = 'CryoChannels', 
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

## config0
        self.add(pr.RemoteVariable(    
            name         = "waveformSelect",
            description  = "Select waveform table",
            offset       =  0x80,
            bitSize      =  1,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        self.add(pr.RemoteVariable(    
            name         = "waveformStart",
            description  = "Start waveform counter",
            offset       =  0x80,
            bitSize      =  1,
            bitOffset    =  1,
            base         = pr.UInt,
            mode         = "RW",
        ))
        self.add(pr.RemoteVariable(    
            name         = "rfEnable",
            description  = "Enable RF output",
            offset       =  0x80,
            bitSize      =  1,
            bitOffset    =  2,
            base         = pr.UInt,
            mode         = "RW",
        ))
## config0  end

## config1
        self.add(pr.RemoteVariable(    
            name         = "iqSwapOut",
            description  = "Swap IQ channels on output",
            offset       =  0x84,
            bitSize      =  1,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        
        self.add(pr.RemoteVariable(    
            name         = "iqSwapIn",
            description  = "Swap IQ channels on input",
            offset       =  0x84,
            bitSize      =  1,
            bitOffset    =  1,
            base         = pr.UInt,
            mode         = "RW",
        ))
## config1  end
        
## config2
        self.add(pr.RemoteVariable(    
            name         = "refPhaseDelay",
            description  = "Nubmer of cycles to delay phase referenece",
            offset       =  0x88,
            bitSize      =  3,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        
        self.add(pr.RemoteVariable(    
            name         = "toneScale",
            description  = "Scale the sum of 16 tones before synthesizer",
            offset       =  0x88,
            bitSize      =  1,
            bitOffset    =  3,
            base         = pr.UInt,
            mode         = "RW",
        ))
        
        self.add(pr.RemoteVariable(    
            name         = "feedbackEnable",
            description  = "Global feedback enable",
            offset       =  0x88,
            bitSize      =  1,
            bitOffset    =  5,
            base         = pr.UInt,
            mode         = "RW",
        ))
        
        self.add(pr.RemoteVariable(    
            name         = "feedbackPolarity",
            description  = "Global feedback polarity",
            offset       =  0x88,
            bitSize      =  1,
            bitOffset    =  6,
            base         = pr.UInt,
            mode         = "RW",
        ))

        self.add(pr.RemoteVariable(    
            name         = "swapDfIQ",
            description  = "Swap DF IQ",
            offset       =  0x88,
            bitSize      =  1,
            bitOffset    =  7,
            base         = pr.UInt,
            mode         = "RW",
        ))

        self.add(pr.RemoteVariable(    
            name         = "statusChannelSelect",
            description  = "Select channel for status registers",
            offset       =  0x88,
            bitSize      =  9,
            bitOffset    =  8,
            base         = pr.UInt,
            mode         = "RW",
        ))
## config2  end

## config3
        self.add(pr.RemoteVariable(    
            name         = "feedbackGain",
            description  = "Feedback gain UFix_16_12",
            offset       =  0x8C,
            bitSize      =  16,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        self.add(pr.RemoteVariable(    
            name         = "feedbackLimit",
            description  = "Feedback limit UFix_16_16",
            offset       =  0x8C,
            bitSize      =  16,
            bitOffset    =  16,
            base         = pr.UInt,
            mode         = "RW",
        ))
## config3  end
       

## status1
        self.add(pr.RemoteVariable(    
            name         = "Q",
            description  = "Q readback Fix_16_15",
            offset       =  0x08,
            bitSize      =  16,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        self.add(pr.RemoteVariable(    
            name         = "I",
            description  = "I readback Fix_16_15",
            offset       =  0x08,
            bitSize      =  16,
            bitOffset    =  16,
            base         = pr.UInt,
            mode         = "RO",
        ))
## status1 end 

## status 2
        self.add(pr.RemoteVariable(    
            name         = "dspCounter",
            description  = "32 bit counter, dsp clock domain UFix_32_0",
            offset       =  0x0C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
## status2 end 
        
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
            if ( i<2 ) and ( i>=0) : 
                self.add(CryoFreqBand(
                    name   = ('Base[%d]'%i), 
                    offset = (i*0x00100000), 
                    expand = False,
                )) 
        
