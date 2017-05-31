#!/usr/bin/env python3
import pyrogue
import pyrogue.protocols
import rogue.protocols.srp
import rogue.protocols.udp
import pyrogue.mesh
import PyQt4.QtGui
import pyrogue.gui
import sys

from AmcCarrierCore import *
from AppTop import *

udpRssiA = pyrogue.protocols.UdpRssiPack("10.0.3.104",8193,1500)
rssiSrp= rogue.protocols.srp.SrpV3()
pyrogue.streamConnectBiDir(rssiSrp,udpRssiA.application(0))

cryo = pyrogue.Root('cryo','AMC Carrier')

#cryo.add(AmcCarrierCore(memBase=rssiSrp, offset=0x00000000))
cryo.add(AppTop(memBase=rssiSrp, offset=0x80000000, numRxLanes=2, numTxLanes=2))

#cryo.setTimeout(5.0)

# Create GUI
appTop = PyQt4.QtGui.QApplication(sys.argv)
guiTop = pyrogue.gui.GuiTop(group='cryoMesh')
guiTop.addTree(cryo)

print("Starting GUI...\n");

# Run GUI
appTop.exec_()

cryo.stop()
exit()
