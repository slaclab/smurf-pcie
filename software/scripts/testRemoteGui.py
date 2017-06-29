#!/usr/bin/env python3
#import pyrogue
#import pyrogue.protocols
#import rogue.protocols.srp
#import rogue.protocols.udp
import pyrogue.mesh
import PyQt4.QtGui
import pyrogue.gui
import sys

#from AmcCarrierCore import *
#from AppTop import *

# Connecting to mesh
mNode = pyrogue.mesh.MeshNode(group='cryoMesh', iface='eth0', root=None)

# Create GUI
appTop = PyQt4.QtGui.QApplication(sys.argv)
guiTop = pyrogue.gui.GuiTop(group='cryoMesh')
mNode.setNewTreeCb(guiTop.addTree)

mNode.start()

print("Waiting for tree...")
mNode.waitTree('cryo')

print("Done. Starting application")
# Run GUI
appTop.exec_()

mNode.stop()
exit()
