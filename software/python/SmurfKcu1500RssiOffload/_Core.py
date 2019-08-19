#!/usr/bin/env python
##############################################################################
## This file is part of 'camera-link-gen1'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'camera-link-gen1', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################

import rogue.hardware.axi

import pyrogue                  as pr
import axipcie                  as pcie
import surf.protocols.ssi       as ssi
import surf.ethernet.ten_gig    as ethPhy    
import surf.axi                 as axi  
import SmurfKcu1500RssiOffload  as smurf

class Core(pr.Device):
    def __init__(   self,       
            name        = "Core",
            description = "Container for SmurfKcu1500RssiOffload",
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
        
        # Add axi-pcie-core 
        self.add(pcie.AxiPcieCore(            
            offset      = 0x00000000, 
            numDmaLanes = 6,
            expand      = True,
        ))   
        
        # Add Ethernet Lane
        for i in range(6):        
            self.add(ethPhy.TenGigEthReg(            
                name    = f'EthPhy[{i}]',
                offset  = 0x00860000 + i*0x1000, 
                writeEn = True,
                expand  = False,
            ))               
            
        # Add Ethernet Lane
        for i in range(6):
            self.add(smurf.EthLane(            
                name   = f'EthLane[{i}]',
                offset = (0x00800000 + i*0x10000), 
                expand = False,
            )) 
            
        # Add UDP Buffer
        for i in range(6):
            self.add(axi.AxiStreamDmaFifo(            
                name   = f'UdpBuffer[{i}]',
                offset = (0x00870000 + i*0x1000), 
                expand = False,
            ))             
        
        # Add the UDP Large Buffer Traffic Config
        self.add(smurf.UdpObConfig(            
            offset = 0x00876000, 
            expand = False,
        )) 

        @self.command(name="C_RestartConn", description="Restart connection request",)
        def C_RestartConn():                        
            for i in range(6):
                self.EthLane[i].RssiClient.C_RestartConn()
                