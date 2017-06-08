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
        
def hex2yaml(fDin,fDout):      

    # Open the output files
    ofd = open(fDout, 'w')  
    
    # Open the input file
    with open(fDin, 'r') as ifd:    
    
        for i, line in enumerate(ifd):     
             
            if (i<3):
                # Blow off first three configurations
                line = line.strip()
            elif (i<109):
                line = line.strip() 
                pat = re.compile("[R\t\n]")                
                fields=pat.split(line)
                addr = ast.literal_eval(fields[1])
                data = (ast.literal_eval(fields[2])&0xFF)
                # print( str(i) +"\t"+ fields[1] +"\t"+ fields[2])
                # print( str(i) +"\t"+ str(addr) +"\t"+ str(data))
                yaml = (('          LmkReg_0x%04X: 0x%02X\n') % (addr,data))
                ofd.write(yaml)
                
                if(addr==357):
                    ofd.write("          LmkReg_0x0171: 0xAA\n")
                    ofd.write("          LmkReg_0x0172: 0x02\n")
                    ofd.write("          LmkReg_0x0173: 0x0 \n") 
                    ofd.write("          LmkReg_0x0174: 0x0 \n") 
                
            else:
                pass
        
    # Close the files
    ifd.close()
    ofd.close()        
        
if __name__ == '__main__':
    hex2yaml(sys.argv[1],sys.argv[2])
        