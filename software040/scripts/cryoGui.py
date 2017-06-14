#!/usr/bin/env python3
import pyrogue
import pyrogue.protocols
import rogue.protocols.srp
import rogue.protocols.udp
import pyrogue.utilities.fileio
import rogue.interfaces.stream
import PyQt4.QtGui
import pyrogue.gui
import sys

from AmcCarrierCore import *
from AppTop import *

# Custom run control
class MyRunControl(pyrogue.RunControl):
   def __init__(self,name):
      pyrogue.RunControl.__init__(self,name=name,description='Run Controller',
                                  rates={1:'1 Hz', 10:'10 Hz', 30:'30 Hz'})
      self._thread = None

   def _setRunState(self,dev,var,value,changed):
      if changed:
         if self.runState.get(read=False) == 'Running':
            self._thread = threading.Thread(target=self._run)
            self._thread.start()
         else:
            self._thread.join()
            self._thread = None

   def _run(self):
      self.runCount.set(0)
      self._last = int(time.time())

      while (self.runState.get(read=False) == 'Running'):
         delay = 1.0 / ({value: key for key,value in self.runRate.enum.items()}[self._runRate])
         time.sleep(delay)
         self._root.ssiPrbsTx.oneShot()

         self._runCount += 1
         if self._last != int(time.time()):
             self._last = int(time.time())
             self.runCount._updated()
  

class cryoGui(pyrogue.Root):

   def __init__(self):

      pyrogue.Root.__init__(self,'cryo','AMC Carrier')
      
      # Run control
      self.add(MyRunControl('runControl'))

      # File writer
      dataWriter = pyrogue.utilities.fileio.StreamWriter('dataWriter')
      self.add(dataWriter)

      # Create RSSI interface
      udpRssiA = pyrogue.protocols.UdpRssiPack("10.0.3.106",8193,1500)
      
      # Create data stream interface
      
      # Create and connect SRP to RSSI
      rssiSrp= rogue.protocols.srp.SrpV3()
      pyrogue.streamConnectBiDir(rssiSrp,udpRssiA.application(0))
      
      # Add data stream to file as channel 0

      # Add devices     
      self.add(AmcCarrierCore(memBase=rssiSrp, offset=0x00000000))
      #cryo.add(AppTop(memBase=rssiSrp, offset=0x80000000, numRxLanes=[0,8], numTxLanes=[0,8]))
      
      # Set global timeout
      self.setTimeout(1.0)
      
      # Create GUI
      appTop = PyQt4.QtGui.QApplication(sys.argv)
      guiTop = pyrogue.gui.GuiTop(group='cryoMesh')
      guiTop.resize(800, 1000)
      guiTop.addTree(self)
      
      print("Starting GUI...\n");
      
      # Run GUI
      appTop.exec_()
   
      super().stop()
      exit()

if __name__ == "__main__":
   cryoGui = cryoGui()
