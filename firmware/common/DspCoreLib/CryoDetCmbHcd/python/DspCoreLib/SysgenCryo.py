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
##import time

class CryoChannel(pr.Device):
    def __init__(   self,
            name        = "Cryo frequency cord",
            description = "Note: This module is read-only with respect to sysgen",
            hidden      = True,
            **kwargs):
        super().__init__(name=name, description=description, hidden=hidden, **kwargs)

        freqSpanMHz = 38.4
        ##############################
        # Configuration registers (RO from Sysgen)
        ##############################

        # Cryo channel ETA
        self.add(pr.RemoteVariable(
            name         = "etaMag",
            hidden       = True,
            description  = "ETA mag Fix_16_10",
            offset       =  0x0000,
            bitSize      =  16,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))

        self.add(pr.LinkVariable(
            name         = "etaMagScaled",
            description  = "ETA mag scaled",
            dependencies = [self.etaMag],
            linkedGet    = lambda: self.etaMag.get(read=False)*2**-10,
            linkedSet    = lambda value: self.etaMag.set(round(value*2**10)),
        ))

        self.add(pr.RemoteVariable(
            name         = "etaPhase",
            hidden       = True,
            description  = "ETA phase Fix_16_15",
            offset       =  0x0002,
            bitSize      =  16,
            bitOffset    =  0,
            base         = pr.Int,
            mode         = "RW",
        ))

        self.add(pr.LinkVariable(
            name         = "etaPhaseDegree",
            description  = "ETA phase degrees",
            dependencies = [self.etaPhase],
            linkedGet    = lambda: self.etaPhase.get(read=False)*180*2**-15,
            linkedSet    = lambda value: self.etaPhase.set(round(value*2**15./180)),
        ))

        # Cryo channel frequency word
        self.add(pr.RemoteVariable(
            name         = "feedbackEnable",
            description  = "Enable feedback on this channel UFix_1_0",
            offset       =  0x0800,
            bitSize      =  1,
            bitOffset    =  31,
            base         = pr.UInt,
            mode         = "RW",
        ))

        self.add(pr.RemoteVariable(
            name         = "amplitudeScale",
            description  = "Amplitdue scale UFix_4_0",
            offset       =  0x0800,
            bitSize      =  4,
            bitOffset    =  24,
            base         = pr.UInt,
            mode         = "RW",
        ))

        self.add(pr.RemoteVariable(
            name         = "centerFrequency",
            hidden       = True,
            description  = "Center frequency UFix_24_24",
            offset       =  0x0800,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))

        self.add(pr.LinkVariable(
            name         = "centerFrequencyMHz",
            description  = "Center frequency MHz",
            dependencies = [self.centerFrequency],
            linkedGet    = lambda: self.centerFrequency.get(read=False)*2**-24*freqSpanMHz,
            linkedSet    = lambda value: self.centerFrequency.set(round((value*2**24./freqSpanMHz))),
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
#            pollInterval = 1,
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
            description  = "Frequency error MHz",
            hidden       = True,
            offset       =  0x1800,
            bitSize      =  24,
            bitOffset    =  0,
            base         = pr.Int,
            mode         = "RO",
        ))

        self.add(pr.LinkVariable(
            name         = "frequencyErrorMHz",
            description  = "Frequency error Fix_24_23",
            mode         = "RO",
            dependencies = [self.frequencyError],
            linkedGet    = lambda: self.frequencyError.get(read=False)*2**-23*freqSpanMHz,
        ))






class CryoChannels(pr.Device):
    def __init__(   self,
            name        = "CryoFrequencyBand",
            description = "Note: This module is read-only with respect to sysgen",
            hidden      = False,
            **kwargs):
        super().__init__(name=name, description=description, hidden=hidden, **kwargs)


#        ##############################
#        # Devices
#        ##############################
        for i in range(512):
            self.add(CryoChannel(
                name   = ('CryoChannel[%d]'%i),
                offset = (i*0x4),
                hidden = (i % 16 != 0),
                expand = False,
            ))

        self.add(pr.LocalVariable(
            name        = "etaScanBand",
            description = "etaScan frequency band",
            mode        = "RW",
            value       = 0,
        ))

        self.add(pr.LocalVariable(
            name        = "etaScanFreqs",
            description = "etaScan frequencies",
            mode        = "RW",
            value       = [0.0 for x in range(100)],
        ))

        self.add(pr.LocalVariable(
            name        = "etaScanResultsImag",
            description = "etaScan frequencies",
            mode        = "RW",
            value       = [0.0 for x in range(100)],
        ))

        self.add(pr.LocalVariable(
            name        = "etaScanResultsReal",
            description = "etaScan frequencies",
            mode        = "RW",
            value       = [0.0 for x in range(100)],
        ))

        self.add(pr.LocalVariable(
            name        = "etaScanDwell",
            description = "etaScan frequencies",
            mode        = "RW",
            value       = 0.0,
        ))

        self.add(pr.LocalVariable(
            name        = "etaScanAmplitude",
            description = "number of points to average for etaScan",
            mode        = "RW",
            value       = 0,
        ))

        @self.command(description="Run etaScan",)
        def runEtaScan():
            band    = self.etaScanBand.get()
            subchan = 16*band
            print( subchan )
            ampl    = self.etaScanAmplitude.get()
            freqs   = self.etaScanFreqs.get()
            # workaround for rogue local variables
            # list objects get written as string, not list of float
            # when set by GUI
            if isinstance(freqs, str):
                freqs = eval(freqs)

            dwell   = self.etaScanDwell.get()

            self.CryoChannel[subchan].amplitudeScale.set( ampl )
            self.CryoChannel[subchan].etaMagScaled.set( 1 )


            # run scan in phase
            self.CryoChannel[subchan].etaPhaseDegree.set( 0 )
            resultsReal = []

            print( freqs )
            for freqMHz in freqs:
                print( freqMHz )
            for freqMHz in freqs:
                # is there overhead of setting freqMHz if prevFreqMHz == freqMHz
                self.CryoChannel[subchan].centerFrequencyMHz.set( freqMHz )
                # do we need a dwell?
                freqError = self.CryoChannel[subchan].frequencyError.get()
                resultsReal.append( freqError )

            # run scan in quadrature
            self.CryoChannel[subchan].etaPhaseDegree.set( -90 )
            resultsImag = []

            for freqMHz in freqs:
                self.CryoChannel[subchan].centerFrequencyMHz.set( freqMHz )
                # do we need a dwell?
                freqError = self.CryoChannel[subchan].frequencyError.get()
                resultsImag.append( freqError )

            self.etaScanResultsReal.set( resultsReal )
            self.etaScanResultsImag.set( resultsImag )


        @self.command(description="Set all amplitudeScale values",value=0)
        def setAmplitudeScales(arg):
            for c in self.CryoChannel.values():
                c.amplitudeScale.setDisp(arg, write=False)

            # Commit blocks with bulk background writes
            self.writeBlocks()

            # Verify the blocks with background transactions
            self.verifyBlocks()

            # Check write and verify results
            self.checkBlocks()


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
            bitSize      =  2,
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

