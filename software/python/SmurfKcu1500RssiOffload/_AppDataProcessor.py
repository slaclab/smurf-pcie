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

class AppDataProcessor(pr.Device):
    def __init__(   self,       
            name        = "AppDataProcessor",
            description = "Container for AppDataProcessor",
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
        
        # Placeholder for future code
