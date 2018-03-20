#!/usr/bin/env python3
import pyrogue as pr
import pyrogue.gui
import PyQt4.QtGui
from FpgaTopLevel import *
import sys

# Set base
AMCc = pr.Root(name='AMCc',description='')

# Add device
AMCc.add(FpgaTopLevel(ipAddr="10.0.3.106"))
AMCc.start()
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
