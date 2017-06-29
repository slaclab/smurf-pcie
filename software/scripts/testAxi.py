#!/usr/bin/env python3
import pyrogue
import pyrogue.protocols
import rogue.protocols.srp
import rogue.protocols.udp
import PyQt4.QtGui
import pyrogue.gui
import sys

from AmcCarrierCore import *
from AppTop import *

# Create HW herarchy
udpRssiA = pyrogue.protocols.UdpRssiPack("10.0.3.106",8193,1500)
rssiSrp= rogue.protocols.srp.SrpV3()
pyrogue.streamConnectBiDir(rssiSrp,udpRssiA.application(0))
cryo = pyrogue.Root('cryo','AMC Carrier')
cryo.add(AmcCarrierCore(memBase=rssiSrp, offset=0x00000000))
cryo.add(AppTop(memBase=rssiSrp, offset=0x80000000, numRxLanes=2, numTxLanes=2))
#cryo.setTimeout(5.0)

# Set 3 wire mode
print("Build String    : %s" % cryo.AmcCarrierCore.AxiVersion.BuildStamp.get())
print("Up time counter : %d" % cryo.AmcCarrierCore.AxiVersion.UpTimeCnt.get())

cryo.stop()
exit()
