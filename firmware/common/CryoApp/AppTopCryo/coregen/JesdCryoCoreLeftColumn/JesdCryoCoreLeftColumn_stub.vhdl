-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
-- Date        : Thu May 11 03:40:14 2017
-- Host        : ppa-pc92464 running 64-bit Red Hat Enterprise Linux Server release 6.9 (Santiago)
-- Command     : write_vhdl -force -mode synth_stub
--               /afs/slac.stanford.edu/u/re/ulegat/ProjDocs/cryo-det/firmware/common/CryoApp/AppTopCryo/coregen/JesdCryoCoreLeftColumn/JesdCryoCoreLeftColumn_stub.vhdl
-- Design      : JesdCryoCoreLeftColumn
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity JesdCryoCoreLeftColumn is
  Port ( 
    gtwiz_userclk_tx_active_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_userclk_rx_active_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_tx_reset_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_tx_start_user_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_tx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_tx_error_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_all_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_pll_and_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_pll_and_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_cdr_stable_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_userdata_tx_in : in STD_LOGIC_VECTOR ( 95 downto 0 );
    gtwiz_userdata_rx_out : out STD_LOGIC_VECTOR ( 95 downto 0 );
    drpaddr_in : in STD_LOGIC_VECTOR ( 26 downto 0 );
    drpclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    drpdi_in : in STD_LOGIC_VECTOR ( 47 downto 0 );
    drpen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    drpwe_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gthrxn_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gthrxp_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtrefclk0_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rx8b10ben_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcommadeten_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxmcommaalignen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxpcommaalignen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxpd_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    rxpolarity_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxusrclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxusrclk2_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    tx8b10ben_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txctrl0_in : in STD_LOGIC_VECTOR ( 47 downto 0 );
    txctrl1_in : in STD_LOGIC_VECTOR ( 47 downto 0 );
    txctrl2_in : in STD_LOGIC_VECTOR ( 23 downto 0 );
    txdiffctrl_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    txpd_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    txpolarity_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txusrclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txusrclk2_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    drpdo_out : out STD_LOGIC_VECTOR ( 47 downto 0 );
    drprdy_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    gthtxn_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    gthtxp_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxbyteisaligned_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxbyterealign_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcommadet_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxctrl0_out : out STD_LOGIC_VECTOR ( 47 downto 0 );
    rxctrl1_out : out STD_LOGIC_VECTOR ( 47 downto 0 );
    rxctrl2_out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    rxctrl3_out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    rxoutclk_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxpmaresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txoutclk_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txpmaresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txprgdivresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );

end JesdCryoCoreLeftColumn;

architecture stub of JesdCryoCoreLeftColumn is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "gtwiz_userclk_tx_active_in[0:0],gtwiz_userclk_rx_active_in[0:0],gtwiz_buffbypass_tx_reset_in[0:0],gtwiz_buffbypass_tx_start_user_in[0:0],gtwiz_buffbypass_tx_done_out[0:0],gtwiz_buffbypass_tx_error_out[0:0],gtwiz_reset_clk_freerun_in[0:0],gtwiz_reset_all_in[0:0],gtwiz_reset_tx_pll_and_datapath_in[0:0],gtwiz_reset_tx_datapath_in[0:0],gtwiz_reset_rx_pll_and_datapath_in[0:0],gtwiz_reset_rx_datapath_in[0:0],gtwiz_reset_rx_cdr_stable_out[0:0],gtwiz_reset_tx_done_out[0:0],gtwiz_reset_rx_done_out[0:0],gtwiz_userdata_tx_in[95:0],gtwiz_userdata_rx_out[95:0],drpaddr_in[26:0],drpclk_in[2:0],drpdi_in[47:0],drpen_in[2:0],drpwe_in[2:0],gthrxn_in[2:0],gthrxp_in[2:0],gtrefclk0_in[2:0],rx8b10ben_in[2:0],rxcommadeten_in[2:0],rxmcommaalignen_in[2:0],rxpcommaalignen_in[2:0],rxpd_in[5:0],rxpolarity_in[2:0],rxusrclk_in[2:0],rxusrclk2_in[2:0],tx8b10ben_in[2:0],txctrl0_in[47:0],txctrl1_in[47:0],txctrl2_in[23:0],txdiffctrl_in[11:0],txpd_in[5:0],txpolarity_in[2:0],txusrclk_in[2:0],txusrclk2_in[2:0],drpdo_out[47:0],drprdy_out[2:0],gthtxn_out[2:0],gthtxp_out[2:0],rxbyteisaligned_out[2:0],rxbyterealign_out[2:0],rxcommadet_out[2:0],rxctrl0_out[47:0],rxctrl1_out[47:0],rxctrl2_out[23:0],rxctrl3_out[23:0],rxoutclk_out[2:0],rxpmaresetdone_out[2:0],txoutclk_out[2:0],txpmaresetdone_out[2:0],txprgdivresetdone_out[2:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "JesdCryoCoreLeftColumn_gtwizard_top,Vivado 2016.4";
begin
end;
