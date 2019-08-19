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

class UdpObConfig(pr.Device):
    def __init__(   self,       
            name        = 'UdpObConfig',
            description = 'Container for UdpObConfig',
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
          
        self.add(pr.RemoteVariable(   
            name         = 'MuxSel',
            description  = 'Select which DMA/PCIe endpoint to send the UDP large buffer traffic (default: SecondaryDMA)',
            offset       = 0x0,
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
            offset       = 0x4,
            bitSize      = 8,
            mode         = 'RW',
        ))  
