#!/usr/bin/env python3
import pyrogue
import pyrogue.protocols
import rogue.protocols.srp
import rogue.protocols.udp
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

# Reading this register works
print("UpTimeCnt: %d" % (cryo.AmcCarrierCore.AxiVersion.UpTimeCnt.get()))

# Reading the  DAC's ID works
print("DAC_0 ID: 0x%x" % (cryo.AppTop.AppCore.AmcCryoCore_1.Dac38J84_0.ID.get()))
print("DAC_1 ID: 0x%x" % (cryo.AppTop.AppCore.AmcCryoCore_1.Dac38J84_1.ID.get()))

# Reading the description from the DAC's temperature works
print("DAC_0 Temperature description: %s" % (cryo.AppTop.AppCore.AmcCryoCore_1.Dac38J84_0.Temperature.description))

# However, reading the DAC's Temperature register fails
print("DAC_0 Temperature: %s" % (cryo.AppTop.AppCore.AmcCryoCore_1.Dac38J84_0.Temperature.get()))

cryo.stop()
exit()
