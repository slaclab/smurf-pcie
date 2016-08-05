##############################################################################
## This file is part of 'LCLS2 LLRF Development'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'LCLS2 LLRF Development', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################
set_property PACKAGE_PIN F6 [get_ports {jesdTxP[1][0]}]
set_property PACKAGE_PIN F5 [get_ports {jesdTxN[1][0]}]
set_property PACKAGE_PIN E4 [get_ports {jesdRxP[1][0]}]
set_property PACKAGE_PIN E3 [get_ports {jesdRxN[1][0]}]
set_property PACKAGE_PIN D6 [get_ports {jesdTxP[1][1]}]
set_property PACKAGE_PIN D5 [get_ports {jesdTxN[1][1]}]
set_property PACKAGE_PIN D2 [get_ports {jesdRxP[1][1]}]
set_property PACKAGE_PIN D1 [get_ports {jesdRxN[1][1]}]
                           
set_property PACKAGE_PIN N4 [get_ports {jesdTxP[1][2]}]
set_property PACKAGE_PIN N3 [get_ports {jesdTxN[1][2]}]
set_property PACKAGE_PIN M2 [get_ports {jesdRxP[1][2]}]
set_property PACKAGE_PIN M1 [get_ports {jesdRxN[1][2]}]
set_property PACKAGE_PIN L4 [get_ports {jesdTxP[1][3]}]
set_property PACKAGE_PIN L3 [get_ports {jesdTxN[1][3]}]
set_property PACKAGE_PIN K2 [get_ports {jesdRxP[1][3]}]
set_property PACKAGE_PIN K1 [get_ports {jesdRxN[1][3]}]
                           
set_property PACKAGE_PIN J4 [get_ports {jesdTxP[1][4]}]
set_property PACKAGE_PIN J3 [get_ports {jesdTxN[1][4]}]
set_property PACKAGE_PIN H2 [get_ports {jesdRxP[1][4]}]
set_property PACKAGE_PIN H1 [get_ports {jesdRxN[1][4]}]
set_property PACKAGE_PIN G4 [get_ports {jesdTxP[1][5]}]
set_property PACKAGE_PIN G3 [get_ports {jesdTxN[1][5]}]
set_property PACKAGE_PIN F2 [get_ports {jesdRxP[1][5]}]
set_property PACKAGE_PIN F1 [get_ports {jesdRxN[1][5]}]

# Spare_Dclk8 clock 
set_property PACKAGE_PIN M6 [get_ports {jesdClkP[1]}] 
set_property PACKAGE_PIN M5 [get_ports {jesdClkN[1]}]

# Spare_SDclk9 clock Note! Different jesdSysRef pins from AMC0

#P13 PIN139
set_property -dict { PACKAGE_PIN W30 IOSTANDARD LVDS DIFF_TERM_ADV TERM_100 } [get_ports {jesdSysRefP[1]}]
#P13 PIN138 
set_property -dict { PACKAGE_PIN Y30 IOSTANDARD LVDS DIFF_TERM_ADV TERM_100 } [get_ports {jesdSysRefN[1]}]

# Note! Different jesdSync pins from AMC0
# Note! jesdSync are inverted

#P13 PIN130
set_property -dict { PACKAGE_PIN U34   IOSTANDARD LVDS } [get_ports {jesdSyncP[1][0]}]
#P13 PIN129
set_property -dict { PACKAGE_PIN V34   IOSTANDARD LVDS } [get_ports {jesdSyncN[1][0]}]
#P13 PIN124
set_property -dict { PACKAGE_PIN AN14  IOSTANDARD LVDS } [get_ports {jesdSyncP[1][1]}]
#P13 PIN123
set_property -dict { PACKAGE_PIN AP14  IOSTANDARD LVDS } [get_ports {jesdSyncN[1][1]}]
#P13 PIN121
set_property -dict { PACKAGE_PIN AD21  IOSTANDARD LVDS } [get_ports {jesdSyncP[1][2]}]
#P13 PIN120
set_property -dict { PACKAGE_PIN AE21  IOSTANDARD LVDS } [get_ports {jesdSyncN[1][2]}]

