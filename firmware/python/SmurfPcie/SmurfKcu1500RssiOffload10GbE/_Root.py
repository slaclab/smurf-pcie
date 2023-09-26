#-----------------------------------------------------------------------------
# This file is part of the 'smurf-pcie'. It is subject to
# the license terms in the LICENSE.txt file found in the top-level directory
# of this distribution and at:
#    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
# No part of the 'smurf-pcie', including this file, may be
# copied, modified, propagated, or distributed except according to the terms
# contained in the LICENSE.txt file.
#-----------------------------------------------------------------------------

import pyrogue as pr
import rogue.hardware.axi
import SmurfPcie.SmurfKcu1500RssiOffload10GbE as smurf

class Root(pr.Root):
    def __init__(self,dev='/dev/datadev_0',**kwargs):
        super().__init__(**kwargs)

        self.memMap = rogue.hardware.axi.AxiMemMap(dev)

        self.add(smurf.Core(
            memBase = self.memMap,
            expand  = True,
        ))
