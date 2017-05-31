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

# Create HW herarchy
udpRssiA = pyrogue.protocols.UdpRssiPack("10.0.3.104",8193,1500)
rssiSrp= rogue.protocols.srp.SrpV3()
pyrogue.streamConnectBiDir(rssiSrp,udpRssiA.application(0))
cryo = pyrogue.Root('cryo','AMC Carrier')
cryo.add(AmcCarrierCore(memBase=rssiSrp, offset=0x00000000))
cryo.add(AppTop(memBase=rssiSrp, offset=0x80000000, numRxLanes=2, numTxLanes=2))
#cryo.setTimeout(5.0)

# Set 3 wire mode
cryo.AppTop.AppCore.AmcCryoCore_1.Adc32Rf45_0.GlobalReg_0x0010.set(1)

# Set master page and read register 20h
#   7   6   5   4           3   2   1           0
#   0   0   0   PDN SYSREF  0   0   PDN CHB     GLOBAL PDN 
# Possible values: 0x01, 0x02, 0x03, 0x11, 0x12, 0x13
cryo.AppTop.AppCore.AmcCryoCore_1.Adc32Rf45_0.GlobalReg_0x0012.set(4)
cryo.AppTop.AppCore.AmcCryoCore_1.Adc32Rf45_0.GlobalReg_0x0011.set(255)
reg20 = cryo.AppTop.AppCore.AmcCryoCore_1.Adc32Rf45_0.MasterReg_0x0020.get()
print("ADC, Reg 0x20 = 0x%x" % (reg20))

# set reg 20h to 0x00 (normal operation)
cryo.AppTop.AppCore.AmcCryoCore_1.Adc32Rf45_0.GlobalReg_0x0012.set(4)
cryo.AppTop.AppCore.AmcCryoCore_1.Adc32Rf45_0.GlobalReg_0x0011.set(255)
reg20 = cryo.AppTop.AppCore.AmcCryoCore_1.Adc32Rf45_0.MasterReg_0x0020.set(0x00)

# Read JESD digital page, register 2
cryo.AppTop.AppCore.AmcCryoCore_1.Adc32Rf45_0.GlobalReg_0x0004.set(0x69)
cryo.AppTop.AppCore.AmcCryoCore_1.Adc32Rf45_0.GlobalReg_0x0003.set(0x00)
cryo.AppTop.AppCore.AmcCryoCore_1.Adc32Rf45_0.GlobalReg_0x0002.set(0x00)
reg20 = cryo.AppTop.AppCore.AmcCryoCore_1.Adc32Rf45_0.GlobalReg_0x0002.get()
print("JESD digital page, Reg 0x02 = 0x%x" % (reg20))


print("Reg 04 = 0x%x" % (cryo.AppTop.AppCore.AmcCryoCore_1.Adc32Rf45_0.GlobalReg_0x0004.get()))
print("Reg 03 = 0x%x" % (cryo.AppTop.AppCore.AmcCryoCore_1.Adc32Rf45_0.GlobalReg_0x0003.get()))
print("Reg 02 = 0x%x" % (cryo.AppTop.AppCore.AmcCryoCore_1.Adc32Rf45_0.GlobalReg_0x0002.get()))

cryo.stop()
exit()
