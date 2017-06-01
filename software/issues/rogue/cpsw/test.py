#!/usr/bin/env python
import pycpsw

root       = pycpsw.Path.loadYamlFile("yaml/000TopLevel.yaml")
counter    = pycpsw.ScalVal_RO.create(root.findByName("mmio/AmcCarrierCore/AxiVersion/UpTimeCnt"))

dacID      = pycpsw.ScalVal_RO.create(root.findByName("mmio/AppTop/AppCore/AmcCryoCore[1]/Dac38J84[0]/ID"))
dacTemp    = pycpsw.ScalVal_RO.create(root.findByName("mmio/AppTop/AppCore/AmcCryoCore[1]/Dac38J84[0]/Temperature"))

#print("DAC_0 ID: 0x%x" % (cryo.AppTop.AppCore.AmcCryoCore_1.Dac38J84_0.ID.get()))
#print("DAC_1 ID: 0x%x" % (cryo.AppTop.AppCore.AmcCryoCore_1.Dac38J84_1.ID.get()))
#print("DAC_0 Temperature description: %s" % (cryo.AppTop.AppCore.AmcCryoCore_1.Dac38J84_0.Temperature.description))
#print("DAC_0 Temperature: %s" % (cryo.AppTop.AppCore.AmcCryoCore_1.Dac38J84_0.Temperature.get()))


print "UpTime Counter:     %d"   % counter.getVal()
print "Dac[0] ID:          0x%x" % dacID.getVal()
print "Dac[0] Temperature: %d"   % dacTemp.getVal()
