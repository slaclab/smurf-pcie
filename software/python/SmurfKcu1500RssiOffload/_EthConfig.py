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

class EthConfig(pr.Device):
    def __init__(   self,       
            name        = 'EthConfig',
            description = 'Container for EthConfig',
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
        
        self.add(pr.RemoteVariable(   
            name         = 'LocalMacRaw',
            description  = 'Local MAC Address',
            offset       = 0x00,
            bitSize      = 48,
            mode         = 'RW',
            hidden       = True,     
        ))      
        
        self.add(pr.LinkVariable(
            name         = 'LocalMac', 
            description  = 'Local MAC (human readable & little-Endian configuration)',
            mode         = 'RW', 
            linkedGet    = udp.getMacValue,
            linkedSet    = udp.setMacValue,
            dependencies = [self.variables['LocalMacRaw']],
        ))          
        
        self.add(pr.RemoteVariable(   
            name         = 'LocalIpRaw',
            description  = 'Local IP Address',
            offset       = 0x08,
            bitSize      = 32,
            mode         = 'RW',
            hidden       = True,     
        ))  

        self.add(pr.LinkVariable(
            name         = 'LocalIp', 
            description  = 'Local Ip Address (human readable string)',
            mode         = 'RW', 
            linkedGet    = udp.getIpValue,
            linkedSet    = udp.setIpValue,
            dependencies = [self.variables['LocalIpRaw']],
        ))          
        
        self.add(pr.RemoteVariable(   
            name         = 'TxPreCursor',
            offset       = 0x20,
            bitSize      = 5,
            mode         = 'RW',
        ))  
        
        self.add(pr.RemoteVariable(   
            name         = 'TxPostCursor',
            offset       = 0x24,
            bitSize      = 5,
            mode         = 'RW',
        ))    

        self.add(pr.RemoteVariable(   
            name         = 'TxDiffCtrl',
            offset       = 0x28,
            bitSize      = 4,
            mode         = 'RW',
        ))            
