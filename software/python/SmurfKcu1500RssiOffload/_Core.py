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
import SmurfKcu1500RssiOffload  as smurf

class Core(pr.Device):
    def __init__(   self,       
            name        = "Core",
            description = "Container for SmurfKcu1500RssiOffload",
            numLink     = 1, # Same as AppPkg.vhd's NUM_LINKS_C constant
            rssiPerLink = 6, # Same as AppPkg.vhd's RSSI_PER_LINK_C constant
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
        
        # Add axi-pcie-core 
        self.add(pcie.AxiPcieCore(            
            offset       = 0x00000000, 
            useSpi       = True,
            expand       = False,
        ))  
        
        # DevBoard Receiver on DMA[7]
        self.add(ssi.SsiPrbsTx(
            offset = 0x00080000,
            expand = False,
        )) 
        self.add(ssi.SsiPrbsRx(
            offset = 0x00081000,
            rxClkPeriod = 8.0e-9,
            expand = False,
        ))           
        
        # Add Ethernet Lane
        for i in range(numLink):
            self.add(smurf.EthLane(            
                name        = ('EthLane[%d]' % i),
                offset      = (0x00800000 + i*0x80000), 
                rssiPerLink = rssiPerLink,
                expand      = True,
            )) 
