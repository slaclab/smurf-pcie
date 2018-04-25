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

class AppLane(pr.Device):
    def __init__(   self,       
            name        = "AppLane",
            description = "Container for AppLane",
            rssiPerLink = 6,
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
        
        # Add Application Processing Cores
        for i in range(rssiPerLink):
            self.add(smurf.AppDataProcessor(            
                name        = ('AppDataProcessor[%d]' % i),
                offset      = (i*0x1000), 
                expand      = False,
            ))
