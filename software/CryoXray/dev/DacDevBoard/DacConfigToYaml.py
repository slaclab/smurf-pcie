#!/usr/bin/env python
#-----------------------------------------------------------------------------
# Title      : 
#-----------------------------------------------------------------------------
# File       : hex2yaml.py
# Created    : 2016-09-29
# Last update: 2016-09-29
#-----------------------------------------------------------------------------
# Description:
#-----------------------------------------------------------------------------
# This file is part of 'SLAC Firmware Standard Library'.
# It is subject to the license terms in the LICENSE.txt file found in the 
# top-level directory of this distribution and at: 
#    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
# No part of 'SLAC Firmware Standard Library', including this file, 
# may be copied, modified, propagated, or distributed except according to 
# the terms contained in the LICENSE.txt file.
#-----------------------------------------------------------------------------

import os
import sys
import re
import ast
        
def Toyaml(fDin,fDout):      

    # Open the output files
    ofd = open(fDout, 'w')  
    
    wait = True
    
    # Open the input file
    with open(fDin, 'r') as ifd:    
        
        for i, line in enumerate(ifd):     
            line = line.strip()
            if (wait):
                # print (line)
                if (line=='DAC3XJ8X'):
                    wait = False
            else:
                pat = re.compile("[ ]") 
                # print (pat)
                fields=pat.split(line)
                # print( str(i) +"\t"+ fields[0] +"\t"+ fields[1])
                addr = ast.literal_eval(fields[0])
                data = (ast.literal_eval(fields[1])&0xFFFF)            
                yaml = (('          DacReg[%d]: 0x%04X\n') % (addr,data))
                ofd.write(yaml)
        
    # Close the files
    ifd.close()
    ofd.close()        
        
if __name__ == '__main__':
    Toyaml(sys.argv[1],sys.argv[2])
        