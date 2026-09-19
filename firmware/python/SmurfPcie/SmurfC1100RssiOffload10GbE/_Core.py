#!/usr/bin/env python
##############################################################################
# This file is part of the 'smurf-pcie'.
# It is subject to the license terms in the LICENSE.txt file found in the
# top-level directory of this distribution and at:
#    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
# No part of the 'smurf-pcie', including this file,
# may be copied, modified, propagated, or distributed except according to
# the terms contained in the LICENSE.txt file.
##############################################################################

import rogue.hardware.axi

import pyrogue                  as pr
import axipcie                  as pcie
import surf.protocols.ssi       as ssi
import surf.ethernet.ten_gig    as ethPhy
import surf.ethernet.udp        as udp
import surf.protocols.rssi      as rssi
import surf.axi                 as axi
import surf.xilinx              as xil
from SmurfPcie.SmurfC1100RssiOffload10GbE._EthConfig import EthConfig
from SmurfPcie.SmurfC1100RssiOffload10GbE._UdpConfig import UdpConfig

##############################################################################

class EthPhyGrp(pr.Device):
    def __init__(   self,
            name        = 'EthPhyGrp',
            description = 'Container for EthPhyGrp',
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        for i in range(8):
            self.add(ethPhy.TenGigEthReg(
                name    = f'EthPhy[{i}]',
                offset  = i*0x1000,
                writeEn = True,
                expand  = False,
            ))

        for i in range(8):
            self.add(EthConfig(
                name    = f'EthConfig[{i}]',
                offset  = 0x8000 + i*0x1000,
                expand  = False,
            ))

##############################################################################

class UdpGrp(pr.Device):
    def __init__(   self,
            name        = 'UdpGrp',
            description = 'Container for UdpGrp',
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        for i in range(8):
            self.add(UdpConfig(
                name   = f'UdpConfig[{i}]',
                offset = i*0x10000 + 0x0000,
                expand = False,
            ))

        for i in range(8):
            self.add(udp.UdpEngine(
                name   = f'UdpEngine[{i}]',
                offset = i*0x10000 + 0x1000,
                numClt = 2,
                expand = False,
            ))

        for i in range(8):
            self.add(rssi.RssiCore(
                name   = f'RssiClient[{i}]',
                offset = i*0x10000 + 0x2000,
                expand =  False,
            ))

##############################################################################

class UdpBufferGrp(pr.Device):
    def __init__(   self,
            name        = 'UdpBufferGrp',
            description = 'Container for UdpBufferGrp',
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        # AXI Stream HBM FIFOs
        for i in range(8):
            self.add(axi.AxiStreamDmaV2Fifo(
                name   = f'UdpBuffer[{i}]',
                offset = (i*0x100),
                expand = False,
            ))

##############################################################################

class Core(pr.Device):
    def __init__(   self,
            name        = "Core",
            description = "Container for SmurfC1100RssiOffload10GbE",
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)

        self.add(pcie.AxiPcieCore(
            offset      = 0x00000000,
            numDmaLanes = 8,
            boardType   = 'XilinxVariumC1100',
            expand      = True,
        ))

        self.add(EthPhyGrp(
            offset      = 0x00880000,
            expand      = True,
        ))

        self.add(UdpGrp(
            offset      = 0x00800000,
            expand      = True,
        ))

        self.add(UdpBufferGrp(
            offset      = 0x00100000,
            expand      = True,
        ))

        @self.command(name="C_RestartConn", description="Restart connection request",)
        def C_RestartConn():
            for i in range(8):
                self.UdpGrp.RssiClient[i].C_RestartConn()

##############################################################################
