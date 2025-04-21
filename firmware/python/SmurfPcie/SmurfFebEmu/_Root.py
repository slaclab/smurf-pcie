##############################################################################
# This file is part of the 'smurf-pcie'.
# It is subject to the license terms in the LICENSE.txt file found in the
# top-level directory of this distribution and at:
#    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
# No part of the 'smurf-pcie', including this file,
# may be copied, modified, propagated, or distributed except according to
# the terms contained in the LICENSE.txt file.
##############################################################################

import pyrogue  as pr
import pyrogue.protocols
import pyrogue.utilities.prbs

import rogue
import rogue.hardware.axi
import rogue.interfaces.stream

import axipcie as pcie
import SmurfPcie.SmurfFebEmu as febEmu
import SmurfPcie.SmurfKcu1500RssiOffload10GbE as smurf

class Root(pr.Root):
    def __init__(   self,
            laneList  = [0],
            febConfig = 'config/SmurfFebEmu/4kHz_8320B.yml',
            zmqSrvEn  = True,  # Flag to include the ZMQ server
            **kwargs):
        super().__init__(**kwargs)

        self.febConfig  = febConfig

        dev0 = '/dev/datadev_0'
        dev1 = '/dev/datadev_1'
        dev2 = '/dev/datadev_2'

        #################################################################
        if zmqSrvEn:
            self.zmqServer = pyrogue.interfaces.ZmqServer(root=self, addr='127.0.0.1', port=0)
            self.addInterface(self.zmqServer)
        #################################################################

        self.memMap0 = rogue.hardware.axi.AxiMemMap(dev0)
        self.add(smurf.Core(
            memBase = self.memMap0,
            # expand  = True,
        ))

        self.memMap1 = rogue.hardware.axi.AxiMemMap(dev1)
        self.add(pcie.AxiPcieCore(
            name        = 'RawUdpMon',
            offset      = 0x00000000,
            numDmaLanes = 6,
            memBase     = self.memMap1,
            # expand      = True,
        ))

        #################################################################

        self.vc0Srp   = [None for i in range(6)]
        self.debugSrp = [None for i in range(6)]
        self.vc1Prbs  = [None for i in range(6)]
        self.srp      = [None for i in range(6)]
        self.dbgSrp   = [None for i in range(6)]
        self.dgbPrbs  = [None for i in range(6)]
        self.udpTx    = [None for i in range(6)]
        self.udpRx    = [None for i in range(6)]
        self.rssiTx   = [None for i in range(6)]
        self.rssiRx   = [None for i in range(6)]

        for i in laneList:
            self.vc1Prbs[i]  = rogue.hardware.axi.AxiStreamDma(dev1,(i*0x100)+0xC1,True)
            self.dgbPrbs[i]  = rogue.hardware.axi.AxiStreamDma(dev0,(i*0x100)+0x02,True)

        for i in laneList:
            self.udpTx[i] = pr.utilities.prbs.PrbsTx(name=f'UdpTx[{i}]',width=128,hidden=True)
            self.udpTx[i] >> self.vc1Prbs[i]
            self.add(self.udpTx[i])

        for i in laneList:
            self.udpRx[i] = pr.utilities.prbs.PrbsRx(name=f'UdpRx[{i}]',width=128,checkPayload=False)
            self.vc1Prbs[i] >> self.udpRx[i]
            self.add(self.udpRx[i])

        for i in laneList:
            self.rssiTx[i] = pr.utilities.prbs.PrbsTx(name=f'RssiTx[{i}]',width=64,hidden=True)
            self.rssiTx[i] >> self.dgbPrbs[i]
            self.add(self.rssiTx[i])

        for i in laneList:
            self.rssiRx[i] = pr.utilities.prbs.PrbsRx(name=f'RssiRx[{i}]',width=64,checkPayload=False)
            self.dgbPrbs[i] >> self.rssiRx[i]
            self.add(self.rssiRx[i])

        for i in laneList:
            self.vc0Srp[i] = rogue.hardware.axi.AxiStreamDma(dev0,(i*0x100)+0,True)
            self.srp[i]    = rogue.protocols.srp.SrpV3()
            self.vc0Srp[i] == self.srp[i]
            self.add(febEmu.Feb(
                name     = f'Feb[{i}]',
                memBase  = self.srp[i],
            ))

        for i in laneList:
            self.debugSrp[i] = rogue.hardware.axi.AxiStreamDma(dev2,(i*0x100)+0,True)
            self.dbgSrp[i]   = rogue.protocols.srp.SrpV3()
            self.debugSrp[i] == self.dbgSrp[i]
            self.add(febEmu.Feb(
                name     = f'DbgFeb[{i}]',
                memBase  = self.dbgSrp[i],
            ))

    def start(self, **kwargs):
        super().start(**kwargs)

        # Load the YAML file
        print( f'Loading {self.febConfig} YAML file' );
        self.LoadConfig(self.febConfig)

        # Reset counters
        self.CountReset()
