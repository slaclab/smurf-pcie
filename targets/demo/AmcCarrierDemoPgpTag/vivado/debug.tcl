##############################################################################
## This file is part of 'LCLS2 LLRF Development'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'LCLS2 LLRF Development', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################


# User Debug Script

# Open the run
open_run synth_1

# Configure the Core
set ilaAxisClk u_ila_0

# Create 1st Debug Core
CreateDebugCore ${ilaAxisClk}

SetDebugCoreClk ${ilaAxisClk} {axiClk}

set_property C_DATA_DEPTH 2048 [get_debug_cores ${ilaAxisClk}]

ConfigProbe ${ilaAxisClk} {AdcDdrFifo_1/axiWriteMaster[awvalid]}
ConfigProbe ${ilaAxisClk} {AdcDdrFifo_1/axiWriteMaster[awaddr][*]}
ConfigProbe ${ilaAxisClk} {AdcDdrFifo_1/axiWriteMaster[awburst][*]}
ConfigProbe ${ilaAxisClk} {AdcDdrFifo_1/axiWriteMaster[wdata][*]}
ConfigProbe ${ilaAxisClk} {AdcDdrFifo_1/axiWriteMaster[bready]}

ConfigProbe ${ilaAxisClk} {AdcDdrFifo_1/axiWriteSlave[bresp][*]}
ConfigProbe ${ilaAxisClk} {AdcDdrFifo_1/axiWriteSlave[bid][*]}
ConfigProbe ${ilaAxisClk} {AdcDdrFifo_1/axiWriteSlave[awready]}
ConfigProbe ${ilaAxisClk} {AdcDdrFifo_1/axiWriteSlave[bvalid]}

ConfigProbe ${ilaAxisClk} {AdcDdrFifo_1/full[*]}
ConfigProbe ${ilaAxisClk} {AdcDdrFifo_1/idle[*]}
ConfigProbe ${ilaAxisClk} {AdcDdrFifo_1/sAxisSlave[0][tReady]}
ConfigProbe ${ilaAxisClk} {AdcDdrFifo_1/sAxisSlave[1][tReady]}

delete_debug_port [get_debug_ports [GetCurrentProbe ${ilaAxisClk}]]

# Write the port map file
write_debug_probes -force ${PROJ_DIR}/debug_probes.ltx