## config4
        self.add(pr.RemoteVariable(
            name         = "filterAlpha",
            description  = "IIR filter alpha UFix16_15",
            offset       =  0x90,
            bitSize      =  16,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))

## config4 end
        self.add(pr.RemoteVariable(
            name         = "loopFilterOutputSel",
            description  = "Global loop filter out reg.  Select with ",
            offset       =  0x94,
            bitSize      =  7,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))

        self.add(pr.RemoteVariable(
            name         = "analysisScale",
            description  = "analysis filter bank scale, nominal value is 1",
            offset       =  0x98,
            bitSize      =  2,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))

        self.add(pr.RemoteVariable(
            name         = "synthesisScale",
            description  = "synthesis filter bank scale, nominal value is 2",
            offset       =  0x98,
            bitSize      =  2,
            bitOffset    =  2,
            base         = pr.UInt,
            mode         = "RW",
        ))

        self.add(pr.RemoteVariable(
            name         = "decimation",
            description  = "debug decimation rate 0...7",
            offset       =  0x98,
            bitSize      =  3,
            bitOffset    =  4,
            base         = pr.UInt,
            mode         = "RW",
        ))

        self.add(pr.RemoteVariable(
            name         = "singleChannelReadout",
            description  = "select for single channel readout",
            offset       =  0x9C,
            bitSize      =  1,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))

        self.add(pr.RemoteVariable(
            name         = "singleChannelReadoutOpt2",
            description  = "non-decimated single channel readout - rate 307.2e6/128",
            offset       =  0x9C,
            bitSize      =  1,
            bitOffset    =  10,
            base         = pr.UInt,
            mode         = "RW",
        ))


        self.add(pr.RemoteVariable(
            name         = "readoutChannelSelect",
            description  = "select for single channel readout",
            offset       =  0x9C,
            bitSize      =  9,
            bitOffset    =  1,
            base         = pr.UInt,
            mode         = "RW",
        ))



        self.add(pr.RemoteVariable(
            name         = "dspReset",
            description  = "reset DSP core",
            offset       =  0x100,
            bitSize      =  1,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
        ))


        self.add(pr.RemoteVariable(
            name         = "refPhaseDelayFine",
            description  = "fine delay control (307.2MHz clock)",
            offset       =  0x100,
            bitSize      =  8,
            bitOffset    =  1,
            base         = pr.UInt,
            mode         = "RW",
        ))





## status1
        self.add(pr.RemoteVariable(
            name         = "Q",
            description  = "Q readback Fix_16_15",
            offset       =  0x08,
            bitSize      =  16,
            bitOffset    =  0,
            base         = pr.Int,
            mode         = "RO",
##            pollInterval = 1,
        ))
        self.add(pr.RemoteVariable(
            name         = "I",
            description  = "I readback Fix_16_15",
            offset       =  0x08,
            bitSize      =  16,
            bitOffset    =  16,
            base         = pr.Int,
            mode         = "RO",
##            pollInterval = 1,
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
        self.add(pr.RemoteVariable(
            name         = "loopFilterOutput",
            description  = "Loop filter output UFix_32_0",
            offset       =  0x10,
            bitSize      =  32,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RO",
        ))


#        for i in range(512):
#            if (i % 16 == 0) :
#                self.CryoChannels.CryoChannel[i].centerFrequency.addListener(self.UpdateIQ)

        # ##############################
        # # Commands
        # ##############################
        # @self.command(description="Starts the signal generator pattern",)
        # def CmdClearErrors():
            # self.StartSigGenReg.set(1)
            # self.StartSigGenReg.set(0)

    def UpdateIQ(self, dev, value, disp):
##        time.sleep(0.001)
        self.I.get()
        self.Q.get()

class CryoAdcMux(pr.Device):
    def __init__(   self,
            name        = "CryoAdcMux",
            description = "",
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        self.addRemoteVariables(
            name         = "ChRemap",
            description  = "",
            offset       =  0x0,
            bitSize      =  4,
            bitOffset    =  0,
            base         = pr.UInt,
            mode         = "RW",
            number       =  10,
            stride       =  4,
        )

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

        self.add(CryoAdcMux(
            name   = 'CryoAdcMux[0]',
            offset = 0x00800000,
            expand = False,
        ))

        self.add(CryoAdcMux(
            name   = 'CryoAdcMux[1]',
            offset = 0x00800100,
            expand = False,
        ))