# LMK and ADC SPI
set_property -dict { PACKAGE_PIN AP9  IOSTANDARD LVCMOS25 PULLUP true} [get_ports {spiSdio_io[1]}] 
set_property -dict { PACKAGE_PIN AL10 IOSTANDARD LVCMOS25 PULLUP true} [get_ports {spiSclk_o[1]}] 
set_property -dict { PACKAGE_PIN AM10 IOSTANDARD LVCMOS25 PULLUP true} [get_ports {spiSdi_o[1]}] 
set_property -dict { PACKAGE_PIN AH9  IOSTANDARD LVCMOS25 PULLUP true} [get_ports {spiSdo_i[1]}]

#P13 PIN153 Note! Different from AMC0
set_property -dict { PACKAGE_PIN AA25 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiCsL_o[1][0]}]
set_property -dict { PACKAGE_PIN Y23  IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiCsL_o[1][1]}] 
set_property -dict { PACKAGE_PIN AA23 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiCsL_o[1][2]}]
set_property -dict { PACKAGE_PIN AA24 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {spiCsL_o[1][3]}]
#P13 PIN169 Note! Added AdcLmkSpiCsL_o[4] for selecting Parallel DAC
set_property -dict { PACKAGE_PIN AH8 IOSTANDARD LVCMOS25 PULLUP true}  [get_ports {spiCsL_o[1][4]}]

# Attenuator
set_property -dict { PACKAGE_PIN  AB31 IOSTANDARD LVCMOS18} [get_ports {attSclk_o[1]}]
set_property -dict { PACKAGE_PIN  AB30 IOSTANDARD LVCMOS18} [get_ports {attSdi_o[1]}]

# Note! Different form AMC0 (only 4 of them)
set_property -dict { PACKAGE_PIN  AC32 IOSTANDARD LVCMOS18} [get_ports {attLatchEn_o[1][0]}]
set_property -dict { PACKAGE_PIN  AC31 IOSTANDARD LVCMOS18} [get_ports {attLatchEn_o[1][1]}]
set_property -dict { PACKAGE_PIN  AB32 IOSTANDARD LVCMOS18} [get_ports {attLatchEn_o[1][2]}]
set_property -dict { PACKAGE_PIN  AA32 IOSTANDARD LVCMOS18} [get_ports {attLatchEn_o[1][3]}]

# Note! Unused
#set_property -dict { PACKAGE_PIN   IOSTANDARD LVCMOS18} [get_ports {attLatchEn_o[1][4]}]
#set_property -dict { PACKAGE_PIN   IOSTANDARD LVCMOS18} [get_ports {attLatchEn_o[1][5]}]

# LVDS DAC signals
set_property -dict { PACKAGE_PIN AD30   IOSTANDARD LVDS} [get_ports {dacDataP[0]}]
set_property -dict { PACKAGE_PIN AD31   IOSTANDARD LVDS} [get_ports {dacDataN[0]}]
set_property -dict { PACKAGE_PIN AB25   IOSTANDARD LVDS} [get_ports {dacDataP[1]}]
set_property -dict { PACKAGE_PIN AB26   IOSTANDARD LVDS} [get_ports {dacDataN[1]}]
set_property -dict { PACKAGE_PIN AA27   IOSTANDARD LVDS} [get_ports {dacDataP[2]}]
set_property -dict { PACKAGE_PIN AB27   IOSTANDARD LVDS} [get_ports {dacDataN[2]}]
set_property -dict { PACKAGE_PIN AC26   IOSTANDARD LVDS} [get_ports {dacDataP[3]}]
set_property -dict { PACKAGE_PIN AC27   IOSTANDARD LVDS} [get_ports {dacDataN[3]}]
set_property -dict { PACKAGE_PIN AB24   IOSTANDARD LVDS} [get_ports {dacDataP[4]}]
set_property -dict { PACKAGE_PIN AC24   IOSTANDARD LVDS} [get_ports {dacDataN[4]}]
set_property -dict { PACKAGE_PIN AD25   IOSTANDARD LVDS} [get_ports {dacDataP[5]}]
set_property -dict { PACKAGE_PIN AD26   IOSTANDARD LVDS} [get_ports {dacDataN[5]}]
set_property -dict { PACKAGE_PIN Y26    IOSTANDARD LVDS} [get_ports {dacDataP[6]}]
set_property -dict { PACKAGE_PIN Y27    IOSTANDARD LVDS} [get_ports {dacDataN[6]}]

