#!/usr/bin/env python
#-----------------------------------------------------------------------------
# Title      : PyRogue feb Module
#-----------------------------------------------------------------------------
# File       : _feb.py
# Created    : 2017-02-15
# Last update: 2017-02-15
#-----------------------------------------------------------------------------
# Description:
# PyRogue Feb Module
#-----------------------------------------------------------------------------
# This file is part of the 'Development Board Examples'. It is subject to 
# the license terms in the LICENSE.txt file found in the top-level directory 
# of this distribution and at: 
#    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
# No part of the 'Development Board Examples', including this file, may be 
# copied, modified, propagated, or distributed except according to the terms 
# contained in the LICENSE.txt file.
#-----------------------------------------------------------------------------

import pyrogue             as pr
import surf.axi            as axi
import surf.protocols.ssi  as ssi
import surf.protocols.rssi as rssi
import surf.xilinx         as xil
import time
import click 

import rogue
import rogue.hardware.axi

class Fpga(pr.Device):                         
    def __init__( self,       
        name        = 'Fpga',
        fpgaType    = '',
        commType    = 'eth',
        description = 'Fpga Container',
        **kwargs):
        
        super().__init__(name=name,description=description, **kwargs)
        
        #############
        # Add devices
        #############
        self.add(axi.AxiVersion(
            offset = 0x00000000,
            expand = False,
        ))
        
        if(fpgaType=='7series'):
            self.add(xil.Xadc(
                offset = 0x00010000,
                expand = False,
            )) 

        if(fpgaType=='ultrascale'):
            self.add(xil.AxiSysMonUltraScale(
                offset = 0x00020000,
                expand = False,
            ))
        
        self.add(MbSharedMem(
            name   = 'MbSharedMem',
            offset = 0x00030000,
            size   = 0x10000,
            expand = False,
        ))
        
        self.add(ssi.SsiPrbsTx(
            offset = 0x00040000,
            expand = False,
        )) 

        self.add(ssi.SsiPrbsRx(
            offset = 0x00050000,
            expand = False,
        ))         
        
        if ( commType == 'eth' ):
            self.add(rssi.RssiCore(
                offset = 0x00070000,
                expand = False,
            ))                 
            
        self.add(MbSharedMem(
            name   = 'TestEmptyMem',
            offset = 0x80000000,
            size   = 0x80000000,
            expand = False,
        ))            
            
    # Normal register rate tester
    def varRateTest(self):
        print("Running variable rate test")
        cnt = 0
        inc = 0
        last = time.localtime()

        try:
            while True:
                val = self.AxiVersion.ScratchPad.get()
                curr = time.localtime()
                cnt += 1
                inc += 1

                if curr != last:
                    print("Cnt={}, rate={}, val={}".format(cnt,inc,val))
                    last = curr
                    inc = 0

        except KeyboardInterrupt:
            return

    # Raw register rate tester
    def rawRateTest(self):
        print("Running raw rate test")
        cnt = 0
        inc = 0
        last = time.localtime()

        try:
            while True:
                val = self.AxiVersion._rawRead(0x4)
                curr = time.localtime()
                cnt += 1
                inc += 1

                if curr != last:
                    print("Cnt={}, rate={}, val={}".format(cnt,inc,val))
                    last = curr
                    inc = 0

        except KeyboardInterrupt:
            return

class MbSharedMem(pr.Device):                         
    def __init__( self,       
        name        = 'MbSharedMem',
        description = 'MbSharedMem Container',
        size        = 0x10000,
        **kwargs):
        
        super().__init__(
            name        = name, 
            description = description, 
            size        = size, 
            **kwargs)        
              
        @self.command(description='rawBurstWriteTest')    
        def rawBurstWriteTest(arg):
            if ( arg<2 ):
                smpl = 0x4000
            else:
                smpl = arg
            
            data = []
            smpl &= 0xFFFFFFFFC
            for i in range(smpl):
                data.append(i)    

            click.secho( 'MbSharedMem.rawBurstWriteTest(%d): %d' % (smpl,len(data)), fg='green')            
            self._rawWrite(
                offset      = 0x00000000,
                data        = data,
                base        = pr.Int,
                stride      = 4,
                wordBitSize = 32,
            )
            
        @self.command(description='rawBurstReadTest')    
        def rawBurstReadTest(arg):
            if ( arg<2 ):
                smpl = 0x4000
            else:
                smpl = arg
                
            data = []
            smpl &= 0xFFFFFFFFC
            for i in range(smpl):
                data.append(i)    

            click.secho( 'MbSharedMem.rawBurstReadTest(%d): %d' % (smpl,len(data)), fg='green')            
            readBack = self._rawRead(
                offset      = 0x00000000,
                numWords    = smpl,
                base        = pr.Int,
                stride      = 4,
                wordBitSize = 32,
            )            
            
class TopLevel(pr.Root):
    def __init__(   self, 
            name            = 'TopLevel',
            description     = 'Container for FPGA Top-Level', 
            dev             = '/dev/datadev_0',
            lane            = 7,
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
        
        self.vc0Srp  = rogue.hardware.axi.AxiStreamDma(dev,(lane*0x100)+0,True)
        self.vc1Prbs = rogue.hardware.axi.AxiStreamDma(dev,(lane*0x100)+1,True)
        
        # TDEST 0 routed to stream 0 (SRPv3)
        self.srp = rogue.protocols.srp.SrpV3()
        pr.streamConnectBiDir(self.vc0Srp,self.srp)
        
        # Connect VC1 to FW TX PRBS
        self.prbsRx = pr.utilities.prbs.PrbsRx(name='PrbsRx',width=128,expand=False)
        pr.streamConnect(self.vc1Prbs,self.prbsRx)
        self.add(self.prbsRx)  
        
        # Connect VC1 to FW RX PRBS
        self.prbTx = pr.utilities.prbs.PrbsTx(name="PrbsTx",width=128,expand=False)
        pr.streamConnect(self.prbTx, self.vc1Prbs)
        self.add(self.prbTx)          
                    
        # Add registers
        self.add(Fpga(
            memBase  = self.srp,
        ))
        