#-----------------------------------------------------------------------------
# This file is part of the 'Development Board Examples'. It is subject to
# the license terms in the LICENSE.txt file found in the top-level directory
# of this distribution and at:
#    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
# No part of the 'Development Board Examples', including this file, may be
# copied, modified, propagated, or distributed except according to the terms
# contained in the LICENSE.txt file.
#-----------------------------------------------------------------------------
import pyrogue               as pr
import surf.axi              as axi
import surf.ethernet.ten_gig as ethPhy
import surf.ethernet.udp     as udp
import surf.protocols.ssi    as ssi
import surf.protocols.rssi   as rssi
import surf.xilinx           as xil

class Feb(pr.Device):
    def __init__(self,**kwargs):
        super().__init__(**kwargs)

        self.add(axi.AxiVersion(
            offset = 0x0000_0000,
        ))

        self.add(ethPhy.TenGigEthReg(
            offset = 0x0001_0000,
        ))

        self.add(udp.UdpEngine(
            offset = 0x0002_0000,
            numSrv = 2,
        ))

        self.add(rssi.RssiCore(
            offset = 0x0003_0000,
        ))

        self.add(ssi.SsiPrbsTx(
            name   = 'RawUdpPrbsTx',
            offset = 0x0004_0000,
        ))

        self.add(ssi.SsiPrbsRx(
            name   = 'RawUdpPrbsRx',
            offset = 0x0005_0000,
        ))

        self.add(ssi.SsiPrbsTx(
            name   = 'RssiPrbsTx',
            offset = 0x0006_0000,
        ))

        self.add(ssi.SsiPrbsRx(
            name   = 'RssiPrbsRx',
            offset = 0x0007_0000,
        ))
