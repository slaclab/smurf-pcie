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

import pyrogue as pr
from surf.ethernet import udp

class UdpDebug(pr.Device):
    def __init__(   self,       
            name        = 'UdpDebug',
            description = 'Container for UdpDebug',
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
          
        self.add(pr.RemoteVariable(   
            name         = 'MuxSel',
            description  = 'Select which DMA/PCIe endpoint to send the UDP large buffer traffic (default: SecondaryDMA)',
            offset       = 0x00,
            bitSize      = 1, 
            mode         = 'RW',
            enum         = {
                0x0: 'PrimaryDMA', 
                0x1: 'SecondaryDMA', 
            }, 
        ))  
        
        self.add(pr.RemoteVariable(   
            name         = 'TDest',
            description  = 'Sets the UDP Large buffer TDEST',
            offset       = 0x04,
            bitSize      = 8,
            mode         = 'RW',
        ))  
       
        self.add(pr.RemoteVariable(   
            name         = 'NUM_RSSI_C',
            offset       =  0x10,
            mode         = 'RO',
        ))            
        
        self.add(pr.RemoteVariable(   
            name         = 'CLIENT_SIZE_C',
            offset       =  0x14,
            mode         = 'RO',
        ))    
        
        self.add(pr.RemoteVariable(   
            name         = 'CLIENT_PORTS_C[0]',
            offset       =  0x18,
            mode         = 'RO',
        ))

        self.add(pr.RemoteVariable(   
            name         = 'CLIENT_PORTS_C[1]',
            offset       =  0x1C,
            mode         = 'RO',
        ))
        
        # self.addRemoteVariables(   
            # name         = 'UdpToPhyRoute',
            # description  = 'Route table for mapping the UDP lanes to ETH PHY lanes',
            # offset       = 0x80,
            # bitSize      = 3,
            # mode         = 'RW',
            # number       = 6,
            # stride       = 4,
        # )        
