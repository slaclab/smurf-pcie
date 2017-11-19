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
            name        = "CMB Frequency Tracking Algorithm 16ch version", 
            description = "Alg for tracking 16ch of resonators",
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        
        ##############################
        # Initial/Basic Registers
        ##############################

        #--DSP Core Version
        self.add(pr.RemoteVariable(    
            name         = "VersionNumber",
            description  = "Version Number",
            offset       =  0xF00,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))

        #--Scratchpad Write Register / for test & debug
        self.add(pr.RemoteVariable(    
            name         = "ScratchPad Write",
            description  = "ScratchPad Write",
            offset       =  0xF04,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))

        #--Scratchpad Read Register / broke out separate read 
        self.add(pr.RemoteVariable(    
            name         = "ScratchPad Read",
            description  = "ScratchPad Read",
            offset       =  0xF08,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        
        
        ##############################
        # Control Registers
        ##############################        
        
        
        # #--signal generator start / not used, comment out for now...
        # self.add(pr.RemoteVariable(    
            # name         = "StartSigGenReg",
            # description  = "Triggers signal generator when the signal generator is in trigger mode (not ppe",
            # offset       =  0x080,
            # bitSize      =  1,
            # bitOffset    =  1,
            # base         = pr.UInt,
            # mode         = "RW",
            # hidden       =  True,
        # ))        

        #--Ctrl Reg0_[0]
        self.add(pr.RemoteVariable(   
            name         = "RF_out_ena",
            description  = "Enables RF output",
            offset       =  0x800,
            bitSize      =  1,
            bitOffset    =  0, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "RF Off",
                1 : "RF On",
            },
        ))        

        #--Ctrl Reg0_[1]
        self.add(pr.RemoteVariable(   
            name         = "Ref_Src",
            description  = "Select FTA reference source",
            offset       =  0x800,
            bitSize      =  1,
            bitOffset    =  1, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "EXT Ref", 
                1 : "INT Ref", #--ALWAYS use this for now
            },
        ))        

        #--Ctrl Reg0_[4]
        self.add(pr.RemoteVariable(   
            name         = "FB Polarity",
            description  = "Set polarity of feedback signals at loop filter",
            offset       =  0x800,
            bitSize      =  1,
            bitOffset    =  4, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "NOT Inverted", 
                1 : "Inverted",
            },
        ))        

        #--Ctrl Reg0_[15:8]
        self.add(pr.RemoteVariable(   
            name         = "Status Mux Select",
            description  = "Select which line/channel to view in Status Registers",
            offset       =  0x800,
            bitSize      =  8,
            bitOffset    =  8, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch_0", 
                1 : "Ch_1",
                2 : "Ch_2",
                3 : "Ch_3",
                4 : "Ch_4",
                5 : "Ch_5",
                6 : "Ch_6",
                7 : "Ch_7",
                8 : "Ch_8",
                9 : "Ch_9",
                10 : "Ch_10",
                11 : "Ch_11",
                12 : "Ch_12",
                13 : "Ch_13",
                14 : "Ch_14",
                15 : "Ch_15",
            },
        ))

        #--Ctrl Reg0_[23:16]
        self.add(pr.RemoteVariable(   
            name         = "Debug Mux Select",
            description  = "Select which line/channel is output to Debug ports 0 & 1",
            offset       =  0x800,
            bitSize      =  8,
            bitOffset    =  16, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch_0", 
                1 : "Ch_1",
                2 : "Ch_2",
                3 : "Ch_3",
                4 : "Ch_4",
                5 : "Ch_5",
                6 : "Ch_6",
                7 : "Ch_7",
                8 : "Ch_8",
                9 : "Ch_9",
                10 : "Ch_10",
                11 : "Ch_11",
                12 : "Ch_12",
                13 : "Ch_13",
                14 : "Ch_14",
                15 : "Ch_15",
            },
        ))

        
        
        #--Ctrl Reg0_[24]
        self.add(pr.RemoteVariable(   
            name         = "ADC Ch0 Band A I/Q Data Swap",
            description  = "Swap position of ADC data in Ch0 32b band A data stream",
            offset       =  0x800,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "High Word = Q / Low Word = I", 
                1 : "High Word = I / Low Word = Q",
            },
        ))        

        
        #--Ctrl Reg1_[0]
        self.add(pr.RemoteVariable(   
            name         = "FB Enable",
            description  = "Swap position of ADC data in Ch0 32b band A data stream",
            offset       =  0x804,
            bitSize      =  1,
            bitOffset    =  0, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Feedback ENabled", 
                1 : "Feedback DISabled",
            },
        ))        
        
        #--Ctrl Reg2_[15:0]
        self.add(pr.RemoteVariable(    
            name         = "FB Gain",
            description  = "Sets Gain of FB in 16_12 format",
            offset       =  0x808,
            bitSize      =  16,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))

        
        #--Ctrl Reg3_[7:0]
        self.add(pr.RemoteVariable(    
            name         = "Ref Dly",
            description  = "Sets Delay of Ref relative to system FB delay",
            offset       =  0x80C,
            bitSize      =  8,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))

        #--Ctrl Reg4_[31:16]
        self.add(pr.RemoteVariable(    
            name         = "Output Amplitude",
            description  = "Sets Amplitude of Chan output to DAC",
            offset       =  0x810,
            bitSize      =  16,
            bitOffset    =  16,
            base         = pr.UInt,
            mode         = "RW",
        ))

        #--Ctrl Reg5_[31:16]
        self.add(pr.RemoteVariable(    
            name         = "Feedback Band Limit",
            description  = "Sets Limit of Loop Filter BW",
            offset       =  0x814,
            bitSize      =  16,
            bitOffset    =  16,
            base         = pr.UInt,
            mode         = "RW",
        ))

        #--Ctrl Reg6_[15:0]
        self.add(pr.RemoteVariable(    
            name         = "Notch Bandwidth",
            description  = "Sets BW of the resonators",
            offset       =  0x818,
            bitSize      =  16,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        
          #--Ctrl Reg63_[0]
        self.add(pr.RemoteVariable(    
            name         = "RstLoopFiltBit",
            description  = "Resets the accumulators inside the FB Loop Filter",
            offset       =  0x8FC,
            bitSize      =  1,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
            hidden       =  True,
        ))       


        #---------------------------------------------------------------------------------
        #--Resonator Channel Initial Fquencies and Enable Control Block (16 ch) so far...
        #
        #
        #--Ch0
        #--Ctrl Reg64_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch0 Enable",
            description  = "Enable Processing for Ch0",
            offset       =  0x900,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch0 DISabled", 
                1 : "Ch0 ENAbled",
            },
        ))        
        #--Ctrl Reg64_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch0 Initial Frequency",
            description  = "Ch0 Initial/Center Frequency",
            offset       =  0x900,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----
        
        #--Ch1
        #--Ctrl Reg65_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch1 Enable",
            description  = "Enable Processing for Ch1",
            offset       =  0x904,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch1 DISabled", 
                1 : "Ch1 ENAbled",
            },
        ))        
        #--Ctrl Reg65_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch1 Initial Frequency",
            description  = "Ch1 Initial/Center Frequency",
            offset       =  0x904,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----
        
        #--Ch2
        #--Ctrl Reg66_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch2 Enable",
            description  = "Enable Processing for Ch2",
            offset       =  0x908,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch2 DISabled", 
                1 : "Ch2 ENAbled",
            },
        ))        
        #--Ctrl Reg66_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch2 Initial Frequency",
            description  = "Ch2 Initial/Center Frequency",
            offset       =  0x908,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----    

        #--Ch3
        #--Ctrl Reg67_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch3 Enable",
            description  = "Enable Processing for Ch3",
            offset       =  0x90C,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch3 DISabled", 
                1 : "Ch3 ENAbled",
            },
        ))        
        #--Ctrl Reg67_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch3 Initial Frequency",
            description  = "Ch3 Initial/Center Frequency",
            offset       =  0x90C,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----

        #--Ch4
        #--Ctrl Reg68_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch4 Enable",
            description  = "Enable Processing for Ch4",
            offset       =  0x910,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch4 DISabled", 
                1 : "Ch4 ENAbled",
            },
        ))        
        #--Ctrl Reg68_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch4 Initial Frequency",
            description  = "Ch4 Initial/Center Frequency",
            offset       =  0x910,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----
        
        #--Ch5
        #--Ctrl Reg69_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch5 Enable",
            description  = "Enable Processing for Ch5",
            offset       =  0x914,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch5 DISabled", 
                1 : "Ch5 ENAbled",
            },
        ))        
        #--Ctrl Reg69_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch5 Initial Frequency",
            description  = "Ch5 Initial/Center Frequency",
            offset       =  0x914,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----      

        #--Ch6
        #--Ctrl Reg70_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch6 Enable",
            description  = "Enable Processing for Ch6",
            offset       =  0x918,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch6 DISabled", 
                1 : "Ch6 ENAbled",
            },
        ))        
        #--Ctrl Reg70_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch6 Initial Frequency",
            description  = "Ch6 Initial/Center Frequency",
            offset       =  0x918,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----        
        
        #--Ch7
        #--Ctrl Reg71_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch7 Enable",
            description  = "Enable Processing for Ch7",
            offset       =  0x91C,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch7 DISabled", 
                1 : "Ch7 ENAbled",
            },
        ))        
        #--Ctrl Reg71_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch7 Initial Frequency",
            description  = "Ch7 Initial/Center Frequency",
            offset       =  0x91C,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----        
        
        #--Ch8
        #--Ctrl Reg72_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch8 Enable",
            description  = "Enable Processing for Ch8",
            offset       =  0x920,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch8 DISabled", 
                1 : "Ch8 ENAbled",
            },
        ))        
        #--Ctrl Reg72_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch8 Initial Frequency",
            description  = "Ch8 Initial/Center Frequency",
            offset       =  0x920,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----
        
        #--Ch9
        #--Ctrl Reg73_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch9 Enable",
            description  = "Enable Processing for Ch9",
            offset       =  0x924,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch9 DISabled", 
                1 : "Ch9 ENAbled",
            },
        ))        
        #--Ctrl Reg73_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch9 Initial Frequency",
            description  = "Ch9 Initial/Center Frequency",
            offset       =  0x924,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----
        
        #--Ch10
        #--Ctrl Reg74_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch10 Enable",
            description  = "Enable Processing for Ch10",
            offset       =  0x928,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch10 DISabled", 
                1 : "Ch10 ENAbled",
            },
        ))        
        #--Ctrl Reg74_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch10 Initial Frequency",
            description  = "Ch10 Initial/Center Frequency",
            offset       =  0x928,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----       
        
        #--Ch11
        #--Ctrl Reg75_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch11 Enable",
            description  = "Enable Processing for Ch11",
            offset       =  0x92C,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch11 DISabled", 
                1 : "Ch11 ENAbled",
            },
        ))        
        #--Ctrl Reg75_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch11 Initial Frequency",
            description  = "Ch11 Initial/Center Frequency",
            offset       =  0x92C,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----        
        
        #--Ch12
        #--Ctrl Reg76_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch12 Enable",
            description  = "Enable Processing for Ch12",
            offset       =  0x930,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch12 DISabled", 
                1 : "Ch12 ENAbled",
            },
        ))        
        #--Ctrl Reg76_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch12 Initial Frequency",
            description  = "Ch12 Initial/Center Frequency",
            offset       =  0x930,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----      
        
        #--Ch13
        #--Ctrl Reg77_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch13 Enable",
            description  = "Enable Processing for Ch13",
            offset       =  0x934,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch13 DISabled", 
                1 : "Ch13 ENAbled",
            },
        ))        
        #--Ctrl Reg77_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch13 Initial Frequency",
            description  = "Ch13 Initial/Center Frequency",
            offset       =  0x934,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----       
        
        #--Ch14
        #--Ctrl Reg78_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch14 Enable",
            description  = "Enable Processing for Ch14",
            offset       =  0x938,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch14 DISabled", 
                1 : "Ch14 ENAbled",
            },
        ))        
        #--Ctrl Reg78_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch14 Initial Frequency",
            description  = "Ch14 Initial/Center Frequency",
            offset       =  0x938,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----        
        
        #--Ch15
        #--Ctrl Reg79_[24]
        self.add(pr.RemoteVariable(   
            name         = "Ch15 Enable",
            description  = "Enable Processing for Ch15",
            offset       =  0x93C,
            bitSize      =  1,
            bitOffset    =  24, #--offset from LSB
            mode         = "RW",
            enum         = {
                0 : "Ch15 DISabled", 
                1 : "Ch15 ENAbled",
            },
        ))        
        #--Ctrl Reg79_[23:0]
        self.add(pr.RemoteVariable(   
            name         = "Ch15 Initial Frequency",
            description  = "Ch15 Initial/Center Frequency",
            offset       =  0x93C,
            bitSize      =  24,
            bitOffset    =  0, #--offset from LSB
            base         = pr.UInt,
            mode         = "RW",
        ))        
        #
        #----       
        #
        #--END Resonator Initial Frequcy setting and enable block
        #---------------------------------------------------------------------------------



        #---------------------------------------------------------------------------------
        #--Resonator eta calbration register block (one I/Q pair per channel) 16 ch so far..
        #
        #
        #--Ch0 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch0EtaI",
            description  = "Ch0 Eta I value",
            offset       =  0xA00,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch0 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch0EtaQ",
            description  = "Ch0 Eta Q value",
            offset       =  0xA04,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #
        #--Ch1 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch1EtaI",
            description  = "Ch1 Eta I value",
            offset       =  0xA08,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch1 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch1EtaQ",
            description  = "Ch1 Eta Q value",
            offset       =  0xA0C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #
        #--Ch2 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch2EtaI",
            description  = "Ch2 Eta I value",
            offset       =  0xA10,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch2 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch2EtaQ",
            description  = "Ch2 Eta Q value",
            offset       =  0xA14,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #
        #--Ch3 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch3EtaI",
            description  = "Ch3 Eta I value",
            offset       =  0xA18,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch3 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch3EtaQ",
            description  = "Ch3 Eta Q value",
            offset       =  0xA1C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #
        #--Ch4 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch4EtaI",
            description  = "Ch4 Eta I value",
            offset       =  0xA20,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch4 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch4EtaQ",
            description  = "Ch4 Eta Q value",
            offset       =  0xA24,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #
        #--Ch5 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch5EtaI",
            description  = "Ch5 Eta I value",
            offset       =  0xA28,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch5 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch5EtaQ",
            description  = "Ch5 Eta Q value",
            offset       =  0xA2C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #
        #--Ch6 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch6EtaI",
            description  = "Ch6 Eta I value",
            offset       =  0xA30,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch6 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch6EtaQ",
            description  = "Ch6 Eta Q value",
            offset       =  0xA34,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #
        #--Ch7 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch7EtaI",
            description  = "Ch7 Eta I value",
            offset       =  0xA38,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch7 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch7EtaQ",
            description  = "Ch7 Eta Q value",
            offset       =  0xA3C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #
         #--Ch8 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch8EtaI",
            description  = "Ch8 Eta I value",
            offset       =  0xA40,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch8 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch8EtaQ",
            description  = "Ch8 Eta Q value",
            offset       =  0xA44,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #
        #--Ch9 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch9EtaI",
            description  = "Ch9 Eta I value",
            offset       =  0xA48,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch9 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch9EtaQ",
            description  = "Ch9 Eta Q value",
            offset       =  0xA4C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #
        #--Ch10 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch10EtaI",
            description  = "Ch10 Eta I value",
            offset       =  0xA50,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch10 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch10EtaQ",
            description  = "Ch10 Eta Q value",
            offset       =  0xA54,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #
        #--Ch11 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch11EtaI",
            description  = "Ch11 Eta I value",
            offset       =  0xA58,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch11 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch11EtaQ",
            description  = "Ch11 Eta Q value",
            offset       =  0xA5C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #       
         #--Ch12 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch12EtaI",
            description  = "Ch12 Eta I value",
            offset       =  0xA60,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch12 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch12EtaQ",
            description  = "Ch12 Eta Q value",
            offset       =  0xA64,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #
        #--Ch13 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch13EtaI",
            description  = "Ch13 Eta I value",
            offset       =  0xA68,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch13 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch13EtaQ",
            description  = "Ch13 Eta Q value",
            offset       =  0xA6C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #
        #--Ch14 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch14EtaI",
            description  = "Ch14 Eta I value",
            offset       =  0xA70,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch14 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch14EtaQ",
            description  = "Ch14 Eta Q value",
            offset       =  0xA74,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #
        #--Ch15 eta I
        self.add(pr.RemoteVariable(    
            name         = "Ch15EtaI",
            description  = "Ch15 Eta I value",
            offset       =  0xA78,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #--Ch15 eta Q
        self.add(pr.RemoteVariable(    
            name         = "Ch15EtaQ",
            description  = "Ch15 Eta Q value",
            offset       =  0xA7C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        #----
        #       
        #
        #--END Resonator eta calbration register block
        #---------------------------------------------------------------------------------
        
        
        #--Ctrl Reg128_[15:0]
        self.add(pr.RemoteVariable(    
            name         = "ADC0 Band_A DAC IF Band Mixer LO Freq",
            description  = "Sets the LO frequency of ADC0 Ch0 Band A mixer for DAC",
            offset       =  0xB00,
            bitSize      =  16,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))
        
        
        ##############################
        # Status Registers
        ##############################        
        
        #--Status Reg0_[23:0]
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for selected channel",
            description  = "Displays the Computed Frequency of selected channel",
            offset       =  0x000,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        
        #--Status Reg1_[23:0]
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for selected channel",
            description  = "Displays the FB Frequency error of selected channel",
            offset       =  0x004,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        
        #--------------------------------------------------------
        #--F(n) & dF(n) Readback Block for all channels
        #
        #--Ch0 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch0",
            description  = "Displays the Computed Frequency of Ch0",
            offset       =  0x100,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch0 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch0",
            description  = "Displays the FB Frequency error of Ch0",
            offset       =  0x104,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #
        #--Ch1 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch1",
            description  = "Displays the Computed Frequency of Ch1",
            offset       =  0x108,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch1 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch1",
            description  = "Displays the FB Frequency error of Ch1",
            offset       =  0x10C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #
        #--Ch2 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch2",
            description  = "Displays the Computed Frequency of Ch2",
            offset       =  0x110,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch2 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch2",
            description  = "Displays the FB Frequency error of Ch2",
            offset       =  0x114,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #
        #--Ch3 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch3",
            description  = "Displays the Computed Frequency of Ch3",
            offset       =  0x118,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch3 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch3",
            description  = "Displays the FB Frequency error of Ch3",
            offset       =  0x11C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #       
        #--Ch4 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch4",
            description  = "Displays the Computed Frequency of Ch4",
            offset       =  0x120,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch4 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch4",
            description  = "Displays the FB Frequency error of Ch4",
            offset       =  0x124,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #
        #--Ch5 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch5",
            description  = "Displays the Computed Frequency of Ch5",
            offset       =  0x128,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch5 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch5",
            description  = "Displays the FB Frequency error of Ch5",
            offset       =  0x12C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #
        #--Ch6 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch6",
            description  = "Displays the Computed Frequency of Ch6",
            offset       =  0x130,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch6 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch6",
            description  = "Displays the FB Frequency error of Ch6",
            offset       =  0x134,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #
        #--Ch7 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch7",
            description  = "Displays the Computed Frequency of Ch7",
            offset       =  0x138,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch7 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch7",
            description  = "Displays the FB Frequency error of Ch7",
            offset       =  0x13C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #  
        #--Ch8 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch8",
            description  = "Displays the Computed Frequency of Ch8",
            offset       =  0x140,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch8 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch8",
            description  = "Displays the FB Frequency error of Ch8",
            offset       =  0x144,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #
        #--Ch9 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch9",
            description  = "Displays the Computed Frequency of Ch9",
            offset       =  0x148,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch9 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch9",
            description  = "Displays the FB Frequency error of Ch9",
            offset       =  0x14C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #
        #--Ch10 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch10",
            description  = "Displays the Computed Frequency of Ch10",
            offset       =  0x150,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch10 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch10",
            description  = "Displays the FB Frequency error of Ch10",
            offset       =  0x154,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #
        #--Ch11 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch11",
            description  = "Displays the Computed Frequency of Ch11",
            offset       =  0x158,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch11 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch11",
            description  = "Displays the FB Frequency error of Ch11",
            offset       =  0x15C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #
        #--Ch12 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch12",
            description  = "Displays the Computed Frequency of Ch12",
            offset       =  0x160,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch12 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch12",
            description  = "Displays the FB Frequency error of Ch12",
            offset       =  0x164,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #
        #--Ch13 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch13",
            description  = "Displays the Computed Frequency of Ch13",
            offset       =  0x168,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch13 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch13",
            description  = "Displays the FB Frequency error of Ch13",
            offset       =  0x16C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #
        #--Ch14 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch14",
            description  = "Displays the Computed Frequency of Ch14",
            offset       =  0x170,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch14 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch14",
            description  = "Displays the FB Frequency error of Ch14",
            offset       =  0x174,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #
        #--Ch15 Freq
        self.add(pr.RemoteVariable(    
            name         = "Computed Frequency Fi(n) + dF(n) for Ch15",
            description  = "Displays the Computed Frequency of Ch15",
            offset       =  0x178,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #--Ch15 dF
        self.add(pr.RemoteVariable(    
            name         = "FB Frequency Error dF(n) for Ch15",
            description  = "Displays the FB Frequency error of Ch15",
            offset       =  0x17C,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))
        #----
        #
        #--END F(n) & dF(n) Readback Block for all channels
        #--------------------------------------------------------
        
        
        
        ##############################
        # Commands
        ##############################
        
        # @self.command(description="Starts the signal generator pattern",)
        # def CmdClearErrors():    
            # self.StartSigGenReg.set(1)
            # self.StartSigGenReg.set(0)        

        @self.command(description="Resets the FB Loop Filter Accumulators",)
        def ResetLoopFilter():    
            self.RstLoopFiltBit.set(1)
            self.RstLoopFiltBit.set(0)        
