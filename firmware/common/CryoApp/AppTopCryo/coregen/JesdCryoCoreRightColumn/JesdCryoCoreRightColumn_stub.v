// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
// Date        : Thu May 11 04:02:34 2017
// Host        : ppa-pc92464 running 64-bit Red Hat Enterprise Linux Server release 6.9 (Santiago)
// Command     : write_verilog -force -mode synth_stub
//               /afs/slac.stanford.edu/u/re/ulegat/ProjDocs/cryo-det/firmware/common/CryoApp/AppTopCryo/coregen/JesdCryoCoreRightColumn/JesdCryoCoreRightColumn_stub.v
// Design      : JesdCryoCoreRightColumn
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "JesdCryoCoreRightColumn_gtwizard_top,Vivado 2016.4" *)
module JesdCryoCoreRightColumn(gtwiz_userclk_tx_active_in, 
  gtwiz_userclk_rx_active_in, gtwiz_buffbypass_tx_reset_in, 
  gtwiz_buffbypass_tx_start_user_in, gtwiz_buffbypass_tx_done_out, 
  gtwiz_buffbypass_tx_error_out, gtwiz_reset_clk_freerun_in, gtwiz_reset_all_in, 
  gtwiz_reset_tx_pll_and_datapath_in, gtwiz_reset_tx_datapath_in, 
  gtwiz_reset_rx_pll_and_datapath_in, gtwiz_reset_rx_datapath_in, 
  gtwiz_reset_rx_cdr_stable_out, gtwiz_reset_tx_done_out, gtwiz_reset_rx_done_out, 
  gtwiz_userdata_tx_in, gtwiz_userdata_rx_out, drpaddr_in, drpclk_in, drpdi_in, drpen_in, 
  drpwe_in, gthrxn_in, gthrxp_in, gtrefclk0_in, rx8b10ben_in, rxcommadeten_in, 
  rxmcommaalignen_in, rxpcommaalignen_in, rxpd_in, rxpolarity_in, rxusrclk_in, rxusrclk2_in, 
  tx8b10ben_in, txctrl0_in, txctrl1_in, txctrl2_in, txdiffctrl_in, txpd_in, txpolarity_in, 
  txusrclk_in, txusrclk2_in, drpdo_out, drprdy_out, gthtxn_out, gthtxp_out, 
  rxbyteisaligned_out, rxbyterealign_out, rxcommadet_out, rxctrl0_out, rxctrl1_out, 
  rxctrl2_out, rxctrl3_out, rxoutclk_out, rxpmaresetdone_out, txoutclk_out, 
  txpmaresetdone_out, txprgdivresetdone_out)
