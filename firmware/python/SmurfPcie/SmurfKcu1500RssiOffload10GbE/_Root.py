##############################################################################
# This file is part of the 'smurf-pcie'.
# It is subject to the license terms in the LICENSE.txt file found in the
# top-level directory of this distribution and at:
#    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
# No part of the 'smurf-pcie', including this file,
# may be copied, modified, propagated, or distributed except according to
# the terms contained in the LICENSE.txt file.
##############################################################################

import pyrogue
import rogue.hardware.axi
import pyrogue.protocols.epicsV4
import SmurfPcie.SmurfKcu1500RssiOffload10GbE as smurf

class Root(pyrogue.Root):
    def __init__(self,
            dev       = '/dev/datadev_0',
            epicsBase = None,
            zmqSrvEn  = True,  # Flag to include the ZMQ server
            **kwargs):
        super().__init__(**kwargs)

        #################################################################
        if zmqSrvEn:
            self.zmqServer = pyrogue.interfaces.ZmqServer(root=self, addr='127.0.0.1', port=0)
            self.addInterface(self.zmqServer)
        #################################################################

        extDev = f"{dev.rsplit('_', 1)[0]}_{int(dev.rsplit('_', 1)[1]) + 1}"

        self.memMap = rogue.hardware.axi.AxiMemMap(dev)
        self.extMap = rogue.hardware.axi.AxiMemMap(extDev)

        self.add(smurf.Core(
            memBase = self.memMap,
            expand  = True,
        ))

        # Using "smurf" instead of "axi" as work around for using older rogue version with newer version of SURF
        self.add(smurf.AxiPcieCore(
            memBase     = self.extMap,
            name        = 'AxiPcieCoreExt',
            offset      = 0x00000000,
            numDmaLanes = 6,
            boardType   = 'Undefined',
            expand      = True,
        ))

        if epicsBase is not None:
            pvserv = pyrogue.protocols.epicsV4.EpicsPvServer(base=epicsBase, root=self,incGroups=None,excGroups=None)
            self.addProtocol(pvserv)
