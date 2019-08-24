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

class UdpConfig(pr.Device):
    def __init__(   self,       
            name        = 'UdpConfig',
            description = 'Container for UdpConfig',
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
       
        self.add(pr.RemoteVariable(   
            name         = 'EnKeepAlive',
            offset       = 0x0C,
            bitSize      = 1,
            mode         = 'RW',
        ))  

        self.add(pr.RemoteVariable(   
            name         = 'KeepAliveConfig',
            offset       = 0x10,
            bitSize      = 32,
            mode         = 'RW',
        ))  
    