/* synthesis syn_black_box black_box_pad_pin="gtwiz_userclk_tx_active_in[0:0],gtwiz_userclk_rx_active_in[0:0],gtwiz_buffbypass_tx_reset_in[0:0],gtwiz_buffbypass_tx_start_user_in[0:0],gtwiz_buffbypass_tx_done_out[0:0],gtwiz_buffbypass_tx_error_out[0:0],gtwiz_reset_clk_freerun_in[0:0],gtwiz_reset_all_in[0:0],gtwiz_reset_tx_pll_and_datapath_in[0:0],gtwiz_reset_tx_datapath_in[0:0],gtwiz_reset_rx_pll_and_datapath_in[0:0],gtwiz_reset_rx_datapath_in[0:0],gtwiz_reset_rx_cdr_stable_out[0:0],gtwiz_reset_tx_done_out[0:0],gtwiz_reset_rx_done_out[0:0],gtwiz_userdata_tx_in[223:0],gtwiz_userdata_rx_out[223:0],drpaddr_in[62:0],drpclk_in[6:0],drpdi_in[111:0],drpen_in[6:0],drpwe_in[6:0],gthrxn_in[6:0],gthrxp_in[6:0],gtrefclk0_in[6:0],rx8b10ben_in[6:0],rxcommadeten_in[6:0],rxmcommaalignen_in[6:0],rxpcommaalignen_in[6:0],rxpd_in[13:0],rxpolarity_in[6:0],rxusrclk_in[6:0],rxusrclk2_in[6:0],tx8b10ben_in[6:0],txctrl0_in[111:0],txctrl1_in[111:0],txctrl2_in[55:0],txdiffctrl_in[27:0],txpd_in[13:0],txpolarity_in[6:0],txusrclk_in[6:0],txusrclk2_in[6:0],drpdo_out[111:0],drprdy_out[6:0],gthtxn_out[6:0],gthtxp_out[6:0],rxbyteisaligned_out[6:0],rxbyterealign_out[6:0],rxcommadet_out[6:0],rxctrl0_out[111:0],rxctrl1_out[111:0],rxctrl2_out[55:0],rxctrl3_out[55:0],rxoutclk_out[6:0],rxpmaresetdone_out[6:0],txoutclk_out[6:0],txpmaresetdone_out[6:0],txprgdivresetdone_out[6:0]" */;
  input [0:0]gtwiz_userclk_tx_active_in;
  input [0:0]gtwiz_userclk_rx_active_in;
  input [0:0]gtwiz_buffbypass_tx_reset_in;
  input [0:0]gtwiz_buffbypass_tx_start_user_in;
  output [0:0]gtwiz_buffbypass_tx_done_out;
  output [0:0]gtwiz_buffbypass_tx_error_out;
  input [0:0]gtwiz_reset_clk_freerun_in;
  input [0:0]gtwiz_reset_all_in;
  input [0:0]gtwiz_reset_tx_pll_and_datapath_in;
  input [0:0]gtwiz_reset_tx_datapath_in;
  input [0:0]gtwiz_reset_rx_pll_and_datapath_in;
  input [0:0]gtwiz_reset_rx_datapath_in;
  output [0:0]gtwiz_reset_rx_cdr_stable_out;
  output [0:0]gtwiz_reset_tx_done_out;
  output [0:0]gtwiz_reset_rx_done_out;
  input [223:0]gtwiz_userdata_tx_in;
  output [223:0]gtwiz_userdata_rx_out;
  input [62:0]drpaddr_in;
  input [6:0]drpclk_in;
  input [111:0]drpdi_in;
  input [6:0]drpen_in;
  input [6:0]drpwe_in;
  input [6:0]gthrxn_in;
  input [6:0]gthrxp_in;
  input [6:0]gtrefclk0_in;
  input [6:0]rx8b10ben_in;
  input [6:0]rxcommadeten_in;
  input [6:0]rxmcommaalignen_in;
  input [6:0]rxpcommaalignen_in;
  input [13:0]rxpd_in;
  input [6:0]rxpolarity_in;
  input [6:0]rxusrclk_in;
  input [6:0]rxusrclk2_in;
  input [6:0]tx8b10ben_in;
  input [111:0]txctrl0_in;
  input [111:0]txctrl1_in;
  input [55:0]txctrl2_in;
  input [27:0]txdiffctrl_in;
  input [13:0]txpd_in;
  input [6:0]txpolarity_in;
  input [6:0]txusrclk_in;
  input [6:0]txusrclk2_in;
  output [111:0]drpdo_out;
  output [6:0]drprdy_out;
  output [6:0]gthtxn_out;
  output [6:0]gthtxp_out;
  output [6:0]rxbyteisaligned_out;
  output [6:0]rxbyterealign_out;
  output [6:0]rxcommadet_out;
  output [111:0]rxctrl0_out;
  output [111:0]rxctrl1_out;
  output [55:0]rxctrl2_out;
  output [55:0]rxctrl3_out;
  output [6:0]rxoutclk_out;
  output [6:0]rxpmaresetdone_out;
  output [6:0]txoutclk_out;
  output [6:0]txpmaresetdone_out;
  output [6:0]txprgdivresetdone_out;
endmodule