# Note: This is a workaround because of board design fault (Connect back after next revision of AMC card) 
# set_property -dict { PACKAGE_PIN J29    IOSTANDARD LVDS} [get_ports {dacDataP[7]}]
# set_property -dict { PACKAGE_PIN J30    IOSTANDARD LVDS} [get_ports {dacDataN[7]}]
set_property -dict { PACKAGE_PIN W33    IOSTANDARD LVDS} [get_ports {dacDataP[7]}]
set_property -dict { PACKAGE_PIN Y33    IOSTANDARD LVDS} [get_ports {dacDataN[7]}]
set_property -dict { PACKAGE_PIN AM22   IOSTANDARD LVDS} [get_ports {dacDataP[8]}]
set_property -dict { PACKAGE_PIN AN22   IOSTANDARD LVDS} [get_ports {dacDataN[8]}]
set_property -dict { PACKAGE_PIN AF30   IOSTANDARD LVDS} [get_ports {dacDataP[9]}]
set_property -dict { PACKAGE_PIN AG30   IOSTANDARD LVDS} [get_ports {dacDataN[9]}]
set_property -dict { PACKAGE_PIN AM21   IOSTANDARD LVDS} [get_ports {dacDataP[10]}]
set_property -dict { PACKAGE_PIN AN21   IOSTANDARD LVDS} [get_ports {dacDataN[10]}]
set_property -dict { PACKAGE_PIN AC34   IOSTANDARD LVDS} [get_ports {dacDataP[11]}]
set_property -dict { PACKAGE_PIN AD34   IOSTANDARD LVDS} [get_ports {dacDataN[11]}]
set_property -dict { PACKAGE_PIN AL24   IOSTANDARD LVDS} [get_ports {dacDataP[12]}]
set_property -dict { PACKAGE_PIN AL25   IOSTANDARD LVDS} [get_ports {dacDataN[12]}]
set_property -dict { PACKAGE_PIN AE33   IOSTANDARD LVDS} [get_ports {dacDataP[13]}]
set_property -dict { PACKAGE_PIN AF34   IOSTANDARD LVDS} [get_ports {dacDataN[13]}]
set_property -dict { PACKAGE_PIN AL22   IOSTANDARD LVDS} [get_ports {dacDataP[14]}]
set_property -dict { PACKAGE_PIN AL23   IOSTANDARD LVDS} [get_ports {dacDataN[14]}]
set_property -dict { PACKAGE_PIN AF20   IOSTANDARD LVDS} [get_ports {dacDataP[15]}]
set_property -dict { PACKAGE_PIN AG20   IOSTANDARD LVDS} [get_ports {dacDataN[15]}]
# DCK (Connected so it is not inverted)
set_property -dict { PACKAGE_PIN AG31  IOSTANDARD LVDS} [get_ports {dacDckP}]
set_property -dict { PACKAGE_PIN AG32  IOSTANDARD LVDS} [get_ports {dacDckN}]

# Interlock and trigger
set_property -dict { PACKAGE_PIN AD9  IOSTANDARD LVCMOS25 } [get_ports {timingTrig}]
set_property -dict { PACKAGE_PIN AE8  IOSTANDARD LVCMOS25 } [get_ports {fpgaInterlock}]


