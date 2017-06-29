#!/usr/bin/env python3
import pyrogue
import pyrogue.protocols
import rogue.protocols.srp
import rogue.protocols.udp
import PyQt4.QtGui
import pyrogue.gui
import sys

from FpgaTopLevel import *

udpRssiA = pyrogue.protocols.UdpRssiPack("10.0.3.104",8193,1500)
rssiSrp= rogue.protocols.srp.SrpV3()
pyrogue.streamConnectBiDir(rssiSrp,udpRssiA.application(0))

class AmcCarrier(pyrogue.Root):
    def __init__(self, srp):
        super().__init__(name='AMCc',description='', pollEn=True)        
        self.add(FpgaTopLevel(memBase=rssiSrp, offset=0x00000000))

AMCc = AmcCarrier(srp=rssiSrp)
AMCc.readAll()

# Create GUI
appTop = PyQt4.QtGui.QApplication(sys.argv)
appTop.setStyle('Fusion')
guiTop = pyrogue.gui.GuiTop(group='rootMesh')
guiTop.resize(800, 1000)
guiTop.addTree(AMCc)

print("Starting GUI...\n");

# Run GUI
appTop.exec_()

AMCc.stop()
exit()
