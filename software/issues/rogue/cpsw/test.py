#!/usr/bin/env python
import pycpsw

root       = pycpsw.Path.loadYamlFile("yaml/000TopLevel.yaml")
counter    = pycpsw.ScalVal_RO.create(root.findByName("mmio/AmcCarrierCore/AxiVersion/UpTimeCnt"))

dac0ID     = pycpsw.ScalVal_RO.create(root.findByName("mmio/AppTop/AppCore/AmcCryoCore[1]/Dac38J84[0]/ID"))
dac1ID     = pycpsw.ScalVal_RO.create(root.findByName("mmio/AppTop/AppCore/AmcCryoCore[1]/Dac38J84[1]/ID"))
dac0Temp   = pycpsw.ScalVal_RO.create(root.findByName("mmio/AppTop/AppCore/AmcCryoCore[1]/Dac38J84[0]/Temperature"))

print "UpTime Counter:     %d"   % counter.getVal()
print "Dac[0] ID:          0x%x" % dac0ID.getVal()
print "Dac[1] ID:          0x%x" % dac1ID.getVal()
print "Dac[0] Temperature: %d"   % dac0Temp.getVal()
