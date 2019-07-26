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
        
        self.add(ssi.SsiPrbsTx(
            offset = 0x00040000,
            expand = True,
        )) 

        self.add(ssi.SsiPrbsRx(
            offset = 0x00050000,
            expand = False,
        ))         
        
        self.add(rssi.RssiCore(
            offset = 0x00070000,
            expand = True,
        ))                 
        
class TopLevel(pr.Root):
    def __init__(   self, 
            name        = 'TopLevel',
            description = 'Container for FPGA Top-Level', 
            dev         = '/dev/datadev_0',
            lane        = 0,
            loopback    = False, 
            swRx        = True, 
            swTx        = True, 
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
        
        self.vc0Srp  = rogue.hardware.axi.AxiStreamDma(dev,(lane*0x100)+0,True)
        self.vc1Prbs = rogue.hardware.axi.AxiStreamDma(dev,(lane*0x100)+1,True)
        
        # TDEST 0 routed to stream 0 (SRPv3)
        self.srp = rogue.protocols.srp.SrpV3()
        pr.streamConnectBiDir(self.vc0Srp,self.srp)
        
        if (loopback):
            # Loopback the PRBS data
            pr.streamConnect(self.vc1Prbs,self.vc1Prbs)  
        
        else:
            if (swTx):
                # Connect VC1 to FW RX PRBS
                self.prbTx = pr.utilities.prbs.PrbsTx(name="PrbsTx",width=128,expand=False)
                pr.streamConnect(self.prbTx, self.vc1Prbs)
                self.add(self.prbTx) 
                    
            if (swRx):
                # Connect VC1 to FW TX PRBS
                self.prbsRx = pr.utilities.prbs.PrbsRx(name='PrbsRx',width=128,expand=True)
                pr.streamConnect(self.vc1Prbs,self.prbsRx)
                self.add(self.prbsRx)          

        # Add registers
        self.add(Fpga(
            memBase  = self.srp,
        ))
        