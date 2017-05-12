// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
// Date        : Thu May 11 03:40:14 2017
// Host        : ppa-pc92464 running 64-bit Red Hat Enterprise Linux Server release 6.9 (Santiago)
// Command     : write_verilog -force -mode synth_stub
//               /afs/slac.stanford.edu/u/re/ulegat/ProjDocs/cryo-det/firmware/common/CryoApp/AppTopCryo/coregen/JesdCryoCoreLeftColumn/JesdCryoCoreLeftColumn_stub.v
// Design      : JesdCryoCoreLeftColumn
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "JesdCryoCoreLeftColumn_gtwizard_top,Vivado 2016.4" *)
module JesdCryoCoreLeftColumn(gtwiz_userclk_tx_active_in, 
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
/* synthesis syn_black_box black_box_pad_pin="gtwiz_userclk_tx_active_in[0:0],gtwiz_userclk_rx_active_in[0:0],gtwiz_buffbypass_tx_reset_in[0:0],gtwiz_buffbypass_tx_start_user_in[0:0],gtwiz_buffbypass_tx_done_out[0:0],gtwiz_buffbypass_tx_error_out[0:0],gtwiz_reset_clk_freerun_in[0:0],gtwiz_reset_all_in[0:0],gtwiz_reset_tx_pll_and_datapath_in[0:0],gtwiz_reset_tx_datapath_in[0:0],gtwiz_reset_rx_pll_and_datapath_in[0:0],gtwiz_reset_rx_datapath_in[0:0],gtwiz_reset_rx_cdr_stable_out[0:0],gtwiz_reset_tx_done_out[0:0],gtwiz_reset_rx_done_out[0:0],gtwiz_userdata_tx_in[95:0],gtwiz_userdata_rx_out[95:0],drpaddr_in[26:0],drpclk_in[2:0],drpdi_in[47:0],drpen_in[2:0],drpwe_in[2:0],gthrxn_in[2:0],gthrxp_in[2:0],gtrefclk0_in[2:0],rx8b10ben_in[2:0],rxcommadeten_in[2:0],rxmcommaalignen_in[2:0],rxpcommaalignen_in[2:0],rxpd_in[5:0],rxpolarity_in[2:0],rxusrclk_in[2:0],rxusrclk2_in[2:0],tx8b10ben_in[2:0],txctrl0_in[47:0],txctrl1_in[47:0],txctrl2_in[23:0],txdiffctrl_in[11:0],txpd_in[5:0],txpolarity_in[2:0],txusrclk_in[2:0],txusrclk2_in[2:0],drpdo_out[47:0],drprdy_out[2:0],gthtxn_out[2:0],gthtxp_out[2:0],rxbyteisaligned_out[2:0],rxbyterealign_out[2:0],rxcommadet_out[2:0],rxctrl0_out[47:0],rxctrl1_out[47:0],rxctrl2_out[23:0],rxctrl3_out[23:0],rxoutclk_out[2:0],rxpmaresetdone_out[2:0],txoutclk_out[2:0],txpmaresetdone_out[2:0],txprgdivresetdone_out[2:0]" */;
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
  input [95:0]gtwiz_userdata_tx_in;
  output [95:0]gtwiz_userdata_rx_out;
  input [26:0]drpaddr_in;
  input [2:0]drpclk_in;
  input [47:0]drpdi_in;
  input [2:0]drpen_in;
  input [2:0]drpwe_in;
  input [2:0]gthrxn_in;
  input [2:0]gthrxp_in;
  input [2:0]gtrefclk0_in;
  input [2:0]rx8b10ben_in;
  input [2:0]rxcommadeten_in;
  input [2:0]rxmcommaalignen_in;
  input [2:0]rxpcommaalignen_in;
  input [5:0]rxpd_in;
  input [2:0]rxpolarity_in;
  input [2:0]rxusrclk_in;
  input [2:0]rxusrclk2_in;
  input [2:0]tx8b10ben_in;
  input [47:0]txctrl0_in;
  input [47:0]txctrl1_in;
  input [23:0]txctrl2_in;
  input [11:0]txdiffctrl_in;
  input [5:0]txpd_in;
  input [2:0]txpolarity_in;
  input [2:0]txusrclk_in;
  input [2:0]txusrclk2_in;
  output [47:0]drpdo_out;
  output [2:0]drprdy_out;
  output [2:0]gthtxn_out;
  output [2:0]gthtxp_out;
  output [2:0]rxbyteisaligned_out;
  output [2:0]rxbyterealign_out;
  output [2:0]rxcommadet_out;
  output [47:0]rxctrl0_out;
  output [47:0]rxctrl1_out;
  output [23:0]rxctrl2_out;
  output [23:0]rxctrl3_out;
  output [2:0]rxoutclk_out;
  output [2:0]rxpmaresetdone_out;
  output [2:0]txoutclk_out;
  output [2:0]txpmaresetdone_out;
  output [2:0]txprgdivresetdone_out;
endmodule
