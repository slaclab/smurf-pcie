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
import surf.axi 

class AppDataProcessorPktMon(pr.Device):
    def __init__(   self,       
            name        = "AppDataProcessorPktMon",
            description = "Container for AppDataProcessorPktMon",
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
        
        self.addRemoteVariables(   
            name         = 'Header',
            description  = 'Current Header values',
            offset       = 0x0,
            bitSize      = 64,
            mode         = 'RO',
            number       = 16,
            stride       = 8,
        )
        
        self.add(pr.RemoteVariable(
            name         = 'SofErrCnt',
            description  = 'Increments every time there is a SOF error detected',
            offset       = 0x84,
            bitSize      = 32,
            mode         = 'RO',
        ))

        self.add(pr.RemoteVariable(
            name         = 'SkipErrCnt',
            description  = 'Increments every time there is a seqCnt skip error detected',
            offset       = 0x88,
            bitSize      = 32,
            mode         = 'RO',
        ))

        self.add(pr.RemoteVariable(
            name         = 'EoffErrCnt',
            description  = 'Increments every time there is an EOFE error detected',
            offset       = 0x8C,
            bitSize      = 32,
            mode         = 'RO',
        ))        
        
    def countReset(self):
        self._rawWrite(offset=0x80,data=0x1)          

class AppDataProcessor(pr.Device):
    def __init__(   self,       
            name        = "AppDataProcessor",
            description = "Container for AppDataProcessor",
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
        
        # AXI Stream Inbound/Outbound Monitor        
        self.add(surf.axi.AxiStreamMonitoring(            
            name        = 'AxisMon', 
            offset      = 0x00000, 
            numberLanes = 2,
            expand      = False,
        ))    

        # Inbound Packet Monitor        
        self.add(AppDataProcessorPktMon(            
            name        = 'PktMon', 
            offset      = 0x10000, 
            expand      = False,
        ))            
