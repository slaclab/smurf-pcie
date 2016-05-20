##############################################################################
## This file is part of 'LCLS2 LLRF Development'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'LCLS2 LLRF Development', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################

## Check for version 2015.4 of Vivado
if { [VersionCheck 2015.4] < 0 } {
   close_project
   exit -1
}

## Source the AMC Carrier Core's .TCL file
source $::env(PROJ_DIR)/../../../modules/AmcCarrierCore/vivado/debug_properties.tcl