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
import SmurfKcu1500RssiOffload as smurf
import surf.ethernet.udp as udp
import surf.protocols.rssi as rssi

class EthLane(pr.Device):
    def __init__(   self,       
            name        = "EthLane",
            description = "Container for EthLane",
            rssiPerLink = 6,
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
        
        self.add(smurf.EthConfig(
            offset = (0x00000), 
            expand = False,
        ))
        
        self.add(udp.UdpEngine(
            offset = (0x10000), 
            numClt = 6,
            expand = False,
        ))        
                
        for i in range(rssiPerLink):
            self.add(rssi.RssiCore(
                name         = "RssiClient[%i]" % (i),
                offset       =  (0x20000) + (i*0x10000),
                description  = "Rssi Client: %i" % (i),
                expand       =  False,
            ))

        @self.command(name="C_RestartConn", description="Restart connection request",)
        def C_RestartConn():                        
            for i in range(rssiPerLink):
                self.RssiClient[i].C_RestartConn()

    # Function calls after loading YAML configuration
    def initialize(self):
        super().initialize()  
        for i in range(rssiPerLink):
            self.C_RestartConn()
            