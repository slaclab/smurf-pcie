-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
-- Date        : Thu May 11 04:02:34 2017
-- Host        : ppa-pc92464 running 64-bit Red Hat Enterprise Linux Server release 6.9 (Santiago)
-- Command     : write_vhdl -force -mode funcsim
--               /afs/slac.stanford.edu/u/re/ulegat/ProjDocs/cryo-det/firmware/common/CryoApp/AppTopCryo/coregen/JesdCryoCoreRightColumn/JesdCryoCoreRightColumn_sim_netlist.vhdl
-- Design      : JesdCryoCoreRightColumn
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer is
  port (
    rxresetdone_sync : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxresetdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rxresetdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => rxresetdone_sync(0),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_0 is
  port (
    txresetdone_sync : out STD_LOGIC_VECTOR ( 0 to 0 );
    txresetdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_0 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_0;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_0 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => txresetdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => txresetdone_sync(0),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_1 is
  port (
    sm_reset_rx_timer_clr_reg : out STD_LOGIC;
    rxresetdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_in_out_reg_0 : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_1 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_1;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_1 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  signal rxresetdone_sync : STD_LOGIC_VECTOR ( 1 to 1 );
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
\FSM_sequential_sm_reset_rx[2]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => rxresetdone_sync(1),
      I1 => i_in_out_reg_0(0),
      I2 => i_in_out_reg_0(2),
      I3 => i_in_out_reg_0(1),
      O => sm_reset_rx_timer_clr_reg
    );
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rxresetdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => rxresetdone_sync(1),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_10 is
  port (
    txresetdone_sync : out STD_LOGIC_VECTOR ( 0 to 0 );
    sm_reset_tx_timer_clr_reg : out STD_LOGIC;
    txresetdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_in_out_reg_0 : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_10 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_10;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_10 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  signal \^txresetdone_sync\ : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
  txresetdone_sync(0) <= \^txresetdone_sync\(0);
\FSM_sequential_sm_reset_tx[2]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \^txresetdone_sync\(0),
      I1 => i_in_out_reg_0(1),
      I2 => i_in_out_reg_0(0),
      O => sm_reset_tx_timer_clr_reg
    );
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => txresetdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => \^txresetdone_sync\(0),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_11 is
  port (
    \FSM_sequential_sm_reset_rx_reg[0]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxresetdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_11 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_11;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_11 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rxresetdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => \FSM_sequential_sm_reset_rx_reg[0]\(0),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_12 is
  port (
    gtwiz_reset_tx_done_int_reg : out STD_LOGIC_VECTOR ( 0 to 0 );
    txresetdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_12 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_12;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_12 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => txresetdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => gtwiz_reset_tx_done_int_reg(0),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_13 is
  port (
    \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.gtwiz_buffbypass_tx_error_out_reg\ : out STD_LOGIC;
    txphaligndone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    txusrclk2_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    out0 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_13 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_13;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_13 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_out : STD_LOGIC;
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
\gen_gtwiz_buffbypass_tx_main.gen_auto_mode.gtwiz_buffbypass_tx_error_out_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => out0,
      I1 => i_in_out,
      O => \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.gtwiz_buffbypass_tx_error_out_reg\
    );
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      D => txphaligndone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => i_in_out,
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_14 is
  port (
    gtwiz_buffbypass_tx_master_syncdone_sync_int : out STD_LOGIC;
    txsyncdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    txusrclk2_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_14 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_14;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_14 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      D => txsyncdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => gtwiz_buffbypass_tx_master_syncdone_sync_int,
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_15 is
  port (
    gtpowergood_sync : out STD_LOGIC;
    in0 : in STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_15 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_15;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_15 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => in0,
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => gtpowergood_sync,
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_16 is
  port (
    gtwiz_reset_rx_datapath_dly : out STD_LOGIC;
    in0 : in STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_16 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_16;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_16 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => in0,
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => gtwiz_reset_rx_datapath_dly,
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_17 is
  port (
    gtwiz_reset_rx_pll_and_datapath_dly : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 1 downto 0 );
    in0 : in STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    \out\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_0_in11_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_17 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_17;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_17 is
  signal \^gtwiz_reset_rx_pll_and_datapath_dly\ : STD_LOGIC;
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_sm_reset_rx[0]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \FSM_sequential_sm_reset_rx[1]_i_1\ : label is "soft_lutpair1";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
  gtwiz_reset_rx_pll_and_datapath_dly <= \^gtwiz_reset_rx_pll_and_datapath_dly\;
\FSM_sequential_sm_reset_rx[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0303BFBC"
    )
        port map (
      I0 => p_0_in11_out,
      I1 => \out\(1),
      I2 => \out\(2),
      I3 => \^gtwiz_reset_rx_pll_and_datapath_dly\,
      I4 => \out\(0),
      O => D(0)
    );
\FSM_sequential_sm_reset_rx[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00F3FF11"
    )
        port map (
      I0 => \^gtwiz_reset_rx_pll_and_datapath_dly\,
      I1 => \out\(2),
      I2 => p_0_in11_out,
      I3 => \out\(0),
      I4 => \out\(1),
      O => D(1)
    );
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => in0,
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => \^gtwiz_reset_rx_pll_and_datapath_dly\,
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_18 is
  port (
    gtwiz_reset_tx_datapath_dly : out STD_LOGIC;
    in0 : in STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_18 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_18;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_18 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => in0,
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => gtwiz_reset_tx_datapath_dly,
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_19 is
  port (
    gtwiz_reset_tx_pll_and_datapath_dly : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 1 downto 0 );
    in0 : in STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    \out\ : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_19 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_19;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_19 is
  signal \^gtwiz_reset_tx_pll_and_datapath_dly\ : STD_LOGIC;
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_sm_reset_tx[0]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \FSM_sequential_sm_reset_tx[1]_i_1\ : label is "soft_lutpair2";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
  gtwiz_reset_tx_pll_and_datapath_dly <= \^gtwiz_reset_tx_pll_and_datapath_dly\;
\FSM_sequential_sm_reset_tx[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5756"
    )
        port map (
      I0 => \out\(0),
      I1 => \out\(2),
      I2 => \out\(1),
      I3 => \^gtwiz_reset_tx_pll_and_datapath_dly\,
      O => D(0)
    );
\FSM_sequential_sm_reset_tx[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"03F1"
    )
        port map (
      I0 => \^gtwiz_reset_tx_pll_and_datapath_dly\,
      I1 => \out\(2),
      I2 => \out\(0),
      I3 => \out\(1),
      O => D(1)
    );
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => in0,
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => \^gtwiz_reset_tx_pll_and_datapath_dly\,
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_2 is
  port (
    sm_reset_tx_timer_clr_reg : out STD_LOGIC;
    txresetdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_in_out_reg_0 : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_2 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_2;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_2 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  signal txresetdone_sync : STD_LOGIC_VECTOR ( 1 to 1 );
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
\FSM_sequential_sm_reset_tx[2]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => txresetdone_sync(1),
      I1 => i_in_out_reg_0(0),
      I2 => i_in_out_reg_0(2),
      I3 => i_in_out_reg_0(1),
      O => sm_reset_tx_timer_clr_reg
    );
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => txresetdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => txresetdone_sync(1),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_20 is
  port (
    sm_reset_rx_timer_clr0 : out STD_LOGIC;
    rxuserrdy_out_reg : out STD_LOGIC;
    sm_reset_rx_timer_clr_reg : out STD_LOGIC;
    gtwiz_userclk_rx_active_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    sm_reset_rx_timer_clr_reg_0 : in STD_LOGIC;
    sm_reset_rx_timer_sat : in STD_LOGIC;
    \out\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtwiz_reset_rx_any_sync : in STD_LOGIC;
    GTHE3_CHANNEL_RXUSERRDY : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_in_out_reg_0 : in STD_LOGIC;
    i_in_out_reg_1 : in STD_LOGIC;
    i_in_out_reg_2 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_20 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_20;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_20 is
  signal gtwiz_reset_userclk_rx_active_sync : STD_LOGIC;
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  signal \^sm_reset_rx_timer_clr0\ : STD_LOGIC;
  signal sm_reset_rx_timer_clr_i_2_n_0 : STD_LOGIC;
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
  sm_reset_rx_timer_clr0 <= \^sm_reset_rx_timer_clr0\;
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => gtwiz_userclk_rx_active_in(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => gtwiz_reset_userclk_rx_active_sync,
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
rxuserrdy_out_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEDED00000800"
    )
        port map (
      I0 => \out\(0),
      I1 => \out\(2),
      I2 => \out\(1),
      I3 => \^sm_reset_rx_timer_clr0\,
      I4 => gtwiz_reset_rx_any_sync,
      I5 => GTHE3_CHANNEL_RXUSERRDY(0),
      O => rxuserrdy_out_reg
    );
rxuserrdy_out_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => sm_reset_rx_timer_clr_reg_0,
      I1 => sm_reset_rx_timer_sat,
      I2 => gtwiz_reset_userclk_rx_active_sync,
      O => \^sm_reset_rx_timer_clr0\
    );
sm_reset_rx_timer_clr_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAAFCCFF0AA0CC0F"
    )
        port map (
      I0 => sm_reset_rx_timer_clr_i_2_n_0,
      I1 => i_in_out_reg_0,
      I2 => \out\(0),
      I3 => \out\(1),
      I4 => \out\(2),
      I5 => sm_reset_rx_timer_clr_reg_0,
      O => sm_reset_rx_timer_clr_reg
    );
sm_reset_rx_timer_clr_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"004F000000400000"
    )
        port map (
      I0 => i_in_out_reg_1,
      I1 => i_in_out_reg_2,
      I2 => \out\(1),
      I3 => sm_reset_rx_timer_clr_reg_0,
      I4 => sm_reset_rx_timer_sat,
      I5 => gtwiz_reset_userclk_rx_active_sync,
      O => sm_reset_rx_timer_clr_i_2_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_21 is
  port (
    txuserrdy_out_reg : out STD_LOGIC;
    sm_reset_tx_timer_clr_reg : out STD_LOGIC;
    \FSM_sequential_sm_reset_tx_reg[0]\ : out STD_LOGIC;
    gtwiz_userclk_tx_active_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    sm_reset_tx_timer_clr_reg_0 : in STD_LOGIC;
    sm_reset_tx_timer_sat : in STD_LOGIC;
    \out\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtwiz_reset_tx_any_sync : in STD_LOGIC;
    GTHE3_CHANNEL_TXUSERRDY : in STD_LOGIC_VECTOR ( 0 to 0 );
    \FSM_sequential_sm_reset_tx_reg[1]\ : in STD_LOGIC;
    sm_reset_tx_timer_sat_reg : in STD_LOGIC;
    gtwiz_reset_tx_pll_and_datapath_dly : in STD_LOGIC;
    gtwiz_reset_tx_datapath_dly : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_21 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_21;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_21 is
  signal gtwiz_reset_userclk_tx_active_sync : STD_LOGIC;
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  signal sm_reset_tx_timer_clr0 : STD_LOGIC;
  signal sm_reset_tx_timer_clr_i_2_n_0 : STD_LOGIC;
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of sm_reset_tx_timer_clr_i_2 : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of txuserrdy_out_i_2 : label is "soft_lutpair3";
begin
\FSM_sequential_sm_reset_tx[2]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"40DD40DD40DD4088"
    )
        port map (
      I0 => \out\(1),
      I1 => sm_reset_tx_timer_sat_reg,
      I2 => gtwiz_reset_userclk_tx_active_sync,
      I3 => \out\(2),
      I4 => gtwiz_reset_tx_pll_and_datapath_dly,
      I5 => gtwiz_reset_tx_datapath_dly,
      O => \FSM_sequential_sm_reset_tx_reg[0]\
    );
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => gtwiz_userclk_tx_active_in(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => gtwiz_reset_userclk_tx_active_sync,
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
sm_reset_tx_timer_clr_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FCCFFAAF0CC00AAF"
    )
        port map (
      I0 => sm_reset_tx_timer_clr_i_2_n_0,
      I1 => \FSM_sequential_sm_reset_tx_reg[1]\,
      I2 => \out\(1),
      I3 => \out\(2),
      I4 => \out\(0),
      I5 => sm_reset_tx_timer_clr_reg_0,
      O => sm_reset_tx_timer_clr_reg
    );
sm_reset_tx_timer_clr_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3020"
    )
        port map (
      I0 => \out\(1),
      I1 => sm_reset_tx_timer_clr_reg_0,
      I2 => sm_reset_tx_timer_sat,
      I3 => gtwiz_reset_userclk_tx_active_sync,
      O => sm_reset_tx_timer_clr_i_2_n_0
    );
txuserrdy_out_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFCCF00000008"
    )
        port map (
      I0 => sm_reset_tx_timer_clr0,
      I1 => \out\(2),
      I2 => \out\(1),
      I3 => \out\(0),
      I4 => gtwiz_reset_tx_any_sync,
      I5 => GTHE3_CHANNEL_TXUSERRDY(0),
      O => txuserrdy_out_reg
    );
txuserrdy_out_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => sm_reset_tx_timer_clr_reg_0,
      I1 => sm_reset_tx_timer_sat,
      I2 => gtwiz_reset_userclk_tx_active_sync,
      O => sm_reset_tx_timer_clr0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_22 is
  port (
    sm_reset_rx_timer_clr09_out : out STD_LOGIC;
    gtrxreset_out_reg : out STD_LOGIC;
    gtwiz_reset_rx_done_int_reg : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    sm_reset_rx_timer_clr_reg : out STD_LOGIC;
    gtrxreset_out_reg_0 : in STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    sm_reset_rx_timer_clr_reg_0 : in STD_LOGIC;
    sm_reset_rx_timer_sat : in STD_LOGIC;
    \out\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtwiz_reset_rx_any_sync : in STD_LOGIC;
    GTHE3_CHANNEL_GTRXRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    p_0_in11_out : in STD_LOGIC;
    gtwiz_reset_rx_done_int_reg_0 : in STD_LOGIC;
    i_in_out_reg_0 : in STD_LOGIC;
    sm_reset_rx_cdr_to_sat_reg : in STD_LOGIC;
    sm_reset_rx_timer_clr0 : in STD_LOGIC;
    sm_reset_rx_pll_timer_sat : in STD_LOGIC;
    sm_reset_rx_pll_timer_clr_reg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_22 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_22;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_22 is
  signal \FSM_sequential_sm_reset_rx[2]_i_3_n_0\ : STD_LOGIC;
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  signal plllock_rx_sync : STD_LOGIC;
  signal \^sm_reset_rx_timer_clr09_out\ : STD_LOGIC;
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of sm_reset_rx_cdr_to_clr_i_3 : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of sm_reset_rx_timer_clr_i_3 : label is "soft_lutpair4";
begin
  sm_reset_rx_timer_clr09_out <= \^sm_reset_rx_timer_clr09_out\;
\FSM_sequential_sm_reset_rx[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \FSM_sequential_sm_reset_rx[2]_i_3_n_0\,
      I1 => \out\(0),
      I2 => i_in_out_reg_0,
      I3 => \out\(1),
      I4 => sm_reset_rx_cdr_to_sat_reg,
      O => E(0)
    );
\FSM_sequential_sm_reset_rx[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3088308830BB3088"
    )
        port map (
      I0 => \^sm_reset_rx_timer_clr09_out\,
      I1 => \out\(1),
      I2 => sm_reset_rx_timer_clr0,
      I3 => \out\(2),
      I4 => sm_reset_rx_pll_timer_sat,
      I5 => sm_reset_rx_pll_timer_clr_reg,
      O => \FSM_sequential_sm_reset_rx[2]_i_3_n_0\
    );
gtrxreset_out_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFF7F0000003C"
    )
        port map (
      I0 => \^sm_reset_rx_timer_clr09_out\,
      I1 => \out\(1),
      I2 => \out\(0),
      I3 => \out\(2),
      I4 => gtwiz_reset_rx_any_sync,
      I5 => GTHE3_CHANNEL_GTRXRESET(0),
      O => gtrxreset_out_reg
    );
gtwiz_reset_rx_done_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF77FF00800080"
    )
        port map (
      I0 => \out\(2),
      I1 => \out\(1),
      I2 => p_0_in11_out,
      I3 => \out\(0),
      I4 => plllock_rx_sync,
      I5 => gtwiz_reset_rx_done_int_reg_0,
      O => gtwiz_reset_rx_done_int_reg
    );
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => gtrxreset_out_reg_0,
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => plllock_rx_sync,
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
sm_reset_rx_cdr_to_clr_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => sm_reset_rx_timer_clr_reg_0,
      I1 => sm_reset_rx_timer_sat,
      I2 => plllock_rx_sync,
      O => \^sm_reset_rx_timer_clr09_out\
    );
sm_reset_rx_timer_clr_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00B0"
    )
        port map (
      I0 => plllock_rx_sync,
      I1 => \out\(0),
      I2 => sm_reset_rx_timer_sat,
      I3 => sm_reset_rx_timer_clr_reg_0,
      O => sm_reset_rx_timer_clr_reg
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_23 is
  port (
    gttxreset_out_reg : out STD_LOGIC;
    gtwiz_reset_tx_done_int_reg : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    sm_reset_tx_timer_clr_reg : out STD_LOGIC;
    gtrxreset_out_reg : in STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    sm_reset_tx_timer_sat : in STD_LOGIC;
    sm_reset_tx_timer_clr_reg_0 : in STD_LOGIC;
    \out\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtwiz_reset_tx_any_sync : in STD_LOGIC;
    GTHE3_CHANNEL_GTTXRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_done_int0 : in STD_LOGIC;
    gtwiz_reset_tx_done_int_reg_0 : in STD_LOGIC;
    \FSM_sequential_sm_reset_tx_reg[2]\ : in STD_LOGIC;
    \FSM_sequential_sm_reset_tx_reg[1]\ : in STD_LOGIC;
    i_in_out_reg_0 : in STD_LOGIC;
    i_in_out_reg_1 : in STD_LOGIC;
    sm_reset_tx_timer_sat_reg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_23 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_23;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_23 is
  signal \FSM_sequential_sm_reset_tx[2]_i_3_n_0\ : STD_LOGIC;
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  signal plllock_tx_sync : STD_LOGIC;
  signal sm_reset_tx_timer_clr012_out : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_sm_reset_tx[2]_i_3\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of gttxreset_out_i_2 : label is "soft_lutpair5";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
\FSM_sequential_sm_reset_tx[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \FSM_sequential_sm_reset_tx[2]_i_3_n_0\,
      I1 => \out\(1),
      I2 => \FSM_sequential_sm_reset_tx_reg[2]\,
      I3 => \out\(0),
      I4 => \FSM_sequential_sm_reset_tx_reg[1]\,
      O => E(0)
    );
\FSM_sequential_sm_reset_tx[2]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0008"
    )
        port map (
      I0 => plllock_tx_sync,
      I1 => sm_reset_tx_timer_sat,
      I2 => sm_reset_tx_timer_clr_reg_0,
      I3 => \out\(2),
      O => \FSM_sequential_sm_reset_tx[2]_i_3_n_0\
    );
gttxreset_out_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFF7F0000003C"
    )
        port map (
      I0 => sm_reset_tx_timer_clr012_out,
      I1 => \out\(1),
      I2 => \out\(0),
      I3 => \out\(2),
      I4 => gtwiz_reset_tx_any_sync,
      I5 => GTHE3_CHANNEL_GTTXRESET(0),
      O => gttxreset_out_reg
    );
gttxreset_out_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => sm_reset_tx_timer_clr_reg_0,
      I1 => sm_reset_tx_timer_sat,
      I2 => plllock_tx_sync,
      O => sm_reset_tx_timer_clr012_out
    );
gtwiz_reset_tx_done_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFCFFFFF00008080"
    )
        port map (
      I0 => gtwiz_reset_tx_done_int0,
      I1 => \out\(0),
      I2 => \out\(2),
      I3 => plllock_tx_sync,
      I4 => \out\(1),
      I5 => gtwiz_reset_tx_done_int_reg_0,
      O => gtwiz_reset_tx_done_int_reg
    );
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => gtrxreset_out_reg,
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => plllock_tx_sync,
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
sm_reset_tx_timer_clr_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"10FF000010100000"
    )
        port map (
      I0 => \out\(1),
      I1 => i_in_out_reg_0,
      I2 => i_in_out_reg_1,
      I3 => \out\(2),
      I4 => sm_reset_tx_timer_sat_reg,
      I5 => plllock_tx_sync,
      O => sm_reset_tx_timer_clr_reg
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_24 is
  port (
    gtwiz_reset_rx_cdr_stable_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    sm_reset_rx_cdr_to_clr_reg : out STD_LOGIC;
    rxprogdivreset_out_reg : out STD_LOGIC;
    \FSM_sequential_sm_reset_rx_reg[0]\ : out STD_LOGIC;
    gtrxreset_out_reg : in STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    \out\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    sm_reset_rx_timer_clr09_out : in STD_LOGIC;
    sm_reset_rx_cdr_to_clr : in STD_LOGIC;
    gtwiz_reset_rx_any_sync : in STD_LOGIC;
    GTHE3_CHANNEL_RXPROGDIVRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    sm_reset_rx_cdr_to_sat : in STD_LOGIC;
    gtwiz_reset_rx_pll_and_datapath_dly : in STD_LOGIC;
    gtwiz_reset_rx_datapath_dly : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_24 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_24;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_24 is
  signal \^gtwiz_reset_rx_cdr_stable_out\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  signal sm_reset_rx_cdr_to_clr0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_sm_reset_rx[2]_i_5\ : label is "soft_lutpair6";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
  attribute SOFT_HLUTNM of sm_reset_rx_cdr_to_clr_i_2 : label is "soft_lutpair6";
begin
  gtwiz_reset_rx_cdr_stable_out(0) <= \^gtwiz_reset_rx_cdr_stable_out\(0);
\FSM_sequential_sm_reset_rx[2]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFEFEFE0"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_sat,
      I1 => \^gtwiz_reset_rx_cdr_stable_out\(0),
      I2 => \out\(2),
      I3 => gtwiz_reset_rx_pll_and_datapath_dly,
      I4 => gtwiz_reset_rx_datapath_dly,
      O => \FSM_sequential_sm_reset_rx_reg[0]\
    );
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => gtrxreset_out_reg,
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => \^gtwiz_reset_rx_cdr_stable_out\(0),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
rxprogdivreset_out_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFF700000330"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_clr0,
      I1 => \out\(2),
      I2 => \out\(1),
      I3 => \out\(0),
      I4 => gtwiz_reset_rx_any_sync,
      I5 => GTHE3_CHANNEL_RXPROGDIVRESET(0),
      O => rxprogdivreset_out_reg
    );
sm_reset_rx_cdr_to_clr_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF3FFF02020303"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_clr0,
      I1 => \out\(1),
      I2 => \out\(0),
      I3 => sm_reset_rx_timer_clr09_out,
      I4 => \out\(2),
      I5 => sm_reset_rx_cdr_to_clr,
      O => sm_reset_rx_cdr_to_clr_reg
    );
sm_reset_rx_cdr_to_clr_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_sat,
      I1 => \^gtwiz_reset_rx_cdr_stable_out\(0),
      O => sm_reset_rx_cdr_to_clr0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_3 is
  port (
    sm_reset_rx_timer_clr_reg : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxresetdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_3 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_3;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_3 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rxresetdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => sm_reset_rx_timer_clr_reg(0),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_4 is
  port (
    sm_reset_tx_timer_clr_reg : out STD_LOGIC_VECTOR ( 0 to 0 );
    txresetdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_4 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_4;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_4 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => txresetdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => sm_reset_tx_timer_clr_reg(0),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_5 is
  port (
    sm_reset_rx_timer_clr_reg : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxresetdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_5 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_5;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_5 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rxresetdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => sm_reset_rx_timer_clr_reg(0),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_6 is
  port (
    sm_reset_tx_timer_clr_reg : out STD_LOGIC_VECTOR ( 0 to 0 );
    txresetdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_6 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_6;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_6 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => txresetdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => sm_reset_tx_timer_clr_reg(0),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_7 is
  port (
    rxresetdone_sync : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxresetdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_7 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_7;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_7 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rxresetdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => rxresetdone_sync(0),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_8 is
  port (
    txresetdone_sync : out STD_LOGIC_VECTOR ( 0 to 0 );
    txresetdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_8 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_8;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_8 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => txresetdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => txresetdone_sync(0),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_9 is
  port (
    rxresetdone_sync : out STD_LOGIC_VECTOR ( 0 to 0 );
    sm_reset_rx_timer_clr_reg : out STD_LOGIC;
    rxresetdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_in_out_reg_0 : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_9 : entity is "gtwizard_ultrascale_v1_6_5_bit_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_9;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_9 is
  signal i_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of i_in_meta : signal is "true";
  signal i_in_sync1 : STD_LOGIC;
  attribute async_reg of i_in_sync1 : signal is "true";
  signal i_in_sync2 : STD_LOGIC;
  attribute async_reg of i_in_sync2 : signal is "true";
  signal i_in_sync3 : STD_LOGIC;
  attribute async_reg of i_in_sync3 : signal is "true";
  signal \^rxresetdone_sync\ : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of i_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of i_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync1_reg : label is std.standard.true;
  attribute KEEP of i_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync2_reg : label is std.standard.true;
  attribute KEEP of i_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of i_in_sync3_reg : label is std.standard.true;
  attribute KEEP of i_in_sync3_reg : label is "yes";
begin
  rxresetdone_sync(0) <= \^rxresetdone_sync\(0);
i_in_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rxresetdone_out(0),
      Q => i_in_meta,
      R => '0'
    );
i_in_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync3,
      Q => \^rxresetdone_sync\(0),
      R => '0'
    );
i_in_sync1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_meta,
      Q => i_in_sync1,
      R => '0'
    );
i_in_sync2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync1,
      Q => i_in_sync2,
      R => '0'
    );
i_in_sync3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => i_in_sync2,
      Q => i_in_sync3,
      R => '0'
    );
sm_reset_rx_timer_clr_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \^rxresetdone_sync\(0),
      I1 => i_in_out_reg_0(1),
      I2 => i_in_out_reg_0(0),
      O => sm_reset_rx_timer_clr_reg
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gthe3_channel is
  port (
    rst_in_out_reg : out STD_LOGIC;
    cplllock_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    cpllfbclklost_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    cpllrefclklost_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    drprdy_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    eyescandataerror_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    gthtxn_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    gthtxp_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    gtpowergood_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    gtrefclkmonitor_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pcierategen3_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pcierateidle_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pciesynctxsyncdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pcieusergen3rdy_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pcieuserphystatusrst_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pcieuserratestart_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    phystatus_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    resetexception_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxbyteisaligned_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxbyterealign_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcdrlock_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcdrphdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxchanbondseq_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxchanisaligned_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxchanrealign_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcominitdet_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcommadet_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcomsasdet_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcomwakedet_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdlysresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxelecidle_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosintdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosintstarted_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosintstrobedone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosintstrobestarted_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxoutclk_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxoutclkfabric_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxoutclkpcs_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxphaligndone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxphalignerr_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxpmaresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxprbserr_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxprbslocked_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxprgdivresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxqpisenn_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxqpisenp_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxratedone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxrecclkout_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxsliderdy_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxslipdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxslipoutclkrdy_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxslippmardy_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxsyncdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxsyncout_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxvalid_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txcomfinish_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txdlysresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txoutclk_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txoutclkfabric_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txoutclkpcs_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txphaligndone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txphinitdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txpmaresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txprgdivresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txqpisenn_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txqpisenp_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txratedone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txsyncdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txsyncout_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pcsrsvdout_out : out STD_LOGIC_VECTOR ( 35 downto 0 );
    rxdata_out : out STD_LOGIC_VECTOR ( 383 downto 0 );
    drpdo_out : out STD_LOGIC_VECTOR ( 47 downto 0 );
    rxctrl0_out : out STD_LOGIC_VECTOR ( 47 downto 0 );
    rxctrl1_out : out STD_LOGIC_VECTOR ( 47 downto 0 );
    dmonitorout_out : out STD_LOGIC_VECTOR ( 50 downto 0 );
    pcierateqpllpd_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    pcierateqpllreset_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    rxclkcorcnt_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    rxdatavalid_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    rxheadervalid_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    rxstartofseq_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    txbufstatus_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    bufgtce_out : out STD_LOGIC_VECTOR ( 8 downto 0 );
    bufgtcemask_out : out STD_LOGIC_VECTOR ( 8 downto 0 );
    bufgtreset_out : out STD_LOGIC_VECTOR ( 8 downto 0 );
    bufgtrstmask_out : out STD_LOGIC_VECTOR ( 8 downto 0 );
    rxbufstatus_out : out STD_LOGIC_VECTOR ( 8 downto 0 );
    rxstatus_out : out STD_LOGIC_VECTOR ( 8 downto 0 );
    rxchbondo_out : out STD_LOGIC_VECTOR ( 14 downto 0 );
    rxheader_out : out STD_LOGIC_VECTOR ( 17 downto 0 );
    rxmonitorout_out : out STD_LOGIC_VECTOR ( 20 downto 0 );
    pinrsrvdas_out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    rxctrl2_out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    rxctrl3_out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    rxdataextendrsvd_out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    bufgtdiv_out : out STD_LOGIC_VECTOR ( 26 downto 0 );
    gtrxreset_out_reg : in STD_LOGIC_VECTOR ( 0 to 0 );
    cfgreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    clkrsvd0_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    clkrsvd1_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    cplllockdetclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    cplllocken_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_CPLLPD : in STD_LOGIC_VECTOR ( 0 to 0 );
    cpllreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    dmonfiforeset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    dmonitorclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    drpclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    drpen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    drpwe_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    evoddphicaldone_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    evoddphicalstart_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    evoddphidrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    evoddphidwren_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    evoddphixrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    evoddphixwren_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    eyescanmode_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    eyescanreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    eyescantrigger_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtgrefclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gthrxn_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gthrxp_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtnorthrefclk0_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtnorthrefclk1_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtrefclk0_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtrefclk1_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtresetsel_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_GTRXRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtsouthrefclk0_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtsouthrefclk1_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_GTTXRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    lpbkrxtxseren_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    lpbktxrxseren_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    pcieeqrxeqadaptdone_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    pcierstidle_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    pciersttxsyncstart_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    pcieuserratedone_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    qpll0clk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    qpll0refclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    qpll1clk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    qpll1refclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    resetovrd_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rstclkentx_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rx8b10ben_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxbufreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcdrfreqreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcdrhold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcdrovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcdrreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcdrresetrsv_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxchbonden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxchbondmaster_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxchbondslave_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcommadeten_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfeagchold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfeagcovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfelfhold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfelfovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfelpmreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap10hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap10ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap11hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap11ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap12hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap12ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap13hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap13ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap14hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap14ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap15hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap15ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap2hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap2ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap3hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap3ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap4hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap4ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap5hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap5ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap6hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap6ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap7hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap7ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap8hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap8ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap9hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap9ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfeuthold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfeutovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfevphold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfevpovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfevsen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfexyden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdlybypass_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdlyen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdlyovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdlysreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxgearboxslip_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlatclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmgchold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmgcovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmhfhold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmhfovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmlfhold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmlfklovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmoshold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmosovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxmcommaalignen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxoobreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxoscalreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxoshold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosinten_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosinthold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosintovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosintstrobe_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosinttestovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxpcommaalignen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxpcsreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxphalign_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxphalignen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxphdlypd_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxphdlyreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxphovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxpmareset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxpolarity_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxprbscntreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_RXPROGDIVRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxqpien_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxratemode_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxslide_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxslipoutclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxslippma_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxsyncallin_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxsyncin_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxsyncmode_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_RXUSERRDY : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxusrclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxusrclk2_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    sigvalidclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    tx8b10ben_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txcominit_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txcomsas_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txcomwake_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txdeemph_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txdetectrx_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txdiffpd_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_TXDLYSRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    txelecidle_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txinhibit_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txlatclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpcsreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpdelecidlemode_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpippmen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpippmovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpippmpd_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpippmsel_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpisopd_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpmareset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpolarity_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpostcursorinv_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txprbsforceerr_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txprecursorinv_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_TXPROGDIVRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    txqpibiasen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txqpistrongpdown_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txqpiweakpup_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txratemode_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txswing_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_TXSYNCALLIN : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtrxreset_out_reg_0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    GTHE3_CHANNEL_TXUSERRDY : in STD_LOGIC_VECTOR ( 0 to 0 );
    txusrclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txusrclk2_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtwiz_userdata_tx_in : in STD_LOGIC_VECTOR ( 95 downto 0 );
    drpdi_in : in STD_LOGIC_VECTOR ( 47 downto 0 );
    gtrsvd_in : in STD_LOGIC_VECTOR ( 47 downto 0 );
    pcsrsvdin_in : in STD_LOGIC_VECTOR ( 47 downto 0 );
    txctrl0_in : in STD_LOGIC_VECTOR ( 47 downto 0 );
    txctrl1_in : in STD_LOGIC_VECTOR ( 47 downto 0 );
    rxdfeagcctrl_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    rxelecidlemode_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    rxmonitorsel_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    rxpd_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    rxpllclksel_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    rxsysclksel_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    txpd_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    txpllclksel_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    txsysclksel_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    cpllrefclksel_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    loopback_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    rxchbondlevel_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    rxoutclksel_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    rxrate_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    txbufdiffctrl_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    txmargin_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    txoutclksel_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    txrate_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    rxosintcfg_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    rxprbssel_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    txdiffctrl_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    txprbssel_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pcsrsvdin2_in : in STD_LOGIC_VECTOR ( 14 downto 0 );
    pmarsvdin_in : in STD_LOGIC_VECTOR ( 14 downto 0 );
    rxchbondi_in : in STD_LOGIC_VECTOR ( 14 downto 0 );
    txpippmstepsize_in : in STD_LOGIC_VECTOR ( 14 downto 0 );
    txpostcursor_in : in STD_LOGIC_VECTOR ( 14 downto 0 );
    txprecursor_in : in STD_LOGIC_VECTOR ( 14 downto 0 );
    txheader_in : in STD_LOGIC_VECTOR ( 17 downto 0 );
    txmaincursor_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    txsequence_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    tx8b10bbypass_in : in STD_LOGIC_VECTOR ( 23 downto 0 );
    txctrl2_in : in STD_LOGIC_VECTOR ( 23 downto 0 );
    txdataextendrsvd_in : in STD_LOGIC_VECTOR ( 23 downto 0 );
    drpaddr_in : in STD_LOGIC_VECTOR ( 26 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gthe3_channel : entity is "gtwizard_ultrascale_v1_6_5_gthe3_channel";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gthe3_channel;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gthe3_channel is
  signal \^cplllock_out\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \gthe3_channel_gen.gen_gthe3_channel_inst[0].GTHE3_CHANNEL_PRIM_INST\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \gthe3_channel_gen.gen_gthe3_channel_inst[1].GTHE3_CHANNEL_PRIM_INST\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \gthe3_channel_gen.gen_gthe3_channel_inst[2].GTHE3_CHANNEL_PRIM_INST\ : label is "PRIMITIVE";
begin
  cplllock_out(2 downto 0) <= \^cplllock_out\(2 downto 0);
\gthe3_channel_gen.gen_gthe3_channel_inst[0].GTHE3_CHANNEL_PRIM_INST\: unisim.vcomponents.GTHE3_CHANNEL
    generic map(
      ACJTAG_DEBUG_MODE => '0',
      ACJTAG_MODE => '0',
      ACJTAG_RESET => '0',
      ADAPT_CFG0 => X"F800",
      ADAPT_CFG1 => X"0000",
      ALIGN_COMMA_DOUBLE => "FALSE",
      ALIGN_COMMA_ENABLE => B"1111111111",
      ALIGN_COMMA_WORD => 1,
      ALIGN_MCOMMA_DET => "TRUE",
      ALIGN_MCOMMA_VALUE => B"1010000011",
      ALIGN_PCOMMA_DET => "TRUE",
      ALIGN_PCOMMA_VALUE => B"0101111100",
      A_RXOSCALRESET => '0',
      A_RXPROGDIVRESET => '0',
      A_TXPROGDIVRESET => '0',
      CBCC_DATA_SOURCE_SEL => "DECODED",
      CDR_SWAP_MODE_EN => '0',
      CHAN_BOND_KEEP_ALIGN => "FALSE",
      CHAN_BOND_MAX_SKEW => 1,
      CHAN_BOND_SEQ_1_1 => B"0000000000",
      CHAN_BOND_SEQ_1_2 => B"0000000000",
      CHAN_BOND_SEQ_1_3 => B"0000000000",
      CHAN_BOND_SEQ_1_4 => B"0000000000",
      CHAN_BOND_SEQ_1_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_1 => B"0000000000",
      CHAN_BOND_SEQ_2_2 => B"0000000000",
      CHAN_BOND_SEQ_2_3 => B"0000000000",
      CHAN_BOND_SEQ_2_4 => B"0000000000",
      CHAN_BOND_SEQ_2_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_USE => "FALSE",
      CHAN_BOND_SEQ_LEN => 1,
      CLK_CORRECT_USE => "FALSE",
      CLK_COR_KEEP_IDLE => "FALSE",
      CLK_COR_MAX_LAT => 12,
      CLK_COR_MIN_LAT => 8,
      CLK_COR_PRECEDENCE => "TRUE",
      CLK_COR_REPEAT_WAIT => 0,
      CLK_COR_SEQ_1_1 => B"0100000000",
      CLK_COR_SEQ_1_2 => B"0100000000",
      CLK_COR_SEQ_1_3 => B"0100000000",
      CLK_COR_SEQ_1_4 => B"0100000000",
      CLK_COR_SEQ_1_ENABLE => B"1111",
      CLK_COR_SEQ_2_1 => B"0100000000",
      CLK_COR_SEQ_2_2 => B"0100000000",
      CLK_COR_SEQ_2_3 => B"0100000000",
      CLK_COR_SEQ_2_4 => B"0100000000",
      CLK_COR_SEQ_2_ENABLE => B"1111",
      CLK_COR_SEQ_2_USE => "FALSE",
      CLK_COR_SEQ_LEN => 1,
      CPLL_CFG0 => X"23FC",
      CPLL_CFG1 => X"A4AC",
      CPLL_CFG2 => X"0004",
      CPLL_CFG3 => B"00" & X"0",
      CPLL_FBDIV => 5,
      CPLL_FBDIV_45 => 4,
      CPLL_INIT_CFG0 => X"02B2",
      CPLL_INIT_CFG1 => X"00",
      CPLL_LOCK_CFG => X"01E8",
      CPLL_REFCLK_DIV => 1,
      DDI_CTRL => B"00",
      DDI_REALIGN_WAIT => 15,
      DEC_MCOMMA_DETECT => "TRUE",
      DEC_PCOMMA_DETECT => "TRUE",
      DEC_VALID_COMMA_ONLY => "FALSE",
      DFE_D_X_REL_POS => '0',
      DFE_VCM_COMP_EN => '0',
      DMONITOR_CFG0 => B"00" & X"00",
      DMONITOR_CFG1 => X"00",
      ES_CLK_PHASE_SEL => '0',
      ES_CONTROL => B"000000",
      ES_ERRDET_EN => "FALSE",
      ES_EYE_SCAN_EN => "FALSE",
      ES_HORZ_OFFSET => X"000",
      ES_PMA_CFG => B"0000000000",
      ES_PRESCALE => B"00000",
      ES_QUALIFIER0 => X"0000",
      ES_QUALIFIER1 => X"0000",
      ES_QUALIFIER2 => X"0000",
      ES_QUALIFIER3 => X"0000",
      ES_QUALIFIER4 => X"0000",
      ES_QUAL_MASK0 => X"0000",
      ES_QUAL_MASK1 => X"0000",
      ES_QUAL_MASK2 => X"0000",
      ES_QUAL_MASK3 => X"0000",
      ES_QUAL_MASK4 => X"0000",
      ES_SDATA_MASK0 => X"0000",
      ES_SDATA_MASK1 => X"0000",
      ES_SDATA_MASK2 => X"0000",
      ES_SDATA_MASK3 => X"0000",
      ES_SDATA_MASK4 => X"0000",
      EVODD_PHI_CFG => B"00000000000",
      EYE_SCAN_SWAP_EN => '0',
      FTS_DESKEW_SEQ_ENABLE => B"1111",
      FTS_LANE_DESKEW_CFG => B"1111",
      FTS_LANE_DESKEW_EN => "FALSE",
      GEARBOX_MODE => B"00000",
      GM_BIAS_SELECT => '0',
      LOCAL_MASTER => '1',
      OOBDIVCTL => B"00",
      OOB_PWRUP => '0',
      PCI3_AUTO_REALIGN => "OVR_1K_BLK",
      PCI3_PIPE_RX_ELECIDLE => '0',
      PCI3_RX_ASYNC_EBUF_BYPASS => B"00",
      PCI3_RX_ELECIDLE_EI2_ENABLE => '0',
      PCI3_RX_ELECIDLE_H2L_COUNT => B"000000",
      PCI3_RX_ELECIDLE_H2L_DISABLE => B"000",
      PCI3_RX_ELECIDLE_HI_COUNT => B"000000",
      PCI3_RX_ELECIDLE_LP4_DISABLE => '0',
      PCI3_RX_FIFO_DISABLE => '0',
      PCIE_BUFG_DIV_CTRL => X"1000",
      PCIE_RXPCS_CFG_GEN3 => X"02A4",
      PCIE_RXPMA_CFG => X"000A",
      PCIE_TXPCS_CFG_GEN3 => X"2CA4",
      PCIE_TXPMA_CFG => X"000A",
      PCS_PCIE_EN => "FALSE",
      PCS_RSVD0 => B"0000000000000000",
      PCS_RSVD1 => B"000",
      PD_TRANS_TIME_FROM_P2 => X"03C",
      PD_TRANS_TIME_NONE_P2 => X"19",
      PD_TRANS_TIME_TO_P2 => X"64",
      PLL_SEL_MODE_GEN12 => B"11",
      PLL_SEL_MODE_GEN3 => B"11",
      PMA_RSV1 => X"E000",
      PROCESS_PAR => B"010",
      RATE_SW_USE_DRP => '1',
      RESET_POWERSAVE_DISABLE => '0',
      RXBUFRESET_TIME => B"00011",
      RXBUF_ADDR_MODE => "FAST",
      RXBUF_EIDLE_HI_CNT => B"1000",
      RXBUF_EIDLE_LO_CNT => B"0000",
      RXBUF_EN => "TRUE",
      RXBUF_RESET_ON_CB_CHANGE => "TRUE",
      RXBUF_RESET_ON_COMMAALIGN => "TRUE",
      RXBUF_RESET_ON_EIDLE => "FALSE",
      RXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      RXBUF_THRESH_OVFLW => 57,
      RXBUF_THRESH_OVRD => "TRUE",
      RXBUF_THRESH_UNDFLW => 3,
      RXCDRFREQRESET_TIME => B"00001",
      RXCDRPHRESET_TIME => B"00001",
      RXCDR_CFG0 => X"0000",
      RXCDR_CFG0_GEN3 => X"0000",
      RXCDR_CFG1 => X"0000",
      RXCDR_CFG1_GEN3 => X"0000",
      RXCDR_CFG2 => X"0766",
      RXCDR_CFG2_GEN3 => X"07E6",
      RXCDR_CFG3 => X"0000",
      RXCDR_CFG3_GEN3 => X"0000",
      RXCDR_CFG4 => X"0000",
      RXCDR_CFG4_GEN3 => X"0000",
      RXCDR_CFG5 => X"0000",
      RXCDR_CFG5_GEN3 => X"0000",
      RXCDR_FR_RESET_ON_EIDLE => '0',
      RXCDR_HOLD_DURING_EIDLE => '0',
      RXCDR_LOCK_CFG0 => X"4480",
      RXCDR_LOCK_CFG1 => X"5FFF",
      RXCDR_LOCK_CFG2 => X"77C3",
      RXCDR_PH_RESET_ON_EIDLE => '0',
      RXCFOK_CFG0 => X"4000",
      RXCFOK_CFG1 => X"0065",
      RXCFOK_CFG2 => X"002E",
      RXDFELPMRESET_TIME => B"0001111",
      RXDFELPM_KL_CFG0 => X"0000",
      RXDFELPM_KL_CFG1 => X"0032",
      RXDFELPM_KL_CFG2 => X"0000",
      RXDFE_CFG0 => X"0A00",
      RXDFE_CFG1 => X"0000",
      RXDFE_GC_CFG0 => X"0000",
      RXDFE_GC_CFG1 => X"7860",
      RXDFE_GC_CFG2 => X"0000",
      RXDFE_H2_CFG0 => X"0000",
      RXDFE_H2_CFG1 => X"0000",
      RXDFE_H3_CFG0 => X"4000",
      RXDFE_H3_CFG1 => X"0000",
      RXDFE_H4_CFG0 => X"2000",
      RXDFE_H4_CFG1 => X"0003",
      RXDFE_H5_CFG0 => X"2000",
      RXDFE_H5_CFG1 => X"0003",
      RXDFE_H6_CFG0 => X"2000",
      RXDFE_H6_CFG1 => X"0000",
      RXDFE_H7_CFG0 => X"2000",
      RXDFE_H7_CFG1 => X"0000",
      RXDFE_H8_CFG0 => X"2000",
      RXDFE_H8_CFG1 => X"0000",
      RXDFE_H9_CFG0 => X"2000",
      RXDFE_H9_CFG1 => X"0000",
      RXDFE_HA_CFG0 => X"2000",
      RXDFE_HA_CFG1 => X"0000",
      RXDFE_HB_CFG0 => X"2000",
      RXDFE_HB_CFG1 => X"0000",
      RXDFE_HC_CFG0 => X"0000",
      RXDFE_HC_CFG1 => X"0000",
      RXDFE_HD_CFG0 => X"0000",
      RXDFE_HD_CFG1 => X"0000",
      RXDFE_HE_CFG0 => X"0000",
      RXDFE_HE_CFG1 => X"0000",
      RXDFE_HF_CFG0 => X"0000",
      RXDFE_HF_CFG1 => X"0000",
      RXDFE_OS_CFG0 => X"8000",
      RXDFE_OS_CFG1 => X"0000",
      RXDFE_UT_CFG0 => X"8000",
      RXDFE_UT_CFG1 => X"0003",
      RXDFE_VP_CFG0 => X"AA00",
      RXDFE_VP_CFG1 => X"0033",
      RXDLY_CFG => X"001F",
      RXDLY_LCFG => X"0030",
      RXELECIDLE_CFG => "Sigcfg_4",
      RXGBOX_FIFO_INIT_RD_ADDR => 4,
      RXGEARBOX_EN => "FALSE",
      RXISCANRESET_TIME => B"00001",
      RXLPM_CFG => X"0000",
      RXLPM_GC_CFG => X"1000",
      RXLPM_KH_CFG0 => X"0000",
      RXLPM_KH_CFG1 => X"0002",
      RXLPM_OS_CFG0 => X"8000",
      RXLPM_OS_CFG1 => X"0002",
      RXOOB_CFG => B"000000110",
      RXOOB_CLK_CFG => "PMA",
      RXOSCALRESET_TIME => B"00011",
      RXOUT_DIV => 1,
      RXPCSRESET_TIME => B"00011",
      RXPHBEACON_CFG => X"0000",
      RXPHDLY_CFG => X"2020",
      RXPHSAMP_CFG => X"2100",
      RXPHSLIP_CFG => X"6622",
      RXPH_MONITOR_SEL => B"00000",
      RXPI_CFG0 => B"01",
      RXPI_CFG1 => B"01",
      RXPI_CFG2 => B"01",
      RXPI_CFG3 => B"01",
      RXPI_CFG4 => '0',
      RXPI_CFG5 => '0',
      RXPI_CFG6 => B"000",
      RXPI_LPM => '0',
      RXPI_VREFSEL => '0',
      RXPMACLK_SEL => "DATA",
      RXPMARESET_TIME => B"00011",
      RXPRBS_ERR_LOOPBACK => '0',
      RXPRBS_LINKACQ_CNT => 15,
      RXSLIDE_AUTO_WAIT => 7,
      RXSLIDE_MODE => "OFF",
      RXSYNC_MULTILANE => '1',
      RXSYNC_OVRD => '0',
      RXSYNC_SKIP_DA => '0',
      RX_AFE_CM_EN => '0',
      RX_BIAS_CFG0 => X"0AB4",
      RX_BUFFER_CFG => B"000000",
      RX_CAPFF_SARC_ENB => '0',
      RX_CLK25_DIV => 13,
      RX_CLKMUX_EN => '1',
      RX_CLK_SLIP_OVRD => B"00000",
      RX_CM_BUF_CFG => B"1010",
      RX_CM_BUF_PD => '0',
      RX_CM_SEL => B"11",
      RX_CM_TRIM => B"1010",
      RX_CTLE3_LPF => B"00000001",
      RX_DATA_WIDTH => 40,
      RX_DDI_SEL => B"000000",
      RX_DEFER_RESET_BUF_EN => "TRUE",
      RX_DFELPM_CFG0 => B"0110",
      RX_DFELPM_CFG1 => '1',
      RX_DFELPM_KLKH_AGC_STUP_EN => '1',
      RX_DFE_AGC_CFG0 => B"10",
      RX_DFE_AGC_CFG1 => B"000",
      RX_DFE_KL_LPM_KH_CFG0 => B"01",
      RX_DFE_KL_LPM_KH_CFG1 => B"000",
      RX_DFE_KL_LPM_KL_CFG0 => B"01",
      RX_DFE_KL_LPM_KL_CFG1 => B"000",
      RX_DFE_LPM_HOLD_DURING_EIDLE => '0',
      RX_DISPERR_SEQ_MATCH => "TRUE",
      RX_DIVRESET_TIME => B"00001",
      RX_EN_HI_LR => '1',
      RX_EYESCAN_VS_CODE => B"0000000",
      RX_EYESCAN_VS_NEG_DIR => '0',
      RX_EYESCAN_VS_RANGE => B"00",
      RX_EYESCAN_VS_UT_SIGN => '0',
      RX_FABINT_USRCLK_FLOP => '0',
      RX_INT_DATAWIDTH => 1,
      RX_PMA_POWER_SAVE => '0',
      RX_PROGDIV_CFG => 0.000000,
      RX_SAMPLE_PERIOD => B"111",
      RX_SIG_VALID_DLY => 11,
      RX_SUM_DFETAPREP_EN => '0',
      RX_SUM_IREF_TUNE => B"1100",
      RX_SUM_RES_CTRL => B"11",
      RX_SUM_VCMTUNE => B"0000",
      RX_SUM_VCM_OVWR => '0',
      RX_SUM_VREF_TUNE => B"000",
      RX_TUNE_AFE_OS => B"10",
      RX_WIDEMODE_CDR => '1',
      RX_XCLK_SEL => "RXDES",
      SAS_MAX_COM => 64,
      SAS_MIN_COM => 36,
      SATA_BURST_SEQ_LEN => B"1110",
      SATA_BURST_VAL => B"100",
      SATA_CPLL_CFG => "VCO_3000MHZ",
      SATA_EIDLE_VAL => B"100",
      SATA_MAX_BURST => 8,
      SATA_MAX_INIT => 21,
      SATA_MAX_WAKE => 7,
      SATA_MIN_BURST => 4,
      SATA_MIN_INIT => 12,
      SATA_MIN_WAKE => 4,
      SHOW_REALIGN_COMMA => "FALSE",
      SIM_MODE => "FAST",
      SIM_RECEIVER_DETECT_PASS => "TRUE",
      SIM_RESET_SPEEDUP => "TRUE",
      SIM_TX_EIDLE_DRIVE_LEVEL => '0',
      SIM_VERSION => 2,
      TAPDLY_SET_TX => B"00",
      TEMPERATUR_PAR => B"0010",
      TERM_RCAL_CFG => B"100001000010000",
      TERM_RCAL_OVRD => B"000",
      TRANS_TIME_RATE => X"0E",
      TST_RSV0 => X"00",
      TST_RSV1 => X"00",
      TXBUF_EN => "FALSE",
      TXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      TXDLY_CFG => X"0009",
      TXDLY_LCFG => X"0050",
      TXDRVBIAS_N => B"1010",
      TXDRVBIAS_P => B"1010",
      TXFIFO_ADDR_CFG => "LOW",
      TXGBOX_FIFO_INIT_RD_ADDR => 4,
      TXGEARBOX_EN => "FALSE",
      TXOUT_DIV => 1,
      TXPCSRESET_TIME => B"00011",
      TXPHDLY_CFG0 => X"2020",
      TXPHDLY_CFG1 => X"0075",
      TXPH_CFG => X"0980",
      TXPH_MONITOR_SEL => B"00000",
      TXPI_CFG0 => B"01",
      TXPI_CFG1 => B"01",
      TXPI_CFG2 => B"01",
      TXPI_CFG3 => '0',
      TXPI_CFG4 => '0',
      TXPI_CFG5 => B"000",
      TXPI_GRAY_SEL => '0',
      TXPI_INVSTROBE_SEL => '0',
      TXPI_LPM => '0',
      TXPI_PPMCLK_SEL => "TXUSRCLK2",
      TXPI_PPM_CFG => B"00000000",
      TXPI_SYNFREQ_PPM => B"001",
      TXPI_VREFSEL => '0',
      TXPMARESET_TIME => B"00011",
      TXSYNC_MULTILANE => '1',
      TXSYNC_OVRD => '0',
      TXSYNC_SKIP_DA => '0',
      TX_CLK25_DIV => 13,
      TX_CLKMUX_EN => '1',
      TX_DATA_WIDTH => 40,
      TX_DCD_CFG => B"000010",
      TX_DCD_EN => '0',
      TX_DEEMPH0 => B"000000",
      TX_DEEMPH1 => B"000000",
      TX_DIVRESET_TIME => B"00001",
      TX_DRIVE_MODE => "DIRECT",
      TX_EIDLE_ASSERT_DELAY => B"100",
      TX_EIDLE_DEASSERT_DELAY => B"011",
      TX_EML_PHI_TUNE => '0',
      TX_FABINT_USRCLK_FLOP => '0',
      TX_IDLE_DATA_ZERO => '0',
      TX_INT_DATAWIDTH => 1,
      TX_LOOPBACK_DRIVE_HIZ => "FALSE",
      TX_MAINCURSOR_SEL => '0',
      TX_MARGIN_FULL_0 => B"1001111",
      TX_MARGIN_FULL_1 => B"1001110",
      TX_MARGIN_FULL_2 => B"1001100",
      TX_MARGIN_FULL_3 => B"1001010",
      TX_MARGIN_FULL_4 => B"1001000",
      TX_MARGIN_LOW_0 => B"1000110",
      TX_MARGIN_LOW_1 => B"1000101",
      TX_MARGIN_LOW_2 => B"1000011",
      TX_MARGIN_LOW_3 => B"1000010",
      TX_MARGIN_LOW_4 => B"1000000",
      TX_MODE_SEL => B"000",
      TX_PMADATA_OPT => '0',
      TX_PMA_POWER_SAVE => '0',
      TX_PROGCLK_SEL => "PREPI",
      TX_PROGDIV_CFG => 20.000000,
      TX_QPI_STATUS_EN => '0',
      TX_RXDETECT_CFG => B"00" & X"032",
      TX_RXDETECT_REF => B"100",
      TX_SAMPLE_PERIOD => B"111",
      TX_SARC_LPBK_ENB => '0',
      TX_XCLK_SEL => "TXUSR",
      USE_PCS_CLK_PHASE_SEL => '0',
      WB_MODE => B"00"
    )
        port map (
      BUFGTCE(2 downto 0) => bufgtce_out(2 downto 0),
      BUFGTCEMASK(2 downto 0) => bufgtcemask_out(2 downto 0),
      BUFGTDIV(8 downto 0) => bufgtdiv_out(8 downto 0),
      BUFGTRESET(2 downto 0) => bufgtreset_out(2 downto 0),
      BUFGTRSTMASK(2 downto 0) => bufgtrstmask_out(2 downto 0),
      CFGRESET => cfgreset_in(0),
      CLKRSVD0 => clkrsvd0_in(0),
      CLKRSVD1 => clkrsvd1_in(0),
      CPLLFBCLKLOST => cpllfbclklost_out(0),
      CPLLLOCK => \^cplllock_out\(0),
      CPLLLOCKDETCLK => cplllockdetclk_in(0),
      CPLLLOCKEN => cplllocken_in(0),
      CPLLPD => GTHE3_CHANNEL_CPLLPD(0),
      CPLLREFCLKLOST => cpllrefclklost_out(0),
      CPLLREFCLKSEL(2 downto 0) => cpllrefclksel_in(2 downto 0),
      CPLLRESET => cpllreset_in(0),
      DMONFIFORESET => dmonfiforeset_in(0),
      DMONITORCLK => dmonitorclk_in(0),
      DMONITOROUT(16 downto 0) => dmonitorout_out(16 downto 0),
      DRPADDR(8 downto 0) => drpaddr_in(8 downto 0),
      DRPCLK => drpclk_in(0),
      DRPDI(15 downto 0) => drpdi_in(15 downto 0),
      DRPDO(15 downto 0) => drpdo_out(15 downto 0),
      DRPEN => drpen_in(0),
      DRPRDY => drprdy_out(0),
      DRPWE => drpwe_in(0),
      EVODDPHICALDONE => evoddphicaldone_in(0),
      EVODDPHICALSTART => evoddphicalstart_in(0),
      EVODDPHIDRDEN => evoddphidrden_in(0),
      EVODDPHIDWREN => evoddphidwren_in(0),
      EVODDPHIXRDEN => evoddphixrden_in(0),
      EVODDPHIXWREN => evoddphixwren_in(0),
      EYESCANDATAERROR => eyescandataerror_out(0),
      EYESCANMODE => eyescanmode_in(0),
      EYESCANRESET => eyescanreset_in(0),
      EYESCANTRIGGER => eyescantrigger_in(0),
      GTGREFCLK => gtgrefclk_in(0),
      GTHRXN => gthrxn_in(0),
      GTHRXP => gthrxp_in(0),
      GTHTXN => gthtxn_out(0),
      GTHTXP => gthtxp_out(0),
      GTNORTHREFCLK0 => gtnorthrefclk0_in(0),
      GTNORTHREFCLK1 => gtnorthrefclk1_in(0),
      GTPOWERGOOD => gtpowergood_out(0),
      GTREFCLK0 => gtrefclk0_in(0),
      GTREFCLK1 => gtrefclk1_in(0),
      GTREFCLKMONITOR => gtrefclkmonitor_out(0),
      GTRESETSEL => gtresetsel_in(0),
      GTRSVD(15 downto 0) => gtrsvd_in(15 downto 0),
      GTRXRESET => GTHE3_CHANNEL_GTRXRESET(0),
      GTSOUTHREFCLK0 => gtsouthrefclk0_in(0),
      GTSOUTHREFCLK1 => gtsouthrefclk1_in(0),
      GTTXRESET => GTHE3_CHANNEL_GTTXRESET(0),
      LOOPBACK(2 downto 0) => loopback_in(2 downto 0),
      LPBKRXTXSEREN => lpbkrxtxseren_in(0),
      LPBKTXRXSEREN => lpbktxrxseren_in(0),
      PCIEEQRXEQADAPTDONE => pcieeqrxeqadaptdone_in(0),
      PCIERATEGEN3 => pcierategen3_out(0),
      PCIERATEIDLE => pcierateidle_out(0),
      PCIERATEQPLLPD(1 downto 0) => pcierateqpllpd_out(1 downto 0),
      PCIERATEQPLLRESET(1 downto 0) => pcierateqpllreset_out(1 downto 0),
      PCIERSTIDLE => pcierstidle_in(0),
      PCIERSTTXSYNCSTART => pciersttxsyncstart_in(0),
      PCIESYNCTXSYNCDONE => pciesynctxsyncdone_out(0),
      PCIEUSERGEN3RDY => pcieusergen3rdy_out(0),
      PCIEUSERPHYSTATUSRST => pcieuserphystatusrst_out(0),
      PCIEUSERRATEDONE => pcieuserratedone_in(0),
      PCIEUSERRATESTART => pcieuserratestart_out(0),
      PCSRSVDIN(15 downto 0) => pcsrsvdin_in(15 downto 0),
      PCSRSVDIN2(4 downto 0) => pcsrsvdin2_in(4 downto 0),
      PCSRSVDOUT(11 downto 0) => pcsrsvdout_out(11 downto 0),
      PHYSTATUS => phystatus_out(0),
      PINRSRVDAS(7 downto 0) => pinrsrvdas_out(7 downto 0),
      PMARSVDIN(4 downto 0) => pmarsvdin_in(4 downto 0),
      QPLL0CLK => qpll0clk_in(0),
      QPLL0REFCLK => qpll0refclk_in(0),
      QPLL1CLK => qpll1clk_in(0),
      QPLL1REFCLK => qpll1refclk_in(0),
      RESETEXCEPTION => resetexception_out(0),
      RESETOVRD => resetovrd_in(0),
      RSTCLKENTX => rstclkentx_in(0),
      RX8B10BEN => rx8b10ben_in(0),
      RXBUFRESET => rxbufreset_in(0),
      RXBUFSTATUS(2 downto 0) => rxbufstatus_out(2 downto 0),
      RXBYTEISALIGNED => rxbyteisaligned_out(0),
      RXBYTEREALIGN => rxbyterealign_out(0),
      RXCDRFREQRESET => rxcdrfreqreset_in(0),
      RXCDRHOLD => rxcdrhold_in(0),
      RXCDRLOCK => rxcdrlock_out(0),
      RXCDROVRDEN => rxcdrovrden_in(0),
      RXCDRPHDONE => rxcdrphdone_out(0),
      RXCDRRESET => rxcdrreset_in(0),
      RXCDRRESETRSV => rxcdrresetrsv_in(0),
      RXCHANBONDSEQ => rxchanbondseq_out(0),
      RXCHANISALIGNED => rxchanisaligned_out(0),
      RXCHANREALIGN => rxchanrealign_out(0),
      RXCHBONDEN => rxchbonden_in(0),
      RXCHBONDI(4 downto 0) => rxchbondi_in(4 downto 0),
      RXCHBONDLEVEL(2 downto 0) => rxchbondlevel_in(2 downto 0),
      RXCHBONDMASTER => rxchbondmaster_in(0),
      RXCHBONDO(4 downto 0) => rxchbondo_out(4 downto 0),
      RXCHBONDSLAVE => rxchbondslave_in(0),
      RXCLKCORCNT(1 downto 0) => rxclkcorcnt_out(1 downto 0),
      RXCOMINITDET => rxcominitdet_out(0),
      RXCOMMADET => rxcommadet_out(0),
      RXCOMMADETEN => rxcommadeten_in(0),
      RXCOMSASDET => rxcomsasdet_out(0),
      RXCOMWAKEDET => rxcomwakedet_out(0),
      RXCTRL0(15 downto 0) => rxctrl0_out(15 downto 0),
      RXCTRL1(15 downto 0) => rxctrl1_out(15 downto 0),
      RXCTRL2(7 downto 0) => rxctrl2_out(7 downto 0),
      RXCTRL3(7 downto 0) => rxctrl3_out(7 downto 0),
      RXDATA(127 downto 0) => rxdata_out(127 downto 0),
      RXDATAEXTENDRSVD(7 downto 0) => rxdataextendrsvd_out(7 downto 0),
      RXDATAVALID(1 downto 0) => rxdatavalid_out(1 downto 0),
      RXDFEAGCCTRL(1 downto 0) => rxdfeagcctrl_in(1 downto 0),
      RXDFEAGCHOLD => rxdfeagchold_in(0),
      RXDFEAGCOVRDEN => rxdfeagcovrden_in(0),
      RXDFELFHOLD => rxdfelfhold_in(0),
      RXDFELFOVRDEN => rxdfelfovrden_in(0),
      RXDFELPMRESET => rxdfelpmreset_in(0),
      RXDFETAP10HOLD => rxdfetap10hold_in(0),
      RXDFETAP10OVRDEN => rxdfetap10ovrden_in(0),
      RXDFETAP11HOLD => rxdfetap11hold_in(0),
      RXDFETAP11OVRDEN => rxdfetap11ovrden_in(0),
      RXDFETAP12HOLD => rxdfetap12hold_in(0),
      RXDFETAP12OVRDEN => rxdfetap12ovrden_in(0),
      RXDFETAP13HOLD => rxdfetap13hold_in(0),
      RXDFETAP13OVRDEN => rxdfetap13ovrden_in(0),
      RXDFETAP14HOLD => rxdfetap14hold_in(0),
      RXDFETAP14OVRDEN => rxdfetap14ovrden_in(0),
      RXDFETAP15HOLD => rxdfetap15hold_in(0),
      RXDFETAP15OVRDEN => rxdfetap15ovrden_in(0),
      RXDFETAP2HOLD => rxdfetap2hold_in(0),
      RXDFETAP2OVRDEN => rxdfetap2ovrden_in(0),
      RXDFETAP3HOLD => rxdfetap3hold_in(0),
      RXDFETAP3OVRDEN => rxdfetap3ovrden_in(0),
      RXDFETAP4HOLD => rxdfetap4hold_in(0),
      RXDFETAP4OVRDEN => rxdfetap4ovrden_in(0),
      RXDFETAP5HOLD => rxdfetap5hold_in(0),
      RXDFETAP5OVRDEN => rxdfetap5ovrden_in(0),
      RXDFETAP6HOLD => rxdfetap6hold_in(0),
      RXDFETAP6OVRDEN => rxdfetap6ovrden_in(0),
      RXDFETAP7HOLD => rxdfetap7hold_in(0),
      RXDFETAP7OVRDEN => rxdfetap7ovrden_in(0),
      RXDFETAP8HOLD => rxdfetap8hold_in(0),
      RXDFETAP8OVRDEN => rxdfetap8ovrden_in(0),
      RXDFETAP9HOLD => rxdfetap9hold_in(0),
      RXDFETAP9OVRDEN => rxdfetap9ovrden_in(0),
      RXDFEUTHOLD => rxdfeuthold_in(0),
      RXDFEUTOVRDEN => rxdfeutovrden_in(0),
      RXDFEVPHOLD => rxdfevphold_in(0),
      RXDFEVPOVRDEN => rxdfevpovrden_in(0),
      RXDFEVSEN => rxdfevsen_in(0),
      RXDFEXYDEN => rxdfexyden_in(0),
      RXDLYBYPASS => rxdlybypass_in(0),
      RXDLYEN => rxdlyen_in(0),
      RXDLYOVRDEN => rxdlyovrden_in(0),
      RXDLYSRESET => rxdlysreset_in(0),
      RXDLYSRESETDONE => rxdlysresetdone_out(0),
      RXELECIDLE => rxelecidle_out(0),
      RXELECIDLEMODE(1 downto 0) => rxelecidlemode_in(1 downto 0),
      RXGEARBOXSLIP => rxgearboxslip_in(0),
      RXHEADER(5 downto 0) => rxheader_out(5 downto 0),
      RXHEADERVALID(1 downto 0) => rxheadervalid_out(1 downto 0),
      RXLATCLK => rxlatclk_in(0),
      RXLPMEN => rxlpmen_in(0),
      RXLPMGCHOLD => rxlpmgchold_in(0),
      RXLPMGCOVRDEN => rxlpmgcovrden_in(0),
      RXLPMHFHOLD => rxlpmhfhold_in(0),
      RXLPMHFOVRDEN => rxlpmhfovrden_in(0),
      RXLPMLFHOLD => rxlpmlfhold_in(0),
      RXLPMLFKLOVRDEN => rxlpmlfklovrden_in(0),
      RXLPMOSHOLD => rxlpmoshold_in(0),
      RXLPMOSOVRDEN => rxlpmosovrden_in(0),
      RXMCOMMAALIGNEN => rxmcommaalignen_in(0),
      RXMONITOROUT(6 downto 0) => rxmonitorout_out(6 downto 0),
      RXMONITORSEL(1 downto 0) => rxmonitorsel_in(1 downto 0),
      RXOOBRESET => rxoobreset_in(0),
      RXOSCALRESET => rxoscalreset_in(0),
      RXOSHOLD => rxoshold_in(0),
      RXOSINTCFG(3 downto 0) => rxosintcfg_in(3 downto 0),
      RXOSINTDONE => rxosintdone_out(0),
      RXOSINTEN => rxosinten_in(0),
      RXOSINTHOLD => rxosinthold_in(0),
      RXOSINTOVRDEN => rxosintovrden_in(0),
      RXOSINTSTARTED => rxosintstarted_out(0),
      RXOSINTSTROBE => rxosintstrobe_in(0),
      RXOSINTSTROBEDONE => rxosintstrobedone_out(0),
      RXOSINTSTROBESTARTED => rxosintstrobestarted_out(0),
      RXOSINTTESTOVRDEN => rxosinttestovrden_in(0),
      RXOSOVRDEN => rxosovrden_in(0),
      RXOUTCLK => rxoutclk_out(0),
      RXOUTCLKFABRIC => rxoutclkfabric_out(0),
      RXOUTCLKPCS => rxoutclkpcs_out(0),
      RXOUTCLKSEL(2 downto 0) => rxoutclksel_in(2 downto 0),
      RXPCOMMAALIGNEN => rxpcommaalignen_in(0),
      RXPCSRESET => rxpcsreset_in(0),
      RXPD(1 downto 0) => rxpd_in(1 downto 0),
      RXPHALIGN => rxphalign_in(0),
      RXPHALIGNDONE => rxphaligndone_out(0),
      RXPHALIGNEN => rxphalignen_in(0),
      RXPHALIGNERR => rxphalignerr_out(0),
      RXPHDLYPD => rxphdlypd_in(0),
      RXPHDLYRESET => rxphdlyreset_in(0),
      RXPHOVRDEN => rxphovrden_in(0),
      RXPLLCLKSEL(1 downto 0) => rxpllclksel_in(1 downto 0),
      RXPMARESET => rxpmareset_in(0),
      RXPMARESETDONE => rxpmaresetdone_out(0),
      RXPOLARITY => rxpolarity_in(0),
      RXPRBSCNTRESET => rxprbscntreset_in(0),
      RXPRBSERR => rxprbserr_out(0),
      RXPRBSLOCKED => rxprbslocked_out(0),
      RXPRBSSEL(3 downto 0) => rxprbssel_in(3 downto 0),
      RXPRGDIVRESETDONE => rxprgdivresetdone_out(0),
      RXPROGDIVRESET => GTHE3_CHANNEL_RXPROGDIVRESET(0),
      RXQPIEN => rxqpien_in(0),
      RXQPISENN => rxqpisenn_out(0),
      RXQPISENP => rxqpisenp_out(0),
      RXRATE(2 downto 0) => rxrate_in(2 downto 0),
      RXRATEDONE => rxratedone_out(0),
      RXRATEMODE => rxratemode_in(0),
      RXRECCLKOUT => rxrecclkout_out(0),
      RXRESETDONE => rxresetdone_out(0),
      RXSLIDE => rxslide_in(0),
      RXSLIDERDY => rxsliderdy_out(0),
      RXSLIPDONE => rxslipdone_out(0),
      RXSLIPOUTCLK => rxslipoutclk_in(0),
      RXSLIPOUTCLKRDY => rxslipoutclkrdy_out(0),
      RXSLIPPMA => rxslippma_in(0),
      RXSLIPPMARDY => rxslippmardy_out(0),
      RXSTARTOFSEQ(1 downto 0) => rxstartofseq_out(1 downto 0),
      RXSTATUS(2 downto 0) => rxstatus_out(2 downto 0),
      RXSYNCALLIN => rxsyncallin_in(0),
      RXSYNCDONE => rxsyncdone_out(0),
      RXSYNCIN => rxsyncin_in(0),
      RXSYNCMODE => rxsyncmode_in(0),
      RXSYNCOUT => rxsyncout_out(0),
      RXSYSCLKSEL(1 downto 0) => rxsysclksel_in(1 downto 0),
      RXUSERRDY => GTHE3_CHANNEL_RXUSERRDY(0),
      RXUSRCLK => rxusrclk_in(0),
      RXUSRCLK2 => rxusrclk2_in(0),
      RXVALID => rxvalid_out(0),
      SIGVALIDCLK => sigvalidclk_in(0),
      TSTIN(19 downto 0) => B"00000000000000000000",
      TX8B10BBYPASS(7 downto 0) => tx8b10bbypass_in(7 downto 0),
      TX8B10BEN => tx8b10ben_in(0),
      TXBUFDIFFCTRL(2 downto 0) => txbufdiffctrl_in(2 downto 0),
      TXBUFSTATUS(1 downto 0) => txbufstatus_out(1 downto 0),
      TXCOMFINISH => txcomfinish_out(0),
      TXCOMINIT => txcominit_in(0),
      TXCOMSAS => txcomsas_in(0),
      TXCOMWAKE => txcomwake_in(0),
      TXCTRL0(15 downto 0) => txctrl0_in(15 downto 0),
      TXCTRL1(15 downto 0) => txctrl1_in(15 downto 0),
      TXCTRL2(7 downto 0) => txctrl2_in(7 downto 0),
      TXDATA(127 downto 32) => B"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      TXDATA(31 downto 0) => gtwiz_userdata_tx_in(31 downto 0),
      TXDATAEXTENDRSVD(7 downto 0) => txdataextendrsvd_in(7 downto 0),
      TXDEEMPH => txdeemph_in(0),
      TXDETECTRX => txdetectrx_in(0),
      TXDIFFCTRL(3 downto 0) => txdiffctrl_in(3 downto 0),
      TXDIFFPD => txdiffpd_in(0),
      TXDLYBYPASS => '0',
      TXDLYEN => '0',
      TXDLYHOLD => '0',
      TXDLYOVRDEN => '0',
      TXDLYSRESET => GTHE3_CHANNEL_TXDLYSRESET(0),
      TXDLYSRESETDONE => txdlysresetdone_out(0),
      TXDLYUPDOWN => '0',
      TXELECIDLE => txelecidle_in(0),
      TXHEADER(5 downto 0) => txheader_in(5 downto 0),
      TXINHIBIT => txinhibit_in(0),
      TXLATCLK => txlatclk_in(0),
      TXMAINCURSOR(6 downto 0) => txmaincursor_in(6 downto 0),
      TXMARGIN(2 downto 0) => txmargin_in(2 downto 0),
      TXOUTCLK => txoutclk_out(0),
      TXOUTCLKFABRIC => txoutclkfabric_out(0),
      TXOUTCLKPCS => txoutclkpcs_out(0),
      TXOUTCLKSEL(2 downto 0) => txoutclksel_in(2 downto 0),
      TXPCSRESET => txpcsreset_in(0),
      TXPD(1 downto 0) => txpd_in(1 downto 0),
      TXPDELECIDLEMODE => txpdelecidlemode_in(0),
      TXPHALIGN => '0',
      TXPHALIGNDONE => txphaligndone_out(0),
      TXPHALIGNEN => '0',
      TXPHDLYPD => '0',
      TXPHDLYRESET => '0',
      TXPHDLYTSTCLK => '0',
      TXPHINIT => '0',
      TXPHINITDONE => txphinitdone_out(0),
      TXPHOVRDEN => '0',
      TXPIPPMEN => txpippmen_in(0),
      TXPIPPMOVRDEN => txpippmovrden_in(0),
      TXPIPPMPD => txpippmpd_in(0),
      TXPIPPMSEL => txpippmsel_in(0),
      TXPIPPMSTEPSIZE(4 downto 0) => txpippmstepsize_in(4 downto 0),
      TXPISOPD => txpisopd_in(0),
      TXPLLCLKSEL(1 downto 0) => txpllclksel_in(1 downto 0),
      TXPMARESET => txpmareset_in(0),
      TXPMARESETDONE => txpmaresetdone_out(0),
      TXPOLARITY => txpolarity_in(0),
      TXPOSTCURSOR(4 downto 0) => txpostcursor_in(4 downto 0),
      TXPOSTCURSORINV => txpostcursorinv_in(0),
      TXPRBSFORCEERR => txprbsforceerr_in(0),
      TXPRBSSEL(3 downto 0) => txprbssel_in(3 downto 0),
      TXPRECURSOR(4 downto 0) => txprecursor_in(4 downto 0),
      TXPRECURSORINV => txprecursorinv_in(0),
      TXPRGDIVRESETDONE => txprgdivresetdone_out(0),
      TXPROGDIVRESET => GTHE3_CHANNEL_TXPROGDIVRESET(0),
      TXQPIBIASEN => txqpibiasen_in(0),
      TXQPISENN => txqpisenn_out(0),
      TXQPISENP => txqpisenp_out(0),
      TXQPISTRONGPDOWN => txqpistrongpdown_in(0),
      TXQPIWEAKPUP => txqpiweakpup_in(0),
      TXRATE(2 downto 0) => txrate_in(2 downto 0),
      TXRATEDONE => txratedone_out(0),
      TXRATEMODE => txratemode_in(0),
      TXRESETDONE => txresetdone_out(0),
      TXSEQUENCE(6 downto 0) => txsequence_in(6 downto 0),
      TXSWING => txswing_in(0),
      TXSYNCALLIN => GTHE3_CHANNEL_TXSYNCALLIN(0),
      TXSYNCDONE => txsyncdone_out(0),
      TXSYNCIN => gtrxreset_out_reg_0(0),
      TXSYNCMODE => '0',
      TXSYNCOUT => txsyncout_out(0),
      TXSYSCLKSEL(1 downto 0) => txsysclksel_in(1 downto 0),
      TXUSERRDY => GTHE3_CHANNEL_TXUSERRDY(0),
      TXUSRCLK => txusrclk_in(0),
      TXUSRCLK2 => txusrclk2_in(0)
    );
\gthe3_channel_gen.gen_gthe3_channel_inst[1].GTHE3_CHANNEL_PRIM_INST\: unisim.vcomponents.GTHE3_CHANNEL
    generic map(
      ACJTAG_DEBUG_MODE => '0',
      ACJTAG_MODE => '0',
      ACJTAG_RESET => '0',
      ADAPT_CFG0 => X"F800",
      ADAPT_CFG1 => X"0000",
      ALIGN_COMMA_DOUBLE => "FALSE",
      ALIGN_COMMA_ENABLE => B"1111111111",
      ALIGN_COMMA_WORD => 1,
      ALIGN_MCOMMA_DET => "TRUE",
      ALIGN_MCOMMA_VALUE => B"1010000011",
      ALIGN_PCOMMA_DET => "TRUE",
      ALIGN_PCOMMA_VALUE => B"0101111100",
      A_RXOSCALRESET => '0',
      A_RXPROGDIVRESET => '0',
      A_TXPROGDIVRESET => '0',
      CBCC_DATA_SOURCE_SEL => "DECODED",
      CDR_SWAP_MODE_EN => '0',
      CHAN_BOND_KEEP_ALIGN => "FALSE",
      CHAN_BOND_MAX_SKEW => 1,
      CHAN_BOND_SEQ_1_1 => B"0000000000",
      CHAN_BOND_SEQ_1_2 => B"0000000000",
      CHAN_BOND_SEQ_1_3 => B"0000000000",
      CHAN_BOND_SEQ_1_4 => B"0000000000",
      CHAN_BOND_SEQ_1_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_1 => B"0000000000",
      CHAN_BOND_SEQ_2_2 => B"0000000000",
      CHAN_BOND_SEQ_2_3 => B"0000000000",
      CHAN_BOND_SEQ_2_4 => B"0000000000",
      CHAN_BOND_SEQ_2_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_USE => "FALSE",
      CHAN_BOND_SEQ_LEN => 1,
      CLK_CORRECT_USE => "FALSE",
      CLK_COR_KEEP_IDLE => "FALSE",
      CLK_COR_MAX_LAT => 12,
      CLK_COR_MIN_LAT => 8,
      CLK_COR_PRECEDENCE => "TRUE",
      CLK_COR_REPEAT_WAIT => 0,
      CLK_COR_SEQ_1_1 => B"0100000000",
      CLK_COR_SEQ_1_2 => B"0100000000",
      CLK_COR_SEQ_1_3 => B"0100000000",
      CLK_COR_SEQ_1_4 => B"0100000000",
      CLK_COR_SEQ_1_ENABLE => B"1111",
      CLK_COR_SEQ_2_1 => B"0100000000",
      CLK_COR_SEQ_2_2 => B"0100000000",
      CLK_COR_SEQ_2_3 => B"0100000000",
      CLK_COR_SEQ_2_4 => B"0100000000",
      CLK_COR_SEQ_2_ENABLE => B"1111",
      CLK_COR_SEQ_2_USE => "FALSE",
      CLK_COR_SEQ_LEN => 1,
      CPLL_CFG0 => X"23FC",
      CPLL_CFG1 => X"A4AC",
      CPLL_CFG2 => X"0004",
      CPLL_CFG3 => B"00" & X"0",
      CPLL_FBDIV => 5,
      CPLL_FBDIV_45 => 4,
      CPLL_INIT_CFG0 => X"02B2",
      CPLL_INIT_CFG1 => X"00",
      CPLL_LOCK_CFG => X"01E8",
      CPLL_REFCLK_DIV => 1,
      DDI_CTRL => B"00",
      DDI_REALIGN_WAIT => 15,
      DEC_MCOMMA_DETECT => "TRUE",
      DEC_PCOMMA_DETECT => "TRUE",
      DEC_VALID_COMMA_ONLY => "FALSE",
      DFE_D_X_REL_POS => '0',
      DFE_VCM_COMP_EN => '0',
      DMONITOR_CFG0 => B"00" & X"00",
      DMONITOR_CFG1 => X"00",
      ES_CLK_PHASE_SEL => '0',
      ES_CONTROL => B"000000",
      ES_ERRDET_EN => "FALSE",
      ES_EYE_SCAN_EN => "FALSE",
      ES_HORZ_OFFSET => X"000",
      ES_PMA_CFG => B"0000000000",
      ES_PRESCALE => B"00000",
      ES_QUALIFIER0 => X"0000",
      ES_QUALIFIER1 => X"0000",
      ES_QUALIFIER2 => X"0000",
      ES_QUALIFIER3 => X"0000",
      ES_QUALIFIER4 => X"0000",
      ES_QUAL_MASK0 => X"0000",
      ES_QUAL_MASK1 => X"0000",
      ES_QUAL_MASK2 => X"0000",
      ES_QUAL_MASK3 => X"0000",
      ES_QUAL_MASK4 => X"0000",
      ES_SDATA_MASK0 => X"0000",
      ES_SDATA_MASK1 => X"0000",
      ES_SDATA_MASK2 => X"0000",
      ES_SDATA_MASK3 => X"0000",
      ES_SDATA_MASK4 => X"0000",
      EVODD_PHI_CFG => B"00000000000",
      EYE_SCAN_SWAP_EN => '0',
      FTS_DESKEW_SEQ_ENABLE => B"1111",
      FTS_LANE_DESKEW_CFG => B"1111",
      FTS_LANE_DESKEW_EN => "FALSE",
      GEARBOX_MODE => B"00000",
      GM_BIAS_SELECT => '0',
      LOCAL_MASTER => '1',
      OOBDIVCTL => B"00",
      OOB_PWRUP => '0',
      PCI3_AUTO_REALIGN => "OVR_1K_BLK",
      PCI3_PIPE_RX_ELECIDLE => '0',
      PCI3_RX_ASYNC_EBUF_BYPASS => B"00",
      PCI3_RX_ELECIDLE_EI2_ENABLE => '0',
      PCI3_RX_ELECIDLE_H2L_COUNT => B"000000",
      PCI3_RX_ELECIDLE_H2L_DISABLE => B"000",
      PCI3_RX_ELECIDLE_HI_COUNT => B"000000",
      PCI3_RX_ELECIDLE_LP4_DISABLE => '0',
      PCI3_RX_FIFO_DISABLE => '0',
      PCIE_BUFG_DIV_CTRL => X"1000",
      PCIE_RXPCS_CFG_GEN3 => X"02A4",
      PCIE_RXPMA_CFG => X"000A",
      PCIE_TXPCS_CFG_GEN3 => X"2CA4",
      PCIE_TXPMA_CFG => X"000A",
      PCS_PCIE_EN => "FALSE",
      PCS_RSVD0 => B"0000000000000000",
      PCS_RSVD1 => B"000",
      PD_TRANS_TIME_FROM_P2 => X"03C",
      PD_TRANS_TIME_NONE_P2 => X"19",
      PD_TRANS_TIME_TO_P2 => X"64",
      PLL_SEL_MODE_GEN12 => B"11",
      PLL_SEL_MODE_GEN3 => B"11",
      PMA_RSV1 => X"E000",
      PROCESS_PAR => B"010",
      RATE_SW_USE_DRP => '1',
      RESET_POWERSAVE_DISABLE => '0',
      RXBUFRESET_TIME => B"00011",
      RXBUF_ADDR_MODE => "FAST",
      RXBUF_EIDLE_HI_CNT => B"1000",
      RXBUF_EIDLE_LO_CNT => B"0000",
      RXBUF_EN => "TRUE",
      RXBUF_RESET_ON_CB_CHANGE => "TRUE",
      RXBUF_RESET_ON_COMMAALIGN => "TRUE",
      RXBUF_RESET_ON_EIDLE => "FALSE",
      RXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      RXBUF_THRESH_OVFLW => 57,
      RXBUF_THRESH_OVRD => "TRUE",
      RXBUF_THRESH_UNDFLW => 3,
      RXCDRFREQRESET_TIME => B"00001",
      RXCDRPHRESET_TIME => B"00001",
      RXCDR_CFG0 => X"0000",
      RXCDR_CFG0_GEN3 => X"0000",
      RXCDR_CFG1 => X"0000",
      RXCDR_CFG1_GEN3 => X"0000",
      RXCDR_CFG2 => X"0766",
      RXCDR_CFG2_GEN3 => X"07E6",
      RXCDR_CFG3 => X"0000",
      RXCDR_CFG3_GEN3 => X"0000",
      RXCDR_CFG4 => X"0000",
      RXCDR_CFG4_GEN3 => X"0000",
      RXCDR_CFG5 => X"0000",
      RXCDR_CFG5_GEN3 => X"0000",
      RXCDR_FR_RESET_ON_EIDLE => '0',
      RXCDR_HOLD_DURING_EIDLE => '0',
      RXCDR_LOCK_CFG0 => X"4480",
      RXCDR_LOCK_CFG1 => X"5FFF",
      RXCDR_LOCK_CFG2 => X"77C3",
      RXCDR_PH_RESET_ON_EIDLE => '0',
      RXCFOK_CFG0 => X"4000",
      RXCFOK_CFG1 => X"0065",
      RXCFOK_CFG2 => X"002E",
      RXDFELPMRESET_TIME => B"0001111",
      RXDFELPM_KL_CFG0 => X"0000",
      RXDFELPM_KL_CFG1 => X"0032",
      RXDFELPM_KL_CFG2 => X"0000",
      RXDFE_CFG0 => X"0A00",
      RXDFE_CFG1 => X"0000",
      RXDFE_GC_CFG0 => X"0000",
      RXDFE_GC_CFG1 => X"7860",
      RXDFE_GC_CFG2 => X"0000",
      RXDFE_H2_CFG0 => X"0000",
      RXDFE_H2_CFG1 => X"0000",
      RXDFE_H3_CFG0 => X"4000",
      RXDFE_H3_CFG1 => X"0000",
      RXDFE_H4_CFG0 => X"2000",
      RXDFE_H4_CFG1 => X"0003",
      RXDFE_H5_CFG0 => X"2000",
      RXDFE_H5_CFG1 => X"0003",
      RXDFE_H6_CFG0 => X"2000",
      RXDFE_H6_CFG1 => X"0000",
      RXDFE_H7_CFG0 => X"2000",
      RXDFE_H7_CFG1 => X"0000",
      RXDFE_H8_CFG0 => X"2000",
      RXDFE_H8_CFG1 => X"0000",
      RXDFE_H9_CFG0 => X"2000",
      RXDFE_H9_CFG1 => X"0000",
      RXDFE_HA_CFG0 => X"2000",
      RXDFE_HA_CFG1 => X"0000",
      RXDFE_HB_CFG0 => X"2000",
      RXDFE_HB_CFG1 => X"0000",
      RXDFE_HC_CFG0 => X"0000",
      RXDFE_HC_CFG1 => X"0000",
      RXDFE_HD_CFG0 => X"0000",
      RXDFE_HD_CFG1 => X"0000",
      RXDFE_HE_CFG0 => X"0000",
      RXDFE_HE_CFG1 => X"0000",
      RXDFE_HF_CFG0 => X"0000",
      RXDFE_HF_CFG1 => X"0000",
      RXDFE_OS_CFG0 => X"8000",
      RXDFE_OS_CFG1 => X"0000",
      RXDFE_UT_CFG0 => X"8000",
      RXDFE_UT_CFG1 => X"0003",
      RXDFE_VP_CFG0 => X"AA00",
      RXDFE_VP_CFG1 => X"0033",
      RXDLY_CFG => X"001F",
      RXDLY_LCFG => X"0030",
      RXELECIDLE_CFG => "Sigcfg_4",
      RXGBOX_FIFO_INIT_RD_ADDR => 4,
      RXGEARBOX_EN => "FALSE",
      RXISCANRESET_TIME => B"00001",
      RXLPM_CFG => X"0000",
      RXLPM_GC_CFG => X"1000",
      RXLPM_KH_CFG0 => X"0000",
      RXLPM_KH_CFG1 => X"0002",
      RXLPM_OS_CFG0 => X"8000",
      RXLPM_OS_CFG1 => X"0002",
      RXOOB_CFG => B"000000110",
      RXOOB_CLK_CFG => "PMA",
      RXOSCALRESET_TIME => B"00011",
      RXOUT_DIV => 1,
      RXPCSRESET_TIME => B"00011",
      RXPHBEACON_CFG => X"0000",
      RXPHDLY_CFG => X"2020",
      RXPHSAMP_CFG => X"2100",
      RXPHSLIP_CFG => X"6622",
      RXPH_MONITOR_SEL => B"00000",
      RXPI_CFG0 => B"01",
      RXPI_CFG1 => B"01",
      RXPI_CFG2 => B"01",
      RXPI_CFG3 => B"01",
      RXPI_CFG4 => '0',
      RXPI_CFG5 => '0',
      RXPI_CFG6 => B"000",
      RXPI_LPM => '0',
      RXPI_VREFSEL => '0',
      RXPMACLK_SEL => "DATA",
      RXPMARESET_TIME => B"00011",
      RXPRBS_ERR_LOOPBACK => '0',
      RXPRBS_LINKACQ_CNT => 15,
      RXSLIDE_AUTO_WAIT => 7,
      RXSLIDE_MODE => "OFF",
      RXSYNC_MULTILANE => '1',
      RXSYNC_OVRD => '0',
      RXSYNC_SKIP_DA => '0',
      RX_AFE_CM_EN => '0',
      RX_BIAS_CFG0 => X"0AB4",
      RX_BUFFER_CFG => B"000000",
      RX_CAPFF_SARC_ENB => '0',
      RX_CLK25_DIV => 13,
      RX_CLKMUX_EN => '1',
      RX_CLK_SLIP_OVRD => B"00000",
      RX_CM_BUF_CFG => B"1010",
      RX_CM_BUF_PD => '0',
      RX_CM_SEL => B"11",
      RX_CM_TRIM => B"1010",
      RX_CTLE3_LPF => B"00000001",
      RX_DATA_WIDTH => 40,
      RX_DDI_SEL => B"000000",
      RX_DEFER_RESET_BUF_EN => "TRUE",
      RX_DFELPM_CFG0 => B"0110",
      RX_DFELPM_CFG1 => '1',
      RX_DFELPM_KLKH_AGC_STUP_EN => '1',
      RX_DFE_AGC_CFG0 => B"10",
      RX_DFE_AGC_CFG1 => B"000",
      RX_DFE_KL_LPM_KH_CFG0 => B"01",
      RX_DFE_KL_LPM_KH_CFG1 => B"000",
      RX_DFE_KL_LPM_KL_CFG0 => B"01",
      RX_DFE_KL_LPM_KL_CFG1 => B"000",
      RX_DFE_LPM_HOLD_DURING_EIDLE => '0',
      RX_DISPERR_SEQ_MATCH => "TRUE",
      RX_DIVRESET_TIME => B"00001",
      RX_EN_HI_LR => '1',
      RX_EYESCAN_VS_CODE => B"0000000",
      RX_EYESCAN_VS_NEG_DIR => '0',
      RX_EYESCAN_VS_RANGE => B"00",
      RX_EYESCAN_VS_UT_SIGN => '0',
      RX_FABINT_USRCLK_FLOP => '0',
      RX_INT_DATAWIDTH => 1,
      RX_PMA_POWER_SAVE => '0',
      RX_PROGDIV_CFG => 0.000000,
      RX_SAMPLE_PERIOD => B"111",
      RX_SIG_VALID_DLY => 11,
      RX_SUM_DFETAPREP_EN => '0',
      RX_SUM_IREF_TUNE => B"1100",
      RX_SUM_RES_CTRL => B"11",
      RX_SUM_VCMTUNE => B"0000",
      RX_SUM_VCM_OVWR => '0',
      RX_SUM_VREF_TUNE => B"000",
      RX_TUNE_AFE_OS => B"10",
      RX_WIDEMODE_CDR => '1',
      RX_XCLK_SEL => "RXDES",
      SAS_MAX_COM => 64,
      SAS_MIN_COM => 36,
      SATA_BURST_SEQ_LEN => B"1110",
      SATA_BURST_VAL => B"100",
      SATA_CPLL_CFG => "VCO_3000MHZ",
      SATA_EIDLE_VAL => B"100",
      SATA_MAX_BURST => 8,
      SATA_MAX_INIT => 21,
      SATA_MAX_WAKE => 7,
      SATA_MIN_BURST => 4,
      SATA_MIN_INIT => 12,
      SATA_MIN_WAKE => 4,
      SHOW_REALIGN_COMMA => "FALSE",
      SIM_MODE => "FAST",
      SIM_RECEIVER_DETECT_PASS => "TRUE",
      SIM_RESET_SPEEDUP => "TRUE",
      SIM_TX_EIDLE_DRIVE_LEVEL => '0',
      SIM_VERSION => 2,
      TAPDLY_SET_TX => B"00",
      TEMPERATUR_PAR => B"0010",
      TERM_RCAL_CFG => B"100001000010000",
      TERM_RCAL_OVRD => B"000",
      TRANS_TIME_RATE => X"0E",
      TST_RSV0 => X"00",
      TST_RSV1 => X"00",
      TXBUF_EN => "FALSE",
      TXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      TXDLY_CFG => X"0009",
      TXDLY_LCFG => X"0050",
      TXDRVBIAS_N => B"1010",
      TXDRVBIAS_P => B"1010",
      TXFIFO_ADDR_CFG => "LOW",
      TXGBOX_FIFO_INIT_RD_ADDR => 4,
      TXGEARBOX_EN => "FALSE",
      TXOUT_DIV => 1,
      TXPCSRESET_TIME => B"00011",
      TXPHDLY_CFG0 => X"2020",
      TXPHDLY_CFG1 => X"0075",
      TXPH_CFG => X"0980",
      TXPH_MONITOR_SEL => B"00000",
      TXPI_CFG0 => B"01",
      TXPI_CFG1 => B"01",
      TXPI_CFG2 => B"01",
      TXPI_CFG3 => '0',
      TXPI_CFG4 => '0',
      TXPI_CFG5 => B"000",
      TXPI_GRAY_SEL => '0',
      TXPI_INVSTROBE_SEL => '0',
      TXPI_LPM => '0',
      TXPI_PPMCLK_SEL => "TXUSRCLK2",
      TXPI_PPM_CFG => B"00000000",
      TXPI_SYNFREQ_PPM => B"001",
      TXPI_VREFSEL => '0',
      TXPMARESET_TIME => B"00011",
      TXSYNC_MULTILANE => '1',
      TXSYNC_OVRD => '0',
      TXSYNC_SKIP_DA => '0',
      TX_CLK25_DIV => 13,
      TX_CLKMUX_EN => '1',
      TX_DATA_WIDTH => 40,
      TX_DCD_CFG => B"000010",
      TX_DCD_EN => '0',
      TX_DEEMPH0 => B"000000",
      TX_DEEMPH1 => B"000000",
      TX_DIVRESET_TIME => B"00001",
      TX_DRIVE_MODE => "DIRECT",
      TX_EIDLE_ASSERT_DELAY => B"100",
      TX_EIDLE_DEASSERT_DELAY => B"011",
      TX_EML_PHI_TUNE => '0',
      TX_FABINT_USRCLK_FLOP => '0',
      TX_IDLE_DATA_ZERO => '0',
      TX_INT_DATAWIDTH => 1,
      TX_LOOPBACK_DRIVE_HIZ => "FALSE",
      TX_MAINCURSOR_SEL => '0',
      TX_MARGIN_FULL_0 => B"1001111",
      TX_MARGIN_FULL_1 => B"1001110",
      TX_MARGIN_FULL_2 => B"1001100",
      TX_MARGIN_FULL_3 => B"1001010",
      TX_MARGIN_FULL_4 => B"1001000",
      TX_MARGIN_LOW_0 => B"1000110",
      TX_MARGIN_LOW_1 => B"1000101",
      TX_MARGIN_LOW_2 => B"1000011",
      TX_MARGIN_LOW_3 => B"1000010",
      TX_MARGIN_LOW_4 => B"1000000",
      TX_MODE_SEL => B"000",
      TX_PMADATA_OPT => '0',
      TX_PMA_POWER_SAVE => '0',
      TX_PROGCLK_SEL => "PREPI",
      TX_PROGDIV_CFG => 20.000000,
      TX_QPI_STATUS_EN => '0',
      TX_RXDETECT_CFG => B"00" & X"032",
      TX_RXDETECT_REF => B"100",
      TX_SAMPLE_PERIOD => B"111",
      TX_SARC_LPBK_ENB => '0',
      TX_XCLK_SEL => "TXUSR",
      USE_PCS_CLK_PHASE_SEL => '0',
      WB_MODE => B"00"
    )
        port map (
      BUFGTCE(2 downto 0) => bufgtce_out(5 downto 3),
      BUFGTCEMASK(2 downto 0) => bufgtcemask_out(5 downto 3),
      BUFGTDIV(8 downto 0) => bufgtdiv_out(17 downto 9),
      BUFGTRESET(2 downto 0) => bufgtreset_out(5 downto 3),
      BUFGTRSTMASK(2 downto 0) => bufgtrstmask_out(5 downto 3),
      CFGRESET => cfgreset_in(1),
      CLKRSVD0 => clkrsvd0_in(1),
      CLKRSVD1 => clkrsvd1_in(1),
      CPLLFBCLKLOST => cpllfbclklost_out(1),
      CPLLLOCK => \^cplllock_out\(1),
      CPLLLOCKDETCLK => cplllockdetclk_in(1),
      CPLLLOCKEN => cplllocken_in(1),
      CPLLPD => GTHE3_CHANNEL_CPLLPD(0),
      CPLLREFCLKLOST => cpllrefclklost_out(1),
      CPLLREFCLKSEL(2 downto 0) => cpllrefclksel_in(5 downto 3),
      CPLLRESET => cpllreset_in(1),
      DMONFIFORESET => dmonfiforeset_in(1),
      DMONITORCLK => dmonitorclk_in(1),
      DMONITOROUT(16 downto 0) => dmonitorout_out(33 downto 17),
      DRPADDR(8 downto 0) => drpaddr_in(17 downto 9),
      DRPCLK => drpclk_in(1),
      DRPDI(15 downto 0) => drpdi_in(31 downto 16),
      DRPDO(15 downto 0) => drpdo_out(31 downto 16),
      DRPEN => drpen_in(1),
      DRPRDY => drprdy_out(1),
      DRPWE => drpwe_in(1),
      EVODDPHICALDONE => evoddphicaldone_in(1),
      EVODDPHICALSTART => evoddphicalstart_in(1),
      EVODDPHIDRDEN => evoddphidrden_in(1),
      EVODDPHIDWREN => evoddphidwren_in(1),
      EVODDPHIXRDEN => evoddphixrden_in(1),
      EVODDPHIXWREN => evoddphixwren_in(1),
      EYESCANDATAERROR => eyescandataerror_out(1),
      EYESCANMODE => eyescanmode_in(1),
      EYESCANRESET => eyescanreset_in(1),
      EYESCANTRIGGER => eyescantrigger_in(1),
      GTGREFCLK => gtgrefclk_in(1),
      GTHRXN => gthrxn_in(1),
      GTHRXP => gthrxp_in(1),
      GTHTXN => gthtxn_out(1),
      GTHTXP => gthtxp_out(1),
      GTNORTHREFCLK0 => gtnorthrefclk0_in(1),
      GTNORTHREFCLK1 => gtnorthrefclk1_in(1),
      GTPOWERGOOD => gtpowergood_out(1),
      GTREFCLK0 => gtrefclk0_in(1),
      GTREFCLK1 => gtrefclk1_in(1),
      GTREFCLKMONITOR => gtrefclkmonitor_out(1),
      GTRESETSEL => gtresetsel_in(1),
      GTRSVD(15 downto 0) => gtrsvd_in(31 downto 16),
      GTRXRESET => GTHE3_CHANNEL_GTRXRESET(0),
      GTSOUTHREFCLK0 => gtsouthrefclk0_in(1),
      GTSOUTHREFCLK1 => gtsouthrefclk1_in(1),
      GTTXRESET => GTHE3_CHANNEL_GTTXRESET(0),
      LOOPBACK(2 downto 0) => loopback_in(5 downto 3),
      LPBKRXTXSEREN => lpbkrxtxseren_in(1),
      LPBKTXRXSEREN => lpbktxrxseren_in(1),
      PCIEEQRXEQADAPTDONE => pcieeqrxeqadaptdone_in(1),
      PCIERATEGEN3 => pcierategen3_out(1),
      PCIERATEIDLE => pcierateidle_out(1),
      PCIERATEQPLLPD(1 downto 0) => pcierateqpllpd_out(3 downto 2),
      PCIERATEQPLLRESET(1 downto 0) => pcierateqpllreset_out(3 downto 2),
      PCIERSTIDLE => pcierstidle_in(1),
      PCIERSTTXSYNCSTART => pciersttxsyncstart_in(1),
      PCIESYNCTXSYNCDONE => pciesynctxsyncdone_out(1),
      PCIEUSERGEN3RDY => pcieusergen3rdy_out(1),
      PCIEUSERPHYSTATUSRST => pcieuserphystatusrst_out(1),
      PCIEUSERRATEDONE => pcieuserratedone_in(1),
      PCIEUSERRATESTART => pcieuserratestart_out(1),
      PCSRSVDIN(15 downto 0) => pcsrsvdin_in(31 downto 16),
      PCSRSVDIN2(4 downto 0) => pcsrsvdin2_in(9 downto 5),
      PCSRSVDOUT(11 downto 0) => pcsrsvdout_out(23 downto 12),
      PHYSTATUS => phystatus_out(1),
      PINRSRVDAS(7 downto 0) => pinrsrvdas_out(15 downto 8),
      PMARSVDIN(4 downto 0) => pmarsvdin_in(9 downto 5),
      QPLL0CLK => qpll0clk_in(1),
      QPLL0REFCLK => qpll0refclk_in(1),
      QPLL1CLK => qpll1clk_in(1),
      QPLL1REFCLK => qpll1refclk_in(1),
      RESETEXCEPTION => resetexception_out(1),
      RESETOVRD => resetovrd_in(1),
      RSTCLKENTX => rstclkentx_in(1),
      RX8B10BEN => rx8b10ben_in(1),
      RXBUFRESET => rxbufreset_in(1),
      RXBUFSTATUS(2 downto 0) => rxbufstatus_out(5 downto 3),
      RXBYTEISALIGNED => rxbyteisaligned_out(1),
      RXBYTEREALIGN => rxbyterealign_out(1),
      RXCDRFREQRESET => rxcdrfreqreset_in(1),
      RXCDRHOLD => rxcdrhold_in(1),
      RXCDRLOCK => rxcdrlock_out(1),
      RXCDROVRDEN => rxcdrovrden_in(1),
      RXCDRPHDONE => rxcdrphdone_out(1),
      RXCDRRESET => rxcdrreset_in(1),
      RXCDRRESETRSV => rxcdrresetrsv_in(1),
      RXCHANBONDSEQ => rxchanbondseq_out(1),
      RXCHANISALIGNED => rxchanisaligned_out(1),
      RXCHANREALIGN => rxchanrealign_out(1),
      RXCHBONDEN => rxchbonden_in(1),
      RXCHBONDI(4 downto 0) => rxchbondi_in(9 downto 5),
      RXCHBONDLEVEL(2 downto 0) => rxchbondlevel_in(5 downto 3),
      RXCHBONDMASTER => rxchbondmaster_in(1),
      RXCHBONDO(4 downto 0) => rxchbondo_out(9 downto 5),
      RXCHBONDSLAVE => rxchbondslave_in(1),
      RXCLKCORCNT(1 downto 0) => rxclkcorcnt_out(3 downto 2),
      RXCOMINITDET => rxcominitdet_out(1),
      RXCOMMADET => rxcommadet_out(1),
      RXCOMMADETEN => rxcommadeten_in(1),
      RXCOMSASDET => rxcomsasdet_out(1),
      RXCOMWAKEDET => rxcomwakedet_out(1),
      RXCTRL0(15 downto 0) => rxctrl0_out(31 downto 16),
      RXCTRL1(15 downto 0) => rxctrl1_out(31 downto 16),
      RXCTRL2(7 downto 0) => rxctrl2_out(15 downto 8),
      RXCTRL3(7 downto 0) => rxctrl3_out(15 downto 8),
      RXDATA(127 downto 0) => rxdata_out(255 downto 128),
      RXDATAEXTENDRSVD(7 downto 0) => rxdataextendrsvd_out(15 downto 8),
      RXDATAVALID(1 downto 0) => rxdatavalid_out(3 downto 2),
      RXDFEAGCCTRL(1 downto 0) => rxdfeagcctrl_in(3 downto 2),
      RXDFEAGCHOLD => rxdfeagchold_in(1),
      RXDFEAGCOVRDEN => rxdfeagcovrden_in(1),
      RXDFELFHOLD => rxdfelfhold_in(1),
      RXDFELFOVRDEN => rxdfelfovrden_in(1),
      RXDFELPMRESET => rxdfelpmreset_in(1),
      RXDFETAP10HOLD => rxdfetap10hold_in(1),
      RXDFETAP10OVRDEN => rxdfetap10ovrden_in(1),
      RXDFETAP11HOLD => rxdfetap11hold_in(1),
      RXDFETAP11OVRDEN => rxdfetap11ovrden_in(1),
      RXDFETAP12HOLD => rxdfetap12hold_in(1),
      RXDFETAP12OVRDEN => rxdfetap12ovrden_in(1),
      RXDFETAP13HOLD => rxdfetap13hold_in(1),
      RXDFETAP13OVRDEN => rxdfetap13ovrden_in(1),
      RXDFETAP14HOLD => rxdfetap14hold_in(1),
      RXDFETAP14OVRDEN => rxdfetap14ovrden_in(1),
      RXDFETAP15HOLD => rxdfetap15hold_in(1),
      RXDFETAP15OVRDEN => rxdfetap15ovrden_in(1),
      RXDFETAP2HOLD => rxdfetap2hold_in(1),
      RXDFETAP2OVRDEN => rxdfetap2ovrden_in(1),
      RXDFETAP3HOLD => rxdfetap3hold_in(1),
      RXDFETAP3OVRDEN => rxdfetap3ovrden_in(1),
      RXDFETAP4HOLD => rxdfetap4hold_in(1),
      RXDFETAP4OVRDEN => rxdfetap4ovrden_in(1),
      RXDFETAP5HOLD => rxdfetap5hold_in(1),
      RXDFETAP5OVRDEN => rxdfetap5ovrden_in(1),
      RXDFETAP6HOLD => rxdfetap6hold_in(1),
      RXDFETAP6OVRDEN => rxdfetap6ovrden_in(1),
      RXDFETAP7HOLD => rxdfetap7hold_in(1),
      RXDFETAP7OVRDEN => rxdfetap7ovrden_in(1),
      RXDFETAP8HOLD => rxdfetap8hold_in(1),
      RXDFETAP8OVRDEN => rxdfetap8ovrden_in(1),
      RXDFETAP9HOLD => rxdfetap9hold_in(1),
      RXDFETAP9OVRDEN => rxdfetap9ovrden_in(1),
      RXDFEUTHOLD => rxdfeuthold_in(1),
      RXDFEUTOVRDEN => rxdfeutovrden_in(1),
      RXDFEVPHOLD => rxdfevphold_in(1),
      RXDFEVPOVRDEN => rxdfevpovrden_in(1),
      RXDFEVSEN => rxdfevsen_in(1),
      RXDFEXYDEN => rxdfexyden_in(1),
      RXDLYBYPASS => rxdlybypass_in(1),
      RXDLYEN => rxdlyen_in(1),
      RXDLYOVRDEN => rxdlyovrden_in(1),
      RXDLYSRESET => rxdlysreset_in(1),
      RXDLYSRESETDONE => rxdlysresetdone_out(1),
      RXELECIDLE => rxelecidle_out(1),
      RXELECIDLEMODE(1 downto 0) => rxelecidlemode_in(3 downto 2),
      RXGEARBOXSLIP => rxgearboxslip_in(1),
      RXHEADER(5 downto 0) => rxheader_out(11 downto 6),
      RXHEADERVALID(1 downto 0) => rxheadervalid_out(3 downto 2),
      RXLATCLK => rxlatclk_in(1),
      RXLPMEN => rxlpmen_in(1),
      RXLPMGCHOLD => rxlpmgchold_in(1),
      RXLPMGCOVRDEN => rxlpmgcovrden_in(1),
      RXLPMHFHOLD => rxlpmhfhold_in(1),
      RXLPMHFOVRDEN => rxlpmhfovrden_in(1),
      RXLPMLFHOLD => rxlpmlfhold_in(1),
      RXLPMLFKLOVRDEN => rxlpmlfklovrden_in(1),
      RXLPMOSHOLD => rxlpmoshold_in(1),
      RXLPMOSOVRDEN => rxlpmosovrden_in(1),
      RXMCOMMAALIGNEN => rxmcommaalignen_in(1),
      RXMONITOROUT(6 downto 0) => rxmonitorout_out(13 downto 7),
      RXMONITORSEL(1 downto 0) => rxmonitorsel_in(3 downto 2),
      RXOOBRESET => rxoobreset_in(1),
      RXOSCALRESET => rxoscalreset_in(1),
      RXOSHOLD => rxoshold_in(1),
      RXOSINTCFG(3 downto 0) => rxosintcfg_in(7 downto 4),
      RXOSINTDONE => rxosintdone_out(1),
      RXOSINTEN => rxosinten_in(1),
      RXOSINTHOLD => rxosinthold_in(1),
      RXOSINTOVRDEN => rxosintovrden_in(1),
      RXOSINTSTARTED => rxosintstarted_out(1),
      RXOSINTSTROBE => rxosintstrobe_in(1),
      RXOSINTSTROBEDONE => rxosintstrobedone_out(1),
      RXOSINTSTROBESTARTED => rxosintstrobestarted_out(1),
      RXOSINTTESTOVRDEN => rxosinttestovrden_in(1),
      RXOSOVRDEN => rxosovrden_in(1),
      RXOUTCLK => rxoutclk_out(1),
      RXOUTCLKFABRIC => rxoutclkfabric_out(1),
      RXOUTCLKPCS => rxoutclkpcs_out(1),
      RXOUTCLKSEL(2 downto 0) => rxoutclksel_in(5 downto 3),
      RXPCOMMAALIGNEN => rxpcommaalignen_in(1),
      RXPCSRESET => rxpcsreset_in(1),
      RXPD(1 downto 0) => rxpd_in(3 downto 2),
      RXPHALIGN => rxphalign_in(1),
      RXPHALIGNDONE => rxphaligndone_out(1),
      RXPHALIGNEN => rxphalignen_in(1),
      RXPHALIGNERR => rxphalignerr_out(1),
      RXPHDLYPD => rxphdlypd_in(1),
      RXPHDLYRESET => rxphdlyreset_in(1),
      RXPHOVRDEN => rxphovrden_in(1),
      RXPLLCLKSEL(1 downto 0) => rxpllclksel_in(3 downto 2),
      RXPMARESET => rxpmareset_in(1),
      RXPMARESETDONE => rxpmaresetdone_out(1),
      RXPOLARITY => rxpolarity_in(1),
      RXPRBSCNTRESET => rxprbscntreset_in(1),
      RXPRBSERR => rxprbserr_out(1),
      RXPRBSLOCKED => rxprbslocked_out(1),
      RXPRBSSEL(3 downto 0) => rxprbssel_in(7 downto 4),
      RXPRGDIVRESETDONE => rxprgdivresetdone_out(1),
      RXPROGDIVRESET => GTHE3_CHANNEL_RXPROGDIVRESET(0),
      RXQPIEN => rxqpien_in(1),
      RXQPISENN => rxqpisenn_out(1),
      RXQPISENP => rxqpisenp_out(1),
      RXRATE(2 downto 0) => rxrate_in(5 downto 3),
      RXRATEDONE => rxratedone_out(1),
      RXRATEMODE => rxratemode_in(1),
      RXRECCLKOUT => rxrecclkout_out(1),
      RXRESETDONE => rxresetdone_out(1),
      RXSLIDE => rxslide_in(1),
      RXSLIDERDY => rxsliderdy_out(1),
      RXSLIPDONE => rxslipdone_out(1),
      RXSLIPOUTCLK => rxslipoutclk_in(1),
      RXSLIPOUTCLKRDY => rxslipoutclkrdy_out(1),
      RXSLIPPMA => rxslippma_in(1),
      RXSLIPPMARDY => rxslippmardy_out(1),
      RXSTARTOFSEQ(1 downto 0) => rxstartofseq_out(3 downto 2),
      RXSTATUS(2 downto 0) => rxstatus_out(5 downto 3),
      RXSYNCALLIN => rxsyncallin_in(1),
      RXSYNCDONE => rxsyncdone_out(1),
      RXSYNCIN => rxsyncin_in(1),
      RXSYNCMODE => rxsyncmode_in(1),
      RXSYNCOUT => rxsyncout_out(1),
      RXSYSCLKSEL(1 downto 0) => rxsysclksel_in(3 downto 2),
      RXUSERRDY => GTHE3_CHANNEL_RXUSERRDY(0),
      RXUSRCLK => rxusrclk_in(1),
      RXUSRCLK2 => rxusrclk2_in(1),
      RXVALID => rxvalid_out(1),
      SIGVALIDCLK => sigvalidclk_in(1),
      TSTIN(19 downto 0) => B"00000000000000000000",
      TX8B10BBYPASS(7 downto 0) => tx8b10bbypass_in(15 downto 8),
      TX8B10BEN => tx8b10ben_in(1),
      TXBUFDIFFCTRL(2 downto 0) => txbufdiffctrl_in(5 downto 3),
      TXBUFSTATUS(1 downto 0) => txbufstatus_out(3 downto 2),
      TXCOMFINISH => txcomfinish_out(1),
      TXCOMINIT => txcominit_in(1),
      TXCOMSAS => txcomsas_in(1),
      TXCOMWAKE => txcomwake_in(1),
      TXCTRL0(15 downto 0) => txctrl0_in(31 downto 16),
      TXCTRL1(15 downto 0) => txctrl1_in(31 downto 16),
      TXCTRL2(7 downto 0) => txctrl2_in(15 downto 8),
      TXDATA(127 downto 32) => B"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      TXDATA(31 downto 0) => gtwiz_userdata_tx_in(63 downto 32),
      TXDATAEXTENDRSVD(7 downto 0) => txdataextendrsvd_in(15 downto 8),
      TXDEEMPH => txdeemph_in(1),
      TXDETECTRX => txdetectrx_in(1),
      TXDIFFCTRL(3 downto 0) => txdiffctrl_in(7 downto 4),
      TXDIFFPD => txdiffpd_in(1),
      TXDLYBYPASS => '0',
      TXDLYEN => '0',
      TXDLYHOLD => '0',
      TXDLYOVRDEN => '0',
      TXDLYSRESET => GTHE3_CHANNEL_TXDLYSRESET(0),
      TXDLYSRESETDONE => txdlysresetdone_out(1),
      TXDLYUPDOWN => '0',
      TXELECIDLE => txelecidle_in(1),
      TXHEADER(5 downto 0) => txheader_in(11 downto 6),
      TXINHIBIT => txinhibit_in(1),
      TXLATCLK => txlatclk_in(1),
      TXMAINCURSOR(6 downto 0) => txmaincursor_in(13 downto 7),
      TXMARGIN(2 downto 0) => txmargin_in(5 downto 3),
      TXOUTCLK => txoutclk_out(1),
      TXOUTCLKFABRIC => txoutclkfabric_out(1),
      TXOUTCLKPCS => txoutclkpcs_out(1),
      TXOUTCLKSEL(2 downto 0) => txoutclksel_in(5 downto 3),
      TXPCSRESET => txpcsreset_in(1),
      TXPD(1 downto 0) => txpd_in(3 downto 2),
      TXPDELECIDLEMODE => txpdelecidlemode_in(1),
      TXPHALIGN => '0',
      TXPHALIGNDONE => txphaligndone_out(1),
      TXPHALIGNEN => '0',
      TXPHDLYPD => '0',
      TXPHDLYRESET => '0',
      TXPHDLYTSTCLK => '0',
      TXPHINIT => '0',
      TXPHINITDONE => txphinitdone_out(1),
      TXPHOVRDEN => '0',
      TXPIPPMEN => txpippmen_in(1),
      TXPIPPMOVRDEN => txpippmovrden_in(1),
      TXPIPPMPD => txpippmpd_in(1),
      TXPIPPMSEL => txpippmsel_in(1),
      TXPIPPMSTEPSIZE(4 downto 0) => txpippmstepsize_in(9 downto 5),
      TXPISOPD => txpisopd_in(1),
      TXPLLCLKSEL(1 downto 0) => txpllclksel_in(3 downto 2),
      TXPMARESET => txpmareset_in(1),
      TXPMARESETDONE => txpmaresetdone_out(1),
      TXPOLARITY => txpolarity_in(1),
      TXPOSTCURSOR(4 downto 0) => txpostcursor_in(9 downto 5),
      TXPOSTCURSORINV => txpostcursorinv_in(1),
      TXPRBSFORCEERR => txprbsforceerr_in(1),
      TXPRBSSEL(3 downto 0) => txprbssel_in(7 downto 4),
      TXPRECURSOR(4 downto 0) => txprecursor_in(9 downto 5),
      TXPRECURSORINV => txprecursorinv_in(1),
      TXPRGDIVRESETDONE => txprgdivresetdone_out(1),
      TXPROGDIVRESET => GTHE3_CHANNEL_TXPROGDIVRESET(0),
      TXQPIBIASEN => txqpibiasen_in(1),
      TXQPISENN => txqpisenn_out(1),
      TXQPISENP => txqpisenp_out(1),
      TXQPISTRONGPDOWN => txqpistrongpdown_in(1),
      TXQPIWEAKPUP => txqpiweakpup_in(1),
      TXRATE(2 downto 0) => txrate_in(5 downto 3),
      TXRATEDONE => txratedone_out(1),
      TXRATEMODE => txratemode_in(1),
      TXRESETDONE => txresetdone_out(1),
      TXSEQUENCE(6 downto 0) => txsequence_in(13 downto 7),
      TXSWING => txswing_in(1),
      TXSYNCALLIN => GTHE3_CHANNEL_TXSYNCALLIN(0),
      TXSYNCDONE => txsyncdone_out(1),
      TXSYNCIN => gtrxreset_out_reg_0(0),
      TXSYNCMODE => '0',
      TXSYNCOUT => txsyncout_out(1),
      TXSYSCLKSEL(1 downto 0) => txsysclksel_in(3 downto 2),
      TXUSERRDY => GTHE3_CHANNEL_TXUSERRDY(0),
      TXUSRCLK => txusrclk_in(1),
      TXUSRCLK2 => txusrclk2_in(1)
    );
\gthe3_channel_gen.gen_gthe3_channel_inst[2].GTHE3_CHANNEL_PRIM_INST\: unisim.vcomponents.GTHE3_CHANNEL
    generic map(
      ACJTAG_DEBUG_MODE => '0',
      ACJTAG_MODE => '0',
      ACJTAG_RESET => '0',
      ADAPT_CFG0 => X"F800",
      ADAPT_CFG1 => X"0000",
      ALIGN_COMMA_DOUBLE => "FALSE",
      ALIGN_COMMA_ENABLE => B"1111111111",
      ALIGN_COMMA_WORD => 1,
      ALIGN_MCOMMA_DET => "TRUE",
      ALIGN_MCOMMA_VALUE => B"1010000011",
      ALIGN_PCOMMA_DET => "TRUE",
      ALIGN_PCOMMA_VALUE => B"0101111100",
      A_RXOSCALRESET => '0',
      A_RXPROGDIVRESET => '0',
      A_TXPROGDIVRESET => '0',
      CBCC_DATA_SOURCE_SEL => "DECODED",
      CDR_SWAP_MODE_EN => '0',
      CHAN_BOND_KEEP_ALIGN => "FALSE",
      CHAN_BOND_MAX_SKEW => 1,
      CHAN_BOND_SEQ_1_1 => B"0000000000",
      CHAN_BOND_SEQ_1_2 => B"0000000000",
      CHAN_BOND_SEQ_1_3 => B"0000000000",
      CHAN_BOND_SEQ_1_4 => B"0000000000",
      CHAN_BOND_SEQ_1_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_1 => B"0000000000",
      CHAN_BOND_SEQ_2_2 => B"0000000000",
      CHAN_BOND_SEQ_2_3 => B"0000000000",
      CHAN_BOND_SEQ_2_4 => B"0000000000",
      CHAN_BOND_SEQ_2_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_USE => "FALSE",
      CHAN_BOND_SEQ_LEN => 1,
      CLK_CORRECT_USE => "FALSE",
      CLK_COR_KEEP_IDLE => "FALSE",
      CLK_COR_MAX_LAT => 12,
      CLK_COR_MIN_LAT => 8,
      CLK_COR_PRECEDENCE => "TRUE",
      CLK_COR_REPEAT_WAIT => 0,
      CLK_COR_SEQ_1_1 => B"0100000000",
      CLK_COR_SEQ_1_2 => B"0100000000",
      CLK_COR_SEQ_1_3 => B"0100000000",
      CLK_COR_SEQ_1_4 => B"0100000000",
      CLK_COR_SEQ_1_ENABLE => B"1111",
      CLK_COR_SEQ_2_1 => B"0100000000",
      CLK_COR_SEQ_2_2 => B"0100000000",
      CLK_COR_SEQ_2_3 => B"0100000000",
      CLK_COR_SEQ_2_4 => B"0100000000",
      CLK_COR_SEQ_2_ENABLE => B"1111",
      CLK_COR_SEQ_2_USE => "FALSE",
      CLK_COR_SEQ_LEN => 1,
      CPLL_CFG0 => X"23FC",
      CPLL_CFG1 => X"A4AC",
      CPLL_CFG2 => X"0004",
      CPLL_CFG3 => B"00" & X"0",
      CPLL_FBDIV => 5,
      CPLL_FBDIV_45 => 4,
      CPLL_INIT_CFG0 => X"02B2",
      CPLL_INIT_CFG1 => X"00",
      CPLL_LOCK_CFG => X"01E8",
      CPLL_REFCLK_DIV => 1,
      DDI_CTRL => B"00",
      DDI_REALIGN_WAIT => 15,
      DEC_MCOMMA_DETECT => "TRUE",
      DEC_PCOMMA_DETECT => "TRUE",
      DEC_VALID_COMMA_ONLY => "FALSE",
      DFE_D_X_REL_POS => '0',
      DFE_VCM_COMP_EN => '0',
      DMONITOR_CFG0 => B"00" & X"00",
      DMONITOR_CFG1 => X"00",
      ES_CLK_PHASE_SEL => '0',
      ES_CONTROL => B"000000",
      ES_ERRDET_EN => "FALSE",
      ES_EYE_SCAN_EN => "FALSE",
      ES_HORZ_OFFSET => X"000",
      ES_PMA_CFG => B"0000000000",
      ES_PRESCALE => B"00000",
      ES_QUALIFIER0 => X"0000",
      ES_QUALIFIER1 => X"0000",
      ES_QUALIFIER2 => X"0000",
      ES_QUALIFIER3 => X"0000",
      ES_QUALIFIER4 => X"0000",
      ES_QUAL_MASK0 => X"0000",
      ES_QUAL_MASK1 => X"0000",
      ES_QUAL_MASK2 => X"0000",
      ES_QUAL_MASK3 => X"0000",
      ES_QUAL_MASK4 => X"0000",
      ES_SDATA_MASK0 => X"0000",
      ES_SDATA_MASK1 => X"0000",
      ES_SDATA_MASK2 => X"0000",
      ES_SDATA_MASK3 => X"0000",
      ES_SDATA_MASK4 => X"0000",
      EVODD_PHI_CFG => B"00000000000",
      EYE_SCAN_SWAP_EN => '0',
      FTS_DESKEW_SEQ_ENABLE => B"1111",
      FTS_LANE_DESKEW_CFG => B"1111",
      FTS_LANE_DESKEW_EN => "FALSE",
      GEARBOX_MODE => B"00000",
      GM_BIAS_SELECT => '0',
      LOCAL_MASTER => '1',
      OOBDIVCTL => B"00",
      OOB_PWRUP => '0',
      PCI3_AUTO_REALIGN => "OVR_1K_BLK",
      PCI3_PIPE_RX_ELECIDLE => '0',
      PCI3_RX_ASYNC_EBUF_BYPASS => B"00",
      PCI3_RX_ELECIDLE_EI2_ENABLE => '0',
      PCI3_RX_ELECIDLE_H2L_COUNT => B"000000",
      PCI3_RX_ELECIDLE_H2L_DISABLE => B"000",
      PCI3_RX_ELECIDLE_HI_COUNT => B"000000",
      PCI3_RX_ELECIDLE_LP4_DISABLE => '0',
      PCI3_RX_FIFO_DISABLE => '0',
      PCIE_BUFG_DIV_CTRL => X"1000",
      PCIE_RXPCS_CFG_GEN3 => X"02A4",
      PCIE_RXPMA_CFG => X"000A",
      PCIE_TXPCS_CFG_GEN3 => X"2CA4",
      PCIE_TXPMA_CFG => X"000A",
      PCS_PCIE_EN => "FALSE",
      PCS_RSVD0 => B"0000000000000000",
      PCS_RSVD1 => B"000",
      PD_TRANS_TIME_FROM_P2 => X"03C",
      PD_TRANS_TIME_NONE_P2 => X"19",
      PD_TRANS_TIME_TO_P2 => X"64",
      PLL_SEL_MODE_GEN12 => B"11",
      PLL_SEL_MODE_GEN3 => B"11",
      PMA_RSV1 => X"E000",
      PROCESS_PAR => B"010",
      RATE_SW_USE_DRP => '1',
      RESET_POWERSAVE_DISABLE => '0',
      RXBUFRESET_TIME => B"00011",
      RXBUF_ADDR_MODE => "FAST",
      RXBUF_EIDLE_HI_CNT => B"1000",
      RXBUF_EIDLE_LO_CNT => B"0000",
      RXBUF_EN => "TRUE",
      RXBUF_RESET_ON_CB_CHANGE => "TRUE",
      RXBUF_RESET_ON_COMMAALIGN => "TRUE",
      RXBUF_RESET_ON_EIDLE => "FALSE",
      RXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      RXBUF_THRESH_OVFLW => 57,
      RXBUF_THRESH_OVRD => "TRUE",
      RXBUF_THRESH_UNDFLW => 3,
      RXCDRFREQRESET_TIME => B"00001",
      RXCDRPHRESET_TIME => B"00001",
      RXCDR_CFG0 => X"0000",
      RXCDR_CFG0_GEN3 => X"0000",
      RXCDR_CFG1 => X"0000",
      RXCDR_CFG1_GEN3 => X"0000",
      RXCDR_CFG2 => X"0766",
      RXCDR_CFG2_GEN3 => X"07E6",
      RXCDR_CFG3 => X"0000",
      RXCDR_CFG3_GEN3 => X"0000",
      RXCDR_CFG4 => X"0000",
      RXCDR_CFG4_GEN3 => X"0000",
      RXCDR_CFG5 => X"0000",
      RXCDR_CFG5_GEN3 => X"0000",
      RXCDR_FR_RESET_ON_EIDLE => '0',
      RXCDR_HOLD_DURING_EIDLE => '0',
      RXCDR_LOCK_CFG0 => X"4480",
      RXCDR_LOCK_CFG1 => X"5FFF",
      RXCDR_LOCK_CFG2 => X"77C3",
      RXCDR_PH_RESET_ON_EIDLE => '0',
      RXCFOK_CFG0 => X"4000",
      RXCFOK_CFG1 => X"0065",
      RXCFOK_CFG2 => X"002E",
      RXDFELPMRESET_TIME => B"0001111",
      RXDFELPM_KL_CFG0 => X"0000",
      RXDFELPM_KL_CFG1 => X"0032",
      RXDFELPM_KL_CFG2 => X"0000",
      RXDFE_CFG0 => X"0A00",
      RXDFE_CFG1 => X"0000",
      RXDFE_GC_CFG0 => X"0000",
      RXDFE_GC_CFG1 => X"7860",
      RXDFE_GC_CFG2 => X"0000",
      RXDFE_H2_CFG0 => X"0000",
      RXDFE_H2_CFG1 => X"0000",
      RXDFE_H3_CFG0 => X"4000",
      RXDFE_H3_CFG1 => X"0000",
      RXDFE_H4_CFG0 => X"2000",
      RXDFE_H4_CFG1 => X"0003",
      RXDFE_H5_CFG0 => X"2000",
      RXDFE_H5_CFG1 => X"0003",
      RXDFE_H6_CFG0 => X"2000",
      RXDFE_H6_CFG1 => X"0000",
      RXDFE_H7_CFG0 => X"2000",
      RXDFE_H7_CFG1 => X"0000",
      RXDFE_H8_CFG0 => X"2000",
      RXDFE_H8_CFG1 => X"0000",
      RXDFE_H9_CFG0 => X"2000",
      RXDFE_H9_CFG1 => X"0000",
      RXDFE_HA_CFG0 => X"2000",
      RXDFE_HA_CFG1 => X"0000",
      RXDFE_HB_CFG0 => X"2000",
      RXDFE_HB_CFG1 => X"0000",
      RXDFE_HC_CFG0 => X"0000",
      RXDFE_HC_CFG1 => X"0000",
      RXDFE_HD_CFG0 => X"0000",
      RXDFE_HD_CFG1 => X"0000",
      RXDFE_HE_CFG0 => X"0000",
      RXDFE_HE_CFG1 => X"0000",
      RXDFE_HF_CFG0 => X"0000",
      RXDFE_HF_CFG1 => X"0000",
      RXDFE_OS_CFG0 => X"8000",
      RXDFE_OS_CFG1 => X"0000",
      RXDFE_UT_CFG0 => X"8000",
      RXDFE_UT_CFG1 => X"0003",
      RXDFE_VP_CFG0 => X"AA00",
      RXDFE_VP_CFG1 => X"0033",
      RXDLY_CFG => X"001F",
      RXDLY_LCFG => X"0030",
      RXELECIDLE_CFG => "Sigcfg_4",
      RXGBOX_FIFO_INIT_RD_ADDR => 4,
      RXGEARBOX_EN => "FALSE",
      RXISCANRESET_TIME => B"00001",
      RXLPM_CFG => X"0000",
      RXLPM_GC_CFG => X"1000",
      RXLPM_KH_CFG0 => X"0000",
      RXLPM_KH_CFG1 => X"0002",
      RXLPM_OS_CFG0 => X"8000",
      RXLPM_OS_CFG1 => X"0002",
      RXOOB_CFG => B"000000110",
      RXOOB_CLK_CFG => "PMA",
      RXOSCALRESET_TIME => B"00011",
      RXOUT_DIV => 1,
      RXPCSRESET_TIME => B"00011",
      RXPHBEACON_CFG => X"0000",
      RXPHDLY_CFG => X"2020",
      RXPHSAMP_CFG => X"2100",
      RXPHSLIP_CFG => X"6622",
      RXPH_MONITOR_SEL => B"00000",
      RXPI_CFG0 => B"01",
      RXPI_CFG1 => B"01",
      RXPI_CFG2 => B"01",
      RXPI_CFG3 => B"01",
      RXPI_CFG4 => '0',
      RXPI_CFG5 => '0',
      RXPI_CFG6 => B"000",
      RXPI_LPM => '0',
      RXPI_VREFSEL => '0',
      RXPMACLK_SEL => "DATA",
      RXPMARESET_TIME => B"00011",
      RXPRBS_ERR_LOOPBACK => '0',
      RXPRBS_LINKACQ_CNT => 15,
      RXSLIDE_AUTO_WAIT => 7,
      RXSLIDE_MODE => "OFF",
      RXSYNC_MULTILANE => '1',
      RXSYNC_OVRD => '0',
      RXSYNC_SKIP_DA => '0',
      RX_AFE_CM_EN => '0',
      RX_BIAS_CFG0 => X"0AB4",
      RX_BUFFER_CFG => B"000000",
      RX_CAPFF_SARC_ENB => '0',
      RX_CLK25_DIV => 13,
      RX_CLKMUX_EN => '1',
      RX_CLK_SLIP_OVRD => B"00000",
      RX_CM_BUF_CFG => B"1010",
      RX_CM_BUF_PD => '0',
      RX_CM_SEL => B"11",
      RX_CM_TRIM => B"1010",
      RX_CTLE3_LPF => B"00000001",
      RX_DATA_WIDTH => 40,
      RX_DDI_SEL => B"000000",
      RX_DEFER_RESET_BUF_EN => "TRUE",
      RX_DFELPM_CFG0 => B"0110",
      RX_DFELPM_CFG1 => '1',
      RX_DFELPM_KLKH_AGC_STUP_EN => '1',
      RX_DFE_AGC_CFG0 => B"10",
      RX_DFE_AGC_CFG1 => B"000",
      RX_DFE_KL_LPM_KH_CFG0 => B"01",
      RX_DFE_KL_LPM_KH_CFG1 => B"000",
      RX_DFE_KL_LPM_KL_CFG0 => B"01",
      RX_DFE_KL_LPM_KL_CFG1 => B"000",
      RX_DFE_LPM_HOLD_DURING_EIDLE => '0',
      RX_DISPERR_SEQ_MATCH => "TRUE",
      RX_DIVRESET_TIME => B"00001",
      RX_EN_HI_LR => '1',
      RX_EYESCAN_VS_CODE => B"0000000",
      RX_EYESCAN_VS_NEG_DIR => '0',
      RX_EYESCAN_VS_RANGE => B"00",
      RX_EYESCAN_VS_UT_SIGN => '0',
      RX_FABINT_USRCLK_FLOP => '0',
      RX_INT_DATAWIDTH => 1,
      RX_PMA_POWER_SAVE => '0',
      RX_PROGDIV_CFG => 0.000000,
      RX_SAMPLE_PERIOD => B"111",
      RX_SIG_VALID_DLY => 11,
      RX_SUM_DFETAPREP_EN => '0',
      RX_SUM_IREF_TUNE => B"1100",
      RX_SUM_RES_CTRL => B"11",
      RX_SUM_VCMTUNE => B"0000",
      RX_SUM_VCM_OVWR => '0',
      RX_SUM_VREF_TUNE => B"000",
      RX_TUNE_AFE_OS => B"10",
      RX_WIDEMODE_CDR => '1',
      RX_XCLK_SEL => "RXDES",
      SAS_MAX_COM => 64,
      SAS_MIN_COM => 36,
      SATA_BURST_SEQ_LEN => B"1110",
      SATA_BURST_VAL => B"100",
      SATA_CPLL_CFG => "VCO_3000MHZ",
      SATA_EIDLE_VAL => B"100",
      SATA_MAX_BURST => 8,
      SATA_MAX_INIT => 21,
      SATA_MAX_WAKE => 7,
      SATA_MIN_BURST => 4,
      SATA_MIN_INIT => 12,
      SATA_MIN_WAKE => 4,
      SHOW_REALIGN_COMMA => "FALSE",
      SIM_MODE => "FAST",
      SIM_RECEIVER_DETECT_PASS => "TRUE",
      SIM_RESET_SPEEDUP => "TRUE",
      SIM_TX_EIDLE_DRIVE_LEVEL => '0',
      SIM_VERSION => 2,
      TAPDLY_SET_TX => B"00",
      TEMPERATUR_PAR => B"0010",
      TERM_RCAL_CFG => B"100001000010000",
      TERM_RCAL_OVRD => B"000",
      TRANS_TIME_RATE => X"0E",
      TST_RSV0 => X"00",
      TST_RSV1 => X"00",
      TXBUF_EN => "FALSE",
      TXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      TXDLY_CFG => X"0009",
      TXDLY_LCFG => X"0050",
      TXDRVBIAS_N => B"1010",
      TXDRVBIAS_P => B"1010",
      TXFIFO_ADDR_CFG => "LOW",
      TXGBOX_FIFO_INIT_RD_ADDR => 4,
      TXGEARBOX_EN => "FALSE",
      TXOUT_DIV => 1,
      TXPCSRESET_TIME => B"00011",
      TXPHDLY_CFG0 => X"2020",
      TXPHDLY_CFG1 => X"0075",
      TXPH_CFG => X"0980",
      TXPH_MONITOR_SEL => B"00000",
      TXPI_CFG0 => B"01",
      TXPI_CFG1 => B"01",
      TXPI_CFG2 => B"01",
      TXPI_CFG3 => '0',
      TXPI_CFG4 => '0',
      TXPI_CFG5 => B"000",
      TXPI_GRAY_SEL => '0',
      TXPI_INVSTROBE_SEL => '0',
      TXPI_LPM => '0',
      TXPI_PPMCLK_SEL => "TXUSRCLK2",
      TXPI_PPM_CFG => B"00000000",
      TXPI_SYNFREQ_PPM => B"001",
      TXPI_VREFSEL => '0',
      TXPMARESET_TIME => B"00011",
      TXSYNC_MULTILANE => '1',
      TXSYNC_OVRD => '0',
      TXSYNC_SKIP_DA => '0',
      TX_CLK25_DIV => 13,
      TX_CLKMUX_EN => '1',
      TX_DATA_WIDTH => 40,
      TX_DCD_CFG => B"000010",
      TX_DCD_EN => '0',
      TX_DEEMPH0 => B"000000",
      TX_DEEMPH1 => B"000000",
      TX_DIVRESET_TIME => B"00001",
      TX_DRIVE_MODE => "DIRECT",
      TX_EIDLE_ASSERT_DELAY => B"100",
      TX_EIDLE_DEASSERT_DELAY => B"011",
      TX_EML_PHI_TUNE => '0',
      TX_FABINT_USRCLK_FLOP => '0',
      TX_IDLE_DATA_ZERO => '0',
      TX_INT_DATAWIDTH => 1,
      TX_LOOPBACK_DRIVE_HIZ => "FALSE",
      TX_MAINCURSOR_SEL => '0',
      TX_MARGIN_FULL_0 => B"1001111",
      TX_MARGIN_FULL_1 => B"1001110",
      TX_MARGIN_FULL_2 => B"1001100",
      TX_MARGIN_FULL_3 => B"1001010",
      TX_MARGIN_FULL_4 => B"1001000",
      TX_MARGIN_LOW_0 => B"1000110",
      TX_MARGIN_LOW_1 => B"1000101",
      TX_MARGIN_LOW_2 => B"1000011",
      TX_MARGIN_LOW_3 => B"1000010",
      TX_MARGIN_LOW_4 => B"1000000",
      TX_MODE_SEL => B"000",
      TX_PMADATA_OPT => '0',
      TX_PMA_POWER_SAVE => '0',
      TX_PROGCLK_SEL => "PREPI",
      TX_PROGDIV_CFG => 20.000000,
      TX_QPI_STATUS_EN => '0',
      TX_RXDETECT_CFG => B"00" & X"032",
      TX_RXDETECT_REF => B"100",
      TX_SAMPLE_PERIOD => B"111",
      TX_SARC_LPBK_ENB => '0',
      TX_XCLK_SEL => "TXUSR",
      USE_PCS_CLK_PHASE_SEL => '0',
      WB_MODE => B"00"
    )
        port map (
      BUFGTCE(2 downto 0) => bufgtce_out(8 downto 6),
      BUFGTCEMASK(2 downto 0) => bufgtcemask_out(8 downto 6),
      BUFGTDIV(8 downto 0) => bufgtdiv_out(26 downto 18),
      BUFGTRESET(2 downto 0) => bufgtreset_out(8 downto 6),
      BUFGTRSTMASK(2 downto 0) => bufgtrstmask_out(8 downto 6),
      CFGRESET => cfgreset_in(2),
      CLKRSVD0 => clkrsvd0_in(2),
      CLKRSVD1 => clkrsvd1_in(2),
      CPLLFBCLKLOST => cpllfbclklost_out(2),
      CPLLLOCK => \^cplllock_out\(2),
      CPLLLOCKDETCLK => cplllockdetclk_in(2),
      CPLLLOCKEN => cplllocken_in(2),
      CPLLPD => GTHE3_CHANNEL_CPLLPD(0),
      CPLLREFCLKLOST => cpllrefclklost_out(2),
      CPLLREFCLKSEL(2 downto 0) => cpllrefclksel_in(8 downto 6),
      CPLLRESET => cpllreset_in(2),
      DMONFIFORESET => dmonfiforeset_in(2),
      DMONITORCLK => dmonitorclk_in(2),
      DMONITOROUT(16 downto 0) => dmonitorout_out(50 downto 34),
      DRPADDR(8 downto 0) => drpaddr_in(26 downto 18),
      DRPCLK => drpclk_in(2),
      DRPDI(15 downto 0) => drpdi_in(47 downto 32),
      DRPDO(15 downto 0) => drpdo_out(47 downto 32),
      DRPEN => drpen_in(2),
      DRPRDY => drprdy_out(2),
      DRPWE => drpwe_in(2),
      EVODDPHICALDONE => evoddphicaldone_in(2),
      EVODDPHICALSTART => evoddphicalstart_in(2),
      EVODDPHIDRDEN => evoddphidrden_in(2),
      EVODDPHIDWREN => evoddphidwren_in(2),
      EVODDPHIXRDEN => evoddphixrden_in(2),
      EVODDPHIXWREN => evoddphixwren_in(2),
      EYESCANDATAERROR => eyescandataerror_out(2),
      EYESCANMODE => eyescanmode_in(2),
      EYESCANRESET => eyescanreset_in(2),
      EYESCANTRIGGER => eyescantrigger_in(2),
      GTGREFCLK => gtgrefclk_in(2),
      GTHRXN => gthrxn_in(2),
      GTHRXP => gthrxp_in(2),
      GTHTXN => gthtxn_out(2),
      GTHTXP => gthtxp_out(2),
      GTNORTHREFCLK0 => gtnorthrefclk0_in(2),
      GTNORTHREFCLK1 => gtnorthrefclk1_in(2),
      GTPOWERGOOD => gtpowergood_out(2),
      GTREFCLK0 => gtrefclk0_in(2),
      GTREFCLK1 => gtrefclk1_in(2),
      GTREFCLKMONITOR => gtrefclkmonitor_out(2),
      GTRESETSEL => gtresetsel_in(2),
      GTRSVD(15 downto 0) => gtrsvd_in(47 downto 32),
      GTRXRESET => GTHE3_CHANNEL_GTRXRESET(0),
      GTSOUTHREFCLK0 => gtsouthrefclk0_in(2),
      GTSOUTHREFCLK1 => gtsouthrefclk1_in(2),
      GTTXRESET => GTHE3_CHANNEL_GTTXRESET(0),
      LOOPBACK(2 downto 0) => loopback_in(8 downto 6),
      LPBKRXTXSEREN => lpbkrxtxseren_in(2),
      LPBKTXRXSEREN => lpbktxrxseren_in(2),
      PCIEEQRXEQADAPTDONE => pcieeqrxeqadaptdone_in(2),
      PCIERATEGEN3 => pcierategen3_out(2),
      PCIERATEIDLE => pcierateidle_out(2),
      PCIERATEQPLLPD(1 downto 0) => pcierateqpllpd_out(5 downto 4),
      PCIERATEQPLLRESET(1 downto 0) => pcierateqpllreset_out(5 downto 4),
      PCIERSTIDLE => pcierstidle_in(2),
      PCIERSTTXSYNCSTART => pciersttxsyncstart_in(2),
      PCIESYNCTXSYNCDONE => pciesynctxsyncdone_out(2),
      PCIEUSERGEN3RDY => pcieusergen3rdy_out(2),
      PCIEUSERPHYSTATUSRST => pcieuserphystatusrst_out(2),
      PCIEUSERRATEDONE => pcieuserratedone_in(2),
      PCIEUSERRATESTART => pcieuserratestart_out(2),
      PCSRSVDIN(15 downto 0) => pcsrsvdin_in(47 downto 32),
      PCSRSVDIN2(4 downto 0) => pcsrsvdin2_in(14 downto 10),
      PCSRSVDOUT(11 downto 0) => pcsrsvdout_out(35 downto 24),
      PHYSTATUS => phystatus_out(2),
      PINRSRVDAS(7 downto 0) => pinrsrvdas_out(23 downto 16),
      PMARSVDIN(4 downto 0) => pmarsvdin_in(14 downto 10),
      QPLL0CLK => qpll0clk_in(2),
      QPLL0REFCLK => qpll0refclk_in(2),
      QPLL1CLK => qpll1clk_in(2),
      QPLL1REFCLK => qpll1refclk_in(2),
      RESETEXCEPTION => resetexception_out(2),
      RESETOVRD => resetovrd_in(2),
      RSTCLKENTX => rstclkentx_in(2),
      RX8B10BEN => rx8b10ben_in(2),
      RXBUFRESET => rxbufreset_in(2),
      RXBUFSTATUS(2 downto 0) => rxbufstatus_out(8 downto 6),
      RXBYTEISALIGNED => rxbyteisaligned_out(2),
      RXBYTEREALIGN => rxbyterealign_out(2),
      RXCDRFREQRESET => rxcdrfreqreset_in(2),
      RXCDRHOLD => rxcdrhold_in(2),
      RXCDRLOCK => rxcdrlock_out(2),
      RXCDROVRDEN => rxcdrovrden_in(2),
      RXCDRPHDONE => rxcdrphdone_out(2),
      RXCDRRESET => rxcdrreset_in(2),
      RXCDRRESETRSV => rxcdrresetrsv_in(2),
      RXCHANBONDSEQ => rxchanbondseq_out(2),
      RXCHANISALIGNED => rxchanisaligned_out(2),
      RXCHANREALIGN => rxchanrealign_out(2),
      RXCHBONDEN => rxchbonden_in(2),
      RXCHBONDI(4 downto 0) => rxchbondi_in(14 downto 10),
      RXCHBONDLEVEL(2 downto 0) => rxchbondlevel_in(8 downto 6),
      RXCHBONDMASTER => rxchbondmaster_in(2),
      RXCHBONDO(4 downto 0) => rxchbondo_out(14 downto 10),
      RXCHBONDSLAVE => rxchbondslave_in(2),
      RXCLKCORCNT(1 downto 0) => rxclkcorcnt_out(5 downto 4),
      RXCOMINITDET => rxcominitdet_out(2),
      RXCOMMADET => rxcommadet_out(2),
      RXCOMMADETEN => rxcommadeten_in(2),
      RXCOMSASDET => rxcomsasdet_out(2),
      RXCOMWAKEDET => rxcomwakedet_out(2),
      RXCTRL0(15 downto 0) => rxctrl0_out(47 downto 32),
      RXCTRL1(15 downto 0) => rxctrl1_out(47 downto 32),
      RXCTRL2(7 downto 0) => rxctrl2_out(23 downto 16),
      RXCTRL3(7 downto 0) => rxctrl3_out(23 downto 16),
      RXDATA(127 downto 0) => rxdata_out(383 downto 256),
      RXDATAEXTENDRSVD(7 downto 0) => rxdataextendrsvd_out(23 downto 16),
      RXDATAVALID(1 downto 0) => rxdatavalid_out(5 downto 4),
      RXDFEAGCCTRL(1 downto 0) => rxdfeagcctrl_in(5 downto 4),
      RXDFEAGCHOLD => rxdfeagchold_in(2),
      RXDFEAGCOVRDEN => rxdfeagcovrden_in(2),
      RXDFELFHOLD => rxdfelfhold_in(2),
      RXDFELFOVRDEN => rxdfelfovrden_in(2),
      RXDFELPMRESET => rxdfelpmreset_in(2),
      RXDFETAP10HOLD => rxdfetap10hold_in(2),
      RXDFETAP10OVRDEN => rxdfetap10ovrden_in(2),
      RXDFETAP11HOLD => rxdfetap11hold_in(2),
      RXDFETAP11OVRDEN => rxdfetap11ovrden_in(2),
      RXDFETAP12HOLD => rxdfetap12hold_in(2),
      RXDFETAP12OVRDEN => rxdfetap12ovrden_in(2),
      RXDFETAP13HOLD => rxdfetap13hold_in(2),
      RXDFETAP13OVRDEN => rxdfetap13ovrden_in(2),
      RXDFETAP14HOLD => rxdfetap14hold_in(2),
      RXDFETAP14OVRDEN => rxdfetap14ovrden_in(2),
      RXDFETAP15HOLD => rxdfetap15hold_in(2),
      RXDFETAP15OVRDEN => rxdfetap15ovrden_in(2),
      RXDFETAP2HOLD => rxdfetap2hold_in(2),
      RXDFETAP2OVRDEN => rxdfetap2ovrden_in(2),
      RXDFETAP3HOLD => rxdfetap3hold_in(2),
      RXDFETAP3OVRDEN => rxdfetap3ovrden_in(2),
      RXDFETAP4HOLD => rxdfetap4hold_in(2),
      RXDFETAP4OVRDEN => rxdfetap4ovrden_in(2),
      RXDFETAP5HOLD => rxdfetap5hold_in(2),
      RXDFETAP5OVRDEN => rxdfetap5ovrden_in(2),
      RXDFETAP6HOLD => rxdfetap6hold_in(2),
      RXDFETAP6OVRDEN => rxdfetap6ovrden_in(2),
      RXDFETAP7HOLD => rxdfetap7hold_in(2),
      RXDFETAP7OVRDEN => rxdfetap7ovrden_in(2),
      RXDFETAP8HOLD => rxdfetap8hold_in(2),
      RXDFETAP8OVRDEN => rxdfetap8ovrden_in(2),
      RXDFETAP9HOLD => rxdfetap9hold_in(2),
      RXDFETAP9OVRDEN => rxdfetap9ovrden_in(2),
      RXDFEUTHOLD => rxdfeuthold_in(2),
      RXDFEUTOVRDEN => rxdfeutovrden_in(2),
      RXDFEVPHOLD => rxdfevphold_in(2),
      RXDFEVPOVRDEN => rxdfevpovrden_in(2),
      RXDFEVSEN => rxdfevsen_in(2),
      RXDFEXYDEN => rxdfexyden_in(2),
      RXDLYBYPASS => rxdlybypass_in(2),
      RXDLYEN => rxdlyen_in(2),
      RXDLYOVRDEN => rxdlyovrden_in(2),
      RXDLYSRESET => rxdlysreset_in(2),
      RXDLYSRESETDONE => rxdlysresetdone_out(2),
      RXELECIDLE => rxelecidle_out(2),
      RXELECIDLEMODE(1 downto 0) => rxelecidlemode_in(5 downto 4),
      RXGEARBOXSLIP => rxgearboxslip_in(2),
      RXHEADER(5 downto 0) => rxheader_out(17 downto 12),
      RXHEADERVALID(1 downto 0) => rxheadervalid_out(5 downto 4),
      RXLATCLK => rxlatclk_in(2),
      RXLPMEN => rxlpmen_in(2),
      RXLPMGCHOLD => rxlpmgchold_in(2),
      RXLPMGCOVRDEN => rxlpmgcovrden_in(2),
      RXLPMHFHOLD => rxlpmhfhold_in(2),
      RXLPMHFOVRDEN => rxlpmhfovrden_in(2),
      RXLPMLFHOLD => rxlpmlfhold_in(2),
      RXLPMLFKLOVRDEN => rxlpmlfklovrden_in(2),
      RXLPMOSHOLD => rxlpmoshold_in(2),
      RXLPMOSOVRDEN => rxlpmosovrden_in(2),
      RXMCOMMAALIGNEN => rxmcommaalignen_in(2),
      RXMONITOROUT(6 downto 0) => rxmonitorout_out(20 downto 14),
      RXMONITORSEL(1 downto 0) => rxmonitorsel_in(5 downto 4),
      RXOOBRESET => rxoobreset_in(2),
      RXOSCALRESET => rxoscalreset_in(2),
      RXOSHOLD => rxoshold_in(2),
      RXOSINTCFG(3 downto 0) => rxosintcfg_in(11 downto 8),
      RXOSINTDONE => rxosintdone_out(2),
      RXOSINTEN => rxosinten_in(2),
      RXOSINTHOLD => rxosinthold_in(2),
      RXOSINTOVRDEN => rxosintovrden_in(2),
      RXOSINTSTARTED => rxosintstarted_out(2),
      RXOSINTSTROBE => rxosintstrobe_in(2),
      RXOSINTSTROBEDONE => rxosintstrobedone_out(2),
      RXOSINTSTROBESTARTED => rxosintstrobestarted_out(2),
      RXOSINTTESTOVRDEN => rxosinttestovrden_in(2),
      RXOSOVRDEN => rxosovrden_in(2),
      RXOUTCLK => rxoutclk_out(2),
      RXOUTCLKFABRIC => rxoutclkfabric_out(2),
      RXOUTCLKPCS => rxoutclkpcs_out(2),
      RXOUTCLKSEL(2 downto 0) => rxoutclksel_in(8 downto 6),
      RXPCOMMAALIGNEN => rxpcommaalignen_in(2),
      RXPCSRESET => rxpcsreset_in(2),
      RXPD(1 downto 0) => rxpd_in(5 downto 4),
      RXPHALIGN => rxphalign_in(2),
      RXPHALIGNDONE => rxphaligndone_out(2),
      RXPHALIGNEN => rxphalignen_in(2),
      RXPHALIGNERR => rxphalignerr_out(2),
      RXPHDLYPD => rxphdlypd_in(2),
      RXPHDLYRESET => rxphdlyreset_in(2),
      RXPHOVRDEN => rxphovrden_in(2),
      RXPLLCLKSEL(1 downto 0) => rxpllclksel_in(5 downto 4),
      RXPMARESET => rxpmareset_in(2),
      RXPMARESETDONE => rxpmaresetdone_out(2),
      RXPOLARITY => rxpolarity_in(2),
      RXPRBSCNTRESET => rxprbscntreset_in(2),
      RXPRBSERR => rxprbserr_out(2),
      RXPRBSLOCKED => rxprbslocked_out(2),
      RXPRBSSEL(3 downto 0) => rxprbssel_in(11 downto 8),
      RXPRGDIVRESETDONE => rxprgdivresetdone_out(2),
      RXPROGDIVRESET => GTHE3_CHANNEL_RXPROGDIVRESET(0),
      RXQPIEN => rxqpien_in(2),
      RXQPISENN => rxqpisenn_out(2),
      RXQPISENP => rxqpisenp_out(2),
      RXRATE(2 downto 0) => rxrate_in(8 downto 6),
      RXRATEDONE => rxratedone_out(2),
      RXRATEMODE => rxratemode_in(2),
      RXRECCLKOUT => rxrecclkout_out(2),
      RXRESETDONE => rxresetdone_out(2),
      RXSLIDE => rxslide_in(2),
      RXSLIDERDY => rxsliderdy_out(2),
      RXSLIPDONE => rxslipdone_out(2),
      RXSLIPOUTCLK => rxslipoutclk_in(2),
      RXSLIPOUTCLKRDY => rxslipoutclkrdy_out(2),
      RXSLIPPMA => rxslippma_in(2),
      RXSLIPPMARDY => rxslippmardy_out(2),
      RXSTARTOFSEQ(1 downto 0) => rxstartofseq_out(5 downto 4),
      RXSTATUS(2 downto 0) => rxstatus_out(8 downto 6),
      RXSYNCALLIN => rxsyncallin_in(2),
      RXSYNCDONE => rxsyncdone_out(2),
      RXSYNCIN => rxsyncin_in(2),
      RXSYNCMODE => rxsyncmode_in(2),
      RXSYNCOUT => rxsyncout_out(2),
      RXSYSCLKSEL(1 downto 0) => rxsysclksel_in(5 downto 4),
      RXUSERRDY => GTHE3_CHANNEL_RXUSERRDY(0),
      RXUSRCLK => rxusrclk_in(2),
      RXUSRCLK2 => rxusrclk2_in(2),
      RXVALID => rxvalid_out(2),
      SIGVALIDCLK => sigvalidclk_in(2),
      TSTIN(19 downto 0) => B"00000000000000000000",
      TX8B10BBYPASS(7 downto 0) => tx8b10bbypass_in(23 downto 16),
      TX8B10BEN => tx8b10ben_in(2),
      TXBUFDIFFCTRL(2 downto 0) => txbufdiffctrl_in(8 downto 6),
      TXBUFSTATUS(1 downto 0) => txbufstatus_out(5 downto 4),
      TXCOMFINISH => txcomfinish_out(2),
      TXCOMINIT => txcominit_in(2),
      TXCOMSAS => txcomsas_in(2),
      TXCOMWAKE => txcomwake_in(2),
      TXCTRL0(15 downto 0) => txctrl0_in(47 downto 32),
      TXCTRL1(15 downto 0) => txctrl1_in(47 downto 32),
      TXCTRL2(7 downto 0) => txctrl2_in(23 downto 16),
      TXDATA(127 downto 32) => B"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      TXDATA(31 downto 0) => gtwiz_userdata_tx_in(95 downto 64),
      TXDATAEXTENDRSVD(7 downto 0) => txdataextendrsvd_in(23 downto 16),
      TXDEEMPH => txdeemph_in(2),
      TXDETECTRX => txdetectrx_in(2),
      TXDIFFCTRL(3 downto 0) => txdiffctrl_in(11 downto 8),
      TXDIFFPD => txdiffpd_in(2),
      TXDLYBYPASS => '0',
      TXDLYEN => '0',
      TXDLYHOLD => '0',
      TXDLYOVRDEN => '0',
      TXDLYSRESET => GTHE3_CHANNEL_TXDLYSRESET(0),
      TXDLYSRESETDONE => txdlysresetdone_out(2),
      TXDLYUPDOWN => '0',
      TXELECIDLE => txelecidle_in(2),
      TXHEADER(5 downto 0) => txheader_in(17 downto 12),
      TXINHIBIT => txinhibit_in(2),
      TXLATCLK => txlatclk_in(2),
      TXMAINCURSOR(6 downto 0) => txmaincursor_in(20 downto 14),
      TXMARGIN(2 downto 0) => txmargin_in(8 downto 6),
      TXOUTCLK => txoutclk_out(2),
      TXOUTCLKFABRIC => txoutclkfabric_out(2),
      TXOUTCLKPCS => txoutclkpcs_out(2),
      TXOUTCLKSEL(2 downto 0) => txoutclksel_in(8 downto 6),
      TXPCSRESET => txpcsreset_in(2),
      TXPD(1 downto 0) => txpd_in(5 downto 4),
      TXPDELECIDLEMODE => txpdelecidlemode_in(2),
      TXPHALIGN => '0',
      TXPHALIGNDONE => txphaligndone_out(2),
      TXPHALIGNEN => '0',
      TXPHDLYPD => '0',
      TXPHDLYRESET => '0',
      TXPHDLYTSTCLK => '0',
      TXPHINIT => '0',
      TXPHINITDONE => txphinitdone_out(2),
      TXPHOVRDEN => '0',
      TXPIPPMEN => txpippmen_in(2),
      TXPIPPMOVRDEN => txpippmovrden_in(2),
      TXPIPPMPD => txpippmpd_in(2),
      TXPIPPMSEL => txpippmsel_in(2),
      TXPIPPMSTEPSIZE(4 downto 0) => txpippmstepsize_in(14 downto 10),
      TXPISOPD => txpisopd_in(2),
      TXPLLCLKSEL(1 downto 0) => txpllclksel_in(5 downto 4),
      TXPMARESET => txpmareset_in(2),
      TXPMARESETDONE => txpmaresetdone_out(2),
      TXPOLARITY => txpolarity_in(2),
      TXPOSTCURSOR(4 downto 0) => txpostcursor_in(14 downto 10),
      TXPOSTCURSORINV => txpostcursorinv_in(2),
      TXPRBSFORCEERR => txprbsforceerr_in(2),
      TXPRBSSEL(3 downto 0) => txprbssel_in(11 downto 8),
      TXPRECURSOR(4 downto 0) => txprecursor_in(14 downto 10),
      TXPRECURSORINV => txprecursorinv_in(2),
      TXPRGDIVRESETDONE => txprgdivresetdone_out(2),
      TXPROGDIVRESET => GTHE3_CHANNEL_TXPROGDIVRESET(0),
      TXQPIBIASEN => txqpibiasen_in(2),
      TXQPISENN => txqpisenn_out(2),
      TXQPISENP => txqpisenp_out(2),
      TXQPISTRONGPDOWN => txqpistrongpdown_in(2),
      TXQPIWEAKPUP => txqpiweakpup_in(2),
      TXRATE(2 downto 0) => txrate_in(8 downto 6),
      TXRATEDONE => txratedone_out(2),
      TXRATEMODE => txratemode_in(2),
      TXRESETDONE => txresetdone_out(2),
      TXSEQUENCE(6 downto 0) => txsequence_in(20 downto 14),
      TXSWING => txswing_in(2),
      TXSYNCALLIN => GTHE3_CHANNEL_TXSYNCALLIN(0),
      TXSYNCDONE => txsyncdone_out(2),
      TXSYNCIN => gtrxreset_out_reg_0(0),
      TXSYNCMODE => '0',
      TXSYNCOUT => txsyncout_out(2),
      TXSYSCLKSEL(1 downto 0) => txsysclksel_in(5 downto 4),
      TXUSERRDY => GTHE3_CHANNEL_TXUSERRDY(0),
      TXUSRCLK => txusrclk_in(2),
      TXUSRCLK2 => txusrclk2_in(2)
    );
\i_in_inferred_i_2__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \^cplllock_out\(1),
      I1 => \^cplllock_out\(0),
      I2 => gtrxreset_out_reg(0),
      I3 => \^cplllock_out\(2),
      O => rst_in_out_reg
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gthe3_channel__parameterized0\ is
  port (
    rst_in0 : out STD_LOGIC;
    cplllock_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    in0 : out STD_LOGIC;
    cpllfbclklost_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    cpllrefclklost_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    drprdy_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    eyescandataerror_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gthtxn_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gthtxp_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gtpowergood_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gtrefclkmonitor_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcierategen3_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcierateidle_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pciesynctxsyncdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcieusergen3rdy_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcieuserphystatusrst_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcieuserratestart_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    phystatus_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    resetexception_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxbyteisaligned_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxbyterealign_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrlock_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrphdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxchanbondseq_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxchanisaligned_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxchanrealign_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcominitdet_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcommadet_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcomsasdet_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcomwakedet_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdlysresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxelecidle_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosintdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosintstarted_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosintstrobedone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosintstrobestarted_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxoutclk_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxoutclkfabric_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxoutclkpcs_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxphaligndone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxphalignerr_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxpmaresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxprbserr_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxprbslocked_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxprgdivresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxqpisenn_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxqpisenp_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxratedone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxrecclkout_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxsliderdy_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxslipdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxslipoutclkrdy_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxslippmardy_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxsyncdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxsyncout_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxvalid_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txcomfinish_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txdlysresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txoutclk_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txoutclkfabric_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txoutclkpcs_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txphaligndone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txphinitdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txpmaresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txprgdivresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txqpisenn_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txqpisenp_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txratedone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txsyncdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txsyncout_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcsrsvdout_out : out STD_LOGIC_VECTOR ( 47 downto 0 );
    rxdata_out : out STD_LOGIC_VECTOR ( 511 downto 0 );
    drpdo_out : out STD_LOGIC_VECTOR ( 63 downto 0 );
    rxctrl0_out : out STD_LOGIC_VECTOR ( 63 downto 0 );
    rxctrl1_out : out STD_LOGIC_VECTOR ( 63 downto 0 );
    dmonitorout_out : out STD_LOGIC_VECTOR ( 67 downto 0 );
    pcierateqpllpd_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    pcierateqpllreset_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rxclkcorcnt_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rxdatavalid_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rxheadervalid_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rxstartofseq_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    txbufstatus_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    bufgtce_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    bufgtcemask_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    bufgtreset_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    bufgtrstmask_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    rxbufstatus_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    rxstatus_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    rxchbondo_out : out STD_LOGIC_VECTOR ( 19 downto 0 );
    rxheader_out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    rxmonitorout_out : out STD_LOGIC_VECTOR ( 27 downto 0 );
    pinrsrvdas_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rxctrl2_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rxctrl3_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rxdataextendrsvd_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bufgtdiv_out : out STD_LOGIC_VECTOR ( 35 downto 0 );
    gtrxreset_out_reg : in STD_LOGIC;
    cfgreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    clkrsvd0_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    clkrsvd1_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    cplllockdetclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    cplllocken_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_CPLLPD : in STD_LOGIC_VECTOR ( 0 to 0 );
    cpllreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    dmonfiforeset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    dmonitorclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    drpclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    drpen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    drpwe_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    evoddphicaldone_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    evoddphicalstart_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    evoddphidrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    evoddphidwren_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    evoddphixrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    evoddphixwren_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eyescanmode_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eyescanreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eyescantrigger_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtgrefclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gthrxn_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gthrxp_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtnorthrefclk0_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtnorthrefclk1_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtrefclk0_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtrefclk1_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtresetsel_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_GTRXRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtsouthrefclk0_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtsouthrefclk1_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_GTTXRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    lpbkrxtxseren_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    lpbktxrxseren_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    pcieeqrxeqadaptdone_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    pcierstidle_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    pciersttxsyncstart_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    pcieuserratedone_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    qpll0clk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    qpll0refclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    qpll1clk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    qpll1refclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    resetovrd_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rstclkentx_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rx8b10ben_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxbufreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrfreqreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrhold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrresetrsv_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxchbonden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxchbondmaster_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxchbondslave_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcommadeten_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfeagchold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfeagcovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfelfhold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfelfovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfelpmreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap10hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap10ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap11hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap11ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap12hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap12ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap13hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap13ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap14hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap14ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap15hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap15ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap2hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap2ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap3hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap3ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap4hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap4ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap5hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap5ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap6hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap6ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap7hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap7ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap8hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap8ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap9hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap9ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfeuthold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfeutovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfevphold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfevpovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfevsen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfexyden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdlybypass_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdlyen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdlyovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdlysreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxgearboxslip_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlatclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmgchold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmgcovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmhfhold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmhfovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmlfhold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmlfklovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmoshold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmosovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxmcommaalignen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxoobreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxoscalreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxoshold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosinten_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosinthold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosintovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosintstrobe_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosinttestovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxpcommaalignen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxpcsreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxphalign_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxphalignen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxphdlypd_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxphdlyreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxphovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxpmareset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxpolarity_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxprbscntreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_RXPROGDIVRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxqpien_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxratemode_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxslide_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxslipoutclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxslippma_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxsyncallin_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxsyncin_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxsyncmode_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_RXUSERRDY : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxusrclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxusrclk2_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    sigvalidclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    tx8b10ben_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txcominit_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txcomsas_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txcomwake_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txdeemph_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txdetectrx_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txdiffpd_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_TXDLYSRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    txelecidle_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txinhibit_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txlatclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpcsreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpdelecidlemode_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpippmen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpippmovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpippmpd_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpippmsel_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpisopd_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpmareset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpolarity_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpostcursorinv_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txprbsforceerr_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txprecursorinv_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_TXPROGDIVRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    txqpibiasen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txqpistrongpdown_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txqpiweakpup_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txratemode_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txswing_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_TXSYNCALLIN : in STD_LOGIC_VECTOR ( 0 to 0 );
    GTHE3_CHANNEL_TXUSERRDY : in STD_LOGIC_VECTOR ( 0 to 0 );
    txusrclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txusrclk2_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtwiz_userdata_tx_in : in STD_LOGIC_VECTOR ( 127 downto 0 );
    drpdi_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    gtrsvd_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    pcsrsvdin_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    txctrl0_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    txctrl1_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    rxdfeagcctrl_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rxelecidlemode_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rxmonitorsel_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rxpd_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rxpllclksel_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rxsysclksel_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    txpd_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    txpllclksel_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    txsysclksel_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    cpllrefclksel_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    loopback_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    rxchbondlevel_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    rxoutclksel_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    rxrate_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    txbufdiffctrl_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    txmargin_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    txoutclksel_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    txrate_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    rxosintcfg_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    rxprbssel_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    txdiffctrl_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    txprbssel_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    pcsrsvdin2_in : in STD_LOGIC_VECTOR ( 19 downto 0 );
    pmarsvdin_in : in STD_LOGIC_VECTOR ( 19 downto 0 );
    rxchbondi_in : in STD_LOGIC_VECTOR ( 19 downto 0 );
    txpippmstepsize_in : in STD_LOGIC_VECTOR ( 19 downto 0 );
    txpostcursor_in : in STD_LOGIC_VECTOR ( 19 downto 0 );
    txprecursor_in : in STD_LOGIC_VECTOR ( 19 downto 0 );
    txheader_in : in STD_LOGIC_VECTOR ( 23 downto 0 );
    txmaincursor_in : in STD_LOGIC_VECTOR ( 27 downto 0 );
    txsequence_in : in STD_LOGIC_VECTOR ( 27 downto 0 );
    tx8b10bbypass_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    txctrl2_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    txdataextendrsvd_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    drpaddr_in : in STD_LOGIC_VECTOR ( 35 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gthe3_channel__parameterized0\ : entity is "gtwizard_ultrascale_v1_6_5_gthe3_channel";
end \JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gthe3_channel__parameterized0\;

architecture STRUCTURE of \JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gthe3_channel__parameterized0\ is
  signal \^cplllock_out\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^txsyncout_out\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \gthe3_channel_gen.gen_gthe3_channel_inst[0].GTHE3_CHANNEL_PRIM_INST\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \gthe3_channel_gen.gen_gthe3_channel_inst[1].GTHE3_CHANNEL_PRIM_INST\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \gthe3_channel_gen.gen_gthe3_channel_inst[2].GTHE3_CHANNEL_PRIM_INST\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \gthe3_channel_gen.gen_gthe3_channel_inst[3].GTHE3_CHANNEL_PRIM_INST\ : label is "PRIMITIVE";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \i_in_inferred_i_1__1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \rst_in_meta_i_1__4\ : label is "soft_lutpair0";
begin
  cplllock_out(3 downto 0) <= \^cplllock_out\(3 downto 0);
  txsyncout_out(3 downto 0) <= \^txsyncout_out\(3 downto 0);
\gthe3_channel_gen.gen_gthe3_channel_inst[0].GTHE3_CHANNEL_PRIM_INST\: unisim.vcomponents.GTHE3_CHANNEL
    generic map(
      ACJTAG_DEBUG_MODE => '0',
      ACJTAG_MODE => '0',
      ACJTAG_RESET => '0',
      ADAPT_CFG0 => X"F800",
      ADAPT_CFG1 => X"0000",
      ALIGN_COMMA_DOUBLE => "FALSE",
      ALIGN_COMMA_ENABLE => B"1111111111",
      ALIGN_COMMA_WORD => 1,
      ALIGN_MCOMMA_DET => "TRUE",
      ALIGN_MCOMMA_VALUE => B"1010000011",
      ALIGN_PCOMMA_DET => "TRUE",
      ALIGN_PCOMMA_VALUE => B"0101111100",
      A_RXOSCALRESET => '0',
      A_RXPROGDIVRESET => '0',
      A_TXPROGDIVRESET => '0',
      CBCC_DATA_SOURCE_SEL => "DECODED",
      CDR_SWAP_MODE_EN => '0',
      CHAN_BOND_KEEP_ALIGN => "FALSE",
      CHAN_BOND_MAX_SKEW => 1,
      CHAN_BOND_SEQ_1_1 => B"0000000000",
      CHAN_BOND_SEQ_1_2 => B"0000000000",
      CHAN_BOND_SEQ_1_3 => B"0000000000",
      CHAN_BOND_SEQ_1_4 => B"0000000000",
      CHAN_BOND_SEQ_1_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_1 => B"0000000000",
      CHAN_BOND_SEQ_2_2 => B"0000000000",
      CHAN_BOND_SEQ_2_3 => B"0000000000",
      CHAN_BOND_SEQ_2_4 => B"0000000000",
      CHAN_BOND_SEQ_2_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_USE => "FALSE",
      CHAN_BOND_SEQ_LEN => 1,
      CLK_CORRECT_USE => "FALSE",
      CLK_COR_KEEP_IDLE => "FALSE",
      CLK_COR_MAX_LAT => 12,
      CLK_COR_MIN_LAT => 8,
      CLK_COR_PRECEDENCE => "TRUE",
      CLK_COR_REPEAT_WAIT => 0,
      CLK_COR_SEQ_1_1 => B"0100000000",
      CLK_COR_SEQ_1_2 => B"0100000000",
      CLK_COR_SEQ_1_3 => B"0100000000",
      CLK_COR_SEQ_1_4 => B"0100000000",
      CLK_COR_SEQ_1_ENABLE => B"1111",
      CLK_COR_SEQ_2_1 => B"0100000000",
      CLK_COR_SEQ_2_2 => B"0100000000",
      CLK_COR_SEQ_2_3 => B"0100000000",
      CLK_COR_SEQ_2_4 => B"0100000000",
      CLK_COR_SEQ_2_ENABLE => B"1111",
      CLK_COR_SEQ_2_USE => "FALSE",
      CLK_COR_SEQ_LEN => 1,
      CPLL_CFG0 => X"23FC",
      CPLL_CFG1 => X"A4AC",
      CPLL_CFG2 => X"0004",
      CPLL_CFG3 => B"00" & X"0",
      CPLL_FBDIV => 5,
      CPLL_FBDIV_45 => 4,
      CPLL_INIT_CFG0 => X"02B2",
      CPLL_INIT_CFG1 => X"00",
      CPLL_LOCK_CFG => X"01E8",
      CPLL_REFCLK_DIV => 1,
      DDI_CTRL => B"00",
      DDI_REALIGN_WAIT => 15,
      DEC_MCOMMA_DETECT => "TRUE",
      DEC_PCOMMA_DETECT => "TRUE",
      DEC_VALID_COMMA_ONLY => "FALSE",
      DFE_D_X_REL_POS => '0',
      DFE_VCM_COMP_EN => '0',
      DMONITOR_CFG0 => B"00" & X"00",
      DMONITOR_CFG1 => X"00",
      ES_CLK_PHASE_SEL => '0',
      ES_CONTROL => B"000000",
      ES_ERRDET_EN => "FALSE",
      ES_EYE_SCAN_EN => "FALSE",
      ES_HORZ_OFFSET => X"000",
      ES_PMA_CFG => B"0000000000",
      ES_PRESCALE => B"00000",
      ES_QUALIFIER0 => X"0000",
      ES_QUALIFIER1 => X"0000",
      ES_QUALIFIER2 => X"0000",
      ES_QUALIFIER3 => X"0000",
      ES_QUALIFIER4 => X"0000",
      ES_QUAL_MASK0 => X"0000",
      ES_QUAL_MASK1 => X"0000",
      ES_QUAL_MASK2 => X"0000",
      ES_QUAL_MASK3 => X"0000",
      ES_QUAL_MASK4 => X"0000",
      ES_SDATA_MASK0 => X"0000",
      ES_SDATA_MASK1 => X"0000",
      ES_SDATA_MASK2 => X"0000",
      ES_SDATA_MASK3 => X"0000",
      ES_SDATA_MASK4 => X"0000",
      EVODD_PHI_CFG => B"00000000000",
      EYE_SCAN_SWAP_EN => '0',
      FTS_DESKEW_SEQ_ENABLE => B"1111",
      FTS_LANE_DESKEW_CFG => B"1111",
      FTS_LANE_DESKEW_EN => "FALSE",
      GEARBOX_MODE => B"00000",
      GM_BIAS_SELECT => '0',
      LOCAL_MASTER => '1',
      OOBDIVCTL => B"00",
      OOB_PWRUP => '0',
      PCI3_AUTO_REALIGN => "OVR_1K_BLK",
      PCI3_PIPE_RX_ELECIDLE => '0',
      PCI3_RX_ASYNC_EBUF_BYPASS => B"00",
      PCI3_RX_ELECIDLE_EI2_ENABLE => '0',
      PCI3_RX_ELECIDLE_H2L_COUNT => B"000000",
      PCI3_RX_ELECIDLE_H2L_DISABLE => B"000",
      PCI3_RX_ELECIDLE_HI_COUNT => B"000000",
      PCI3_RX_ELECIDLE_LP4_DISABLE => '0',
      PCI3_RX_FIFO_DISABLE => '0',
      PCIE_BUFG_DIV_CTRL => X"1000",
      PCIE_RXPCS_CFG_GEN3 => X"02A4",
      PCIE_RXPMA_CFG => X"000A",
      PCIE_TXPCS_CFG_GEN3 => X"2CA4",
      PCIE_TXPMA_CFG => X"000A",
      PCS_PCIE_EN => "FALSE",
      PCS_RSVD0 => B"0000000000000000",
      PCS_RSVD1 => B"000",
      PD_TRANS_TIME_FROM_P2 => X"03C",
      PD_TRANS_TIME_NONE_P2 => X"19",
      PD_TRANS_TIME_TO_P2 => X"64",
      PLL_SEL_MODE_GEN12 => B"11",
      PLL_SEL_MODE_GEN3 => B"11",
      PMA_RSV1 => X"E000",
      PROCESS_PAR => B"010",
      RATE_SW_USE_DRP => '1',
      RESET_POWERSAVE_DISABLE => '0',
      RXBUFRESET_TIME => B"00011",
      RXBUF_ADDR_MODE => "FAST",
      RXBUF_EIDLE_HI_CNT => B"1000",
      RXBUF_EIDLE_LO_CNT => B"0000",
      RXBUF_EN => "TRUE",
      RXBUF_RESET_ON_CB_CHANGE => "TRUE",
      RXBUF_RESET_ON_COMMAALIGN => "TRUE",
      RXBUF_RESET_ON_EIDLE => "FALSE",
      RXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      RXBUF_THRESH_OVFLW => 57,
      RXBUF_THRESH_OVRD => "TRUE",
      RXBUF_THRESH_UNDFLW => 3,
      RXCDRFREQRESET_TIME => B"00001",
      RXCDRPHRESET_TIME => B"00001",
      RXCDR_CFG0 => X"0000",
      RXCDR_CFG0_GEN3 => X"0000",
      RXCDR_CFG1 => X"0000",
      RXCDR_CFG1_GEN3 => X"0000",
      RXCDR_CFG2 => X"0766",
      RXCDR_CFG2_GEN3 => X"07E6",
      RXCDR_CFG3 => X"0000",
      RXCDR_CFG3_GEN3 => X"0000",
      RXCDR_CFG4 => X"0000",
      RXCDR_CFG4_GEN3 => X"0000",
      RXCDR_CFG5 => X"0000",
      RXCDR_CFG5_GEN3 => X"0000",
      RXCDR_FR_RESET_ON_EIDLE => '0',
      RXCDR_HOLD_DURING_EIDLE => '0',
      RXCDR_LOCK_CFG0 => X"4480",
      RXCDR_LOCK_CFG1 => X"5FFF",
      RXCDR_LOCK_CFG2 => X"77C3",
      RXCDR_PH_RESET_ON_EIDLE => '0',
      RXCFOK_CFG0 => X"4000",
      RXCFOK_CFG1 => X"0065",
      RXCFOK_CFG2 => X"002E",
      RXDFELPMRESET_TIME => B"0001111",
      RXDFELPM_KL_CFG0 => X"0000",
      RXDFELPM_KL_CFG1 => X"0032",
      RXDFELPM_KL_CFG2 => X"0000",
      RXDFE_CFG0 => X"0A00",
      RXDFE_CFG1 => X"0000",
      RXDFE_GC_CFG0 => X"0000",
      RXDFE_GC_CFG1 => X"7860",
      RXDFE_GC_CFG2 => X"0000",
      RXDFE_H2_CFG0 => X"0000",
      RXDFE_H2_CFG1 => X"0000",
      RXDFE_H3_CFG0 => X"4000",
      RXDFE_H3_CFG1 => X"0000",
      RXDFE_H4_CFG0 => X"2000",
      RXDFE_H4_CFG1 => X"0003",
      RXDFE_H5_CFG0 => X"2000",
      RXDFE_H5_CFG1 => X"0003",
      RXDFE_H6_CFG0 => X"2000",
      RXDFE_H6_CFG1 => X"0000",
      RXDFE_H7_CFG0 => X"2000",
      RXDFE_H7_CFG1 => X"0000",
      RXDFE_H8_CFG0 => X"2000",
      RXDFE_H8_CFG1 => X"0000",
      RXDFE_H9_CFG0 => X"2000",
      RXDFE_H9_CFG1 => X"0000",
      RXDFE_HA_CFG0 => X"2000",
      RXDFE_HA_CFG1 => X"0000",
      RXDFE_HB_CFG0 => X"2000",
      RXDFE_HB_CFG1 => X"0000",
      RXDFE_HC_CFG0 => X"0000",
      RXDFE_HC_CFG1 => X"0000",
      RXDFE_HD_CFG0 => X"0000",
      RXDFE_HD_CFG1 => X"0000",
      RXDFE_HE_CFG0 => X"0000",
      RXDFE_HE_CFG1 => X"0000",
      RXDFE_HF_CFG0 => X"0000",
      RXDFE_HF_CFG1 => X"0000",
      RXDFE_OS_CFG0 => X"8000",
      RXDFE_OS_CFG1 => X"0000",
      RXDFE_UT_CFG0 => X"8000",
      RXDFE_UT_CFG1 => X"0003",
      RXDFE_VP_CFG0 => X"AA00",
      RXDFE_VP_CFG1 => X"0033",
      RXDLY_CFG => X"001F",
      RXDLY_LCFG => X"0030",
      RXELECIDLE_CFG => "Sigcfg_4",
      RXGBOX_FIFO_INIT_RD_ADDR => 4,
      RXGEARBOX_EN => "FALSE",
      RXISCANRESET_TIME => B"00001",
      RXLPM_CFG => X"0000",
      RXLPM_GC_CFG => X"1000",
      RXLPM_KH_CFG0 => X"0000",
      RXLPM_KH_CFG1 => X"0002",
      RXLPM_OS_CFG0 => X"8000",
      RXLPM_OS_CFG1 => X"0002",
      RXOOB_CFG => B"000000110",
      RXOOB_CLK_CFG => "PMA",
      RXOSCALRESET_TIME => B"00011",
      RXOUT_DIV => 1,
      RXPCSRESET_TIME => B"00011",
      RXPHBEACON_CFG => X"0000",
      RXPHDLY_CFG => X"2020",
      RXPHSAMP_CFG => X"2100",
      RXPHSLIP_CFG => X"6622",
      RXPH_MONITOR_SEL => B"00000",
      RXPI_CFG0 => B"01",
      RXPI_CFG1 => B"01",
      RXPI_CFG2 => B"01",
      RXPI_CFG3 => B"01",
      RXPI_CFG4 => '0',
      RXPI_CFG5 => '0',
      RXPI_CFG6 => B"000",
      RXPI_LPM => '0',
      RXPI_VREFSEL => '0',
      RXPMACLK_SEL => "DATA",
      RXPMARESET_TIME => B"00011",
      RXPRBS_ERR_LOOPBACK => '0',
      RXPRBS_LINKACQ_CNT => 15,
      RXSLIDE_AUTO_WAIT => 7,
      RXSLIDE_MODE => "OFF",
      RXSYNC_MULTILANE => '1',
      RXSYNC_OVRD => '0',
      RXSYNC_SKIP_DA => '0',
      RX_AFE_CM_EN => '0',
      RX_BIAS_CFG0 => X"0AB4",
      RX_BUFFER_CFG => B"000000",
      RX_CAPFF_SARC_ENB => '0',
      RX_CLK25_DIV => 13,
      RX_CLKMUX_EN => '1',
      RX_CLK_SLIP_OVRD => B"00000",
      RX_CM_BUF_CFG => B"1010",
      RX_CM_BUF_PD => '0',
      RX_CM_SEL => B"11",
      RX_CM_TRIM => B"1010",
      RX_CTLE3_LPF => B"00000001",
      RX_DATA_WIDTH => 40,
      RX_DDI_SEL => B"000000",
      RX_DEFER_RESET_BUF_EN => "TRUE",
      RX_DFELPM_CFG0 => B"0110",
      RX_DFELPM_CFG1 => '1',
      RX_DFELPM_KLKH_AGC_STUP_EN => '1',
      RX_DFE_AGC_CFG0 => B"10",
      RX_DFE_AGC_CFG1 => B"000",
      RX_DFE_KL_LPM_KH_CFG0 => B"01",
      RX_DFE_KL_LPM_KH_CFG1 => B"000",
      RX_DFE_KL_LPM_KL_CFG0 => B"01",
      RX_DFE_KL_LPM_KL_CFG1 => B"000",
      RX_DFE_LPM_HOLD_DURING_EIDLE => '0',
      RX_DISPERR_SEQ_MATCH => "TRUE",
      RX_DIVRESET_TIME => B"00001",
      RX_EN_HI_LR => '1',
      RX_EYESCAN_VS_CODE => B"0000000",
      RX_EYESCAN_VS_NEG_DIR => '0',
      RX_EYESCAN_VS_RANGE => B"00",
      RX_EYESCAN_VS_UT_SIGN => '0',
      RX_FABINT_USRCLK_FLOP => '0',
      RX_INT_DATAWIDTH => 1,
      RX_PMA_POWER_SAVE => '0',
      RX_PROGDIV_CFG => 0.000000,
      RX_SAMPLE_PERIOD => B"111",
      RX_SIG_VALID_DLY => 11,
      RX_SUM_DFETAPREP_EN => '0',
      RX_SUM_IREF_TUNE => B"1100",
      RX_SUM_RES_CTRL => B"11",
      RX_SUM_VCMTUNE => B"0000",
      RX_SUM_VCM_OVWR => '0',
      RX_SUM_VREF_TUNE => B"000",
      RX_TUNE_AFE_OS => B"10",
      RX_WIDEMODE_CDR => '1',
      RX_XCLK_SEL => "RXDES",
      SAS_MAX_COM => 64,
      SAS_MIN_COM => 36,
      SATA_BURST_SEQ_LEN => B"1110",
      SATA_BURST_VAL => B"100",
      SATA_CPLL_CFG => "VCO_3000MHZ",
      SATA_EIDLE_VAL => B"100",
      SATA_MAX_BURST => 8,
      SATA_MAX_INIT => 21,
      SATA_MAX_WAKE => 7,
      SATA_MIN_BURST => 4,
      SATA_MIN_INIT => 12,
      SATA_MIN_WAKE => 4,
      SHOW_REALIGN_COMMA => "FALSE",
      SIM_MODE => "FAST",
      SIM_RECEIVER_DETECT_PASS => "TRUE",
      SIM_RESET_SPEEDUP => "TRUE",
      SIM_TX_EIDLE_DRIVE_LEVEL => '0',
      SIM_VERSION => 2,
      TAPDLY_SET_TX => B"00",
      TEMPERATUR_PAR => B"0010",
      TERM_RCAL_CFG => B"100001000010000",
      TERM_RCAL_OVRD => B"000",
      TRANS_TIME_RATE => X"0E",
      TST_RSV0 => X"00",
      TST_RSV1 => X"00",
      TXBUF_EN => "FALSE",
      TXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      TXDLY_CFG => X"0009",
      TXDLY_LCFG => X"0050",
      TXDRVBIAS_N => B"1010",
      TXDRVBIAS_P => B"1010",
      TXFIFO_ADDR_CFG => "LOW",
      TXGBOX_FIFO_INIT_RD_ADDR => 4,
      TXGEARBOX_EN => "FALSE",
      TXOUT_DIV => 1,
      TXPCSRESET_TIME => B"00011",
      TXPHDLY_CFG0 => X"2020",
      TXPHDLY_CFG1 => X"0075",
      TXPH_CFG => X"0980",
      TXPH_MONITOR_SEL => B"00000",
      TXPI_CFG0 => B"01",
      TXPI_CFG1 => B"01",
      TXPI_CFG2 => B"01",
      TXPI_CFG3 => '0',
      TXPI_CFG4 => '0',
      TXPI_CFG5 => B"000",
      TXPI_GRAY_SEL => '0',
      TXPI_INVSTROBE_SEL => '0',
      TXPI_LPM => '0',
      TXPI_PPMCLK_SEL => "TXUSRCLK2",
      TXPI_PPM_CFG => B"00000000",
      TXPI_SYNFREQ_PPM => B"001",
      TXPI_VREFSEL => '0',
      TXPMARESET_TIME => B"00011",
      TXSYNC_MULTILANE => '1',
      TXSYNC_OVRD => '0',
      TXSYNC_SKIP_DA => '0',
      TX_CLK25_DIV => 13,
      TX_CLKMUX_EN => '1',
      TX_DATA_WIDTH => 40,
      TX_DCD_CFG => B"000010",
      TX_DCD_EN => '0',
      TX_DEEMPH0 => B"000000",
      TX_DEEMPH1 => B"000000",
      TX_DIVRESET_TIME => B"00001",
      TX_DRIVE_MODE => "DIRECT",
      TX_EIDLE_ASSERT_DELAY => B"100",
      TX_EIDLE_DEASSERT_DELAY => B"011",
      TX_EML_PHI_TUNE => '0',
      TX_FABINT_USRCLK_FLOP => '0',
      TX_IDLE_DATA_ZERO => '0',
      TX_INT_DATAWIDTH => 1,
      TX_LOOPBACK_DRIVE_HIZ => "FALSE",
      TX_MAINCURSOR_SEL => '0',
      TX_MARGIN_FULL_0 => B"1001111",
      TX_MARGIN_FULL_1 => B"1001110",
      TX_MARGIN_FULL_2 => B"1001100",
      TX_MARGIN_FULL_3 => B"1001010",
      TX_MARGIN_FULL_4 => B"1001000",
      TX_MARGIN_LOW_0 => B"1000110",
      TX_MARGIN_LOW_1 => B"1000101",
      TX_MARGIN_LOW_2 => B"1000011",
      TX_MARGIN_LOW_3 => B"1000010",
      TX_MARGIN_LOW_4 => B"1000000",
      TX_MODE_SEL => B"000",
      TX_PMADATA_OPT => '0',
      TX_PMA_POWER_SAVE => '0',
      TX_PROGCLK_SEL => "PREPI",
      TX_PROGDIV_CFG => 20.000000,
      TX_QPI_STATUS_EN => '0',
      TX_RXDETECT_CFG => B"00" & X"032",
      TX_RXDETECT_REF => B"100",
      TX_SAMPLE_PERIOD => B"111",
      TX_SARC_LPBK_ENB => '0',
      TX_XCLK_SEL => "TXUSR",
      USE_PCS_CLK_PHASE_SEL => '0',
      WB_MODE => B"00"
    )
        port map (
      BUFGTCE(2 downto 0) => bufgtce_out(2 downto 0),
      BUFGTCEMASK(2 downto 0) => bufgtcemask_out(2 downto 0),
      BUFGTDIV(8 downto 0) => bufgtdiv_out(8 downto 0),
      BUFGTRESET(2 downto 0) => bufgtreset_out(2 downto 0),
      BUFGTRSTMASK(2 downto 0) => bufgtrstmask_out(2 downto 0),
      CFGRESET => cfgreset_in(0),
      CLKRSVD0 => clkrsvd0_in(0),
      CLKRSVD1 => clkrsvd1_in(0),
      CPLLFBCLKLOST => cpllfbclklost_out(0),
      CPLLLOCK => \^cplllock_out\(0),
      CPLLLOCKDETCLK => cplllockdetclk_in(0),
      CPLLLOCKEN => cplllocken_in(0),
      CPLLPD => GTHE3_CHANNEL_CPLLPD(0),
      CPLLREFCLKLOST => cpllrefclklost_out(0),
      CPLLREFCLKSEL(2 downto 0) => cpllrefclksel_in(2 downto 0),
      CPLLRESET => cpllreset_in(0),
      DMONFIFORESET => dmonfiforeset_in(0),
      DMONITORCLK => dmonitorclk_in(0),
      DMONITOROUT(16 downto 0) => dmonitorout_out(16 downto 0),
      DRPADDR(8 downto 0) => drpaddr_in(8 downto 0),
      DRPCLK => drpclk_in(0),
      DRPDI(15 downto 0) => drpdi_in(15 downto 0),
      DRPDO(15 downto 0) => drpdo_out(15 downto 0),
      DRPEN => drpen_in(0),
      DRPRDY => drprdy_out(0),
      DRPWE => drpwe_in(0),
      EVODDPHICALDONE => evoddphicaldone_in(0),
      EVODDPHICALSTART => evoddphicalstart_in(0),
      EVODDPHIDRDEN => evoddphidrden_in(0),
      EVODDPHIDWREN => evoddphidwren_in(0),
      EVODDPHIXRDEN => evoddphixrden_in(0),
      EVODDPHIXWREN => evoddphixwren_in(0),
      EYESCANDATAERROR => eyescandataerror_out(0),
      EYESCANMODE => eyescanmode_in(0),
      EYESCANRESET => eyescanreset_in(0),
      EYESCANTRIGGER => eyescantrigger_in(0),
      GTGREFCLK => gtgrefclk_in(0),
      GTHRXN => gthrxn_in(0),
      GTHRXP => gthrxp_in(0),
      GTHTXN => gthtxn_out(0),
      GTHTXP => gthtxp_out(0),
      GTNORTHREFCLK0 => gtnorthrefclk0_in(0),
      GTNORTHREFCLK1 => gtnorthrefclk1_in(0),
      GTPOWERGOOD => gtpowergood_out(0),
      GTREFCLK0 => gtrefclk0_in(0),
      GTREFCLK1 => gtrefclk1_in(0),
      GTREFCLKMONITOR => gtrefclkmonitor_out(0),
      GTRESETSEL => gtresetsel_in(0),
      GTRSVD(15 downto 0) => gtrsvd_in(15 downto 0),
      GTRXRESET => GTHE3_CHANNEL_GTRXRESET(0),
      GTSOUTHREFCLK0 => gtsouthrefclk0_in(0),
      GTSOUTHREFCLK1 => gtsouthrefclk1_in(0),
      GTTXRESET => GTHE3_CHANNEL_GTTXRESET(0),
      LOOPBACK(2 downto 0) => loopback_in(2 downto 0),
      LPBKRXTXSEREN => lpbkrxtxseren_in(0),
      LPBKTXRXSEREN => lpbktxrxseren_in(0),
      PCIEEQRXEQADAPTDONE => pcieeqrxeqadaptdone_in(0),
      PCIERATEGEN3 => pcierategen3_out(0),
      PCIERATEIDLE => pcierateidle_out(0),
      PCIERATEQPLLPD(1 downto 0) => pcierateqpllpd_out(1 downto 0),
      PCIERATEQPLLRESET(1 downto 0) => pcierateqpllreset_out(1 downto 0),
      PCIERSTIDLE => pcierstidle_in(0),
      PCIERSTTXSYNCSTART => pciersttxsyncstart_in(0),
      PCIESYNCTXSYNCDONE => pciesynctxsyncdone_out(0),
      PCIEUSERGEN3RDY => pcieusergen3rdy_out(0),
      PCIEUSERPHYSTATUSRST => pcieuserphystatusrst_out(0),
      PCIEUSERRATEDONE => pcieuserratedone_in(0),
      PCIEUSERRATESTART => pcieuserratestart_out(0),
      PCSRSVDIN(15 downto 0) => pcsrsvdin_in(15 downto 0),
      PCSRSVDIN2(4 downto 0) => pcsrsvdin2_in(4 downto 0),
      PCSRSVDOUT(11 downto 0) => pcsrsvdout_out(11 downto 0),
      PHYSTATUS => phystatus_out(0),
      PINRSRVDAS(7 downto 0) => pinrsrvdas_out(7 downto 0),
      PMARSVDIN(4 downto 0) => pmarsvdin_in(4 downto 0),
      QPLL0CLK => qpll0clk_in(0),
      QPLL0REFCLK => qpll0refclk_in(0),
      QPLL1CLK => qpll1clk_in(0),
      QPLL1REFCLK => qpll1refclk_in(0),
      RESETEXCEPTION => resetexception_out(0),
      RESETOVRD => resetovrd_in(0),
      RSTCLKENTX => rstclkentx_in(0),
      RX8B10BEN => rx8b10ben_in(0),
      RXBUFRESET => rxbufreset_in(0),
      RXBUFSTATUS(2 downto 0) => rxbufstatus_out(2 downto 0),
      RXBYTEISALIGNED => rxbyteisaligned_out(0),
      RXBYTEREALIGN => rxbyterealign_out(0),
      RXCDRFREQRESET => rxcdrfreqreset_in(0),
      RXCDRHOLD => rxcdrhold_in(0),
      RXCDRLOCK => rxcdrlock_out(0),
      RXCDROVRDEN => rxcdrovrden_in(0),
      RXCDRPHDONE => rxcdrphdone_out(0),
      RXCDRRESET => rxcdrreset_in(0),
      RXCDRRESETRSV => rxcdrresetrsv_in(0),
      RXCHANBONDSEQ => rxchanbondseq_out(0),
      RXCHANISALIGNED => rxchanisaligned_out(0),
      RXCHANREALIGN => rxchanrealign_out(0),
      RXCHBONDEN => rxchbonden_in(0),
      RXCHBONDI(4 downto 0) => rxchbondi_in(4 downto 0),
      RXCHBONDLEVEL(2 downto 0) => rxchbondlevel_in(2 downto 0),
      RXCHBONDMASTER => rxchbondmaster_in(0),
      RXCHBONDO(4 downto 0) => rxchbondo_out(4 downto 0),
      RXCHBONDSLAVE => rxchbondslave_in(0),
      RXCLKCORCNT(1 downto 0) => rxclkcorcnt_out(1 downto 0),
      RXCOMINITDET => rxcominitdet_out(0),
      RXCOMMADET => rxcommadet_out(0),
      RXCOMMADETEN => rxcommadeten_in(0),
      RXCOMSASDET => rxcomsasdet_out(0),
      RXCOMWAKEDET => rxcomwakedet_out(0),
      RXCTRL0(15 downto 0) => rxctrl0_out(15 downto 0),
      RXCTRL1(15 downto 0) => rxctrl1_out(15 downto 0),
      RXCTRL2(7 downto 0) => rxctrl2_out(7 downto 0),
      RXCTRL3(7 downto 0) => rxctrl3_out(7 downto 0),
      RXDATA(127 downto 0) => rxdata_out(127 downto 0),
      RXDATAEXTENDRSVD(7 downto 0) => rxdataextendrsvd_out(7 downto 0),
      RXDATAVALID(1 downto 0) => rxdatavalid_out(1 downto 0),
      RXDFEAGCCTRL(1 downto 0) => rxdfeagcctrl_in(1 downto 0),
      RXDFEAGCHOLD => rxdfeagchold_in(0),
      RXDFEAGCOVRDEN => rxdfeagcovrden_in(0),
      RXDFELFHOLD => rxdfelfhold_in(0),
      RXDFELFOVRDEN => rxdfelfovrden_in(0),
      RXDFELPMRESET => rxdfelpmreset_in(0),
      RXDFETAP10HOLD => rxdfetap10hold_in(0),
      RXDFETAP10OVRDEN => rxdfetap10ovrden_in(0),
      RXDFETAP11HOLD => rxdfetap11hold_in(0),
      RXDFETAP11OVRDEN => rxdfetap11ovrden_in(0),
      RXDFETAP12HOLD => rxdfetap12hold_in(0),
      RXDFETAP12OVRDEN => rxdfetap12ovrden_in(0),
      RXDFETAP13HOLD => rxdfetap13hold_in(0),
      RXDFETAP13OVRDEN => rxdfetap13ovrden_in(0),
      RXDFETAP14HOLD => rxdfetap14hold_in(0),
      RXDFETAP14OVRDEN => rxdfetap14ovrden_in(0),
      RXDFETAP15HOLD => rxdfetap15hold_in(0),
      RXDFETAP15OVRDEN => rxdfetap15ovrden_in(0),
      RXDFETAP2HOLD => rxdfetap2hold_in(0),
      RXDFETAP2OVRDEN => rxdfetap2ovrden_in(0),
      RXDFETAP3HOLD => rxdfetap3hold_in(0),
      RXDFETAP3OVRDEN => rxdfetap3ovrden_in(0),
      RXDFETAP4HOLD => rxdfetap4hold_in(0),
      RXDFETAP4OVRDEN => rxdfetap4ovrden_in(0),
      RXDFETAP5HOLD => rxdfetap5hold_in(0),
      RXDFETAP5OVRDEN => rxdfetap5ovrden_in(0),
      RXDFETAP6HOLD => rxdfetap6hold_in(0),
      RXDFETAP6OVRDEN => rxdfetap6ovrden_in(0),
      RXDFETAP7HOLD => rxdfetap7hold_in(0),
      RXDFETAP7OVRDEN => rxdfetap7ovrden_in(0),
      RXDFETAP8HOLD => rxdfetap8hold_in(0),
      RXDFETAP8OVRDEN => rxdfetap8ovrden_in(0),
      RXDFETAP9HOLD => rxdfetap9hold_in(0),
      RXDFETAP9OVRDEN => rxdfetap9ovrden_in(0),
      RXDFEUTHOLD => rxdfeuthold_in(0),
      RXDFEUTOVRDEN => rxdfeutovrden_in(0),
      RXDFEVPHOLD => rxdfevphold_in(0),
      RXDFEVPOVRDEN => rxdfevpovrden_in(0),
      RXDFEVSEN => rxdfevsen_in(0),
      RXDFEXYDEN => rxdfexyden_in(0),
      RXDLYBYPASS => rxdlybypass_in(0),
      RXDLYEN => rxdlyen_in(0),
      RXDLYOVRDEN => rxdlyovrden_in(0),
      RXDLYSRESET => rxdlysreset_in(0),
      RXDLYSRESETDONE => rxdlysresetdone_out(0),
      RXELECIDLE => rxelecidle_out(0),
      RXELECIDLEMODE(1 downto 0) => rxelecidlemode_in(1 downto 0),
      RXGEARBOXSLIP => rxgearboxslip_in(0),
      RXHEADER(5 downto 0) => rxheader_out(5 downto 0),
      RXHEADERVALID(1 downto 0) => rxheadervalid_out(1 downto 0),
      RXLATCLK => rxlatclk_in(0),
      RXLPMEN => rxlpmen_in(0),
      RXLPMGCHOLD => rxlpmgchold_in(0),
      RXLPMGCOVRDEN => rxlpmgcovrden_in(0),
      RXLPMHFHOLD => rxlpmhfhold_in(0),
      RXLPMHFOVRDEN => rxlpmhfovrden_in(0),
      RXLPMLFHOLD => rxlpmlfhold_in(0),
      RXLPMLFKLOVRDEN => rxlpmlfklovrden_in(0),
      RXLPMOSHOLD => rxlpmoshold_in(0),
      RXLPMOSOVRDEN => rxlpmosovrden_in(0),
      RXMCOMMAALIGNEN => rxmcommaalignen_in(0),
      RXMONITOROUT(6 downto 0) => rxmonitorout_out(6 downto 0),
      RXMONITORSEL(1 downto 0) => rxmonitorsel_in(1 downto 0),
      RXOOBRESET => rxoobreset_in(0),
      RXOSCALRESET => rxoscalreset_in(0),
      RXOSHOLD => rxoshold_in(0),
      RXOSINTCFG(3 downto 0) => rxosintcfg_in(3 downto 0),
      RXOSINTDONE => rxosintdone_out(0),
      RXOSINTEN => rxosinten_in(0),
      RXOSINTHOLD => rxosinthold_in(0),
      RXOSINTOVRDEN => rxosintovrden_in(0),
      RXOSINTSTARTED => rxosintstarted_out(0),
      RXOSINTSTROBE => rxosintstrobe_in(0),
      RXOSINTSTROBEDONE => rxosintstrobedone_out(0),
      RXOSINTSTROBESTARTED => rxosintstrobestarted_out(0),
      RXOSINTTESTOVRDEN => rxosinttestovrden_in(0),
      RXOSOVRDEN => rxosovrden_in(0),
      RXOUTCLK => rxoutclk_out(0),
      RXOUTCLKFABRIC => rxoutclkfabric_out(0),
      RXOUTCLKPCS => rxoutclkpcs_out(0),
      RXOUTCLKSEL(2 downto 0) => rxoutclksel_in(2 downto 0),
      RXPCOMMAALIGNEN => rxpcommaalignen_in(0),
      RXPCSRESET => rxpcsreset_in(0),
      RXPD(1 downto 0) => rxpd_in(1 downto 0),
      RXPHALIGN => rxphalign_in(0),
      RXPHALIGNDONE => rxphaligndone_out(0),
      RXPHALIGNEN => rxphalignen_in(0),
      RXPHALIGNERR => rxphalignerr_out(0),
      RXPHDLYPD => rxphdlypd_in(0),
      RXPHDLYRESET => rxphdlyreset_in(0),
      RXPHOVRDEN => rxphovrden_in(0),
      RXPLLCLKSEL(1 downto 0) => rxpllclksel_in(1 downto 0),
      RXPMARESET => rxpmareset_in(0),
      RXPMARESETDONE => rxpmaresetdone_out(0),
      RXPOLARITY => rxpolarity_in(0),
      RXPRBSCNTRESET => rxprbscntreset_in(0),
      RXPRBSERR => rxprbserr_out(0),
      RXPRBSLOCKED => rxprbslocked_out(0),
      RXPRBSSEL(3 downto 0) => rxprbssel_in(3 downto 0),
      RXPRGDIVRESETDONE => rxprgdivresetdone_out(0),
      RXPROGDIVRESET => GTHE3_CHANNEL_RXPROGDIVRESET(0),
      RXQPIEN => rxqpien_in(0),
      RXQPISENN => rxqpisenn_out(0),
      RXQPISENP => rxqpisenp_out(0),
      RXRATE(2 downto 0) => rxrate_in(2 downto 0),
      RXRATEDONE => rxratedone_out(0),
      RXRATEMODE => rxratemode_in(0),
      RXRECCLKOUT => rxrecclkout_out(0),
      RXRESETDONE => rxresetdone_out(0),
      RXSLIDE => rxslide_in(0),
      RXSLIDERDY => rxsliderdy_out(0),
      RXSLIPDONE => rxslipdone_out(0),
      RXSLIPOUTCLK => rxslipoutclk_in(0),
      RXSLIPOUTCLKRDY => rxslipoutclkrdy_out(0),
      RXSLIPPMA => rxslippma_in(0),
      RXSLIPPMARDY => rxslippmardy_out(0),
      RXSTARTOFSEQ(1 downto 0) => rxstartofseq_out(1 downto 0),
      RXSTATUS(2 downto 0) => rxstatus_out(2 downto 0),
      RXSYNCALLIN => rxsyncallin_in(0),
      RXSYNCDONE => rxsyncdone_out(0),
      RXSYNCIN => rxsyncin_in(0),
      RXSYNCMODE => rxsyncmode_in(0),
      RXSYNCOUT => rxsyncout_out(0),
      RXSYSCLKSEL(1 downto 0) => rxsysclksel_in(1 downto 0),
      RXUSERRDY => GTHE3_CHANNEL_RXUSERRDY(0),
      RXUSRCLK => rxusrclk_in(0),
      RXUSRCLK2 => rxusrclk2_in(0),
      RXVALID => rxvalid_out(0),
      SIGVALIDCLK => sigvalidclk_in(0),
      TSTIN(19 downto 0) => B"00000000000000000000",
      TX8B10BBYPASS(7 downto 0) => tx8b10bbypass_in(7 downto 0),
      TX8B10BEN => tx8b10ben_in(0),
      TXBUFDIFFCTRL(2 downto 0) => txbufdiffctrl_in(2 downto 0),
      TXBUFSTATUS(1 downto 0) => txbufstatus_out(1 downto 0),
      TXCOMFINISH => txcomfinish_out(0),
      TXCOMINIT => txcominit_in(0),
      TXCOMSAS => txcomsas_in(0),
      TXCOMWAKE => txcomwake_in(0),
      TXCTRL0(15 downto 0) => txctrl0_in(15 downto 0),
      TXCTRL1(15 downto 0) => txctrl1_in(15 downto 0),
      TXCTRL2(7 downto 0) => txctrl2_in(7 downto 0),
      TXDATA(127 downto 32) => B"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      TXDATA(31 downto 0) => gtwiz_userdata_tx_in(31 downto 0),
      TXDATAEXTENDRSVD(7 downto 0) => txdataextendrsvd_in(7 downto 0),
      TXDEEMPH => txdeemph_in(0),
      TXDETECTRX => txdetectrx_in(0),
      TXDIFFCTRL(3 downto 0) => txdiffctrl_in(3 downto 0),
      TXDIFFPD => txdiffpd_in(0),
      TXDLYBYPASS => '0',
      TXDLYEN => '0',
      TXDLYHOLD => '0',
      TXDLYOVRDEN => '0',
      TXDLYSRESET => GTHE3_CHANNEL_TXDLYSRESET(0),
      TXDLYSRESETDONE => txdlysresetdone_out(0),
      TXDLYUPDOWN => '0',
      TXELECIDLE => txelecidle_in(0),
      TXHEADER(5 downto 0) => txheader_in(5 downto 0),
      TXINHIBIT => txinhibit_in(0),
      TXLATCLK => txlatclk_in(0),
      TXMAINCURSOR(6 downto 0) => txmaincursor_in(6 downto 0),
      TXMARGIN(2 downto 0) => txmargin_in(2 downto 0),
      TXOUTCLK => txoutclk_out(0),
      TXOUTCLKFABRIC => txoutclkfabric_out(0),
      TXOUTCLKPCS => txoutclkpcs_out(0),
      TXOUTCLKSEL(2 downto 0) => txoutclksel_in(2 downto 0),
      TXPCSRESET => txpcsreset_in(0),
      TXPD(1 downto 0) => txpd_in(1 downto 0),
      TXPDELECIDLEMODE => txpdelecidlemode_in(0),
      TXPHALIGN => '0',
      TXPHALIGNDONE => txphaligndone_out(0),
      TXPHALIGNEN => '0',
      TXPHDLYPD => '0',
      TXPHDLYRESET => '0',
      TXPHDLYTSTCLK => '0',
      TXPHINIT => '0',
      TXPHINITDONE => txphinitdone_out(0),
      TXPHOVRDEN => '0',
      TXPIPPMEN => txpippmen_in(0),
      TXPIPPMOVRDEN => txpippmovrden_in(0),
      TXPIPPMPD => txpippmpd_in(0),
      TXPIPPMSEL => txpippmsel_in(0),
      TXPIPPMSTEPSIZE(4 downto 0) => txpippmstepsize_in(4 downto 0),
      TXPISOPD => txpisopd_in(0),
      TXPLLCLKSEL(1 downto 0) => txpllclksel_in(1 downto 0),
      TXPMARESET => txpmareset_in(0),
      TXPMARESETDONE => txpmaresetdone_out(0),
      TXPOLARITY => txpolarity_in(0),
      TXPOSTCURSOR(4 downto 0) => txpostcursor_in(4 downto 0),
      TXPOSTCURSORINV => txpostcursorinv_in(0),
      TXPRBSFORCEERR => txprbsforceerr_in(0),
      TXPRBSSEL(3 downto 0) => txprbssel_in(3 downto 0),
      TXPRECURSOR(4 downto 0) => txprecursor_in(4 downto 0),
      TXPRECURSORINV => txprecursorinv_in(0),
      TXPRGDIVRESETDONE => txprgdivresetdone_out(0),
      TXPROGDIVRESET => GTHE3_CHANNEL_TXPROGDIVRESET(0),
      TXQPIBIASEN => txqpibiasen_in(0),
      TXQPISENN => txqpisenn_out(0),
      TXQPISENP => txqpisenp_out(0),
      TXQPISTRONGPDOWN => txqpistrongpdown_in(0),
      TXQPIWEAKPUP => txqpiweakpup_in(0),
      TXRATE(2 downto 0) => txrate_in(2 downto 0),
      TXRATEDONE => txratedone_out(0),
      TXRATEMODE => txratemode_in(0),
      TXRESETDONE => txresetdone_out(0),
      TXSEQUENCE(6 downto 0) => txsequence_in(6 downto 0),
      TXSWING => txswing_in(0),
      TXSYNCALLIN => GTHE3_CHANNEL_TXSYNCALLIN(0),
      TXSYNCDONE => txsyncdone_out(0),
      TXSYNCIN => \^txsyncout_out\(3),
      TXSYNCMODE => '0',
      TXSYNCOUT => \^txsyncout_out\(0),
      TXSYSCLKSEL(1 downto 0) => txsysclksel_in(1 downto 0),
      TXUSERRDY => GTHE3_CHANNEL_TXUSERRDY(0),
      TXUSRCLK => txusrclk_in(0),
      TXUSRCLK2 => txusrclk2_in(0)
    );
\gthe3_channel_gen.gen_gthe3_channel_inst[1].GTHE3_CHANNEL_PRIM_INST\: unisim.vcomponents.GTHE3_CHANNEL
    generic map(
      ACJTAG_DEBUG_MODE => '0',
      ACJTAG_MODE => '0',
      ACJTAG_RESET => '0',
      ADAPT_CFG0 => X"F800",
      ADAPT_CFG1 => X"0000",
      ALIGN_COMMA_DOUBLE => "FALSE",
      ALIGN_COMMA_ENABLE => B"1111111111",
      ALIGN_COMMA_WORD => 1,
      ALIGN_MCOMMA_DET => "TRUE",
      ALIGN_MCOMMA_VALUE => B"1010000011",
      ALIGN_PCOMMA_DET => "TRUE",
      ALIGN_PCOMMA_VALUE => B"0101111100",
      A_RXOSCALRESET => '0',
      A_RXPROGDIVRESET => '0',
      A_TXPROGDIVRESET => '0',
      CBCC_DATA_SOURCE_SEL => "DECODED",
      CDR_SWAP_MODE_EN => '0',
      CHAN_BOND_KEEP_ALIGN => "FALSE",
      CHAN_BOND_MAX_SKEW => 1,
      CHAN_BOND_SEQ_1_1 => B"0000000000",
      CHAN_BOND_SEQ_1_2 => B"0000000000",
      CHAN_BOND_SEQ_1_3 => B"0000000000",
      CHAN_BOND_SEQ_1_4 => B"0000000000",
      CHAN_BOND_SEQ_1_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_1 => B"0000000000",
      CHAN_BOND_SEQ_2_2 => B"0000000000",
      CHAN_BOND_SEQ_2_3 => B"0000000000",
      CHAN_BOND_SEQ_2_4 => B"0000000000",
      CHAN_BOND_SEQ_2_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_USE => "FALSE",
      CHAN_BOND_SEQ_LEN => 1,
      CLK_CORRECT_USE => "FALSE",
      CLK_COR_KEEP_IDLE => "FALSE",
      CLK_COR_MAX_LAT => 12,
      CLK_COR_MIN_LAT => 8,
      CLK_COR_PRECEDENCE => "TRUE",
      CLK_COR_REPEAT_WAIT => 0,
      CLK_COR_SEQ_1_1 => B"0100000000",
      CLK_COR_SEQ_1_2 => B"0100000000",
      CLK_COR_SEQ_1_3 => B"0100000000",
      CLK_COR_SEQ_1_4 => B"0100000000",
      CLK_COR_SEQ_1_ENABLE => B"1111",
      CLK_COR_SEQ_2_1 => B"0100000000",
      CLK_COR_SEQ_2_2 => B"0100000000",
      CLK_COR_SEQ_2_3 => B"0100000000",
      CLK_COR_SEQ_2_4 => B"0100000000",
      CLK_COR_SEQ_2_ENABLE => B"1111",
      CLK_COR_SEQ_2_USE => "FALSE",
      CLK_COR_SEQ_LEN => 1,
      CPLL_CFG0 => X"23FC",
      CPLL_CFG1 => X"A4AC",
      CPLL_CFG2 => X"0004",
      CPLL_CFG3 => B"00" & X"0",
      CPLL_FBDIV => 5,
      CPLL_FBDIV_45 => 4,
      CPLL_INIT_CFG0 => X"02B2",
      CPLL_INIT_CFG1 => X"00",
      CPLL_LOCK_CFG => X"01E8",
      CPLL_REFCLK_DIV => 1,
      DDI_CTRL => B"00",
      DDI_REALIGN_WAIT => 15,
      DEC_MCOMMA_DETECT => "TRUE",
      DEC_PCOMMA_DETECT => "TRUE",
      DEC_VALID_COMMA_ONLY => "FALSE",
      DFE_D_X_REL_POS => '0',
      DFE_VCM_COMP_EN => '0',
      DMONITOR_CFG0 => B"00" & X"00",
      DMONITOR_CFG1 => X"00",
      ES_CLK_PHASE_SEL => '0',
      ES_CONTROL => B"000000",
      ES_ERRDET_EN => "FALSE",
      ES_EYE_SCAN_EN => "FALSE",
      ES_HORZ_OFFSET => X"000",
      ES_PMA_CFG => B"0000000000",
      ES_PRESCALE => B"00000",
      ES_QUALIFIER0 => X"0000",
      ES_QUALIFIER1 => X"0000",
      ES_QUALIFIER2 => X"0000",
      ES_QUALIFIER3 => X"0000",
      ES_QUALIFIER4 => X"0000",
      ES_QUAL_MASK0 => X"0000",
      ES_QUAL_MASK1 => X"0000",
      ES_QUAL_MASK2 => X"0000",
      ES_QUAL_MASK3 => X"0000",
      ES_QUAL_MASK4 => X"0000",
      ES_SDATA_MASK0 => X"0000",
      ES_SDATA_MASK1 => X"0000",
      ES_SDATA_MASK2 => X"0000",
      ES_SDATA_MASK3 => X"0000",
      ES_SDATA_MASK4 => X"0000",
      EVODD_PHI_CFG => B"00000000000",
      EYE_SCAN_SWAP_EN => '0',
      FTS_DESKEW_SEQ_ENABLE => B"1111",
      FTS_LANE_DESKEW_CFG => B"1111",
      FTS_LANE_DESKEW_EN => "FALSE",
      GEARBOX_MODE => B"00000",
      GM_BIAS_SELECT => '0',
      LOCAL_MASTER => '1',
      OOBDIVCTL => B"00",
      OOB_PWRUP => '0',
      PCI3_AUTO_REALIGN => "OVR_1K_BLK",
      PCI3_PIPE_RX_ELECIDLE => '0',
      PCI3_RX_ASYNC_EBUF_BYPASS => B"00",
      PCI3_RX_ELECIDLE_EI2_ENABLE => '0',
      PCI3_RX_ELECIDLE_H2L_COUNT => B"000000",
      PCI3_RX_ELECIDLE_H2L_DISABLE => B"000",
      PCI3_RX_ELECIDLE_HI_COUNT => B"000000",
      PCI3_RX_ELECIDLE_LP4_DISABLE => '0',
      PCI3_RX_FIFO_DISABLE => '0',
      PCIE_BUFG_DIV_CTRL => X"1000",
      PCIE_RXPCS_CFG_GEN3 => X"02A4",
      PCIE_RXPMA_CFG => X"000A",
      PCIE_TXPCS_CFG_GEN3 => X"2CA4",
      PCIE_TXPMA_CFG => X"000A",
      PCS_PCIE_EN => "FALSE",
      PCS_RSVD0 => B"0000000000000000",
      PCS_RSVD1 => B"000",
      PD_TRANS_TIME_FROM_P2 => X"03C",
      PD_TRANS_TIME_NONE_P2 => X"19",
      PD_TRANS_TIME_TO_P2 => X"64",
      PLL_SEL_MODE_GEN12 => B"11",
      PLL_SEL_MODE_GEN3 => B"11",
      PMA_RSV1 => X"E000",
      PROCESS_PAR => B"010",
      RATE_SW_USE_DRP => '1',
      RESET_POWERSAVE_DISABLE => '0',
      RXBUFRESET_TIME => B"00011",
      RXBUF_ADDR_MODE => "FAST",
      RXBUF_EIDLE_HI_CNT => B"1000",
      RXBUF_EIDLE_LO_CNT => B"0000",
      RXBUF_EN => "TRUE",
      RXBUF_RESET_ON_CB_CHANGE => "TRUE",
      RXBUF_RESET_ON_COMMAALIGN => "TRUE",
      RXBUF_RESET_ON_EIDLE => "FALSE",
      RXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      RXBUF_THRESH_OVFLW => 57,
      RXBUF_THRESH_OVRD => "TRUE",
      RXBUF_THRESH_UNDFLW => 3,
      RXCDRFREQRESET_TIME => B"00001",
      RXCDRPHRESET_TIME => B"00001",
      RXCDR_CFG0 => X"0000",
      RXCDR_CFG0_GEN3 => X"0000",
      RXCDR_CFG1 => X"0000",
      RXCDR_CFG1_GEN3 => X"0000",
      RXCDR_CFG2 => X"0766",
      RXCDR_CFG2_GEN3 => X"07E6",
      RXCDR_CFG3 => X"0000",
      RXCDR_CFG3_GEN3 => X"0000",
      RXCDR_CFG4 => X"0000",
      RXCDR_CFG4_GEN3 => X"0000",
      RXCDR_CFG5 => X"0000",
      RXCDR_CFG5_GEN3 => X"0000",
      RXCDR_FR_RESET_ON_EIDLE => '0',
      RXCDR_HOLD_DURING_EIDLE => '0',
      RXCDR_LOCK_CFG0 => X"4480",
      RXCDR_LOCK_CFG1 => X"5FFF",
      RXCDR_LOCK_CFG2 => X"77C3",
      RXCDR_PH_RESET_ON_EIDLE => '0',
      RXCFOK_CFG0 => X"4000",
      RXCFOK_CFG1 => X"0065",
      RXCFOK_CFG2 => X"002E",
      RXDFELPMRESET_TIME => B"0001111",
      RXDFELPM_KL_CFG0 => X"0000",
      RXDFELPM_KL_CFG1 => X"0032",
      RXDFELPM_KL_CFG2 => X"0000",
      RXDFE_CFG0 => X"0A00",
      RXDFE_CFG1 => X"0000",
      RXDFE_GC_CFG0 => X"0000",
      RXDFE_GC_CFG1 => X"7860",
      RXDFE_GC_CFG2 => X"0000",
      RXDFE_H2_CFG0 => X"0000",
      RXDFE_H2_CFG1 => X"0000",
      RXDFE_H3_CFG0 => X"4000",
      RXDFE_H3_CFG1 => X"0000",
      RXDFE_H4_CFG0 => X"2000",
      RXDFE_H4_CFG1 => X"0003",
      RXDFE_H5_CFG0 => X"2000",
      RXDFE_H5_CFG1 => X"0003",
      RXDFE_H6_CFG0 => X"2000",
      RXDFE_H6_CFG1 => X"0000",
      RXDFE_H7_CFG0 => X"2000",
      RXDFE_H7_CFG1 => X"0000",
      RXDFE_H8_CFG0 => X"2000",
      RXDFE_H8_CFG1 => X"0000",
      RXDFE_H9_CFG0 => X"2000",
      RXDFE_H9_CFG1 => X"0000",
      RXDFE_HA_CFG0 => X"2000",
      RXDFE_HA_CFG1 => X"0000",
      RXDFE_HB_CFG0 => X"2000",
      RXDFE_HB_CFG1 => X"0000",
      RXDFE_HC_CFG0 => X"0000",
      RXDFE_HC_CFG1 => X"0000",
      RXDFE_HD_CFG0 => X"0000",
      RXDFE_HD_CFG1 => X"0000",
      RXDFE_HE_CFG0 => X"0000",
      RXDFE_HE_CFG1 => X"0000",
      RXDFE_HF_CFG0 => X"0000",
      RXDFE_HF_CFG1 => X"0000",
      RXDFE_OS_CFG0 => X"8000",
      RXDFE_OS_CFG1 => X"0000",
      RXDFE_UT_CFG0 => X"8000",
      RXDFE_UT_CFG1 => X"0003",
      RXDFE_VP_CFG0 => X"AA00",
      RXDFE_VP_CFG1 => X"0033",
      RXDLY_CFG => X"001F",
      RXDLY_LCFG => X"0030",
      RXELECIDLE_CFG => "Sigcfg_4",
      RXGBOX_FIFO_INIT_RD_ADDR => 4,
      RXGEARBOX_EN => "FALSE",
      RXISCANRESET_TIME => B"00001",
      RXLPM_CFG => X"0000",
      RXLPM_GC_CFG => X"1000",
      RXLPM_KH_CFG0 => X"0000",
      RXLPM_KH_CFG1 => X"0002",
      RXLPM_OS_CFG0 => X"8000",
      RXLPM_OS_CFG1 => X"0002",
      RXOOB_CFG => B"000000110",
      RXOOB_CLK_CFG => "PMA",
      RXOSCALRESET_TIME => B"00011",
      RXOUT_DIV => 1,
      RXPCSRESET_TIME => B"00011",
      RXPHBEACON_CFG => X"0000",
      RXPHDLY_CFG => X"2020",
      RXPHSAMP_CFG => X"2100",
      RXPHSLIP_CFG => X"6622",
      RXPH_MONITOR_SEL => B"00000",
      RXPI_CFG0 => B"01",
      RXPI_CFG1 => B"01",
      RXPI_CFG2 => B"01",
      RXPI_CFG3 => B"01",
      RXPI_CFG4 => '0',
      RXPI_CFG5 => '0',
      RXPI_CFG6 => B"000",
      RXPI_LPM => '0',
      RXPI_VREFSEL => '0',
      RXPMACLK_SEL => "DATA",
      RXPMARESET_TIME => B"00011",
      RXPRBS_ERR_LOOPBACK => '0',
      RXPRBS_LINKACQ_CNT => 15,
      RXSLIDE_AUTO_WAIT => 7,
      RXSLIDE_MODE => "OFF",
      RXSYNC_MULTILANE => '1',
      RXSYNC_OVRD => '0',
      RXSYNC_SKIP_DA => '0',
      RX_AFE_CM_EN => '0',
      RX_BIAS_CFG0 => X"0AB4",
      RX_BUFFER_CFG => B"000000",
      RX_CAPFF_SARC_ENB => '0',
      RX_CLK25_DIV => 13,
      RX_CLKMUX_EN => '1',
      RX_CLK_SLIP_OVRD => B"00000",
      RX_CM_BUF_CFG => B"1010",
      RX_CM_BUF_PD => '0',
      RX_CM_SEL => B"11",
      RX_CM_TRIM => B"1010",
      RX_CTLE3_LPF => B"00000001",
      RX_DATA_WIDTH => 40,
      RX_DDI_SEL => B"000000",
      RX_DEFER_RESET_BUF_EN => "TRUE",
      RX_DFELPM_CFG0 => B"0110",
      RX_DFELPM_CFG1 => '1',
      RX_DFELPM_KLKH_AGC_STUP_EN => '1',
      RX_DFE_AGC_CFG0 => B"10",
      RX_DFE_AGC_CFG1 => B"000",
      RX_DFE_KL_LPM_KH_CFG0 => B"01",
      RX_DFE_KL_LPM_KH_CFG1 => B"000",
      RX_DFE_KL_LPM_KL_CFG0 => B"01",
      RX_DFE_KL_LPM_KL_CFG1 => B"000",
      RX_DFE_LPM_HOLD_DURING_EIDLE => '0',
      RX_DISPERR_SEQ_MATCH => "TRUE",
      RX_DIVRESET_TIME => B"00001",
      RX_EN_HI_LR => '1',
      RX_EYESCAN_VS_CODE => B"0000000",
      RX_EYESCAN_VS_NEG_DIR => '0',
      RX_EYESCAN_VS_RANGE => B"00",
      RX_EYESCAN_VS_UT_SIGN => '0',
      RX_FABINT_USRCLK_FLOP => '0',
      RX_INT_DATAWIDTH => 1,
      RX_PMA_POWER_SAVE => '0',
      RX_PROGDIV_CFG => 0.000000,
      RX_SAMPLE_PERIOD => B"111",
      RX_SIG_VALID_DLY => 11,
      RX_SUM_DFETAPREP_EN => '0',
      RX_SUM_IREF_TUNE => B"1100",
      RX_SUM_RES_CTRL => B"11",
      RX_SUM_VCMTUNE => B"0000",
      RX_SUM_VCM_OVWR => '0',
      RX_SUM_VREF_TUNE => B"000",
      RX_TUNE_AFE_OS => B"10",
      RX_WIDEMODE_CDR => '1',
      RX_XCLK_SEL => "RXDES",
      SAS_MAX_COM => 64,
      SAS_MIN_COM => 36,
      SATA_BURST_SEQ_LEN => B"1110",
      SATA_BURST_VAL => B"100",
      SATA_CPLL_CFG => "VCO_3000MHZ",
      SATA_EIDLE_VAL => B"100",
      SATA_MAX_BURST => 8,
      SATA_MAX_INIT => 21,
      SATA_MAX_WAKE => 7,
      SATA_MIN_BURST => 4,
      SATA_MIN_INIT => 12,
      SATA_MIN_WAKE => 4,
      SHOW_REALIGN_COMMA => "FALSE",
      SIM_MODE => "FAST",
      SIM_RECEIVER_DETECT_PASS => "TRUE",
      SIM_RESET_SPEEDUP => "TRUE",
      SIM_TX_EIDLE_DRIVE_LEVEL => '0',
      SIM_VERSION => 2,
      TAPDLY_SET_TX => B"00",
      TEMPERATUR_PAR => B"0010",
      TERM_RCAL_CFG => B"100001000010000",
      TERM_RCAL_OVRD => B"000",
      TRANS_TIME_RATE => X"0E",
      TST_RSV0 => X"00",
      TST_RSV1 => X"00",
      TXBUF_EN => "FALSE",
      TXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      TXDLY_CFG => X"0009",
      TXDLY_LCFG => X"0050",
      TXDRVBIAS_N => B"1010",
      TXDRVBIAS_P => B"1010",
      TXFIFO_ADDR_CFG => "LOW",
      TXGBOX_FIFO_INIT_RD_ADDR => 4,
      TXGEARBOX_EN => "FALSE",
      TXOUT_DIV => 1,
      TXPCSRESET_TIME => B"00011",
      TXPHDLY_CFG0 => X"2020",
      TXPHDLY_CFG1 => X"0075",
      TXPH_CFG => X"0980",
      TXPH_MONITOR_SEL => B"00000",
      TXPI_CFG0 => B"01",
      TXPI_CFG1 => B"01",
      TXPI_CFG2 => B"01",
      TXPI_CFG3 => '0',
      TXPI_CFG4 => '0',
      TXPI_CFG5 => B"000",
      TXPI_GRAY_SEL => '0',
      TXPI_INVSTROBE_SEL => '0',
      TXPI_LPM => '0',
      TXPI_PPMCLK_SEL => "TXUSRCLK2",
      TXPI_PPM_CFG => B"00000000",
      TXPI_SYNFREQ_PPM => B"001",
      TXPI_VREFSEL => '0',
      TXPMARESET_TIME => B"00011",
      TXSYNC_MULTILANE => '1',
      TXSYNC_OVRD => '0',
      TXSYNC_SKIP_DA => '0',
      TX_CLK25_DIV => 13,
      TX_CLKMUX_EN => '1',
      TX_DATA_WIDTH => 40,
      TX_DCD_CFG => B"000010",
      TX_DCD_EN => '0',
      TX_DEEMPH0 => B"000000",
      TX_DEEMPH1 => B"000000",
      TX_DIVRESET_TIME => B"00001",
      TX_DRIVE_MODE => "DIRECT",
      TX_EIDLE_ASSERT_DELAY => B"100",
      TX_EIDLE_DEASSERT_DELAY => B"011",
      TX_EML_PHI_TUNE => '0',
      TX_FABINT_USRCLK_FLOP => '0',
      TX_IDLE_DATA_ZERO => '0',
      TX_INT_DATAWIDTH => 1,
      TX_LOOPBACK_DRIVE_HIZ => "FALSE",
      TX_MAINCURSOR_SEL => '0',
      TX_MARGIN_FULL_0 => B"1001111",
      TX_MARGIN_FULL_1 => B"1001110",
      TX_MARGIN_FULL_2 => B"1001100",
      TX_MARGIN_FULL_3 => B"1001010",
      TX_MARGIN_FULL_4 => B"1001000",
      TX_MARGIN_LOW_0 => B"1000110",
      TX_MARGIN_LOW_1 => B"1000101",
      TX_MARGIN_LOW_2 => B"1000011",
      TX_MARGIN_LOW_3 => B"1000010",
      TX_MARGIN_LOW_4 => B"1000000",
      TX_MODE_SEL => B"000",
      TX_PMADATA_OPT => '0',
      TX_PMA_POWER_SAVE => '0',
      TX_PROGCLK_SEL => "PREPI",
      TX_PROGDIV_CFG => 20.000000,
      TX_QPI_STATUS_EN => '0',
      TX_RXDETECT_CFG => B"00" & X"032",
      TX_RXDETECT_REF => B"100",
      TX_SAMPLE_PERIOD => B"111",
      TX_SARC_LPBK_ENB => '0',
      TX_XCLK_SEL => "TXUSR",
      USE_PCS_CLK_PHASE_SEL => '0',
      WB_MODE => B"00"
    )
        port map (
      BUFGTCE(2 downto 0) => bufgtce_out(5 downto 3),
      BUFGTCEMASK(2 downto 0) => bufgtcemask_out(5 downto 3),
      BUFGTDIV(8 downto 0) => bufgtdiv_out(17 downto 9),
      BUFGTRESET(2 downto 0) => bufgtreset_out(5 downto 3),
      BUFGTRSTMASK(2 downto 0) => bufgtrstmask_out(5 downto 3),
      CFGRESET => cfgreset_in(1),
      CLKRSVD0 => clkrsvd0_in(1),
      CLKRSVD1 => clkrsvd1_in(1),
      CPLLFBCLKLOST => cpllfbclklost_out(1),
      CPLLLOCK => \^cplllock_out\(1),
      CPLLLOCKDETCLK => cplllockdetclk_in(1),
      CPLLLOCKEN => cplllocken_in(1),
      CPLLPD => GTHE3_CHANNEL_CPLLPD(0),
      CPLLREFCLKLOST => cpllrefclklost_out(1),
      CPLLREFCLKSEL(2 downto 0) => cpllrefclksel_in(5 downto 3),
      CPLLRESET => cpllreset_in(1),
      DMONFIFORESET => dmonfiforeset_in(1),
      DMONITORCLK => dmonitorclk_in(1),
      DMONITOROUT(16 downto 0) => dmonitorout_out(33 downto 17),
      DRPADDR(8 downto 0) => drpaddr_in(17 downto 9),
      DRPCLK => drpclk_in(1),
      DRPDI(15 downto 0) => drpdi_in(31 downto 16),
      DRPDO(15 downto 0) => drpdo_out(31 downto 16),
      DRPEN => drpen_in(1),
      DRPRDY => drprdy_out(1),
      DRPWE => drpwe_in(1),
      EVODDPHICALDONE => evoddphicaldone_in(1),
      EVODDPHICALSTART => evoddphicalstart_in(1),
      EVODDPHIDRDEN => evoddphidrden_in(1),
      EVODDPHIDWREN => evoddphidwren_in(1),
      EVODDPHIXRDEN => evoddphixrden_in(1),
      EVODDPHIXWREN => evoddphixwren_in(1),
      EYESCANDATAERROR => eyescandataerror_out(1),
      EYESCANMODE => eyescanmode_in(1),
      EYESCANRESET => eyescanreset_in(1),
      EYESCANTRIGGER => eyescantrigger_in(1),
      GTGREFCLK => gtgrefclk_in(1),
      GTHRXN => gthrxn_in(1),
      GTHRXP => gthrxp_in(1),
      GTHTXN => gthtxn_out(1),
      GTHTXP => gthtxp_out(1),
      GTNORTHREFCLK0 => gtnorthrefclk0_in(1),
      GTNORTHREFCLK1 => gtnorthrefclk1_in(1),
      GTPOWERGOOD => gtpowergood_out(1),
      GTREFCLK0 => gtrefclk0_in(1),
      GTREFCLK1 => gtrefclk1_in(1),
      GTREFCLKMONITOR => gtrefclkmonitor_out(1),
      GTRESETSEL => gtresetsel_in(1),
      GTRSVD(15 downto 0) => gtrsvd_in(31 downto 16),
      GTRXRESET => GTHE3_CHANNEL_GTRXRESET(0),
      GTSOUTHREFCLK0 => gtsouthrefclk0_in(1),
      GTSOUTHREFCLK1 => gtsouthrefclk1_in(1),
      GTTXRESET => GTHE3_CHANNEL_GTTXRESET(0),
      LOOPBACK(2 downto 0) => loopback_in(5 downto 3),
      LPBKRXTXSEREN => lpbkrxtxseren_in(1),
      LPBKTXRXSEREN => lpbktxrxseren_in(1),
      PCIEEQRXEQADAPTDONE => pcieeqrxeqadaptdone_in(1),
      PCIERATEGEN3 => pcierategen3_out(1),
      PCIERATEIDLE => pcierateidle_out(1),
      PCIERATEQPLLPD(1 downto 0) => pcierateqpllpd_out(3 downto 2),
      PCIERATEQPLLRESET(1 downto 0) => pcierateqpllreset_out(3 downto 2),
      PCIERSTIDLE => pcierstidle_in(1),
      PCIERSTTXSYNCSTART => pciersttxsyncstart_in(1),
      PCIESYNCTXSYNCDONE => pciesynctxsyncdone_out(1),
      PCIEUSERGEN3RDY => pcieusergen3rdy_out(1),
      PCIEUSERPHYSTATUSRST => pcieuserphystatusrst_out(1),
      PCIEUSERRATEDONE => pcieuserratedone_in(1),
      PCIEUSERRATESTART => pcieuserratestart_out(1),
      PCSRSVDIN(15 downto 0) => pcsrsvdin_in(31 downto 16),
      PCSRSVDIN2(4 downto 0) => pcsrsvdin2_in(9 downto 5),
      PCSRSVDOUT(11 downto 0) => pcsrsvdout_out(23 downto 12),
      PHYSTATUS => phystatus_out(1),
      PINRSRVDAS(7 downto 0) => pinrsrvdas_out(15 downto 8),
      PMARSVDIN(4 downto 0) => pmarsvdin_in(9 downto 5),
      QPLL0CLK => qpll0clk_in(1),
      QPLL0REFCLK => qpll0refclk_in(1),
      QPLL1CLK => qpll1clk_in(1),
      QPLL1REFCLK => qpll1refclk_in(1),
      RESETEXCEPTION => resetexception_out(1),
      RESETOVRD => resetovrd_in(1),
      RSTCLKENTX => rstclkentx_in(1),
      RX8B10BEN => rx8b10ben_in(1),
      RXBUFRESET => rxbufreset_in(1),
      RXBUFSTATUS(2 downto 0) => rxbufstatus_out(5 downto 3),
      RXBYTEISALIGNED => rxbyteisaligned_out(1),
      RXBYTEREALIGN => rxbyterealign_out(1),
      RXCDRFREQRESET => rxcdrfreqreset_in(1),
      RXCDRHOLD => rxcdrhold_in(1),
      RXCDRLOCK => rxcdrlock_out(1),
      RXCDROVRDEN => rxcdrovrden_in(1),
      RXCDRPHDONE => rxcdrphdone_out(1),
      RXCDRRESET => rxcdrreset_in(1),
      RXCDRRESETRSV => rxcdrresetrsv_in(1),
      RXCHANBONDSEQ => rxchanbondseq_out(1),
      RXCHANISALIGNED => rxchanisaligned_out(1),
      RXCHANREALIGN => rxchanrealign_out(1),
      RXCHBONDEN => rxchbonden_in(1),
      RXCHBONDI(4 downto 0) => rxchbondi_in(9 downto 5),
      RXCHBONDLEVEL(2 downto 0) => rxchbondlevel_in(5 downto 3),
      RXCHBONDMASTER => rxchbondmaster_in(1),
      RXCHBONDO(4 downto 0) => rxchbondo_out(9 downto 5),
      RXCHBONDSLAVE => rxchbondslave_in(1),
      RXCLKCORCNT(1 downto 0) => rxclkcorcnt_out(3 downto 2),
      RXCOMINITDET => rxcominitdet_out(1),
      RXCOMMADET => rxcommadet_out(1),
      RXCOMMADETEN => rxcommadeten_in(1),
      RXCOMSASDET => rxcomsasdet_out(1),
      RXCOMWAKEDET => rxcomwakedet_out(1),
      RXCTRL0(15 downto 0) => rxctrl0_out(31 downto 16),
      RXCTRL1(15 downto 0) => rxctrl1_out(31 downto 16),
      RXCTRL2(7 downto 0) => rxctrl2_out(15 downto 8),
      RXCTRL3(7 downto 0) => rxctrl3_out(15 downto 8),
      RXDATA(127 downto 0) => rxdata_out(255 downto 128),
      RXDATAEXTENDRSVD(7 downto 0) => rxdataextendrsvd_out(15 downto 8),
      RXDATAVALID(1 downto 0) => rxdatavalid_out(3 downto 2),
      RXDFEAGCCTRL(1 downto 0) => rxdfeagcctrl_in(3 downto 2),
      RXDFEAGCHOLD => rxdfeagchold_in(1),
      RXDFEAGCOVRDEN => rxdfeagcovrden_in(1),
      RXDFELFHOLD => rxdfelfhold_in(1),
      RXDFELFOVRDEN => rxdfelfovrden_in(1),
      RXDFELPMRESET => rxdfelpmreset_in(1),
      RXDFETAP10HOLD => rxdfetap10hold_in(1),
      RXDFETAP10OVRDEN => rxdfetap10ovrden_in(1),
      RXDFETAP11HOLD => rxdfetap11hold_in(1),
      RXDFETAP11OVRDEN => rxdfetap11ovrden_in(1),
      RXDFETAP12HOLD => rxdfetap12hold_in(1),
      RXDFETAP12OVRDEN => rxdfetap12ovrden_in(1),
      RXDFETAP13HOLD => rxdfetap13hold_in(1),
      RXDFETAP13OVRDEN => rxdfetap13ovrden_in(1),
      RXDFETAP14HOLD => rxdfetap14hold_in(1),
      RXDFETAP14OVRDEN => rxdfetap14ovrden_in(1),
      RXDFETAP15HOLD => rxdfetap15hold_in(1),
      RXDFETAP15OVRDEN => rxdfetap15ovrden_in(1),
      RXDFETAP2HOLD => rxdfetap2hold_in(1),
      RXDFETAP2OVRDEN => rxdfetap2ovrden_in(1),
      RXDFETAP3HOLD => rxdfetap3hold_in(1),
      RXDFETAP3OVRDEN => rxdfetap3ovrden_in(1),
      RXDFETAP4HOLD => rxdfetap4hold_in(1),
      RXDFETAP4OVRDEN => rxdfetap4ovrden_in(1),
      RXDFETAP5HOLD => rxdfetap5hold_in(1),
      RXDFETAP5OVRDEN => rxdfetap5ovrden_in(1),
      RXDFETAP6HOLD => rxdfetap6hold_in(1),
      RXDFETAP6OVRDEN => rxdfetap6ovrden_in(1),
      RXDFETAP7HOLD => rxdfetap7hold_in(1),
      RXDFETAP7OVRDEN => rxdfetap7ovrden_in(1),
      RXDFETAP8HOLD => rxdfetap8hold_in(1),
      RXDFETAP8OVRDEN => rxdfetap8ovrden_in(1),
      RXDFETAP9HOLD => rxdfetap9hold_in(1),
      RXDFETAP9OVRDEN => rxdfetap9ovrden_in(1),
      RXDFEUTHOLD => rxdfeuthold_in(1),
      RXDFEUTOVRDEN => rxdfeutovrden_in(1),
      RXDFEVPHOLD => rxdfevphold_in(1),
      RXDFEVPOVRDEN => rxdfevpovrden_in(1),
      RXDFEVSEN => rxdfevsen_in(1),
      RXDFEXYDEN => rxdfexyden_in(1),
      RXDLYBYPASS => rxdlybypass_in(1),
      RXDLYEN => rxdlyen_in(1),
      RXDLYOVRDEN => rxdlyovrden_in(1),
      RXDLYSRESET => rxdlysreset_in(1),
      RXDLYSRESETDONE => rxdlysresetdone_out(1),
      RXELECIDLE => rxelecidle_out(1),
      RXELECIDLEMODE(1 downto 0) => rxelecidlemode_in(3 downto 2),
      RXGEARBOXSLIP => rxgearboxslip_in(1),
      RXHEADER(5 downto 0) => rxheader_out(11 downto 6),
      RXHEADERVALID(1 downto 0) => rxheadervalid_out(3 downto 2),
      RXLATCLK => rxlatclk_in(1),
      RXLPMEN => rxlpmen_in(1),
      RXLPMGCHOLD => rxlpmgchold_in(1),
      RXLPMGCOVRDEN => rxlpmgcovrden_in(1),
      RXLPMHFHOLD => rxlpmhfhold_in(1),
      RXLPMHFOVRDEN => rxlpmhfovrden_in(1),
      RXLPMLFHOLD => rxlpmlfhold_in(1),
      RXLPMLFKLOVRDEN => rxlpmlfklovrden_in(1),
      RXLPMOSHOLD => rxlpmoshold_in(1),
      RXLPMOSOVRDEN => rxlpmosovrden_in(1),
      RXMCOMMAALIGNEN => rxmcommaalignen_in(1),
      RXMONITOROUT(6 downto 0) => rxmonitorout_out(13 downto 7),
      RXMONITORSEL(1 downto 0) => rxmonitorsel_in(3 downto 2),
      RXOOBRESET => rxoobreset_in(1),
      RXOSCALRESET => rxoscalreset_in(1),
      RXOSHOLD => rxoshold_in(1),
      RXOSINTCFG(3 downto 0) => rxosintcfg_in(7 downto 4),
      RXOSINTDONE => rxosintdone_out(1),
      RXOSINTEN => rxosinten_in(1),
      RXOSINTHOLD => rxosinthold_in(1),
      RXOSINTOVRDEN => rxosintovrden_in(1),
      RXOSINTSTARTED => rxosintstarted_out(1),
      RXOSINTSTROBE => rxosintstrobe_in(1),
      RXOSINTSTROBEDONE => rxosintstrobedone_out(1),
      RXOSINTSTROBESTARTED => rxosintstrobestarted_out(1),
      RXOSINTTESTOVRDEN => rxosinttestovrden_in(1),
      RXOSOVRDEN => rxosovrden_in(1),
      RXOUTCLK => rxoutclk_out(1),
      RXOUTCLKFABRIC => rxoutclkfabric_out(1),
      RXOUTCLKPCS => rxoutclkpcs_out(1),
      RXOUTCLKSEL(2 downto 0) => rxoutclksel_in(5 downto 3),
      RXPCOMMAALIGNEN => rxpcommaalignen_in(1),
      RXPCSRESET => rxpcsreset_in(1),
      RXPD(1 downto 0) => rxpd_in(3 downto 2),
      RXPHALIGN => rxphalign_in(1),
      RXPHALIGNDONE => rxphaligndone_out(1),
      RXPHALIGNEN => rxphalignen_in(1),
      RXPHALIGNERR => rxphalignerr_out(1),
      RXPHDLYPD => rxphdlypd_in(1),
      RXPHDLYRESET => rxphdlyreset_in(1),
      RXPHOVRDEN => rxphovrden_in(1),
      RXPLLCLKSEL(1 downto 0) => rxpllclksel_in(3 downto 2),
      RXPMARESET => rxpmareset_in(1),
      RXPMARESETDONE => rxpmaresetdone_out(1),
      RXPOLARITY => rxpolarity_in(1),
      RXPRBSCNTRESET => rxprbscntreset_in(1),
      RXPRBSERR => rxprbserr_out(1),
      RXPRBSLOCKED => rxprbslocked_out(1),
      RXPRBSSEL(3 downto 0) => rxprbssel_in(7 downto 4),
      RXPRGDIVRESETDONE => rxprgdivresetdone_out(1),
      RXPROGDIVRESET => GTHE3_CHANNEL_RXPROGDIVRESET(0),
      RXQPIEN => rxqpien_in(1),
      RXQPISENN => rxqpisenn_out(1),
      RXQPISENP => rxqpisenp_out(1),
      RXRATE(2 downto 0) => rxrate_in(5 downto 3),
      RXRATEDONE => rxratedone_out(1),
      RXRATEMODE => rxratemode_in(1),
      RXRECCLKOUT => rxrecclkout_out(1),
      RXRESETDONE => rxresetdone_out(1),
      RXSLIDE => rxslide_in(1),
      RXSLIDERDY => rxsliderdy_out(1),
      RXSLIPDONE => rxslipdone_out(1),
      RXSLIPOUTCLK => rxslipoutclk_in(1),
      RXSLIPOUTCLKRDY => rxslipoutclkrdy_out(1),
      RXSLIPPMA => rxslippma_in(1),
      RXSLIPPMARDY => rxslippmardy_out(1),
      RXSTARTOFSEQ(1 downto 0) => rxstartofseq_out(3 downto 2),
      RXSTATUS(2 downto 0) => rxstatus_out(5 downto 3),
      RXSYNCALLIN => rxsyncallin_in(1),
      RXSYNCDONE => rxsyncdone_out(1),
      RXSYNCIN => rxsyncin_in(1),
      RXSYNCMODE => rxsyncmode_in(1),
      RXSYNCOUT => rxsyncout_out(1),
      RXSYSCLKSEL(1 downto 0) => rxsysclksel_in(3 downto 2),
      RXUSERRDY => GTHE3_CHANNEL_RXUSERRDY(0),
      RXUSRCLK => rxusrclk_in(1),
      RXUSRCLK2 => rxusrclk2_in(1),
      RXVALID => rxvalid_out(1),
      SIGVALIDCLK => sigvalidclk_in(1),
      TSTIN(19 downto 0) => B"00000000000000000000",
      TX8B10BBYPASS(7 downto 0) => tx8b10bbypass_in(15 downto 8),
      TX8B10BEN => tx8b10ben_in(1),
      TXBUFDIFFCTRL(2 downto 0) => txbufdiffctrl_in(5 downto 3),
      TXBUFSTATUS(1 downto 0) => txbufstatus_out(3 downto 2),
      TXCOMFINISH => txcomfinish_out(1),
      TXCOMINIT => txcominit_in(1),
      TXCOMSAS => txcomsas_in(1),
      TXCOMWAKE => txcomwake_in(1),
      TXCTRL0(15 downto 0) => txctrl0_in(31 downto 16),
      TXCTRL1(15 downto 0) => txctrl1_in(31 downto 16),
      TXCTRL2(7 downto 0) => txctrl2_in(15 downto 8),
      TXDATA(127 downto 32) => B"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      TXDATA(31 downto 0) => gtwiz_userdata_tx_in(63 downto 32),
      TXDATAEXTENDRSVD(7 downto 0) => txdataextendrsvd_in(15 downto 8),
      TXDEEMPH => txdeemph_in(1),
      TXDETECTRX => txdetectrx_in(1),
      TXDIFFCTRL(3 downto 0) => txdiffctrl_in(7 downto 4),
      TXDIFFPD => txdiffpd_in(1),
      TXDLYBYPASS => '0',
      TXDLYEN => '0',
      TXDLYHOLD => '0',
      TXDLYOVRDEN => '0',
      TXDLYSRESET => GTHE3_CHANNEL_TXDLYSRESET(0),
      TXDLYSRESETDONE => txdlysresetdone_out(1),
      TXDLYUPDOWN => '0',
      TXELECIDLE => txelecidle_in(1),
      TXHEADER(5 downto 0) => txheader_in(11 downto 6),
      TXINHIBIT => txinhibit_in(1),
      TXLATCLK => txlatclk_in(1),
      TXMAINCURSOR(6 downto 0) => txmaincursor_in(13 downto 7),
      TXMARGIN(2 downto 0) => txmargin_in(5 downto 3),
      TXOUTCLK => txoutclk_out(1),
      TXOUTCLKFABRIC => txoutclkfabric_out(1),
      TXOUTCLKPCS => txoutclkpcs_out(1),
      TXOUTCLKSEL(2 downto 0) => txoutclksel_in(5 downto 3),
      TXPCSRESET => txpcsreset_in(1),
      TXPD(1 downto 0) => txpd_in(3 downto 2),
      TXPDELECIDLEMODE => txpdelecidlemode_in(1),
      TXPHALIGN => '0',
      TXPHALIGNDONE => txphaligndone_out(1),
      TXPHALIGNEN => '0',
      TXPHDLYPD => '0',
      TXPHDLYRESET => '0',
      TXPHDLYTSTCLK => '0',
      TXPHINIT => '0',
      TXPHINITDONE => txphinitdone_out(1),
      TXPHOVRDEN => '0',
      TXPIPPMEN => txpippmen_in(1),
      TXPIPPMOVRDEN => txpippmovrden_in(1),
      TXPIPPMPD => txpippmpd_in(1),
      TXPIPPMSEL => txpippmsel_in(1),
      TXPIPPMSTEPSIZE(4 downto 0) => txpippmstepsize_in(9 downto 5),
      TXPISOPD => txpisopd_in(1),
      TXPLLCLKSEL(1 downto 0) => txpllclksel_in(3 downto 2),
      TXPMARESET => txpmareset_in(1),
      TXPMARESETDONE => txpmaresetdone_out(1),
      TXPOLARITY => txpolarity_in(1),
      TXPOSTCURSOR(4 downto 0) => txpostcursor_in(9 downto 5),
      TXPOSTCURSORINV => txpostcursorinv_in(1),
      TXPRBSFORCEERR => txprbsforceerr_in(1),
      TXPRBSSEL(3 downto 0) => txprbssel_in(7 downto 4),
      TXPRECURSOR(4 downto 0) => txprecursor_in(9 downto 5),
      TXPRECURSORINV => txprecursorinv_in(1),
      TXPRGDIVRESETDONE => txprgdivresetdone_out(1),
      TXPROGDIVRESET => GTHE3_CHANNEL_TXPROGDIVRESET(0),
      TXQPIBIASEN => txqpibiasen_in(1),
      TXQPISENN => txqpisenn_out(1),
      TXQPISENP => txqpisenp_out(1),
      TXQPISTRONGPDOWN => txqpistrongpdown_in(1),
      TXQPIWEAKPUP => txqpiweakpup_in(1),
      TXRATE(2 downto 0) => txrate_in(5 downto 3),
      TXRATEDONE => txratedone_out(1),
      TXRATEMODE => txratemode_in(1),
      TXRESETDONE => txresetdone_out(1),
      TXSEQUENCE(6 downto 0) => txsequence_in(13 downto 7),
      TXSWING => txswing_in(1),
      TXSYNCALLIN => GTHE3_CHANNEL_TXSYNCALLIN(0),
      TXSYNCDONE => txsyncdone_out(1),
      TXSYNCIN => \^txsyncout_out\(3),
      TXSYNCMODE => '0',
      TXSYNCOUT => \^txsyncout_out\(1),
      TXSYSCLKSEL(1 downto 0) => txsysclksel_in(3 downto 2),
      TXUSERRDY => GTHE3_CHANNEL_TXUSERRDY(0),
      TXUSRCLK => txusrclk_in(1),
      TXUSRCLK2 => txusrclk2_in(1)
    );
\gthe3_channel_gen.gen_gthe3_channel_inst[2].GTHE3_CHANNEL_PRIM_INST\: unisim.vcomponents.GTHE3_CHANNEL
    generic map(
      ACJTAG_DEBUG_MODE => '0',
      ACJTAG_MODE => '0',
      ACJTAG_RESET => '0',
      ADAPT_CFG0 => X"F800",
      ADAPT_CFG1 => X"0000",
      ALIGN_COMMA_DOUBLE => "FALSE",
      ALIGN_COMMA_ENABLE => B"1111111111",
      ALIGN_COMMA_WORD => 1,
      ALIGN_MCOMMA_DET => "TRUE",
      ALIGN_MCOMMA_VALUE => B"1010000011",
      ALIGN_PCOMMA_DET => "TRUE",
      ALIGN_PCOMMA_VALUE => B"0101111100",
      A_RXOSCALRESET => '0',
      A_RXPROGDIVRESET => '0',
      A_TXPROGDIVRESET => '0',
      CBCC_DATA_SOURCE_SEL => "DECODED",
      CDR_SWAP_MODE_EN => '0',
      CHAN_BOND_KEEP_ALIGN => "FALSE",
      CHAN_BOND_MAX_SKEW => 1,
      CHAN_BOND_SEQ_1_1 => B"0000000000",
      CHAN_BOND_SEQ_1_2 => B"0000000000",
      CHAN_BOND_SEQ_1_3 => B"0000000000",
      CHAN_BOND_SEQ_1_4 => B"0000000000",
      CHAN_BOND_SEQ_1_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_1 => B"0000000000",
      CHAN_BOND_SEQ_2_2 => B"0000000000",
      CHAN_BOND_SEQ_2_3 => B"0000000000",
      CHAN_BOND_SEQ_2_4 => B"0000000000",
      CHAN_BOND_SEQ_2_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_USE => "FALSE",
      CHAN_BOND_SEQ_LEN => 1,
      CLK_CORRECT_USE => "FALSE",
      CLK_COR_KEEP_IDLE => "FALSE",
      CLK_COR_MAX_LAT => 12,
      CLK_COR_MIN_LAT => 8,
      CLK_COR_PRECEDENCE => "TRUE",
      CLK_COR_REPEAT_WAIT => 0,
      CLK_COR_SEQ_1_1 => B"0100000000",
      CLK_COR_SEQ_1_2 => B"0100000000",
      CLK_COR_SEQ_1_3 => B"0100000000",
      CLK_COR_SEQ_1_4 => B"0100000000",
      CLK_COR_SEQ_1_ENABLE => B"1111",
      CLK_COR_SEQ_2_1 => B"0100000000",
      CLK_COR_SEQ_2_2 => B"0100000000",
      CLK_COR_SEQ_2_3 => B"0100000000",
      CLK_COR_SEQ_2_4 => B"0100000000",
      CLK_COR_SEQ_2_ENABLE => B"1111",
      CLK_COR_SEQ_2_USE => "FALSE",
      CLK_COR_SEQ_LEN => 1,
      CPLL_CFG0 => X"23FC",
      CPLL_CFG1 => X"A4AC",
      CPLL_CFG2 => X"0004",
      CPLL_CFG3 => B"00" & X"0",
      CPLL_FBDIV => 5,
      CPLL_FBDIV_45 => 4,
      CPLL_INIT_CFG0 => X"02B2",
      CPLL_INIT_CFG1 => X"00",
      CPLL_LOCK_CFG => X"01E8",
      CPLL_REFCLK_DIV => 1,
      DDI_CTRL => B"00",
      DDI_REALIGN_WAIT => 15,
      DEC_MCOMMA_DETECT => "TRUE",
      DEC_PCOMMA_DETECT => "TRUE",
      DEC_VALID_COMMA_ONLY => "FALSE",
      DFE_D_X_REL_POS => '0',
      DFE_VCM_COMP_EN => '0',
      DMONITOR_CFG0 => B"00" & X"00",
      DMONITOR_CFG1 => X"00",
      ES_CLK_PHASE_SEL => '0',
      ES_CONTROL => B"000000",
      ES_ERRDET_EN => "FALSE",
      ES_EYE_SCAN_EN => "FALSE",
      ES_HORZ_OFFSET => X"000",
      ES_PMA_CFG => B"0000000000",
      ES_PRESCALE => B"00000",
      ES_QUALIFIER0 => X"0000",
      ES_QUALIFIER1 => X"0000",
      ES_QUALIFIER2 => X"0000",
      ES_QUALIFIER3 => X"0000",
      ES_QUALIFIER4 => X"0000",
      ES_QUAL_MASK0 => X"0000",
      ES_QUAL_MASK1 => X"0000",
      ES_QUAL_MASK2 => X"0000",
      ES_QUAL_MASK3 => X"0000",
      ES_QUAL_MASK4 => X"0000",
      ES_SDATA_MASK0 => X"0000",
      ES_SDATA_MASK1 => X"0000",
      ES_SDATA_MASK2 => X"0000",
      ES_SDATA_MASK3 => X"0000",
      ES_SDATA_MASK4 => X"0000",
      EVODD_PHI_CFG => B"00000000000",
      EYE_SCAN_SWAP_EN => '0',
      FTS_DESKEW_SEQ_ENABLE => B"1111",
      FTS_LANE_DESKEW_CFG => B"1111",
      FTS_LANE_DESKEW_EN => "FALSE",
      GEARBOX_MODE => B"00000",
      GM_BIAS_SELECT => '0',
      LOCAL_MASTER => '1',
      OOBDIVCTL => B"00",
      OOB_PWRUP => '0',
      PCI3_AUTO_REALIGN => "OVR_1K_BLK",
      PCI3_PIPE_RX_ELECIDLE => '0',
      PCI3_RX_ASYNC_EBUF_BYPASS => B"00",
      PCI3_RX_ELECIDLE_EI2_ENABLE => '0',
      PCI3_RX_ELECIDLE_H2L_COUNT => B"000000",
      PCI3_RX_ELECIDLE_H2L_DISABLE => B"000",
      PCI3_RX_ELECIDLE_HI_COUNT => B"000000",
      PCI3_RX_ELECIDLE_LP4_DISABLE => '0',
      PCI3_RX_FIFO_DISABLE => '0',
      PCIE_BUFG_DIV_CTRL => X"1000",
      PCIE_RXPCS_CFG_GEN3 => X"02A4",
      PCIE_RXPMA_CFG => X"000A",
      PCIE_TXPCS_CFG_GEN3 => X"2CA4",
      PCIE_TXPMA_CFG => X"000A",
      PCS_PCIE_EN => "FALSE",
      PCS_RSVD0 => B"0000000000000000",
      PCS_RSVD1 => B"000",
      PD_TRANS_TIME_FROM_P2 => X"03C",
      PD_TRANS_TIME_NONE_P2 => X"19",
      PD_TRANS_TIME_TO_P2 => X"64",
      PLL_SEL_MODE_GEN12 => B"11",
      PLL_SEL_MODE_GEN3 => B"11",
      PMA_RSV1 => X"E000",
      PROCESS_PAR => B"010",
      RATE_SW_USE_DRP => '1',
      RESET_POWERSAVE_DISABLE => '0',
      RXBUFRESET_TIME => B"00011",
      RXBUF_ADDR_MODE => "FAST",
      RXBUF_EIDLE_HI_CNT => B"1000",
      RXBUF_EIDLE_LO_CNT => B"0000",
      RXBUF_EN => "TRUE",
      RXBUF_RESET_ON_CB_CHANGE => "TRUE",
      RXBUF_RESET_ON_COMMAALIGN => "TRUE",
      RXBUF_RESET_ON_EIDLE => "FALSE",
      RXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      RXBUF_THRESH_OVFLW => 57,
      RXBUF_THRESH_OVRD => "TRUE",
      RXBUF_THRESH_UNDFLW => 3,
      RXCDRFREQRESET_TIME => B"00001",
      RXCDRPHRESET_TIME => B"00001",
      RXCDR_CFG0 => X"0000",
      RXCDR_CFG0_GEN3 => X"0000",
      RXCDR_CFG1 => X"0000",
      RXCDR_CFG1_GEN3 => X"0000",
      RXCDR_CFG2 => X"0766",
      RXCDR_CFG2_GEN3 => X"07E6",
      RXCDR_CFG3 => X"0000",
      RXCDR_CFG3_GEN3 => X"0000",
      RXCDR_CFG4 => X"0000",
      RXCDR_CFG4_GEN3 => X"0000",
      RXCDR_CFG5 => X"0000",
      RXCDR_CFG5_GEN3 => X"0000",
      RXCDR_FR_RESET_ON_EIDLE => '0',
      RXCDR_HOLD_DURING_EIDLE => '0',
      RXCDR_LOCK_CFG0 => X"4480",
      RXCDR_LOCK_CFG1 => X"5FFF",
      RXCDR_LOCK_CFG2 => X"77C3",
      RXCDR_PH_RESET_ON_EIDLE => '0',
      RXCFOK_CFG0 => X"4000",
      RXCFOK_CFG1 => X"0065",
      RXCFOK_CFG2 => X"002E",
      RXDFELPMRESET_TIME => B"0001111",
      RXDFELPM_KL_CFG0 => X"0000",
      RXDFELPM_KL_CFG1 => X"0032",
      RXDFELPM_KL_CFG2 => X"0000",
      RXDFE_CFG0 => X"0A00",
      RXDFE_CFG1 => X"0000",
      RXDFE_GC_CFG0 => X"0000",
      RXDFE_GC_CFG1 => X"7860",
      RXDFE_GC_CFG2 => X"0000",
      RXDFE_H2_CFG0 => X"0000",
      RXDFE_H2_CFG1 => X"0000",
      RXDFE_H3_CFG0 => X"4000",
      RXDFE_H3_CFG1 => X"0000",
      RXDFE_H4_CFG0 => X"2000",
      RXDFE_H4_CFG1 => X"0003",
      RXDFE_H5_CFG0 => X"2000",
      RXDFE_H5_CFG1 => X"0003",
      RXDFE_H6_CFG0 => X"2000",
      RXDFE_H6_CFG1 => X"0000",
      RXDFE_H7_CFG0 => X"2000",
      RXDFE_H7_CFG1 => X"0000",
      RXDFE_H8_CFG0 => X"2000",
      RXDFE_H8_CFG1 => X"0000",
      RXDFE_H9_CFG0 => X"2000",
      RXDFE_H9_CFG1 => X"0000",
      RXDFE_HA_CFG0 => X"2000",
      RXDFE_HA_CFG1 => X"0000",
      RXDFE_HB_CFG0 => X"2000",
      RXDFE_HB_CFG1 => X"0000",
      RXDFE_HC_CFG0 => X"0000",
      RXDFE_HC_CFG1 => X"0000",
      RXDFE_HD_CFG0 => X"0000",
      RXDFE_HD_CFG1 => X"0000",
      RXDFE_HE_CFG0 => X"0000",
      RXDFE_HE_CFG1 => X"0000",
      RXDFE_HF_CFG0 => X"0000",
      RXDFE_HF_CFG1 => X"0000",
      RXDFE_OS_CFG0 => X"8000",
      RXDFE_OS_CFG1 => X"0000",
      RXDFE_UT_CFG0 => X"8000",
      RXDFE_UT_CFG1 => X"0003",
      RXDFE_VP_CFG0 => X"AA00",
      RXDFE_VP_CFG1 => X"0033",
      RXDLY_CFG => X"001F",
      RXDLY_LCFG => X"0030",
      RXELECIDLE_CFG => "Sigcfg_4",
      RXGBOX_FIFO_INIT_RD_ADDR => 4,
      RXGEARBOX_EN => "FALSE",
      RXISCANRESET_TIME => B"00001",
      RXLPM_CFG => X"0000",
      RXLPM_GC_CFG => X"1000",
      RXLPM_KH_CFG0 => X"0000",
      RXLPM_KH_CFG1 => X"0002",
      RXLPM_OS_CFG0 => X"8000",
      RXLPM_OS_CFG1 => X"0002",
      RXOOB_CFG => B"000000110",
      RXOOB_CLK_CFG => "PMA",
      RXOSCALRESET_TIME => B"00011",
      RXOUT_DIV => 1,
      RXPCSRESET_TIME => B"00011",
      RXPHBEACON_CFG => X"0000",
      RXPHDLY_CFG => X"2020",
      RXPHSAMP_CFG => X"2100",
      RXPHSLIP_CFG => X"6622",
      RXPH_MONITOR_SEL => B"00000",
      RXPI_CFG0 => B"01",
      RXPI_CFG1 => B"01",
      RXPI_CFG2 => B"01",
      RXPI_CFG3 => B"01",
      RXPI_CFG4 => '0',
      RXPI_CFG5 => '0',
      RXPI_CFG6 => B"000",
      RXPI_LPM => '0',
      RXPI_VREFSEL => '0',
      RXPMACLK_SEL => "DATA",
      RXPMARESET_TIME => B"00011",
      RXPRBS_ERR_LOOPBACK => '0',
      RXPRBS_LINKACQ_CNT => 15,
      RXSLIDE_AUTO_WAIT => 7,
      RXSLIDE_MODE => "OFF",
      RXSYNC_MULTILANE => '1',
      RXSYNC_OVRD => '0',
      RXSYNC_SKIP_DA => '0',
      RX_AFE_CM_EN => '0',
      RX_BIAS_CFG0 => X"0AB4",
      RX_BUFFER_CFG => B"000000",
      RX_CAPFF_SARC_ENB => '0',
      RX_CLK25_DIV => 13,
      RX_CLKMUX_EN => '1',
      RX_CLK_SLIP_OVRD => B"00000",
      RX_CM_BUF_CFG => B"1010",
      RX_CM_BUF_PD => '0',
      RX_CM_SEL => B"11",
      RX_CM_TRIM => B"1010",
      RX_CTLE3_LPF => B"00000001",
      RX_DATA_WIDTH => 40,
      RX_DDI_SEL => B"000000",
      RX_DEFER_RESET_BUF_EN => "TRUE",
      RX_DFELPM_CFG0 => B"0110",
      RX_DFELPM_CFG1 => '1',
      RX_DFELPM_KLKH_AGC_STUP_EN => '1',
      RX_DFE_AGC_CFG0 => B"10",
      RX_DFE_AGC_CFG1 => B"000",
      RX_DFE_KL_LPM_KH_CFG0 => B"01",
      RX_DFE_KL_LPM_KH_CFG1 => B"000",
      RX_DFE_KL_LPM_KL_CFG0 => B"01",
      RX_DFE_KL_LPM_KL_CFG1 => B"000",
      RX_DFE_LPM_HOLD_DURING_EIDLE => '0',
      RX_DISPERR_SEQ_MATCH => "TRUE",
      RX_DIVRESET_TIME => B"00001",
      RX_EN_HI_LR => '1',
      RX_EYESCAN_VS_CODE => B"0000000",
      RX_EYESCAN_VS_NEG_DIR => '0',
      RX_EYESCAN_VS_RANGE => B"00",
      RX_EYESCAN_VS_UT_SIGN => '0',
      RX_FABINT_USRCLK_FLOP => '0',
      RX_INT_DATAWIDTH => 1,
      RX_PMA_POWER_SAVE => '0',
      RX_PROGDIV_CFG => 0.000000,
      RX_SAMPLE_PERIOD => B"111",
      RX_SIG_VALID_DLY => 11,
      RX_SUM_DFETAPREP_EN => '0',
      RX_SUM_IREF_TUNE => B"1100",
      RX_SUM_RES_CTRL => B"11",
      RX_SUM_VCMTUNE => B"0000",
      RX_SUM_VCM_OVWR => '0',
      RX_SUM_VREF_TUNE => B"000",
      RX_TUNE_AFE_OS => B"10",
      RX_WIDEMODE_CDR => '1',
      RX_XCLK_SEL => "RXDES",
      SAS_MAX_COM => 64,
      SAS_MIN_COM => 36,
      SATA_BURST_SEQ_LEN => B"1110",
      SATA_BURST_VAL => B"100",
      SATA_CPLL_CFG => "VCO_3000MHZ",
      SATA_EIDLE_VAL => B"100",
      SATA_MAX_BURST => 8,
      SATA_MAX_INIT => 21,
      SATA_MAX_WAKE => 7,
      SATA_MIN_BURST => 4,
      SATA_MIN_INIT => 12,
      SATA_MIN_WAKE => 4,
      SHOW_REALIGN_COMMA => "FALSE",
      SIM_MODE => "FAST",
      SIM_RECEIVER_DETECT_PASS => "TRUE",
      SIM_RESET_SPEEDUP => "TRUE",
      SIM_TX_EIDLE_DRIVE_LEVEL => '0',
      SIM_VERSION => 2,
      TAPDLY_SET_TX => B"00",
      TEMPERATUR_PAR => B"0010",
      TERM_RCAL_CFG => B"100001000010000",
      TERM_RCAL_OVRD => B"000",
      TRANS_TIME_RATE => X"0E",
      TST_RSV0 => X"00",
      TST_RSV1 => X"00",
      TXBUF_EN => "FALSE",
      TXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      TXDLY_CFG => X"0009",
      TXDLY_LCFG => X"0050",
      TXDRVBIAS_N => B"1010",
      TXDRVBIAS_P => B"1010",
      TXFIFO_ADDR_CFG => "LOW",
      TXGBOX_FIFO_INIT_RD_ADDR => 4,
      TXGEARBOX_EN => "FALSE",
      TXOUT_DIV => 1,
      TXPCSRESET_TIME => B"00011",
      TXPHDLY_CFG0 => X"2020",
      TXPHDLY_CFG1 => X"0075",
      TXPH_CFG => X"0980",
      TXPH_MONITOR_SEL => B"00000",
      TXPI_CFG0 => B"01",
      TXPI_CFG1 => B"01",
      TXPI_CFG2 => B"01",
      TXPI_CFG3 => '0',
      TXPI_CFG4 => '0',
      TXPI_CFG5 => B"000",
      TXPI_GRAY_SEL => '0',
      TXPI_INVSTROBE_SEL => '0',
      TXPI_LPM => '0',
      TXPI_PPMCLK_SEL => "TXUSRCLK2",
      TXPI_PPM_CFG => B"00000000",
      TXPI_SYNFREQ_PPM => B"001",
      TXPI_VREFSEL => '0',
      TXPMARESET_TIME => B"00011",
      TXSYNC_MULTILANE => '1',
      TXSYNC_OVRD => '0',
      TXSYNC_SKIP_DA => '0',
      TX_CLK25_DIV => 13,
      TX_CLKMUX_EN => '1',
      TX_DATA_WIDTH => 40,
      TX_DCD_CFG => B"000010",
      TX_DCD_EN => '0',
      TX_DEEMPH0 => B"000000",
      TX_DEEMPH1 => B"000000",
      TX_DIVRESET_TIME => B"00001",
      TX_DRIVE_MODE => "DIRECT",
      TX_EIDLE_ASSERT_DELAY => B"100",
      TX_EIDLE_DEASSERT_DELAY => B"011",
      TX_EML_PHI_TUNE => '0',
      TX_FABINT_USRCLK_FLOP => '0',
      TX_IDLE_DATA_ZERO => '0',
      TX_INT_DATAWIDTH => 1,
      TX_LOOPBACK_DRIVE_HIZ => "FALSE",
      TX_MAINCURSOR_SEL => '0',
      TX_MARGIN_FULL_0 => B"1001111",
      TX_MARGIN_FULL_1 => B"1001110",
      TX_MARGIN_FULL_2 => B"1001100",
      TX_MARGIN_FULL_3 => B"1001010",
      TX_MARGIN_FULL_4 => B"1001000",
      TX_MARGIN_LOW_0 => B"1000110",
      TX_MARGIN_LOW_1 => B"1000101",
      TX_MARGIN_LOW_2 => B"1000011",
      TX_MARGIN_LOW_3 => B"1000010",
      TX_MARGIN_LOW_4 => B"1000000",
      TX_MODE_SEL => B"000",
      TX_PMADATA_OPT => '0',
      TX_PMA_POWER_SAVE => '0',
      TX_PROGCLK_SEL => "PREPI",
      TX_PROGDIV_CFG => 20.000000,
      TX_QPI_STATUS_EN => '0',
      TX_RXDETECT_CFG => B"00" & X"032",
      TX_RXDETECT_REF => B"100",
      TX_SAMPLE_PERIOD => B"111",
      TX_SARC_LPBK_ENB => '0',
      TX_XCLK_SEL => "TXUSR",
      USE_PCS_CLK_PHASE_SEL => '0',
      WB_MODE => B"00"
    )
        port map (
      BUFGTCE(2 downto 0) => bufgtce_out(8 downto 6),
      BUFGTCEMASK(2 downto 0) => bufgtcemask_out(8 downto 6),
      BUFGTDIV(8 downto 0) => bufgtdiv_out(26 downto 18),
      BUFGTRESET(2 downto 0) => bufgtreset_out(8 downto 6),
      BUFGTRSTMASK(2 downto 0) => bufgtrstmask_out(8 downto 6),
      CFGRESET => cfgreset_in(2),
      CLKRSVD0 => clkrsvd0_in(2),
      CLKRSVD1 => clkrsvd1_in(2),
      CPLLFBCLKLOST => cpllfbclklost_out(2),
      CPLLLOCK => \^cplllock_out\(2),
      CPLLLOCKDETCLK => cplllockdetclk_in(2),
      CPLLLOCKEN => cplllocken_in(2),
      CPLLPD => GTHE3_CHANNEL_CPLLPD(0),
      CPLLREFCLKLOST => cpllrefclklost_out(2),
      CPLLREFCLKSEL(2 downto 0) => cpllrefclksel_in(8 downto 6),
      CPLLRESET => cpllreset_in(2),
      DMONFIFORESET => dmonfiforeset_in(2),
      DMONITORCLK => dmonitorclk_in(2),
      DMONITOROUT(16 downto 0) => dmonitorout_out(50 downto 34),
      DRPADDR(8 downto 0) => drpaddr_in(26 downto 18),
      DRPCLK => drpclk_in(2),
      DRPDI(15 downto 0) => drpdi_in(47 downto 32),
      DRPDO(15 downto 0) => drpdo_out(47 downto 32),
      DRPEN => drpen_in(2),
      DRPRDY => drprdy_out(2),
      DRPWE => drpwe_in(2),
      EVODDPHICALDONE => evoddphicaldone_in(2),
      EVODDPHICALSTART => evoddphicalstart_in(2),
      EVODDPHIDRDEN => evoddphidrden_in(2),
      EVODDPHIDWREN => evoddphidwren_in(2),
      EVODDPHIXRDEN => evoddphixrden_in(2),
      EVODDPHIXWREN => evoddphixwren_in(2),
      EYESCANDATAERROR => eyescandataerror_out(2),
      EYESCANMODE => eyescanmode_in(2),
      EYESCANRESET => eyescanreset_in(2),
      EYESCANTRIGGER => eyescantrigger_in(2),
      GTGREFCLK => gtgrefclk_in(2),
      GTHRXN => gthrxn_in(2),
      GTHRXP => gthrxp_in(2),
      GTHTXN => gthtxn_out(2),
      GTHTXP => gthtxp_out(2),
      GTNORTHREFCLK0 => gtnorthrefclk0_in(2),
      GTNORTHREFCLK1 => gtnorthrefclk1_in(2),
      GTPOWERGOOD => gtpowergood_out(2),
      GTREFCLK0 => gtrefclk0_in(2),
      GTREFCLK1 => gtrefclk1_in(2),
      GTREFCLKMONITOR => gtrefclkmonitor_out(2),
      GTRESETSEL => gtresetsel_in(2),
      GTRSVD(15 downto 0) => gtrsvd_in(47 downto 32),
      GTRXRESET => GTHE3_CHANNEL_GTRXRESET(0),
      GTSOUTHREFCLK0 => gtsouthrefclk0_in(2),
      GTSOUTHREFCLK1 => gtsouthrefclk1_in(2),
      GTTXRESET => GTHE3_CHANNEL_GTTXRESET(0),
      LOOPBACK(2 downto 0) => loopback_in(8 downto 6),
      LPBKRXTXSEREN => lpbkrxtxseren_in(2),
      LPBKTXRXSEREN => lpbktxrxseren_in(2),
      PCIEEQRXEQADAPTDONE => pcieeqrxeqadaptdone_in(2),
      PCIERATEGEN3 => pcierategen3_out(2),
      PCIERATEIDLE => pcierateidle_out(2),
      PCIERATEQPLLPD(1 downto 0) => pcierateqpllpd_out(5 downto 4),
      PCIERATEQPLLRESET(1 downto 0) => pcierateqpllreset_out(5 downto 4),
      PCIERSTIDLE => pcierstidle_in(2),
      PCIERSTTXSYNCSTART => pciersttxsyncstart_in(2),
      PCIESYNCTXSYNCDONE => pciesynctxsyncdone_out(2),
      PCIEUSERGEN3RDY => pcieusergen3rdy_out(2),
      PCIEUSERPHYSTATUSRST => pcieuserphystatusrst_out(2),
      PCIEUSERRATEDONE => pcieuserratedone_in(2),
      PCIEUSERRATESTART => pcieuserratestart_out(2),
      PCSRSVDIN(15 downto 0) => pcsrsvdin_in(47 downto 32),
      PCSRSVDIN2(4 downto 0) => pcsrsvdin2_in(14 downto 10),
      PCSRSVDOUT(11 downto 0) => pcsrsvdout_out(35 downto 24),
      PHYSTATUS => phystatus_out(2),
      PINRSRVDAS(7 downto 0) => pinrsrvdas_out(23 downto 16),
      PMARSVDIN(4 downto 0) => pmarsvdin_in(14 downto 10),
      QPLL0CLK => qpll0clk_in(2),
      QPLL0REFCLK => qpll0refclk_in(2),
      QPLL1CLK => qpll1clk_in(2),
      QPLL1REFCLK => qpll1refclk_in(2),
      RESETEXCEPTION => resetexception_out(2),
      RESETOVRD => resetovrd_in(2),
      RSTCLKENTX => rstclkentx_in(2),
      RX8B10BEN => rx8b10ben_in(2),
      RXBUFRESET => rxbufreset_in(2),
      RXBUFSTATUS(2 downto 0) => rxbufstatus_out(8 downto 6),
      RXBYTEISALIGNED => rxbyteisaligned_out(2),
      RXBYTEREALIGN => rxbyterealign_out(2),
      RXCDRFREQRESET => rxcdrfreqreset_in(2),
      RXCDRHOLD => rxcdrhold_in(2),
      RXCDRLOCK => rxcdrlock_out(2),
      RXCDROVRDEN => rxcdrovrden_in(2),
      RXCDRPHDONE => rxcdrphdone_out(2),
      RXCDRRESET => rxcdrreset_in(2),
      RXCDRRESETRSV => rxcdrresetrsv_in(2),
      RXCHANBONDSEQ => rxchanbondseq_out(2),
      RXCHANISALIGNED => rxchanisaligned_out(2),
      RXCHANREALIGN => rxchanrealign_out(2),
      RXCHBONDEN => rxchbonden_in(2),
      RXCHBONDI(4 downto 0) => rxchbondi_in(14 downto 10),
      RXCHBONDLEVEL(2 downto 0) => rxchbondlevel_in(8 downto 6),
      RXCHBONDMASTER => rxchbondmaster_in(2),
      RXCHBONDO(4 downto 0) => rxchbondo_out(14 downto 10),
      RXCHBONDSLAVE => rxchbondslave_in(2),
      RXCLKCORCNT(1 downto 0) => rxclkcorcnt_out(5 downto 4),
      RXCOMINITDET => rxcominitdet_out(2),
      RXCOMMADET => rxcommadet_out(2),
      RXCOMMADETEN => rxcommadeten_in(2),
      RXCOMSASDET => rxcomsasdet_out(2),
      RXCOMWAKEDET => rxcomwakedet_out(2),
      RXCTRL0(15 downto 0) => rxctrl0_out(47 downto 32),
      RXCTRL1(15 downto 0) => rxctrl1_out(47 downto 32),
      RXCTRL2(7 downto 0) => rxctrl2_out(23 downto 16),
      RXCTRL3(7 downto 0) => rxctrl3_out(23 downto 16),
      RXDATA(127 downto 0) => rxdata_out(383 downto 256),
      RXDATAEXTENDRSVD(7 downto 0) => rxdataextendrsvd_out(23 downto 16),
      RXDATAVALID(1 downto 0) => rxdatavalid_out(5 downto 4),
      RXDFEAGCCTRL(1 downto 0) => rxdfeagcctrl_in(5 downto 4),
      RXDFEAGCHOLD => rxdfeagchold_in(2),
      RXDFEAGCOVRDEN => rxdfeagcovrden_in(2),
      RXDFELFHOLD => rxdfelfhold_in(2),
      RXDFELFOVRDEN => rxdfelfovrden_in(2),
      RXDFELPMRESET => rxdfelpmreset_in(2),
      RXDFETAP10HOLD => rxdfetap10hold_in(2),
      RXDFETAP10OVRDEN => rxdfetap10ovrden_in(2),
      RXDFETAP11HOLD => rxdfetap11hold_in(2),
      RXDFETAP11OVRDEN => rxdfetap11ovrden_in(2),
      RXDFETAP12HOLD => rxdfetap12hold_in(2),
      RXDFETAP12OVRDEN => rxdfetap12ovrden_in(2),
      RXDFETAP13HOLD => rxdfetap13hold_in(2),
      RXDFETAP13OVRDEN => rxdfetap13ovrden_in(2),
      RXDFETAP14HOLD => rxdfetap14hold_in(2),
      RXDFETAP14OVRDEN => rxdfetap14ovrden_in(2),
      RXDFETAP15HOLD => rxdfetap15hold_in(2),
      RXDFETAP15OVRDEN => rxdfetap15ovrden_in(2),
      RXDFETAP2HOLD => rxdfetap2hold_in(2),
      RXDFETAP2OVRDEN => rxdfetap2ovrden_in(2),
      RXDFETAP3HOLD => rxdfetap3hold_in(2),
      RXDFETAP3OVRDEN => rxdfetap3ovrden_in(2),
      RXDFETAP4HOLD => rxdfetap4hold_in(2),
      RXDFETAP4OVRDEN => rxdfetap4ovrden_in(2),
      RXDFETAP5HOLD => rxdfetap5hold_in(2),
      RXDFETAP5OVRDEN => rxdfetap5ovrden_in(2),
      RXDFETAP6HOLD => rxdfetap6hold_in(2),
      RXDFETAP6OVRDEN => rxdfetap6ovrden_in(2),
      RXDFETAP7HOLD => rxdfetap7hold_in(2),
      RXDFETAP7OVRDEN => rxdfetap7ovrden_in(2),
      RXDFETAP8HOLD => rxdfetap8hold_in(2),
      RXDFETAP8OVRDEN => rxdfetap8ovrden_in(2),
      RXDFETAP9HOLD => rxdfetap9hold_in(2),
      RXDFETAP9OVRDEN => rxdfetap9ovrden_in(2),
      RXDFEUTHOLD => rxdfeuthold_in(2),
      RXDFEUTOVRDEN => rxdfeutovrden_in(2),
      RXDFEVPHOLD => rxdfevphold_in(2),
      RXDFEVPOVRDEN => rxdfevpovrden_in(2),
      RXDFEVSEN => rxdfevsen_in(2),
      RXDFEXYDEN => rxdfexyden_in(2),
      RXDLYBYPASS => rxdlybypass_in(2),
      RXDLYEN => rxdlyen_in(2),
      RXDLYOVRDEN => rxdlyovrden_in(2),
      RXDLYSRESET => rxdlysreset_in(2),
      RXDLYSRESETDONE => rxdlysresetdone_out(2),
      RXELECIDLE => rxelecidle_out(2),
      RXELECIDLEMODE(1 downto 0) => rxelecidlemode_in(5 downto 4),
      RXGEARBOXSLIP => rxgearboxslip_in(2),
      RXHEADER(5 downto 0) => rxheader_out(17 downto 12),
      RXHEADERVALID(1 downto 0) => rxheadervalid_out(5 downto 4),
      RXLATCLK => rxlatclk_in(2),
      RXLPMEN => rxlpmen_in(2),
      RXLPMGCHOLD => rxlpmgchold_in(2),
      RXLPMGCOVRDEN => rxlpmgcovrden_in(2),
      RXLPMHFHOLD => rxlpmhfhold_in(2),
      RXLPMHFOVRDEN => rxlpmhfovrden_in(2),
      RXLPMLFHOLD => rxlpmlfhold_in(2),
      RXLPMLFKLOVRDEN => rxlpmlfklovrden_in(2),
      RXLPMOSHOLD => rxlpmoshold_in(2),
      RXLPMOSOVRDEN => rxlpmosovrden_in(2),
      RXMCOMMAALIGNEN => rxmcommaalignen_in(2),
      RXMONITOROUT(6 downto 0) => rxmonitorout_out(20 downto 14),
      RXMONITORSEL(1 downto 0) => rxmonitorsel_in(5 downto 4),
      RXOOBRESET => rxoobreset_in(2),
      RXOSCALRESET => rxoscalreset_in(2),
      RXOSHOLD => rxoshold_in(2),
      RXOSINTCFG(3 downto 0) => rxosintcfg_in(11 downto 8),
      RXOSINTDONE => rxosintdone_out(2),
      RXOSINTEN => rxosinten_in(2),
      RXOSINTHOLD => rxosinthold_in(2),
      RXOSINTOVRDEN => rxosintovrden_in(2),
      RXOSINTSTARTED => rxosintstarted_out(2),
      RXOSINTSTROBE => rxosintstrobe_in(2),
      RXOSINTSTROBEDONE => rxosintstrobedone_out(2),
      RXOSINTSTROBESTARTED => rxosintstrobestarted_out(2),
      RXOSINTTESTOVRDEN => rxosinttestovrden_in(2),
      RXOSOVRDEN => rxosovrden_in(2),
      RXOUTCLK => rxoutclk_out(2),
      RXOUTCLKFABRIC => rxoutclkfabric_out(2),
      RXOUTCLKPCS => rxoutclkpcs_out(2),
      RXOUTCLKSEL(2 downto 0) => rxoutclksel_in(8 downto 6),
      RXPCOMMAALIGNEN => rxpcommaalignen_in(2),
      RXPCSRESET => rxpcsreset_in(2),
      RXPD(1 downto 0) => rxpd_in(5 downto 4),
      RXPHALIGN => rxphalign_in(2),
      RXPHALIGNDONE => rxphaligndone_out(2),
      RXPHALIGNEN => rxphalignen_in(2),
      RXPHALIGNERR => rxphalignerr_out(2),
      RXPHDLYPD => rxphdlypd_in(2),
      RXPHDLYRESET => rxphdlyreset_in(2),
      RXPHOVRDEN => rxphovrden_in(2),
      RXPLLCLKSEL(1 downto 0) => rxpllclksel_in(5 downto 4),
      RXPMARESET => rxpmareset_in(2),
      RXPMARESETDONE => rxpmaresetdone_out(2),
      RXPOLARITY => rxpolarity_in(2),
      RXPRBSCNTRESET => rxprbscntreset_in(2),
      RXPRBSERR => rxprbserr_out(2),
      RXPRBSLOCKED => rxprbslocked_out(2),
      RXPRBSSEL(3 downto 0) => rxprbssel_in(11 downto 8),
      RXPRGDIVRESETDONE => rxprgdivresetdone_out(2),
      RXPROGDIVRESET => GTHE3_CHANNEL_RXPROGDIVRESET(0),
      RXQPIEN => rxqpien_in(2),
      RXQPISENN => rxqpisenn_out(2),
      RXQPISENP => rxqpisenp_out(2),
      RXRATE(2 downto 0) => rxrate_in(8 downto 6),
      RXRATEDONE => rxratedone_out(2),
      RXRATEMODE => rxratemode_in(2),
      RXRECCLKOUT => rxrecclkout_out(2),
      RXRESETDONE => rxresetdone_out(2),
      RXSLIDE => rxslide_in(2),
      RXSLIDERDY => rxsliderdy_out(2),
      RXSLIPDONE => rxslipdone_out(2),
      RXSLIPOUTCLK => rxslipoutclk_in(2),
      RXSLIPOUTCLKRDY => rxslipoutclkrdy_out(2),
      RXSLIPPMA => rxslippma_in(2),
      RXSLIPPMARDY => rxslippmardy_out(2),
      RXSTARTOFSEQ(1 downto 0) => rxstartofseq_out(5 downto 4),
      RXSTATUS(2 downto 0) => rxstatus_out(8 downto 6),
      RXSYNCALLIN => rxsyncallin_in(2),
      RXSYNCDONE => rxsyncdone_out(2),
      RXSYNCIN => rxsyncin_in(2),
      RXSYNCMODE => rxsyncmode_in(2),
      RXSYNCOUT => rxsyncout_out(2),
      RXSYSCLKSEL(1 downto 0) => rxsysclksel_in(5 downto 4),
      RXUSERRDY => GTHE3_CHANNEL_RXUSERRDY(0),
      RXUSRCLK => rxusrclk_in(2),
      RXUSRCLK2 => rxusrclk2_in(2),
      RXVALID => rxvalid_out(2),
      SIGVALIDCLK => sigvalidclk_in(2),
      TSTIN(19 downto 0) => B"00000000000000000000",
      TX8B10BBYPASS(7 downto 0) => tx8b10bbypass_in(23 downto 16),
      TX8B10BEN => tx8b10ben_in(2),
      TXBUFDIFFCTRL(2 downto 0) => txbufdiffctrl_in(8 downto 6),
      TXBUFSTATUS(1 downto 0) => txbufstatus_out(5 downto 4),
      TXCOMFINISH => txcomfinish_out(2),
      TXCOMINIT => txcominit_in(2),
      TXCOMSAS => txcomsas_in(2),
      TXCOMWAKE => txcomwake_in(2),
      TXCTRL0(15 downto 0) => txctrl0_in(47 downto 32),
      TXCTRL1(15 downto 0) => txctrl1_in(47 downto 32),
      TXCTRL2(7 downto 0) => txctrl2_in(23 downto 16),
      TXDATA(127 downto 32) => B"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      TXDATA(31 downto 0) => gtwiz_userdata_tx_in(95 downto 64),
      TXDATAEXTENDRSVD(7 downto 0) => txdataextendrsvd_in(23 downto 16),
      TXDEEMPH => txdeemph_in(2),
      TXDETECTRX => txdetectrx_in(2),
      TXDIFFCTRL(3 downto 0) => txdiffctrl_in(11 downto 8),
      TXDIFFPD => txdiffpd_in(2),
      TXDLYBYPASS => '0',
      TXDLYEN => '0',
      TXDLYHOLD => '0',
      TXDLYOVRDEN => '0',
      TXDLYSRESET => GTHE3_CHANNEL_TXDLYSRESET(0),
      TXDLYSRESETDONE => txdlysresetdone_out(2),
      TXDLYUPDOWN => '0',
      TXELECIDLE => txelecidle_in(2),
      TXHEADER(5 downto 0) => txheader_in(17 downto 12),
      TXINHIBIT => txinhibit_in(2),
      TXLATCLK => txlatclk_in(2),
      TXMAINCURSOR(6 downto 0) => txmaincursor_in(20 downto 14),
      TXMARGIN(2 downto 0) => txmargin_in(8 downto 6),
      TXOUTCLK => txoutclk_out(2),
      TXOUTCLKFABRIC => txoutclkfabric_out(2),
      TXOUTCLKPCS => txoutclkpcs_out(2),
      TXOUTCLKSEL(2 downto 0) => txoutclksel_in(8 downto 6),
      TXPCSRESET => txpcsreset_in(2),
      TXPD(1 downto 0) => txpd_in(5 downto 4),
      TXPDELECIDLEMODE => txpdelecidlemode_in(2),
      TXPHALIGN => '0',
      TXPHALIGNDONE => txphaligndone_out(2),
      TXPHALIGNEN => '0',
      TXPHDLYPD => '0',
      TXPHDLYRESET => '0',
      TXPHDLYTSTCLK => '0',
      TXPHINIT => '0',
      TXPHINITDONE => txphinitdone_out(2),
      TXPHOVRDEN => '0',
      TXPIPPMEN => txpippmen_in(2),
      TXPIPPMOVRDEN => txpippmovrden_in(2),
      TXPIPPMPD => txpippmpd_in(2),
      TXPIPPMSEL => txpippmsel_in(2),
      TXPIPPMSTEPSIZE(4 downto 0) => txpippmstepsize_in(14 downto 10),
      TXPISOPD => txpisopd_in(2),
      TXPLLCLKSEL(1 downto 0) => txpllclksel_in(5 downto 4),
      TXPMARESET => txpmareset_in(2),
      TXPMARESETDONE => txpmaresetdone_out(2),
      TXPOLARITY => txpolarity_in(2),
      TXPOSTCURSOR(4 downto 0) => txpostcursor_in(14 downto 10),
      TXPOSTCURSORINV => txpostcursorinv_in(2),
      TXPRBSFORCEERR => txprbsforceerr_in(2),
      TXPRBSSEL(3 downto 0) => txprbssel_in(11 downto 8),
      TXPRECURSOR(4 downto 0) => txprecursor_in(14 downto 10),
      TXPRECURSORINV => txprecursorinv_in(2),
      TXPRGDIVRESETDONE => txprgdivresetdone_out(2),
      TXPROGDIVRESET => GTHE3_CHANNEL_TXPROGDIVRESET(0),
      TXQPIBIASEN => txqpibiasen_in(2),
      TXQPISENN => txqpisenn_out(2),
      TXQPISENP => txqpisenp_out(2),
      TXQPISTRONGPDOWN => txqpistrongpdown_in(2),
      TXQPIWEAKPUP => txqpiweakpup_in(2),
      TXRATE(2 downto 0) => txrate_in(8 downto 6),
      TXRATEDONE => txratedone_out(2),
      TXRATEMODE => txratemode_in(2),
      TXRESETDONE => txresetdone_out(2),
      TXSEQUENCE(6 downto 0) => txsequence_in(20 downto 14),
      TXSWING => txswing_in(2),
      TXSYNCALLIN => GTHE3_CHANNEL_TXSYNCALLIN(0),
      TXSYNCDONE => txsyncdone_out(2),
      TXSYNCIN => \^txsyncout_out\(3),
      TXSYNCMODE => '0',
      TXSYNCOUT => \^txsyncout_out\(2),
      TXSYSCLKSEL(1 downto 0) => txsysclksel_in(5 downto 4),
      TXUSERRDY => GTHE3_CHANNEL_TXUSERRDY(0),
      TXUSRCLK => txusrclk_in(2),
      TXUSRCLK2 => txusrclk2_in(2)
    );
\gthe3_channel_gen.gen_gthe3_channel_inst[3].GTHE3_CHANNEL_PRIM_INST\: unisim.vcomponents.GTHE3_CHANNEL
    generic map(
      ACJTAG_DEBUG_MODE => '0',
      ACJTAG_MODE => '0',
      ACJTAG_RESET => '0',
      ADAPT_CFG0 => X"F800",
      ADAPT_CFG1 => X"0000",
      ALIGN_COMMA_DOUBLE => "FALSE",
      ALIGN_COMMA_ENABLE => B"1111111111",
      ALIGN_COMMA_WORD => 1,
      ALIGN_MCOMMA_DET => "TRUE",
      ALIGN_MCOMMA_VALUE => B"1010000011",
      ALIGN_PCOMMA_DET => "TRUE",
      ALIGN_PCOMMA_VALUE => B"0101111100",
      A_RXOSCALRESET => '0',
      A_RXPROGDIVRESET => '0',
      A_TXPROGDIVRESET => '0',
      CBCC_DATA_SOURCE_SEL => "DECODED",
      CDR_SWAP_MODE_EN => '0',
      CHAN_BOND_KEEP_ALIGN => "FALSE",
      CHAN_BOND_MAX_SKEW => 1,
      CHAN_BOND_SEQ_1_1 => B"0000000000",
      CHAN_BOND_SEQ_1_2 => B"0000000000",
      CHAN_BOND_SEQ_1_3 => B"0000000000",
      CHAN_BOND_SEQ_1_4 => B"0000000000",
      CHAN_BOND_SEQ_1_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_1 => B"0000000000",
      CHAN_BOND_SEQ_2_2 => B"0000000000",
      CHAN_BOND_SEQ_2_3 => B"0000000000",
      CHAN_BOND_SEQ_2_4 => B"0000000000",
      CHAN_BOND_SEQ_2_ENABLE => B"1111",
      CHAN_BOND_SEQ_2_USE => "FALSE",
      CHAN_BOND_SEQ_LEN => 1,
      CLK_CORRECT_USE => "FALSE",
      CLK_COR_KEEP_IDLE => "FALSE",
      CLK_COR_MAX_LAT => 12,
      CLK_COR_MIN_LAT => 8,
      CLK_COR_PRECEDENCE => "TRUE",
      CLK_COR_REPEAT_WAIT => 0,
      CLK_COR_SEQ_1_1 => B"0100000000",
      CLK_COR_SEQ_1_2 => B"0100000000",
      CLK_COR_SEQ_1_3 => B"0100000000",
      CLK_COR_SEQ_1_4 => B"0100000000",
      CLK_COR_SEQ_1_ENABLE => B"1111",
      CLK_COR_SEQ_2_1 => B"0100000000",
      CLK_COR_SEQ_2_2 => B"0100000000",
      CLK_COR_SEQ_2_3 => B"0100000000",
      CLK_COR_SEQ_2_4 => B"0100000000",
      CLK_COR_SEQ_2_ENABLE => B"1111",
      CLK_COR_SEQ_2_USE => "FALSE",
      CLK_COR_SEQ_LEN => 1,
      CPLL_CFG0 => X"23FC",
      CPLL_CFG1 => X"A4AC",
      CPLL_CFG2 => X"0004",
      CPLL_CFG3 => B"00" & X"0",
      CPLL_FBDIV => 5,
      CPLL_FBDIV_45 => 4,
      CPLL_INIT_CFG0 => X"02B2",
      CPLL_INIT_CFG1 => X"00",
      CPLL_LOCK_CFG => X"01E8",
      CPLL_REFCLK_DIV => 1,
      DDI_CTRL => B"00",
      DDI_REALIGN_WAIT => 15,
      DEC_MCOMMA_DETECT => "TRUE",
      DEC_PCOMMA_DETECT => "TRUE",
      DEC_VALID_COMMA_ONLY => "FALSE",
      DFE_D_X_REL_POS => '0',
      DFE_VCM_COMP_EN => '0',
      DMONITOR_CFG0 => B"00" & X"00",
      DMONITOR_CFG1 => X"00",
      ES_CLK_PHASE_SEL => '0',
      ES_CONTROL => B"000000",
      ES_ERRDET_EN => "FALSE",
      ES_EYE_SCAN_EN => "FALSE",
      ES_HORZ_OFFSET => X"000",
      ES_PMA_CFG => B"0000000000",
      ES_PRESCALE => B"00000",
      ES_QUALIFIER0 => X"0000",
      ES_QUALIFIER1 => X"0000",
      ES_QUALIFIER2 => X"0000",
      ES_QUALIFIER3 => X"0000",
      ES_QUALIFIER4 => X"0000",
      ES_QUAL_MASK0 => X"0000",
      ES_QUAL_MASK1 => X"0000",
      ES_QUAL_MASK2 => X"0000",
      ES_QUAL_MASK3 => X"0000",
      ES_QUAL_MASK4 => X"0000",
      ES_SDATA_MASK0 => X"0000",
      ES_SDATA_MASK1 => X"0000",
      ES_SDATA_MASK2 => X"0000",
      ES_SDATA_MASK3 => X"0000",
      ES_SDATA_MASK4 => X"0000",
      EVODD_PHI_CFG => B"00000000000",
      EYE_SCAN_SWAP_EN => '0',
      FTS_DESKEW_SEQ_ENABLE => B"1111",
      FTS_LANE_DESKEW_CFG => B"1111",
      FTS_LANE_DESKEW_EN => "FALSE",
      GEARBOX_MODE => B"00000",
      GM_BIAS_SELECT => '0',
      LOCAL_MASTER => '1',
      OOBDIVCTL => B"00",
      OOB_PWRUP => '0',
      PCI3_AUTO_REALIGN => "OVR_1K_BLK",
      PCI3_PIPE_RX_ELECIDLE => '0',
      PCI3_RX_ASYNC_EBUF_BYPASS => B"00",
      PCI3_RX_ELECIDLE_EI2_ENABLE => '0',
      PCI3_RX_ELECIDLE_H2L_COUNT => B"000000",
      PCI3_RX_ELECIDLE_H2L_DISABLE => B"000",
      PCI3_RX_ELECIDLE_HI_COUNT => B"000000",
      PCI3_RX_ELECIDLE_LP4_DISABLE => '0',
      PCI3_RX_FIFO_DISABLE => '0',
      PCIE_BUFG_DIV_CTRL => X"1000",
      PCIE_RXPCS_CFG_GEN3 => X"02A4",
      PCIE_RXPMA_CFG => X"000A",
      PCIE_TXPCS_CFG_GEN3 => X"2CA4",
      PCIE_TXPMA_CFG => X"000A",
      PCS_PCIE_EN => "FALSE",
      PCS_RSVD0 => B"0000000000000000",
      PCS_RSVD1 => B"000",
      PD_TRANS_TIME_FROM_P2 => X"03C",
      PD_TRANS_TIME_NONE_P2 => X"19",
      PD_TRANS_TIME_TO_P2 => X"64",
      PLL_SEL_MODE_GEN12 => B"11",
      PLL_SEL_MODE_GEN3 => B"11",
      PMA_RSV1 => X"E000",
      PROCESS_PAR => B"010",
      RATE_SW_USE_DRP => '1',
      RESET_POWERSAVE_DISABLE => '0',
      RXBUFRESET_TIME => B"00011",
      RXBUF_ADDR_MODE => "FAST",
      RXBUF_EIDLE_HI_CNT => B"1000",
      RXBUF_EIDLE_LO_CNT => B"0000",
      RXBUF_EN => "TRUE",
      RXBUF_RESET_ON_CB_CHANGE => "TRUE",
      RXBUF_RESET_ON_COMMAALIGN => "TRUE",
      RXBUF_RESET_ON_EIDLE => "FALSE",
      RXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      RXBUF_THRESH_OVFLW => 57,
      RXBUF_THRESH_OVRD => "TRUE",
      RXBUF_THRESH_UNDFLW => 3,
      RXCDRFREQRESET_TIME => B"00001",
      RXCDRPHRESET_TIME => B"00001",
      RXCDR_CFG0 => X"0000",
      RXCDR_CFG0_GEN3 => X"0000",
      RXCDR_CFG1 => X"0000",
      RXCDR_CFG1_GEN3 => X"0000",
      RXCDR_CFG2 => X"0766",
      RXCDR_CFG2_GEN3 => X"07E6",
      RXCDR_CFG3 => X"0000",
      RXCDR_CFG3_GEN3 => X"0000",
      RXCDR_CFG4 => X"0000",
      RXCDR_CFG4_GEN3 => X"0000",
      RXCDR_CFG5 => X"0000",
      RXCDR_CFG5_GEN3 => X"0000",
      RXCDR_FR_RESET_ON_EIDLE => '0',
      RXCDR_HOLD_DURING_EIDLE => '0',
      RXCDR_LOCK_CFG0 => X"4480",
      RXCDR_LOCK_CFG1 => X"5FFF",
      RXCDR_LOCK_CFG2 => X"77C3",
      RXCDR_PH_RESET_ON_EIDLE => '0',
      RXCFOK_CFG0 => X"4000",
      RXCFOK_CFG1 => X"0065",
      RXCFOK_CFG2 => X"002E",
      RXDFELPMRESET_TIME => B"0001111",
      RXDFELPM_KL_CFG0 => X"0000",
      RXDFELPM_KL_CFG1 => X"0032",
      RXDFELPM_KL_CFG2 => X"0000",
      RXDFE_CFG0 => X"0A00",
      RXDFE_CFG1 => X"0000",
      RXDFE_GC_CFG0 => X"0000",
      RXDFE_GC_CFG1 => X"7860",
      RXDFE_GC_CFG2 => X"0000",
      RXDFE_H2_CFG0 => X"0000",
      RXDFE_H2_CFG1 => X"0000",
      RXDFE_H3_CFG0 => X"4000",
      RXDFE_H3_CFG1 => X"0000",
      RXDFE_H4_CFG0 => X"2000",
      RXDFE_H4_CFG1 => X"0003",
      RXDFE_H5_CFG0 => X"2000",
      RXDFE_H5_CFG1 => X"0003",
      RXDFE_H6_CFG0 => X"2000",
      RXDFE_H6_CFG1 => X"0000",
      RXDFE_H7_CFG0 => X"2000",
      RXDFE_H7_CFG1 => X"0000",
      RXDFE_H8_CFG0 => X"2000",
      RXDFE_H8_CFG1 => X"0000",
      RXDFE_H9_CFG0 => X"2000",
      RXDFE_H9_CFG1 => X"0000",
      RXDFE_HA_CFG0 => X"2000",
      RXDFE_HA_CFG1 => X"0000",
      RXDFE_HB_CFG0 => X"2000",
      RXDFE_HB_CFG1 => X"0000",
      RXDFE_HC_CFG0 => X"0000",
      RXDFE_HC_CFG1 => X"0000",
      RXDFE_HD_CFG0 => X"0000",
      RXDFE_HD_CFG1 => X"0000",
      RXDFE_HE_CFG0 => X"0000",
      RXDFE_HE_CFG1 => X"0000",
      RXDFE_HF_CFG0 => X"0000",
      RXDFE_HF_CFG1 => X"0000",
      RXDFE_OS_CFG0 => X"8000",
      RXDFE_OS_CFG1 => X"0000",
      RXDFE_UT_CFG0 => X"8000",
      RXDFE_UT_CFG1 => X"0003",
      RXDFE_VP_CFG0 => X"AA00",
      RXDFE_VP_CFG1 => X"0033",
      RXDLY_CFG => X"001F",
      RXDLY_LCFG => X"0030",
      RXELECIDLE_CFG => "Sigcfg_4",
      RXGBOX_FIFO_INIT_RD_ADDR => 4,
      RXGEARBOX_EN => "FALSE",
      RXISCANRESET_TIME => B"00001",
      RXLPM_CFG => X"0000",
      RXLPM_GC_CFG => X"1000",
      RXLPM_KH_CFG0 => X"0000",
      RXLPM_KH_CFG1 => X"0002",
      RXLPM_OS_CFG0 => X"8000",
      RXLPM_OS_CFG1 => X"0002",
      RXOOB_CFG => B"000000110",
      RXOOB_CLK_CFG => "PMA",
      RXOSCALRESET_TIME => B"00011",
      RXOUT_DIV => 1,
      RXPCSRESET_TIME => B"00011",
      RXPHBEACON_CFG => X"0000",
      RXPHDLY_CFG => X"2020",
      RXPHSAMP_CFG => X"2100",
      RXPHSLIP_CFG => X"6622",
      RXPH_MONITOR_SEL => B"00000",
      RXPI_CFG0 => B"01",
      RXPI_CFG1 => B"01",
      RXPI_CFG2 => B"01",
      RXPI_CFG3 => B"01",
      RXPI_CFG4 => '0',
      RXPI_CFG5 => '0',
      RXPI_CFG6 => B"000",
      RXPI_LPM => '0',
      RXPI_VREFSEL => '0',
      RXPMACLK_SEL => "DATA",
      RXPMARESET_TIME => B"00011",
      RXPRBS_ERR_LOOPBACK => '0',
      RXPRBS_LINKACQ_CNT => 15,
      RXSLIDE_AUTO_WAIT => 7,
      RXSLIDE_MODE => "OFF",
      RXSYNC_MULTILANE => '1',
      RXSYNC_OVRD => '0',
      RXSYNC_SKIP_DA => '0',
      RX_AFE_CM_EN => '0',
      RX_BIAS_CFG0 => X"0AB4",
      RX_BUFFER_CFG => B"000000",
      RX_CAPFF_SARC_ENB => '0',
      RX_CLK25_DIV => 13,
      RX_CLKMUX_EN => '1',
      RX_CLK_SLIP_OVRD => B"00000",
      RX_CM_BUF_CFG => B"1010",
      RX_CM_BUF_PD => '0',
      RX_CM_SEL => B"11",
      RX_CM_TRIM => B"1010",
      RX_CTLE3_LPF => B"00000001",
      RX_DATA_WIDTH => 40,
      RX_DDI_SEL => B"000000",
      RX_DEFER_RESET_BUF_EN => "TRUE",
      RX_DFELPM_CFG0 => B"0110",
      RX_DFELPM_CFG1 => '1',
      RX_DFELPM_KLKH_AGC_STUP_EN => '1',
      RX_DFE_AGC_CFG0 => B"10",
      RX_DFE_AGC_CFG1 => B"000",
      RX_DFE_KL_LPM_KH_CFG0 => B"01",
      RX_DFE_KL_LPM_KH_CFG1 => B"000",
      RX_DFE_KL_LPM_KL_CFG0 => B"01",
      RX_DFE_KL_LPM_KL_CFG1 => B"000",
      RX_DFE_LPM_HOLD_DURING_EIDLE => '0',
      RX_DISPERR_SEQ_MATCH => "TRUE",
      RX_DIVRESET_TIME => B"00001",
      RX_EN_HI_LR => '1',
      RX_EYESCAN_VS_CODE => B"0000000",
      RX_EYESCAN_VS_NEG_DIR => '0',
      RX_EYESCAN_VS_RANGE => B"00",
      RX_EYESCAN_VS_UT_SIGN => '0',
      RX_FABINT_USRCLK_FLOP => '0',
      RX_INT_DATAWIDTH => 1,
      RX_PMA_POWER_SAVE => '0',
      RX_PROGDIV_CFG => 0.000000,
      RX_SAMPLE_PERIOD => B"111",
      RX_SIG_VALID_DLY => 11,
      RX_SUM_DFETAPREP_EN => '0',
      RX_SUM_IREF_TUNE => B"1100",
      RX_SUM_RES_CTRL => B"11",
      RX_SUM_VCMTUNE => B"0000",
      RX_SUM_VCM_OVWR => '0',
      RX_SUM_VREF_TUNE => B"000",
      RX_TUNE_AFE_OS => B"10",
      RX_WIDEMODE_CDR => '1',
      RX_XCLK_SEL => "RXDES",
      SAS_MAX_COM => 64,
      SAS_MIN_COM => 36,
      SATA_BURST_SEQ_LEN => B"1110",
      SATA_BURST_VAL => B"100",
      SATA_CPLL_CFG => "VCO_3000MHZ",
      SATA_EIDLE_VAL => B"100",
      SATA_MAX_BURST => 8,
      SATA_MAX_INIT => 21,
      SATA_MAX_WAKE => 7,
      SATA_MIN_BURST => 4,
      SATA_MIN_INIT => 12,
      SATA_MIN_WAKE => 4,
      SHOW_REALIGN_COMMA => "FALSE",
      SIM_MODE => "FAST",
      SIM_RECEIVER_DETECT_PASS => "TRUE",
      SIM_RESET_SPEEDUP => "TRUE",
      SIM_TX_EIDLE_DRIVE_LEVEL => '0',
      SIM_VERSION => 2,
      TAPDLY_SET_TX => B"00",
      TEMPERATUR_PAR => B"0010",
      TERM_RCAL_CFG => B"100001000010000",
      TERM_RCAL_OVRD => B"000",
      TRANS_TIME_RATE => X"0E",
      TST_RSV0 => X"00",
      TST_RSV1 => X"00",
      TXBUF_EN => "FALSE",
      TXBUF_RESET_ON_RATE_CHANGE => "TRUE",
      TXDLY_CFG => X"0009",
      TXDLY_LCFG => X"0050",
      TXDRVBIAS_N => B"1010",
      TXDRVBIAS_P => B"1010",
      TXFIFO_ADDR_CFG => "LOW",
      TXGBOX_FIFO_INIT_RD_ADDR => 4,
      TXGEARBOX_EN => "FALSE",
      TXOUT_DIV => 1,
      TXPCSRESET_TIME => B"00011",
      TXPHDLY_CFG0 => X"2020",
      TXPHDLY_CFG1 => X"0075",
      TXPH_CFG => X"0980",
      TXPH_MONITOR_SEL => B"00000",
      TXPI_CFG0 => B"01",
      TXPI_CFG1 => B"01",
      TXPI_CFG2 => B"01",
      TXPI_CFG3 => '0',
      TXPI_CFG4 => '0',
      TXPI_CFG5 => B"000",
      TXPI_GRAY_SEL => '0',
      TXPI_INVSTROBE_SEL => '0',
      TXPI_LPM => '0',
      TXPI_PPMCLK_SEL => "TXUSRCLK2",
      TXPI_PPM_CFG => B"00000000",
      TXPI_SYNFREQ_PPM => B"001",
      TXPI_VREFSEL => '0',
      TXPMARESET_TIME => B"00011",
      TXSYNC_MULTILANE => '1',
      TXSYNC_OVRD => '0',
      TXSYNC_SKIP_DA => '0',
      TX_CLK25_DIV => 13,
      TX_CLKMUX_EN => '1',
      TX_DATA_WIDTH => 40,
      TX_DCD_CFG => B"000010",
      TX_DCD_EN => '0',
      TX_DEEMPH0 => B"000000",
      TX_DEEMPH1 => B"000000",
      TX_DIVRESET_TIME => B"00001",
      TX_DRIVE_MODE => "DIRECT",
      TX_EIDLE_ASSERT_DELAY => B"100",
      TX_EIDLE_DEASSERT_DELAY => B"011",
      TX_EML_PHI_TUNE => '0',
      TX_FABINT_USRCLK_FLOP => '0',
      TX_IDLE_DATA_ZERO => '0',
      TX_INT_DATAWIDTH => 1,
      TX_LOOPBACK_DRIVE_HIZ => "FALSE",
      TX_MAINCURSOR_SEL => '0',
      TX_MARGIN_FULL_0 => B"1001111",
      TX_MARGIN_FULL_1 => B"1001110",
      TX_MARGIN_FULL_2 => B"1001100",
      TX_MARGIN_FULL_3 => B"1001010",
      TX_MARGIN_FULL_4 => B"1001000",
      TX_MARGIN_LOW_0 => B"1000110",
      TX_MARGIN_LOW_1 => B"1000101",
      TX_MARGIN_LOW_2 => B"1000011",
      TX_MARGIN_LOW_3 => B"1000010",
      TX_MARGIN_LOW_4 => B"1000000",
      TX_MODE_SEL => B"000",
      TX_PMADATA_OPT => '0',
      TX_PMA_POWER_SAVE => '0',
      TX_PROGCLK_SEL => "PREPI",
      TX_PROGDIV_CFG => 20.000000,
      TX_QPI_STATUS_EN => '0',
      TX_RXDETECT_CFG => B"00" & X"032",
      TX_RXDETECT_REF => B"100",
      TX_SAMPLE_PERIOD => B"111",
      TX_SARC_LPBK_ENB => '0',
      TX_XCLK_SEL => "TXUSR",
      USE_PCS_CLK_PHASE_SEL => '0',
      WB_MODE => B"00"
    )
        port map (
      BUFGTCE(2 downto 0) => bufgtce_out(11 downto 9),
      BUFGTCEMASK(2 downto 0) => bufgtcemask_out(11 downto 9),
      BUFGTDIV(8 downto 0) => bufgtdiv_out(35 downto 27),
      BUFGTRESET(2 downto 0) => bufgtreset_out(11 downto 9),
      BUFGTRSTMASK(2 downto 0) => bufgtrstmask_out(11 downto 9),
      CFGRESET => cfgreset_in(3),
      CLKRSVD0 => clkrsvd0_in(3),
      CLKRSVD1 => clkrsvd1_in(3),
      CPLLFBCLKLOST => cpllfbclklost_out(3),
      CPLLLOCK => \^cplllock_out\(3),
      CPLLLOCKDETCLK => cplllockdetclk_in(3),
      CPLLLOCKEN => cplllocken_in(3),
      CPLLPD => GTHE3_CHANNEL_CPLLPD(0),
      CPLLREFCLKLOST => cpllrefclklost_out(3),
      CPLLREFCLKSEL(2 downto 0) => cpllrefclksel_in(11 downto 9),
      CPLLRESET => cpllreset_in(3),
      DMONFIFORESET => dmonfiforeset_in(3),
      DMONITORCLK => dmonitorclk_in(3),
      DMONITOROUT(16 downto 0) => dmonitorout_out(67 downto 51),
      DRPADDR(8 downto 0) => drpaddr_in(35 downto 27),
      DRPCLK => drpclk_in(3),
      DRPDI(15 downto 0) => drpdi_in(63 downto 48),
      DRPDO(15 downto 0) => drpdo_out(63 downto 48),
      DRPEN => drpen_in(3),
      DRPRDY => drprdy_out(3),
      DRPWE => drpwe_in(3),
      EVODDPHICALDONE => evoddphicaldone_in(3),
      EVODDPHICALSTART => evoddphicalstart_in(3),
      EVODDPHIDRDEN => evoddphidrden_in(3),
      EVODDPHIDWREN => evoddphidwren_in(3),
      EVODDPHIXRDEN => evoddphixrden_in(3),
      EVODDPHIXWREN => evoddphixwren_in(3),
      EYESCANDATAERROR => eyescandataerror_out(3),
      EYESCANMODE => eyescanmode_in(3),
      EYESCANRESET => eyescanreset_in(3),
      EYESCANTRIGGER => eyescantrigger_in(3),
      GTGREFCLK => gtgrefclk_in(3),
      GTHRXN => gthrxn_in(3),
      GTHRXP => gthrxp_in(3),
      GTHTXN => gthtxn_out(3),
      GTHTXP => gthtxp_out(3),
      GTNORTHREFCLK0 => gtnorthrefclk0_in(3),
      GTNORTHREFCLK1 => gtnorthrefclk1_in(3),
      GTPOWERGOOD => gtpowergood_out(3),
      GTREFCLK0 => gtrefclk0_in(3),
      GTREFCLK1 => gtrefclk1_in(3),
      GTREFCLKMONITOR => gtrefclkmonitor_out(3),
      GTRESETSEL => gtresetsel_in(3),
      GTRSVD(15 downto 0) => gtrsvd_in(63 downto 48),
      GTRXRESET => GTHE3_CHANNEL_GTRXRESET(0),
      GTSOUTHREFCLK0 => gtsouthrefclk0_in(3),
      GTSOUTHREFCLK1 => gtsouthrefclk1_in(3),
      GTTXRESET => GTHE3_CHANNEL_GTTXRESET(0),
      LOOPBACK(2 downto 0) => loopback_in(11 downto 9),
      LPBKRXTXSEREN => lpbkrxtxseren_in(3),
      LPBKTXRXSEREN => lpbktxrxseren_in(3),
      PCIEEQRXEQADAPTDONE => pcieeqrxeqadaptdone_in(3),
      PCIERATEGEN3 => pcierategen3_out(3),
      PCIERATEIDLE => pcierateidle_out(3),
      PCIERATEQPLLPD(1 downto 0) => pcierateqpllpd_out(7 downto 6),
      PCIERATEQPLLRESET(1 downto 0) => pcierateqpllreset_out(7 downto 6),
      PCIERSTIDLE => pcierstidle_in(3),
      PCIERSTTXSYNCSTART => pciersttxsyncstart_in(3),
      PCIESYNCTXSYNCDONE => pciesynctxsyncdone_out(3),
      PCIEUSERGEN3RDY => pcieusergen3rdy_out(3),
      PCIEUSERPHYSTATUSRST => pcieuserphystatusrst_out(3),
      PCIEUSERRATEDONE => pcieuserratedone_in(3),
      PCIEUSERRATESTART => pcieuserratestart_out(3),
      PCSRSVDIN(15 downto 0) => pcsrsvdin_in(63 downto 48),
      PCSRSVDIN2(4 downto 0) => pcsrsvdin2_in(19 downto 15),
      PCSRSVDOUT(11 downto 0) => pcsrsvdout_out(47 downto 36),
      PHYSTATUS => phystatus_out(3),
      PINRSRVDAS(7 downto 0) => pinrsrvdas_out(31 downto 24),
      PMARSVDIN(4 downto 0) => pmarsvdin_in(19 downto 15),
      QPLL0CLK => qpll0clk_in(3),
      QPLL0REFCLK => qpll0refclk_in(3),
      QPLL1CLK => qpll1clk_in(3),
      QPLL1REFCLK => qpll1refclk_in(3),
      RESETEXCEPTION => resetexception_out(3),
      RESETOVRD => resetovrd_in(3),
      RSTCLKENTX => rstclkentx_in(3),
      RX8B10BEN => rx8b10ben_in(3),
      RXBUFRESET => rxbufreset_in(3),
      RXBUFSTATUS(2 downto 0) => rxbufstatus_out(11 downto 9),
      RXBYTEISALIGNED => rxbyteisaligned_out(3),
      RXBYTEREALIGN => rxbyterealign_out(3),
      RXCDRFREQRESET => rxcdrfreqreset_in(3),
      RXCDRHOLD => rxcdrhold_in(3),
      RXCDRLOCK => rxcdrlock_out(3),
      RXCDROVRDEN => rxcdrovrden_in(3),
      RXCDRPHDONE => rxcdrphdone_out(3),
      RXCDRRESET => rxcdrreset_in(3),
      RXCDRRESETRSV => rxcdrresetrsv_in(3),
      RXCHANBONDSEQ => rxchanbondseq_out(3),
      RXCHANISALIGNED => rxchanisaligned_out(3),
      RXCHANREALIGN => rxchanrealign_out(3),
      RXCHBONDEN => rxchbonden_in(3),
      RXCHBONDI(4 downto 0) => rxchbondi_in(19 downto 15),
      RXCHBONDLEVEL(2 downto 0) => rxchbondlevel_in(11 downto 9),
      RXCHBONDMASTER => rxchbondmaster_in(3),
      RXCHBONDO(4 downto 0) => rxchbondo_out(19 downto 15),
      RXCHBONDSLAVE => rxchbondslave_in(3),
      RXCLKCORCNT(1 downto 0) => rxclkcorcnt_out(7 downto 6),
      RXCOMINITDET => rxcominitdet_out(3),
      RXCOMMADET => rxcommadet_out(3),
      RXCOMMADETEN => rxcommadeten_in(3),
      RXCOMSASDET => rxcomsasdet_out(3),
      RXCOMWAKEDET => rxcomwakedet_out(3),
      RXCTRL0(15 downto 0) => rxctrl0_out(63 downto 48),
      RXCTRL1(15 downto 0) => rxctrl1_out(63 downto 48),
      RXCTRL2(7 downto 0) => rxctrl2_out(31 downto 24),
      RXCTRL3(7 downto 0) => rxctrl3_out(31 downto 24),
      RXDATA(127 downto 0) => rxdata_out(511 downto 384),
      RXDATAEXTENDRSVD(7 downto 0) => rxdataextendrsvd_out(31 downto 24),
      RXDATAVALID(1 downto 0) => rxdatavalid_out(7 downto 6),
      RXDFEAGCCTRL(1 downto 0) => rxdfeagcctrl_in(7 downto 6),
      RXDFEAGCHOLD => rxdfeagchold_in(3),
      RXDFEAGCOVRDEN => rxdfeagcovrden_in(3),
      RXDFELFHOLD => rxdfelfhold_in(3),
      RXDFELFOVRDEN => rxdfelfovrden_in(3),
      RXDFELPMRESET => rxdfelpmreset_in(3),
      RXDFETAP10HOLD => rxdfetap10hold_in(3),
      RXDFETAP10OVRDEN => rxdfetap10ovrden_in(3),
      RXDFETAP11HOLD => rxdfetap11hold_in(3),
      RXDFETAP11OVRDEN => rxdfetap11ovrden_in(3),
      RXDFETAP12HOLD => rxdfetap12hold_in(3),
      RXDFETAP12OVRDEN => rxdfetap12ovrden_in(3),
      RXDFETAP13HOLD => rxdfetap13hold_in(3),
      RXDFETAP13OVRDEN => rxdfetap13ovrden_in(3),
      RXDFETAP14HOLD => rxdfetap14hold_in(3),
      RXDFETAP14OVRDEN => rxdfetap14ovrden_in(3),
      RXDFETAP15HOLD => rxdfetap15hold_in(3),
      RXDFETAP15OVRDEN => rxdfetap15ovrden_in(3),
      RXDFETAP2HOLD => rxdfetap2hold_in(3),
      RXDFETAP2OVRDEN => rxdfetap2ovrden_in(3),
      RXDFETAP3HOLD => rxdfetap3hold_in(3),
      RXDFETAP3OVRDEN => rxdfetap3ovrden_in(3),
      RXDFETAP4HOLD => rxdfetap4hold_in(3),
      RXDFETAP4OVRDEN => rxdfetap4ovrden_in(3),
      RXDFETAP5HOLD => rxdfetap5hold_in(3),
      RXDFETAP5OVRDEN => rxdfetap5ovrden_in(3),
      RXDFETAP6HOLD => rxdfetap6hold_in(3),
      RXDFETAP6OVRDEN => rxdfetap6ovrden_in(3),
      RXDFETAP7HOLD => rxdfetap7hold_in(3),
      RXDFETAP7OVRDEN => rxdfetap7ovrden_in(3),
      RXDFETAP8HOLD => rxdfetap8hold_in(3),
      RXDFETAP8OVRDEN => rxdfetap8ovrden_in(3),
      RXDFETAP9HOLD => rxdfetap9hold_in(3),
      RXDFETAP9OVRDEN => rxdfetap9ovrden_in(3),
      RXDFEUTHOLD => rxdfeuthold_in(3),
      RXDFEUTOVRDEN => rxdfeutovrden_in(3),
      RXDFEVPHOLD => rxdfevphold_in(3),
      RXDFEVPOVRDEN => rxdfevpovrden_in(3),
      RXDFEVSEN => rxdfevsen_in(3),
      RXDFEXYDEN => rxdfexyden_in(3),
      RXDLYBYPASS => rxdlybypass_in(3),
      RXDLYEN => rxdlyen_in(3),
      RXDLYOVRDEN => rxdlyovrden_in(3),
      RXDLYSRESET => rxdlysreset_in(3),
      RXDLYSRESETDONE => rxdlysresetdone_out(3),
      RXELECIDLE => rxelecidle_out(3),
      RXELECIDLEMODE(1 downto 0) => rxelecidlemode_in(7 downto 6),
      RXGEARBOXSLIP => rxgearboxslip_in(3),
      RXHEADER(5 downto 0) => rxheader_out(23 downto 18),
      RXHEADERVALID(1 downto 0) => rxheadervalid_out(7 downto 6),
      RXLATCLK => rxlatclk_in(3),
      RXLPMEN => rxlpmen_in(3),
      RXLPMGCHOLD => rxlpmgchold_in(3),
      RXLPMGCOVRDEN => rxlpmgcovrden_in(3),
      RXLPMHFHOLD => rxlpmhfhold_in(3),
      RXLPMHFOVRDEN => rxlpmhfovrden_in(3),
      RXLPMLFHOLD => rxlpmlfhold_in(3),
      RXLPMLFKLOVRDEN => rxlpmlfklovrden_in(3),
      RXLPMOSHOLD => rxlpmoshold_in(3),
      RXLPMOSOVRDEN => rxlpmosovrden_in(3),
      RXMCOMMAALIGNEN => rxmcommaalignen_in(3),
      RXMONITOROUT(6 downto 0) => rxmonitorout_out(27 downto 21),
      RXMONITORSEL(1 downto 0) => rxmonitorsel_in(7 downto 6),
      RXOOBRESET => rxoobreset_in(3),
      RXOSCALRESET => rxoscalreset_in(3),
      RXOSHOLD => rxoshold_in(3),
      RXOSINTCFG(3 downto 0) => rxosintcfg_in(15 downto 12),
      RXOSINTDONE => rxosintdone_out(3),
      RXOSINTEN => rxosinten_in(3),
      RXOSINTHOLD => rxosinthold_in(3),
      RXOSINTOVRDEN => rxosintovrden_in(3),
      RXOSINTSTARTED => rxosintstarted_out(3),
      RXOSINTSTROBE => rxosintstrobe_in(3),
      RXOSINTSTROBEDONE => rxosintstrobedone_out(3),
      RXOSINTSTROBESTARTED => rxosintstrobestarted_out(3),
      RXOSINTTESTOVRDEN => rxosinttestovrden_in(3),
      RXOSOVRDEN => rxosovrden_in(3),
      RXOUTCLK => rxoutclk_out(3),
      RXOUTCLKFABRIC => rxoutclkfabric_out(3),
      RXOUTCLKPCS => rxoutclkpcs_out(3),
      RXOUTCLKSEL(2 downto 0) => rxoutclksel_in(11 downto 9),
      RXPCOMMAALIGNEN => rxpcommaalignen_in(3),
      RXPCSRESET => rxpcsreset_in(3),
      RXPD(1 downto 0) => rxpd_in(7 downto 6),
      RXPHALIGN => rxphalign_in(3),
      RXPHALIGNDONE => rxphaligndone_out(3),
      RXPHALIGNEN => rxphalignen_in(3),
      RXPHALIGNERR => rxphalignerr_out(3),
      RXPHDLYPD => rxphdlypd_in(3),
      RXPHDLYRESET => rxphdlyreset_in(3),
      RXPHOVRDEN => rxphovrden_in(3),
      RXPLLCLKSEL(1 downto 0) => rxpllclksel_in(7 downto 6),
      RXPMARESET => rxpmareset_in(3),
      RXPMARESETDONE => rxpmaresetdone_out(3),
      RXPOLARITY => rxpolarity_in(3),
      RXPRBSCNTRESET => rxprbscntreset_in(3),
      RXPRBSERR => rxprbserr_out(3),
      RXPRBSLOCKED => rxprbslocked_out(3),
      RXPRBSSEL(3 downto 0) => rxprbssel_in(15 downto 12),
      RXPRGDIVRESETDONE => rxprgdivresetdone_out(3),
      RXPROGDIVRESET => GTHE3_CHANNEL_RXPROGDIVRESET(0),
      RXQPIEN => rxqpien_in(3),
      RXQPISENN => rxqpisenn_out(3),
      RXQPISENP => rxqpisenp_out(3),
      RXRATE(2 downto 0) => rxrate_in(11 downto 9),
      RXRATEDONE => rxratedone_out(3),
      RXRATEMODE => rxratemode_in(3),
      RXRECCLKOUT => rxrecclkout_out(3),
      RXRESETDONE => rxresetdone_out(3),
      RXSLIDE => rxslide_in(3),
      RXSLIDERDY => rxsliderdy_out(3),
      RXSLIPDONE => rxslipdone_out(3),
      RXSLIPOUTCLK => rxslipoutclk_in(3),
      RXSLIPOUTCLKRDY => rxslipoutclkrdy_out(3),
      RXSLIPPMA => rxslippma_in(3),
      RXSLIPPMARDY => rxslippmardy_out(3),
      RXSTARTOFSEQ(1 downto 0) => rxstartofseq_out(7 downto 6),
      RXSTATUS(2 downto 0) => rxstatus_out(11 downto 9),
      RXSYNCALLIN => rxsyncallin_in(3),
      RXSYNCDONE => rxsyncdone_out(3),
      RXSYNCIN => rxsyncin_in(3),
      RXSYNCMODE => rxsyncmode_in(3),
      RXSYNCOUT => rxsyncout_out(3),
      RXSYSCLKSEL(1 downto 0) => rxsysclksel_in(7 downto 6),
      RXUSERRDY => GTHE3_CHANNEL_RXUSERRDY(0),
      RXUSRCLK => rxusrclk_in(3),
      RXUSRCLK2 => rxusrclk2_in(3),
      RXVALID => rxvalid_out(3),
      SIGVALIDCLK => sigvalidclk_in(3),
      TSTIN(19 downto 0) => B"00000000000000000000",
      TX8B10BBYPASS(7 downto 0) => tx8b10bbypass_in(31 downto 24),
      TX8B10BEN => tx8b10ben_in(3),
      TXBUFDIFFCTRL(2 downto 0) => txbufdiffctrl_in(11 downto 9),
      TXBUFSTATUS(1 downto 0) => txbufstatus_out(7 downto 6),
      TXCOMFINISH => txcomfinish_out(3),
      TXCOMINIT => txcominit_in(3),
      TXCOMSAS => txcomsas_in(3),
      TXCOMWAKE => txcomwake_in(3),
      TXCTRL0(15 downto 0) => txctrl0_in(63 downto 48),
      TXCTRL1(15 downto 0) => txctrl1_in(63 downto 48),
      TXCTRL2(7 downto 0) => txctrl2_in(31 downto 24),
      TXDATA(127 downto 32) => B"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      TXDATA(31 downto 0) => gtwiz_userdata_tx_in(127 downto 96),
      TXDATAEXTENDRSVD(7 downto 0) => txdataextendrsvd_in(31 downto 24),
      TXDEEMPH => txdeemph_in(3),
      TXDETECTRX => txdetectrx_in(3),
      TXDIFFCTRL(3 downto 0) => txdiffctrl_in(15 downto 12),
      TXDIFFPD => txdiffpd_in(3),
      TXDLYBYPASS => '0',
      TXDLYEN => '0',
      TXDLYHOLD => '0',
      TXDLYOVRDEN => '0',
      TXDLYSRESET => GTHE3_CHANNEL_TXDLYSRESET(0),
      TXDLYSRESETDONE => txdlysresetdone_out(3),
      TXDLYUPDOWN => '0',
      TXELECIDLE => txelecidle_in(3),
      TXHEADER(5 downto 0) => txheader_in(23 downto 18),
      TXINHIBIT => txinhibit_in(3),
      TXLATCLK => txlatclk_in(3),
      TXMAINCURSOR(6 downto 0) => txmaincursor_in(27 downto 21),
      TXMARGIN(2 downto 0) => txmargin_in(11 downto 9),
      TXOUTCLK => txoutclk_out(3),
      TXOUTCLKFABRIC => txoutclkfabric_out(3),
      TXOUTCLKPCS => txoutclkpcs_out(3),
      TXOUTCLKSEL(2 downto 0) => txoutclksel_in(11 downto 9),
      TXPCSRESET => txpcsreset_in(3),
      TXPD(1 downto 0) => txpd_in(7 downto 6),
      TXPDELECIDLEMODE => txpdelecidlemode_in(3),
      TXPHALIGN => '0',
      TXPHALIGNDONE => txphaligndone_out(3),
      TXPHALIGNEN => '0',
      TXPHDLYPD => '0',
      TXPHDLYRESET => '0',
      TXPHDLYTSTCLK => '0',
      TXPHINIT => '0',
      TXPHINITDONE => txphinitdone_out(3),
      TXPHOVRDEN => '0',
      TXPIPPMEN => txpippmen_in(3),
      TXPIPPMOVRDEN => txpippmovrden_in(3),
      TXPIPPMPD => txpippmpd_in(3),
      TXPIPPMSEL => txpippmsel_in(3),
      TXPIPPMSTEPSIZE(4 downto 0) => txpippmstepsize_in(19 downto 15),
      TXPISOPD => txpisopd_in(3),
      TXPLLCLKSEL(1 downto 0) => txpllclksel_in(7 downto 6),
      TXPMARESET => txpmareset_in(3),
      TXPMARESETDONE => txpmaresetdone_out(3),
      TXPOLARITY => txpolarity_in(3),
      TXPOSTCURSOR(4 downto 0) => txpostcursor_in(19 downto 15),
      TXPOSTCURSORINV => txpostcursorinv_in(3),
      TXPRBSFORCEERR => txprbsforceerr_in(3),
      TXPRBSSEL(3 downto 0) => txprbssel_in(15 downto 12),
      TXPRECURSOR(4 downto 0) => txprecursor_in(19 downto 15),
      TXPRECURSORINV => txprecursorinv_in(3),
      TXPRGDIVRESETDONE => txprgdivresetdone_out(3),
      TXPROGDIVRESET => GTHE3_CHANNEL_TXPROGDIVRESET(0),
      TXQPIBIASEN => txqpibiasen_in(3),
      TXQPISENN => txqpisenn_out(3),
      TXQPISENP => txqpisenp_out(3),
      TXQPISTRONGPDOWN => txqpistrongpdown_in(3),
      TXQPIWEAKPUP => txqpiweakpup_in(3),
      TXRATE(2 downto 0) => txrate_in(11 downto 9),
      TXRATEDONE => txratedone_out(3),
      TXRATEMODE => txratemode_in(3),
      TXRESETDONE => txresetdone_out(3),
      TXSEQUENCE(6 downto 0) => txsequence_in(27 downto 21),
      TXSWING => txswing_in(3),
      TXSYNCALLIN => GTHE3_CHANNEL_TXSYNCALLIN(0),
      TXSYNCDONE => txsyncdone_out(3),
      TXSYNCIN => \^txsyncout_out\(3),
      TXSYNCMODE => '1',
      TXSYNCOUT => \^txsyncout_out\(3),
      TXSYSCLKSEL(1 downto 0) => txsysclksel_in(7 downto 6),
      TXUSERRDY => GTHE3_CHANNEL_TXUSERRDY(0),
      TXUSRCLK => txusrclk_in(3),
      TXUSRCLK2 => txusrclk2_in(3)
    );
\i_in_inferred_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => \^cplllock_out\(1),
      I1 => \^cplllock_out\(3),
      I2 => \^cplllock_out\(2),
      I3 => gtrxreset_out_reg,
      O => in0
    );
\rst_in_meta_i_1__4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF7F"
    )
        port map (
      I0 => \^cplllock_out\(1),
      I1 => \^cplllock_out\(3),
      I2 => \^cplllock_out\(2),
      I3 => gtrxreset_out_reg,
      O => rst_in0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer is
  port (
    gtwiz_buffbypass_tx_resetdone_sync_int : out STD_LOGIC;
    \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.txdlysreset_out_reg[6]\ : out STD_LOGIC;
    \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.gtwiz_buffbypass_tx_error_out_reg\ : out STD_LOGIC;
    txusrclk2_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rst_in_out_reg_0 : in STD_LOGIC;
    \out\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    gtwiz_buffbypass_tx_start_user_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_tx_resetdone_reg : in STD_LOGIC;
    GTHE3_CHANNEL_TXDLYSRESET : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer : entity is "gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer is
  signal \^gtwiz_buffbypass_tx_resetdone_sync_int\ : STD_LOGIC;
  signal rst_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of rst_in_meta : signal is "true";
  signal rst_in_sync1 : STD_LOGIC;
  attribute async_reg of rst_in_sync1 : signal is "true";
  signal rst_in_sync2 : STD_LOGIC;
  attribute async_reg of rst_in_sync2 : signal is "true";
  signal rst_in_sync3 : STD_LOGIC;
  attribute async_reg of rst_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of rst_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of rst_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync1_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync2_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync3_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync3_reg : label is "yes";
begin
  gtwiz_buffbypass_tx_resetdone_sync_int <= \^gtwiz_buffbypass_tx_resetdone_sync_int\;
\gen_gtwiz_buffbypass_tx_main.gen_auto_mode.gtwiz_buffbypass_tx_done_out_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAA5510"
    )
        port map (
      I0 => \out\(0),
      I1 => gtwiz_buffbypass_tx_resetdone_reg,
      I2 => \^gtwiz_buffbypass_tx_resetdone_sync_int\,
      I3 => gtwiz_buffbypass_tx_start_user_in(0),
      I4 => \out\(1),
      O => \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.gtwiz_buffbypass_tx_error_out_reg\
    );
\gen_gtwiz_buffbypass_tx_main.gen_auto_mode.txdlysreset_out[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAFFFF00004454"
    )
        port map (
      I0 => \out\(1),
      I1 => gtwiz_buffbypass_tx_start_user_in(0),
      I2 => \^gtwiz_buffbypass_tx_resetdone_sync_int\,
      I3 => gtwiz_buffbypass_tx_resetdone_reg,
      I4 => \out\(0),
      I5 => GTHE3_CHANNEL_TXDLYSRESET(0),
      O => \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.txdlysreset_out_reg[6]\
    );
rst_in_meta_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      CLR => rst_in_out_reg_0,
      D => '1',
      Q => rst_in_meta
    );
rst_in_out_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      CLR => rst_in_out_reg_0,
      D => rst_in_sync3,
      Q => \^gtwiz_buffbypass_tx_resetdone_sync_int\
    );
rst_in_sync1_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      CLR => rst_in_out_reg_0,
      D => rst_in_meta,
      Q => rst_in_sync1
    );
rst_in_sync2_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      CLR => rst_in_out_reg_0,
      D => rst_in_sync1,
      Q => rst_in_sync2
    );
rst_in_sync3_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      CLR => rst_in_out_reg_0,
      D => rst_in_sync2,
      Q => rst_in_sync3
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer_31 is
  port (
    gtwiz_reset_rx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxusrclk2_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_done_int_reg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer_31 : entity is "gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer_31;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer_31 is
  signal rst_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of rst_in_meta : signal is "true";
  signal \rst_in_out_i_1__1_n_0\ : STD_LOGIC;
  signal rst_in_sync1 : STD_LOGIC;
  attribute async_reg of rst_in_sync1 : signal is "true";
  signal rst_in_sync2 : STD_LOGIC;
  attribute async_reg of rst_in_sync2 : signal is "true";
  signal rst_in_sync3 : STD_LOGIC;
  attribute async_reg of rst_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of rst_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of rst_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync1_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync2_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync3_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync3_reg : label is "yes";
begin
rst_in_meta_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => rxusrclk2_in(0),
      CE => '1',
      CLR => \rst_in_out_i_1__1_n_0\,
      D => '1',
      Q => rst_in_meta
    );
\rst_in_out_i_1__1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => gtwiz_reset_rx_done_int_reg,
      O => \rst_in_out_i_1__1_n_0\
    );
rst_in_out_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => rxusrclk2_in(0),
      CE => '1',
      CLR => \rst_in_out_i_1__1_n_0\,
      D => rst_in_sync3,
      Q => gtwiz_reset_rx_done_out(0)
    );
rst_in_sync1_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => rxusrclk2_in(0),
      CE => '1',
      CLR => \rst_in_out_i_1__1_n_0\,
      D => rst_in_meta,
      Q => rst_in_sync1
    );
rst_in_sync2_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => rxusrclk2_in(0),
      CE => '1',
      CLR => \rst_in_out_i_1__1_n_0\,
      D => rst_in_sync1,
      Q => rst_in_sync2
    );
rst_in_sync3_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => rxusrclk2_in(0),
      CE => '1',
      CLR => \rst_in_out_i_1__1_n_0\,
      D => rst_in_sync2,
      Q => rst_in_sync3
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer_32 is
  port (
    gtwiz_reset_tx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    rst_in_sync2_reg_0 : out STD_LOGIC;
    txusrclk2_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_done_int_reg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer_32 : entity is "gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer_32;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer_32 is
  signal \^gtwiz_reset_tx_done_out\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rst_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of rst_in_meta : signal is "true";
  signal \rst_in_out_i_1__0_n_0\ : STD_LOGIC;
  signal rst_in_sync1 : STD_LOGIC;
  attribute async_reg of rst_in_sync1 : signal is "true";
  signal rst_in_sync2 : STD_LOGIC;
  attribute async_reg of rst_in_sync2 : signal is "true";
  signal rst_in_sync3 : STD_LOGIC;
  attribute async_reg of rst_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of rst_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of rst_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync1_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync2_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync3_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync3_reg : label is "yes";
begin
  gtwiz_reset_tx_done_out(0) <= \^gtwiz_reset_tx_done_out\(0);
\rst_in_meta_i_1__3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^gtwiz_reset_tx_done_out\(0),
      O => rst_in_sync2_reg_0
    );
rst_in_meta_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      CLR => \rst_in_out_i_1__0_n_0\,
      D => '1',
      Q => rst_in_meta
    );
\rst_in_out_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => gtwiz_reset_tx_done_int_reg,
      O => \rst_in_out_i_1__0_n_0\
    );
rst_in_out_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      CLR => \rst_in_out_i_1__0_n_0\,
      D => rst_in_sync3,
      Q => \^gtwiz_reset_tx_done_out\(0)
    );
rst_in_sync1_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      CLR => \rst_in_out_i_1__0_n_0\,
      D => rst_in_meta,
      Q => rst_in_sync1
    );
rst_in_sync2_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      CLR => \rst_in_out_i_1__0_n_0\,
      D => rst_in_sync1,
      Q => rst_in_sync2
    );
rst_in_sync3_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      CLR => \rst_in_out_i_1__0_n_0\,
      D => rst_in_sync2,
      Q => rst_in_sync3
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer is
  port (
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_all_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer : entity is "gtwizard_ultrascale_v1_6_5_reset_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer is
  signal rst_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of rst_in_meta : signal is "true";
  signal rst_in_sync1 : STD_LOGIC;
  attribute async_reg of rst_in_sync1 : signal is "true";
  signal rst_in_sync2 : STD_LOGIC;
  attribute async_reg of rst_in_sync2 : signal is "true";
  signal rst_in_sync3 : STD_LOGIC;
  attribute async_reg of rst_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of rst_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of rst_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync1_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync2_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync3_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync3_reg : label is "yes";
begin
rst_in_meta_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => '0',
      PRE => gtwiz_reset_all_in(0),
      Q => rst_in_meta
    );
rst_in_out_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync3,
      PRE => gtwiz_reset_all_in(0),
      Q => SR(0)
    );
rst_in_sync1_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_meta,
      PRE => gtwiz_reset_all_in(0),
      Q => rst_in_sync1
    );
rst_in_sync2_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync1,
      PRE => gtwiz_reset_all_in(0),
      Q => rst_in_sync2
    );
rst_in_sync3_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync2,
      PRE => gtwiz_reset_all_in(0),
      Q => rst_in_sync3
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_25 is
  port (
    gtwiz_reset_rx_any_sync : out STD_LOGIC;
    pllreset_rx_out_reg : out STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    \out\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtwiz_reset_pllreset_rx_int : in STD_LOGIC;
    gtwiz_reset_rx_datapath_int_reg : in STD_LOGIC;
    gtwiz_reset_rx_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_pll_and_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_pll_and_datapath_int_reg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_25 : entity is "gtwizard_ultrascale_v1_6_5_reset_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_25;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_25 is
  signal gtwiz_reset_rx_any : STD_LOGIC;
  signal \^gtwiz_reset_rx_any_sync\ : STD_LOGIC;
  signal rst_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of rst_in_meta : signal is "true";
  signal rst_in_sync1 : STD_LOGIC;
  attribute async_reg of rst_in_sync1 : signal is "true";
  signal rst_in_sync2 : STD_LOGIC;
  attribute async_reg of rst_in_sync2 : signal is "true";
  signal rst_in_sync3 : STD_LOGIC;
  attribute async_reg of rst_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of rst_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of rst_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync1_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync2_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync3_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync3_reg : label is "yes";
begin
  gtwiz_reset_rx_any_sync <= \^gtwiz_reset_rx_any_sync\;
pllreset_rx_out_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFDF0010"
    )
        port map (
      I0 => \out\(1),
      I1 => \out\(2),
      I2 => \out\(0),
      I3 => \^gtwiz_reset_rx_any_sync\,
      I4 => gtwiz_reset_pllreset_rx_int,
      O => pllreset_rx_out_reg
    );
\rst_in_meta_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => gtwiz_reset_rx_datapath_int_reg,
      I1 => gtwiz_reset_rx_datapath_in(0),
      I2 => gtwiz_reset_rx_pll_and_datapath_in(0),
      I3 => gtwiz_reset_rx_pll_and_datapath_int_reg,
      O => gtwiz_reset_rx_any
    );
rst_in_meta_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => '0',
      PRE => gtwiz_reset_rx_any,
      Q => rst_in_meta
    );
rst_in_out_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync3,
      PRE => gtwiz_reset_rx_any,
      Q => \^gtwiz_reset_rx_any_sync\
    );
rst_in_sync1_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_meta,
      PRE => gtwiz_reset_rx_any,
      Q => rst_in_sync1
    );
rst_in_sync2_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync1,
      PRE => gtwiz_reset_rx_any,
      Q => rst_in_sync2
    );
rst_in_sync3_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync2,
      PRE => gtwiz_reset_rx_any,
      Q => rst_in_sync3
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_26 is
  port (
    in0 : out STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_datapath_int_reg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_26 : entity is "gtwizard_ultrascale_v1_6_5_reset_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_26;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_26 is
  signal rst_in0_2 : STD_LOGIC;
  signal rst_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of rst_in_meta : signal is "true";
  signal rst_in_sync1 : STD_LOGIC;
  attribute async_reg of rst_in_sync1 : signal is "true";
  signal rst_in_sync2 : STD_LOGIC;
  attribute async_reg of rst_in_sync2 : signal is "true";
  signal rst_in_sync3 : STD_LOGIC;
  attribute async_reg of rst_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of rst_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of rst_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync1_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync2_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync3_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync3_reg : label is "yes";
begin
\rst_in_meta_i_1__2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => gtwiz_reset_rx_datapath_in(0),
      I1 => gtwiz_reset_rx_datapath_int_reg,
      O => rst_in0_2
    );
rst_in_meta_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => '0',
      PRE => rst_in0_2,
      Q => rst_in_meta
    );
rst_in_out_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync3,
      PRE => rst_in0_2,
      Q => in0
    );
rst_in_sync1_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_meta,
      PRE => rst_in0_2,
      Q => rst_in_sync1
    );
rst_in_sync2_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync1,
      PRE => rst_in0_2,
      Q => rst_in_sync2
    );
rst_in_sync3_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync2,
      PRE => rst_in0_2,
      Q => rst_in_sync3
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_27 is
  port (
    in0 : out STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_pll_and_datapath_int_reg : in STD_LOGIC;
    gtwiz_reset_rx_pll_and_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_27 : entity is "gtwizard_ultrascale_v1_6_5_reset_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_27;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_27 is
  signal p_0_in_1 : STD_LOGIC;
  signal rst_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of rst_in_meta : signal is "true";
  signal rst_in_sync1 : STD_LOGIC;
  attribute async_reg of rst_in_sync1 : signal is "true";
  signal rst_in_sync2 : STD_LOGIC;
  attribute async_reg of rst_in_sync2 : signal is "true";
  signal rst_in_sync3 : STD_LOGIC;
  attribute async_reg of rst_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of rst_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of rst_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync1_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync2_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync3_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync3_reg : label is "yes";
begin
\rst_in_meta_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => gtwiz_reset_rx_pll_and_datapath_int_reg,
      I1 => gtwiz_reset_rx_pll_and_datapath_in(0),
      O => p_0_in_1
    );
rst_in_meta_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => '0',
      PRE => p_0_in_1,
      Q => rst_in_meta
    );
rst_in_out_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync3,
      PRE => p_0_in_1,
      Q => in0
    );
rst_in_sync1_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_meta,
      PRE => p_0_in_1,
      Q => rst_in_sync1
    );
rst_in_sync2_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync1,
      PRE => p_0_in_1,
      Q => rst_in_sync2
    );
rst_in_sync3_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync2,
      PRE => p_0_in_1,
      Q => rst_in_sync3
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_28 is
  port (
    gtwiz_reset_tx_any_sync : out STD_LOGIC;
    pllreset_tx_out_reg : out STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    \out\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtwiz_reset_pllreset_tx_int : in STD_LOGIC;
    gtwiz_reset_tx_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_pll_and_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_pll_and_datapath_int_reg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_28 : entity is "gtwizard_ultrascale_v1_6_5_reset_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_28;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_28 is
  signal gtwiz_reset_tx_any : STD_LOGIC;
  signal \^gtwiz_reset_tx_any_sync\ : STD_LOGIC;
  signal rst_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of rst_in_meta : signal is "true";
  signal rst_in_sync1 : STD_LOGIC;
  attribute async_reg of rst_in_sync1 : signal is "true";
  signal rst_in_sync2 : STD_LOGIC;
  attribute async_reg of rst_in_sync2 : signal is "true";
  signal rst_in_sync3 : STD_LOGIC;
  attribute async_reg of rst_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of rst_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of rst_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync1_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync2_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync3_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync3_reg : label is "yes";
begin
  gtwiz_reset_tx_any_sync <= \^gtwiz_reset_tx_any_sync\;
pllreset_tx_out_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFDF0010"
    )
        port map (
      I0 => \out\(1),
      I1 => \out\(2),
      I2 => \out\(0),
      I3 => \^gtwiz_reset_tx_any_sync\,
      I4 => gtwiz_reset_pllreset_tx_int,
      O => pllreset_tx_out_reg
    );
rst_in_meta_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => '0',
      PRE => gtwiz_reset_tx_any,
      Q => rst_in_meta
    );
rst_in_out_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => gtwiz_reset_tx_datapath_in(0),
      I1 => gtwiz_reset_tx_pll_and_datapath_in(0),
      I2 => gtwiz_reset_tx_pll_and_datapath_int_reg,
      O => gtwiz_reset_tx_any
    );
rst_in_out_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync3,
      PRE => gtwiz_reset_tx_any,
      Q => \^gtwiz_reset_tx_any_sync\
    );
rst_in_sync1_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_meta,
      PRE => gtwiz_reset_tx_any,
      Q => rst_in_sync1
    );
rst_in_sync2_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync1,
      PRE => gtwiz_reset_tx_any,
      Q => rst_in_sync2
    );
rst_in_sync3_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync2,
      PRE => gtwiz_reset_tx_any,
      Q => rst_in_sync3
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_29 is
  port (
    in0 : out STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_29 : entity is "gtwizard_ultrascale_v1_6_5_reset_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_29;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_29 is
  signal rst_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of rst_in_meta : signal is "true";
  signal rst_in_sync1 : STD_LOGIC;
  attribute async_reg of rst_in_sync1 : signal is "true";
  signal rst_in_sync2 : STD_LOGIC;
  attribute async_reg of rst_in_sync2 : signal is "true";
  signal rst_in_sync3 : STD_LOGIC;
  attribute async_reg of rst_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of rst_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of rst_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync1_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync2_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync3_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync3_reg : label is "yes";
begin
rst_in_meta_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => '0',
      PRE => gtwiz_reset_tx_datapath_in(0),
      Q => rst_in_meta
    );
rst_in_out_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync3,
      PRE => gtwiz_reset_tx_datapath_in(0),
      Q => in0
    );
rst_in_sync1_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_meta,
      PRE => gtwiz_reset_tx_datapath_in(0),
      Q => rst_in_sync1
    );
rst_in_sync2_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync1,
      PRE => gtwiz_reset_tx_datapath_in(0),
      Q => rst_in_sync2
    );
rst_in_sync3_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync2,
      PRE => gtwiz_reset_tx_datapath_in(0),
      Q => rst_in_sync3
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_30 is
  port (
    in0 : out STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_pll_and_datapath_int_reg : in STD_LOGIC;
    gtwiz_reset_tx_pll_and_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_30 : entity is "gtwizard_ultrascale_v1_6_5_reset_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_30;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_30 is
  signal p_1_in_0 : STD_LOGIC;
  signal rst_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of rst_in_meta : signal is "true";
  signal rst_in_sync1 : STD_LOGIC;
  attribute async_reg of rst_in_sync1 : signal is "true";
  signal rst_in_sync2 : STD_LOGIC;
  attribute async_reg of rst_in_sync2 : signal is "true";
  signal rst_in_sync3 : STD_LOGIC;
  attribute async_reg of rst_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of rst_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of rst_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync1_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync2_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync3_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync3_reg : label is "yes";
begin
rst_in_meta_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => gtwiz_reset_tx_pll_and_datapath_int_reg,
      I1 => gtwiz_reset_tx_pll_and_datapath_in(0),
      O => p_1_in_0
    );
rst_in_meta_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => '0',
      PRE => p_1_in_0,
      Q => rst_in_meta
    );
rst_in_out_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync3,
      PRE => p_1_in_0,
      Q => in0
    );
rst_in_sync1_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_meta,
      PRE => p_1_in_0,
      Q => rst_in_sync1
    );
rst_in_sync2_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync1,
      PRE => p_1_in_0,
      Q => rst_in_sync2
    );
rst_in_sync3_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync2,
      PRE => p_1_in_0,
      Q => rst_in_sync3
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_33 is
  port (
    GTHE3_CHANNEL_TXPROGDIVRESET : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rst_in0 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_33 : entity is "gtwizard_ultrascale_v1_6_5_reset_synchronizer";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_33;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_33 is
  signal rst_in_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of rst_in_meta : signal is "true";
  signal rst_in_sync1 : STD_LOGIC;
  attribute async_reg of rst_in_sync1 : signal is "true";
  signal rst_in_sync2 : STD_LOGIC;
  attribute async_reg of rst_in_sync2 : signal is "true";
  signal rst_in_sync3 : STD_LOGIC;
  attribute async_reg of rst_in_sync3 : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of rst_in_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of rst_in_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync1_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync1_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync2_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync2_reg : label is "yes";
  attribute ASYNC_REG_boolean of rst_in_sync3_reg : label is std.standard.true;
  attribute KEEP of rst_in_sync3_reg : label is "yes";
begin
rst_in_meta_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => '0',
      PRE => rst_in0,
      Q => rst_in_meta
    );
rst_in_out_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync3,
      PRE => rst_in0,
      Q => GTHE3_CHANNEL_TXPROGDIVRESET(0)
    );
rst_in_sync1_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_meta,
      PRE => rst_in0,
      Q => rst_in_sync1
    );
rst_in_sync2_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync1,
      PRE => rst_in0,
      Q => rst_in_sync2
    );
rst_in_sync3_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => rst_in_sync2,
      PRE => rst_in0,
      Q => rst_in_sync3
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gthe3_channel_wrapper is
  port (
    rst_in_out_reg : out STD_LOGIC;
    cplllock_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    cpllfbclklost_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    cpllrefclklost_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    drprdy_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    eyescandataerror_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    gthtxn_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    gthtxp_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    gtpowergood_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    gtrefclkmonitor_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pcierategen3_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pcierateidle_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pciesynctxsyncdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pcieusergen3rdy_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pcieuserphystatusrst_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pcieuserratestart_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    phystatus_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    resetexception_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxbyteisaligned_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxbyterealign_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcdrlock_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcdrphdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxchanbondseq_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxchanisaligned_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxchanrealign_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcominitdet_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcommadet_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcomsasdet_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcomwakedet_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdlysresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxelecidle_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosintdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosintstarted_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosintstrobedone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosintstrobestarted_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxoutclk_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxoutclkfabric_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxoutclkpcs_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxphaligndone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxphalignerr_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxpmaresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxprbserr_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxprbslocked_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxprgdivresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxqpisenn_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxqpisenp_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxratedone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxrecclkout_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxsliderdy_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxslipdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxslipoutclkrdy_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxslippmardy_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxsyncdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxsyncout_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rxvalid_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txcomfinish_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txdlysresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txoutclk_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txoutclkfabric_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txoutclkpcs_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txphaligndone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txphinitdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txpmaresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txprgdivresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txqpisenn_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txqpisenp_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txratedone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txresetdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txsyncdone_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    txsyncout_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pcsrsvdout_out : out STD_LOGIC_VECTOR ( 35 downto 0 );
    rxdata_out : out STD_LOGIC_VECTOR ( 383 downto 0 );
    drpdo_out : out STD_LOGIC_VECTOR ( 47 downto 0 );
    rxctrl0_out : out STD_LOGIC_VECTOR ( 47 downto 0 );
    rxctrl1_out : out STD_LOGIC_VECTOR ( 47 downto 0 );
    dmonitorout_out : out STD_LOGIC_VECTOR ( 50 downto 0 );
    pcierateqpllpd_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    pcierateqpllreset_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    rxclkcorcnt_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    rxdatavalid_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    rxheadervalid_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    rxstartofseq_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    txbufstatus_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    bufgtce_out : out STD_LOGIC_VECTOR ( 8 downto 0 );
    bufgtcemask_out : out STD_LOGIC_VECTOR ( 8 downto 0 );
    bufgtreset_out : out STD_LOGIC_VECTOR ( 8 downto 0 );
    bufgtrstmask_out : out STD_LOGIC_VECTOR ( 8 downto 0 );
    rxbufstatus_out : out STD_LOGIC_VECTOR ( 8 downto 0 );
    rxstatus_out : out STD_LOGIC_VECTOR ( 8 downto 0 );
    rxchbondo_out : out STD_LOGIC_VECTOR ( 14 downto 0 );
    rxheader_out : out STD_LOGIC_VECTOR ( 17 downto 0 );
    rxmonitorout_out : out STD_LOGIC_VECTOR ( 20 downto 0 );
    pinrsrvdas_out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    rxctrl2_out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    rxctrl3_out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    rxdataextendrsvd_out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    bufgtdiv_out : out STD_LOGIC_VECTOR ( 26 downto 0 );
    gtrxreset_out_reg : in STD_LOGIC_VECTOR ( 0 to 0 );
    cfgreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    clkrsvd0_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    clkrsvd1_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    cplllockdetclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    cplllocken_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_CPLLPD : in STD_LOGIC_VECTOR ( 0 to 0 );
    cpllreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    dmonfiforeset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    dmonitorclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    drpclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    drpen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    drpwe_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    evoddphicaldone_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    evoddphicalstart_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    evoddphidrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    evoddphidwren_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    evoddphixrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    evoddphixwren_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    eyescanmode_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    eyescanreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    eyescantrigger_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtgrefclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gthrxn_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gthrxp_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtnorthrefclk0_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtnorthrefclk1_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtrefclk0_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtrefclk1_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtresetsel_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_GTRXRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtsouthrefclk0_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtsouthrefclk1_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_GTTXRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    lpbkrxtxseren_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    lpbktxrxseren_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    pcieeqrxeqadaptdone_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    pcierstidle_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    pciersttxsyncstart_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    pcieuserratedone_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    qpll0clk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    qpll0refclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    qpll1clk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    qpll1refclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    resetovrd_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rstclkentx_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rx8b10ben_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxbufreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcdrfreqreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcdrhold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcdrovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcdrreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcdrresetrsv_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxchbonden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxchbondmaster_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxchbondslave_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxcommadeten_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfeagchold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfeagcovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfelfhold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfelfovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfelpmreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap10hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap10ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap11hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap11ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap12hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap12ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap13hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap13ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap14hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap14ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap15hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap15ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap2hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap2ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap3hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap3ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap4hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap4ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap5hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap5ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap6hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap6ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap7hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap7ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap8hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap8ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap9hold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfetap9ovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfeuthold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfeutovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfevphold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfevpovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfevsen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdfexyden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdlybypass_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdlyen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdlyovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxdlysreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxgearboxslip_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlatclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmgchold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmgcovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmhfhold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmhfovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmlfhold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmlfklovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmoshold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxlpmosovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxmcommaalignen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxoobreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxoscalreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxoshold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosinten_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosinthold_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosintovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosintstrobe_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosinttestovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxosovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxpcommaalignen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxpcsreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxphalign_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxphalignen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxphdlypd_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxphdlyreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxphovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxpmareset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxpolarity_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxprbscntreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_RXPROGDIVRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxqpien_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxratemode_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxslide_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxslipoutclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxslippma_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxsyncallin_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxsyncin_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxsyncmode_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_RXUSERRDY : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxusrclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rxusrclk2_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    sigvalidclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    tx8b10ben_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txcominit_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txcomsas_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txcomwake_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txdeemph_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txdetectrx_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txdiffpd_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_TXDLYSRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    txelecidle_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txinhibit_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txlatclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpcsreset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpdelecidlemode_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpippmen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpippmovrden_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpippmpd_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpippmsel_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpisopd_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpmareset_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpolarity_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txpostcursorinv_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txprbsforceerr_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txprecursorinv_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_TXPROGDIVRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    txqpibiasen_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txqpistrongpdown_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txqpiweakpup_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txratemode_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txswing_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    GTHE3_CHANNEL_TXSYNCALLIN : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtrxreset_out_reg_0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    GTHE3_CHANNEL_TXUSERRDY : in STD_LOGIC_VECTOR ( 0 to 0 );
    txusrclk_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    txusrclk2_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtwiz_userdata_tx_in : in STD_LOGIC_VECTOR ( 95 downto 0 );
    drpdi_in : in STD_LOGIC_VECTOR ( 47 downto 0 );
    gtrsvd_in : in STD_LOGIC_VECTOR ( 47 downto 0 );
    pcsrsvdin_in : in STD_LOGIC_VECTOR ( 47 downto 0 );
    txctrl0_in : in STD_LOGIC_VECTOR ( 47 downto 0 );
    txctrl1_in : in STD_LOGIC_VECTOR ( 47 downto 0 );
    rxdfeagcctrl_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    rxelecidlemode_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    rxmonitorsel_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    rxpd_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    rxpllclksel_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    rxsysclksel_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    txpd_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    txpllclksel_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    txsysclksel_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    cpllrefclksel_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    loopback_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    rxchbondlevel_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    rxoutclksel_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    rxrate_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    txbufdiffctrl_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    txmargin_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    txoutclksel_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    txrate_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    rxosintcfg_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    rxprbssel_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    txdiffctrl_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    txprbssel_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pcsrsvdin2_in : in STD_LOGIC_VECTOR ( 14 downto 0 );
    pmarsvdin_in : in STD_LOGIC_VECTOR ( 14 downto 0 );
    rxchbondi_in : in STD_LOGIC_VECTOR ( 14 downto 0 );
    txpippmstepsize_in : in STD_LOGIC_VECTOR ( 14 downto 0 );
    txpostcursor_in : in STD_LOGIC_VECTOR ( 14 downto 0 );
    txprecursor_in : in STD_LOGIC_VECTOR ( 14 downto 0 );
    txheader_in : in STD_LOGIC_VECTOR ( 17 downto 0 );
    txmaincursor_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    txsequence_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    tx8b10bbypass_in : in STD_LOGIC_VECTOR ( 23 downto 0 );
    txctrl2_in : in STD_LOGIC_VECTOR ( 23 downto 0 );
    txdataextendrsvd_in : in STD_LOGIC_VECTOR ( 23 downto 0 );
    drpaddr_in : in STD_LOGIC_VECTOR ( 26 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gthe3_channel_wrapper : entity is "JesdCryoCoreRightColumn_gthe3_channel_wrapper";
end JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gthe3_channel_wrapper;

architecture STRUCTURE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gthe3_channel_wrapper is
begin
channel_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gthe3_channel
     port map (
      GTHE3_CHANNEL_CPLLPD(0) => GTHE3_CHANNEL_CPLLPD(0),
      GTHE3_CHANNEL_GTRXRESET(0) => GTHE3_CHANNEL_GTRXRESET(0),
      GTHE3_CHANNEL_GTTXRESET(0) => GTHE3_CHANNEL_GTTXRESET(0),
      GTHE3_CHANNEL_RXPROGDIVRESET(0) => GTHE3_CHANNEL_RXPROGDIVRESET(0),
      GTHE3_CHANNEL_RXUSERRDY(0) => GTHE3_CHANNEL_RXUSERRDY(0),
      GTHE3_CHANNEL_TXDLYSRESET(0) => GTHE3_CHANNEL_TXDLYSRESET(0),
      GTHE3_CHANNEL_TXPROGDIVRESET(0) => GTHE3_CHANNEL_TXPROGDIVRESET(0),
      GTHE3_CHANNEL_TXSYNCALLIN(0) => GTHE3_CHANNEL_TXSYNCALLIN(0),
      GTHE3_CHANNEL_TXUSERRDY(0) => GTHE3_CHANNEL_TXUSERRDY(0),
      bufgtce_out(8 downto 0) => bufgtce_out(8 downto 0),
      bufgtcemask_out(8 downto 0) => bufgtcemask_out(8 downto 0),
      bufgtdiv_out(26 downto 0) => bufgtdiv_out(26 downto 0),
      bufgtreset_out(8 downto 0) => bufgtreset_out(8 downto 0),
      bufgtrstmask_out(8 downto 0) => bufgtrstmask_out(8 downto 0),
      cfgreset_in(2 downto 0) => cfgreset_in(2 downto 0),
      clkrsvd0_in(2 downto 0) => clkrsvd0_in(2 downto 0),
      clkrsvd1_in(2 downto 0) => clkrsvd1_in(2 downto 0),
      cpllfbclklost_out(2 downto 0) => cpllfbclklost_out(2 downto 0),
      cplllock_out(2 downto 0) => cplllock_out(2 downto 0),
      cplllockdetclk_in(2 downto 0) => cplllockdetclk_in(2 downto 0),
      cplllocken_in(2 downto 0) => cplllocken_in(2 downto 0),
      cpllrefclklost_out(2 downto 0) => cpllrefclklost_out(2 downto 0),
      cpllrefclksel_in(8 downto 0) => cpllrefclksel_in(8 downto 0),
      cpllreset_in(2 downto 0) => cpllreset_in(2 downto 0),
      dmonfiforeset_in(2 downto 0) => dmonfiforeset_in(2 downto 0),
      dmonitorclk_in(2 downto 0) => dmonitorclk_in(2 downto 0),
      dmonitorout_out(50 downto 0) => dmonitorout_out(50 downto 0),
      drpaddr_in(26 downto 0) => drpaddr_in(26 downto 0),
      drpclk_in(2 downto 0) => drpclk_in(2 downto 0),
      drpdi_in(47 downto 0) => drpdi_in(47 downto 0),
      drpdo_out(47 downto 0) => drpdo_out(47 downto 0),
      drpen_in(2 downto 0) => drpen_in(2 downto 0),
      drprdy_out(2 downto 0) => drprdy_out(2 downto 0),
      drpwe_in(2 downto 0) => drpwe_in(2 downto 0),
      evoddphicaldone_in(2 downto 0) => evoddphicaldone_in(2 downto 0),
      evoddphicalstart_in(2 downto 0) => evoddphicalstart_in(2 downto 0),
      evoddphidrden_in(2 downto 0) => evoddphidrden_in(2 downto 0),
      evoddphidwren_in(2 downto 0) => evoddphidwren_in(2 downto 0),
      evoddphixrden_in(2 downto 0) => evoddphixrden_in(2 downto 0),
      evoddphixwren_in(2 downto 0) => evoddphixwren_in(2 downto 0),
      eyescandataerror_out(2 downto 0) => eyescandataerror_out(2 downto 0),
      eyescanmode_in(2 downto 0) => eyescanmode_in(2 downto 0),
      eyescanreset_in(2 downto 0) => eyescanreset_in(2 downto 0),
      eyescantrigger_in(2 downto 0) => eyescantrigger_in(2 downto 0),
      gtgrefclk_in(2 downto 0) => gtgrefclk_in(2 downto 0),
      gthrxn_in(2 downto 0) => gthrxn_in(2 downto 0),
      gthrxp_in(2 downto 0) => gthrxp_in(2 downto 0),
      gthtxn_out(2 downto 0) => gthtxn_out(2 downto 0),
      gthtxp_out(2 downto 0) => gthtxp_out(2 downto 0),
      gtnorthrefclk0_in(2 downto 0) => gtnorthrefclk0_in(2 downto 0),
      gtnorthrefclk1_in(2 downto 0) => gtnorthrefclk1_in(2 downto 0),
      gtpowergood_out(2 downto 0) => gtpowergood_out(2 downto 0),
      gtrefclk0_in(2 downto 0) => gtrefclk0_in(2 downto 0),
      gtrefclk1_in(2 downto 0) => gtrefclk1_in(2 downto 0),
      gtrefclkmonitor_out(2 downto 0) => gtrefclkmonitor_out(2 downto 0),
      gtresetsel_in(2 downto 0) => gtresetsel_in(2 downto 0),
      gtrsvd_in(47 downto 0) => gtrsvd_in(47 downto 0),
      gtrxreset_out_reg(0) => gtrxreset_out_reg(0),
      gtrxreset_out_reg_0(0) => gtrxreset_out_reg_0(0),
      gtsouthrefclk0_in(2 downto 0) => gtsouthrefclk0_in(2 downto 0),
      gtsouthrefclk1_in(2 downto 0) => gtsouthrefclk1_in(2 downto 0),
      gtwiz_userdata_tx_in(95 downto 0) => gtwiz_userdata_tx_in(95 downto 0),
      loopback_in(8 downto 0) => loopback_in(8 downto 0),
      lpbkrxtxseren_in(2 downto 0) => lpbkrxtxseren_in(2 downto 0),
      lpbktxrxseren_in(2 downto 0) => lpbktxrxseren_in(2 downto 0),
      pcieeqrxeqadaptdone_in(2 downto 0) => pcieeqrxeqadaptdone_in(2 downto 0),
      pcierategen3_out(2 downto 0) => pcierategen3_out(2 downto 0),
      pcierateidle_out(2 downto 0) => pcierateidle_out(2 downto 0),
      pcierateqpllpd_out(5 downto 0) => pcierateqpllpd_out(5 downto 0),
      pcierateqpllreset_out(5 downto 0) => pcierateqpllreset_out(5 downto 0),
      pcierstidle_in(2 downto 0) => pcierstidle_in(2 downto 0),
      pciersttxsyncstart_in(2 downto 0) => pciersttxsyncstart_in(2 downto 0),
      pciesynctxsyncdone_out(2 downto 0) => pciesynctxsyncdone_out(2 downto 0),
      pcieusergen3rdy_out(2 downto 0) => pcieusergen3rdy_out(2 downto 0),
      pcieuserphystatusrst_out(2 downto 0) => pcieuserphystatusrst_out(2 downto 0),
      pcieuserratedone_in(2 downto 0) => pcieuserratedone_in(2 downto 0),
      pcieuserratestart_out(2 downto 0) => pcieuserratestart_out(2 downto 0),
      pcsrsvdin2_in(14 downto 0) => pcsrsvdin2_in(14 downto 0),
      pcsrsvdin_in(47 downto 0) => pcsrsvdin_in(47 downto 0),
      pcsrsvdout_out(35 downto 0) => pcsrsvdout_out(35 downto 0),
      phystatus_out(2 downto 0) => phystatus_out(2 downto 0),
      pinrsrvdas_out(23 downto 0) => pinrsrvdas_out(23 downto 0),
      pmarsvdin_in(14 downto 0) => pmarsvdin_in(14 downto 0),
      qpll0clk_in(2 downto 0) => qpll0clk_in(2 downto 0),
      qpll0refclk_in(2 downto 0) => qpll0refclk_in(2 downto 0),
      qpll1clk_in(2 downto 0) => qpll1clk_in(2 downto 0),
      qpll1refclk_in(2 downto 0) => qpll1refclk_in(2 downto 0),
      resetexception_out(2 downto 0) => resetexception_out(2 downto 0),
      resetovrd_in(2 downto 0) => resetovrd_in(2 downto 0),
      rst_in_out_reg => rst_in_out_reg,
      rstclkentx_in(2 downto 0) => rstclkentx_in(2 downto 0),
      rx8b10ben_in(2 downto 0) => rx8b10ben_in(2 downto 0),
      rxbufreset_in(2 downto 0) => rxbufreset_in(2 downto 0),
      rxbufstatus_out(8 downto 0) => rxbufstatus_out(8 downto 0),
      rxbyteisaligned_out(2 downto 0) => rxbyteisaligned_out(2 downto 0),
      rxbyterealign_out(2 downto 0) => rxbyterealign_out(2 downto 0),
      rxcdrfreqreset_in(2 downto 0) => rxcdrfreqreset_in(2 downto 0),
      rxcdrhold_in(2 downto 0) => rxcdrhold_in(2 downto 0),
      rxcdrlock_out(2 downto 0) => rxcdrlock_out(2 downto 0),
      rxcdrovrden_in(2 downto 0) => rxcdrovrden_in(2 downto 0),
      rxcdrphdone_out(2 downto 0) => rxcdrphdone_out(2 downto 0),
      rxcdrreset_in(2 downto 0) => rxcdrreset_in(2 downto 0),
      rxcdrresetrsv_in(2 downto 0) => rxcdrresetrsv_in(2 downto 0),
      rxchanbondseq_out(2 downto 0) => rxchanbondseq_out(2 downto 0),
      rxchanisaligned_out(2 downto 0) => rxchanisaligned_out(2 downto 0),
      rxchanrealign_out(2 downto 0) => rxchanrealign_out(2 downto 0),
      rxchbonden_in(2 downto 0) => rxchbonden_in(2 downto 0),
      rxchbondi_in(14 downto 0) => rxchbondi_in(14 downto 0),
      rxchbondlevel_in(8 downto 0) => rxchbondlevel_in(8 downto 0),
      rxchbondmaster_in(2 downto 0) => rxchbondmaster_in(2 downto 0),
      rxchbondo_out(14 downto 0) => rxchbondo_out(14 downto 0),
      rxchbondslave_in(2 downto 0) => rxchbondslave_in(2 downto 0),
      rxclkcorcnt_out(5 downto 0) => rxclkcorcnt_out(5 downto 0),
      rxcominitdet_out(2 downto 0) => rxcominitdet_out(2 downto 0),
      rxcommadet_out(2 downto 0) => rxcommadet_out(2 downto 0),
      rxcommadeten_in(2 downto 0) => rxcommadeten_in(2 downto 0),
      rxcomsasdet_out(2 downto 0) => rxcomsasdet_out(2 downto 0),
      rxcomwakedet_out(2 downto 0) => rxcomwakedet_out(2 downto 0),
      rxctrl0_out(47 downto 0) => rxctrl0_out(47 downto 0),
      rxctrl1_out(47 downto 0) => rxctrl1_out(47 downto 0),
      rxctrl2_out(23 downto 0) => rxctrl2_out(23 downto 0),
      rxctrl3_out(23 downto 0) => rxctrl3_out(23 downto 0),
      rxdata_out(383 downto 0) => rxdata_out(383 downto 0),
      rxdataextendrsvd_out(23 downto 0) => rxdataextendrsvd_out(23 downto 0),
      rxdatavalid_out(5 downto 0) => rxdatavalid_out(5 downto 0),
      rxdfeagcctrl_in(5 downto 0) => rxdfeagcctrl_in(5 downto 0),
      rxdfeagchold_in(2 downto 0) => rxdfeagchold_in(2 downto 0),
      rxdfeagcovrden_in(2 downto 0) => rxdfeagcovrden_in(2 downto 0),
      rxdfelfhold_in(2 downto 0) => rxdfelfhold_in(2 downto 0),
      rxdfelfovrden_in(2 downto 0) => rxdfelfovrden_in(2 downto 0),
      rxdfelpmreset_in(2 downto 0) => rxdfelpmreset_in(2 downto 0),
      rxdfetap10hold_in(2 downto 0) => rxdfetap10hold_in(2 downto 0),
      rxdfetap10ovrden_in(2 downto 0) => rxdfetap10ovrden_in(2 downto 0),
      rxdfetap11hold_in(2 downto 0) => rxdfetap11hold_in(2 downto 0),
      rxdfetap11ovrden_in(2 downto 0) => rxdfetap11ovrden_in(2 downto 0),
      rxdfetap12hold_in(2 downto 0) => rxdfetap12hold_in(2 downto 0),
      rxdfetap12ovrden_in(2 downto 0) => rxdfetap12ovrden_in(2 downto 0),
      rxdfetap13hold_in(2 downto 0) => rxdfetap13hold_in(2 downto 0),
      rxdfetap13ovrden_in(2 downto 0) => rxdfetap13ovrden_in(2 downto 0),
      rxdfetap14hold_in(2 downto 0) => rxdfetap14hold_in(2 downto 0),
      rxdfetap14ovrden_in(2 downto 0) => rxdfetap14ovrden_in(2 downto 0),
      rxdfetap15hold_in(2 downto 0) => rxdfetap15hold_in(2 downto 0),
      rxdfetap15ovrden_in(2 downto 0) => rxdfetap15ovrden_in(2 downto 0),
      rxdfetap2hold_in(2 downto 0) => rxdfetap2hold_in(2 downto 0),
      rxdfetap2ovrden_in(2 downto 0) => rxdfetap2ovrden_in(2 downto 0),
      rxdfetap3hold_in(2 downto 0) => rxdfetap3hold_in(2 downto 0),
      rxdfetap3ovrden_in(2 downto 0) => rxdfetap3ovrden_in(2 downto 0),
      rxdfetap4hold_in(2 downto 0) => rxdfetap4hold_in(2 downto 0),
      rxdfetap4ovrden_in(2 downto 0) => rxdfetap4ovrden_in(2 downto 0),
      rxdfetap5hold_in(2 downto 0) => rxdfetap5hold_in(2 downto 0),
      rxdfetap5ovrden_in(2 downto 0) => rxdfetap5ovrden_in(2 downto 0),
      rxdfetap6hold_in(2 downto 0) => rxdfetap6hold_in(2 downto 0),
      rxdfetap6ovrden_in(2 downto 0) => rxdfetap6ovrden_in(2 downto 0),
      rxdfetap7hold_in(2 downto 0) => rxdfetap7hold_in(2 downto 0),
      rxdfetap7ovrden_in(2 downto 0) => rxdfetap7ovrden_in(2 downto 0),
      rxdfetap8hold_in(2 downto 0) => rxdfetap8hold_in(2 downto 0),
      rxdfetap8ovrden_in(2 downto 0) => rxdfetap8ovrden_in(2 downto 0),
      rxdfetap9hold_in(2 downto 0) => rxdfetap9hold_in(2 downto 0),
      rxdfetap9ovrden_in(2 downto 0) => rxdfetap9ovrden_in(2 downto 0),
      rxdfeuthold_in(2 downto 0) => rxdfeuthold_in(2 downto 0),
      rxdfeutovrden_in(2 downto 0) => rxdfeutovrden_in(2 downto 0),
      rxdfevphold_in(2 downto 0) => rxdfevphold_in(2 downto 0),
      rxdfevpovrden_in(2 downto 0) => rxdfevpovrden_in(2 downto 0),
      rxdfevsen_in(2 downto 0) => rxdfevsen_in(2 downto 0),
      rxdfexyden_in(2 downto 0) => rxdfexyden_in(2 downto 0),
      rxdlybypass_in(2 downto 0) => rxdlybypass_in(2 downto 0),
      rxdlyen_in(2 downto 0) => rxdlyen_in(2 downto 0),
      rxdlyovrden_in(2 downto 0) => rxdlyovrden_in(2 downto 0),
      rxdlysreset_in(2 downto 0) => rxdlysreset_in(2 downto 0),
      rxdlysresetdone_out(2 downto 0) => rxdlysresetdone_out(2 downto 0),
      rxelecidle_out(2 downto 0) => rxelecidle_out(2 downto 0),
      rxelecidlemode_in(5 downto 0) => rxelecidlemode_in(5 downto 0),
      rxgearboxslip_in(2 downto 0) => rxgearboxslip_in(2 downto 0),
      rxheader_out(17 downto 0) => rxheader_out(17 downto 0),
      rxheadervalid_out(5 downto 0) => rxheadervalid_out(5 downto 0),
      rxlatclk_in(2 downto 0) => rxlatclk_in(2 downto 0),
      rxlpmen_in(2 downto 0) => rxlpmen_in(2 downto 0),
      rxlpmgchold_in(2 downto 0) => rxlpmgchold_in(2 downto 0),
      rxlpmgcovrden_in(2 downto 0) => rxlpmgcovrden_in(2 downto 0),
      rxlpmhfhold_in(2 downto 0) => rxlpmhfhold_in(2 downto 0),
      rxlpmhfovrden_in(2 downto 0) => rxlpmhfovrden_in(2 downto 0),
      rxlpmlfhold_in(2 downto 0) => rxlpmlfhold_in(2 downto 0),
      rxlpmlfklovrden_in(2 downto 0) => rxlpmlfklovrden_in(2 downto 0),
      rxlpmoshold_in(2 downto 0) => rxlpmoshold_in(2 downto 0),
      rxlpmosovrden_in(2 downto 0) => rxlpmosovrden_in(2 downto 0),
      rxmcommaalignen_in(2 downto 0) => rxmcommaalignen_in(2 downto 0),
      rxmonitorout_out(20 downto 0) => rxmonitorout_out(20 downto 0),
      rxmonitorsel_in(5 downto 0) => rxmonitorsel_in(5 downto 0),
      rxoobreset_in(2 downto 0) => rxoobreset_in(2 downto 0),
      rxoscalreset_in(2 downto 0) => rxoscalreset_in(2 downto 0),
      rxoshold_in(2 downto 0) => rxoshold_in(2 downto 0),
      rxosintcfg_in(11 downto 0) => rxosintcfg_in(11 downto 0),
      rxosintdone_out(2 downto 0) => rxosintdone_out(2 downto 0),
      rxosinten_in(2 downto 0) => rxosinten_in(2 downto 0),
      rxosinthold_in(2 downto 0) => rxosinthold_in(2 downto 0),
      rxosintovrden_in(2 downto 0) => rxosintovrden_in(2 downto 0),
      rxosintstarted_out(2 downto 0) => rxosintstarted_out(2 downto 0),
      rxosintstrobe_in(2 downto 0) => rxosintstrobe_in(2 downto 0),
      rxosintstrobedone_out(2 downto 0) => rxosintstrobedone_out(2 downto 0),
      rxosintstrobestarted_out(2 downto 0) => rxosintstrobestarted_out(2 downto 0),
      rxosinttestovrden_in(2 downto 0) => rxosinttestovrden_in(2 downto 0),
      rxosovrden_in(2 downto 0) => rxosovrden_in(2 downto 0),
      rxoutclk_out(2 downto 0) => rxoutclk_out(2 downto 0),
      rxoutclkfabric_out(2 downto 0) => rxoutclkfabric_out(2 downto 0),
      rxoutclkpcs_out(2 downto 0) => rxoutclkpcs_out(2 downto 0),
      rxoutclksel_in(8 downto 0) => rxoutclksel_in(8 downto 0),
      rxpcommaalignen_in(2 downto 0) => rxpcommaalignen_in(2 downto 0),
      rxpcsreset_in(2 downto 0) => rxpcsreset_in(2 downto 0),
      rxpd_in(5 downto 0) => rxpd_in(5 downto 0),
      rxphalign_in(2 downto 0) => rxphalign_in(2 downto 0),
      rxphaligndone_out(2 downto 0) => rxphaligndone_out(2 downto 0),
      rxphalignen_in(2 downto 0) => rxphalignen_in(2 downto 0),
      rxphalignerr_out(2 downto 0) => rxphalignerr_out(2 downto 0),
      rxphdlypd_in(2 downto 0) => rxphdlypd_in(2 downto 0),
      rxphdlyreset_in(2 downto 0) => rxphdlyreset_in(2 downto 0),
      rxphovrden_in(2 downto 0) => rxphovrden_in(2 downto 0),
      rxpllclksel_in(5 downto 0) => rxpllclksel_in(5 downto 0),
      rxpmareset_in(2 downto 0) => rxpmareset_in(2 downto 0),
      rxpmaresetdone_out(2 downto 0) => rxpmaresetdone_out(2 downto 0),
      rxpolarity_in(2 downto 0) => rxpolarity_in(2 downto 0),
      rxprbscntreset_in(2 downto 0) => rxprbscntreset_in(2 downto 0),
      rxprbserr_out(2 downto 0) => rxprbserr_out(2 downto 0),
      rxprbslocked_out(2 downto 0) => rxprbslocked_out(2 downto 0),
      rxprbssel_in(11 downto 0) => rxprbssel_in(11 downto 0),
      rxprgdivresetdone_out(2 downto 0) => rxprgdivresetdone_out(2 downto 0),
      rxqpien_in(2 downto 0) => rxqpien_in(2 downto 0),
      rxqpisenn_out(2 downto 0) => rxqpisenn_out(2 downto 0),
      rxqpisenp_out(2 downto 0) => rxqpisenp_out(2 downto 0),
      rxrate_in(8 downto 0) => rxrate_in(8 downto 0),
      rxratedone_out(2 downto 0) => rxratedone_out(2 downto 0),
      rxratemode_in(2 downto 0) => rxratemode_in(2 downto 0),
      rxrecclkout_out(2 downto 0) => rxrecclkout_out(2 downto 0),
      rxresetdone_out(2 downto 0) => rxresetdone_out(2 downto 0),
      rxslide_in(2 downto 0) => rxslide_in(2 downto 0),
      rxsliderdy_out(2 downto 0) => rxsliderdy_out(2 downto 0),
      rxslipdone_out(2 downto 0) => rxslipdone_out(2 downto 0),
      rxslipoutclk_in(2 downto 0) => rxslipoutclk_in(2 downto 0),
      rxslipoutclkrdy_out(2 downto 0) => rxslipoutclkrdy_out(2 downto 0),
      rxslippma_in(2 downto 0) => rxslippma_in(2 downto 0),
      rxslippmardy_out(2 downto 0) => rxslippmardy_out(2 downto 0),
      rxstartofseq_out(5 downto 0) => rxstartofseq_out(5 downto 0),
      rxstatus_out(8 downto 0) => rxstatus_out(8 downto 0),
      rxsyncallin_in(2 downto 0) => rxsyncallin_in(2 downto 0),
      rxsyncdone_out(2 downto 0) => rxsyncdone_out(2 downto 0),
      rxsyncin_in(2 downto 0) => rxsyncin_in(2 downto 0),
      rxsyncmode_in(2 downto 0) => rxsyncmode_in(2 downto 0),
      rxsyncout_out(2 downto 0) => rxsyncout_out(2 downto 0),
      rxsysclksel_in(5 downto 0) => rxsysclksel_in(5 downto 0),
      rxusrclk2_in(2 downto 0) => rxusrclk2_in(2 downto 0),
      rxusrclk_in(2 downto 0) => rxusrclk_in(2 downto 0),
      rxvalid_out(2 downto 0) => rxvalid_out(2 downto 0),
      sigvalidclk_in(2 downto 0) => sigvalidclk_in(2 downto 0),
      tx8b10bbypass_in(23 downto 0) => tx8b10bbypass_in(23 downto 0),
      tx8b10ben_in(2 downto 0) => tx8b10ben_in(2 downto 0),
      txbufdiffctrl_in(8 downto 0) => txbufdiffctrl_in(8 downto 0),
      txbufstatus_out(5 downto 0) => txbufstatus_out(5 downto 0),
      txcomfinish_out(2 downto 0) => txcomfinish_out(2 downto 0),
      txcominit_in(2 downto 0) => txcominit_in(2 downto 0),
      txcomsas_in(2 downto 0) => txcomsas_in(2 downto 0),
      txcomwake_in(2 downto 0) => txcomwake_in(2 downto 0),
      txctrl0_in(47 downto 0) => txctrl0_in(47 downto 0),
      txctrl1_in(47 downto 0) => txctrl1_in(47 downto 0),
      txctrl2_in(23 downto 0) => txctrl2_in(23 downto 0),
      txdataextendrsvd_in(23 downto 0) => txdataextendrsvd_in(23 downto 0),
      txdeemph_in(2 downto 0) => txdeemph_in(2 downto 0),
      txdetectrx_in(2 downto 0) => txdetectrx_in(2 downto 0),
      txdiffctrl_in(11 downto 0) => txdiffctrl_in(11 downto 0),
      txdiffpd_in(2 downto 0) => txdiffpd_in(2 downto 0),
      txdlysresetdone_out(2 downto 0) => txdlysresetdone_out(2 downto 0),
      txelecidle_in(2 downto 0) => txelecidle_in(2 downto 0),
      txheader_in(17 downto 0) => txheader_in(17 downto 0),
      txinhibit_in(2 downto 0) => txinhibit_in(2 downto 0),
      txlatclk_in(2 downto 0) => txlatclk_in(2 downto 0),
      txmaincursor_in(20 downto 0) => txmaincursor_in(20 downto 0),
      txmargin_in(8 downto 0) => txmargin_in(8 downto 0),
      txoutclk_out(2 downto 0) => txoutclk_out(2 downto 0),
      txoutclkfabric_out(2 downto 0) => txoutclkfabric_out(2 downto 0),
      txoutclkpcs_out(2 downto 0) => txoutclkpcs_out(2 downto 0),
      txoutclksel_in(8 downto 0) => txoutclksel_in(8 downto 0),
      txpcsreset_in(2 downto 0) => txpcsreset_in(2 downto 0),
      txpd_in(5 downto 0) => txpd_in(5 downto 0),
      txpdelecidlemode_in(2 downto 0) => txpdelecidlemode_in(2 downto 0),
      txphaligndone_out(2 downto 0) => txphaligndone_out(2 downto 0),
      txphinitdone_out(2 downto 0) => txphinitdone_out(2 downto 0),
      txpippmen_in(2 downto 0) => txpippmen_in(2 downto 0),
      txpippmovrden_in(2 downto 0) => txpippmovrden_in(2 downto 0),
      txpippmpd_in(2 downto 0) => txpippmpd_in(2 downto 0),
      txpippmsel_in(2 downto 0) => txpippmsel_in(2 downto 0),
      txpippmstepsize_in(14 downto 0) => txpippmstepsize_in(14 downto 0),
      txpisopd_in(2 downto 0) => txpisopd_in(2 downto 0),
      txpllclksel_in(5 downto 0) => txpllclksel_in(5 downto 0),
      txpmareset_in(2 downto 0) => txpmareset_in(2 downto 0),
      txpmaresetdone_out(2 downto 0) => txpmaresetdone_out(2 downto 0),
      txpolarity_in(2 downto 0) => txpolarity_in(2 downto 0),
      txpostcursor_in(14 downto 0) => txpostcursor_in(14 downto 0),
      txpostcursorinv_in(2 downto 0) => txpostcursorinv_in(2 downto 0),
      txprbsforceerr_in(2 downto 0) => txprbsforceerr_in(2 downto 0),
      txprbssel_in(11 downto 0) => txprbssel_in(11 downto 0),
      txprecursor_in(14 downto 0) => txprecursor_in(14 downto 0),
      txprecursorinv_in(2 downto 0) => txprecursorinv_in(2 downto 0),
      txprgdivresetdone_out(2 downto 0) => txprgdivresetdone_out(2 downto 0),
      txqpibiasen_in(2 downto 0) => txqpibiasen_in(2 downto 0),
      txqpisenn_out(2 downto 0) => txqpisenn_out(2 downto 0),
      txqpisenp_out(2 downto 0) => txqpisenp_out(2 downto 0),
      txqpistrongpdown_in(2 downto 0) => txqpistrongpdown_in(2 downto 0),
      txqpiweakpup_in(2 downto 0) => txqpiweakpup_in(2 downto 0),
      txrate_in(8 downto 0) => txrate_in(8 downto 0),
      txratedone_out(2 downto 0) => txratedone_out(2 downto 0),
      txratemode_in(2 downto 0) => txratemode_in(2 downto 0),
      txresetdone_out(2 downto 0) => txresetdone_out(2 downto 0),
      txsequence_in(20 downto 0) => txsequence_in(20 downto 0),
      txswing_in(2 downto 0) => txswing_in(2 downto 0),
      txsyncdone_out(2 downto 0) => txsyncdone_out(2 downto 0),
      txsyncout_out(2 downto 0) => txsyncout_out(2 downto 0),
      txsysclksel_in(5 downto 0) => txsysclksel_in(5 downto 0),
      txusrclk2_in(2 downto 0) => txusrclk2_in(2 downto 0),
      txusrclk_in(2 downto 0) => txusrclk_in(2 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gthe3_channel_wrapper__parameterized0\ is
  port (
    rst_in0 : out STD_LOGIC;
    cplllock_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    in0 : out STD_LOGIC;
    cpllfbclklost_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    cpllrefclklost_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    drprdy_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    eyescandataerror_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gthtxn_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gthtxp_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gtpowergood_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gtrefclkmonitor_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcierategen3_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcierateidle_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pciesynctxsyncdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcieusergen3rdy_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcieuserphystatusrst_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcieuserratestart_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    phystatus_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    resetexception_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxbyteisaligned_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxbyterealign_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrlock_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrphdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxchanbondseq_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxchanisaligned_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxchanrealign_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcominitdet_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcommadet_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcomsasdet_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcomwakedet_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdlysresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxelecidle_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosintdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosintstarted_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosintstrobedone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosintstrobestarted_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxoutclk_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxoutclkfabric_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxoutclkpcs_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxphaligndone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxphalignerr_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxpmaresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxprbserr_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxprbslocked_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxprgdivresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxqpisenn_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxqpisenp_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxratedone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxrecclkout_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxsliderdy_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxslipdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxslipoutclkrdy_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxslippmardy_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxsyncdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxsyncout_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxvalid_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txcomfinish_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txdlysresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txoutclk_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txoutclkfabric_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txoutclkpcs_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txphaligndone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txphinitdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txpmaresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txprgdivresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txqpisenn_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txqpisenp_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txratedone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txresetdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txsyncdone_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txsyncout_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcsrsvdout_out : out STD_LOGIC_VECTOR ( 47 downto 0 );
    rxdata_out : out STD_LOGIC_VECTOR ( 511 downto 0 );
    drpdo_out : out STD_LOGIC_VECTOR ( 63 downto 0 );
    rxctrl0_out : out STD_LOGIC_VECTOR ( 63 downto 0 );
    rxctrl1_out : out STD_LOGIC_VECTOR ( 63 downto 0 );
    dmonitorout_out : out STD_LOGIC_VECTOR ( 67 downto 0 );
    pcierateqpllpd_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    pcierateqpllreset_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rxclkcorcnt_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rxdatavalid_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rxheadervalid_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rxstartofseq_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    txbufstatus_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    bufgtce_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    bufgtcemask_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    bufgtreset_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    bufgtrstmask_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    rxbufstatus_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    rxstatus_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    rxchbondo_out : out STD_LOGIC_VECTOR ( 19 downto 0 );
    rxheader_out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    rxmonitorout_out : out STD_LOGIC_VECTOR ( 27 downto 0 );
    pinrsrvdas_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rxctrl2_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rxctrl3_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rxdataextendrsvd_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bufgtdiv_out : out STD_LOGIC_VECTOR ( 35 downto 0 );
    gtrxreset_out_reg : in STD_LOGIC;
    cfgreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    clkrsvd0_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    clkrsvd1_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    cplllockdetclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    cplllocken_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_CPLLPD : in STD_LOGIC_VECTOR ( 0 to 0 );
    cpllreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    dmonfiforeset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    dmonitorclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    drpclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    drpen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    drpwe_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    evoddphicaldone_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    evoddphicalstart_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    evoddphidrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    evoddphidwren_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    evoddphixrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    evoddphixwren_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eyescanmode_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eyescanreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eyescantrigger_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtgrefclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gthrxn_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gthrxp_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtnorthrefclk0_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtnorthrefclk1_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtrefclk0_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtrefclk1_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtresetsel_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_GTRXRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtsouthrefclk0_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtsouthrefclk1_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_GTTXRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    lpbkrxtxseren_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    lpbktxrxseren_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    pcieeqrxeqadaptdone_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    pcierstidle_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    pciersttxsyncstart_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    pcieuserratedone_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    qpll0clk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    qpll0refclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    qpll1clk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    qpll1refclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    resetovrd_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rstclkentx_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rx8b10ben_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxbufreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrfreqreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrhold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcdrresetrsv_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxchbonden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxchbondmaster_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxchbondslave_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxcommadeten_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfeagchold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfeagcovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfelfhold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfelfovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfelpmreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap10hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap10ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap11hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap11ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap12hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap12ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap13hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap13ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap14hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap14ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap15hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap15ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap2hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap2ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap3hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap3ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap4hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap4ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap5hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap5ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap6hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap6ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap7hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap7ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap8hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap8ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap9hold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfetap9ovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfeuthold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfeutovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfevphold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfevpovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfevsen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdfexyden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdlybypass_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdlyen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdlyovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxdlysreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxgearboxslip_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlatclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmgchold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmgcovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmhfhold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmhfovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmlfhold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmlfklovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmoshold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxlpmosovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxmcommaalignen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxoobreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxoscalreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxoshold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosinten_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosinthold_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosintovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosintstrobe_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosinttestovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxosovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxpcommaalignen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxpcsreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxphalign_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxphalignen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxphdlypd_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxphdlyreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxphovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxpmareset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxpolarity_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxprbscntreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_RXPROGDIVRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxqpien_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxratemode_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxslide_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxslipoutclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxslippma_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxsyncallin_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxsyncin_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxsyncmode_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_RXUSERRDY : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxusrclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxusrclk2_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    sigvalidclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    tx8b10ben_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txcominit_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txcomsas_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txcomwake_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txdeemph_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txdetectrx_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txdiffpd_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_TXDLYSRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    txelecidle_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txinhibit_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txlatclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpcsreset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpdelecidlemode_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpippmen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpippmovrden_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpippmpd_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpippmsel_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpisopd_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpmareset_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpolarity_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txpostcursorinv_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txprbsforceerr_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txprecursorinv_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_TXPROGDIVRESET : in STD_LOGIC_VECTOR ( 0 to 0 );
    txqpibiasen_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txqpistrongpdown_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txqpiweakpup_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txratemode_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txswing_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GTHE3_CHANNEL_TXSYNCALLIN : in STD_LOGIC_VECTOR ( 0 to 0 );
    GTHE3_CHANNEL_TXUSERRDY : in STD_LOGIC_VECTOR ( 0 to 0 );
    txusrclk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txusrclk2_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gtwiz_userdata_tx_in : in STD_LOGIC_VECTOR ( 127 downto 0 );
    drpdi_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    gtrsvd_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    pcsrsvdin_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    txctrl0_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    txctrl1_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
    rxdfeagcctrl_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rxelecidlemode_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rxmonitorsel_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rxpd_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rxpllclksel_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rxsysclksel_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    txpd_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    txpllclksel_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    txsysclksel_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    cpllrefclksel_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    loopback_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    rxchbondlevel_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    rxoutclksel_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    rxrate_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    txbufdiffctrl_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    txmargin_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    txoutclksel_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    txrate_in : in STD_LOGIC_VECTOR ( 11 downto 0 );
    rxosintcfg_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    rxprbssel_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    txdiffctrl_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    txprbssel_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    pcsrsvdin2_in : in STD_LOGIC_VECTOR ( 19 downto 0 );
    pmarsvdin_in : in STD_LOGIC_VECTOR ( 19 downto 0 );
    rxchbondi_in : in STD_LOGIC_VECTOR ( 19 downto 0 );
    txpippmstepsize_in : in STD_LOGIC_VECTOR ( 19 downto 0 );
    txpostcursor_in : in STD_LOGIC_VECTOR ( 19 downto 0 );
    txprecursor_in : in STD_LOGIC_VECTOR ( 19 downto 0 );
    txheader_in : in STD_LOGIC_VECTOR ( 23 downto 0 );
    txmaincursor_in : in STD_LOGIC_VECTOR ( 27 downto 0 );
    txsequence_in : in STD_LOGIC_VECTOR ( 27 downto 0 );
    tx8b10bbypass_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    txctrl2_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    txdataextendrsvd_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    drpaddr_in : in STD_LOGIC_VECTOR ( 35 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gthe3_channel_wrapper__parameterized0\ : entity is "JesdCryoCoreRightColumn_gthe3_channel_wrapper";
end \JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gthe3_channel_wrapper__parameterized0\;

architecture STRUCTURE of \JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gthe3_channel_wrapper__parameterized0\ is
begin
channel_inst: entity work.\JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gthe3_channel__parameterized0\
     port map (
      GTHE3_CHANNEL_CPLLPD(0) => GTHE3_CHANNEL_CPLLPD(0),
      GTHE3_CHANNEL_GTRXRESET(0) => GTHE3_CHANNEL_GTRXRESET(0),
      GTHE3_CHANNEL_GTTXRESET(0) => GTHE3_CHANNEL_GTTXRESET(0),
      GTHE3_CHANNEL_RXPROGDIVRESET(0) => GTHE3_CHANNEL_RXPROGDIVRESET(0),
      GTHE3_CHANNEL_RXUSERRDY(0) => GTHE3_CHANNEL_RXUSERRDY(0),
      GTHE3_CHANNEL_TXDLYSRESET(0) => GTHE3_CHANNEL_TXDLYSRESET(0),
      GTHE3_CHANNEL_TXPROGDIVRESET(0) => GTHE3_CHANNEL_TXPROGDIVRESET(0),
      GTHE3_CHANNEL_TXSYNCALLIN(0) => GTHE3_CHANNEL_TXSYNCALLIN(0),
      GTHE3_CHANNEL_TXUSERRDY(0) => GTHE3_CHANNEL_TXUSERRDY(0),
      bufgtce_out(11 downto 0) => bufgtce_out(11 downto 0),
      bufgtcemask_out(11 downto 0) => bufgtcemask_out(11 downto 0),
      bufgtdiv_out(35 downto 0) => bufgtdiv_out(35 downto 0),
      bufgtreset_out(11 downto 0) => bufgtreset_out(11 downto 0),
      bufgtrstmask_out(11 downto 0) => bufgtrstmask_out(11 downto 0),
      cfgreset_in(3 downto 0) => cfgreset_in(3 downto 0),
      clkrsvd0_in(3 downto 0) => clkrsvd0_in(3 downto 0),
      clkrsvd1_in(3 downto 0) => clkrsvd1_in(3 downto 0),
      cpllfbclklost_out(3 downto 0) => cpllfbclklost_out(3 downto 0),
      cplllock_out(3 downto 0) => cplllock_out(3 downto 0),
      cplllockdetclk_in(3 downto 0) => cplllockdetclk_in(3 downto 0),
      cplllocken_in(3 downto 0) => cplllocken_in(3 downto 0),
      cpllrefclklost_out(3 downto 0) => cpllrefclklost_out(3 downto 0),
      cpllrefclksel_in(11 downto 0) => cpllrefclksel_in(11 downto 0),
      cpllreset_in(3 downto 0) => cpllreset_in(3 downto 0),
      dmonfiforeset_in(3 downto 0) => dmonfiforeset_in(3 downto 0),
      dmonitorclk_in(3 downto 0) => dmonitorclk_in(3 downto 0),
      dmonitorout_out(67 downto 0) => dmonitorout_out(67 downto 0),
      drpaddr_in(35 downto 0) => drpaddr_in(35 downto 0),
      drpclk_in(3 downto 0) => drpclk_in(3 downto 0),
      drpdi_in(63 downto 0) => drpdi_in(63 downto 0),
      drpdo_out(63 downto 0) => drpdo_out(63 downto 0),
      drpen_in(3 downto 0) => drpen_in(3 downto 0),
      drprdy_out(3 downto 0) => drprdy_out(3 downto 0),
      drpwe_in(3 downto 0) => drpwe_in(3 downto 0),
      evoddphicaldone_in(3 downto 0) => evoddphicaldone_in(3 downto 0),
      evoddphicalstart_in(3 downto 0) => evoddphicalstart_in(3 downto 0),
      evoddphidrden_in(3 downto 0) => evoddphidrden_in(3 downto 0),
      evoddphidwren_in(3 downto 0) => evoddphidwren_in(3 downto 0),
      evoddphixrden_in(3 downto 0) => evoddphixrden_in(3 downto 0),
      evoddphixwren_in(3 downto 0) => evoddphixwren_in(3 downto 0),
      eyescandataerror_out(3 downto 0) => eyescandataerror_out(3 downto 0),
      eyescanmode_in(3 downto 0) => eyescanmode_in(3 downto 0),
      eyescanreset_in(3 downto 0) => eyescanreset_in(3 downto 0),
      eyescantrigger_in(3 downto 0) => eyescantrigger_in(3 downto 0),
      gtgrefclk_in(3 downto 0) => gtgrefclk_in(3 downto 0),
      gthrxn_in(3 downto 0) => gthrxn_in(3 downto 0),
      gthrxp_in(3 downto 0) => gthrxp_in(3 downto 0),
      gthtxn_out(3 downto 0) => gthtxn_out(3 downto 0),
      gthtxp_out(3 downto 0) => gthtxp_out(3 downto 0),
      gtnorthrefclk0_in(3 downto 0) => gtnorthrefclk0_in(3 downto 0),
      gtnorthrefclk1_in(3 downto 0) => gtnorthrefclk1_in(3 downto 0),
      gtpowergood_out(3 downto 0) => gtpowergood_out(3 downto 0),
      gtrefclk0_in(3 downto 0) => gtrefclk0_in(3 downto 0),
      gtrefclk1_in(3 downto 0) => gtrefclk1_in(3 downto 0),
      gtrefclkmonitor_out(3 downto 0) => gtrefclkmonitor_out(3 downto 0),
      gtresetsel_in(3 downto 0) => gtresetsel_in(3 downto 0),
      gtrsvd_in(63 downto 0) => gtrsvd_in(63 downto 0),
      gtrxreset_out_reg => gtrxreset_out_reg,
      gtsouthrefclk0_in(3 downto 0) => gtsouthrefclk0_in(3 downto 0),
      gtsouthrefclk1_in(3 downto 0) => gtsouthrefclk1_in(3 downto 0),
      gtwiz_userdata_tx_in(127 downto 0) => gtwiz_userdata_tx_in(127 downto 0),
      in0 => in0,
      loopback_in(11 downto 0) => loopback_in(11 downto 0),
      lpbkrxtxseren_in(3 downto 0) => lpbkrxtxseren_in(3 downto 0),
      lpbktxrxseren_in(3 downto 0) => lpbktxrxseren_in(3 downto 0),
      pcieeqrxeqadaptdone_in(3 downto 0) => pcieeqrxeqadaptdone_in(3 downto 0),
      pcierategen3_out(3 downto 0) => pcierategen3_out(3 downto 0),
      pcierateidle_out(3 downto 0) => pcierateidle_out(3 downto 0),
      pcierateqpllpd_out(7 downto 0) => pcierateqpllpd_out(7 downto 0),
      pcierateqpllreset_out(7 downto 0) => pcierateqpllreset_out(7 downto 0),
      pcierstidle_in(3 downto 0) => pcierstidle_in(3 downto 0),
      pciersttxsyncstart_in(3 downto 0) => pciersttxsyncstart_in(3 downto 0),
      pciesynctxsyncdone_out(3 downto 0) => pciesynctxsyncdone_out(3 downto 0),
      pcieusergen3rdy_out(3 downto 0) => pcieusergen3rdy_out(3 downto 0),
      pcieuserphystatusrst_out(3 downto 0) => pcieuserphystatusrst_out(3 downto 0),
      pcieuserratedone_in(3 downto 0) => pcieuserratedone_in(3 downto 0),
      pcieuserratestart_out(3 downto 0) => pcieuserratestart_out(3 downto 0),
      pcsrsvdin2_in(19 downto 0) => pcsrsvdin2_in(19 downto 0),
      pcsrsvdin_in(63 downto 0) => pcsrsvdin_in(63 downto 0),
      pcsrsvdout_out(47 downto 0) => pcsrsvdout_out(47 downto 0),
      phystatus_out(3 downto 0) => phystatus_out(3 downto 0),
      pinrsrvdas_out(31 downto 0) => pinrsrvdas_out(31 downto 0),
      pmarsvdin_in(19 downto 0) => pmarsvdin_in(19 downto 0),
      qpll0clk_in(3 downto 0) => qpll0clk_in(3 downto 0),
      qpll0refclk_in(3 downto 0) => qpll0refclk_in(3 downto 0),
      qpll1clk_in(3 downto 0) => qpll1clk_in(3 downto 0),
      qpll1refclk_in(3 downto 0) => qpll1refclk_in(3 downto 0),
      resetexception_out(3 downto 0) => resetexception_out(3 downto 0),
      resetovrd_in(3 downto 0) => resetovrd_in(3 downto 0),
      rst_in0 => rst_in0,
      rstclkentx_in(3 downto 0) => rstclkentx_in(3 downto 0),
      rx8b10ben_in(3 downto 0) => rx8b10ben_in(3 downto 0),
      rxbufreset_in(3 downto 0) => rxbufreset_in(3 downto 0),
      rxbufstatus_out(11 downto 0) => rxbufstatus_out(11 downto 0),
      rxbyteisaligned_out(3 downto 0) => rxbyteisaligned_out(3 downto 0),
      rxbyterealign_out(3 downto 0) => rxbyterealign_out(3 downto 0),
      rxcdrfreqreset_in(3 downto 0) => rxcdrfreqreset_in(3 downto 0),
      rxcdrhold_in(3 downto 0) => rxcdrhold_in(3 downto 0),
      rxcdrlock_out(3 downto 0) => rxcdrlock_out(3 downto 0),
      rxcdrovrden_in(3 downto 0) => rxcdrovrden_in(3 downto 0),
      rxcdrphdone_out(3 downto 0) => rxcdrphdone_out(3 downto 0),
      rxcdrreset_in(3 downto 0) => rxcdrreset_in(3 downto 0),
      rxcdrresetrsv_in(3 downto 0) => rxcdrresetrsv_in(3 downto 0),
      rxchanbondseq_out(3 downto 0) => rxchanbondseq_out(3 downto 0),
      rxchanisaligned_out(3 downto 0) => rxchanisaligned_out(3 downto 0),
      rxchanrealign_out(3 downto 0) => rxchanrealign_out(3 downto 0),
      rxchbonden_in(3 downto 0) => rxchbonden_in(3 downto 0),
      rxchbondi_in(19 downto 0) => rxchbondi_in(19 downto 0),
      rxchbondlevel_in(11 downto 0) => rxchbondlevel_in(11 downto 0),
      rxchbondmaster_in(3 downto 0) => rxchbondmaster_in(3 downto 0),
      rxchbondo_out(19 downto 0) => rxchbondo_out(19 downto 0),
      rxchbondslave_in(3 downto 0) => rxchbondslave_in(3 downto 0),
      rxclkcorcnt_out(7 downto 0) => rxclkcorcnt_out(7 downto 0),
      rxcominitdet_out(3 downto 0) => rxcominitdet_out(3 downto 0),
      rxcommadet_out(3 downto 0) => rxcommadet_out(3 downto 0),
      rxcommadeten_in(3 downto 0) => rxcommadeten_in(3 downto 0),
      rxcomsasdet_out(3 downto 0) => rxcomsasdet_out(3 downto 0),
      rxcomwakedet_out(3 downto 0) => rxcomwakedet_out(3 downto 0),
      rxctrl0_out(63 downto 0) => rxctrl0_out(63 downto 0),
      rxctrl1_out(63 downto 0) => rxctrl1_out(63 downto 0),
      rxctrl2_out(31 downto 0) => rxctrl2_out(31 downto 0),
      rxctrl3_out(31 downto 0) => rxctrl3_out(31 downto 0),
      rxdata_out(511 downto 0) => rxdata_out(511 downto 0),
      rxdataextendrsvd_out(31 downto 0) => rxdataextendrsvd_out(31 downto 0),
      rxdatavalid_out(7 downto 0) => rxdatavalid_out(7 downto 0),
      rxdfeagcctrl_in(7 downto 0) => rxdfeagcctrl_in(7 downto 0),
      rxdfeagchold_in(3 downto 0) => rxdfeagchold_in(3 downto 0),
      rxdfeagcovrden_in(3 downto 0) => rxdfeagcovrden_in(3 downto 0),
      rxdfelfhold_in(3 downto 0) => rxdfelfhold_in(3 downto 0),
      rxdfelfovrden_in(3 downto 0) => rxdfelfovrden_in(3 downto 0),
      rxdfelpmreset_in(3 downto 0) => rxdfelpmreset_in(3 downto 0),
      rxdfetap10hold_in(3 downto 0) => rxdfetap10hold_in(3 downto 0),
      rxdfetap10ovrden_in(3 downto 0) => rxdfetap10ovrden_in(3 downto 0),
      rxdfetap11hold_in(3 downto 0) => rxdfetap11hold_in(3 downto 0),
      rxdfetap11ovrden_in(3 downto 0) => rxdfetap11ovrden_in(3 downto 0),
      rxdfetap12hold_in(3 downto 0) => rxdfetap12hold_in(3 downto 0),
      rxdfetap12ovrden_in(3 downto 0) => rxdfetap12ovrden_in(3 downto 0),
      rxdfetap13hold_in(3 downto 0) => rxdfetap13hold_in(3 downto 0),
      rxdfetap13ovrden_in(3 downto 0) => rxdfetap13ovrden_in(3 downto 0),
      rxdfetap14hold_in(3 downto 0) => rxdfetap14hold_in(3 downto 0),
      rxdfetap14ovrden_in(3 downto 0) => rxdfetap14ovrden_in(3 downto 0),
      rxdfetap15hold_in(3 downto 0) => rxdfetap15hold_in(3 downto 0),
      rxdfetap15ovrden_in(3 downto 0) => rxdfetap15ovrden_in(3 downto 0),
      rxdfetap2hold_in(3 downto 0) => rxdfetap2hold_in(3 downto 0),
      rxdfetap2ovrden_in(3 downto 0) => rxdfetap2ovrden_in(3 downto 0),
      rxdfetap3hold_in(3 downto 0) => rxdfetap3hold_in(3 downto 0),
      rxdfetap3ovrden_in(3 downto 0) => rxdfetap3ovrden_in(3 downto 0),
      rxdfetap4hold_in(3 downto 0) => rxdfetap4hold_in(3 downto 0),
      rxdfetap4ovrden_in(3 downto 0) => rxdfetap4ovrden_in(3 downto 0),
      rxdfetap5hold_in(3 downto 0) => rxdfetap5hold_in(3 downto 0),
      rxdfetap5ovrden_in(3 downto 0) => rxdfetap5ovrden_in(3 downto 0),
      rxdfetap6hold_in(3 downto 0) => rxdfetap6hold_in(3 downto 0),
      rxdfetap6ovrden_in(3 downto 0) => rxdfetap6ovrden_in(3 downto 0),
      rxdfetap7hold_in(3 downto 0) => rxdfetap7hold_in(3 downto 0),
      rxdfetap7ovrden_in(3 downto 0) => rxdfetap7ovrden_in(3 downto 0),
      rxdfetap8hold_in(3 downto 0) => rxdfetap8hold_in(3 downto 0),
      rxdfetap8ovrden_in(3 downto 0) => rxdfetap8ovrden_in(3 downto 0),
      rxdfetap9hold_in(3 downto 0) => rxdfetap9hold_in(3 downto 0),
      rxdfetap9ovrden_in(3 downto 0) => rxdfetap9ovrden_in(3 downto 0),
      rxdfeuthold_in(3 downto 0) => rxdfeuthold_in(3 downto 0),
      rxdfeutovrden_in(3 downto 0) => rxdfeutovrden_in(3 downto 0),
      rxdfevphold_in(3 downto 0) => rxdfevphold_in(3 downto 0),
      rxdfevpovrden_in(3 downto 0) => rxdfevpovrden_in(3 downto 0),
      rxdfevsen_in(3 downto 0) => rxdfevsen_in(3 downto 0),
      rxdfexyden_in(3 downto 0) => rxdfexyden_in(3 downto 0),
      rxdlybypass_in(3 downto 0) => rxdlybypass_in(3 downto 0),
      rxdlyen_in(3 downto 0) => rxdlyen_in(3 downto 0),
      rxdlyovrden_in(3 downto 0) => rxdlyovrden_in(3 downto 0),
      rxdlysreset_in(3 downto 0) => rxdlysreset_in(3 downto 0),
      rxdlysresetdone_out(3 downto 0) => rxdlysresetdone_out(3 downto 0),
      rxelecidle_out(3 downto 0) => rxelecidle_out(3 downto 0),
      rxelecidlemode_in(7 downto 0) => rxelecidlemode_in(7 downto 0),
      rxgearboxslip_in(3 downto 0) => rxgearboxslip_in(3 downto 0),
      rxheader_out(23 downto 0) => rxheader_out(23 downto 0),
      rxheadervalid_out(7 downto 0) => rxheadervalid_out(7 downto 0),
      rxlatclk_in(3 downto 0) => rxlatclk_in(3 downto 0),
      rxlpmen_in(3 downto 0) => rxlpmen_in(3 downto 0),
      rxlpmgchold_in(3 downto 0) => rxlpmgchold_in(3 downto 0),
      rxlpmgcovrden_in(3 downto 0) => rxlpmgcovrden_in(3 downto 0),
      rxlpmhfhold_in(3 downto 0) => rxlpmhfhold_in(3 downto 0),
      rxlpmhfovrden_in(3 downto 0) => rxlpmhfovrden_in(3 downto 0),
      rxlpmlfhold_in(3 downto 0) => rxlpmlfhold_in(3 downto 0),
      rxlpmlfklovrden_in(3 downto 0) => rxlpmlfklovrden_in(3 downto 0),
      rxlpmoshold_in(3 downto 0) => rxlpmoshold_in(3 downto 0),
      rxlpmosovrden_in(3 downto 0) => rxlpmosovrden_in(3 downto 0),
      rxmcommaalignen_in(3 downto 0) => rxmcommaalignen_in(3 downto 0),
      rxmonitorout_out(27 downto 0) => rxmonitorout_out(27 downto 0),
      rxmonitorsel_in(7 downto 0) => rxmonitorsel_in(7 downto 0),
      rxoobreset_in(3 downto 0) => rxoobreset_in(3 downto 0),
      rxoscalreset_in(3 downto 0) => rxoscalreset_in(3 downto 0),
      rxoshold_in(3 downto 0) => rxoshold_in(3 downto 0),
      rxosintcfg_in(15 downto 0) => rxosintcfg_in(15 downto 0),
      rxosintdone_out(3 downto 0) => rxosintdone_out(3 downto 0),
      rxosinten_in(3 downto 0) => rxosinten_in(3 downto 0),
      rxosinthold_in(3 downto 0) => rxosinthold_in(3 downto 0),
      rxosintovrden_in(3 downto 0) => rxosintovrden_in(3 downto 0),
      rxosintstarted_out(3 downto 0) => rxosintstarted_out(3 downto 0),
      rxosintstrobe_in(3 downto 0) => rxosintstrobe_in(3 downto 0),
      rxosintstrobedone_out(3 downto 0) => rxosintstrobedone_out(3 downto 0),
      rxosintstrobestarted_out(3 downto 0) => rxosintstrobestarted_out(3 downto 0),
      rxosinttestovrden_in(3 downto 0) => rxosinttestovrden_in(3 downto 0),
      rxosovrden_in(3 downto 0) => rxosovrden_in(3 downto 0),
      rxoutclk_out(3 downto 0) => rxoutclk_out(3 downto 0),
      rxoutclkfabric_out(3 downto 0) => rxoutclkfabric_out(3 downto 0),
      rxoutclkpcs_out(3 downto 0) => rxoutclkpcs_out(3 downto 0),
      rxoutclksel_in(11 downto 0) => rxoutclksel_in(11 downto 0),
      rxpcommaalignen_in(3 downto 0) => rxpcommaalignen_in(3 downto 0),
      rxpcsreset_in(3 downto 0) => rxpcsreset_in(3 downto 0),
      rxpd_in(7 downto 0) => rxpd_in(7 downto 0),
      rxphalign_in(3 downto 0) => rxphalign_in(3 downto 0),
      rxphaligndone_out(3 downto 0) => rxphaligndone_out(3 downto 0),
      rxphalignen_in(3 downto 0) => rxphalignen_in(3 downto 0),
      rxphalignerr_out(3 downto 0) => rxphalignerr_out(3 downto 0),
      rxphdlypd_in(3 downto 0) => rxphdlypd_in(3 downto 0),
      rxphdlyreset_in(3 downto 0) => rxphdlyreset_in(3 downto 0),
      rxphovrden_in(3 downto 0) => rxphovrden_in(3 downto 0),
      rxpllclksel_in(7 downto 0) => rxpllclksel_in(7 downto 0),
      rxpmareset_in(3 downto 0) => rxpmareset_in(3 downto 0),
      rxpmaresetdone_out(3 downto 0) => rxpmaresetdone_out(3 downto 0),
      rxpolarity_in(3 downto 0) => rxpolarity_in(3 downto 0),
      rxprbscntreset_in(3 downto 0) => rxprbscntreset_in(3 downto 0),
      rxprbserr_out(3 downto 0) => rxprbserr_out(3 downto 0),
      rxprbslocked_out(3 downto 0) => rxprbslocked_out(3 downto 0),
      rxprbssel_in(15 downto 0) => rxprbssel_in(15 downto 0),
      rxprgdivresetdone_out(3 downto 0) => rxprgdivresetdone_out(3 downto 0),
      rxqpien_in(3 downto 0) => rxqpien_in(3 downto 0),
      rxqpisenn_out(3 downto 0) => rxqpisenn_out(3 downto 0),
      rxqpisenp_out(3 downto 0) => rxqpisenp_out(3 downto 0),
      rxrate_in(11 downto 0) => rxrate_in(11 downto 0),
      rxratedone_out(3 downto 0) => rxratedone_out(3 downto 0),
      rxratemode_in(3 downto 0) => rxratemode_in(3 downto 0),
      rxrecclkout_out(3 downto 0) => rxrecclkout_out(3 downto 0),
      rxresetdone_out(3 downto 0) => rxresetdone_out(3 downto 0),
      rxslide_in(3 downto 0) => rxslide_in(3 downto 0),
      rxsliderdy_out(3 downto 0) => rxsliderdy_out(3 downto 0),
      rxslipdone_out(3 downto 0) => rxslipdone_out(3 downto 0),
      rxslipoutclk_in(3 downto 0) => rxslipoutclk_in(3 downto 0),
      rxslipoutclkrdy_out(3 downto 0) => rxslipoutclkrdy_out(3 downto 0),
      rxslippma_in(3 downto 0) => rxslippma_in(3 downto 0),
      rxslippmardy_out(3 downto 0) => rxslippmardy_out(3 downto 0),
      rxstartofseq_out(7 downto 0) => rxstartofseq_out(7 downto 0),
      rxstatus_out(11 downto 0) => rxstatus_out(11 downto 0),
      rxsyncallin_in(3 downto 0) => rxsyncallin_in(3 downto 0),
      rxsyncdone_out(3 downto 0) => rxsyncdone_out(3 downto 0),
      rxsyncin_in(3 downto 0) => rxsyncin_in(3 downto 0),
      rxsyncmode_in(3 downto 0) => rxsyncmode_in(3 downto 0),
      rxsyncout_out(3 downto 0) => rxsyncout_out(3 downto 0),
      rxsysclksel_in(7 downto 0) => rxsysclksel_in(7 downto 0),
      rxusrclk2_in(3 downto 0) => rxusrclk2_in(3 downto 0),
      rxusrclk_in(3 downto 0) => rxusrclk_in(3 downto 0),
      rxvalid_out(3 downto 0) => rxvalid_out(3 downto 0),
      sigvalidclk_in(3 downto 0) => sigvalidclk_in(3 downto 0),
      tx8b10bbypass_in(31 downto 0) => tx8b10bbypass_in(31 downto 0),
      tx8b10ben_in(3 downto 0) => tx8b10ben_in(3 downto 0),
      txbufdiffctrl_in(11 downto 0) => txbufdiffctrl_in(11 downto 0),
      txbufstatus_out(7 downto 0) => txbufstatus_out(7 downto 0),
      txcomfinish_out(3 downto 0) => txcomfinish_out(3 downto 0),
      txcominit_in(3 downto 0) => txcominit_in(3 downto 0),
      txcomsas_in(3 downto 0) => txcomsas_in(3 downto 0),
      txcomwake_in(3 downto 0) => txcomwake_in(3 downto 0),
      txctrl0_in(63 downto 0) => txctrl0_in(63 downto 0),
      txctrl1_in(63 downto 0) => txctrl1_in(63 downto 0),
      txctrl2_in(31 downto 0) => txctrl2_in(31 downto 0),
      txdataextendrsvd_in(31 downto 0) => txdataextendrsvd_in(31 downto 0),
      txdeemph_in(3 downto 0) => txdeemph_in(3 downto 0),
      txdetectrx_in(3 downto 0) => txdetectrx_in(3 downto 0),
      txdiffctrl_in(15 downto 0) => txdiffctrl_in(15 downto 0),
      txdiffpd_in(3 downto 0) => txdiffpd_in(3 downto 0),
      txdlysresetdone_out(3 downto 0) => txdlysresetdone_out(3 downto 0),
      txelecidle_in(3 downto 0) => txelecidle_in(3 downto 0),
      txheader_in(23 downto 0) => txheader_in(23 downto 0),
      txinhibit_in(3 downto 0) => txinhibit_in(3 downto 0),
      txlatclk_in(3 downto 0) => txlatclk_in(3 downto 0),
      txmaincursor_in(27 downto 0) => txmaincursor_in(27 downto 0),
      txmargin_in(11 downto 0) => txmargin_in(11 downto 0),
      txoutclk_out(3 downto 0) => txoutclk_out(3 downto 0),
      txoutclkfabric_out(3 downto 0) => txoutclkfabric_out(3 downto 0),
      txoutclkpcs_out(3 downto 0) => txoutclkpcs_out(3 downto 0),
      txoutclksel_in(11 downto 0) => txoutclksel_in(11 downto 0),
      txpcsreset_in(3 downto 0) => txpcsreset_in(3 downto 0),
      txpd_in(7 downto 0) => txpd_in(7 downto 0),
      txpdelecidlemode_in(3 downto 0) => txpdelecidlemode_in(3 downto 0),
      txphaligndone_out(3 downto 0) => txphaligndone_out(3 downto 0),
      txphinitdone_out(3 downto 0) => txphinitdone_out(3 downto 0),
      txpippmen_in(3 downto 0) => txpippmen_in(3 downto 0),
      txpippmovrden_in(3 downto 0) => txpippmovrden_in(3 downto 0),
      txpippmpd_in(3 downto 0) => txpippmpd_in(3 downto 0),
      txpippmsel_in(3 downto 0) => txpippmsel_in(3 downto 0),
      txpippmstepsize_in(19 downto 0) => txpippmstepsize_in(19 downto 0),
      txpisopd_in(3 downto 0) => txpisopd_in(3 downto 0),
      txpllclksel_in(7 downto 0) => txpllclksel_in(7 downto 0),
      txpmareset_in(3 downto 0) => txpmareset_in(3 downto 0),
      txpmaresetdone_out(3 downto 0) => txpmaresetdone_out(3 downto 0),
      txpolarity_in(3 downto 0) => txpolarity_in(3 downto 0),
      txpostcursor_in(19 downto 0) => txpostcursor_in(19 downto 0),
      txpostcursorinv_in(3 downto 0) => txpostcursorinv_in(3 downto 0),
      txprbsforceerr_in(3 downto 0) => txprbsforceerr_in(3 downto 0),
      txprbssel_in(15 downto 0) => txprbssel_in(15 downto 0),
      txprecursor_in(19 downto 0) => txprecursor_in(19 downto 0),
      txprecursorinv_in(3 downto 0) => txprecursorinv_in(3 downto 0),
      txprgdivresetdone_out(3 downto 0) => txprgdivresetdone_out(3 downto 0),
      txqpibiasen_in(3 downto 0) => txqpibiasen_in(3 downto 0),
      txqpisenn_out(3 downto 0) => txqpisenn_out(3 downto 0),
      txqpisenp_out(3 downto 0) => txqpisenp_out(3 downto 0),
      txqpistrongpdown_in(3 downto 0) => txqpistrongpdown_in(3 downto 0),
      txqpiweakpup_in(3 downto 0) => txqpiweakpup_in(3 downto 0),
      txrate_in(11 downto 0) => txrate_in(11 downto 0),
      txratedone_out(3 downto 0) => txratedone_out(3 downto 0),
      txratemode_in(3 downto 0) => txratemode_in(3 downto 0),
      txresetdone_out(3 downto 0) => txresetdone_out(3 downto 0),
      txsequence_in(27 downto 0) => txsequence_in(27 downto 0),
      txswing_in(3 downto 0) => txswing_in(3 downto 0),
      txsyncdone_out(3 downto 0) => txsyncdone_out(3 downto 0),
      txsyncout_out(3 downto 0) => txsyncout_out(3 downto 0),
      txsysclksel_in(7 downto 0) => txsysclksel_in(7 downto 0),
      txusrclk2_in(3 downto 0) => txusrclk2_in(3 downto 0),
      txusrclk_in(3 downto 0) => txusrclk_in(3 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gtwiz_buffbypass_tx is
  port (
    gtwiz_buffbypass_tx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_tx_error_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    GTHE3_CHANNEL_TXDLYSRESET : out STD_LOGIC_VECTOR ( 0 to 0 );
    GTHE3_CHANNEL_TXSYNCALLIN : out STD_LOGIC_VECTOR ( 0 to 0 );
    txsyncdone_out : in STD_LOGIC_VECTOR ( 0 to 0 );
    txphaligndone_out : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtwiz_buffbypass_tx_start_user_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    txusrclk2_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rst_in_out_reg : in STD_LOGIC;
    gtwiz_buffbypass_tx_reset_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gtwiz_buffbypass_tx : entity is "gtwizard_ultrascale_v1_6_5_gtwiz_buffbypass_tx";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gtwiz_buffbypass_tx;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gtwiz_buffbypass_tx is
  signal \FSM_sequential_gen_gtwiz_buffbypass_tx_main.gen_auto_mode.sm_buffbypass_tx[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_gen_gtwiz_buffbypass_tx_main.gen_auto_mode.sm_buffbypass_tx[1]_i_1_n_0\ : STD_LOGIC;
  signal \^gthe3_channel_txdlysreset\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.bit_synchronizer_master_phaligndone_inst_n_0\ : STD_LOGIC;
  signal \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.reset_synchronizer_resetdone_inst_n_1\ : STD_LOGIC;
  signal \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.reset_synchronizer_resetdone_inst_n_2\ : STD_LOGIC;
  signal \gthe3_channel_gen.gen_gthe3_channel_inst[3].GTHE3_CHANNEL_PRIM_INST_i_3_n_0\ : STD_LOGIC;
  signal gtwiz_buffbypass_tx_master_syncdone_sync_int : STD_LOGIC;
  signal gtwiz_buffbypass_tx_master_syncdone_sync_reg : STD_LOGIC;
  signal gtwiz_buffbypass_tx_resetdone_reg : STD_LOGIC;
  signal gtwiz_buffbypass_tx_resetdone_sync_int : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal \sm_buffbypass_tx__0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of \sm_buffbypass_tx__0\ : signal is "yes";
  signal sm_buffbypass_tx_n_0 : STD_LOGIC;
  attribute KEEP : string;
  attribute KEEP of \FSM_sequential_gen_gtwiz_buffbypass_tx_main.gen_auto_mode.sm_buffbypass_tx_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_gen_gtwiz_buffbypass_tx_main.gen_auto_mode.sm_buffbypass_tx_reg[1]\ : label is "yes";
begin
  GTHE3_CHANNEL_TXDLYSRESET(0) <= \^gthe3_channel_txdlysreset\(0);
\FSM_sequential_gen_gtwiz_buffbypass_tx_main.gen_auto_mode.sm_buffbypass_tx[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0455"
    )
        port map (
      I0 => \sm_buffbypass_tx__0\(0),
      I1 => gtwiz_buffbypass_tx_master_syncdone_sync_int,
      I2 => gtwiz_buffbypass_tx_master_syncdone_sync_reg,
      I3 => \sm_buffbypass_tx__0\(1),
      O => \FSM_sequential_gen_gtwiz_buffbypass_tx_main.gen_auto_mode.sm_buffbypass_tx[0]_i_1_n_0\
    );
\FSM_sequential_gen_gtwiz_buffbypass_tx_main.gen_auto_mode.sm_buffbypass_tx[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"10AA"
    )
        port map (
      I0 => \sm_buffbypass_tx__0\(0),
      I1 => gtwiz_buffbypass_tx_master_syncdone_sync_reg,
      I2 => gtwiz_buffbypass_tx_master_syncdone_sync_int,
      I3 => \sm_buffbypass_tx__0\(1),
      O => \FSM_sequential_gen_gtwiz_buffbypass_tx_main.gen_auto_mode.sm_buffbypass_tx[1]_i_1_n_0\
    );
\FSM_sequential_gen_gtwiz_buffbypass_tx_main.gen_auto_mode.sm_buffbypass_tx_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => txusrclk2_in(0),
      CE => sm_buffbypass_tx_n_0,
      D => \FSM_sequential_gen_gtwiz_buffbypass_tx_main.gen_auto_mode.sm_buffbypass_tx[0]_i_1_n_0\,
      Q => \sm_buffbypass_tx__0\(0),
      R => gtwiz_buffbypass_tx_reset_in(0)
    );
\FSM_sequential_gen_gtwiz_buffbypass_tx_main.gen_auto_mode.sm_buffbypass_tx_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => txusrclk2_in(0),
      CE => sm_buffbypass_tx_n_0,
      D => \FSM_sequential_gen_gtwiz_buffbypass_tx_main.gen_auto_mode.sm_buffbypass_tx[1]_i_1_n_0\,
      Q => \sm_buffbypass_tx__0\(1),
      R => gtwiz_buffbypass_tx_reset_in(0)
    );
\gen_gtwiz_buffbypass_tx_main.gen_auto_mode.bit_synchronizer_master_phaligndone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_13
     port map (
      \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.gtwiz_buffbypass_tx_error_out_reg\ => \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.bit_synchronizer_master_phaligndone_inst_n_0\,
      out0 => \sm_buffbypass_tx__0\(1),
      txphaligndone_out(0) => txphaligndone_out(6),
      txusrclk2_in(0) => txusrclk2_in(0)
    );
\gen_gtwiz_buffbypass_tx_main.gen_auto_mode.bit_synchronizer_master_syncdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_14
     port map (
      gtwiz_buffbypass_tx_master_syncdone_sync_int => gtwiz_buffbypass_tx_master_syncdone_sync_int,
      txsyncdone_out(0) => txsyncdone_out(0),
      txusrclk2_in(0) => txusrclk2_in(0)
    );
\gen_gtwiz_buffbypass_tx_main.gen_auto_mode.gtwiz_buffbypass_tx_done_out_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.reset_synchronizer_resetdone_inst_n_2\,
      D => \sm_buffbypass_tx__0\(1),
      Q => gtwiz_buffbypass_tx_done_out(0),
      R => gtwiz_buffbypass_tx_reset_in(0)
    );
\gen_gtwiz_buffbypass_tx_main.gen_auto_mode.gtwiz_buffbypass_tx_error_out_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.reset_synchronizer_resetdone_inst_n_2\,
      D => \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.bit_synchronizer_master_phaligndone_inst_n_0\,
      Q => gtwiz_buffbypass_tx_error_out(0),
      R => gtwiz_buffbypass_tx_reset_in(0)
    );
\gen_gtwiz_buffbypass_tx_main.gen_auto_mode.gtwiz_buffbypass_tx_master_syncdone_sync_reg_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      D => gtwiz_buffbypass_tx_master_syncdone_sync_int,
      Q => gtwiz_buffbypass_tx_master_syncdone_sync_reg,
      R => '0'
    );
\gen_gtwiz_buffbypass_tx_main.gen_auto_mode.gtwiz_buffbypass_tx_resetdone_reg_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      D => gtwiz_buffbypass_tx_resetdone_sync_int,
      Q => gtwiz_buffbypass_tx_resetdone_reg,
      R => gtwiz_buffbypass_tx_reset_in(0)
    );
\gen_gtwiz_buffbypass_tx_main.gen_auto_mode.reset_synchronizer_resetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer
     port map (
      GTHE3_CHANNEL_TXDLYSRESET(0) => \^gthe3_channel_txdlysreset\(0),
      \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.gtwiz_buffbypass_tx_error_out_reg\ => \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.reset_synchronizer_resetdone_inst_n_2\,
      \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.txdlysreset_out_reg[6]\ => \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.reset_synchronizer_resetdone_inst_n_1\,
      gtwiz_buffbypass_tx_resetdone_reg => gtwiz_buffbypass_tx_resetdone_reg,
      gtwiz_buffbypass_tx_resetdone_sync_int => gtwiz_buffbypass_tx_resetdone_sync_int,
      gtwiz_buffbypass_tx_start_user_in(0) => gtwiz_buffbypass_tx_start_user_in(0),
      \out\(1 downto 0) => \sm_buffbypass_tx__0\(1 downto 0),
      rst_in_out_reg_0 => rst_in_out_reg,
      txusrclk2_in(0) => txusrclk2_in(0)
    );
\gen_gtwiz_buffbypass_tx_main.gen_auto_mode.txdlysreset_out_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => txusrclk2_in(0),
      CE => '1',
      D => \gen_gtwiz_buffbypass_tx_main.gen_auto_mode.reset_synchronizer_resetdone_inst_n_1\,
      Q => \^gthe3_channel_txdlysreset\(0),
      R => gtwiz_buffbypass_tx_reset_in(0)
    );
\gthe3_channel_gen.gen_gthe3_channel_inst[3].GTHE3_CHANNEL_PRIM_INST_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => txphaligndone_out(4),
      I1 => txphaligndone_out(6),
      I2 => txphaligndone_out(5),
      I3 => \gthe3_channel_gen.gen_gthe3_channel_inst[3].GTHE3_CHANNEL_PRIM_INST_i_3_n_0\,
      O => GTHE3_CHANNEL_TXSYNCALLIN(0)
    );
\gthe3_channel_gen.gen_gthe3_channel_inst[3].GTHE3_CHANNEL_PRIM_INST_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => txphaligndone_out(1),
      I1 => txphaligndone_out(0),
      I2 => txphaligndone_out(3),
      I3 => txphaligndone_out(2),
      O => \gthe3_channel_gen.gen_gthe3_channel_inst[3].GTHE3_CHANNEL_PRIM_INST_i_3_n_0\
    );
gtwiz_buffbypass_tx_start_int: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AE"
    )
        port map (
      I0 => gtwiz_buffbypass_tx_start_user_in(0),
      I1 => gtwiz_buffbypass_tx_resetdone_sync_int,
      I2 => gtwiz_buffbypass_tx_resetdone_reg,
      O => p_0_in
    );
sm_buffbypass_tx: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEFEAEAE"
    )
        port map (
      I0 => \sm_buffbypass_tx__0\(0),
      I1 => p_0_in,
      I2 => \sm_buffbypass_tx__0\(1),
      I3 => gtwiz_buffbypass_tx_master_syncdone_sync_reg,
      I4 => gtwiz_buffbypass_tx_master_syncdone_sync_int,
      O => sm_buffbypass_tx_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gtwiz_reset is
  port (
    gtwiz_reset_tx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    GTHE3_CHANNEL_TXPROGDIVRESET : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_cdr_stable_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    GTHE3_CHANNEL_GTTXRESET : out STD_LOGIC_VECTOR ( 0 to 0 );
    GTHE3_CHANNEL_TXUSERRDY : out STD_LOGIC_VECTOR ( 0 to 0 );
    GTHE3_CHANNEL_RXPROGDIVRESET : out STD_LOGIC_VECTOR ( 0 to 0 );
    GTHE3_CHANNEL_GTRXRESET : out STD_LOGIC_VECTOR ( 0 to 0 );
    GTHE3_CHANNEL_RXUSERRDY : out STD_LOGIC_VECTOR ( 0 to 0 );
    GTHE3_CHANNEL_CPLLPD : out STD_LOGIC_VECTOR ( 0 to 0 );
    rst_in_sync2_reg : out STD_LOGIC;
    in0 : in STD_LOGIC;
    gtwiz_userclk_tx_active_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtrxreset_out_reg_0 : in STD_LOGIC;
    gtwiz_userclk_rx_active_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtrxreset_out_reg_1 : in STD_LOGIC;
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    txusrclk2_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_all_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rst_in0 : in STD_LOGIC;
    rxusrclk2_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_in_out_reg : in STD_LOGIC;
    txresetdone_sync : in STD_LOGIC_VECTOR ( 2 downto 0 );
    i_in_out_reg_0 : in STD_LOGIC;
    rxresetdone_sync : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gtwiz_reset_tx_pll_and_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_pll_and_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_in_out_reg_1 : in STD_LOGIC;
    i_in_out_reg_2 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gtwiz_reset : entity is "gtwizard_ultrascale_v1_6_5_gtwiz_reset";
end JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gtwiz_reset;

architecture STRUCTURE of JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gtwiz_reset is
  signal \FSM_sequential_sm_reset_all[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_sm_reset_all[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_sm_reset_all[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_sm_reset_all[2]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_sm_reset_all[2]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_sm_reset_rx[2]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_sm_reset_rx[2]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_sequential_sm_reset_rx[2]_i_8_n_0\ : STD_LOGIC;
  signal \FSM_sequential_sm_reset_tx[2]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_sm_reset_tx[2]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_sequential_sm_reset_tx[2]_i_6_n_0\ : STD_LOGIC;
  signal \^gthe3_channel_gtrxreset\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^gthe3_channel_gttxreset\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^gthe3_channel_rxprogdivreset\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^gthe3_channel_rxuserrdy\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^gthe3_channel_txuserrdy\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal bit_synchronizer_gtwiz_reset_rx_pll_and_datapath_dly_inst_n_1 : STD_LOGIC;
  signal bit_synchronizer_gtwiz_reset_rx_pll_and_datapath_dly_inst_n_2 : STD_LOGIC;
  signal bit_synchronizer_gtwiz_reset_tx_pll_and_datapath_dly_inst_n_1 : STD_LOGIC;
  signal bit_synchronizer_gtwiz_reset_tx_pll_and_datapath_dly_inst_n_2 : STD_LOGIC;
  signal bit_synchronizer_gtwiz_reset_userclk_rx_active_inst_n_1 : STD_LOGIC;
  signal bit_synchronizer_gtwiz_reset_userclk_rx_active_inst_n_2 : STD_LOGIC;
  signal bit_synchronizer_gtwiz_reset_userclk_tx_active_inst_n_0 : STD_LOGIC;
  signal bit_synchronizer_gtwiz_reset_userclk_tx_active_inst_n_1 : STD_LOGIC;
  signal bit_synchronizer_gtwiz_reset_userclk_tx_active_inst_n_2 : STD_LOGIC;
  signal bit_synchronizer_plllock_rx_inst_n_1 : STD_LOGIC;
  signal bit_synchronizer_plllock_rx_inst_n_2 : STD_LOGIC;
  signal bit_synchronizer_plllock_rx_inst_n_3 : STD_LOGIC;
  signal bit_synchronizer_plllock_rx_inst_n_4 : STD_LOGIC;
  signal bit_synchronizer_plllock_tx_inst_n_0 : STD_LOGIC;
  signal bit_synchronizer_plllock_tx_inst_n_1 : STD_LOGIC;
  signal bit_synchronizer_plllock_tx_inst_n_2 : STD_LOGIC;
  signal bit_synchronizer_plllock_tx_inst_n_3 : STD_LOGIC;
  signal bit_synchronizer_rxcdrlock_inst_n_1 : STD_LOGIC;
  signal bit_synchronizer_rxcdrlock_inst_n_2 : STD_LOGIC;
  signal bit_synchronizer_rxcdrlock_inst_n_3 : STD_LOGIC;
  signal gtpowergood_sync : STD_LOGIC;
  signal gtwiz_reset_all_sync : STD_LOGIC;
  signal gtwiz_reset_pllreset_rx_int : STD_LOGIC;
  signal gtwiz_reset_pllreset_tx_int : STD_LOGIC;
  signal gtwiz_reset_rx_any_sync : STD_LOGIC;
  signal gtwiz_reset_rx_datapath_dly : STD_LOGIC;
  signal gtwiz_reset_rx_datapath_int_i_1_n_0 : STD_LOGIC;
  signal gtwiz_reset_rx_datapath_int_reg_n_0 : STD_LOGIC;
  signal gtwiz_reset_rx_datapath_sync : STD_LOGIC;
  signal gtwiz_reset_rx_done_int_reg_n_0 : STD_LOGIC;
  signal gtwiz_reset_rx_pll_and_datapath_dly : STD_LOGIC;
  signal gtwiz_reset_rx_pll_and_datapath_int_i_1_n_0 : STD_LOGIC;
  signal gtwiz_reset_rx_pll_and_datapath_int_reg_n_0 : STD_LOGIC;
  signal gtwiz_reset_rx_pll_and_datapath_sync : STD_LOGIC;
  signal gtwiz_reset_tx_any_sync : STD_LOGIC;
  signal gtwiz_reset_tx_datapath_dly : STD_LOGIC;
  signal gtwiz_reset_tx_datapath_sync : STD_LOGIC;
  signal gtwiz_reset_tx_done_int0 : STD_LOGIC;
  signal gtwiz_reset_tx_done_int_reg_n_0 : STD_LOGIC;
  signal gtwiz_reset_tx_pll_and_datapath_dly : STD_LOGIC;
  signal gtwiz_reset_tx_pll_and_datapath_int_i_1_n_0 : STD_LOGIC;
  signal gtwiz_reset_tx_pll_and_datapath_int_reg_n_0 : STD_LOGIC;
  signal gtwiz_reset_tx_pll_and_datapath_sync : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal p_0_in11_out : STD_LOGIC;
  signal \p_0_in__0\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \p_0_in__1\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal p_1_in : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal reset_synchronizer_gtwiz_reset_rx_any_inst_n_1 : STD_LOGIC;
  signal reset_synchronizer_gtwiz_reset_tx_any_inst_n_1 : STD_LOGIC;
  signal sel : STD_LOGIC;
  signal sm_reset_all : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of sm_reset_all : signal is "yes";
  signal sm_reset_all_timer_clr_i_1_n_0 : STD_LOGIC;
  signal sm_reset_all_timer_clr_i_2_n_0 : STD_LOGIC;
  signal sm_reset_all_timer_clr_reg_n_0 : STD_LOGIC;
  signal sm_reset_all_timer_ctr : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \sm_reset_all_timer_ctr0_inferred__0/i__n_0\ : STD_LOGIC;
  signal \sm_reset_all_timer_ctr[0]_i_1_n_0\ : STD_LOGIC;
  signal \sm_reset_all_timer_ctr[1]_i_1_n_0\ : STD_LOGIC;
  signal \sm_reset_all_timer_ctr[2]_i_1_n_0\ : STD_LOGIC;
  signal sm_reset_all_timer_sat : STD_LOGIC;
  signal sm_reset_all_timer_sat_i_1_n_0 : STD_LOGIC;
  signal sm_reset_rx : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute RTL_KEEP of sm_reset_rx : signal is "yes";
  signal sm_reset_rx_cdr_to_clr : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_10_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_11_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_12_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_13_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_14_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_15_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_16_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_3_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_4_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_5_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_6_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_7_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_8_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[0]_i_9_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[16]_i_2_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[16]_i_3_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[16]_i_4_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[16]_i_5_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[16]_i_6_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[16]_i_7_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[16]_i_8_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[16]_i_9_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[24]_i_2_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[24]_i_3_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[8]_i_2_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[8]_i_3_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[8]_i_4_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[8]_i_5_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[8]_i_6_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[8]_i_7_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[8]_i_8_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr[8]_i_9_n_0\ : STD_LOGIC;
  signal sm_reset_rx_cdr_to_ctr_reg : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_1\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_10\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_11\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_12\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_13\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_14\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_15\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_2\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_3\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_8\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_9\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_10\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_11\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_12\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_13\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_14\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_15\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_8\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_9\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[24]_i_1_n_14\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[24]_i_1_n_15\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_10\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_11\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_12\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_13\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_14\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_15\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_8\ : STD_LOGIC;
  signal \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_9\ : STD_LOGIC;
  signal sm_reset_rx_cdr_to_sat : STD_LOGIC;
  signal sm_reset_rx_cdr_to_sat_i_1_n_0 : STD_LOGIC;
  signal sm_reset_rx_pll_timer_clr_i_1_n_0 : STD_LOGIC;
  signal sm_reset_rx_pll_timer_clr_reg_n_0 : STD_LOGIC;
  signal \sm_reset_rx_pll_timer_ctr[9]_i_1_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_pll_timer_ctr[9]_i_3_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_pll_timer_ctr[9]_i_4_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_pll_timer_ctr_reg__0\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal sm_reset_rx_pll_timer_sat : STD_LOGIC;
  signal sm_reset_rx_pll_timer_sat_i_1_n_0 : STD_LOGIC;
  signal sm_reset_rx_timer_clr0 : STD_LOGIC;
  signal sm_reset_rx_timer_clr09_out : STD_LOGIC;
  signal sm_reset_rx_timer_clr_reg_n_0 : STD_LOGIC;
  signal sm_reset_rx_timer_ctr : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \sm_reset_rx_timer_ctr0_inferred__0/i__n_0\ : STD_LOGIC;
  signal \sm_reset_rx_timer_ctr[0]_i_1_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_timer_ctr[1]_i_1_n_0\ : STD_LOGIC;
  signal \sm_reset_rx_timer_ctr[2]_i_1_n_0\ : STD_LOGIC;
  signal sm_reset_rx_timer_sat : STD_LOGIC;
  signal sm_reset_rx_timer_sat_i_1_n_0 : STD_LOGIC;
  signal sm_reset_tx : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute RTL_KEEP of sm_reset_tx : signal is "yes";
  signal sm_reset_tx_pll_timer_clr_i_1_n_0 : STD_LOGIC;
  signal sm_reset_tx_pll_timer_clr_reg_n_0 : STD_LOGIC;
  signal \sm_reset_tx_pll_timer_ctr[9]_i_3_n_0\ : STD_LOGIC;
  signal \sm_reset_tx_pll_timer_ctr[9]_i_4_n_0\ : STD_LOGIC;
  signal \sm_reset_tx_pll_timer_ctr_reg__0\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal sm_reset_tx_pll_timer_sat : STD_LOGIC;
  signal sm_reset_tx_pll_timer_sat_i_1_n_0 : STD_LOGIC;
  signal sm_reset_tx_timer_clr_reg_n_0 : STD_LOGIC;
  signal sm_reset_tx_timer_ctr : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal sm_reset_tx_timer_sat : STD_LOGIC;
  signal sm_reset_tx_timer_sat_i_1_n_0 : STD_LOGIC;
  signal \NLW_sm_reset_rx_cdr_to_ctr_reg[0]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_sm_reset_rx_cdr_to_ctr_reg[16]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_sm_reset_rx_cdr_to_ctr_reg[24]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal \NLW_sm_reset_rx_cdr_to_ctr_reg[24]_i_1_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_sm_reset_rx_cdr_to_ctr_reg[24]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_sm_reset_rx_cdr_to_ctr_reg[24]_i_1_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_sm_reset_rx_cdr_to_ctr_reg[8]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute KEEP : string;
  attribute KEEP of \FSM_sequential_sm_reset_all_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_sm_reset_all_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_sequential_sm_reset_all_reg[2]\ : label is "yes";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_sm_reset_rx[2]_i_8\ : label is "soft_lutpair8";
  attribute KEEP of \FSM_sequential_sm_reset_rx_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_sm_reset_rx_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_sequential_sm_reset_rx_reg[2]\ : label is "yes";
  attribute SOFT_HLUTNM of \FSM_sequential_sm_reset_tx[2]_i_6\ : label is "soft_lutpair10";
  attribute KEEP of \FSM_sequential_sm_reset_tx_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_sm_reset_tx_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_sequential_sm_reset_tx_reg[2]\ : label is "yes";
  attribute SOFT_HLUTNM of \sm_reset_all_timer_ctr[1]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \sm_reset_all_timer_ctr[2]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \sm_reset_rx_pll_timer_ctr[1]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \sm_reset_rx_pll_timer_ctr[2]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \sm_reset_rx_pll_timer_ctr[3]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \sm_reset_rx_pll_timer_ctr[4]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \sm_reset_rx_pll_timer_ctr[6]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \sm_reset_rx_pll_timer_ctr[7]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \sm_reset_rx_pll_timer_ctr[8]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \sm_reset_rx_pll_timer_ctr[9]_i_2\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \sm_reset_rx_timer_ctr[1]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \sm_reset_rx_timer_ctr[2]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of sm_reset_rx_timer_sat_i_1 : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \sm_reset_tx_pll_timer_ctr[1]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \sm_reset_tx_pll_timer_ctr[2]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \sm_reset_tx_pll_timer_ctr[3]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \sm_reset_tx_pll_timer_ctr[4]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \sm_reset_tx_pll_timer_ctr[6]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \sm_reset_tx_pll_timer_ctr[7]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \sm_reset_tx_pll_timer_ctr[8]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \sm_reset_tx_pll_timer_ctr[9]_i_2\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \sm_reset_tx_timer_ctr[1]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \sm_reset_tx_timer_ctr[2]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of sm_reset_tx_timer_sat_i_1 : label is "soft_lutpair10";
begin
  GTHE3_CHANNEL_GTRXRESET(0) <= \^gthe3_channel_gtrxreset\(0);
  GTHE3_CHANNEL_GTTXRESET(0) <= \^gthe3_channel_gttxreset\(0);
  GTHE3_CHANNEL_RXPROGDIVRESET(0) <= \^gthe3_channel_rxprogdivreset\(0);
  GTHE3_CHANNEL_RXUSERRDY(0) <= \^gthe3_channel_rxuserrdy\(0);
  GTHE3_CHANNEL_TXUSERRDY(0) <= \^gthe3_channel_txuserrdy\(0);
\FSM_sequential_sm_reset_all[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"77777777DDDD5DDD"
    )
        port map (
      I0 => sm_reset_all(0),
      I1 => sm_reset_all(2),
      I2 => gtwiz_reset_rx_done_int_reg_n_0,
      I3 => sm_reset_all_timer_sat,
      I4 => sm_reset_all_timer_clr_reg_n_0,
      I5 => sm_reset_all(1),
      O => \FSM_sequential_sm_reset_all[0]_i_1_n_0\
    );
\FSM_sequential_sm_reset_all[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => sm_reset_all(0),
      I1 => sm_reset_all(1),
      O => \FSM_sequential_sm_reset_all[1]_i_1_n_0\
    );
\FSM_sequential_sm_reset_all[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF0000AAEA"
    )
        port map (
      I0 => sm_reset_all(0),
      I1 => gtwiz_reset_tx_done_int_reg_n_0,
      I2 => sm_reset_all_timer_sat,
      I3 => sm_reset_all_timer_clr_reg_n_0,
      I4 => sm_reset_all(2),
      I5 => \FSM_sequential_sm_reset_all[2]_i_3_n_0\,
      O => \FSM_sequential_sm_reset_all[2]_i_1_n_0\
    );
\FSM_sequential_sm_reset_all[2]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"2C"
    )
        port map (
      I0 => sm_reset_all(0),
      I1 => sm_reset_all(2),
      I2 => sm_reset_all(1),
      O => \FSM_sequential_sm_reset_all[2]_i_2_n_0\
    );
\FSM_sequential_sm_reset_all[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888B88833333333"
    )
        port map (
      I0 => gtpowergood_sync,
      I1 => sm_reset_all(1),
      I2 => gtwiz_reset_rx_done_int_reg_n_0,
      I3 => sm_reset_all_timer_sat,
      I4 => sm_reset_all_timer_clr_reg_n_0,
      I5 => sm_reset_all(0),
      O => \FSM_sequential_sm_reset_all[2]_i_3_n_0\
    );
\FSM_sequential_sm_reset_all_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \FSM_sequential_sm_reset_all[2]_i_1_n_0\,
      D => \FSM_sequential_sm_reset_all[0]_i_1_n_0\,
      Q => sm_reset_all(0),
      R => gtwiz_reset_all_sync
    );
\FSM_sequential_sm_reset_all_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \FSM_sequential_sm_reset_all[2]_i_1_n_0\,
      D => \FSM_sequential_sm_reset_all[1]_i_1_n_0\,
      Q => sm_reset_all(1),
      R => gtwiz_reset_all_sync
    );
\FSM_sequential_sm_reset_all_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \FSM_sequential_sm_reset_all[2]_i_1_n_0\,
      D => \FSM_sequential_sm_reset_all[2]_i_2_n_0\,
      Q => sm_reset_all(2),
      R => gtwiz_reset_all_sync
    );
\FSM_sequential_sm_reset_rx[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"ECAA"
    )
        port map (
      I0 => sm_reset_rx(2),
      I1 => sm_reset_rx(0),
      I2 => p_0_in11_out,
      I3 => sm_reset_rx(1),
      O => \FSM_sequential_sm_reset_rx[2]_i_2_n_0\
    );
\FSM_sequential_sm_reset_rx[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4000FFFF00000000"
    )
        port map (
      I0 => i_in_out_reg_0,
      I1 => rxresetdone_sync(1),
      I2 => rxresetdone_sync(2),
      I3 => rxresetdone_sync(0),
      I4 => sm_reset_rx(2),
      I5 => \FSM_sequential_sm_reset_rx[2]_i_8_n_0\,
      O => \FSM_sequential_sm_reset_rx[2]_i_4_n_0\
    );
\FSM_sequential_sm_reset_rx[2]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0400000000000000"
    )
        port map (
      I0 => sm_reset_rx_timer_clr_reg_n_0,
      I1 => sm_reset_rx_timer_sat,
      I2 => i_in_out_reg_0,
      I3 => rxresetdone_sync(1),
      I4 => rxresetdone_sync(2),
      I5 => rxresetdone_sync(0),
      O => p_0_in11_out
    );
\FSM_sequential_sm_reset_rx[2]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_timer_sat,
      I1 => sm_reset_rx_timer_clr_reg_n_0,
      O => \FSM_sequential_sm_reset_rx[2]_i_8_n_0\
    );
\FSM_sequential_sm_reset_rx_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => bit_synchronizer_plllock_rx_inst_n_3,
      D => bit_synchronizer_gtwiz_reset_rx_pll_and_datapath_dly_inst_n_2,
      Q => sm_reset_rx(0),
      R => gtwiz_reset_rx_any_sync
    );
\FSM_sequential_sm_reset_rx_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => bit_synchronizer_plllock_rx_inst_n_3,
      D => bit_synchronizer_gtwiz_reset_rx_pll_and_datapath_dly_inst_n_1,
      Q => sm_reset_rx(1),
      R => gtwiz_reset_rx_any_sync
    );
\FSM_sequential_sm_reset_rx_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => bit_synchronizer_plllock_rx_inst_n_3,
      D => \FSM_sequential_sm_reset_rx[2]_i_2_n_0\,
      Q => sm_reset_rx(2),
      R => gtwiz_reset_rx_any_sync
    );
\FSM_sequential_sm_reset_tx[2]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"38"
    )
        port map (
      I0 => sm_reset_tx(0),
      I1 => sm_reset_tx(1),
      I2 => sm_reset_tx(2),
      O => \FSM_sequential_sm_reset_tx[2]_i_2_n_0\
    );
\FSM_sequential_sm_reset_tx[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2000200020FF2000"
    )
        port map (
      I0 => \FSM_sequential_sm_reset_tx[2]_i_6_n_0\,
      I1 => i_in_out_reg,
      I2 => i_in_out_reg_1,
      I3 => sm_reset_tx(2),
      I4 => sm_reset_tx_pll_timer_sat,
      I5 => sm_reset_tx_pll_timer_clr_reg_n_0,
      O => \FSM_sequential_sm_reset_tx[2]_i_4_n_0\
    );
\FSM_sequential_sm_reset_tx[2]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_tx_timer_sat,
      I1 => sm_reset_tx_timer_clr_reg_n_0,
      O => \FSM_sequential_sm_reset_tx[2]_i_6_n_0\
    );
\FSM_sequential_sm_reset_tx_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => bit_synchronizer_plllock_tx_inst_n_2,
      D => bit_synchronizer_gtwiz_reset_tx_pll_and_datapath_dly_inst_n_2,
      Q => sm_reset_tx(0),
      R => gtwiz_reset_tx_any_sync
    );
\FSM_sequential_sm_reset_tx_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => bit_synchronizer_plllock_tx_inst_n_2,
      D => bit_synchronizer_gtwiz_reset_tx_pll_and_datapath_dly_inst_n_1,
      Q => sm_reset_tx(1),
      R => gtwiz_reset_tx_any_sync
    );
\FSM_sequential_sm_reset_tx_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => bit_synchronizer_plllock_tx_inst_n_2,
      D => \FSM_sequential_sm_reset_tx[2]_i_2_n_0\,
      Q => sm_reset_tx(2),
      R => gtwiz_reset_tx_any_sync
    );
bit_synchronizer_gtpowergood_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_15
     port map (
      gtpowergood_sync => gtpowergood_sync,
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      in0 => in0
    );
bit_synchronizer_gtwiz_reset_rx_datapath_dly_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_16
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_rx_datapath_dly => gtwiz_reset_rx_datapath_dly,
      in0 => gtwiz_reset_rx_datapath_sync
    );
bit_synchronizer_gtwiz_reset_rx_pll_and_datapath_dly_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_17
     port map (
      D(1) => bit_synchronizer_gtwiz_reset_rx_pll_and_datapath_dly_inst_n_1,
      D(0) => bit_synchronizer_gtwiz_reset_rx_pll_and_datapath_dly_inst_n_2,
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_rx_pll_and_datapath_dly => gtwiz_reset_rx_pll_and_datapath_dly,
      in0 => gtwiz_reset_rx_pll_and_datapath_sync,
      \out\(2 downto 0) => sm_reset_rx(2 downto 0),
      p_0_in11_out => p_0_in11_out
    );
bit_synchronizer_gtwiz_reset_tx_datapath_dly_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_18
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_tx_datapath_dly => gtwiz_reset_tx_datapath_dly,
      in0 => gtwiz_reset_tx_datapath_sync
    );
bit_synchronizer_gtwiz_reset_tx_pll_and_datapath_dly_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_19
     port map (
      D(1) => bit_synchronizer_gtwiz_reset_tx_pll_and_datapath_dly_inst_n_1,
      D(0) => bit_synchronizer_gtwiz_reset_tx_pll_and_datapath_dly_inst_n_2,
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_tx_pll_and_datapath_dly => gtwiz_reset_tx_pll_and_datapath_dly,
      in0 => gtwiz_reset_tx_pll_and_datapath_sync,
      \out\(2 downto 0) => sm_reset_tx(2 downto 0)
    );
bit_synchronizer_gtwiz_reset_userclk_rx_active_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_20
     port map (
      GTHE3_CHANNEL_RXUSERRDY(0) => \^gthe3_channel_rxuserrdy\(0),
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_rx_any_sync => gtwiz_reset_rx_any_sync,
      gtwiz_userclk_rx_active_in(0) => gtwiz_userclk_rx_active_in(0),
      i_in_out_reg_0 => bit_synchronizer_plllock_rx_inst_n_4,
      i_in_out_reg_1 => i_in_out_reg_0,
      i_in_out_reg_2 => i_in_out_reg_2,
      \out\(2 downto 0) => sm_reset_rx(2 downto 0),
      rxuserrdy_out_reg => bit_synchronizer_gtwiz_reset_userclk_rx_active_inst_n_1,
      sm_reset_rx_timer_clr0 => sm_reset_rx_timer_clr0,
      sm_reset_rx_timer_clr_reg => bit_synchronizer_gtwiz_reset_userclk_rx_active_inst_n_2,
      sm_reset_rx_timer_clr_reg_0 => sm_reset_rx_timer_clr_reg_n_0,
      sm_reset_rx_timer_sat => sm_reset_rx_timer_sat
    );
bit_synchronizer_gtwiz_reset_userclk_tx_active_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_21
     port map (
      \FSM_sequential_sm_reset_tx_reg[0]\ => bit_synchronizer_gtwiz_reset_userclk_tx_active_inst_n_2,
      \FSM_sequential_sm_reset_tx_reg[1]\ => bit_synchronizer_plllock_tx_inst_n_3,
      GTHE3_CHANNEL_TXUSERRDY(0) => \^gthe3_channel_txuserrdy\(0),
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_tx_any_sync => gtwiz_reset_tx_any_sync,
      gtwiz_reset_tx_datapath_dly => gtwiz_reset_tx_datapath_dly,
      gtwiz_reset_tx_pll_and_datapath_dly => gtwiz_reset_tx_pll_and_datapath_dly,
      gtwiz_userclk_tx_active_in(0) => gtwiz_userclk_tx_active_in(0),
      \out\(2 downto 0) => sm_reset_tx(2 downto 0),
      sm_reset_tx_timer_clr_reg => bit_synchronizer_gtwiz_reset_userclk_tx_active_inst_n_1,
      sm_reset_tx_timer_clr_reg_0 => sm_reset_tx_timer_clr_reg_n_0,
      sm_reset_tx_timer_sat => sm_reset_tx_timer_sat,
      sm_reset_tx_timer_sat_reg => \FSM_sequential_sm_reset_tx[2]_i_6_n_0\,
      txuserrdy_out_reg => bit_synchronizer_gtwiz_reset_userclk_tx_active_inst_n_0
    );
bit_synchronizer_plllock_rx_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_22
     port map (
      E(0) => bit_synchronizer_plllock_rx_inst_n_3,
      GTHE3_CHANNEL_GTRXRESET(0) => \^gthe3_channel_gtrxreset\(0),
      gtrxreset_out_reg => bit_synchronizer_plllock_rx_inst_n_1,
      gtrxreset_out_reg_0 => gtrxreset_out_reg_0,
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_rx_any_sync => gtwiz_reset_rx_any_sync,
      gtwiz_reset_rx_done_int_reg => bit_synchronizer_plllock_rx_inst_n_2,
      gtwiz_reset_rx_done_int_reg_0 => gtwiz_reset_rx_done_int_reg_n_0,
      i_in_out_reg_0 => \FSM_sequential_sm_reset_rx[2]_i_4_n_0\,
      \out\(2 downto 0) => sm_reset_rx(2 downto 0),
      p_0_in11_out => p_0_in11_out,
      sm_reset_rx_cdr_to_sat_reg => bit_synchronizer_rxcdrlock_inst_n_3,
      sm_reset_rx_pll_timer_clr_reg => sm_reset_rx_pll_timer_clr_reg_n_0,
      sm_reset_rx_pll_timer_sat => sm_reset_rx_pll_timer_sat,
      sm_reset_rx_timer_clr0 => sm_reset_rx_timer_clr0,
      sm_reset_rx_timer_clr09_out => sm_reset_rx_timer_clr09_out,
      sm_reset_rx_timer_clr_reg => bit_synchronizer_plllock_rx_inst_n_4,
      sm_reset_rx_timer_clr_reg_0 => sm_reset_rx_timer_clr_reg_n_0,
      sm_reset_rx_timer_sat => sm_reset_rx_timer_sat
    );
bit_synchronizer_plllock_tx_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_23
     port map (
      E(0) => bit_synchronizer_plllock_tx_inst_n_2,
      \FSM_sequential_sm_reset_tx_reg[1]\ => bit_synchronizer_gtwiz_reset_userclk_tx_active_inst_n_2,
      \FSM_sequential_sm_reset_tx_reg[2]\ => \FSM_sequential_sm_reset_tx[2]_i_4_n_0\,
      GTHE3_CHANNEL_GTTXRESET(0) => \^gthe3_channel_gttxreset\(0),
      gtrxreset_out_reg => gtrxreset_out_reg_0,
      gttxreset_out_reg => bit_synchronizer_plllock_tx_inst_n_0,
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_tx_any_sync => gtwiz_reset_tx_any_sync,
      gtwiz_reset_tx_done_int0 => gtwiz_reset_tx_done_int0,
      gtwiz_reset_tx_done_int_reg => bit_synchronizer_plllock_tx_inst_n_1,
      gtwiz_reset_tx_done_int_reg_0 => gtwiz_reset_tx_done_int_reg_n_0,
      i_in_out_reg_0 => i_in_out_reg,
      i_in_out_reg_1 => i_in_out_reg_1,
      \out\(2 downto 0) => sm_reset_tx(2 downto 0),
      sm_reset_tx_timer_clr_reg => bit_synchronizer_plllock_tx_inst_n_3,
      sm_reset_tx_timer_clr_reg_0 => sm_reset_tx_timer_clr_reg_n_0,
      sm_reset_tx_timer_sat => sm_reset_tx_timer_sat,
      sm_reset_tx_timer_sat_reg => \FSM_sequential_sm_reset_tx[2]_i_6_n_0\
    );
bit_synchronizer_rxcdrlock_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_24
     port map (
      \FSM_sequential_sm_reset_rx_reg[0]\ => bit_synchronizer_rxcdrlock_inst_n_3,
      GTHE3_CHANNEL_RXPROGDIVRESET(0) => \^gthe3_channel_rxprogdivreset\(0),
      gtrxreset_out_reg => gtrxreset_out_reg_1,
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_rx_any_sync => gtwiz_reset_rx_any_sync,
      gtwiz_reset_rx_cdr_stable_out(0) => gtwiz_reset_rx_cdr_stable_out(0),
      gtwiz_reset_rx_datapath_dly => gtwiz_reset_rx_datapath_dly,
      gtwiz_reset_rx_pll_and_datapath_dly => gtwiz_reset_rx_pll_and_datapath_dly,
      \out\(2 downto 0) => sm_reset_rx(2 downto 0),
      rxprogdivreset_out_reg => bit_synchronizer_rxcdrlock_inst_n_2,
      sm_reset_rx_cdr_to_clr => sm_reset_rx_cdr_to_clr,
      sm_reset_rx_cdr_to_clr_reg => bit_synchronizer_rxcdrlock_inst_n_1,
      sm_reset_rx_cdr_to_sat => sm_reset_rx_cdr_to_sat,
      sm_reset_rx_timer_clr09_out => sm_reset_rx_timer_clr09_out
    );
\gthe3_channel_gen.gen_gthe3_channel_inst[3].GTHE3_CHANNEL_PRIM_INST_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => gtwiz_reset_pllreset_tx_int,
      I1 => gtwiz_reset_pllreset_rx_int,
      O => GTHE3_CHANNEL_CPLLPD(0)
    );
gtrxreset_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => bit_synchronizer_plllock_rx_inst_n_1,
      Q => \^gthe3_channel_gtrxreset\(0),
      R => '0'
    );
gttxreset_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => bit_synchronizer_plllock_tx_inst_n_0,
      Q => \^gthe3_channel_gttxreset\(0),
      R => '0'
    );
gtwiz_reset_rx_datapath_int_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F720"
    )
        port map (
      I0 => sm_reset_all(0),
      I1 => sm_reset_all(2),
      I2 => sm_reset_all(1),
      I3 => gtwiz_reset_rx_datapath_int_reg_n_0,
      O => gtwiz_reset_rx_datapath_int_i_1_n_0
    );
gtwiz_reset_rx_datapath_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => gtwiz_reset_rx_datapath_int_i_1_n_0,
      Q => gtwiz_reset_rx_datapath_int_reg_n_0,
      R => gtwiz_reset_all_sync
    );
gtwiz_reset_rx_done_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => bit_synchronizer_plllock_rx_inst_n_2,
      Q => gtwiz_reset_rx_done_int_reg_n_0,
      R => gtwiz_reset_rx_any_sync
    );
gtwiz_reset_rx_pll_and_datapath_int_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F704"
    )
        port map (
      I0 => sm_reset_all(0),
      I1 => sm_reset_all(2),
      I2 => sm_reset_all(1),
      I3 => gtwiz_reset_rx_pll_and_datapath_int_reg_n_0,
      O => gtwiz_reset_rx_pll_and_datapath_int_i_1_n_0
    );
gtwiz_reset_rx_pll_and_datapath_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => gtwiz_reset_rx_pll_and_datapath_int_i_1_n_0,
      Q => gtwiz_reset_rx_pll_and_datapath_int_reg_n_0,
      R => gtwiz_reset_all_sync
    );
gtwiz_reset_tx_done_int_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0400000000000000"
    )
        port map (
      I0 => sm_reset_tx_timer_clr_reg_n_0,
      I1 => sm_reset_tx_timer_sat,
      I2 => i_in_out_reg,
      I3 => txresetdone_sync(1),
      I4 => txresetdone_sync(2),
      I5 => txresetdone_sync(0),
      O => gtwiz_reset_tx_done_int0
    );
gtwiz_reset_tx_done_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => bit_synchronizer_plllock_tx_inst_n_1,
      Q => gtwiz_reset_tx_done_int_reg_n_0,
      R => gtwiz_reset_tx_any_sync
    );
gtwiz_reset_tx_pll_and_datapath_int_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FD04"
    )
        port map (
      I0 => sm_reset_all(1),
      I1 => sm_reset_all(0),
      I2 => sm_reset_all(2),
      I3 => gtwiz_reset_tx_pll_and_datapath_int_reg_n_0,
      O => gtwiz_reset_tx_pll_and_datapath_int_i_1_n_0
    );
gtwiz_reset_tx_pll_and_datapath_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => gtwiz_reset_tx_pll_and_datapath_int_i_1_n_0,
      Q => gtwiz_reset_tx_pll_and_datapath_int_reg_n_0,
      R => gtwiz_reset_all_sync
    );
pllreset_rx_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => reset_synchronizer_gtwiz_reset_rx_any_inst_n_1,
      Q => gtwiz_reset_pllreset_rx_int,
      R => '0'
    );
pllreset_tx_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => reset_synchronizer_gtwiz_reset_tx_any_inst_n_1,
      Q => gtwiz_reset_pllreset_tx_int,
      R => '0'
    );
reset_synchronizer_gtwiz_reset_all_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer
     port map (
      SR(0) => gtwiz_reset_all_sync,
      gtwiz_reset_all_in(0) => gtwiz_reset_all_in(0),
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0)
    );
reset_synchronizer_gtwiz_reset_rx_any_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_25
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_pllreset_rx_int => gtwiz_reset_pllreset_rx_int,
      gtwiz_reset_rx_any_sync => gtwiz_reset_rx_any_sync,
      gtwiz_reset_rx_datapath_in(0) => gtwiz_reset_rx_datapath_in(0),
      gtwiz_reset_rx_datapath_int_reg => gtwiz_reset_rx_datapath_int_reg_n_0,
      gtwiz_reset_rx_pll_and_datapath_in(0) => gtwiz_reset_rx_pll_and_datapath_in(0),
      gtwiz_reset_rx_pll_and_datapath_int_reg => gtwiz_reset_rx_pll_and_datapath_int_reg_n_0,
      \out\(2 downto 0) => sm_reset_rx(2 downto 0),
      pllreset_rx_out_reg => reset_synchronizer_gtwiz_reset_rx_any_inst_n_1
    );
reset_synchronizer_gtwiz_reset_rx_datapath_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_26
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_rx_datapath_in(0) => gtwiz_reset_rx_datapath_in(0),
      gtwiz_reset_rx_datapath_int_reg => gtwiz_reset_rx_datapath_int_reg_n_0,
      in0 => gtwiz_reset_rx_datapath_sync
    );
reset_synchronizer_gtwiz_reset_rx_pll_and_datapath_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_27
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_rx_pll_and_datapath_in(0) => gtwiz_reset_rx_pll_and_datapath_in(0),
      gtwiz_reset_rx_pll_and_datapath_int_reg => gtwiz_reset_rx_pll_and_datapath_int_reg_n_0,
      in0 => gtwiz_reset_rx_pll_and_datapath_sync
    );
reset_synchronizer_gtwiz_reset_tx_any_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_28
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_pllreset_tx_int => gtwiz_reset_pllreset_tx_int,
      gtwiz_reset_tx_any_sync => gtwiz_reset_tx_any_sync,
      gtwiz_reset_tx_datapath_in(0) => gtwiz_reset_tx_datapath_in(0),
      gtwiz_reset_tx_pll_and_datapath_in(0) => gtwiz_reset_tx_pll_and_datapath_in(0),
      gtwiz_reset_tx_pll_and_datapath_int_reg => gtwiz_reset_tx_pll_and_datapath_int_reg_n_0,
      \out\(2 downto 0) => sm_reset_tx(2 downto 0),
      pllreset_tx_out_reg => reset_synchronizer_gtwiz_reset_tx_any_inst_n_1
    );
reset_synchronizer_gtwiz_reset_tx_datapath_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_29
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_tx_datapath_in(0) => gtwiz_reset_tx_datapath_in(0),
      in0 => gtwiz_reset_tx_datapath_sync
    );
reset_synchronizer_gtwiz_reset_tx_pll_and_datapath_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_30
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_tx_pll_and_datapath_in(0) => gtwiz_reset_tx_pll_and_datapath_in(0),
      gtwiz_reset_tx_pll_and_datapath_int_reg => gtwiz_reset_tx_pll_and_datapath_int_reg_n_0,
      in0 => gtwiz_reset_tx_pll_and_datapath_sync
    );
reset_synchronizer_rx_done_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer_31
     port map (
      gtwiz_reset_rx_done_int_reg => gtwiz_reset_rx_done_int_reg_n_0,
      gtwiz_reset_rx_done_out(0) => gtwiz_reset_rx_done_out(0),
      rxusrclk2_in(0) => rxusrclk2_in(0)
    );
reset_synchronizer_tx_done_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_inv_synchronizer_32
     port map (
      gtwiz_reset_tx_done_int_reg => gtwiz_reset_tx_done_int_reg_n_0,
      gtwiz_reset_tx_done_out(0) => gtwiz_reset_tx_done_out(0),
      rst_in_sync2_reg_0 => rst_in_sync2_reg,
      txusrclk2_in(0) => txusrclk2_in(0)
    );
reset_synchronizer_txprogdivreset_inst: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_reset_synchronizer_33
     port map (
      GTHE3_CHANNEL_TXPROGDIVRESET(0) => GTHE3_CHANNEL_TXPROGDIVRESET(0),
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      rst_in0 => rst_in0
    );
rxprogdivreset_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => bit_synchronizer_rxcdrlock_inst_n_2,
      Q => \^gthe3_channel_rxprogdivreset\(0),
      R => '0'
    );
rxuserrdy_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => bit_synchronizer_gtwiz_reset_userclk_rx_active_inst_n_1,
      Q => \^gthe3_channel_rxuserrdy\(0),
      R => '0'
    );
sm_reset_all_timer_clr_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFA200A"
    )
        port map (
      I0 => sm_reset_all_timer_clr_i_2_n_0,
      I1 => sm_reset_all(1),
      I2 => sm_reset_all(0),
      I3 => sm_reset_all(2),
      I4 => sm_reset_all_timer_clr_reg_n_0,
      O => sm_reset_all_timer_clr_i_1_n_0
    );
sm_reset_all_timer_clr_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"05050505DD0D0505"
    )
        port map (
      I0 => sm_reset_all(1),
      I1 => gtwiz_reset_tx_done_int_reg_n_0,
      I2 => sm_reset_all(2),
      I3 => gtwiz_reset_rx_done_int_reg_n_0,
      I4 => sm_reset_all_timer_sat,
      I5 => sm_reset_all_timer_clr_reg_n_0,
      O => sm_reset_all_timer_clr_i_2_n_0
    );
sm_reset_all_timer_clr_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => sm_reset_all_timer_clr_i_1_n_0,
      Q => sm_reset_all_timer_clr_reg_n_0,
      S => gtwiz_reset_all_sync
    );
\sm_reset_all_timer_ctr0_inferred__0/i_\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => sm_reset_all_timer_ctr(2),
      I1 => sm_reset_all_timer_ctr(0),
      I2 => sm_reset_all_timer_ctr(1),
      O => \sm_reset_all_timer_ctr0_inferred__0/i__n_0\
    );
\sm_reset_all_timer_ctr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => sm_reset_all_timer_ctr(0),
      O => \sm_reset_all_timer_ctr[0]_i_1_n_0\
    );
\sm_reset_all_timer_ctr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => sm_reset_all_timer_ctr(0),
      I1 => sm_reset_all_timer_ctr(1),
      O => \sm_reset_all_timer_ctr[1]_i_1_n_0\
    );
\sm_reset_all_timer_ctr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => sm_reset_all_timer_ctr(0),
      I1 => sm_reset_all_timer_ctr(1),
      I2 => sm_reset_all_timer_ctr(2),
      O => \sm_reset_all_timer_ctr[2]_i_1_n_0\
    );
\sm_reset_all_timer_ctr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_all_timer_ctr0_inferred__0/i__n_0\,
      D => \sm_reset_all_timer_ctr[0]_i_1_n_0\,
      Q => sm_reset_all_timer_ctr(0),
      R => sm_reset_all_timer_clr_reg_n_0
    );
\sm_reset_all_timer_ctr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_all_timer_ctr0_inferred__0/i__n_0\,
      D => \sm_reset_all_timer_ctr[1]_i_1_n_0\,
      Q => sm_reset_all_timer_ctr(1),
      R => sm_reset_all_timer_clr_reg_n_0
    );
\sm_reset_all_timer_ctr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_all_timer_ctr0_inferred__0/i__n_0\,
      D => \sm_reset_all_timer_ctr[2]_i_1_n_0\,
      Q => sm_reset_all_timer_ctr(2),
      R => sm_reset_all_timer_clr_reg_n_0
    );
sm_reset_all_timer_sat_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FF80"
    )
        port map (
      I0 => sm_reset_all_timer_ctr(2),
      I1 => sm_reset_all_timer_ctr(0),
      I2 => sm_reset_all_timer_ctr(1),
      I3 => sm_reset_all_timer_sat,
      I4 => sm_reset_all_timer_clr_reg_n_0,
      O => sm_reset_all_timer_sat_i_1_n_0
    );
sm_reset_all_timer_sat_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => sm_reset_all_timer_sat_i_1_n_0,
      Q => sm_reset_all_timer_sat,
      R => '0'
    );
sm_reset_rx_cdr_to_clr_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => bit_synchronizer_rxcdrlock_inst_n_1,
      Q => sm_reset_rx_cdr_to_clr,
      S => gtwiz_reset_rx_any_sync
    );
\sm_reset_rx_cdr_to_ctr[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
        port map (
      I0 => \sm_reset_rx_cdr_to_ctr[0]_i_3_n_0\,
      I1 => \sm_reset_rx_cdr_to_ctr[0]_i_4_n_0\,
      I2 => \sm_reset_rx_cdr_to_ctr[0]_i_5_n_0\,
      I3 => \sm_reset_rx_cdr_to_ctr[0]_i_6_n_0\,
      I4 => \sm_reset_rx_cdr_to_ctr[0]_i_7_n_0\,
      I5 => \sm_reset_rx_cdr_to_ctr[0]_i_8_n_0\,
      O => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\
    );
\sm_reset_rx_cdr_to_ctr[0]_i_10\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(6),
      O => \sm_reset_rx_cdr_to_ctr[0]_i_10_n_0\
    );
\sm_reset_rx_cdr_to_ctr[0]_i_11\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(5),
      O => \sm_reset_rx_cdr_to_ctr[0]_i_11_n_0\
    );
\sm_reset_rx_cdr_to_ctr[0]_i_12\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(4),
      O => \sm_reset_rx_cdr_to_ctr[0]_i_12_n_0\
    );
\sm_reset_rx_cdr_to_ctr[0]_i_13\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(3),
      O => \sm_reset_rx_cdr_to_ctr[0]_i_13_n_0\
    );
\sm_reset_rx_cdr_to_ctr[0]_i_14\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(2),
      O => \sm_reset_rx_cdr_to_ctr[0]_i_14_n_0\
    );
\sm_reset_rx_cdr_to_ctr[0]_i_15\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(1),
      O => \sm_reset_rx_cdr_to_ctr[0]_i_15_n_0\
    );
\sm_reset_rx_cdr_to_ctr[0]_i_16\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(0),
      O => \sm_reset_rx_cdr_to_ctr[0]_i_16_n_0\
    );
\sm_reset_rx_cdr_to_ctr[0]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(3),
      I1 => sm_reset_rx_cdr_to_ctr_reg(0),
      I2 => sm_reset_rx_cdr_to_ctr_reg(5),
      I3 => sm_reset_rx_cdr_to_ctr_reg(4),
      O => \sm_reset_rx_cdr_to_ctr[0]_i_3_n_0\
    );
\sm_reset_rx_cdr_to_ctr[0]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(12),
      I1 => sm_reset_rx_cdr_to_ctr_reg(7),
      I2 => sm_reset_rx_cdr_to_ctr_reg(6),
      O => \sm_reset_rx_cdr_to_ctr[0]_i_4_n_0\
    );
\sm_reset_rx_cdr_to_ctr[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0100000000000000"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(8),
      I1 => sm_reset_rx_cdr_to_ctr_reg(1),
      I2 => sm_reset_rx_cdr_to_ctr_reg(2),
      I3 => sm_reset_rx_cdr_to_ctr_reg(19),
      I4 => sm_reset_rx_cdr_to_ctr_reg(13),
      I5 => sm_reset_rx_cdr_to_ctr_reg(16),
      O => \sm_reset_rx_cdr_to_ctr[0]_i_5_n_0\
    );
\sm_reset_rx_cdr_to_ctr[0]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(14),
      I1 => sm_reset_rx_cdr_to_ctr_reg(11),
      I2 => sm_reset_rx_cdr_to_ctr_reg(10),
      I3 => sm_reset_rx_cdr_to_ctr_reg(9),
      O => \sm_reset_rx_cdr_to_ctr[0]_i_6_n_0\
    );
\sm_reset_rx_cdr_to_ctr[0]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(17),
      I1 => sm_reset_rx_cdr_to_ctr_reg(15),
      I2 => sm_reset_rx_cdr_to_ctr_reg(18),
      O => \sm_reset_rx_cdr_to_ctr[0]_i_7_n_0\
    );
\sm_reset_rx_cdr_to_ctr[0]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(24),
      I1 => sm_reset_rx_cdr_to_ctr_reg(23),
      I2 => sm_reset_rx_cdr_to_ctr_reg(25),
      I3 => sm_reset_rx_cdr_to_ctr_reg(20),
      I4 => sm_reset_rx_cdr_to_ctr_reg(21),
      I5 => sm_reset_rx_cdr_to_ctr_reg(22),
      O => \sm_reset_rx_cdr_to_ctr[0]_i_8_n_0\
    );
\sm_reset_rx_cdr_to_ctr[0]_i_9\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(7),
      O => \sm_reset_rx_cdr_to_ctr[0]_i_9_n_0\
    );
\sm_reset_rx_cdr_to_ctr[16]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(23),
      O => \sm_reset_rx_cdr_to_ctr[16]_i_2_n_0\
    );
\sm_reset_rx_cdr_to_ctr[16]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(22),
      O => \sm_reset_rx_cdr_to_ctr[16]_i_3_n_0\
    );
\sm_reset_rx_cdr_to_ctr[16]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(21),
      O => \sm_reset_rx_cdr_to_ctr[16]_i_4_n_0\
    );
\sm_reset_rx_cdr_to_ctr[16]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(20),
      O => \sm_reset_rx_cdr_to_ctr[16]_i_5_n_0\
    );
\sm_reset_rx_cdr_to_ctr[16]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(19),
      O => \sm_reset_rx_cdr_to_ctr[16]_i_6_n_0\
    );
\sm_reset_rx_cdr_to_ctr[16]_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(18),
      O => \sm_reset_rx_cdr_to_ctr[16]_i_7_n_0\
    );
\sm_reset_rx_cdr_to_ctr[16]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(17),
      O => \sm_reset_rx_cdr_to_ctr[16]_i_8_n_0\
    );
\sm_reset_rx_cdr_to_ctr[16]_i_9\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(16),
      O => \sm_reset_rx_cdr_to_ctr[16]_i_9_n_0\
    );
\sm_reset_rx_cdr_to_ctr[24]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(25),
      O => \sm_reset_rx_cdr_to_ctr[24]_i_2_n_0\
    );
\sm_reset_rx_cdr_to_ctr[24]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(24),
      O => \sm_reset_rx_cdr_to_ctr[24]_i_3_n_0\
    );
\sm_reset_rx_cdr_to_ctr[8]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(15),
      O => \sm_reset_rx_cdr_to_ctr[8]_i_2_n_0\
    );
\sm_reset_rx_cdr_to_ctr[8]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(14),
      O => \sm_reset_rx_cdr_to_ctr[8]_i_3_n_0\
    );
\sm_reset_rx_cdr_to_ctr[8]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(13),
      O => \sm_reset_rx_cdr_to_ctr[8]_i_4_n_0\
    );
\sm_reset_rx_cdr_to_ctr[8]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(12),
      O => \sm_reset_rx_cdr_to_ctr[8]_i_5_n_0\
    );
\sm_reset_rx_cdr_to_ctr[8]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(11),
      O => \sm_reset_rx_cdr_to_ctr[8]_i_6_n_0\
    );
\sm_reset_rx_cdr_to_ctr[8]_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(10),
      O => \sm_reset_rx_cdr_to_ctr[8]_i_7_n_0\
    );
\sm_reset_rx_cdr_to_ctr[8]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(9),
      O => \sm_reset_rx_cdr_to_ctr[8]_i_8_n_0\
    );
\sm_reset_rx_cdr_to_ctr[8]_i_9\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => sm_reset_rx_cdr_to_ctr_reg(8),
      O => \sm_reset_rx_cdr_to_ctr[8]_i_9_n_0\
    );
\sm_reset_rx_cdr_to_ctr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_15\,
      Q => sm_reset_rx_cdr_to_ctr_reg(0),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[0]_i_2\: unisim.vcomponents.CARRY8
     port map (
      CI => '0',
      CI_TOP => '0',
      CO(7) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_0\,
      CO(6) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_1\,
      CO(5) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_2\,
      CO(4) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_3\,
      CO(3) => \NLW_sm_reset_rx_cdr_to_ctr_reg[0]_i_2_CO_UNCONNECTED\(3),
      CO(2) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_5\,
      CO(1) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_6\,
      CO(0) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_7\,
      DI(7 downto 0) => B"00000001",
      O(7) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_8\,
      O(6) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_9\,
      O(5) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_10\,
      O(4) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_11\,
      O(3) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_12\,
      O(2) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_13\,
      O(1) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_14\,
      O(0) => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_15\,
      S(7) => \sm_reset_rx_cdr_to_ctr[0]_i_9_n_0\,
      S(6) => \sm_reset_rx_cdr_to_ctr[0]_i_10_n_0\,
      S(5) => \sm_reset_rx_cdr_to_ctr[0]_i_11_n_0\,
      S(4) => \sm_reset_rx_cdr_to_ctr[0]_i_12_n_0\,
      S(3) => \sm_reset_rx_cdr_to_ctr[0]_i_13_n_0\,
      S(2) => \sm_reset_rx_cdr_to_ctr[0]_i_14_n_0\,
      S(1) => \sm_reset_rx_cdr_to_ctr[0]_i_15_n_0\,
      S(0) => \sm_reset_rx_cdr_to_ctr[0]_i_16_n_0\
    );
\sm_reset_rx_cdr_to_ctr_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_13\,
      Q => sm_reset_rx_cdr_to_ctr_reg(10),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_12\,
      Q => sm_reset_rx_cdr_to_ctr_reg(11),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_11\,
      Q => sm_reset_rx_cdr_to_ctr_reg(12),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_10\,
      Q => sm_reset_rx_cdr_to_ctr_reg(13),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_9\,
      Q => sm_reset_rx_cdr_to_ctr_reg(14),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_8\,
      Q => sm_reset_rx_cdr_to_ctr_reg(15),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_15\,
      Q => sm_reset_rx_cdr_to_ctr_reg(16),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[16]_i_1\: unisim.vcomponents.CARRY8
     port map (
      CI => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_0\,
      CI_TOP => '0',
      CO(7) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_0\,
      CO(6) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_1\,
      CO(5) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_2\,
      CO(4) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_3\,
      CO(3) => \NLW_sm_reset_rx_cdr_to_ctr_reg[16]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_5\,
      CO(1) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_6\,
      CO(0) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_7\,
      DI(7 downto 0) => B"00000000",
      O(7) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_8\,
      O(6) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_9\,
      O(5) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_10\,
      O(4) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_11\,
      O(3) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_12\,
      O(2) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_13\,
      O(1) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_14\,
      O(0) => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_15\,
      S(7) => \sm_reset_rx_cdr_to_ctr[16]_i_2_n_0\,
      S(6) => \sm_reset_rx_cdr_to_ctr[16]_i_3_n_0\,
      S(5) => \sm_reset_rx_cdr_to_ctr[16]_i_4_n_0\,
      S(4) => \sm_reset_rx_cdr_to_ctr[16]_i_5_n_0\,
      S(3) => \sm_reset_rx_cdr_to_ctr[16]_i_6_n_0\,
      S(2) => \sm_reset_rx_cdr_to_ctr[16]_i_7_n_0\,
      S(1) => \sm_reset_rx_cdr_to_ctr[16]_i_8_n_0\,
      S(0) => \sm_reset_rx_cdr_to_ctr[16]_i_9_n_0\
    );
\sm_reset_rx_cdr_to_ctr_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_14\,
      Q => sm_reset_rx_cdr_to_ctr_reg(17),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_13\,
      Q => sm_reset_rx_cdr_to_ctr_reg(18),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_12\,
      Q => sm_reset_rx_cdr_to_ctr_reg(19),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_14\,
      Q => sm_reset_rx_cdr_to_ctr_reg(1),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_11\,
      Q => sm_reset_rx_cdr_to_ctr_reg(20),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_10\,
      Q => sm_reset_rx_cdr_to_ctr_reg(21),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_9\,
      Q => sm_reset_rx_cdr_to_ctr_reg(22),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_8\,
      Q => sm_reset_rx_cdr_to_ctr_reg(23),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[24]_i_1_n_15\,
      Q => sm_reset_rx_cdr_to_ctr_reg(24),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[24]_i_1\: unisim.vcomponents.CARRY8
     port map (
      CI => \sm_reset_rx_cdr_to_ctr_reg[16]_i_1_n_0\,
      CI_TOP => '0',
      CO(7 downto 1) => \NLW_sm_reset_rx_cdr_to_ctr_reg[24]_i_1_CO_UNCONNECTED\(7 downto 1),
      CO(0) => \sm_reset_rx_cdr_to_ctr_reg[24]_i_1_n_7\,
      DI(7 downto 2) => \NLW_sm_reset_rx_cdr_to_ctr_reg[24]_i_1_DI_UNCONNECTED\(7 downto 2),
      DI(1 downto 0) => B"00",
      O(7 downto 2) => \NLW_sm_reset_rx_cdr_to_ctr_reg[24]_i_1_O_UNCONNECTED\(7 downto 2),
      O(1) => \sm_reset_rx_cdr_to_ctr_reg[24]_i_1_n_14\,
      O(0) => \sm_reset_rx_cdr_to_ctr_reg[24]_i_1_n_15\,
      S(7 downto 2) => \NLW_sm_reset_rx_cdr_to_ctr_reg[24]_i_1_S_UNCONNECTED\(7 downto 2),
      S(1) => \sm_reset_rx_cdr_to_ctr[24]_i_2_n_0\,
      S(0) => \sm_reset_rx_cdr_to_ctr[24]_i_3_n_0\
    );
\sm_reset_rx_cdr_to_ctr_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[24]_i_1_n_14\,
      Q => sm_reset_rx_cdr_to_ctr_reg(25),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_13\,
      Q => sm_reset_rx_cdr_to_ctr_reg(2),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_12\,
      Q => sm_reset_rx_cdr_to_ctr_reg(3),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_11\,
      Q => sm_reset_rx_cdr_to_ctr_reg(4),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_10\,
      Q => sm_reset_rx_cdr_to_ctr_reg(5),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_9\,
      Q => sm_reset_rx_cdr_to_ctr_reg(6),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_8\,
      Q => sm_reset_rx_cdr_to_ctr_reg(7),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_15\,
      Q => sm_reset_rx_cdr_to_ctr_reg(8),
      R => sm_reset_rx_cdr_to_clr
    );
\sm_reset_rx_cdr_to_ctr_reg[8]_i_1\: unisim.vcomponents.CARRY8
     port map (
      CI => \sm_reset_rx_cdr_to_ctr_reg[0]_i_2_n_0\,
      CI_TOP => '0',
      CO(7) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_0\,
      CO(6) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_1\,
      CO(5) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_2\,
      CO(4) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_3\,
      CO(3) => \NLW_sm_reset_rx_cdr_to_ctr_reg[8]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_5\,
      CO(1) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_6\,
      CO(0) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_7\,
      DI(7 downto 0) => B"00000000",
      O(7) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_8\,
      O(6) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_9\,
      O(5) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_10\,
      O(4) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_11\,
      O(3) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_12\,
      O(2) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_13\,
      O(1) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_14\,
      O(0) => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_15\,
      S(7) => \sm_reset_rx_cdr_to_ctr[8]_i_2_n_0\,
      S(6) => \sm_reset_rx_cdr_to_ctr[8]_i_3_n_0\,
      S(5) => \sm_reset_rx_cdr_to_ctr[8]_i_4_n_0\,
      S(4) => \sm_reset_rx_cdr_to_ctr[8]_i_5_n_0\,
      S(3) => \sm_reset_rx_cdr_to_ctr[8]_i_6_n_0\,
      S(2) => \sm_reset_rx_cdr_to_ctr[8]_i_7_n_0\,
      S(1) => \sm_reset_rx_cdr_to_ctr[8]_i_8_n_0\,
      S(0) => \sm_reset_rx_cdr_to_ctr[8]_i_9_n_0\
    );
\sm_reset_rx_cdr_to_ctr_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      D => \sm_reset_rx_cdr_to_ctr_reg[8]_i_1_n_14\,
      Q => sm_reset_rx_cdr_to_ctr_reg(9),
      R => sm_reset_rx_cdr_to_clr
    );
sm_reset_rx_cdr_to_sat_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0D"
    )
        port map (
      I0 => \sm_reset_rx_cdr_to_ctr[0]_i_1_n_0\,
      I1 => sm_reset_rx_cdr_to_sat,
      I2 => sm_reset_rx_cdr_to_clr,
      O => sm_reset_rx_cdr_to_sat_i_1_n_0
    );
sm_reset_rx_cdr_to_sat_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => sm_reset_rx_cdr_to_sat_i_1_n_0,
      Q => sm_reset_rx_cdr_to_sat,
      R => '0'
    );
sm_reset_rx_pll_timer_clr_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFF3000B"
    )
        port map (
      I0 => sm_reset_rx_pll_timer_sat,
      I1 => sm_reset_rx(0),
      I2 => sm_reset_rx(1),
      I3 => sm_reset_rx(2),
      I4 => sm_reset_rx_pll_timer_clr_reg_n_0,
      O => sm_reset_rx_pll_timer_clr_i_1_n_0
    );
sm_reset_rx_pll_timer_clr_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => sm_reset_rx_pll_timer_clr_i_1_n_0,
      Q => sm_reset_rx_pll_timer_clr_reg_n_0,
      S => gtwiz_reset_rx_any_sync
    );
\sm_reset_rx_pll_timer_ctr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \sm_reset_rx_pll_timer_ctr_reg__0\(0),
      O => \p_0_in__1\(0)
    );
\sm_reset_rx_pll_timer_ctr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \sm_reset_rx_pll_timer_ctr_reg__0\(0),
      I1 => \sm_reset_rx_pll_timer_ctr_reg__0\(1),
      O => \p_0_in__1\(1)
    );
\sm_reset_rx_pll_timer_ctr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \sm_reset_rx_pll_timer_ctr_reg__0\(0),
      I1 => \sm_reset_rx_pll_timer_ctr_reg__0\(1),
      I2 => \sm_reset_rx_pll_timer_ctr_reg__0\(2),
      O => \p_0_in__1\(2)
    );
\sm_reset_rx_pll_timer_ctr[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \sm_reset_rx_pll_timer_ctr_reg__0\(1),
      I1 => \sm_reset_rx_pll_timer_ctr_reg__0\(0),
      I2 => \sm_reset_rx_pll_timer_ctr_reg__0\(2),
      I3 => \sm_reset_rx_pll_timer_ctr_reg__0\(3),
      O => \p_0_in__1\(3)
    );
\sm_reset_rx_pll_timer_ctr[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \sm_reset_rx_pll_timer_ctr_reg__0\(2),
      I1 => \sm_reset_rx_pll_timer_ctr_reg__0\(0),
      I2 => \sm_reset_rx_pll_timer_ctr_reg__0\(1),
      I3 => \sm_reset_rx_pll_timer_ctr_reg__0\(3),
      I4 => \sm_reset_rx_pll_timer_ctr_reg__0\(4),
      O => \p_0_in__1\(4)
    );
\sm_reset_rx_pll_timer_ctr[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => \sm_reset_rx_pll_timer_ctr_reg__0\(3),
      I1 => \sm_reset_rx_pll_timer_ctr_reg__0\(1),
      I2 => \sm_reset_rx_pll_timer_ctr_reg__0\(0),
      I3 => \sm_reset_rx_pll_timer_ctr_reg__0\(2),
      I4 => \sm_reset_rx_pll_timer_ctr_reg__0\(4),
      I5 => \sm_reset_rx_pll_timer_ctr_reg__0\(5),
      O => \p_0_in__1\(5)
    );
\sm_reset_rx_pll_timer_ctr[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \sm_reset_rx_pll_timer_ctr[9]_i_4_n_0\,
      I1 => \sm_reset_rx_pll_timer_ctr_reg__0\(6),
      O => \p_0_in__1\(6)
    );
\sm_reset_rx_pll_timer_ctr[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \sm_reset_rx_pll_timer_ctr[9]_i_4_n_0\,
      I1 => \sm_reset_rx_pll_timer_ctr_reg__0\(6),
      I2 => \sm_reset_rx_pll_timer_ctr_reg__0\(7),
      O => \p_0_in__1\(7)
    );
\sm_reset_rx_pll_timer_ctr[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \sm_reset_rx_pll_timer_ctr_reg__0\(6),
      I1 => \sm_reset_rx_pll_timer_ctr[9]_i_4_n_0\,
      I2 => \sm_reset_rx_pll_timer_ctr_reg__0\(7),
      I3 => \sm_reset_rx_pll_timer_ctr_reg__0\(8),
      O => \p_0_in__1\(8)
    );
\sm_reset_rx_pll_timer_ctr[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF7FFFFFFFFFFF"
    )
        port map (
      I0 => \sm_reset_rx_pll_timer_ctr_reg__0\(4),
      I1 => \sm_reset_rx_pll_timer_ctr_reg__0\(1),
      I2 => \sm_reset_rx_pll_timer_ctr_reg__0\(7),
      I3 => \sm_reset_rx_pll_timer_ctr_reg__0\(8),
      I4 => \sm_reset_rx_pll_timer_ctr_reg__0\(0),
      I5 => \sm_reset_rx_pll_timer_ctr[9]_i_3_n_0\,
      O => \sm_reset_rx_pll_timer_ctr[9]_i_1_n_0\
    );
\sm_reset_rx_pll_timer_ctr[9]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \sm_reset_rx_pll_timer_ctr_reg__0\(7),
      I1 => \sm_reset_rx_pll_timer_ctr[9]_i_4_n_0\,
      I2 => \sm_reset_rx_pll_timer_ctr_reg__0\(6),
      I3 => \sm_reset_rx_pll_timer_ctr_reg__0\(8),
      I4 => \sm_reset_rx_pll_timer_ctr_reg__0\(9),
      O => \p_0_in__1\(9)
    );
\sm_reset_rx_pll_timer_ctr[9]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \sm_reset_rx_pll_timer_ctr_reg__0\(9),
      I1 => \sm_reset_rx_pll_timer_ctr_reg__0\(6),
      I2 => \sm_reset_rx_pll_timer_ctr_reg__0\(2),
      I3 => \sm_reset_rx_pll_timer_ctr_reg__0\(3),
      I4 => \sm_reset_rx_pll_timer_ctr_reg__0\(5),
      O => \sm_reset_rx_pll_timer_ctr[9]_i_3_n_0\
    );
\sm_reset_rx_pll_timer_ctr[9]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \sm_reset_rx_pll_timer_ctr_reg__0\(5),
      I1 => \sm_reset_rx_pll_timer_ctr_reg__0\(3),
      I2 => \sm_reset_rx_pll_timer_ctr_reg__0\(1),
      I3 => \sm_reset_rx_pll_timer_ctr_reg__0\(0),
      I4 => \sm_reset_rx_pll_timer_ctr_reg__0\(2),
      I5 => \sm_reset_rx_pll_timer_ctr_reg__0\(4),
      O => \sm_reset_rx_pll_timer_ctr[9]_i_4_n_0\
    );
\sm_reset_rx_pll_timer_ctr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_pll_timer_ctr[9]_i_1_n_0\,
      D => \p_0_in__1\(0),
      Q => \sm_reset_rx_pll_timer_ctr_reg__0\(0),
      R => sm_reset_rx_pll_timer_clr_reg_n_0
    );
\sm_reset_rx_pll_timer_ctr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_pll_timer_ctr[9]_i_1_n_0\,
      D => \p_0_in__1\(1),
      Q => \sm_reset_rx_pll_timer_ctr_reg__0\(1),
      R => sm_reset_rx_pll_timer_clr_reg_n_0
    );
\sm_reset_rx_pll_timer_ctr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_pll_timer_ctr[9]_i_1_n_0\,
      D => \p_0_in__1\(2),
      Q => \sm_reset_rx_pll_timer_ctr_reg__0\(2),
      R => sm_reset_rx_pll_timer_clr_reg_n_0
    );
\sm_reset_rx_pll_timer_ctr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_pll_timer_ctr[9]_i_1_n_0\,
      D => \p_0_in__1\(3),
      Q => \sm_reset_rx_pll_timer_ctr_reg__0\(3),
      R => sm_reset_rx_pll_timer_clr_reg_n_0
    );
\sm_reset_rx_pll_timer_ctr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_pll_timer_ctr[9]_i_1_n_0\,
      D => \p_0_in__1\(4),
      Q => \sm_reset_rx_pll_timer_ctr_reg__0\(4),
      R => sm_reset_rx_pll_timer_clr_reg_n_0
    );
\sm_reset_rx_pll_timer_ctr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_pll_timer_ctr[9]_i_1_n_0\,
      D => \p_0_in__1\(5),
      Q => \sm_reset_rx_pll_timer_ctr_reg__0\(5),
      R => sm_reset_rx_pll_timer_clr_reg_n_0
    );
\sm_reset_rx_pll_timer_ctr_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_pll_timer_ctr[9]_i_1_n_0\,
      D => \p_0_in__1\(6),
      Q => \sm_reset_rx_pll_timer_ctr_reg__0\(6),
      R => sm_reset_rx_pll_timer_clr_reg_n_0
    );
\sm_reset_rx_pll_timer_ctr_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_pll_timer_ctr[9]_i_1_n_0\,
      D => \p_0_in__1\(7),
      Q => \sm_reset_rx_pll_timer_ctr_reg__0\(7),
      R => sm_reset_rx_pll_timer_clr_reg_n_0
    );
\sm_reset_rx_pll_timer_ctr_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_pll_timer_ctr[9]_i_1_n_0\,
      D => \p_0_in__1\(8),
      Q => \sm_reset_rx_pll_timer_ctr_reg__0\(8),
      R => sm_reset_rx_pll_timer_clr_reg_n_0
    );
\sm_reset_rx_pll_timer_ctr_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_pll_timer_ctr[9]_i_1_n_0\,
      D => \p_0_in__1\(9),
      Q => \sm_reset_rx_pll_timer_ctr_reg__0\(9),
      R => sm_reset_rx_pll_timer_clr_reg_n_0
    );
sm_reset_rx_pll_timer_sat_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0D"
    )
        port map (
      I0 => \sm_reset_rx_pll_timer_ctr[9]_i_1_n_0\,
      I1 => sm_reset_rx_pll_timer_sat,
      I2 => sm_reset_rx_pll_timer_clr_reg_n_0,
      O => sm_reset_rx_pll_timer_sat_i_1_n_0
    );
sm_reset_rx_pll_timer_sat_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => sm_reset_rx_pll_timer_sat_i_1_n_0,
      Q => sm_reset_rx_pll_timer_sat,
      R => '0'
    );
sm_reset_rx_timer_clr_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => bit_synchronizer_gtwiz_reset_userclk_rx_active_inst_n_2,
      Q => sm_reset_rx_timer_clr_reg_n_0,
      S => gtwiz_reset_rx_any_sync
    );
\sm_reset_rx_timer_ctr0_inferred__0/i_\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => sm_reset_rx_timer_ctr(2),
      I1 => sm_reset_rx_timer_ctr(0),
      I2 => sm_reset_rx_timer_ctr(1),
      O => \sm_reset_rx_timer_ctr0_inferred__0/i__n_0\
    );
\sm_reset_rx_timer_ctr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => sm_reset_rx_timer_ctr(0),
      O => \sm_reset_rx_timer_ctr[0]_i_1_n_0\
    );
\sm_reset_rx_timer_ctr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => sm_reset_rx_timer_ctr(0),
      I1 => sm_reset_rx_timer_ctr(1),
      O => \sm_reset_rx_timer_ctr[1]_i_1_n_0\
    );
\sm_reset_rx_timer_ctr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => sm_reset_rx_timer_ctr(0),
      I1 => sm_reset_rx_timer_ctr(1),
      I2 => sm_reset_rx_timer_ctr(2),
      O => \sm_reset_rx_timer_ctr[2]_i_1_n_0\
    );
\sm_reset_rx_timer_ctr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_timer_ctr0_inferred__0/i__n_0\,
      D => \sm_reset_rx_timer_ctr[0]_i_1_n_0\,
      Q => sm_reset_rx_timer_ctr(0),
      R => sm_reset_rx_timer_clr_reg_n_0
    );
\sm_reset_rx_timer_ctr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_timer_ctr0_inferred__0/i__n_0\,
      D => \sm_reset_rx_timer_ctr[1]_i_1_n_0\,
      Q => sm_reset_rx_timer_ctr(1),
      R => sm_reset_rx_timer_clr_reg_n_0
    );
\sm_reset_rx_timer_ctr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => \sm_reset_rx_timer_ctr0_inferred__0/i__n_0\,
      D => \sm_reset_rx_timer_ctr[2]_i_1_n_0\,
      Q => sm_reset_rx_timer_ctr(2),
      R => sm_reset_rx_timer_clr_reg_n_0
    );
sm_reset_rx_timer_sat_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FF80"
    )
        port map (
      I0 => sm_reset_rx_timer_ctr(2),
      I1 => sm_reset_rx_timer_ctr(0),
      I2 => sm_reset_rx_timer_ctr(1),
      I3 => sm_reset_rx_timer_sat,
      I4 => sm_reset_rx_timer_clr_reg_n_0,
      O => sm_reset_rx_timer_sat_i_1_n_0
    );
sm_reset_rx_timer_sat_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => sm_reset_rx_timer_sat_i_1_n_0,
      Q => sm_reset_rx_timer_sat,
      R => '0'
    );
sm_reset_tx_pll_timer_clr_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFF3000B"
    )
        port map (
      I0 => sm_reset_tx_pll_timer_sat,
      I1 => sm_reset_tx(0),
      I2 => sm_reset_tx(1),
      I3 => sm_reset_tx(2),
      I4 => sm_reset_tx_pll_timer_clr_reg_n_0,
      O => sm_reset_tx_pll_timer_clr_i_1_n_0
    );
sm_reset_tx_pll_timer_clr_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => sm_reset_tx_pll_timer_clr_i_1_n_0,
      Q => sm_reset_tx_pll_timer_clr_reg_n_0,
      S => gtwiz_reset_tx_any_sync
    );
\sm_reset_tx_pll_timer_ctr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \sm_reset_tx_pll_timer_ctr_reg__0\(0),
      O => \p_0_in__0\(0)
    );
\sm_reset_tx_pll_timer_ctr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \sm_reset_tx_pll_timer_ctr_reg__0\(0),
      I1 => \sm_reset_tx_pll_timer_ctr_reg__0\(1),
      O => \p_0_in__0\(1)
    );
\sm_reset_tx_pll_timer_ctr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \sm_reset_tx_pll_timer_ctr_reg__0\(0),
      I1 => \sm_reset_tx_pll_timer_ctr_reg__0\(1),
      I2 => \sm_reset_tx_pll_timer_ctr_reg__0\(2),
      O => \p_0_in__0\(2)
    );
\sm_reset_tx_pll_timer_ctr[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \sm_reset_tx_pll_timer_ctr_reg__0\(1),
      I1 => \sm_reset_tx_pll_timer_ctr_reg__0\(0),
      I2 => \sm_reset_tx_pll_timer_ctr_reg__0\(2),
      I3 => \sm_reset_tx_pll_timer_ctr_reg__0\(3),
      O => \p_0_in__0\(3)
    );
\sm_reset_tx_pll_timer_ctr[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \sm_reset_tx_pll_timer_ctr_reg__0\(2),
      I1 => \sm_reset_tx_pll_timer_ctr_reg__0\(0),
      I2 => \sm_reset_tx_pll_timer_ctr_reg__0\(1),
      I3 => \sm_reset_tx_pll_timer_ctr_reg__0\(3),
      I4 => \sm_reset_tx_pll_timer_ctr_reg__0\(4),
      O => \p_0_in__0\(4)
    );
\sm_reset_tx_pll_timer_ctr[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => \sm_reset_tx_pll_timer_ctr_reg__0\(3),
      I1 => \sm_reset_tx_pll_timer_ctr_reg__0\(1),
      I2 => \sm_reset_tx_pll_timer_ctr_reg__0\(0),
      I3 => \sm_reset_tx_pll_timer_ctr_reg__0\(2),
      I4 => \sm_reset_tx_pll_timer_ctr_reg__0\(4),
      I5 => \sm_reset_tx_pll_timer_ctr_reg__0\(5),
      O => \p_0_in__0\(5)
    );
\sm_reset_tx_pll_timer_ctr[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \sm_reset_tx_pll_timer_ctr[9]_i_4_n_0\,
      I1 => \sm_reset_tx_pll_timer_ctr_reg__0\(6),
      O => \p_0_in__0\(6)
    );
\sm_reset_tx_pll_timer_ctr[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \sm_reset_tx_pll_timer_ctr[9]_i_4_n_0\,
      I1 => \sm_reset_tx_pll_timer_ctr_reg__0\(6),
      I2 => \sm_reset_tx_pll_timer_ctr_reg__0\(7),
      O => \p_0_in__0\(7)
    );
\sm_reset_tx_pll_timer_ctr[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \sm_reset_tx_pll_timer_ctr_reg__0\(6),
      I1 => \sm_reset_tx_pll_timer_ctr[9]_i_4_n_0\,
      I2 => \sm_reset_tx_pll_timer_ctr_reg__0\(7),
      I3 => \sm_reset_tx_pll_timer_ctr_reg__0\(8),
      O => \p_0_in__0\(8)
    );
\sm_reset_tx_pll_timer_ctr[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF7FFFFFFFFFFF"
    )
        port map (
      I0 => \sm_reset_tx_pll_timer_ctr_reg__0\(4),
      I1 => \sm_reset_tx_pll_timer_ctr_reg__0\(1),
      I2 => \sm_reset_tx_pll_timer_ctr_reg__0\(7),
      I3 => \sm_reset_tx_pll_timer_ctr_reg__0\(8),
      I4 => \sm_reset_tx_pll_timer_ctr_reg__0\(0),
      I5 => \sm_reset_tx_pll_timer_ctr[9]_i_3_n_0\,
      O => sel
    );
\sm_reset_tx_pll_timer_ctr[9]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \sm_reset_tx_pll_timer_ctr_reg__0\(7),
      I1 => \sm_reset_tx_pll_timer_ctr[9]_i_4_n_0\,
      I2 => \sm_reset_tx_pll_timer_ctr_reg__0\(6),
      I3 => \sm_reset_tx_pll_timer_ctr_reg__0\(8),
      I4 => \sm_reset_tx_pll_timer_ctr_reg__0\(9),
      O => \p_0_in__0\(9)
    );
\sm_reset_tx_pll_timer_ctr[9]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \sm_reset_tx_pll_timer_ctr_reg__0\(9),
      I1 => \sm_reset_tx_pll_timer_ctr_reg__0\(6),
      I2 => \sm_reset_tx_pll_timer_ctr_reg__0\(2),
      I3 => \sm_reset_tx_pll_timer_ctr_reg__0\(3),
      I4 => \sm_reset_tx_pll_timer_ctr_reg__0\(5),
      O => \sm_reset_tx_pll_timer_ctr[9]_i_3_n_0\
    );
\sm_reset_tx_pll_timer_ctr[9]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \sm_reset_tx_pll_timer_ctr_reg__0\(5),
      I1 => \sm_reset_tx_pll_timer_ctr_reg__0\(3),
      I2 => \sm_reset_tx_pll_timer_ctr_reg__0\(1),
      I3 => \sm_reset_tx_pll_timer_ctr_reg__0\(0),
      I4 => \sm_reset_tx_pll_timer_ctr_reg__0\(2),
      I5 => \sm_reset_tx_pll_timer_ctr_reg__0\(4),
      O => \sm_reset_tx_pll_timer_ctr[9]_i_4_n_0\
    );
\sm_reset_tx_pll_timer_ctr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => sel,
      D => \p_0_in__0\(0),
      Q => \sm_reset_tx_pll_timer_ctr_reg__0\(0),
      R => sm_reset_tx_pll_timer_clr_reg_n_0
    );
\sm_reset_tx_pll_timer_ctr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => sel,
      D => \p_0_in__0\(1),
      Q => \sm_reset_tx_pll_timer_ctr_reg__0\(1),
      R => sm_reset_tx_pll_timer_clr_reg_n_0
    );
\sm_reset_tx_pll_timer_ctr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => sel,
      D => \p_0_in__0\(2),
      Q => \sm_reset_tx_pll_timer_ctr_reg__0\(2),
      R => sm_reset_tx_pll_timer_clr_reg_n_0
    );
\sm_reset_tx_pll_timer_ctr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => sel,
      D => \p_0_in__0\(3),
      Q => \sm_reset_tx_pll_timer_ctr_reg__0\(3),
      R => sm_reset_tx_pll_timer_clr_reg_n_0
    );
\sm_reset_tx_pll_timer_ctr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => sel,
      D => \p_0_in__0\(4),
      Q => \sm_reset_tx_pll_timer_ctr_reg__0\(4),
      R => sm_reset_tx_pll_timer_clr_reg_n_0
    );
\sm_reset_tx_pll_timer_ctr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => sel,
      D => \p_0_in__0\(5),
      Q => \sm_reset_tx_pll_timer_ctr_reg__0\(5),
      R => sm_reset_tx_pll_timer_clr_reg_n_0
    );
\sm_reset_tx_pll_timer_ctr_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => sel,
      D => \p_0_in__0\(6),
      Q => \sm_reset_tx_pll_timer_ctr_reg__0\(6),
      R => sm_reset_tx_pll_timer_clr_reg_n_0
    );
\sm_reset_tx_pll_timer_ctr_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => sel,
      D => \p_0_in__0\(7),
      Q => \sm_reset_tx_pll_timer_ctr_reg__0\(7),
      R => sm_reset_tx_pll_timer_clr_reg_n_0
    );
\sm_reset_tx_pll_timer_ctr_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => sel,
      D => \p_0_in__0\(8),
      Q => \sm_reset_tx_pll_timer_ctr_reg__0\(8),
      R => sm_reset_tx_pll_timer_clr_reg_n_0
    );
\sm_reset_tx_pll_timer_ctr_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => sel,
      D => \p_0_in__0\(9),
      Q => \sm_reset_tx_pll_timer_ctr_reg__0\(9),
      R => sm_reset_tx_pll_timer_clr_reg_n_0
    );
sm_reset_tx_pll_timer_sat_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0D"
    )
        port map (
      I0 => sel,
      I1 => sm_reset_tx_pll_timer_sat,
      I2 => sm_reset_tx_pll_timer_clr_reg_n_0,
      O => sm_reset_tx_pll_timer_sat_i_1_n_0
    );
sm_reset_tx_pll_timer_sat_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => sm_reset_tx_pll_timer_sat_i_1_n_0,
      Q => sm_reset_tx_pll_timer_sat,
      R => '0'
    );
sm_reset_tx_timer_clr_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => bit_synchronizer_gtwiz_reset_userclk_tx_active_inst_n_1,
      Q => sm_reset_tx_timer_clr_reg_n_0,
      S => gtwiz_reset_tx_any_sync
    );
\sm_reset_tx_timer_ctr0_inferred__0/i_\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => sm_reset_tx_timer_ctr(2),
      I1 => sm_reset_tx_timer_ctr(0),
      I2 => sm_reset_tx_timer_ctr(1),
      O => p_0_in
    );
\sm_reset_tx_timer_ctr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => sm_reset_tx_timer_ctr(0),
      O => p_1_in(0)
    );
\sm_reset_tx_timer_ctr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => sm_reset_tx_timer_ctr(0),
      I1 => sm_reset_tx_timer_ctr(1),
      O => p_1_in(1)
    );
\sm_reset_tx_timer_ctr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => sm_reset_tx_timer_ctr(0),
      I1 => sm_reset_tx_timer_ctr(1),
      I2 => sm_reset_tx_timer_ctr(2),
      O => p_1_in(2)
    );
\sm_reset_tx_timer_ctr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => p_0_in,
      D => p_1_in(0),
      Q => sm_reset_tx_timer_ctr(0),
      R => sm_reset_tx_timer_clr_reg_n_0
    );
\sm_reset_tx_timer_ctr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => p_0_in,
      D => p_1_in(1),
      Q => sm_reset_tx_timer_ctr(1),
      R => sm_reset_tx_timer_clr_reg_n_0
    );
\sm_reset_tx_timer_ctr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => p_0_in,
      D => p_1_in(2),
      Q => sm_reset_tx_timer_ctr(2),
      R => sm_reset_tx_timer_clr_reg_n_0
    );
sm_reset_tx_timer_sat_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FF80"
    )
        port map (
      I0 => sm_reset_tx_timer_ctr(2),
      I1 => sm_reset_tx_timer_ctr(0),
      I2 => sm_reset_tx_timer_ctr(1),
      I3 => sm_reset_tx_timer_sat,
      I4 => sm_reset_tx_timer_clr_reg_n_0,
      O => sm_reset_tx_timer_sat_i_1_n_0
    );
sm_reset_tx_timer_sat_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => sm_reset_tx_timer_sat_i_1_n_0,
      Q => sm_reset_tx_timer_sat,
      R => '0'
    );
txuserrdy_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => gtwiz_reset_clk_freerun_in(0),
      CE => '1',
      D => bit_synchronizer_gtwiz_reset_userclk_tx_active_inst_n_0,
      Q => \^gthe3_channel_txuserrdy\(0),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_gthe3 is
  port (
    cplllock_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txsyncdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txphaligndone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gtwiz_reset_rx_cdr_stable_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    cpllfbclklost_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    cpllrefclklost_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    drprdy_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    eyescandataerror_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gthtxn_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gthtxp_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gtpowergood_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gtrefclkmonitor_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    pcierategen3_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    pcierateidle_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    pciesynctxsyncdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    pcieusergen3rdy_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    pcieuserphystatusrst_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    pcieuserratestart_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    phystatus_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    resetexception_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxbyteisaligned_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxbyterealign_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcdrlock_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcdrphdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxchanbondseq_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxchanisaligned_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxchanrealign_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcominitdet_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcommadet_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcomsasdet_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcomwakedet_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdlysresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxelecidle_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosintdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosintstarted_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosintstrobedone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosintstrobestarted_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxoutclk_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxoutclkfabric_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxoutclkpcs_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxphaligndone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxphalignerr_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxpmaresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxprbserr_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxprbslocked_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxprgdivresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxqpisenn_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxqpisenp_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxratedone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxrecclkout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxsliderdy_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxslipdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxslipoutclkrdy_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxslippmardy_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxsyncdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxsyncout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxvalid_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txcomfinish_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txdlysresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txoutclk_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txoutclkfabric_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txoutclkpcs_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txphinitdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txpmaresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txprgdivresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txqpisenn_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txqpisenp_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txratedone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txsyncout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    pcsrsvdout_out : out STD_LOGIC_VECTOR ( 83 downto 0 );
    rxdata_out : out STD_LOGIC_VECTOR ( 895 downto 0 );
    drpdo_out : out STD_LOGIC_VECTOR ( 111 downto 0 );
    rxctrl0_out : out STD_LOGIC_VECTOR ( 111 downto 0 );
    rxctrl1_out : out STD_LOGIC_VECTOR ( 111 downto 0 );
    dmonitorout_out : out STD_LOGIC_VECTOR ( 118 downto 0 );
    pcierateqpllpd_out : out STD_LOGIC_VECTOR ( 13 downto 0 );
    pcierateqpllreset_out : out STD_LOGIC_VECTOR ( 13 downto 0 );
    rxclkcorcnt_out : out STD_LOGIC_VECTOR ( 13 downto 0 );
    rxdatavalid_out : out STD_LOGIC_VECTOR ( 13 downto 0 );
    rxheadervalid_out : out STD_LOGIC_VECTOR ( 13 downto 0 );
    rxstartofseq_out : out STD_LOGIC_VECTOR ( 13 downto 0 );
    txbufstatus_out : out STD_LOGIC_VECTOR ( 13 downto 0 );
    bufgtce_out : out STD_LOGIC_VECTOR ( 20 downto 0 );
    bufgtcemask_out : out STD_LOGIC_VECTOR ( 20 downto 0 );
    bufgtreset_out : out STD_LOGIC_VECTOR ( 20 downto 0 );
    bufgtrstmask_out : out STD_LOGIC_VECTOR ( 20 downto 0 );
    rxbufstatus_out : out STD_LOGIC_VECTOR ( 20 downto 0 );
    rxstatus_out : out STD_LOGIC_VECTOR ( 20 downto 0 );
    rxchbondo_out : out STD_LOGIC_VECTOR ( 34 downto 0 );
    rxheader_out : out STD_LOGIC_VECTOR ( 41 downto 0 );
    rxmonitorout_out : out STD_LOGIC_VECTOR ( 48 downto 0 );
    pinrsrvdas_out : out STD_LOGIC_VECTOR ( 55 downto 0 );
    rxctrl2_out : out STD_LOGIC_VECTOR ( 55 downto 0 );
    rxctrl3_out : out STD_LOGIC_VECTOR ( 55 downto 0 );
    rxdataextendrsvd_out : out STD_LOGIC_VECTOR ( 55 downto 0 );
    bufgtdiv_out : out STD_LOGIC_VECTOR ( 62 downto 0 );
    gtwiz_reset_tx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_tx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_tx_error_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_tx_start_user_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_tx_reset_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    txusrclk2_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtwiz_userclk_tx_active_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_userclk_rx_active_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    cfgreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    clkrsvd0_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    clkrsvd1_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    cplllockdetclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    cplllocken_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    cpllreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    dmonfiforeset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    dmonitorclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    drpclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    drpen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    drpwe_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    evoddphicaldone_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    evoddphicalstart_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    evoddphidrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    evoddphidwren_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    evoddphixrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    evoddphixwren_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    eyescanmode_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    eyescanreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    eyescantrigger_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtgrefclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gthrxn_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gthrxp_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtnorthrefclk0_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtnorthrefclk1_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtrefclk0_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtrefclk1_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtresetsel_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtsouthrefclk0_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtsouthrefclk1_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    lpbkrxtxseren_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    lpbktxrxseren_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    pcieeqrxeqadaptdone_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    pcierstidle_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    pciersttxsyncstart_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    pcieuserratedone_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    qpll0clk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    qpll0refclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    qpll1clk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    qpll1refclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    resetovrd_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rstclkentx_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rx8b10ben_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxbufreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcdrfreqreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcdrhold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcdrovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcdrreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcdrresetrsv_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxchbonden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxchbondmaster_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxchbondslave_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcommadeten_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfeagchold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfeagcovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfelfhold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfelfovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfelpmreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap10hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap10ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap11hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap11ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap12hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap12ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap13hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap13ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap14hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap14ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap15hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap15ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap2hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap2ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap3hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap3ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap4hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap4ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap5hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap5ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap6hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap6ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap7hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap7ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap8hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap8ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap9hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap9ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfeuthold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfeutovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfevphold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfevpovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfevsen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfexyden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdlybypass_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdlyen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdlyovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdlysreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxgearboxslip_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlatclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmgchold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmgcovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmhfhold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmhfovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmlfhold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmlfklovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmoshold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmosovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxmcommaalignen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxoobreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxoscalreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxoshold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosinten_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosinthold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosintovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosintstrobe_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosinttestovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxpcommaalignen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxpcsreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxphalign_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxphalignen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxphdlypd_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxphdlyreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxphovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxpmareset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxpolarity_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxprbscntreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxqpien_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxratemode_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxslide_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxslipoutclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxslippma_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxsyncallin_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxsyncin_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxsyncmode_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxusrclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxusrclk2_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    sigvalidclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    tx8b10ben_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txcominit_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txcomsas_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txcomwake_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txdeemph_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txdetectrx_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txdiffpd_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txelecidle_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txinhibit_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txlatclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpcsreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpdelecidlemode_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpippmen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpippmovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpippmpd_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpippmsel_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpisopd_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpmareset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpolarity_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpostcursorinv_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txprbsforceerr_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txprecursorinv_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txqpibiasen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txqpistrongpdown_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txqpiweakpup_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txratemode_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txswing_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txusrclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtwiz_userdata_tx_in : in STD_LOGIC_VECTOR ( 223 downto 0 );
    drpdi_in : in STD_LOGIC_VECTOR ( 111 downto 0 );
    gtrsvd_in : in STD_LOGIC_VECTOR ( 111 downto 0 );
    pcsrsvdin_in : in STD_LOGIC_VECTOR ( 111 downto 0 );
    txctrl0_in : in STD_LOGIC_VECTOR ( 111 downto 0 );
    txctrl1_in : in STD_LOGIC_VECTOR ( 111 downto 0 );
    rxdfeagcctrl_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    rxelecidlemode_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    rxmonitorsel_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    rxpd_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    rxpllclksel_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    rxsysclksel_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    txpd_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    txpllclksel_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    txsysclksel_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    cpllrefclksel_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    loopback_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    rxchbondlevel_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    rxoutclksel_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    rxrate_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    txbufdiffctrl_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    txmargin_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    txoutclksel_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    txrate_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    rxosintcfg_in : in STD_LOGIC_VECTOR ( 27 downto 0 );
    rxprbssel_in : in STD_LOGIC_VECTOR ( 27 downto 0 );
    txdiffctrl_in : in STD_LOGIC_VECTOR ( 27 downto 0 );
    txprbssel_in : in STD_LOGIC_VECTOR ( 27 downto 0 );
    pcsrsvdin2_in : in STD_LOGIC_VECTOR ( 34 downto 0 );
    pmarsvdin_in : in STD_LOGIC_VECTOR ( 34 downto 0 );
    rxchbondi_in : in STD_LOGIC_VECTOR ( 34 downto 0 );
    txpippmstepsize_in : in STD_LOGIC_VECTOR ( 34 downto 0 );
    txpostcursor_in : in STD_LOGIC_VECTOR ( 34 downto 0 );
    txprecursor_in : in STD_LOGIC_VECTOR ( 34 downto 0 );
    txheader_in : in STD_LOGIC_VECTOR ( 41 downto 0 );
    txmaincursor_in : in STD_LOGIC_VECTOR ( 48 downto 0 );
    txsequence_in : in STD_LOGIC_VECTOR ( 48 downto 0 );
    tx8b10bbypass_in : in STD_LOGIC_VECTOR ( 55 downto 0 );
    txctrl2_in : in STD_LOGIC_VECTOR ( 55 downto 0 );
    txdataextendrsvd_in : in STD_LOGIC_VECTOR ( 55 downto 0 );
    drpaddr_in : in STD_LOGIC_VECTOR ( 62 downto 0 );
    gtwiz_reset_all_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_pll_and_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_pll_and_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_gthe3 : entity is "JesdCryoCoreRightColumn_gtwizard_gthe3";
end JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_gthe3;

architecture STRUCTURE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_gthe3 is
  signal \^cplllock_out\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \gen_gtwizard_gthe3.gen_channel_container[24].gen_enabled_channel.gthe3_channel_wrapper_inst_n_0\ : STD_LOGIC;
  signal \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[1].bit_synchronizer_rxresetdone_inst_n_0\ : STD_LOGIC;
  signal \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[1].bit_synchronizer_txresetdone_inst_n_0\ : STD_LOGIC;
  signal \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[5].bit_synchronizer_rxresetdone_inst_n_1\ : STD_LOGIC;
  signal \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[5].bit_synchronizer_txresetdone_inst_n_1\ : STD_LOGIC;
  signal \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gtwiz_reset_inst_n_10\ : STD_LOGIC;
  signal \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gtwiz_reset_inst_n_9\ : STD_LOGIC;
  signal \^gtpowergood_out\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \gtwiz_reset_gtpowergood_int__0\ : STD_LOGIC;
  signal gtwiz_reset_gtrxreset_int : STD_LOGIC;
  signal gtwiz_reset_gttxreset_int : STD_LOGIC;
  signal gtwiz_reset_plllock_tx_int : STD_LOGIC;
  signal \gtwiz_reset_rxcdrlock_int__0\ : STD_LOGIC;
  signal gtwiz_reset_rxprogdivreset_int : STD_LOGIC;
  signal gtwiz_reset_rxuserrdy_int : STD_LOGIC;
  signal gtwiz_reset_txprogdivreset_int : STD_LOGIC;
  signal gtwiz_reset_txuserrdy_int : STD_LOGIC;
  signal \i_in_inferred_i_2__0_n_0\ : STD_LOGIC;
  signal i_in_inferred_i_2_n_0 : STD_LOGIC;
  signal rst_in0 : STD_LOGIC;
  signal \^rxcdrlock_out\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \^rxresetdone_out\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal rxresetdone_sync : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal txdlysreset_int : STD_LOGIC_VECTOR ( 6 to 6 );
  signal \^txphaligndone_out\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \^txresetdone_out\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal txresetdone_sync : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal txsyncallin_int : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^txsyncdone_out\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \^txsyncout_out\ : STD_LOGIC_VECTOR ( 6 downto 0 );
begin
  cplllock_out(6 downto 0) <= \^cplllock_out\(6 downto 0);
  gtpowergood_out(6 downto 0) <= \^gtpowergood_out\(6 downto 0);
  rxcdrlock_out(6 downto 0) <= \^rxcdrlock_out\(6 downto 0);
  rxresetdone_out(6 downto 0) <= \^rxresetdone_out\(6 downto 0);
  txphaligndone_out(6 downto 0) <= \^txphaligndone_out\(6 downto 0);
  txresetdone_out(6 downto 0) <= \^txresetdone_out\(6 downto 0);
  txsyncdone_out(6 downto 0) <= \^txsyncdone_out\(6 downto 0);
  txsyncout_out(6 downto 0) <= \^txsyncout_out\(6 downto 0);
\gen_gtwizard_gthe3.gen_channel_container[24].gen_enabled_channel.gthe3_channel_wrapper_inst\: entity work.JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gthe3_channel_wrapper
     port map (
      GTHE3_CHANNEL_CPLLPD(0) => \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gtwiz_reset_inst_n_9\,
      GTHE3_CHANNEL_GTRXRESET(0) => gtwiz_reset_gtrxreset_int,
      GTHE3_CHANNEL_GTTXRESET(0) => gtwiz_reset_gttxreset_int,
      GTHE3_CHANNEL_RXPROGDIVRESET(0) => gtwiz_reset_rxprogdivreset_int,
      GTHE3_CHANNEL_RXUSERRDY(0) => gtwiz_reset_rxuserrdy_int,
      GTHE3_CHANNEL_TXDLYSRESET(0) => txdlysreset_int(6),
      GTHE3_CHANNEL_TXPROGDIVRESET(0) => gtwiz_reset_txprogdivreset_int,
      GTHE3_CHANNEL_TXSYNCALLIN(0) => txsyncallin_int(0),
      GTHE3_CHANNEL_TXUSERRDY(0) => gtwiz_reset_txuserrdy_int,
      bufgtce_out(8 downto 0) => bufgtce_out(8 downto 0),
      bufgtcemask_out(8 downto 0) => bufgtcemask_out(8 downto 0),
      bufgtdiv_out(26 downto 0) => bufgtdiv_out(26 downto 0),
      bufgtreset_out(8 downto 0) => bufgtreset_out(8 downto 0),
      bufgtrstmask_out(8 downto 0) => bufgtrstmask_out(8 downto 0),
      cfgreset_in(2 downto 0) => cfgreset_in(2 downto 0),
      clkrsvd0_in(2 downto 0) => clkrsvd0_in(2 downto 0),
      clkrsvd1_in(2 downto 0) => clkrsvd1_in(2 downto 0),
      cpllfbclklost_out(2 downto 0) => cpllfbclklost_out(2 downto 0),
      cplllock_out(2 downto 0) => \^cplllock_out\(2 downto 0),
      cplllockdetclk_in(2 downto 0) => cplllockdetclk_in(2 downto 0),
      cplllocken_in(2 downto 0) => cplllocken_in(2 downto 0),
      cpllrefclklost_out(2 downto 0) => cpllrefclklost_out(2 downto 0),
      cpllrefclksel_in(8 downto 0) => cpllrefclksel_in(8 downto 0),
      cpllreset_in(2 downto 0) => cpllreset_in(2 downto 0),
      dmonfiforeset_in(2 downto 0) => dmonfiforeset_in(2 downto 0),
      dmonitorclk_in(2 downto 0) => dmonitorclk_in(2 downto 0),
      dmonitorout_out(50 downto 0) => dmonitorout_out(50 downto 0),
      drpaddr_in(26 downto 0) => drpaddr_in(26 downto 0),
      drpclk_in(2 downto 0) => drpclk_in(2 downto 0),
      drpdi_in(47 downto 0) => drpdi_in(47 downto 0),
      drpdo_out(47 downto 0) => drpdo_out(47 downto 0),
      drpen_in(2 downto 0) => drpen_in(2 downto 0),
      drprdy_out(2 downto 0) => drprdy_out(2 downto 0),
      drpwe_in(2 downto 0) => drpwe_in(2 downto 0),
      evoddphicaldone_in(2 downto 0) => evoddphicaldone_in(2 downto 0),
      evoddphicalstart_in(2 downto 0) => evoddphicalstart_in(2 downto 0),
      evoddphidrden_in(2 downto 0) => evoddphidrden_in(2 downto 0),
      evoddphidwren_in(2 downto 0) => evoddphidwren_in(2 downto 0),
      evoddphixrden_in(2 downto 0) => evoddphixrden_in(2 downto 0),
      evoddphixwren_in(2 downto 0) => evoddphixwren_in(2 downto 0),
      eyescandataerror_out(2 downto 0) => eyescandataerror_out(2 downto 0),
      eyescanmode_in(2 downto 0) => eyescanmode_in(2 downto 0),
      eyescanreset_in(2 downto 0) => eyescanreset_in(2 downto 0),
      eyescantrigger_in(2 downto 0) => eyescantrigger_in(2 downto 0),
      gtgrefclk_in(2 downto 0) => gtgrefclk_in(2 downto 0),
      gthrxn_in(2 downto 0) => gthrxn_in(2 downto 0),
      gthrxp_in(2 downto 0) => gthrxp_in(2 downto 0),
      gthtxn_out(2 downto 0) => gthtxn_out(2 downto 0),
      gthtxp_out(2 downto 0) => gthtxp_out(2 downto 0),
      gtnorthrefclk0_in(2 downto 0) => gtnorthrefclk0_in(2 downto 0),
      gtnorthrefclk1_in(2 downto 0) => gtnorthrefclk1_in(2 downto 0),
      gtpowergood_out(2 downto 0) => \^gtpowergood_out\(2 downto 0),
      gtrefclk0_in(2 downto 0) => gtrefclk0_in(2 downto 0),
      gtrefclk1_in(2 downto 0) => gtrefclk1_in(2 downto 0),
      gtrefclkmonitor_out(2 downto 0) => gtrefclkmonitor_out(2 downto 0),
      gtresetsel_in(2 downto 0) => gtresetsel_in(2 downto 0),
      gtrsvd_in(47 downto 0) => gtrsvd_in(47 downto 0),
      gtrxreset_out_reg(0) => \^cplllock_out\(3),
      gtrxreset_out_reg_0(0) => \^txsyncout_out\(6),
      gtsouthrefclk0_in(2 downto 0) => gtsouthrefclk0_in(2 downto 0),
      gtsouthrefclk1_in(2 downto 0) => gtsouthrefclk1_in(2 downto 0),
      gtwiz_userdata_tx_in(95 downto 0) => gtwiz_userdata_tx_in(95 downto 0),
      loopback_in(8 downto 0) => loopback_in(8 downto 0),
      lpbkrxtxseren_in(2 downto 0) => lpbkrxtxseren_in(2 downto 0),
      lpbktxrxseren_in(2 downto 0) => lpbktxrxseren_in(2 downto 0),
      pcieeqrxeqadaptdone_in(2 downto 0) => pcieeqrxeqadaptdone_in(2 downto 0),
      pcierategen3_out(2 downto 0) => pcierategen3_out(2 downto 0),
      pcierateidle_out(2 downto 0) => pcierateidle_out(2 downto 0),
      pcierateqpllpd_out(5 downto 0) => pcierateqpllpd_out(5 downto 0),
      pcierateqpllreset_out(5 downto 0) => pcierateqpllreset_out(5 downto 0),
      pcierstidle_in(2 downto 0) => pcierstidle_in(2 downto 0),
      pciersttxsyncstart_in(2 downto 0) => pciersttxsyncstart_in(2 downto 0),
      pciesynctxsyncdone_out(2 downto 0) => pciesynctxsyncdone_out(2 downto 0),
      pcieusergen3rdy_out(2 downto 0) => pcieusergen3rdy_out(2 downto 0),
      pcieuserphystatusrst_out(2 downto 0) => pcieuserphystatusrst_out(2 downto 0),
      pcieuserratedone_in(2 downto 0) => pcieuserratedone_in(2 downto 0),
      pcieuserratestart_out(2 downto 0) => pcieuserratestart_out(2 downto 0),
      pcsrsvdin2_in(14 downto 0) => pcsrsvdin2_in(14 downto 0),
      pcsrsvdin_in(47 downto 0) => pcsrsvdin_in(47 downto 0),
      pcsrsvdout_out(35 downto 0) => pcsrsvdout_out(35 downto 0),
      phystatus_out(2 downto 0) => phystatus_out(2 downto 0),
      pinrsrvdas_out(23 downto 0) => pinrsrvdas_out(23 downto 0),
      pmarsvdin_in(14 downto 0) => pmarsvdin_in(14 downto 0),
      qpll0clk_in(2 downto 0) => qpll0clk_in(2 downto 0),
      qpll0refclk_in(2 downto 0) => qpll0refclk_in(2 downto 0),
      qpll1clk_in(2 downto 0) => qpll1clk_in(2 downto 0),
      qpll1refclk_in(2 downto 0) => qpll1refclk_in(2 downto 0),
      resetexception_out(2 downto 0) => resetexception_out(2 downto 0),
      resetovrd_in(2 downto 0) => resetovrd_in(2 downto 0),
      rst_in_out_reg => \gen_gtwizard_gthe3.gen_channel_container[24].gen_enabled_channel.gthe3_channel_wrapper_inst_n_0\,
      rstclkentx_in(2 downto 0) => rstclkentx_in(2 downto 0),
      rx8b10ben_in(2 downto 0) => rx8b10ben_in(2 downto 0),
      rxbufreset_in(2 downto 0) => rxbufreset_in(2 downto 0),
      rxbufstatus_out(8 downto 0) => rxbufstatus_out(8 downto 0),
      rxbyteisaligned_out(2 downto 0) => rxbyteisaligned_out(2 downto 0),
      rxbyterealign_out(2 downto 0) => rxbyterealign_out(2 downto 0),
      rxcdrfreqreset_in(2 downto 0) => rxcdrfreqreset_in(2 downto 0),
      rxcdrhold_in(2 downto 0) => rxcdrhold_in(2 downto 0),
      rxcdrlock_out(2 downto 0) => \^rxcdrlock_out\(2 downto 0),
      rxcdrovrden_in(2 downto 0) => rxcdrovrden_in(2 downto 0),
      rxcdrphdone_out(2 downto 0) => rxcdrphdone_out(2 downto 0),
      rxcdrreset_in(2 downto 0) => rxcdrreset_in(2 downto 0),
      rxcdrresetrsv_in(2 downto 0) => rxcdrresetrsv_in(2 downto 0),
      rxchanbondseq_out(2 downto 0) => rxchanbondseq_out(2 downto 0),
      rxchanisaligned_out(2 downto 0) => rxchanisaligned_out(2 downto 0),
      rxchanrealign_out(2 downto 0) => rxchanrealign_out(2 downto 0),
      rxchbonden_in(2 downto 0) => rxchbonden_in(2 downto 0),
      rxchbondi_in(14 downto 0) => rxchbondi_in(14 downto 0),
      rxchbondlevel_in(8 downto 0) => rxchbondlevel_in(8 downto 0),
      rxchbondmaster_in(2 downto 0) => rxchbondmaster_in(2 downto 0),
      rxchbondo_out(14 downto 0) => rxchbondo_out(14 downto 0),
      rxchbondslave_in(2 downto 0) => rxchbondslave_in(2 downto 0),
      rxclkcorcnt_out(5 downto 0) => rxclkcorcnt_out(5 downto 0),
      rxcominitdet_out(2 downto 0) => rxcominitdet_out(2 downto 0),
      rxcommadet_out(2 downto 0) => rxcommadet_out(2 downto 0),
      rxcommadeten_in(2 downto 0) => rxcommadeten_in(2 downto 0),
      rxcomsasdet_out(2 downto 0) => rxcomsasdet_out(2 downto 0),
      rxcomwakedet_out(2 downto 0) => rxcomwakedet_out(2 downto 0),
      rxctrl0_out(47 downto 0) => rxctrl0_out(47 downto 0),
      rxctrl1_out(47 downto 0) => rxctrl1_out(47 downto 0),
      rxctrl2_out(23 downto 0) => rxctrl2_out(23 downto 0),
      rxctrl3_out(23 downto 0) => rxctrl3_out(23 downto 0),
      rxdata_out(383 downto 0) => rxdata_out(383 downto 0),
      rxdataextendrsvd_out(23 downto 0) => rxdataextendrsvd_out(23 downto 0),
      rxdatavalid_out(5 downto 0) => rxdatavalid_out(5 downto 0),
      rxdfeagcctrl_in(5 downto 0) => rxdfeagcctrl_in(5 downto 0),
      rxdfeagchold_in(2 downto 0) => rxdfeagchold_in(2 downto 0),
      rxdfeagcovrden_in(2 downto 0) => rxdfeagcovrden_in(2 downto 0),
      rxdfelfhold_in(2 downto 0) => rxdfelfhold_in(2 downto 0),
      rxdfelfovrden_in(2 downto 0) => rxdfelfovrden_in(2 downto 0),
      rxdfelpmreset_in(2 downto 0) => rxdfelpmreset_in(2 downto 0),
      rxdfetap10hold_in(2 downto 0) => rxdfetap10hold_in(2 downto 0),
      rxdfetap10ovrden_in(2 downto 0) => rxdfetap10ovrden_in(2 downto 0),
      rxdfetap11hold_in(2 downto 0) => rxdfetap11hold_in(2 downto 0),
      rxdfetap11ovrden_in(2 downto 0) => rxdfetap11ovrden_in(2 downto 0),
      rxdfetap12hold_in(2 downto 0) => rxdfetap12hold_in(2 downto 0),
      rxdfetap12ovrden_in(2 downto 0) => rxdfetap12ovrden_in(2 downto 0),
      rxdfetap13hold_in(2 downto 0) => rxdfetap13hold_in(2 downto 0),
      rxdfetap13ovrden_in(2 downto 0) => rxdfetap13ovrden_in(2 downto 0),
      rxdfetap14hold_in(2 downto 0) => rxdfetap14hold_in(2 downto 0),
      rxdfetap14ovrden_in(2 downto 0) => rxdfetap14ovrden_in(2 downto 0),
      rxdfetap15hold_in(2 downto 0) => rxdfetap15hold_in(2 downto 0),
      rxdfetap15ovrden_in(2 downto 0) => rxdfetap15ovrden_in(2 downto 0),
      rxdfetap2hold_in(2 downto 0) => rxdfetap2hold_in(2 downto 0),
      rxdfetap2ovrden_in(2 downto 0) => rxdfetap2ovrden_in(2 downto 0),
      rxdfetap3hold_in(2 downto 0) => rxdfetap3hold_in(2 downto 0),
      rxdfetap3ovrden_in(2 downto 0) => rxdfetap3ovrden_in(2 downto 0),
      rxdfetap4hold_in(2 downto 0) => rxdfetap4hold_in(2 downto 0),
      rxdfetap4ovrden_in(2 downto 0) => rxdfetap4ovrden_in(2 downto 0),
      rxdfetap5hold_in(2 downto 0) => rxdfetap5hold_in(2 downto 0),
      rxdfetap5ovrden_in(2 downto 0) => rxdfetap5ovrden_in(2 downto 0),
      rxdfetap6hold_in(2 downto 0) => rxdfetap6hold_in(2 downto 0),
      rxdfetap6ovrden_in(2 downto 0) => rxdfetap6ovrden_in(2 downto 0),
      rxdfetap7hold_in(2 downto 0) => rxdfetap7hold_in(2 downto 0),
      rxdfetap7ovrden_in(2 downto 0) => rxdfetap7ovrden_in(2 downto 0),
      rxdfetap8hold_in(2 downto 0) => rxdfetap8hold_in(2 downto 0),
      rxdfetap8ovrden_in(2 downto 0) => rxdfetap8ovrden_in(2 downto 0),
      rxdfetap9hold_in(2 downto 0) => rxdfetap9hold_in(2 downto 0),
      rxdfetap9ovrden_in(2 downto 0) => rxdfetap9ovrden_in(2 downto 0),
      rxdfeuthold_in(2 downto 0) => rxdfeuthold_in(2 downto 0),
      rxdfeutovrden_in(2 downto 0) => rxdfeutovrden_in(2 downto 0),
      rxdfevphold_in(2 downto 0) => rxdfevphold_in(2 downto 0),
      rxdfevpovrden_in(2 downto 0) => rxdfevpovrden_in(2 downto 0),
      rxdfevsen_in(2 downto 0) => rxdfevsen_in(2 downto 0),
      rxdfexyden_in(2 downto 0) => rxdfexyden_in(2 downto 0),
      rxdlybypass_in(2 downto 0) => rxdlybypass_in(2 downto 0),
      rxdlyen_in(2 downto 0) => rxdlyen_in(2 downto 0),
      rxdlyovrden_in(2 downto 0) => rxdlyovrden_in(2 downto 0),
      rxdlysreset_in(2 downto 0) => rxdlysreset_in(2 downto 0),
      rxdlysresetdone_out(2 downto 0) => rxdlysresetdone_out(2 downto 0),
      rxelecidle_out(2 downto 0) => rxelecidle_out(2 downto 0),
      rxelecidlemode_in(5 downto 0) => rxelecidlemode_in(5 downto 0),
      rxgearboxslip_in(2 downto 0) => rxgearboxslip_in(2 downto 0),
      rxheader_out(17 downto 0) => rxheader_out(17 downto 0),
      rxheadervalid_out(5 downto 0) => rxheadervalid_out(5 downto 0),
      rxlatclk_in(2 downto 0) => rxlatclk_in(2 downto 0),
      rxlpmen_in(2 downto 0) => rxlpmen_in(2 downto 0),
      rxlpmgchold_in(2 downto 0) => rxlpmgchold_in(2 downto 0),
      rxlpmgcovrden_in(2 downto 0) => rxlpmgcovrden_in(2 downto 0),
      rxlpmhfhold_in(2 downto 0) => rxlpmhfhold_in(2 downto 0),
      rxlpmhfovrden_in(2 downto 0) => rxlpmhfovrden_in(2 downto 0),
      rxlpmlfhold_in(2 downto 0) => rxlpmlfhold_in(2 downto 0),
      rxlpmlfklovrden_in(2 downto 0) => rxlpmlfklovrden_in(2 downto 0),
      rxlpmoshold_in(2 downto 0) => rxlpmoshold_in(2 downto 0),
      rxlpmosovrden_in(2 downto 0) => rxlpmosovrden_in(2 downto 0),
      rxmcommaalignen_in(2 downto 0) => rxmcommaalignen_in(2 downto 0),
      rxmonitorout_out(20 downto 0) => rxmonitorout_out(20 downto 0),
      rxmonitorsel_in(5 downto 0) => rxmonitorsel_in(5 downto 0),
      rxoobreset_in(2 downto 0) => rxoobreset_in(2 downto 0),
      rxoscalreset_in(2 downto 0) => rxoscalreset_in(2 downto 0),
      rxoshold_in(2 downto 0) => rxoshold_in(2 downto 0),
      rxosintcfg_in(11 downto 0) => rxosintcfg_in(11 downto 0),
      rxosintdone_out(2 downto 0) => rxosintdone_out(2 downto 0),
      rxosinten_in(2 downto 0) => rxosinten_in(2 downto 0),
      rxosinthold_in(2 downto 0) => rxosinthold_in(2 downto 0),
      rxosintovrden_in(2 downto 0) => rxosintovrden_in(2 downto 0),
      rxosintstarted_out(2 downto 0) => rxosintstarted_out(2 downto 0),
      rxosintstrobe_in(2 downto 0) => rxosintstrobe_in(2 downto 0),
      rxosintstrobedone_out(2 downto 0) => rxosintstrobedone_out(2 downto 0),
      rxosintstrobestarted_out(2 downto 0) => rxosintstrobestarted_out(2 downto 0),
      rxosinttestovrden_in(2 downto 0) => rxosinttestovrden_in(2 downto 0),
      rxosovrden_in(2 downto 0) => rxosovrden_in(2 downto 0),
      rxoutclk_out(2 downto 0) => rxoutclk_out(2 downto 0),
      rxoutclkfabric_out(2 downto 0) => rxoutclkfabric_out(2 downto 0),
      rxoutclkpcs_out(2 downto 0) => rxoutclkpcs_out(2 downto 0),
      rxoutclksel_in(8 downto 0) => rxoutclksel_in(8 downto 0),
      rxpcommaalignen_in(2 downto 0) => rxpcommaalignen_in(2 downto 0),
      rxpcsreset_in(2 downto 0) => rxpcsreset_in(2 downto 0),
      rxpd_in(5 downto 0) => rxpd_in(5 downto 0),
      rxphalign_in(2 downto 0) => rxphalign_in(2 downto 0),
      rxphaligndone_out(2 downto 0) => rxphaligndone_out(2 downto 0),
      rxphalignen_in(2 downto 0) => rxphalignen_in(2 downto 0),
      rxphalignerr_out(2 downto 0) => rxphalignerr_out(2 downto 0),
      rxphdlypd_in(2 downto 0) => rxphdlypd_in(2 downto 0),
      rxphdlyreset_in(2 downto 0) => rxphdlyreset_in(2 downto 0),
      rxphovrden_in(2 downto 0) => rxphovrden_in(2 downto 0),
      rxpllclksel_in(5 downto 0) => rxpllclksel_in(5 downto 0),
      rxpmareset_in(2 downto 0) => rxpmareset_in(2 downto 0),
      rxpmaresetdone_out(2 downto 0) => rxpmaresetdone_out(2 downto 0),
      rxpolarity_in(2 downto 0) => rxpolarity_in(2 downto 0),
      rxprbscntreset_in(2 downto 0) => rxprbscntreset_in(2 downto 0),
      rxprbserr_out(2 downto 0) => rxprbserr_out(2 downto 0),
      rxprbslocked_out(2 downto 0) => rxprbslocked_out(2 downto 0),
      rxprbssel_in(11 downto 0) => rxprbssel_in(11 downto 0),
      rxprgdivresetdone_out(2 downto 0) => rxprgdivresetdone_out(2 downto 0),
      rxqpien_in(2 downto 0) => rxqpien_in(2 downto 0),
      rxqpisenn_out(2 downto 0) => rxqpisenn_out(2 downto 0),
      rxqpisenp_out(2 downto 0) => rxqpisenp_out(2 downto 0),
      rxrate_in(8 downto 0) => rxrate_in(8 downto 0),
      rxratedone_out(2 downto 0) => rxratedone_out(2 downto 0),
      rxratemode_in(2 downto 0) => rxratemode_in(2 downto 0),
      rxrecclkout_out(2 downto 0) => rxrecclkout_out(2 downto 0),
      rxresetdone_out(2 downto 0) => \^rxresetdone_out\(2 downto 0),
      rxslide_in(2 downto 0) => rxslide_in(2 downto 0),
      rxsliderdy_out(2 downto 0) => rxsliderdy_out(2 downto 0),
      rxslipdone_out(2 downto 0) => rxslipdone_out(2 downto 0),
      rxslipoutclk_in(2 downto 0) => rxslipoutclk_in(2 downto 0),
      rxslipoutclkrdy_out(2 downto 0) => rxslipoutclkrdy_out(2 downto 0),
      rxslippma_in(2 downto 0) => rxslippma_in(2 downto 0),
      rxslippmardy_out(2 downto 0) => rxslippmardy_out(2 downto 0),
      rxstartofseq_out(5 downto 0) => rxstartofseq_out(5 downto 0),
      rxstatus_out(8 downto 0) => rxstatus_out(8 downto 0),
      rxsyncallin_in(2 downto 0) => rxsyncallin_in(2 downto 0),
      rxsyncdone_out(2 downto 0) => rxsyncdone_out(2 downto 0),
      rxsyncin_in(2 downto 0) => rxsyncin_in(2 downto 0),
      rxsyncmode_in(2 downto 0) => rxsyncmode_in(2 downto 0),
      rxsyncout_out(2 downto 0) => rxsyncout_out(2 downto 0),
      rxsysclksel_in(5 downto 0) => rxsysclksel_in(5 downto 0),
      rxusrclk2_in(2 downto 0) => rxusrclk2_in(2 downto 0),
      rxusrclk_in(2 downto 0) => rxusrclk_in(2 downto 0),
      rxvalid_out(2 downto 0) => rxvalid_out(2 downto 0),
      sigvalidclk_in(2 downto 0) => sigvalidclk_in(2 downto 0),
      tx8b10bbypass_in(23 downto 0) => tx8b10bbypass_in(23 downto 0),
      tx8b10ben_in(2 downto 0) => tx8b10ben_in(2 downto 0),
      txbufdiffctrl_in(8 downto 0) => txbufdiffctrl_in(8 downto 0),
      txbufstatus_out(5 downto 0) => txbufstatus_out(5 downto 0),
      txcomfinish_out(2 downto 0) => txcomfinish_out(2 downto 0),
      txcominit_in(2 downto 0) => txcominit_in(2 downto 0),
      txcomsas_in(2 downto 0) => txcomsas_in(2 downto 0),
      txcomwake_in(2 downto 0) => txcomwake_in(2 downto 0),
      txctrl0_in(47 downto 0) => txctrl0_in(47 downto 0),
      txctrl1_in(47 downto 0) => txctrl1_in(47 downto 0),
      txctrl2_in(23 downto 0) => txctrl2_in(23 downto 0),
      txdataextendrsvd_in(23 downto 0) => txdataextendrsvd_in(23 downto 0),
      txdeemph_in(2 downto 0) => txdeemph_in(2 downto 0),
      txdetectrx_in(2 downto 0) => txdetectrx_in(2 downto 0),
      txdiffctrl_in(11 downto 0) => txdiffctrl_in(11 downto 0),
      txdiffpd_in(2 downto 0) => txdiffpd_in(2 downto 0),
      txdlysresetdone_out(2 downto 0) => txdlysresetdone_out(2 downto 0),
      txelecidle_in(2 downto 0) => txelecidle_in(2 downto 0),
      txheader_in(17 downto 0) => txheader_in(17 downto 0),
      txinhibit_in(2 downto 0) => txinhibit_in(2 downto 0),
      txlatclk_in(2 downto 0) => txlatclk_in(2 downto 0),
      txmaincursor_in(20 downto 0) => txmaincursor_in(20 downto 0),
      txmargin_in(8 downto 0) => txmargin_in(8 downto 0),
      txoutclk_out(2 downto 0) => txoutclk_out(2 downto 0),
      txoutclkfabric_out(2 downto 0) => txoutclkfabric_out(2 downto 0),
      txoutclkpcs_out(2 downto 0) => txoutclkpcs_out(2 downto 0),
      txoutclksel_in(8 downto 0) => txoutclksel_in(8 downto 0),
      txpcsreset_in(2 downto 0) => txpcsreset_in(2 downto 0),
      txpd_in(5 downto 0) => txpd_in(5 downto 0),
      txpdelecidlemode_in(2 downto 0) => txpdelecidlemode_in(2 downto 0),
      txphaligndone_out(2 downto 0) => \^txphaligndone_out\(2 downto 0),
      txphinitdone_out(2 downto 0) => txphinitdone_out(2 downto 0),
      txpippmen_in(2 downto 0) => txpippmen_in(2 downto 0),
      txpippmovrden_in(2 downto 0) => txpippmovrden_in(2 downto 0),
      txpippmpd_in(2 downto 0) => txpippmpd_in(2 downto 0),
      txpippmsel_in(2 downto 0) => txpippmsel_in(2 downto 0),
      txpippmstepsize_in(14 downto 0) => txpippmstepsize_in(14 downto 0),
      txpisopd_in(2 downto 0) => txpisopd_in(2 downto 0),
      txpllclksel_in(5 downto 0) => txpllclksel_in(5 downto 0),
      txpmareset_in(2 downto 0) => txpmareset_in(2 downto 0),
      txpmaresetdone_out(2 downto 0) => txpmaresetdone_out(2 downto 0),
      txpolarity_in(2 downto 0) => txpolarity_in(2 downto 0),
      txpostcursor_in(14 downto 0) => txpostcursor_in(14 downto 0),
      txpostcursorinv_in(2 downto 0) => txpostcursorinv_in(2 downto 0),
      txprbsforceerr_in(2 downto 0) => txprbsforceerr_in(2 downto 0),
      txprbssel_in(11 downto 0) => txprbssel_in(11 downto 0),
      txprecursor_in(14 downto 0) => txprecursor_in(14 downto 0),
      txprecursorinv_in(2 downto 0) => txprecursorinv_in(2 downto 0),
      txprgdivresetdone_out(2 downto 0) => txprgdivresetdone_out(2 downto 0),
      txqpibiasen_in(2 downto 0) => txqpibiasen_in(2 downto 0),
      txqpisenn_out(2 downto 0) => txqpisenn_out(2 downto 0),
      txqpisenp_out(2 downto 0) => txqpisenp_out(2 downto 0),
      txqpistrongpdown_in(2 downto 0) => txqpistrongpdown_in(2 downto 0),
      txqpiweakpup_in(2 downto 0) => txqpiweakpup_in(2 downto 0),
      txrate_in(8 downto 0) => txrate_in(8 downto 0),
      txratedone_out(2 downto 0) => txratedone_out(2 downto 0),
      txratemode_in(2 downto 0) => txratemode_in(2 downto 0),
      txresetdone_out(2 downto 0) => \^txresetdone_out\(2 downto 0),
      txsequence_in(20 downto 0) => txsequence_in(20 downto 0),
      txswing_in(2 downto 0) => txswing_in(2 downto 0),
      txsyncdone_out(2 downto 0) => \^txsyncdone_out\(2 downto 0),
      txsyncout_out(2 downto 0) => \^txsyncout_out\(2 downto 0),
      txsysclksel_in(5 downto 0) => txsysclksel_in(5 downto 0),
      txusrclk2_in(2 downto 0) => txusrclk2_in(2 downto 0),
      txusrclk_in(2 downto 0) => txusrclk_in(2 downto 0)
    );
\gen_gtwizard_gthe3.gen_channel_container[25].gen_enabled_channel.gthe3_channel_wrapper_inst\: entity work.\JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gthe3_channel_wrapper__parameterized0\
     port map (
      GTHE3_CHANNEL_CPLLPD(0) => \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gtwiz_reset_inst_n_9\,
      GTHE3_CHANNEL_GTRXRESET(0) => gtwiz_reset_gtrxreset_int,
      GTHE3_CHANNEL_GTTXRESET(0) => gtwiz_reset_gttxreset_int,
      GTHE3_CHANNEL_RXPROGDIVRESET(0) => gtwiz_reset_rxprogdivreset_int,
      GTHE3_CHANNEL_RXUSERRDY(0) => gtwiz_reset_rxuserrdy_int,
      GTHE3_CHANNEL_TXDLYSRESET(0) => txdlysreset_int(6),
      GTHE3_CHANNEL_TXPROGDIVRESET(0) => gtwiz_reset_txprogdivreset_int,
      GTHE3_CHANNEL_TXSYNCALLIN(0) => txsyncallin_int(0),
      GTHE3_CHANNEL_TXUSERRDY(0) => gtwiz_reset_txuserrdy_int,
      bufgtce_out(11 downto 0) => bufgtce_out(20 downto 9),
      bufgtcemask_out(11 downto 0) => bufgtcemask_out(20 downto 9),
      bufgtdiv_out(35 downto 0) => bufgtdiv_out(62 downto 27),
      bufgtreset_out(11 downto 0) => bufgtreset_out(20 downto 9),
      bufgtrstmask_out(11 downto 0) => bufgtrstmask_out(20 downto 9),
      cfgreset_in(3 downto 0) => cfgreset_in(6 downto 3),
      clkrsvd0_in(3 downto 0) => clkrsvd0_in(6 downto 3),
      clkrsvd1_in(3 downto 0) => clkrsvd1_in(6 downto 3),
      cpllfbclklost_out(3 downto 0) => cpllfbclklost_out(6 downto 3),
      cplllock_out(3 downto 0) => \^cplllock_out\(6 downto 3),
      cplllockdetclk_in(3 downto 0) => cplllockdetclk_in(6 downto 3),
      cplllocken_in(3 downto 0) => cplllocken_in(6 downto 3),
      cpllrefclklost_out(3 downto 0) => cpllrefclklost_out(6 downto 3),
      cpllrefclksel_in(11 downto 0) => cpllrefclksel_in(20 downto 9),
      cpllreset_in(3 downto 0) => cpllreset_in(6 downto 3),
      dmonfiforeset_in(3 downto 0) => dmonfiforeset_in(6 downto 3),
      dmonitorclk_in(3 downto 0) => dmonitorclk_in(6 downto 3),
      dmonitorout_out(67 downto 0) => dmonitorout_out(118 downto 51),
      drpaddr_in(35 downto 0) => drpaddr_in(62 downto 27),
      drpclk_in(3 downto 0) => drpclk_in(6 downto 3),
      drpdi_in(63 downto 0) => drpdi_in(111 downto 48),
      drpdo_out(63 downto 0) => drpdo_out(111 downto 48),
      drpen_in(3 downto 0) => drpen_in(6 downto 3),
      drprdy_out(3 downto 0) => drprdy_out(6 downto 3),
      drpwe_in(3 downto 0) => drpwe_in(6 downto 3),
      evoddphicaldone_in(3 downto 0) => evoddphicaldone_in(6 downto 3),
      evoddphicalstart_in(3 downto 0) => evoddphicalstart_in(6 downto 3),
      evoddphidrden_in(3 downto 0) => evoddphidrden_in(6 downto 3),
      evoddphidwren_in(3 downto 0) => evoddphidwren_in(6 downto 3),
      evoddphixrden_in(3 downto 0) => evoddphixrden_in(6 downto 3),
      evoddphixwren_in(3 downto 0) => evoddphixwren_in(6 downto 3),
      eyescandataerror_out(3 downto 0) => eyescandataerror_out(6 downto 3),
      eyescanmode_in(3 downto 0) => eyescanmode_in(6 downto 3),
      eyescanreset_in(3 downto 0) => eyescanreset_in(6 downto 3),
      eyescantrigger_in(3 downto 0) => eyescantrigger_in(6 downto 3),
      gtgrefclk_in(3 downto 0) => gtgrefclk_in(6 downto 3),
      gthrxn_in(3 downto 0) => gthrxn_in(6 downto 3),
      gthrxp_in(3 downto 0) => gthrxp_in(6 downto 3),
      gthtxn_out(3 downto 0) => gthtxn_out(6 downto 3),
      gthtxp_out(3 downto 0) => gthtxp_out(6 downto 3),
      gtnorthrefclk0_in(3 downto 0) => gtnorthrefclk0_in(6 downto 3),
      gtnorthrefclk1_in(3 downto 0) => gtnorthrefclk1_in(6 downto 3),
      gtpowergood_out(3 downto 0) => \^gtpowergood_out\(6 downto 3),
      gtrefclk0_in(3 downto 0) => gtrefclk0_in(6 downto 3),
      gtrefclk1_in(3 downto 0) => gtrefclk1_in(6 downto 3),
      gtrefclkmonitor_out(3 downto 0) => gtrefclkmonitor_out(6 downto 3),
      gtresetsel_in(3 downto 0) => gtresetsel_in(6 downto 3),
      gtrsvd_in(63 downto 0) => gtrsvd_in(111 downto 48),
      gtrxreset_out_reg => \gen_gtwizard_gthe3.gen_channel_container[24].gen_enabled_channel.gthe3_channel_wrapper_inst_n_0\,
      gtsouthrefclk0_in(3 downto 0) => gtsouthrefclk0_in(6 downto 3),
      gtsouthrefclk1_in(3 downto 0) => gtsouthrefclk1_in(6 downto 3),
      gtwiz_userdata_tx_in(127 downto 0) => gtwiz_userdata_tx_in(223 downto 96),
      in0 => gtwiz_reset_plllock_tx_int,
      loopback_in(11 downto 0) => loopback_in(20 downto 9),
      lpbkrxtxseren_in(3 downto 0) => lpbkrxtxseren_in(6 downto 3),
      lpbktxrxseren_in(3 downto 0) => lpbktxrxseren_in(6 downto 3),
      pcieeqrxeqadaptdone_in(3 downto 0) => pcieeqrxeqadaptdone_in(6 downto 3),
      pcierategen3_out(3 downto 0) => pcierategen3_out(6 downto 3),
      pcierateidle_out(3 downto 0) => pcierateidle_out(6 downto 3),
      pcierateqpllpd_out(7 downto 0) => pcierateqpllpd_out(13 downto 6),
      pcierateqpllreset_out(7 downto 0) => pcierateqpllreset_out(13 downto 6),
      pcierstidle_in(3 downto 0) => pcierstidle_in(6 downto 3),
      pciersttxsyncstart_in(3 downto 0) => pciersttxsyncstart_in(6 downto 3),
      pciesynctxsyncdone_out(3 downto 0) => pciesynctxsyncdone_out(6 downto 3),
      pcieusergen3rdy_out(3 downto 0) => pcieusergen3rdy_out(6 downto 3),
      pcieuserphystatusrst_out(3 downto 0) => pcieuserphystatusrst_out(6 downto 3),
      pcieuserratedone_in(3 downto 0) => pcieuserratedone_in(6 downto 3),
      pcieuserratestart_out(3 downto 0) => pcieuserratestart_out(6 downto 3),
      pcsrsvdin2_in(19 downto 0) => pcsrsvdin2_in(34 downto 15),
      pcsrsvdin_in(63 downto 0) => pcsrsvdin_in(111 downto 48),
      pcsrsvdout_out(47 downto 0) => pcsrsvdout_out(83 downto 36),
      phystatus_out(3 downto 0) => phystatus_out(6 downto 3),
      pinrsrvdas_out(31 downto 0) => pinrsrvdas_out(55 downto 24),
      pmarsvdin_in(19 downto 0) => pmarsvdin_in(34 downto 15),
      qpll0clk_in(3 downto 0) => qpll0clk_in(6 downto 3),
      qpll0refclk_in(3 downto 0) => qpll0refclk_in(6 downto 3),
      qpll1clk_in(3 downto 0) => qpll1clk_in(6 downto 3),
      qpll1refclk_in(3 downto 0) => qpll1refclk_in(6 downto 3),
      resetexception_out(3 downto 0) => resetexception_out(6 downto 3),
      resetovrd_in(3 downto 0) => resetovrd_in(6 downto 3),
      rst_in0 => rst_in0,
      rstclkentx_in(3 downto 0) => rstclkentx_in(6 downto 3),
      rx8b10ben_in(3 downto 0) => rx8b10ben_in(6 downto 3),
      rxbufreset_in(3 downto 0) => rxbufreset_in(6 downto 3),
      rxbufstatus_out(11 downto 0) => rxbufstatus_out(20 downto 9),
      rxbyteisaligned_out(3 downto 0) => rxbyteisaligned_out(6 downto 3),
      rxbyterealign_out(3 downto 0) => rxbyterealign_out(6 downto 3),
      rxcdrfreqreset_in(3 downto 0) => rxcdrfreqreset_in(6 downto 3),
      rxcdrhold_in(3 downto 0) => rxcdrhold_in(6 downto 3),
      rxcdrlock_out(3 downto 0) => \^rxcdrlock_out\(6 downto 3),
      rxcdrovrden_in(3 downto 0) => rxcdrovrden_in(6 downto 3),
      rxcdrphdone_out(3 downto 0) => rxcdrphdone_out(6 downto 3),
      rxcdrreset_in(3 downto 0) => rxcdrreset_in(6 downto 3),
      rxcdrresetrsv_in(3 downto 0) => rxcdrresetrsv_in(6 downto 3),
      rxchanbondseq_out(3 downto 0) => rxchanbondseq_out(6 downto 3),
      rxchanisaligned_out(3 downto 0) => rxchanisaligned_out(6 downto 3),
      rxchanrealign_out(3 downto 0) => rxchanrealign_out(6 downto 3),
      rxchbonden_in(3 downto 0) => rxchbonden_in(6 downto 3),
      rxchbondi_in(19 downto 0) => rxchbondi_in(34 downto 15),
      rxchbondlevel_in(11 downto 0) => rxchbondlevel_in(20 downto 9),
      rxchbondmaster_in(3 downto 0) => rxchbondmaster_in(6 downto 3),
      rxchbondo_out(19 downto 0) => rxchbondo_out(34 downto 15),
      rxchbondslave_in(3 downto 0) => rxchbondslave_in(6 downto 3),
      rxclkcorcnt_out(7 downto 0) => rxclkcorcnt_out(13 downto 6),
      rxcominitdet_out(3 downto 0) => rxcominitdet_out(6 downto 3),
      rxcommadet_out(3 downto 0) => rxcommadet_out(6 downto 3),
      rxcommadeten_in(3 downto 0) => rxcommadeten_in(6 downto 3),
      rxcomsasdet_out(3 downto 0) => rxcomsasdet_out(6 downto 3),
      rxcomwakedet_out(3 downto 0) => rxcomwakedet_out(6 downto 3),
      rxctrl0_out(63 downto 0) => rxctrl0_out(111 downto 48),
      rxctrl1_out(63 downto 0) => rxctrl1_out(111 downto 48),
      rxctrl2_out(31 downto 0) => rxctrl2_out(55 downto 24),
      rxctrl3_out(31 downto 0) => rxctrl3_out(55 downto 24),
      rxdata_out(511 downto 0) => rxdata_out(895 downto 384),
      rxdataextendrsvd_out(31 downto 0) => rxdataextendrsvd_out(55 downto 24),
      rxdatavalid_out(7 downto 0) => rxdatavalid_out(13 downto 6),
      rxdfeagcctrl_in(7 downto 0) => rxdfeagcctrl_in(13 downto 6),
      rxdfeagchold_in(3 downto 0) => rxdfeagchold_in(6 downto 3),
      rxdfeagcovrden_in(3 downto 0) => rxdfeagcovrden_in(6 downto 3),
      rxdfelfhold_in(3 downto 0) => rxdfelfhold_in(6 downto 3),
      rxdfelfovrden_in(3 downto 0) => rxdfelfovrden_in(6 downto 3),
      rxdfelpmreset_in(3 downto 0) => rxdfelpmreset_in(6 downto 3),
      rxdfetap10hold_in(3 downto 0) => rxdfetap10hold_in(6 downto 3),
      rxdfetap10ovrden_in(3 downto 0) => rxdfetap10ovrden_in(6 downto 3),
      rxdfetap11hold_in(3 downto 0) => rxdfetap11hold_in(6 downto 3),
      rxdfetap11ovrden_in(3 downto 0) => rxdfetap11ovrden_in(6 downto 3),
      rxdfetap12hold_in(3 downto 0) => rxdfetap12hold_in(6 downto 3),
      rxdfetap12ovrden_in(3 downto 0) => rxdfetap12ovrden_in(6 downto 3),
      rxdfetap13hold_in(3 downto 0) => rxdfetap13hold_in(6 downto 3),
      rxdfetap13ovrden_in(3 downto 0) => rxdfetap13ovrden_in(6 downto 3),
      rxdfetap14hold_in(3 downto 0) => rxdfetap14hold_in(6 downto 3),
      rxdfetap14ovrden_in(3 downto 0) => rxdfetap14ovrden_in(6 downto 3),
      rxdfetap15hold_in(3 downto 0) => rxdfetap15hold_in(6 downto 3),
      rxdfetap15ovrden_in(3 downto 0) => rxdfetap15ovrden_in(6 downto 3),
      rxdfetap2hold_in(3 downto 0) => rxdfetap2hold_in(6 downto 3),
      rxdfetap2ovrden_in(3 downto 0) => rxdfetap2ovrden_in(6 downto 3),
      rxdfetap3hold_in(3 downto 0) => rxdfetap3hold_in(6 downto 3),
      rxdfetap3ovrden_in(3 downto 0) => rxdfetap3ovrden_in(6 downto 3),
      rxdfetap4hold_in(3 downto 0) => rxdfetap4hold_in(6 downto 3),
      rxdfetap4ovrden_in(3 downto 0) => rxdfetap4ovrden_in(6 downto 3),
      rxdfetap5hold_in(3 downto 0) => rxdfetap5hold_in(6 downto 3),
      rxdfetap5ovrden_in(3 downto 0) => rxdfetap5ovrden_in(6 downto 3),
      rxdfetap6hold_in(3 downto 0) => rxdfetap6hold_in(6 downto 3),
      rxdfetap6ovrden_in(3 downto 0) => rxdfetap6ovrden_in(6 downto 3),
      rxdfetap7hold_in(3 downto 0) => rxdfetap7hold_in(6 downto 3),
      rxdfetap7ovrden_in(3 downto 0) => rxdfetap7ovrden_in(6 downto 3),
      rxdfetap8hold_in(3 downto 0) => rxdfetap8hold_in(6 downto 3),
      rxdfetap8ovrden_in(3 downto 0) => rxdfetap8ovrden_in(6 downto 3),
      rxdfetap9hold_in(3 downto 0) => rxdfetap9hold_in(6 downto 3),
      rxdfetap9ovrden_in(3 downto 0) => rxdfetap9ovrden_in(6 downto 3),
      rxdfeuthold_in(3 downto 0) => rxdfeuthold_in(6 downto 3),
      rxdfeutovrden_in(3 downto 0) => rxdfeutovrden_in(6 downto 3),
      rxdfevphold_in(3 downto 0) => rxdfevphold_in(6 downto 3),
      rxdfevpovrden_in(3 downto 0) => rxdfevpovrden_in(6 downto 3),
      rxdfevsen_in(3 downto 0) => rxdfevsen_in(6 downto 3),
      rxdfexyden_in(3 downto 0) => rxdfexyden_in(6 downto 3),
      rxdlybypass_in(3 downto 0) => rxdlybypass_in(6 downto 3),
      rxdlyen_in(3 downto 0) => rxdlyen_in(6 downto 3),
      rxdlyovrden_in(3 downto 0) => rxdlyovrden_in(6 downto 3),
      rxdlysreset_in(3 downto 0) => rxdlysreset_in(6 downto 3),
      rxdlysresetdone_out(3 downto 0) => rxdlysresetdone_out(6 downto 3),
      rxelecidle_out(3 downto 0) => rxelecidle_out(6 downto 3),
      rxelecidlemode_in(7 downto 0) => rxelecidlemode_in(13 downto 6),
      rxgearboxslip_in(3 downto 0) => rxgearboxslip_in(6 downto 3),
      rxheader_out(23 downto 0) => rxheader_out(41 downto 18),
      rxheadervalid_out(7 downto 0) => rxheadervalid_out(13 downto 6),
      rxlatclk_in(3 downto 0) => rxlatclk_in(6 downto 3),
      rxlpmen_in(3 downto 0) => rxlpmen_in(6 downto 3),
      rxlpmgchold_in(3 downto 0) => rxlpmgchold_in(6 downto 3),
      rxlpmgcovrden_in(3 downto 0) => rxlpmgcovrden_in(6 downto 3),
      rxlpmhfhold_in(3 downto 0) => rxlpmhfhold_in(6 downto 3),
      rxlpmhfovrden_in(3 downto 0) => rxlpmhfovrden_in(6 downto 3),
      rxlpmlfhold_in(3 downto 0) => rxlpmlfhold_in(6 downto 3),
      rxlpmlfklovrden_in(3 downto 0) => rxlpmlfklovrden_in(6 downto 3),
      rxlpmoshold_in(3 downto 0) => rxlpmoshold_in(6 downto 3),
      rxlpmosovrden_in(3 downto 0) => rxlpmosovrden_in(6 downto 3),
      rxmcommaalignen_in(3 downto 0) => rxmcommaalignen_in(6 downto 3),
      rxmonitorout_out(27 downto 0) => rxmonitorout_out(48 downto 21),
      rxmonitorsel_in(7 downto 0) => rxmonitorsel_in(13 downto 6),
      rxoobreset_in(3 downto 0) => rxoobreset_in(6 downto 3),
      rxoscalreset_in(3 downto 0) => rxoscalreset_in(6 downto 3),
      rxoshold_in(3 downto 0) => rxoshold_in(6 downto 3),
      rxosintcfg_in(15 downto 0) => rxosintcfg_in(27 downto 12),
      rxosintdone_out(3 downto 0) => rxosintdone_out(6 downto 3),
      rxosinten_in(3 downto 0) => rxosinten_in(6 downto 3),
      rxosinthold_in(3 downto 0) => rxosinthold_in(6 downto 3),
      rxosintovrden_in(3 downto 0) => rxosintovrden_in(6 downto 3),
      rxosintstarted_out(3 downto 0) => rxosintstarted_out(6 downto 3),
      rxosintstrobe_in(3 downto 0) => rxosintstrobe_in(6 downto 3),
      rxosintstrobedone_out(3 downto 0) => rxosintstrobedone_out(6 downto 3),
      rxosintstrobestarted_out(3 downto 0) => rxosintstrobestarted_out(6 downto 3),
      rxosinttestovrden_in(3 downto 0) => rxosinttestovrden_in(6 downto 3),
      rxosovrden_in(3 downto 0) => rxosovrden_in(6 downto 3),
      rxoutclk_out(3 downto 0) => rxoutclk_out(6 downto 3),
      rxoutclkfabric_out(3 downto 0) => rxoutclkfabric_out(6 downto 3),
      rxoutclkpcs_out(3 downto 0) => rxoutclkpcs_out(6 downto 3),
      rxoutclksel_in(11 downto 0) => rxoutclksel_in(20 downto 9),
      rxpcommaalignen_in(3 downto 0) => rxpcommaalignen_in(6 downto 3),
      rxpcsreset_in(3 downto 0) => rxpcsreset_in(6 downto 3),
      rxpd_in(7 downto 0) => rxpd_in(13 downto 6),
      rxphalign_in(3 downto 0) => rxphalign_in(6 downto 3),
      rxphaligndone_out(3 downto 0) => rxphaligndone_out(6 downto 3),
      rxphalignen_in(3 downto 0) => rxphalignen_in(6 downto 3),
      rxphalignerr_out(3 downto 0) => rxphalignerr_out(6 downto 3),
      rxphdlypd_in(3 downto 0) => rxphdlypd_in(6 downto 3),
      rxphdlyreset_in(3 downto 0) => rxphdlyreset_in(6 downto 3),
      rxphovrden_in(3 downto 0) => rxphovrden_in(6 downto 3),
      rxpllclksel_in(7 downto 0) => rxpllclksel_in(13 downto 6),
      rxpmareset_in(3 downto 0) => rxpmareset_in(6 downto 3),
      rxpmaresetdone_out(3 downto 0) => rxpmaresetdone_out(6 downto 3),
      rxpolarity_in(3 downto 0) => rxpolarity_in(6 downto 3),
      rxprbscntreset_in(3 downto 0) => rxprbscntreset_in(6 downto 3),
      rxprbserr_out(3 downto 0) => rxprbserr_out(6 downto 3),
      rxprbslocked_out(3 downto 0) => rxprbslocked_out(6 downto 3),
      rxprbssel_in(15 downto 0) => rxprbssel_in(27 downto 12),
      rxprgdivresetdone_out(3 downto 0) => rxprgdivresetdone_out(6 downto 3),
      rxqpien_in(3 downto 0) => rxqpien_in(6 downto 3),
      rxqpisenn_out(3 downto 0) => rxqpisenn_out(6 downto 3),
      rxqpisenp_out(3 downto 0) => rxqpisenp_out(6 downto 3),
      rxrate_in(11 downto 0) => rxrate_in(20 downto 9),
      rxratedone_out(3 downto 0) => rxratedone_out(6 downto 3),
      rxratemode_in(3 downto 0) => rxratemode_in(6 downto 3),
      rxrecclkout_out(3 downto 0) => rxrecclkout_out(6 downto 3),
      rxresetdone_out(3 downto 0) => \^rxresetdone_out\(6 downto 3),
      rxslide_in(3 downto 0) => rxslide_in(6 downto 3),
      rxsliderdy_out(3 downto 0) => rxsliderdy_out(6 downto 3),
      rxslipdone_out(3 downto 0) => rxslipdone_out(6 downto 3),
      rxslipoutclk_in(3 downto 0) => rxslipoutclk_in(6 downto 3),
      rxslipoutclkrdy_out(3 downto 0) => rxslipoutclkrdy_out(6 downto 3),
      rxslippma_in(3 downto 0) => rxslippma_in(6 downto 3),
      rxslippmardy_out(3 downto 0) => rxslippmardy_out(6 downto 3),
      rxstartofseq_out(7 downto 0) => rxstartofseq_out(13 downto 6),
      rxstatus_out(11 downto 0) => rxstatus_out(20 downto 9),
      rxsyncallin_in(3 downto 0) => rxsyncallin_in(6 downto 3),
      rxsyncdone_out(3 downto 0) => rxsyncdone_out(6 downto 3),
      rxsyncin_in(3 downto 0) => rxsyncin_in(6 downto 3),
      rxsyncmode_in(3 downto 0) => rxsyncmode_in(6 downto 3),
      rxsyncout_out(3 downto 0) => rxsyncout_out(6 downto 3),
      rxsysclksel_in(7 downto 0) => rxsysclksel_in(13 downto 6),
      rxusrclk2_in(3 downto 0) => rxusrclk2_in(6 downto 3),
      rxusrclk_in(3 downto 0) => rxusrclk_in(6 downto 3),
      rxvalid_out(3 downto 0) => rxvalid_out(6 downto 3),
      sigvalidclk_in(3 downto 0) => sigvalidclk_in(6 downto 3),
      tx8b10bbypass_in(31 downto 0) => tx8b10bbypass_in(55 downto 24),
      tx8b10ben_in(3 downto 0) => tx8b10ben_in(6 downto 3),
      txbufdiffctrl_in(11 downto 0) => txbufdiffctrl_in(20 downto 9),
      txbufstatus_out(7 downto 0) => txbufstatus_out(13 downto 6),
      txcomfinish_out(3 downto 0) => txcomfinish_out(6 downto 3),
      txcominit_in(3 downto 0) => txcominit_in(6 downto 3),
      txcomsas_in(3 downto 0) => txcomsas_in(6 downto 3),
      txcomwake_in(3 downto 0) => txcomwake_in(6 downto 3),
      txctrl0_in(63 downto 0) => txctrl0_in(111 downto 48),
      txctrl1_in(63 downto 0) => txctrl1_in(111 downto 48),
      txctrl2_in(31 downto 0) => txctrl2_in(55 downto 24),
      txdataextendrsvd_in(31 downto 0) => txdataextendrsvd_in(55 downto 24),
      txdeemph_in(3 downto 0) => txdeemph_in(6 downto 3),
      txdetectrx_in(3 downto 0) => txdetectrx_in(6 downto 3),
      txdiffctrl_in(15 downto 0) => txdiffctrl_in(27 downto 12),
      txdiffpd_in(3 downto 0) => txdiffpd_in(6 downto 3),
      txdlysresetdone_out(3 downto 0) => txdlysresetdone_out(6 downto 3),
      txelecidle_in(3 downto 0) => txelecidle_in(6 downto 3),
      txheader_in(23 downto 0) => txheader_in(41 downto 18),
      txinhibit_in(3 downto 0) => txinhibit_in(6 downto 3),
      txlatclk_in(3 downto 0) => txlatclk_in(6 downto 3),
      txmaincursor_in(27 downto 0) => txmaincursor_in(48 downto 21),
      txmargin_in(11 downto 0) => txmargin_in(20 downto 9),
      txoutclk_out(3 downto 0) => txoutclk_out(6 downto 3),
      txoutclkfabric_out(3 downto 0) => txoutclkfabric_out(6 downto 3),
      txoutclkpcs_out(3 downto 0) => txoutclkpcs_out(6 downto 3),
      txoutclksel_in(11 downto 0) => txoutclksel_in(20 downto 9),
      txpcsreset_in(3 downto 0) => txpcsreset_in(6 downto 3),
      txpd_in(7 downto 0) => txpd_in(13 downto 6),
      txpdelecidlemode_in(3 downto 0) => txpdelecidlemode_in(6 downto 3),
      txphaligndone_out(3 downto 0) => \^txphaligndone_out\(6 downto 3),
      txphinitdone_out(3 downto 0) => txphinitdone_out(6 downto 3),
      txpippmen_in(3 downto 0) => txpippmen_in(6 downto 3),
      txpippmovrden_in(3 downto 0) => txpippmovrden_in(6 downto 3),
      txpippmpd_in(3 downto 0) => txpippmpd_in(6 downto 3),
      txpippmsel_in(3 downto 0) => txpippmsel_in(6 downto 3),
      txpippmstepsize_in(19 downto 0) => txpippmstepsize_in(34 downto 15),
      txpisopd_in(3 downto 0) => txpisopd_in(6 downto 3),
      txpllclksel_in(7 downto 0) => txpllclksel_in(13 downto 6),
      txpmareset_in(3 downto 0) => txpmareset_in(6 downto 3),
      txpmaresetdone_out(3 downto 0) => txpmaresetdone_out(6 downto 3),
      txpolarity_in(3 downto 0) => txpolarity_in(6 downto 3),
      txpostcursor_in(19 downto 0) => txpostcursor_in(34 downto 15),
      txpostcursorinv_in(3 downto 0) => txpostcursorinv_in(6 downto 3),
      txprbsforceerr_in(3 downto 0) => txprbsforceerr_in(6 downto 3),
      txprbssel_in(15 downto 0) => txprbssel_in(27 downto 12),
      txprecursor_in(19 downto 0) => txprecursor_in(34 downto 15),
      txprecursorinv_in(3 downto 0) => txprecursorinv_in(6 downto 3),
      txprgdivresetdone_out(3 downto 0) => txprgdivresetdone_out(6 downto 3),
      txqpibiasen_in(3 downto 0) => txqpibiasen_in(6 downto 3),
      txqpisenn_out(3 downto 0) => txqpisenn_out(6 downto 3),
      txqpisenp_out(3 downto 0) => txqpisenp_out(6 downto 3),
      txqpistrongpdown_in(3 downto 0) => txqpistrongpdown_in(6 downto 3),
      txqpiweakpup_in(3 downto 0) => txqpiweakpup_in(6 downto 3),
      txrate_in(11 downto 0) => txrate_in(20 downto 9),
      txratedone_out(3 downto 0) => txratedone_out(6 downto 3),
      txratemode_in(3 downto 0) => txratemode_in(6 downto 3),
      txresetdone_out(3 downto 0) => \^txresetdone_out\(6 downto 3),
      txsequence_in(27 downto 0) => txsequence_in(48 downto 21),
      txswing_in(3 downto 0) => txswing_in(6 downto 3),
      txsyncdone_out(3 downto 0) => \^txsyncdone_out\(6 downto 3),
      txsyncout_out(3 downto 0) => \^txsyncout_out\(6 downto 3),
      txsysclksel_in(7 downto 0) => txsysclksel_in(13 downto 6),
      txusrclk2_in(3 downto 0) => txusrclk2_in(6 downto 3),
      txusrclk_in(3 downto 0) => txusrclk_in(6 downto 3)
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[0].bit_synchronizer_rxresetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      rxresetdone_out(0) => \^rxresetdone_out\(0),
      rxresetdone_sync(0) => rxresetdone_sync(0)
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[0].bit_synchronizer_txresetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_0
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      txresetdone_out(0) => \^txresetdone_out\(0),
      txresetdone_sync(0) => txresetdone_sync(0)
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[1].bit_synchronizer_rxresetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_1
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      i_in_out_reg_0(2 downto 1) => rxresetdone_sync(3 downto 2),
      i_in_out_reg_0(0) => rxresetdone_sync(0),
      rxresetdone_out(0) => \^rxresetdone_out\(1),
      sm_reset_rx_timer_clr_reg => \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[1].bit_synchronizer_rxresetdone_inst_n_0\
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[1].bit_synchronizer_txresetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_2
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      i_in_out_reg_0(2 downto 1) => txresetdone_sync(3 downto 2),
      i_in_out_reg_0(0) => txresetdone_sync(0),
      sm_reset_tx_timer_clr_reg => \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[1].bit_synchronizer_txresetdone_inst_n_0\,
      txresetdone_out(0) => \^txresetdone_out\(1)
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[2].bit_synchronizer_rxresetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_3
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      rxresetdone_out(0) => \^rxresetdone_out\(2),
      sm_reset_rx_timer_clr_reg(0) => rxresetdone_sync(2)
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[2].bit_synchronizer_txresetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_4
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      sm_reset_tx_timer_clr_reg(0) => txresetdone_sync(2),
      txresetdone_out(0) => \^txresetdone_out\(2)
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[3].bit_synchronizer_rxresetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_5
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      rxresetdone_out(0) => \^rxresetdone_out\(3),
      sm_reset_rx_timer_clr_reg(0) => rxresetdone_sync(3)
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[3].bit_synchronizer_txresetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_6
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      sm_reset_tx_timer_clr_reg(0) => txresetdone_sync(3),
      txresetdone_out(0) => \^txresetdone_out\(3)
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[4].bit_synchronizer_rxresetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_7
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      rxresetdone_out(0) => \^rxresetdone_out\(4),
      rxresetdone_sync(0) => rxresetdone_sync(4)
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[4].bit_synchronizer_txresetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_8
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      txresetdone_out(0) => \^txresetdone_out\(4),
      txresetdone_sync(0) => txresetdone_sync(4)
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[5].bit_synchronizer_rxresetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_9
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      i_in_out_reg_0(1) => rxresetdone_sync(6),
      i_in_out_reg_0(0) => rxresetdone_sync(4),
      rxresetdone_out(0) => \^rxresetdone_out\(5),
      rxresetdone_sync(0) => rxresetdone_sync(5),
      sm_reset_rx_timer_clr_reg => \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[5].bit_synchronizer_rxresetdone_inst_n_1\
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[5].bit_synchronizer_txresetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_10
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      i_in_out_reg_0(1) => txresetdone_sync(6),
      i_in_out_reg_0(0) => txresetdone_sync(4),
      sm_reset_tx_timer_clr_reg => \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[5].bit_synchronizer_txresetdone_inst_n_1\,
      txresetdone_out(0) => \^txresetdone_out\(5),
      txresetdone_sync(0) => txresetdone_sync(5)
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[6].bit_synchronizer_rxresetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_11
     port map (
      \FSM_sequential_sm_reset_rx_reg[0]\(0) => rxresetdone_sync(6),
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      rxresetdone_out(0) => \^rxresetdone_out\(6)
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[6].bit_synchronizer_txresetdone_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_bit_synchronizer_12
     port map (
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_tx_done_int_reg(0) => txresetdone_sync(6),
      txresetdone_out(0) => \^txresetdone_out\(6)
    );
\gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gtwiz_reset_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gtwiz_reset
     port map (
      GTHE3_CHANNEL_CPLLPD(0) => \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gtwiz_reset_inst_n_9\,
      GTHE3_CHANNEL_GTRXRESET(0) => gtwiz_reset_gtrxreset_int,
      GTHE3_CHANNEL_GTTXRESET(0) => gtwiz_reset_gttxreset_int,
      GTHE3_CHANNEL_RXPROGDIVRESET(0) => gtwiz_reset_rxprogdivreset_int,
      GTHE3_CHANNEL_RXUSERRDY(0) => gtwiz_reset_rxuserrdy_int,
      GTHE3_CHANNEL_TXPROGDIVRESET(0) => gtwiz_reset_txprogdivreset_int,
      GTHE3_CHANNEL_TXUSERRDY(0) => gtwiz_reset_txuserrdy_int,
      gtrxreset_out_reg_0 => gtwiz_reset_plllock_tx_int,
      gtrxreset_out_reg_1 => \gtwiz_reset_rxcdrlock_int__0\,
      gtwiz_reset_all_in(0) => gtwiz_reset_all_in(0),
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_rx_cdr_stable_out(0) => gtwiz_reset_rx_cdr_stable_out(0),
      gtwiz_reset_rx_datapath_in(0) => gtwiz_reset_rx_datapath_in(0),
      gtwiz_reset_rx_done_out(0) => gtwiz_reset_rx_done_out(0),
      gtwiz_reset_rx_pll_and_datapath_in(0) => gtwiz_reset_rx_pll_and_datapath_in(0),
      gtwiz_reset_tx_datapath_in(0) => gtwiz_reset_tx_datapath_in(0),
      gtwiz_reset_tx_done_out(0) => gtwiz_reset_tx_done_out(0),
      gtwiz_reset_tx_pll_and_datapath_in(0) => gtwiz_reset_tx_pll_and_datapath_in(0),
      gtwiz_userclk_rx_active_in(0) => gtwiz_userclk_rx_active_in(0),
      gtwiz_userclk_tx_active_in(0) => gtwiz_userclk_tx_active_in(0),
      i_in_out_reg => \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[1].bit_synchronizer_txresetdone_inst_n_0\,
      i_in_out_reg_0 => \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[1].bit_synchronizer_rxresetdone_inst_n_0\,
      i_in_out_reg_1 => \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[5].bit_synchronizer_txresetdone_inst_n_1\,
      i_in_out_reg_2 => \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gen_ch_xrd[5].bit_synchronizer_rxresetdone_inst_n_1\,
      in0 => \gtwiz_reset_gtpowergood_int__0\,
      rst_in0 => rst_in0,
      rst_in_sync2_reg => \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gtwiz_reset_inst_n_10\,
      rxresetdone_sync(2 downto 0) => rxresetdone_sync(6 downto 4),
      rxusrclk2_in(0) => rxusrclk2_in(6),
      txresetdone_sync(2 downto 0) => txresetdone_sync(6 downto 4),
      txusrclk2_in(0) => txusrclk2_in(6)
    );
\gen_gtwizard_gthe3.gen_tx_buffer_bypass_internal.gen_single_instance.gtwiz_buffbypass_tx_inst\: entity work.JesdCryoCoreRightColumn_gtwizard_ultrascale_v1_6_5_gtwiz_buffbypass_tx
     port map (
      GTHE3_CHANNEL_TXDLYSRESET(0) => txdlysreset_int(6),
      GTHE3_CHANNEL_TXSYNCALLIN(0) => txsyncallin_int(0),
      gtwiz_buffbypass_tx_done_out(0) => gtwiz_buffbypass_tx_done_out(0),
      gtwiz_buffbypass_tx_error_out(0) => gtwiz_buffbypass_tx_error_out(0),
      gtwiz_buffbypass_tx_reset_in(0) => gtwiz_buffbypass_tx_reset_in(0),
      gtwiz_buffbypass_tx_start_user_in(0) => gtwiz_buffbypass_tx_start_user_in(0),
      rst_in_out_reg => \gen_gtwizard_gthe3.gen_reset_controller_internal.gen_single_instance.gtwiz_reset_inst_n_10\,
      txphaligndone_out(6 downto 0) => \^txphaligndone_out\(6 downto 0),
      txsyncdone_out(0) => \^txsyncdone_out\(6),
      txusrclk2_in(0) => txusrclk2_in(6)
    );
i_in_inferred_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => \^gtpowergood_out\(4),
      I1 => \^gtpowergood_out\(6),
      I2 => \^gtpowergood_out\(5),
      I3 => i_in_inferred_i_2_n_0,
      O => \gtwiz_reset_gtpowergood_int__0\
    );
\i_in_inferred_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => \^rxcdrlock_out\(4),
      I1 => \^rxcdrlock_out\(6),
      I2 => \^rxcdrlock_out\(5),
      I3 => \i_in_inferred_i_2__0_n_0\,
      O => \gtwiz_reset_rxcdrlock_int__0\
    );
i_in_inferred_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \^gtpowergood_out\(1),
      I1 => \^gtpowergood_out\(0),
      I2 => \^gtpowergood_out\(3),
      I3 => \^gtpowergood_out\(2),
      O => i_in_inferred_i_2_n_0
    );
\i_in_inferred_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \^rxcdrlock_out\(1),
      I1 => \^rxcdrlock_out\(0),
      I2 => \^rxcdrlock_out\(3),
      I3 => \^rxcdrlock_out\(2),
      O => \i_in_inferred_i_2__0_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top is
  port (
    gtwiz_userclk_tx_reset_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_userclk_tx_active_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_userclk_tx_srcclk_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_userclk_tx_usrclk_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_userclk_tx_usrclk2_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_userclk_tx_active_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_userclk_rx_reset_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_userclk_rx_active_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_userclk_rx_srcclk_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_userclk_rx_usrclk_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_userclk_rx_usrclk2_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_userclk_rx_active_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_tx_reset_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_tx_start_user_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_tx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_tx_error_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_rx_reset_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_rx_start_user_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_rx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_buffbypass_rx_error_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_clk_freerun_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_all_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_pll_and_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_pll_and_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_datapath_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_done_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_done_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_qpll0lock_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_qpll1lock_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_cdr_stable_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_tx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_rx_done_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_qpll0reset_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_reset_qpll1reset_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtwiz_gthe3_cpll_cal_txoutclk_period_in : in STD_LOGIC_VECTOR ( 125 downto 0 );
    gtwiz_gthe3_cpll_cal_cnt_tol_in : in STD_LOGIC_VECTOR ( 125 downto 0 );
    gtwiz_gthe3_cpll_cal_bufg_ce_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtwiz_gthe4_cpll_cal_txoutclk_period_in : in STD_LOGIC_VECTOR ( 125 downto 0 );
    gtwiz_gthe4_cpll_cal_cnt_tol_in : in STD_LOGIC_VECTOR ( 125 downto 0 );
    gtwiz_gthe4_cpll_cal_bufg_ce_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtwiz_gtye4_cpll_cal_txoutclk_period_in : in STD_LOGIC_VECTOR ( 125 downto 0 );
    gtwiz_gtye4_cpll_cal_cnt_tol_in : in STD_LOGIC_VECTOR ( 125 downto 0 );
    gtwiz_gtye4_cpll_cal_bufg_ce_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtwiz_userdata_tx_in : in STD_LOGIC_VECTOR ( 223 downto 0 );
    gtwiz_userdata_rx_out : out STD_LOGIC_VECTOR ( 223 downto 0 );
    bgbypassb_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    bgmonitorenb_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    bgpdb_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    bgrcalovrd_in : in STD_LOGIC_VECTOR ( 4 downto 0 );
    bgrcalovrdenb_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    drpaddr_common_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    drpclk_common_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    drpdi_common_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    drpen_common_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    drpwe_common_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtgrefclk0_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtgrefclk1_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtnorthrefclk00_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtnorthrefclk01_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtnorthrefclk10_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtnorthrefclk11_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtrefclk00_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtrefclk01_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtrefclk10_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtrefclk11_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtsouthrefclk00_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtsouthrefclk01_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtsouthrefclk10_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtsouthrefclk11_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    pcierateqpll0_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    pcierateqpll1_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    pmarsvd0_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pmarsvd1_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    qpll0clkrsvd0_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll0clkrsvd1_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll0fbdiv_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll0lockdetclk_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll0locken_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll0pd_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll0refclksel_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    qpll0reset_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll1clkrsvd0_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll1clkrsvd1_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll1fbdiv_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll1lockdetclk_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll1locken_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll1pd_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll1refclksel_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    qpll1reset_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpllrsvd1_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    qpllrsvd2_in : in STD_LOGIC_VECTOR ( 4 downto 0 );
    qpllrsvd3_in : in STD_LOGIC_VECTOR ( 4 downto 0 );
    qpllrsvd4_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rcalenb_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    sdm0data_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    sdm0reset_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    sdm0toggle_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    sdm0width_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    sdm1data_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    sdm1reset_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    sdm1toggle_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    sdm1width_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    tcongpi_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    tconpowerup_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    tconreset_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    tconrsvdin1_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubcfgstreamen_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubdo_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubdrdy_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubenable_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubgpi_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubintr_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubiolmbrst_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubmbrst_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubmdmcapture_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubmdmdbgrst_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubmdmdbgupdate_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubmdmregen_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubmdmshift_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubmdmsysrst_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubmdmtck_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    ubmdmtdi_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    drpdo_common_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    drprdy_common_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    pmarsvdout0_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    pmarsvdout1_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    qpll0fbclklost_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    qpll0lock_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    qpll0outclk_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    qpll0outrefclk_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    qpll0refclklost_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    qpll1fbclklost_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    qpll1lock_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    qpll1outclk_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    qpll1outrefclk_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    qpll1refclklost_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    qplldmonitor0_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    qplldmonitor1_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    refclkoutmonitor0_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    refclkoutmonitor1_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxrecclk0_sel_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    rxrecclk1_sel_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    rxrecclk0sel_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxrecclk1sel_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    sdm0finalout_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    sdm0testdata_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    sdm1finalout_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    sdm1testdata_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    tcongpo_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    tconrsvdout0_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    ubdaddr_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    ubden_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    ubdi_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    ubdwe_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    ubmdmtdo_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    ubrsvdout_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    ubtxuart_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    cdrstepdir_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    cdrstepsq_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    cdrstepsx_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    cfgreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    clkrsvd0_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    clkrsvd1_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    cpllfreqlock_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    cplllockdetclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    cplllocken_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    cpllpd_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    cpllrefclksel_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    cpllreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    dmonfiforeset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    dmonitorclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    drpaddr_in : in STD_LOGIC_VECTOR ( 62 downto 0 );
    drpclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    drpdi_in : in STD_LOGIC_VECTOR ( 111 downto 0 );
    drpen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    drprst_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    drpwe_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    elpcaldvorwren_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    elpcalpaorwren_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    evoddphicaldone_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    evoddphicalstart_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    evoddphidrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    evoddphidwren_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    evoddphixrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    evoddphixwren_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    eyescanmode_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    eyescanreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    eyescantrigger_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    freqos_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtgrefclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gthrxn_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gthrxp_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtnorthrefclk0_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtnorthrefclk1_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtrefclk0_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtrefclk1_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtresetsel_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtrsvd_in : in STD_LOGIC_VECTOR ( 111 downto 0 );
    gtrxreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtrxresetsel_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtsouthrefclk0_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtsouthrefclk1_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gttxreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gttxresetsel_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    incpctrl_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtyrxn_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtyrxp_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    loopback_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    looprsvd_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    lpbkrxtxseren_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    lpbktxrxseren_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    pcieeqrxeqadaptdone_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    pcierstidle_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    pciersttxsyncstart_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    pcieuserratedone_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    pcsrsvdin_in : in STD_LOGIC_VECTOR ( 111 downto 0 );
    pcsrsvdin2_in : in STD_LOGIC_VECTOR ( 34 downto 0 );
    pmarsvdin_in : in STD_LOGIC_VECTOR ( 34 downto 0 );
    qpll0clk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    qpll0freqlock_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll0refclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    qpll1clk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    qpll1freqlock_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    qpll1refclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    resetovrd_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rstclkentx_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rx8b10ben_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxafecfoken_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxbufreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcdrfreqreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcdrhold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcdrovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcdrreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcdrresetrsv_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxchbonden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxchbondi_in : in STD_LOGIC_VECTOR ( 34 downto 0 );
    rxchbondlevel_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    rxchbondmaster_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxchbondslave_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxckcalreset_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxckcalstart_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxcommadeten_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfeagcctrl_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    rxdccforcestart_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxdfeagchold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfeagcovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfecfokfcnum_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxdfecfokfen_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxdfecfokfpulse_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxdfecfokhold_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxdfecfokovren_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxdfekhhold_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxdfekhovrden_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxdfelfhold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfelfovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfelpmreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap10hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap10ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap11hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap11ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap12hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap12ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap13hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap13ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap14hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap14ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap15hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap15ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap2hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap2ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap3hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap3ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap4hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap4ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap5hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap5ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap6hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap6ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap7hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap7ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap8hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap8ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap9hold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfetap9ovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfeuthold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfeutovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfevphold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfevpovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfevsen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdfexyden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdlybypass_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdlyen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdlyovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxdlysreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxelecidlemode_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    rxeqtraining_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxgearboxslip_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlatclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmgchold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmgcovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmhfhold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmhfovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmlfhold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmlfklovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmoshold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxlpmosovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxmcommaalignen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxmonitorsel_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    rxoobreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxoscalreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxoshold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosintcfg_in : in STD_LOGIC_VECTOR ( 27 downto 0 );
    rxosinten_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosinthold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosintovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosintstrobe_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosinttestovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxoutclksel_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    rxpcommaalignen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxpcsreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxpd_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    rxphalign_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxphalignen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxphdlypd_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxphdlyreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxphovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxpllclksel_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    rxpmareset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxpolarity_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxprbscntreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxprbssel_in : in STD_LOGIC_VECTOR ( 27 downto 0 );
    rxprogdivreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxqpien_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxrate_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    rxratemode_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxslide_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxslipoutclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxslippma_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxsyncallin_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxsyncin_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxsyncmode_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxsysclksel_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    rxtermination_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxuserrdy_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxusrclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxusrclk2_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    sigvalidclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    tstin_in : in STD_LOGIC_VECTOR ( 139 downto 0 );
    tx8b10bbypass_in : in STD_LOGIC_VECTOR ( 55 downto 0 );
    tx8b10ben_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txbufdiffctrl_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    txcominit_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txcomsas_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txcomwake_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txctrl0_in : in STD_LOGIC_VECTOR ( 111 downto 0 );
    txctrl1_in : in STD_LOGIC_VECTOR ( 111 downto 0 );
    txctrl2_in : in STD_LOGIC_VECTOR ( 55 downto 0 );
    txdata_in : in STD_LOGIC_VECTOR ( 895 downto 0 );
    txdataextendrsvd_in : in STD_LOGIC_VECTOR ( 55 downto 0 );
    txdccforcestart_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    txdccreset_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    txdeemph_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txdetectrx_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txdiffctrl_in : in STD_LOGIC_VECTOR ( 27 downto 0 );
    txdiffpd_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txdlybypass_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txdlyen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txdlyhold_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txdlyovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txdlysreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txdlyupdown_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txelecidle_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txelforcestart_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    txheader_in : in STD_LOGIC_VECTOR ( 41 downto 0 );
    txinhibit_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txlatclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txlfpstreset_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    txlfpsu2lpexit_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    txlfpsu3wake_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    txmaincursor_in : in STD_LOGIC_VECTOR ( 48 downto 0 );
    txmargin_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    txmuxdcdexhold_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    txmuxdcdorwren_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    txoneszeros_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    txoutclksel_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    txpcsreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpd_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    txpdelecidlemode_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txphalign_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txphalignen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txphdlypd_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txphdlyreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txphdlytstclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txphinit_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txphovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpippmen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpippmovrden_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpippmpd_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpippmsel_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpippmstepsize_in : in STD_LOGIC_VECTOR ( 34 downto 0 );
    txpisopd_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpllclksel_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    txpmareset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpolarity_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txpostcursor_in : in STD_LOGIC_VECTOR ( 34 downto 0 );
    txpostcursorinv_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txprbsforceerr_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txprbssel_in : in STD_LOGIC_VECTOR ( 27 downto 0 );
    txprecursor_in : in STD_LOGIC_VECTOR ( 34 downto 0 );
    txprecursorinv_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txprogdivreset_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txqpibiasen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txqpistrongpdown_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txqpiweakpup_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txrate_in : in STD_LOGIC_VECTOR ( 20 downto 0 );
    txratemode_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txsequence_in : in STD_LOGIC_VECTOR ( 48 downto 0 );
    txswing_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txsyncallin_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txsyncin_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txsyncmode_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txsysclksel_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    txuserrdy_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txusrclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txusrclk2_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    bufgtce_out : out STD_LOGIC_VECTOR ( 20 downto 0 );
    bufgtcemask_out : out STD_LOGIC_VECTOR ( 20 downto 0 );
    bufgtdiv_out : out STD_LOGIC_VECTOR ( 62 downto 0 );
    bufgtreset_out : out STD_LOGIC_VECTOR ( 20 downto 0 );
    bufgtrstmask_out : out STD_LOGIC_VECTOR ( 20 downto 0 );
    cpllfbclklost_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    cplllock_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    cpllrefclklost_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    dmonitorout_out : out STD_LOGIC_VECTOR ( 118 downto 0 );
    dmonitoroutclk_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    drpdo_out : out STD_LOGIC_VECTOR ( 111 downto 0 );
    drprdy_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    eyescandataerror_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gthtxn_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gthtxp_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gtpowergood_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gtrefclkmonitor_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gtytxn_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtytxp_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    pcierategen3_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    pcierateidle_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    pcierateqpllpd_out : out STD_LOGIC_VECTOR ( 13 downto 0 );
    pcierateqpllreset_out : out STD_LOGIC_VECTOR ( 13 downto 0 );
    pciesynctxsyncdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    pcieusergen3rdy_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    pcieuserphystatusrst_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    pcieuserratestart_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    pcsrsvdout_out : out STD_LOGIC_VECTOR ( 83 downto 0 );
    phystatus_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    pinrsrvdas_out : out STD_LOGIC_VECTOR ( 55 downto 0 );
    powerpresent_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    resetexception_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxbufstatus_out : out STD_LOGIC_VECTOR ( 20 downto 0 );
    rxbyteisaligned_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxbyterealign_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcdrlock_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcdrphdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxchanbondseq_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxchanisaligned_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxchanrealign_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxchbondo_out : out STD_LOGIC_VECTOR ( 34 downto 0 );
    rxckcaldone_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxclkcorcnt_out : out STD_LOGIC_VECTOR ( 13 downto 0 );
    rxcominitdet_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcommadet_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcomsasdet_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcomwakedet_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxctrl0_out : out STD_LOGIC_VECTOR ( 111 downto 0 );
    rxctrl1_out : out STD_LOGIC_VECTOR ( 111 downto 0 );
    rxctrl2_out : out STD_LOGIC_VECTOR ( 55 downto 0 );
    rxctrl3_out : out STD_LOGIC_VECTOR ( 55 downto 0 );
    rxdata_out : out STD_LOGIC_VECTOR ( 895 downto 0 );
    rxdataextendrsvd_out : out STD_LOGIC_VECTOR ( 55 downto 0 );
    rxdatavalid_out : out STD_LOGIC_VECTOR ( 13 downto 0 );
    rxdlysresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxelecidle_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxheader_out : out STD_LOGIC_VECTOR ( 41 downto 0 );
    rxheadervalid_out : out STD_LOGIC_VECTOR ( 13 downto 0 );
    rxlfpstresetdet_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxlfpsu2lpexitdet_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxlfpsu3wakedet_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    rxmonitorout_out : out STD_LOGIC_VECTOR ( 48 downto 0 );
    rxosintdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosintstarted_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosintstrobedone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxosintstrobestarted_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxoutclk_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxoutclkfabric_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxoutclkpcs_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxphaligndone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxphalignerr_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxpmaresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxprbserr_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxprbslocked_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxprgdivresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxqpisenn_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxqpisenp_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxratedone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxrecclkout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxsliderdy_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxslipdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxslipoutclkrdy_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxslippmardy_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxstartofseq_out : out STD_LOGIC_VECTOR ( 13 downto 0 );
    rxstatus_out : out STD_LOGIC_VECTOR ( 20 downto 0 );
    rxsyncdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxsyncout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxvalid_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txbufstatus_out : out STD_LOGIC_VECTOR ( 13 downto 0 );
    txcomfinish_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txdccdone_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    txdlysresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txoutclk_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txoutclkfabric_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txoutclkpcs_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txphaligndone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txphinitdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txpmaresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txprgdivresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txqpisenn_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txqpisenp_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txratedone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txsyncdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txsyncout_out : out STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  attribute C_CHANNEL_ENABLE : string;
  attribute C_CHANNEL_ENABLE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "192'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011110111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  attribute C_COMMON_SCALING_FACTOR : integer;
  attribute C_COMMON_SCALING_FACTOR of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_CPLL_VCO_FREQUENCY : string;
  attribute C_CPLL_VCO_FREQUENCY of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "6142.500000";
  attribute C_FORCE_COMMONS : integer;
  attribute C_FORCE_COMMONS of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_FREERUN_FREQUENCY : string;
  attribute C_FREERUN_FREQUENCY of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "200.000000";
  attribute C_GT_REV : integer;
  attribute C_GT_REV of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 17;
  attribute C_GT_TYPE : integer;
  attribute C_GT_TYPE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_INCLUDE_CPLL_CAL : integer;
  attribute C_INCLUDE_CPLL_CAL of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 2;
  attribute C_LOCATE_COMMON : integer;
  attribute C_LOCATE_COMMON of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_LOCATE_IN_SYSTEM_IBERT_CORE : integer;
  attribute C_LOCATE_IN_SYSTEM_IBERT_CORE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 2;
  attribute C_LOCATE_RESET_CONTROLLER : integer;
  attribute C_LOCATE_RESET_CONTROLLER of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_LOCATE_RX_BUFFER_BYPASS_CONTROLLER : integer;
  attribute C_LOCATE_RX_BUFFER_BYPASS_CONTROLLER of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_LOCATE_RX_USER_CLOCKING : integer;
  attribute C_LOCATE_RX_USER_CLOCKING of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_LOCATE_TX_BUFFER_BYPASS_CONTROLLER : integer;
  attribute C_LOCATE_TX_BUFFER_BYPASS_CONTROLLER of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_LOCATE_TX_USER_CLOCKING : integer;
  attribute C_LOCATE_TX_USER_CLOCKING of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_LOCATE_USER_DATA_WIDTH_SIZING : integer;
  attribute C_LOCATE_USER_DATA_WIDTH_SIZING of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_PCIE_CORECLK_FREQ : integer;
  attribute C_PCIE_CORECLK_FREQ of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 250;
  attribute C_PCIE_ENABLE : integer;
  attribute C_PCIE_ENABLE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_RESET_CONTROLLER_INSTANCE_CTRL : integer;
  attribute C_RESET_CONTROLLER_INSTANCE_CTRL of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_RESET_SEQUENCE_INTERVAL : integer;
  attribute C_RESET_SEQUENCE_INTERVAL of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_RX_BUFFBYPASS_MODE : integer;
  attribute C_RX_BUFFBYPASS_MODE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_RX_BUFFER_BYPASS_INSTANCE_CTRL : integer;
  attribute C_RX_BUFFER_BYPASS_INSTANCE_CTRL of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_RX_BUFFER_MODE : integer;
  attribute C_RX_BUFFER_MODE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_RX_CB_DISP : string;
  attribute C_RX_CB_DISP of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "8'b00000000";
  attribute C_RX_CB_K : string;
  attribute C_RX_CB_K of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "8'b00000000";
  attribute C_RX_CB_LEN_SEQ : integer;
  attribute C_RX_CB_LEN_SEQ of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_RX_CB_MAX_LEVEL : integer;
  attribute C_RX_CB_MAX_LEVEL of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 3;
  attribute C_RX_CB_NUM_SEQ : integer;
  attribute C_RX_CB_NUM_SEQ of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_RX_CB_VAL : string;
  attribute C_RX_CB_VAL of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "80'b00000000000000000000000000000000000000000000000000000000000000000000000000000000";
  attribute C_RX_CC_DISP : string;
  attribute C_RX_CC_DISP of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "8'b00000000";
  attribute C_RX_CC_ENABLE : integer;
  attribute C_RX_CC_ENABLE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_RX_CC_K : string;
  attribute C_RX_CC_K of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "8'b00000000";
  attribute C_RX_CC_LEN_SEQ : integer;
  attribute C_RX_CC_LEN_SEQ of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_RX_CC_NUM_SEQ : integer;
  attribute C_RX_CC_NUM_SEQ of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_RX_CC_PERIODICITY : integer;
  attribute C_RX_CC_PERIODICITY of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 5000;
  attribute C_RX_CC_VAL : string;
  attribute C_RX_CC_VAL of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "80'b00000000000000000000000000000000000000000000000000000000000000000000000000000000";
  attribute C_RX_COMMA_M_ENABLE : integer;
  attribute C_RX_COMMA_M_ENABLE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_RX_COMMA_M_VAL : string;
  attribute C_RX_COMMA_M_VAL of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "10'b1010000011";
  attribute C_RX_COMMA_P_ENABLE : integer;
  attribute C_RX_COMMA_P_ENABLE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_RX_COMMA_P_VAL : string;
  attribute C_RX_COMMA_P_VAL of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "10'b0101111100";
  attribute C_RX_DATA_DECODING : integer;
  attribute C_RX_DATA_DECODING of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_RX_ENABLE : integer;
  attribute C_RX_ENABLE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_RX_INT_DATA_WIDTH : integer;
  attribute C_RX_INT_DATA_WIDTH of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 40;
  attribute C_RX_LINE_RATE : string;
  attribute C_RX_LINE_RATE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "12.285000";
  attribute C_RX_MASTER_CHANNEL_IDX : integer;
  attribute C_RX_MASTER_CHANNEL_IDX of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 103;
  attribute C_RX_OUTCLK_BUFG_GT_DIV : integer;
  attribute C_RX_OUTCLK_BUFG_GT_DIV of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_RX_OUTCLK_FREQUENCY : string;
  attribute C_RX_OUTCLK_FREQUENCY of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "307.125000";
  attribute C_RX_OUTCLK_SOURCE : integer;
  attribute C_RX_OUTCLK_SOURCE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_RX_PLL_TYPE : integer;
  attribute C_RX_PLL_TYPE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 2;
  attribute C_RX_RECCLK_OUTPUT : string;
  attribute C_RX_RECCLK_OUTPUT of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "192'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  attribute C_RX_REFCLK_FREQUENCY : string;
  attribute C_RX_REFCLK_FREQUENCY of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "307.125000";
  attribute C_RX_SLIDE_MODE : integer;
  attribute C_RX_SLIDE_MODE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_RX_USER_CLOCKING_CONTENTS : integer;
  attribute C_RX_USER_CLOCKING_CONTENTS of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_RX_USER_CLOCKING_INSTANCE_CTRL : integer;
  attribute C_RX_USER_CLOCKING_INSTANCE_CTRL of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_RX_USER_CLOCKING_RATIO_FSRC_FUSRCLK : integer;
  attribute C_RX_USER_CLOCKING_RATIO_FSRC_FUSRCLK of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_RX_USER_CLOCKING_RATIO_FUSRCLK_FUSRCLK2 : integer;
  attribute C_RX_USER_CLOCKING_RATIO_FUSRCLK_FUSRCLK2 of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_RX_USER_CLOCKING_SOURCE : integer;
  attribute C_RX_USER_CLOCKING_SOURCE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_RX_USER_DATA_WIDTH : integer;
  attribute C_RX_USER_DATA_WIDTH of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 32;
  attribute C_RX_USRCLK2_FREQUENCY : string;
  attribute C_RX_USRCLK2_FREQUENCY of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "307.125000";
  attribute C_RX_USRCLK_FREQUENCY : string;
  attribute C_RX_USRCLK_FREQUENCY of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "307.125000";
  attribute C_SECONDARY_QPLL_ENABLE : integer;
  attribute C_SECONDARY_QPLL_ENABLE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_SECONDARY_QPLL_REFCLK_FREQUENCY : string;
  attribute C_SECONDARY_QPLL_REFCLK_FREQUENCY of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "257.812500";
  attribute C_SIM_CPLL_CAL_BYPASS : string;
  attribute C_SIM_CPLL_CAL_BYPASS of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "1'b0";
  attribute C_TOTAL_NUM_CHANNELS : integer;
  attribute C_TOTAL_NUM_CHANNELS of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 7;
  attribute C_TOTAL_NUM_COMMONS : integer;
  attribute C_TOTAL_NUM_COMMONS of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_TOTAL_NUM_COMMONS_EXAMPLE : integer;
  attribute C_TOTAL_NUM_COMMONS_EXAMPLE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_TXPROGDIV_FREQ_ENABLE : integer;
  attribute C_TXPROGDIV_FREQ_ENABLE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_TXPROGDIV_FREQ_SOURCE : integer;
  attribute C_TXPROGDIV_FREQ_SOURCE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 2;
  attribute C_TXPROGDIV_FREQ_VAL : string;
  attribute C_TXPROGDIV_FREQ_VAL of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "307.125000";
  attribute C_TX_BUFFBYPASS_MODE : integer;
  attribute C_TX_BUFFBYPASS_MODE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_TX_BUFFER_BYPASS_INSTANCE_CTRL : integer;
  attribute C_TX_BUFFER_BYPASS_INSTANCE_CTRL of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_TX_BUFFER_MODE : integer;
  attribute C_TX_BUFFER_MODE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_TX_DATA_ENCODING : integer;
  attribute C_TX_DATA_ENCODING of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_TX_ENABLE : integer;
  attribute C_TX_ENABLE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_TX_INT_DATA_WIDTH : integer;
  attribute C_TX_INT_DATA_WIDTH of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 40;
  attribute C_TX_LINE_RATE : string;
  attribute C_TX_LINE_RATE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "12.285000";
  attribute C_TX_MASTER_CHANNEL_IDX : integer;
  attribute C_TX_MASTER_CHANNEL_IDX of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 103;
  attribute C_TX_OUTCLK_BUFG_GT_DIV : integer;
  attribute C_TX_OUTCLK_BUFG_GT_DIV of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_TX_OUTCLK_FREQUENCY : string;
  attribute C_TX_OUTCLK_FREQUENCY of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "307.125000";
  attribute C_TX_OUTCLK_SOURCE : integer;
  attribute C_TX_OUTCLK_SOURCE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 4;
  attribute C_TX_PLL_TYPE : integer;
  attribute C_TX_PLL_TYPE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 2;
  attribute C_TX_REFCLK_FREQUENCY : string;
  attribute C_TX_REFCLK_FREQUENCY of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "307.125000";
  attribute C_TX_USER_CLOCKING_CONTENTS : integer;
  attribute C_TX_USER_CLOCKING_CONTENTS of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_TX_USER_CLOCKING_INSTANCE_CTRL : integer;
  attribute C_TX_USER_CLOCKING_INSTANCE_CTRL of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_TX_USER_CLOCKING_RATIO_FSRC_FUSRCLK : integer;
  attribute C_TX_USER_CLOCKING_RATIO_FSRC_FUSRCLK of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_TX_USER_CLOCKING_RATIO_FUSRCLK_FUSRCLK2 : integer;
  attribute C_TX_USER_CLOCKING_RATIO_FUSRCLK_FUSRCLK2 of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 1;
  attribute C_TX_USER_CLOCKING_SOURCE : integer;
  attribute C_TX_USER_CLOCKING_SOURCE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 0;
  attribute C_TX_USER_DATA_WIDTH : integer;
  attribute C_TX_USER_DATA_WIDTH of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is 32;
  attribute C_TX_USRCLK2_FREQUENCY : string;
  attribute C_TX_USRCLK2_FREQUENCY of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "307.125000";
  attribute C_TX_USRCLK_FREQUENCY : string;
  attribute C_TX_USRCLK_FREQUENCY of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "307.125000";
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top : entity is "JesdCryoCoreRightColumn_gtwizard_top";
end JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top;

architecture STRUCTURE of JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top is
  signal \<const0>\ : STD_LOGIC;
  signal \^gtwiz_reset_qpll0lock_in\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^gtwiz_reset_qpll1lock_in\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^gtwiz_userclk_rx_active_in\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^gtwiz_userclk_tx_active_in\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^qpll0reset_in\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^qpll1reset_in\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^rxdata_out\ : STD_LOGIC_VECTOR ( 895 downto 0 );
begin
  \^gtwiz_reset_qpll0lock_in\(0) <= gtwiz_reset_qpll0lock_in(0);
  \^gtwiz_reset_qpll1lock_in\(0) <= gtwiz_reset_qpll1lock_in(0);
  \^gtwiz_userclk_rx_active_in\(0) <= gtwiz_userclk_rx_active_in(0);
  \^gtwiz_userclk_tx_active_in\(0) <= gtwiz_userclk_tx_active_in(0);
  \^qpll0reset_in\(0) <= qpll0reset_in(0);
  \^qpll1reset_in\(0) <= qpll1reset_in(0);
  dmonitoroutclk_out(0) <= \<const0>\;
  drpdo_common_out(15) <= \<const0>\;
  drpdo_common_out(14) <= \<const0>\;
  drpdo_common_out(13) <= \<const0>\;
  drpdo_common_out(12) <= \<const0>\;
  drpdo_common_out(11) <= \<const0>\;
  drpdo_common_out(10) <= \<const0>\;
  drpdo_common_out(9) <= \<const0>\;
  drpdo_common_out(8) <= \<const0>\;
  drpdo_common_out(7) <= \<const0>\;
  drpdo_common_out(6) <= \<const0>\;
  drpdo_common_out(5) <= \<const0>\;
  drpdo_common_out(4) <= \<const0>\;
  drpdo_common_out(3) <= \<const0>\;
  drpdo_common_out(2) <= \<const0>\;
  drpdo_common_out(1) <= \<const0>\;
  drpdo_common_out(0) <= \<const0>\;
  drprdy_common_out(0) <= \<const0>\;
  gtwiz_buffbypass_rx_done_out(0) <= \<const0>\;
  gtwiz_buffbypass_rx_error_out(0) <= \<const0>\;
  gtwiz_reset_qpll0reset_out(0) <= \^qpll0reset_in\(0);
  gtwiz_reset_qpll1reset_out(0) <= \^qpll1reset_in\(0);
  gtwiz_userclk_rx_active_out(0) <= \^gtwiz_userclk_rx_active_in\(0);
  gtwiz_userclk_rx_srcclk_out(0) <= \<const0>\;
  gtwiz_userclk_rx_usrclk2_out(0) <= \<const0>\;
  gtwiz_userclk_rx_usrclk_out(0) <= \<const0>\;
  gtwiz_userclk_tx_active_out(0) <= \^gtwiz_userclk_tx_active_in\(0);
  gtwiz_userclk_tx_srcclk_out(0) <= \<const0>\;
  gtwiz_userclk_tx_usrclk2_out(0) <= \<const0>\;
  gtwiz_userclk_tx_usrclk_out(0) <= \<const0>\;
  gtwiz_userdata_rx_out(223 downto 192) <= \^rxdata_out\(799 downto 768);
  gtwiz_userdata_rx_out(191 downto 160) <= \^rxdata_out\(671 downto 640);
  gtwiz_userdata_rx_out(159 downto 128) <= \^rxdata_out\(543 downto 512);
  gtwiz_userdata_rx_out(127 downto 96) <= \^rxdata_out\(415 downto 384);
  gtwiz_userdata_rx_out(95 downto 64) <= \^rxdata_out\(287 downto 256);
  gtwiz_userdata_rx_out(63 downto 32) <= \^rxdata_out\(159 downto 128);
  gtwiz_userdata_rx_out(31 downto 0) <= \^rxdata_out\(31 downto 0);
  gtytxn_out(0) <= \<const0>\;
  gtytxp_out(0) <= \<const0>\;
  pmarsvdout0_out(7) <= \<const0>\;
  pmarsvdout0_out(6) <= \<const0>\;
  pmarsvdout0_out(5) <= \<const0>\;
  pmarsvdout0_out(4) <= \<const0>\;
  pmarsvdout0_out(3) <= \<const0>\;
  pmarsvdout0_out(2) <= \<const0>\;
  pmarsvdout0_out(1) <= \<const0>\;
  pmarsvdout0_out(0) <= \<const0>\;
  pmarsvdout1_out(7) <= \<const0>\;
  pmarsvdout1_out(6) <= \<const0>\;
  pmarsvdout1_out(5) <= \<const0>\;
  pmarsvdout1_out(4) <= \<const0>\;
  pmarsvdout1_out(3) <= \<const0>\;
  pmarsvdout1_out(2) <= \<const0>\;
  pmarsvdout1_out(1) <= \<const0>\;
  pmarsvdout1_out(0) <= \<const0>\;
  powerpresent_out(0) <= \<const0>\;
  qpll0fbclklost_out(0) <= \<const0>\;
  qpll0lock_out(0) <= \^gtwiz_reset_qpll0lock_in\(0);
  qpll0outclk_out(0) <= \<const0>\;
  qpll0outrefclk_out(0) <= \<const0>\;
  qpll0refclklost_out(0) <= \<const0>\;
  qpll1fbclklost_out(0) <= \<const0>\;
  qpll1lock_out(0) <= \^gtwiz_reset_qpll1lock_in\(0);
  qpll1outclk_out(0) <= \<const0>\;
  qpll1outrefclk_out(0) <= \<const0>\;
  qpll1refclklost_out(0) <= \<const0>\;
  qplldmonitor0_out(7) <= \<const0>\;
  qplldmonitor0_out(6) <= \<const0>\;
  qplldmonitor0_out(5) <= \<const0>\;
  qplldmonitor0_out(4) <= \<const0>\;
  qplldmonitor0_out(3) <= \<const0>\;
  qplldmonitor0_out(2) <= \<const0>\;
  qplldmonitor0_out(1) <= \<const0>\;
  qplldmonitor0_out(0) <= \<const0>\;
  qplldmonitor1_out(7) <= \<const0>\;
  qplldmonitor1_out(6) <= \<const0>\;
  qplldmonitor1_out(5) <= \<const0>\;
  qplldmonitor1_out(4) <= \<const0>\;
  qplldmonitor1_out(3) <= \<const0>\;
  qplldmonitor1_out(2) <= \<const0>\;
  qplldmonitor1_out(1) <= \<const0>\;
  qplldmonitor1_out(0) <= \<const0>\;
  refclkoutmonitor0_out(0) <= \<const0>\;
  refclkoutmonitor1_out(0) <= \<const0>\;
  rxckcaldone_out(0) <= \<const0>\;
  rxdata_out(895 downto 0) <= \^rxdata_out\(895 downto 0);
  rxlfpstresetdet_out(0) <= \<const0>\;
  rxlfpsu2lpexitdet_out(0) <= \<const0>\;
  rxlfpsu3wakedet_out(0) <= \<const0>\;
  rxrecclk0_sel_out(1) <= \<const0>\;
  rxrecclk0_sel_out(0) <= \<const0>\;
  rxrecclk0sel_out(0) <= \<const0>\;
  rxrecclk1_sel_out(1) <= \<const0>\;
  rxrecclk1_sel_out(0) <= \<const0>\;
  rxrecclk1sel_out(0) <= \<const0>\;
  sdm0finalout_out(0) <= \<const0>\;
  sdm0testdata_out(0) <= \<const0>\;
  sdm1finalout_out(0) <= \<const0>\;
  sdm1testdata_out(0) <= \<const0>\;
  tcongpo_out(0) <= \<const0>\;
  tconrsvdout0_out(0) <= \<const0>\;
  txdccdone_out(0) <= \<const0>\;
  ubdaddr_out(0) <= \<const0>\;
  ubden_out(0) <= \<const0>\;
  ubdi_out(0) <= \<const0>\;
  ubdwe_out(0) <= \<const0>\;
  ubmdmtdo_out(0) <= \<const0>\;
  ubrsvdout_out(0) <= \<const0>\;
  ubtxuart_out(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\gen_gtwizard_gthe3_top.JesdCryoCoreRightColumn_gtwizard_gthe3_inst\: entity work.JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_gthe3
     port map (
      bufgtce_out(20 downto 0) => bufgtce_out(20 downto 0),
      bufgtcemask_out(20 downto 0) => bufgtcemask_out(20 downto 0),
      bufgtdiv_out(62 downto 0) => bufgtdiv_out(62 downto 0),
      bufgtreset_out(20 downto 0) => bufgtreset_out(20 downto 0),
      bufgtrstmask_out(20 downto 0) => bufgtrstmask_out(20 downto 0),
      cfgreset_in(6 downto 0) => cfgreset_in(6 downto 0),
      clkrsvd0_in(6 downto 0) => clkrsvd0_in(6 downto 0),
      clkrsvd1_in(6 downto 0) => clkrsvd1_in(6 downto 0),
      cpllfbclklost_out(6 downto 0) => cpllfbclklost_out(6 downto 0),
      cplllock_out(6 downto 0) => cplllock_out(6 downto 0),
      cplllockdetclk_in(6 downto 0) => cplllockdetclk_in(6 downto 0),
      cplllocken_in(6 downto 0) => cplllocken_in(6 downto 0),
      cpllrefclklost_out(6 downto 0) => cpllrefclklost_out(6 downto 0),
      cpllrefclksel_in(20 downto 0) => cpllrefclksel_in(20 downto 0),
      cpllreset_in(6 downto 0) => cpllreset_in(6 downto 0),
      dmonfiforeset_in(6 downto 0) => dmonfiforeset_in(6 downto 0),
      dmonitorclk_in(6 downto 0) => dmonitorclk_in(6 downto 0),
      dmonitorout_out(118 downto 0) => dmonitorout_out(118 downto 0),
      drpaddr_in(62 downto 0) => drpaddr_in(62 downto 0),
      drpclk_in(6 downto 0) => drpclk_in(6 downto 0),
      drpdi_in(111 downto 0) => drpdi_in(111 downto 0),
      drpdo_out(111 downto 0) => drpdo_out(111 downto 0),
      drpen_in(6 downto 0) => drpen_in(6 downto 0),
      drprdy_out(6 downto 0) => drprdy_out(6 downto 0),
      drpwe_in(6 downto 0) => drpwe_in(6 downto 0),
      evoddphicaldone_in(6 downto 0) => evoddphicaldone_in(6 downto 0),
      evoddphicalstart_in(6 downto 0) => evoddphicalstart_in(6 downto 0),
      evoddphidrden_in(6 downto 0) => evoddphidrden_in(6 downto 0),
      evoddphidwren_in(6 downto 0) => evoddphidwren_in(6 downto 0),
      evoddphixrden_in(6 downto 0) => evoddphixrden_in(6 downto 0),
      evoddphixwren_in(6 downto 0) => evoddphixwren_in(6 downto 0),
      eyescandataerror_out(6 downto 0) => eyescandataerror_out(6 downto 0),
      eyescanmode_in(6 downto 0) => eyescanmode_in(6 downto 0),
      eyescanreset_in(6 downto 0) => eyescanreset_in(6 downto 0),
      eyescantrigger_in(6 downto 0) => eyescantrigger_in(6 downto 0),
      gtgrefclk_in(6 downto 0) => gtgrefclk_in(6 downto 0),
      gthrxn_in(6 downto 0) => gthrxn_in(6 downto 0),
      gthrxp_in(6 downto 0) => gthrxp_in(6 downto 0),
      gthtxn_out(6 downto 0) => gthtxn_out(6 downto 0),
      gthtxp_out(6 downto 0) => gthtxp_out(6 downto 0),
      gtnorthrefclk0_in(6 downto 0) => gtnorthrefclk0_in(6 downto 0),
      gtnorthrefclk1_in(6 downto 0) => gtnorthrefclk1_in(6 downto 0),
      gtpowergood_out(6 downto 0) => gtpowergood_out(6 downto 0),
      gtrefclk0_in(6 downto 0) => gtrefclk0_in(6 downto 0),
      gtrefclk1_in(6 downto 0) => gtrefclk1_in(6 downto 0),
      gtrefclkmonitor_out(6 downto 0) => gtrefclkmonitor_out(6 downto 0),
      gtresetsel_in(6 downto 0) => gtresetsel_in(6 downto 0),
      gtrsvd_in(111 downto 0) => gtrsvd_in(111 downto 0),
      gtsouthrefclk0_in(6 downto 0) => gtsouthrefclk0_in(6 downto 0),
      gtsouthrefclk1_in(6 downto 0) => gtsouthrefclk1_in(6 downto 0),
      gtwiz_buffbypass_tx_done_out(0) => gtwiz_buffbypass_tx_done_out(0),
      gtwiz_buffbypass_tx_error_out(0) => gtwiz_buffbypass_tx_error_out(0),
      gtwiz_buffbypass_tx_reset_in(0) => gtwiz_buffbypass_tx_reset_in(0),
      gtwiz_buffbypass_tx_start_user_in(0) => gtwiz_buffbypass_tx_start_user_in(0),
      gtwiz_reset_all_in(0) => gtwiz_reset_all_in(0),
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_rx_cdr_stable_out(0) => gtwiz_reset_rx_cdr_stable_out(0),
      gtwiz_reset_rx_datapath_in(0) => gtwiz_reset_rx_datapath_in(0),
      gtwiz_reset_rx_done_out(0) => gtwiz_reset_rx_done_out(0),
      gtwiz_reset_rx_pll_and_datapath_in(0) => gtwiz_reset_rx_pll_and_datapath_in(0),
      gtwiz_reset_tx_datapath_in(0) => gtwiz_reset_tx_datapath_in(0),
      gtwiz_reset_tx_done_out(0) => gtwiz_reset_tx_done_out(0),
      gtwiz_reset_tx_pll_and_datapath_in(0) => gtwiz_reset_tx_pll_and_datapath_in(0),
      gtwiz_userclk_rx_active_in(0) => \^gtwiz_userclk_rx_active_in\(0),
      gtwiz_userclk_tx_active_in(0) => \^gtwiz_userclk_tx_active_in\(0),
      gtwiz_userdata_tx_in(223 downto 0) => gtwiz_userdata_tx_in(223 downto 0),
      loopback_in(20 downto 0) => loopback_in(20 downto 0),
      lpbkrxtxseren_in(6 downto 0) => lpbkrxtxseren_in(6 downto 0),
      lpbktxrxseren_in(6 downto 0) => lpbktxrxseren_in(6 downto 0),
      pcieeqrxeqadaptdone_in(6 downto 0) => pcieeqrxeqadaptdone_in(6 downto 0),
      pcierategen3_out(6 downto 0) => pcierategen3_out(6 downto 0),
      pcierateidle_out(6 downto 0) => pcierateidle_out(6 downto 0),
      pcierateqpllpd_out(13 downto 0) => pcierateqpllpd_out(13 downto 0),
      pcierateqpllreset_out(13 downto 0) => pcierateqpllreset_out(13 downto 0),
      pcierstidle_in(6 downto 0) => pcierstidle_in(6 downto 0),
      pciersttxsyncstart_in(6 downto 0) => pciersttxsyncstart_in(6 downto 0),
      pciesynctxsyncdone_out(6 downto 0) => pciesynctxsyncdone_out(6 downto 0),
      pcieusergen3rdy_out(6 downto 0) => pcieusergen3rdy_out(6 downto 0),
      pcieuserphystatusrst_out(6 downto 0) => pcieuserphystatusrst_out(6 downto 0),
      pcieuserratedone_in(6 downto 0) => pcieuserratedone_in(6 downto 0),
      pcieuserratestart_out(6 downto 0) => pcieuserratestart_out(6 downto 0),
      pcsrsvdin2_in(34 downto 0) => pcsrsvdin2_in(34 downto 0),
      pcsrsvdin_in(111 downto 0) => pcsrsvdin_in(111 downto 0),
      pcsrsvdout_out(83 downto 0) => pcsrsvdout_out(83 downto 0),
      phystatus_out(6 downto 0) => phystatus_out(6 downto 0),
      pinrsrvdas_out(55 downto 0) => pinrsrvdas_out(55 downto 0),
      pmarsvdin_in(34 downto 0) => pmarsvdin_in(34 downto 0),
      qpll0clk_in(6 downto 0) => qpll0clk_in(6 downto 0),
      qpll0refclk_in(6 downto 0) => qpll0refclk_in(6 downto 0),
      qpll1clk_in(6 downto 0) => qpll1clk_in(6 downto 0),
      qpll1refclk_in(6 downto 0) => qpll1refclk_in(6 downto 0),
      resetexception_out(6 downto 0) => resetexception_out(6 downto 0),
      resetovrd_in(6 downto 0) => resetovrd_in(6 downto 0),
      rstclkentx_in(6 downto 0) => rstclkentx_in(6 downto 0),
      rx8b10ben_in(6 downto 0) => rx8b10ben_in(6 downto 0),
      rxbufreset_in(6 downto 0) => rxbufreset_in(6 downto 0),
      rxbufstatus_out(20 downto 0) => rxbufstatus_out(20 downto 0),
      rxbyteisaligned_out(6 downto 0) => rxbyteisaligned_out(6 downto 0),
      rxbyterealign_out(6 downto 0) => rxbyterealign_out(6 downto 0),
      rxcdrfreqreset_in(6 downto 0) => rxcdrfreqreset_in(6 downto 0),
      rxcdrhold_in(6 downto 0) => rxcdrhold_in(6 downto 0),
      rxcdrlock_out(6 downto 0) => rxcdrlock_out(6 downto 0),
      rxcdrovrden_in(6 downto 0) => rxcdrovrden_in(6 downto 0),
      rxcdrphdone_out(6 downto 0) => rxcdrphdone_out(6 downto 0),
      rxcdrreset_in(6 downto 0) => rxcdrreset_in(6 downto 0),
      rxcdrresetrsv_in(6 downto 0) => rxcdrresetrsv_in(6 downto 0),
      rxchanbondseq_out(6 downto 0) => rxchanbondseq_out(6 downto 0),
      rxchanisaligned_out(6 downto 0) => rxchanisaligned_out(6 downto 0),
      rxchanrealign_out(6 downto 0) => rxchanrealign_out(6 downto 0),
      rxchbonden_in(6 downto 0) => rxchbonden_in(6 downto 0),
      rxchbondi_in(34 downto 0) => rxchbondi_in(34 downto 0),
      rxchbondlevel_in(20 downto 0) => rxchbondlevel_in(20 downto 0),
      rxchbondmaster_in(6 downto 0) => rxchbondmaster_in(6 downto 0),
      rxchbondo_out(34 downto 0) => rxchbondo_out(34 downto 0),
      rxchbondslave_in(6 downto 0) => rxchbondslave_in(6 downto 0),
      rxclkcorcnt_out(13 downto 0) => rxclkcorcnt_out(13 downto 0),
      rxcominitdet_out(6 downto 0) => rxcominitdet_out(6 downto 0),
      rxcommadet_out(6 downto 0) => rxcommadet_out(6 downto 0),
      rxcommadeten_in(6 downto 0) => rxcommadeten_in(6 downto 0),
      rxcomsasdet_out(6 downto 0) => rxcomsasdet_out(6 downto 0),
      rxcomwakedet_out(6 downto 0) => rxcomwakedet_out(6 downto 0),
      rxctrl0_out(111 downto 0) => rxctrl0_out(111 downto 0),
      rxctrl1_out(111 downto 0) => rxctrl1_out(111 downto 0),
      rxctrl2_out(55 downto 0) => rxctrl2_out(55 downto 0),
      rxctrl3_out(55 downto 0) => rxctrl3_out(55 downto 0),
      rxdata_out(895 downto 0) => \^rxdata_out\(895 downto 0),
      rxdataextendrsvd_out(55 downto 0) => rxdataextendrsvd_out(55 downto 0),
      rxdatavalid_out(13 downto 0) => rxdatavalid_out(13 downto 0),
      rxdfeagcctrl_in(13 downto 0) => rxdfeagcctrl_in(13 downto 0),
      rxdfeagchold_in(6 downto 0) => rxdfeagchold_in(6 downto 0),
      rxdfeagcovrden_in(6 downto 0) => rxdfeagcovrden_in(6 downto 0),
      rxdfelfhold_in(6 downto 0) => rxdfelfhold_in(6 downto 0),
      rxdfelfovrden_in(6 downto 0) => rxdfelfovrden_in(6 downto 0),
      rxdfelpmreset_in(6 downto 0) => rxdfelpmreset_in(6 downto 0),
      rxdfetap10hold_in(6 downto 0) => rxdfetap10hold_in(6 downto 0),
      rxdfetap10ovrden_in(6 downto 0) => rxdfetap10ovrden_in(6 downto 0),
      rxdfetap11hold_in(6 downto 0) => rxdfetap11hold_in(6 downto 0),
      rxdfetap11ovrden_in(6 downto 0) => rxdfetap11ovrden_in(6 downto 0),
      rxdfetap12hold_in(6 downto 0) => rxdfetap12hold_in(6 downto 0),
      rxdfetap12ovrden_in(6 downto 0) => rxdfetap12ovrden_in(6 downto 0),
      rxdfetap13hold_in(6 downto 0) => rxdfetap13hold_in(6 downto 0),
      rxdfetap13ovrden_in(6 downto 0) => rxdfetap13ovrden_in(6 downto 0),
      rxdfetap14hold_in(6 downto 0) => rxdfetap14hold_in(6 downto 0),
      rxdfetap14ovrden_in(6 downto 0) => rxdfetap14ovrden_in(6 downto 0),
      rxdfetap15hold_in(6 downto 0) => rxdfetap15hold_in(6 downto 0),
      rxdfetap15ovrden_in(6 downto 0) => rxdfetap15ovrden_in(6 downto 0),
      rxdfetap2hold_in(6 downto 0) => rxdfetap2hold_in(6 downto 0),
      rxdfetap2ovrden_in(6 downto 0) => rxdfetap2ovrden_in(6 downto 0),
      rxdfetap3hold_in(6 downto 0) => rxdfetap3hold_in(6 downto 0),
      rxdfetap3ovrden_in(6 downto 0) => rxdfetap3ovrden_in(6 downto 0),
      rxdfetap4hold_in(6 downto 0) => rxdfetap4hold_in(6 downto 0),
      rxdfetap4ovrden_in(6 downto 0) => rxdfetap4ovrden_in(6 downto 0),
      rxdfetap5hold_in(6 downto 0) => rxdfetap5hold_in(6 downto 0),
      rxdfetap5ovrden_in(6 downto 0) => rxdfetap5ovrden_in(6 downto 0),
      rxdfetap6hold_in(6 downto 0) => rxdfetap6hold_in(6 downto 0),
      rxdfetap6ovrden_in(6 downto 0) => rxdfetap6ovrden_in(6 downto 0),
      rxdfetap7hold_in(6 downto 0) => rxdfetap7hold_in(6 downto 0),
      rxdfetap7ovrden_in(6 downto 0) => rxdfetap7ovrden_in(6 downto 0),
      rxdfetap8hold_in(6 downto 0) => rxdfetap8hold_in(6 downto 0),
      rxdfetap8ovrden_in(6 downto 0) => rxdfetap8ovrden_in(6 downto 0),
      rxdfetap9hold_in(6 downto 0) => rxdfetap9hold_in(6 downto 0),
      rxdfetap9ovrden_in(6 downto 0) => rxdfetap9ovrden_in(6 downto 0),
      rxdfeuthold_in(6 downto 0) => rxdfeuthold_in(6 downto 0),
      rxdfeutovrden_in(6 downto 0) => rxdfeutovrden_in(6 downto 0),
      rxdfevphold_in(6 downto 0) => rxdfevphold_in(6 downto 0),
      rxdfevpovrden_in(6 downto 0) => rxdfevpovrden_in(6 downto 0),
      rxdfevsen_in(6 downto 0) => rxdfevsen_in(6 downto 0),
      rxdfexyden_in(6 downto 0) => rxdfexyden_in(6 downto 0),
      rxdlybypass_in(6 downto 0) => rxdlybypass_in(6 downto 0),
      rxdlyen_in(6 downto 0) => rxdlyen_in(6 downto 0),
      rxdlyovrden_in(6 downto 0) => rxdlyovrden_in(6 downto 0),
      rxdlysreset_in(6 downto 0) => rxdlysreset_in(6 downto 0),
      rxdlysresetdone_out(6 downto 0) => rxdlysresetdone_out(6 downto 0),
      rxelecidle_out(6 downto 0) => rxelecidle_out(6 downto 0),
      rxelecidlemode_in(13 downto 0) => rxelecidlemode_in(13 downto 0),
      rxgearboxslip_in(6 downto 0) => rxgearboxslip_in(6 downto 0),
      rxheader_out(41 downto 0) => rxheader_out(41 downto 0),
      rxheadervalid_out(13 downto 0) => rxheadervalid_out(13 downto 0),
      rxlatclk_in(6 downto 0) => rxlatclk_in(6 downto 0),
      rxlpmen_in(6 downto 0) => rxlpmen_in(6 downto 0),
      rxlpmgchold_in(6 downto 0) => rxlpmgchold_in(6 downto 0),
      rxlpmgcovrden_in(6 downto 0) => rxlpmgcovrden_in(6 downto 0),
      rxlpmhfhold_in(6 downto 0) => rxlpmhfhold_in(6 downto 0),
      rxlpmhfovrden_in(6 downto 0) => rxlpmhfovrden_in(6 downto 0),
      rxlpmlfhold_in(6 downto 0) => rxlpmlfhold_in(6 downto 0),
      rxlpmlfklovrden_in(6 downto 0) => rxlpmlfklovrden_in(6 downto 0),
      rxlpmoshold_in(6 downto 0) => rxlpmoshold_in(6 downto 0),
      rxlpmosovrden_in(6 downto 0) => rxlpmosovrden_in(6 downto 0),
      rxmcommaalignen_in(6 downto 0) => rxmcommaalignen_in(6 downto 0),
      rxmonitorout_out(48 downto 0) => rxmonitorout_out(48 downto 0),
      rxmonitorsel_in(13 downto 0) => rxmonitorsel_in(13 downto 0),
      rxoobreset_in(6 downto 0) => rxoobreset_in(6 downto 0),
      rxoscalreset_in(6 downto 0) => rxoscalreset_in(6 downto 0),
      rxoshold_in(6 downto 0) => rxoshold_in(6 downto 0),
      rxosintcfg_in(27 downto 0) => rxosintcfg_in(27 downto 0),
      rxosintdone_out(6 downto 0) => rxosintdone_out(6 downto 0),
      rxosinten_in(6 downto 0) => rxosinten_in(6 downto 0),
      rxosinthold_in(6 downto 0) => rxosinthold_in(6 downto 0),
      rxosintovrden_in(6 downto 0) => rxosintovrden_in(6 downto 0),
      rxosintstarted_out(6 downto 0) => rxosintstarted_out(6 downto 0),
      rxosintstrobe_in(6 downto 0) => rxosintstrobe_in(6 downto 0),
      rxosintstrobedone_out(6 downto 0) => rxosintstrobedone_out(6 downto 0),
      rxosintstrobestarted_out(6 downto 0) => rxosintstrobestarted_out(6 downto 0),
      rxosinttestovrden_in(6 downto 0) => rxosinttestovrden_in(6 downto 0),
      rxosovrden_in(6 downto 0) => rxosovrden_in(6 downto 0),
      rxoutclk_out(6 downto 0) => rxoutclk_out(6 downto 0),
      rxoutclkfabric_out(6 downto 0) => rxoutclkfabric_out(6 downto 0),
      rxoutclkpcs_out(6 downto 0) => rxoutclkpcs_out(6 downto 0),
      rxoutclksel_in(20 downto 0) => rxoutclksel_in(20 downto 0),
      rxpcommaalignen_in(6 downto 0) => rxpcommaalignen_in(6 downto 0),
      rxpcsreset_in(6 downto 0) => rxpcsreset_in(6 downto 0),
      rxpd_in(13 downto 0) => rxpd_in(13 downto 0),
      rxphalign_in(6 downto 0) => rxphalign_in(6 downto 0),
      rxphaligndone_out(6 downto 0) => rxphaligndone_out(6 downto 0),
      rxphalignen_in(6 downto 0) => rxphalignen_in(6 downto 0),
      rxphalignerr_out(6 downto 0) => rxphalignerr_out(6 downto 0),
      rxphdlypd_in(6 downto 0) => rxphdlypd_in(6 downto 0),
      rxphdlyreset_in(6 downto 0) => rxphdlyreset_in(6 downto 0),
      rxphovrden_in(6 downto 0) => rxphovrden_in(6 downto 0),
      rxpllclksel_in(13 downto 0) => rxpllclksel_in(13 downto 0),
      rxpmareset_in(6 downto 0) => rxpmareset_in(6 downto 0),
      rxpmaresetdone_out(6 downto 0) => rxpmaresetdone_out(6 downto 0),
      rxpolarity_in(6 downto 0) => rxpolarity_in(6 downto 0),
      rxprbscntreset_in(6 downto 0) => rxprbscntreset_in(6 downto 0),
      rxprbserr_out(6 downto 0) => rxprbserr_out(6 downto 0),
      rxprbslocked_out(6 downto 0) => rxprbslocked_out(6 downto 0),
      rxprbssel_in(27 downto 0) => rxprbssel_in(27 downto 0),
      rxprgdivresetdone_out(6 downto 0) => rxprgdivresetdone_out(6 downto 0),
      rxqpien_in(6 downto 0) => rxqpien_in(6 downto 0),
      rxqpisenn_out(6 downto 0) => rxqpisenn_out(6 downto 0),
      rxqpisenp_out(6 downto 0) => rxqpisenp_out(6 downto 0),
      rxrate_in(20 downto 0) => rxrate_in(20 downto 0),
      rxratedone_out(6 downto 0) => rxratedone_out(6 downto 0),
      rxratemode_in(6 downto 0) => rxratemode_in(6 downto 0),
      rxrecclkout_out(6 downto 0) => rxrecclkout_out(6 downto 0),
      rxresetdone_out(6 downto 0) => rxresetdone_out(6 downto 0),
      rxslide_in(6 downto 0) => rxslide_in(6 downto 0),
      rxsliderdy_out(6 downto 0) => rxsliderdy_out(6 downto 0),
      rxslipdone_out(6 downto 0) => rxslipdone_out(6 downto 0),
      rxslipoutclk_in(6 downto 0) => rxslipoutclk_in(6 downto 0),
      rxslipoutclkrdy_out(6 downto 0) => rxslipoutclkrdy_out(6 downto 0),
      rxslippma_in(6 downto 0) => rxslippma_in(6 downto 0),
      rxslippmardy_out(6 downto 0) => rxslippmardy_out(6 downto 0),
      rxstartofseq_out(13 downto 0) => rxstartofseq_out(13 downto 0),
      rxstatus_out(20 downto 0) => rxstatus_out(20 downto 0),
      rxsyncallin_in(6 downto 0) => rxsyncallin_in(6 downto 0),
      rxsyncdone_out(6 downto 0) => rxsyncdone_out(6 downto 0),
      rxsyncin_in(6 downto 0) => rxsyncin_in(6 downto 0),
      rxsyncmode_in(6 downto 0) => rxsyncmode_in(6 downto 0),
      rxsyncout_out(6 downto 0) => rxsyncout_out(6 downto 0),
      rxsysclksel_in(13 downto 0) => rxsysclksel_in(13 downto 0),
      rxusrclk2_in(6 downto 0) => rxusrclk2_in(6 downto 0),
      rxusrclk_in(6 downto 0) => rxusrclk_in(6 downto 0),
      rxvalid_out(6 downto 0) => rxvalid_out(6 downto 0),
      sigvalidclk_in(6 downto 0) => sigvalidclk_in(6 downto 0),
      tx8b10bbypass_in(55 downto 0) => tx8b10bbypass_in(55 downto 0),
      tx8b10ben_in(6 downto 0) => tx8b10ben_in(6 downto 0),
      txbufdiffctrl_in(20 downto 0) => txbufdiffctrl_in(20 downto 0),
      txbufstatus_out(13 downto 0) => txbufstatus_out(13 downto 0),
      txcomfinish_out(6 downto 0) => txcomfinish_out(6 downto 0),
      txcominit_in(6 downto 0) => txcominit_in(6 downto 0),
      txcomsas_in(6 downto 0) => txcomsas_in(6 downto 0),
      txcomwake_in(6 downto 0) => txcomwake_in(6 downto 0),
      txctrl0_in(111 downto 0) => txctrl0_in(111 downto 0),
      txctrl1_in(111 downto 0) => txctrl1_in(111 downto 0),
      txctrl2_in(55 downto 0) => txctrl2_in(55 downto 0),
      txdataextendrsvd_in(55 downto 0) => txdataextendrsvd_in(55 downto 0),
      txdeemph_in(6 downto 0) => txdeemph_in(6 downto 0),
      txdetectrx_in(6 downto 0) => txdetectrx_in(6 downto 0),
      txdiffctrl_in(27 downto 0) => txdiffctrl_in(27 downto 0),
      txdiffpd_in(6 downto 0) => txdiffpd_in(6 downto 0),
      txdlysresetdone_out(6 downto 0) => txdlysresetdone_out(6 downto 0),
      txelecidle_in(6 downto 0) => txelecidle_in(6 downto 0),
      txheader_in(41 downto 0) => txheader_in(41 downto 0),
      txinhibit_in(6 downto 0) => txinhibit_in(6 downto 0),
      txlatclk_in(6 downto 0) => txlatclk_in(6 downto 0),
      txmaincursor_in(48 downto 0) => txmaincursor_in(48 downto 0),
      txmargin_in(20 downto 0) => txmargin_in(20 downto 0),
      txoutclk_out(6 downto 0) => txoutclk_out(6 downto 0),
      txoutclkfabric_out(6 downto 0) => txoutclkfabric_out(6 downto 0),
      txoutclkpcs_out(6 downto 0) => txoutclkpcs_out(6 downto 0),
      txoutclksel_in(20 downto 0) => txoutclksel_in(20 downto 0),
      txpcsreset_in(6 downto 0) => txpcsreset_in(6 downto 0),
      txpd_in(13 downto 0) => txpd_in(13 downto 0),
      txpdelecidlemode_in(6 downto 0) => txpdelecidlemode_in(6 downto 0),
      txphaligndone_out(6 downto 0) => txphaligndone_out(6 downto 0),
      txphinitdone_out(6 downto 0) => txphinitdone_out(6 downto 0),
      txpippmen_in(6 downto 0) => txpippmen_in(6 downto 0),
      txpippmovrden_in(6 downto 0) => txpippmovrden_in(6 downto 0),
      txpippmpd_in(6 downto 0) => txpippmpd_in(6 downto 0),
      txpippmsel_in(6 downto 0) => txpippmsel_in(6 downto 0),
      txpippmstepsize_in(34 downto 0) => txpippmstepsize_in(34 downto 0),
      txpisopd_in(6 downto 0) => txpisopd_in(6 downto 0),
      txpllclksel_in(13 downto 0) => txpllclksel_in(13 downto 0),
      txpmareset_in(6 downto 0) => txpmareset_in(6 downto 0),
      txpmaresetdone_out(6 downto 0) => txpmaresetdone_out(6 downto 0),
      txpolarity_in(6 downto 0) => txpolarity_in(6 downto 0),
      txpostcursor_in(34 downto 0) => txpostcursor_in(34 downto 0),
      txpostcursorinv_in(6 downto 0) => txpostcursorinv_in(6 downto 0),
      txprbsforceerr_in(6 downto 0) => txprbsforceerr_in(6 downto 0),
      txprbssel_in(27 downto 0) => txprbssel_in(27 downto 0),
      txprecursor_in(34 downto 0) => txprecursor_in(34 downto 0),
      txprecursorinv_in(6 downto 0) => txprecursorinv_in(6 downto 0),
      txprgdivresetdone_out(6 downto 0) => txprgdivresetdone_out(6 downto 0),
      txqpibiasen_in(6 downto 0) => txqpibiasen_in(6 downto 0),
      txqpisenn_out(6 downto 0) => txqpisenn_out(6 downto 0),
      txqpisenp_out(6 downto 0) => txqpisenp_out(6 downto 0),
      txqpistrongpdown_in(6 downto 0) => txqpistrongpdown_in(6 downto 0),
      txqpiweakpup_in(6 downto 0) => txqpiweakpup_in(6 downto 0),
      txrate_in(20 downto 0) => txrate_in(20 downto 0),
      txratedone_out(6 downto 0) => txratedone_out(6 downto 0),
      txratemode_in(6 downto 0) => txratemode_in(6 downto 0),
      txresetdone_out(6 downto 0) => txresetdone_out(6 downto 0),
      txsequence_in(48 downto 0) => txsequence_in(48 downto 0),
      txswing_in(6 downto 0) => txswing_in(6 downto 0),
      txsyncdone_out(6 downto 0) => txsyncdone_out(6 downto 0),
      txsyncout_out(6 downto 0) => txsyncout_out(6 downto 0),
      txsysclksel_in(13 downto 0) => txsysclksel_in(13 downto 0),
      txusrclk2_in(6 downto 0) => txusrclk2_in(6 downto 0),
      txusrclk_in(6 downto 0) => txusrclk_in(6 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JesdCryoCoreRightColumn is
  port (
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
    gtwiz_userdata_tx_in : in STD_LOGIC_VECTOR ( 223 downto 0 );
    gtwiz_userdata_rx_out : out STD_LOGIC_VECTOR ( 223 downto 0 );
    drpaddr_in : in STD_LOGIC_VECTOR ( 62 downto 0 );
    drpclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    drpdi_in : in STD_LOGIC_VECTOR ( 111 downto 0 );
    drpen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    drpwe_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gthrxn_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gthrxp_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    gtrefclk0_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rx8b10ben_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcommadeten_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxmcommaalignen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxpcommaalignen_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxpd_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    rxpolarity_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxusrclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    rxusrclk2_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    tx8b10ben_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txctrl0_in : in STD_LOGIC_VECTOR ( 111 downto 0 );
    txctrl1_in : in STD_LOGIC_VECTOR ( 111 downto 0 );
    txctrl2_in : in STD_LOGIC_VECTOR ( 55 downto 0 );
    txdiffctrl_in : in STD_LOGIC_VECTOR ( 27 downto 0 );
    txpd_in : in STD_LOGIC_VECTOR ( 13 downto 0 );
    txpolarity_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txusrclk_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    txusrclk2_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    drpdo_out : out STD_LOGIC_VECTOR ( 111 downto 0 );
    drprdy_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gthtxn_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gthtxp_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxbyteisaligned_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxbyterealign_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxcommadet_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxctrl0_out : out STD_LOGIC_VECTOR ( 111 downto 0 );
    rxctrl1_out : out STD_LOGIC_VECTOR ( 111 downto 0 );
    rxctrl2_out : out STD_LOGIC_VECTOR ( 55 downto 0 );
    rxctrl3_out : out STD_LOGIC_VECTOR ( 55 downto 0 );
    rxoutclk_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rxpmaresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txoutclk_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txpmaresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    txprgdivresetdone_out : out STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of JesdCryoCoreRightColumn : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of JesdCryoCoreRightColumn : entity is "JesdCryoCoreRightColumn,JesdCryoCoreRightColumn_gtwizard_top,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of JesdCryoCoreRightColumn : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of JesdCryoCoreRightColumn : entity is "JesdCryoCoreRightColumn_gtwizard_top,Vivado 2016.4";
end JesdCryoCoreRightColumn;

architecture STRUCTURE of JesdCryoCoreRightColumn is
  signal NLW_inst_bufgtce_out_UNCONNECTED : STD_LOGIC_VECTOR ( 20 downto 0 );
  signal NLW_inst_bufgtcemask_out_UNCONNECTED : STD_LOGIC_VECTOR ( 20 downto 0 );
  signal NLW_inst_bufgtdiv_out_UNCONNECTED : STD_LOGIC_VECTOR ( 62 downto 0 );
  signal NLW_inst_bufgtreset_out_UNCONNECTED : STD_LOGIC_VECTOR ( 20 downto 0 );
  signal NLW_inst_bufgtrstmask_out_UNCONNECTED : STD_LOGIC_VECTOR ( 20 downto 0 );
  signal NLW_inst_cpllfbclklost_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_cplllock_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_cpllrefclklost_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_dmonitorout_out_UNCONNECTED : STD_LOGIC_VECTOR ( 118 downto 0 );
  signal NLW_inst_dmonitoroutclk_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_drpdo_common_out_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_inst_drprdy_common_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_eyescandataerror_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_gtpowergood_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_gtrefclkmonitor_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_gtwiz_buffbypass_rx_done_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_gtwiz_buffbypass_rx_error_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_gtwiz_reset_qpll0reset_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_gtwiz_reset_qpll1reset_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_gtwiz_userclk_rx_active_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_gtwiz_userclk_rx_srcclk_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_gtwiz_userclk_rx_usrclk2_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_gtwiz_userclk_rx_usrclk_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_gtwiz_userclk_tx_active_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_gtwiz_userclk_tx_srcclk_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_gtwiz_userclk_tx_usrclk2_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_gtwiz_userclk_tx_usrclk_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_gtytxn_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_gtytxp_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_pcierategen3_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_pcierateidle_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_pcierateqpllpd_out_UNCONNECTED : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal NLW_inst_pcierateqpllreset_out_UNCONNECTED : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal NLW_inst_pciesynctxsyncdone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_pcieusergen3rdy_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_pcieuserphystatusrst_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_pcieuserratestart_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_pcsrsvdout_out_UNCONNECTED : STD_LOGIC_VECTOR ( 83 downto 0 );
  signal NLW_inst_phystatus_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_pinrsrvdas_out_UNCONNECTED : STD_LOGIC_VECTOR ( 55 downto 0 );
  signal NLW_inst_pmarsvdout0_out_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_inst_pmarsvdout1_out_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_inst_powerpresent_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_qpll0fbclklost_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_qpll0lock_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_qpll0outclk_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_qpll0outrefclk_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_qpll0refclklost_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_qpll1fbclklost_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_qpll1lock_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_qpll1outclk_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_qpll1outrefclk_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_qpll1refclklost_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_qplldmonitor0_out_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_inst_qplldmonitor1_out_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_inst_refclkoutmonitor0_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_refclkoutmonitor1_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_resetexception_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxbufstatus_out_UNCONNECTED : STD_LOGIC_VECTOR ( 20 downto 0 );
  signal NLW_inst_rxcdrlock_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxcdrphdone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxchanbondseq_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxchanisaligned_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxchanrealign_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxchbondo_out_UNCONNECTED : STD_LOGIC_VECTOR ( 34 downto 0 );
  signal NLW_inst_rxckcaldone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_rxclkcorcnt_out_UNCONNECTED : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal NLW_inst_rxcominitdet_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxcomsasdet_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxcomwakedet_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxdata_out_UNCONNECTED : STD_LOGIC_VECTOR ( 895 downto 0 );
  signal NLW_inst_rxdataextendrsvd_out_UNCONNECTED : STD_LOGIC_VECTOR ( 55 downto 0 );
  signal NLW_inst_rxdatavalid_out_UNCONNECTED : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal NLW_inst_rxdlysresetdone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxelecidle_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxheader_out_UNCONNECTED : STD_LOGIC_VECTOR ( 41 downto 0 );
  signal NLW_inst_rxheadervalid_out_UNCONNECTED : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal NLW_inst_rxlfpstresetdet_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_rxlfpsu2lpexitdet_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_rxlfpsu3wakedet_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_rxmonitorout_out_UNCONNECTED : STD_LOGIC_VECTOR ( 48 downto 0 );
  signal NLW_inst_rxosintdone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxosintstarted_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxosintstrobedone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxosintstrobestarted_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxoutclkfabric_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxoutclkpcs_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxphaligndone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxphalignerr_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxprbserr_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxprbslocked_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxprgdivresetdone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxqpisenn_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxqpisenp_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxratedone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxrecclk0_sel_out_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_rxrecclk0sel_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_rxrecclk1_sel_out_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_rxrecclk1sel_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_rxrecclkout_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxresetdone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxsliderdy_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxslipdone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxslipoutclkrdy_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxslippmardy_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxstartofseq_out_UNCONNECTED : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal NLW_inst_rxstatus_out_UNCONNECTED : STD_LOGIC_VECTOR ( 20 downto 0 );
  signal NLW_inst_rxsyncdone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxsyncout_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_rxvalid_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_sdm0finalout_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_sdm0testdata_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_sdm1finalout_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_sdm1testdata_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_tcongpo_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_tconrsvdout0_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_txbufstatus_out_UNCONNECTED : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal NLW_inst_txcomfinish_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_txdccdone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_txdlysresetdone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_txoutclkfabric_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_txoutclkpcs_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_txphaligndone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_txphinitdone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_txqpisenn_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_txqpisenp_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_txratedone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_txresetdone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_txsyncdone_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_txsyncout_out_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_inst_ubdaddr_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_ubden_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_ubdi_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_ubdwe_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_ubmdmtdo_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_ubrsvdout_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_ubtxuart_out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute C_CHANNEL_ENABLE : string;
  attribute C_CHANNEL_ENABLE of inst : label is "192'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011110111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  attribute C_COMMON_SCALING_FACTOR : integer;
  attribute C_COMMON_SCALING_FACTOR of inst : label is 1;
  attribute C_CPLL_VCO_FREQUENCY : string;
  attribute C_CPLL_VCO_FREQUENCY of inst : label is "6142.500000";
  attribute C_FORCE_COMMONS : integer;
  attribute C_FORCE_COMMONS of inst : label is 0;
  attribute C_FREERUN_FREQUENCY : string;
  attribute C_FREERUN_FREQUENCY of inst : label is "200.000000";
  attribute C_GT_REV : integer;
  attribute C_GT_REV of inst : label is 17;
  attribute C_GT_TYPE : integer;
  attribute C_GT_TYPE of inst : label is 0;
  attribute C_INCLUDE_CPLL_CAL : integer;
  attribute C_INCLUDE_CPLL_CAL of inst : label is 2;
  attribute C_LOCATE_COMMON : integer;
  attribute C_LOCATE_COMMON of inst : label is 0;
  attribute C_LOCATE_IN_SYSTEM_IBERT_CORE : integer;
  attribute C_LOCATE_IN_SYSTEM_IBERT_CORE of inst : label is 2;
  attribute C_LOCATE_RESET_CONTROLLER : integer;
  attribute C_LOCATE_RESET_CONTROLLER of inst : label is 0;
  attribute C_LOCATE_RX_BUFFER_BYPASS_CONTROLLER : integer;
  attribute C_LOCATE_RX_BUFFER_BYPASS_CONTROLLER of inst : label is 0;
  attribute C_LOCATE_RX_USER_CLOCKING : integer;
  attribute C_LOCATE_RX_USER_CLOCKING of inst : label is 1;
  attribute C_LOCATE_TX_BUFFER_BYPASS_CONTROLLER : integer;
  attribute C_LOCATE_TX_BUFFER_BYPASS_CONTROLLER of inst : label is 0;
  attribute C_LOCATE_TX_USER_CLOCKING : integer;
  attribute C_LOCATE_TX_USER_CLOCKING of inst : label is 1;
  attribute C_LOCATE_USER_DATA_WIDTH_SIZING : integer;
  attribute C_LOCATE_USER_DATA_WIDTH_SIZING of inst : label is 0;
  attribute C_PCIE_CORECLK_FREQ : integer;
  attribute C_PCIE_CORECLK_FREQ of inst : label is 250;
  attribute C_PCIE_ENABLE : integer;
  attribute C_PCIE_ENABLE of inst : label is 0;
  attribute C_RESET_CONTROLLER_INSTANCE_CTRL : integer;
  attribute C_RESET_CONTROLLER_INSTANCE_CTRL of inst : label is 0;
  attribute C_RESET_SEQUENCE_INTERVAL : integer;
  attribute C_RESET_SEQUENCE_INTERVAL of inst : label is 0;
  attribute C_RX_BUFFBYPASS_MODE : integer;
  attribute C_RX_BUFFBYPASS_MODE of inst : label is 0;
  attribute C_RX_BUFFER_BYPASS_INSTANCE_CTRL : integer;
  attribute C_RX_BUFFER_BYPASS_INSTANCE_CTRL of inst : label is 0;
  attribute C_RX_BUFFER_MODE : integer;
  attribute C_RX_BUFFER_MODE of inst : label is 1;
  attribute C_RX_CB_DISP : string;
  attribute C_RX_CB_DISP of inst : label is "8'b00000000";
  attribute C_RX_CB_K : string;
  attribute C_RX_CB_K of inst : label is "8'b00000000";
  attribute C_RX_CB_LEN_SEQ : integer;
  attribute C_RX_CB_LEN_SEQ of inst : label is 1;
  attribute C_RX_CB_MAX_LEVEL : integer;
  attribute C_RX_CB_MAX_LEVEL of inst : label is 3;
  attribute C_RX_CB_NUM_SEQ : integer;
  attribute C_RX_CB_NUM_SEQ of inst : label is 0;
  attribute C_RX_CB_VAL : string;
  attribute C_RX_CB_VAL of inst : label is "80'b00000000000000000000000000000000000000000000000000000000000000000000000000000000";
  attribute C_RX_CC_DISP : string;
  attribute C_RX_CC_DISP of inst : label is "8'b00000000";
  attribute C_RX_CC_ENABLE : integer;
  attribute C_RX_CC_ENABLE of inst : label is 0;
  attribute C_RX_CC_K : string;
  attribute C_RX_CC_K of inst : label is "8'b00000000";
  attribute C_RX_CC_LEN_SEQ : integer;
  attribute C_RX_CC_LEN_SEQ of inst : label is 1;
  attribute C_RX_CC_NUM_SEQ : integer;
  attribute C_RX_CC_NUM_SEQ of inst : label is 0;
  attribute C_RX_CC_PERIODICITY : integer;
  attribute C_RX_CC_PERIODICITY of inst : label is 5000;
  attribute C_RX_CC_VAL : string;
  attribute C_RX_CC_VAL of inst : label is "80'b00000000000000000000000000000000000000000000000000000000000000000000000000000000";
  attribute C_RX_COMMA_M_ENABLE : integer;
  attribute C_RX_COMMA_M_ENABLE of inst : label is 1;
  attribute C_RX_COMMA_M_VAL : string;
  attribute C_RX_COMMA_M_VAL of inst : label is "10'b1010000011";
  attribute C_RX_COMMA_P_ENABLE : integer;
  attribute C_RX_COMMA_P_ENABLE of inst : label is 1;
  attribute C_RX_COMMA_P_VAL : string;
  attribute C_RX_COMMA_P_VAL of inst : label is "10'b0101111100";
  attribute C_RX_DATA_DECODING : integer;
  attribute C_RX_DATA_DECODING of inst : label is 1;
  attribute C_RX_ENABLE : integer;
  attribute C_RX_ENABLE of inst : label is 1;
  attribute C_RX_INT_DATA_WIDTH : integer;
  attribute C_RX_INT_DATA_WIDTH of inst : label is 40;
  attribute C_RX_LINE_RATE : string;
  attribute C_RX_LINE_RATE of inst : label is "12.285000";
  attribute C_RX_MASTER_CHANNEL_IDX : integer;
  attribute C_RX_MASTER_CHANNEL_IDX of inst : label is 103;
  attribute C_RX_OUTCLK_BUFG_GT_DIV : integer;
  attribute C_RX_OUTCLK_BUFG_GT_DIV of inst : label is 1;
  attribute C_RX_OUTCLK_FREQUENCY : string;
  attribute C_RX_OUTCLK_FREQUENCY of inst : label is "307.125000";
  attribute C_RX_OUTCLK_SOURCE : integer;
  attribute C_RX_OUTCLK_SOURCE of inst : label is 1;
  attribute C_RX_PLL_TYPE : integer;
  attribute C_RX_PLL_TYPE of inst : label is 2;
  attribute C_RX_RECCLK_OUTPUT : string;
  attribute C_RX_RECCLK_OUTPUT of inst : label is "192'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  attribute C_RX_REFCLK_FREQUENCY : string;
  attribute C_RX_REFCLK_FREQUENCY of inst : label is "307.125000";
  attribute C_RX_SLIDE_MODE : integer;
  attribute C_RX_SLIDE_MODE of inst : label is 0;
  attribute C_RX_USER_CLOCKING_CONTENTS : integer;
  attribute C_RX_USER_CLOCKING_CONTENTS of inst : label is 0;
  attribute C_RX_USER_CLOCKING_INSTANCE_CTRL : integer;
  attribute C_RX_USER_CLOCKING_INSTANCE_CTRL of inst : label is 0;
  attribute C_RX_USER_CLOCKING_RATIO_FSRC_FUSRCLK : integer;
  attribute C_RX_USER_CLOCKING_RATIO_FSRC_FUSRCLK of inst : label is 1;
  attribute C_RX_USER_CLOCKING_RATIO_FUSRCLK_FUSRCLK2 : integer;
  attribute C_RX_USER_CLOCKING_RATIO_FUSRCLK_FUSRCLK2 of inst : label is 1;
  attribute C_RX_USER_CLOCKING_SOURCE : integer;
  attribute C_RX_USER_CLOCKING_SOURCE of inst : label is 0;
  attribute C_RX_USER_DATA_WIDTH : integer;
  attribute C_RX_USER_DATA_WIDTH of inst : label is 32;
  attribute C_RX_USRCLK2_FREQUENCY : string;
  attribute C_RX_USRCLK2_FREQUENCY of inst : label is "307.125000";
  attribute C_RX_USRCLK_FREQUENCY : string;
  attribute C_RX_USRCLK_FREQUENCY of inst : label is "307.125000";
  attribute C_SECONDARY_QPLL_ENABLE : integer;
  attribute C_SECONDARY_QPLL_ENABLE of inst : label is 0;
  attribute C_SECONDARY_QPLL_REFCLK_FREQUENCY : string;
  attribute C_SECONDARY_QPLL_REFCLK_FREQUENCY of inst : label is "257.812500";
  attribute C_SIM_CPLL_CAL_BYPASS : string;
  attribute C_SIM_CPLL_CAL_BYPASS of inst : label is "1'b0";
  attribute C_TOTAL_NUM_CHANNELS : integer;
  attribute C_TOTAL_NUM_CHANNELS of inst : label is 7;
  attribute C_TOTAL_NUM_COMMONS : integer;
  attribute C_TOTAL_NUM_COMMONS of inst : label is 0;
  attribute C_TOTAL_NUM_COMMONS_EXAMPLE : integer;
  attribute C_TOTAL_NUM_COMMONS_EXAMPLE of inst : label is 0;
  attribute C_TXPROGDIV_FREQ_ENABLE : integer;
  attribute C_TXPROGDIV_FREQ_ENABLE of inst : label is 0;
  attribute C_TXPROGDIV_FREQ_SOURCE : integer;
  attribute C_TXPROGDIV_FREQ_SOURCE of inst : label is 2;
  attribute C_TXPROGDIV_FREQ_VAL : string;
  attribute C_TXPROGDIV_FREQ_VAL of inst : label is "307.125000";
  attribute C_TX_BUFFBYPASS_MODE : integer;
  attribute C_TX_BUFFBYPASS_MODE of inst : label is 0;
  attribute C_TX_BUFFER_BYPASS_INSTANCE_CTRL : integer;
  attribute C_TX_BUFFER_BYPASS_INSTANCE_CTRL of inst : label is 0;
  attribute C_TX_BUFFER_MODE : integer;
  attribute C_TX_BUFFER_MODE of inst : label is 0;
  attribute C_TX_DATA_ENCODING : integer;
  attribute C_TX_DATA_ENCODING of inst : label is 1;
  attribute C_TX_ENABLE : integer;
  attribute C_TX_ENABLE of inst : label is 1;
  attribute C_TX_INT_DATA_WIDTH : integer;
  attribute C_TX_INT_DATA_WIDTH of inst : label is 40;
  attribute C_TX_LINE_RATE : string;
  attribute C_TX_LINE_RATE of inst : label is "12.285000";
  attribute C_TX_MASTER_CHANNEL_IDX : integer;
  attribute C_TX_MASTER_CHANNEL_IDX of inst : label is 103;
  attribute C_TX_OUTCLK_BUFG_GT_DIV : integer;
  attribute C_TX_OUTCLK_BUFG_GT_DIV of inst : label is 1;
  attribute C_TX_OUTCLK_FREQUENCY : string;
  attribute C_TX_OUTCLK_FREQUENCY of inst : label is "307.125000";
  attribute C_TX_OUTCLK_SOURCE : integer;
  attribute C_TX_OUTCLK_SOURCE of inst : label is 4;
  attribute C_TX_PLL_TYPE : integer;
  attribute C_TX_PLL_TYPE of inst : label is 2;
  attribute C_TX_REFCLK_FREQUENCY : string;
  attribute C_TX_REFCLK_FREQUENCY of inst : label is "307.125000";
  attribute C_TX_USER_CLOCKING_CONTENTS : integer;
  attribute C_TX_USER_CLOCKING_CONTENTS of inst : label is 0;
  attribute C_TX_USER_CLOCKING_INSTANCE_CTRL : integer;
  attribute C_TX_USER_CLOCKING_INSTANCE_CTRL of inst : label is 0;
  attribute C_TX_USER_CLOCKING_RATIO_FSRC_FUSRCLK : integer;
  attribute C_TX_USER_CLOCKING_RATIO_FSRC_FUSRCLK of inst : label is 1;
  attribute C_TX_USER_CLOCKING_RATIO_FUSRCLK_FUSRCLK2 : integer;
  attribute C_TX_USER_CLOCKING_RATIO_FUSRCLK_FUSRCLK2 of inst : label is 1;
  attribute C_TX_USER_CLOCKING_SOURCE : integer;
  attribute C_TX_USER_CLOCKING_SOURCE of inst : label is 0;
  attribute C_TX_USER_DATA_WIDTH : integer;
  attribute C_TX_USER_DATA_WIDTH of inst : label is 32;
  attribute C_TX_USRCLK2_FREQUENCY : string;
  attribute C_TX_USRCLK2_FREQUENCY of inst : label is "307.125000";
  attribute C_TX_USRCLK_FREQUENCY : string;
  attribute C_TX_USRCLK_FREQUENCY of inst : label is "307.125000";
begin
inst: entity work.JesdCryoCoreRightColumn_JesdCryoCoreRightColumn_gtwizard_top
     port map (
      bgbypassb_in(0) => '1',
      bgmonitorenb_in(0) => '1',
      bgpdb_in(0) => '1',
      bgrcalovrd_in(4 downto 0) => B"11111",
      bgrcalovrdenb_in(0) => '1',
      bufgtce_out(20 downto 0) => NLW_inst_bufgtce_out_UNCONNECTED(20 downto 0),
      bufgtcemask_out(20 downto 0) => NLW_inst_bufgtcemask_out_UNCONNECTED(20 downto 0),
      bufgtdiv_out(62 downto 0) => NLW_inst_bufgtdiv_out_UNCONNECTED(62 downto 0),
      bufgtreset_out(20 downto 0) => NLW_inst_bufgtreset_out_UNCONNECTED(20 downto 0),
      bufgtrstmask_out(20 downto 0) => NLW_inst_bufgtrstmask_out_UNCONNECTED(20 downto 0),
      cdrstepdir_in(0) => '0',
      cdrstepsq_in(0) => '0',
      cdrstepsx_in(0) => '0',
      cfgreset_in(6 downto 0) => B"0000000",
      clkrsvd0_in(6 downto 0) => B"0000000",
      clkrsvd1_in(6 downto 0) => B"0000000",
      cpllfbclklost_out(6 downto 0) => NLW_inst_cpllfbclklost_out_UNCONNECTED(6 downto 0),
      cpllfreqlock_in(0) => '0',
      cplllock_out(6 downto 0) => NLW_inst_cplllock_out_UNCONNECTED(6 downto 0),
      cplllockdetclk_in(6 downto 0) => B"0000000",
      cplllocken_in(6 downto 0) => B"1111111",
      cpllpd_in(6 downto 0) => B"0000000",
      cpllrefclklost_out(6 downto 0) => NLW_inst_cpllrefclklost_out_UNCONNECTED(6 downto 0),
      cpllrefclksel_in(20 downto 0) => B"001001001001001001001",
      cpllreset_in(6 downto 0) => B"0000000",
      dmonfiforeset_in(6 downto 0) => B"0000000",
      dmonitorclk_in(6 downto 0) => B"0000000",
      dmonitorout_out(118 downto 0) => NLW_inst_dmonitorout_out_UNCONNECTED(118 downto 0),
      dmonitoroutclk_out(0) => NLW_inst_dmonitoroutclk_out_UNCONNECTED(0),
      drpaddr_common_in(8 downto 0) => B"000000000",
      drpaddr_in(62 downto 0) => drpaddr_in(62 downto 0),
      drpclk_common_in(0) => '0',
      drpclk_in(6 downto 0) => drpclk_in(6 downto 0),
      drpdi_common_in(15 downto 0) => B"0000000000000000",
      drpdi_in(111 downto 0) => drpdi_in(111 downto 0),
      drpdo_common_out(15 downto 0) => NLW_inst_drpdo_common_out_UNCONNECTED(15 downto 0),
      drpdo_out(111 downto 0) => drpdo_out(111 downto 0),
      drpen_common_in(0) => '0',
      drpen_in(6 downto 0) => drpen_in(6 downto 0),
      drprdy_common_out(0) => NLW_inst_drprdy_common_out_UNCONNECTED(0),
      drprdy_out(6 downto 0) => drprdy_out(6 downto 0),
      drprst_in(0) => '0',
      drpwe_common_in(0) => '0',
      drpwe_in(6 downto 0) => drpwe_in(6 downto 0),
      elpcaldvorwren_in(0) => '0',
      elpcalpaorwren_in(0) => '0',
      evoddphicaldone_in(6 downto 0) => B"0000000",
      evoddphicalstart_in(6 downto 0) => B"0000000",
      evoddphidrden_in(6 downto 0) => B"0000000",
      evoddphidwren_in(6 downto 0) => B"0000000",
      evoddphixrden_in(6 downto 0) => B"0000000",
      evoddphixwren_in(6 downto 0) => B"0000000",
      eyescandataerror_out(6 downto 0) => NLW_inst_eyescandataerror_out_UNCONNECTED(6 downto 0),
      eyescanmode_in(6 downto 0) => B"0000000",
      eyescanreset_in(6 downto 0) => B"0000000",
      eyescantrigger_in(6 downto 0) => B"0000000",
      freqos_in(0) => '0',
      gtgrefclk0_in(0) => '0',
      gtgrefclk1_in(0) => '0',
      gtgrefclk_in(6 downto 0) => B"0000000",
      gthrxn_in(6 downto 0) => gthrxn_in(6 downto 0),
      gthrxp_in(6 downto 0) => gthrxp_in(6 downto 0),
      gthtxn_out(6 downto 0) => gthtxn_out(6 downto 0),
      gthtxp_out(6 downto 0) => gthtxp_out(6 downto 0),
      gtnorthrefclk00_in(0) => '0',
      gtnorthrefclk01_in(0) => '0',
      gtnorthrefclk0_in(6 downto 0) => B"0000000",
      gtnorthrefclk10_in(0) => '0',
      gtnorthrefclk11_in(0) => '0',
      gtnorthrefclk1_in(6 downto 0) => B"0000000",
      gtpowergood_out(6 downto 0) => NLW_inst_gtpowergood_out_UNCONNECTED(6 downto 0),
      gtrefclk00_in(0) => '0',
      gtrefclk01_in(0) => '0',
      gtrefclk0_in(6 downto 0) => gtrefclk0_in(6 downto 0),
      gtrefclk10_in(0) => '0',
      gtrefclk11_in(0) => '0',
      gtrefclk1_in(6 downto 0) => B"0000000",
      gtrefclkmonitor_out(6 downto 0) => NLW_inst_gtrefclkmonitor_out_UNCONNECTED(6 downto 0),
      gtresetsel_in(6 downto 0) => B"0000000",
      gtrsvd_in(111 downto 0) => B"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      gtrxreset_in(6 downto 0) => B"0000000",
      gtrxresetsel_in(0) => '0',
      gtsouthrefclk00_in(0) => '0',
      gtsouthrefclk01_in(0) => '0',
      gtsouthrefclk0_in(6 downto 0) => B"0000000",
      gtsouthrefclk10_in(0) => '0',
      gtsouthrefclk11_in(0) => '0',
      gtsouthrefclk1_in(6 downto 0) => B"0000000",
      gttxreset_in(6 downto 0) => B"0000000",
      gttxresetsel_in(0) => '0',
      gtwiz_buffbypass_rx_done_out(0) => NLW_inst_gtwiz_buffbypass_rx_done_out_UNCONNECTED(0),
      gtwiz_buffbypass_rx_error_out(0) => NLW_inst_gtwiz_buffbypass_rx_error_out_UNCONNECTED(0),
      gtwiz_buffbypass_rx_reset_in(0) => '0',
      gtwiz_buffbypass_rx_start_user_in(0) => '0',
      gtwiz_buffbypass_tx_done_out(0) => gtwiz_buffbypass_tx_done_out(0),
      gtwiz_buffbypass_tx_error_out(0) => gtwiz_buffbypass_tx_error_out(0),
      gtwiz_buffbypass_tx_reset_in(0) => gtwiz_buffbypass_tx_reset_in(0),
      gtwiz_buffbypass_tx_start_user_in(0) => gtwiz_buffbypass_tx_start_user_in(0),
      gtwiz_gthe3_cpll_cal_bufg_ce_in(6 downto 0) => B"0000000",
      gtwiz_gthe3_cpll_cal_cnt_tol_in(125 downto 0) => B"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      gtwiz_gthe3_cpll_cal_txoutclk_period_in(125 downto 0) => B"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      gtwiz_gthe4_cpll_cal_bufg_ce_in(6 downto 0) => B"0000000",
      gtwiz_gthe4_cpll_cal_cnt_tol_in(125 downto 0) => B"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      gtwiz_gthe4_cpll_cal_txoutclk_period_in(125 downto 0) => B"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      gtwiz_gtye4_cpll_cal_bufg_ce_in(6 downto 0) => B"0000000",
      gtwiz_gtye4_cpll_cal_cnt_tol_in(125 downto 0) => B"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      gtwiz_gtye4_cpll_cal_txoutclk_period_in(125 downto 0) => B"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      gtwiz_reset_all_in(0) => gtwiz_reset_all_in(0),
      gtwiz_reset_clk_freerun_in(0) => gtwiz_reset_clk_freerun_in(0),
      gtwiz_reset_qpll0lock_in(0) => '0',
      gtwiz_reset_qpll0reset_out(0) => NLW_inst_gtwiz_reset_qpll0reset_out_UNCONNECTED(0),
      gtwiz_reset_qpll1lock_in(0) => '0',
      gtwiz_reset_qpll1reset_out(0) => NLW_inst_gtwiz_reset_qpll1reset_out_UNCONNECTED(0),
      gtwiz_reset_rx_cdr_stable_out(0) => gtwiz_reset_rx_cdr_stable_out(0),
      gtwiz_reset_rx_datapath_in(0) => gtwiz_reset_rx_datapath_in(0),
      gtwiz_reset_rx_done_in(0) => '0',
      gtwiz_reset_rx_done_out(0) => gtwiz_reset_rx_done_out(0),
      gtwiz_reset_rx_pll_and_datapath_in(0) => gtwiz_reset_rx_pll_and_datapath_in(0),
      gtwiz_reset_tx_datapath_in(0) => gtwiz_reset_tx_datapath_in(0),
      gtwiz_reset_tx_done_in(0) => '0',
      gtwiz_reset_tx_done_out(0) => gtwiz_reset_tx_done_out(0),
      gtwiz_reset_tx_pll_and_datapath_in(0) => gtwiz_reset_tx_pll_and_datapath_in(0),
      gtwiz_userclk_rx_active_in(0) => gtwiz_userclk_rx_active_in(0),
      gtwiz_userclk_rx_active_out(0) => NLW_inst_gtwiz_userclk_rx_active_out_UNCONNECTED(0),
      gtwiz_userclk_rx_reset_in(0) => '0',
      gtwiz_userclk_rx_srcclk_out(0) => NLW_inst_gtwiz_userclk_rx_srcclk_out_UNCONNECTED(0),
      gtwiz_userclk_rx_usrclk2_out(0) => NLW_inst_gtwiz_userclk_rx_usrclk2_out_UNCONNECTED(0),
      gtwiz_userclk_rx_usrclk_out(0) => NLW_inst_gtwiz_userclk_rx_usrclk_out_UNCONNECTED(0),
      gtwiz_userclk_tx_active_in(0) => gtwiz_userclk_tx_active_in(0),
      gtwiz_userclk_tx_active_out(0) => NLW_inst_gtwiz_userclk_tx_active_out_UNCONNECTED(0),
      gtwiz_userclk_tx_reset_in(0) => '0',
      gtwiz_userclk_tx_srcclk_out(0) => NLW_inst_gtwiz_userclk_tx_srcclk_out_UNCONNECTED(0),
      gtwiz_userclk_tx_usrclk2_out(0) => NLW_inst_gtwiz_userclk_tx_usrclk2_out_UNCONNECTED(0),
      gtwiz_userclk_tx_usrclk_out(0) => NLW_inst_gtwiz_userclk_tx_usrclk_out_UNCONNECTED(0),
      gtwiz_userdata_rx_out(223 downto 0) => gtwiz_userdata_rx_out(223 downto 0),
      gtwiz_userdata_tx_in(223 downto 0) => gtwiz_userdata_tx_in(223 downto 0),
      gtyrxn_in(0) => '0',
      gtyrxp_in(0) => '0',
      gtytxn_out(0) => NLW_inst_gtytxn_out_UNCONNECTED(0),
      gtytxp_out(0) => NLW_inst_gtytxp_out_UNCONNECTED(0),
      incpctrl_in(0) => '0',
      loopback_in(20 downto 0) => B"000000000000000000000",
      looprsvd_in(0) => '0',
      lpbkrxtxseren_in(6 downto 0) => B"0000000",
      lpbktxrxseren_in(6 downto 0) => B"0000000",
      pcieeqrxeqadaptdone_in(6 downto 0) => B"0000000",
      pcierategen3_out(6 downto 0) => NLW_inst_pcierategen3_out_UNCONNECTED(6 downto 0),
      pcierateidle_out(6 downto 0) => NLW_inst_pcierateidle_out_UNCONNECTED(6 downto 0),
      pcierateqpll0_in(0) => '0',
      pcierateqpll1_in(0) => '0',
      pcierateqpllpd_out(13 downto 0) => NLW_inst_pcierateqpllpd_out_UNCONNECTED(13 downto 0),
      pcierateqpllreset_out(13 downto 0) => NLW_inst_pcierateqpllreset_out_UNCONNECTED(13 downto 0),
      pcierstidle_in(6 downto 0) => B"0000000",
      pciersttxsyncstart_in(6 downto 0) => B"0000000",
      pciesynctxsyncdone_out(6 downto 0) => NLW_inst_pciesynctxsyncdone_out_UNCONNECTED(6 downto 0),
      pcieusergen3rdy_out(6 downto 0) => NLW_inst_pcieusergen3rdy_out_UNCONNECTED(6 downto 0),
      pcieuserphystatusrst_out(6 downto 0) => NLW_inst_pcieuserphystatusrst_out_UNCONNECTED(6 downto 0),
      pcieuserratedone_in(6 downto 0) => B"0000000",
      pcieuserratestart_out(6 downto 0) => NLW_inst_pcieuserratestart_out_UNCONNECTED(6 downto 0),
      pcsrsvdin2_in(34 downto 0) => B"00000000000000000000000000000000000",
      pcsrsvdin_in(111 downto 0) => B"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      pcsrsvdout_out(83 downto 0) => NLW_inst_pcsrsvdout_out_UNCONNECTED(83 downto 0),
      phystatus_out(6 downto 0) => NLW_inst_phystatus_out_UNCONNECTED(6 downto 0),
      pinrsrvdas_out(55 downto 0) => NLW_inst_pinrsrvdas_out_UNCONNECTED(55 downto 0),
      pmarsvd0_in(7 downto 0) => B"00000000",
      pmarsvd1_in(7 downto 0) => B"00000000",
      pmarsvdin_in(34 downto 0) => B"00000000000000000000000000000000000",
      pmarsvdout0_out(7 downto 0) => NLW_inst_pmarsvdout0_out_UNCONNECTED(7 downto 0),
      pmarsvdout1_out(7 downto 0) => NLW_inst_pmarsvdout1_out_UNCONNECTED(7 downto 0),
      powerpresent_out(0) => NLW_inst_powerpresent_out_UNCONNECTED(0),
      qpll0clk_in(6 downto 0) => B"0000000",
      qpll0clkrsvd0_in(0) => '0',
      qpll0clkrsvd1_in(0) => '0',
      qpll0fbclklost_out(0) => NLW_inst_qpll0fbclklost_out_UNCONNECTED(0),
      qpll0fbdiv_in(0) => '0',
      qpll0freqlock_in(0) => '0',
      qpll0lock_out(0) => NLW_inst_qpll0lock_out_UNCONNECTED(0),
      qpll0lockdetclk_in(0) => '0',
      qpll0locken_in(0) => '0',
      qpll0outclk_out(0) => NLW_inst_qpll0outclk_out_UNCONNECTED(0),
      qpll0outrefclk_out(0) => NLW_inst_qpll0outrefclk_out_UNCONNECTED(0),
      qpll0pd_in(0) => '1',
      qpll0refclk_in(6 downto 0) => B"0000000",
      qpll0refclklost_out(0) => NLW_inst_qpll0refclklost_out_UNCONNECTED(0),
      qpll0refclksel_in(2 downto 0) => B"001",
      qpll0reset_in(0) => '1',
      qpll1clk_in(6 downto 0) => B"0000000",
      qpll1clkrsvd0_in(0) => '0',
      qpll1clkrsvd1_in(0) => '0',
      qpll1fbclklost_out(0) => NLW_inst_qpll1fbclklost_out_UNCONNECTED(0),
      qpll1fbdiv_in(0) => '0',
      qpll1freqlock_in(0) => '0',
      qpll1lock_out(0) => NLW_inst_qpll1lock_out_UNCONNECTED(0),
      qpll1lockdetclk_in(0) => '0',
      qpll1locken_in(0) => '0',
      qpll1outclk_out(0) => NLW_inst_qpll1outclk_out_UNCONNECTED(0),
      qpll1outrefclk_out(0) => NLW_inst_qpll1outrefclk_out_UNCONNECTED(0),
      qpll1pd_in(0) => '1',
      qpll1refclk_in(6 downto 0) => B"0000000",
      qpll1refclklost_out(0) => NLW_inst_qpll1refclklost_out_UNCONNECTED(0),
      qpll1refclksel_in(2 downto 0) => B"001",
      qpll1reset_in(0) => '1',
      qplldmonitor0_out(7 downto 0) => NLW_inst_qplldmonitor0_out_UNCONNECTED(7 downto 0),
      qplldmonitor1_out(7 downto 0) => NLW_inst_qplldmonitor1_out_UNCONNECTED(7 downto 0),
      qpllrsvd1_in(7 downto 0) => B"00000000",
      qpllrsvd2_in(4 downto 0) => B"00000",
      qpllrsvd3_in(4 downto 0) => B"00000",
      qpllrsvd4_in(7 downto 0) => B"00000000",
      rcalenb_in(0) => '1',
      refclkoutmonitor0_out(0) => NLW_inst_refclkoutmonitor0_out_UNCONNECTED(0),
      refclkoutmonitor1_out(0) => NLW_inst_refclkoutmonitor1_out_UNCONNECTED(0),
      resetexception_out(6 downto 0) => NLW_inst_resetexception_out_UNCONNECTED(6 downto 0),
      resetovrd_in(6 downto 0) => B"0000000",
      rstclkentx_in(6 downto 0) => B"0000000",
      rx8b10ben_in(6 downto 0) => rx8b10ben_in(6 downto 0),
      rxafecfoken_in(0) => '0',
      rxbufreset_in(6 downto 0) => B"0000000",
      rxbufstatus_out(20 downto 0) => NLW_inst_rxbufstatus_out_UNCONNECTED(20 downto 0),
      rxbyteisaligned_out(6 downto 0) => rxbyteisaligned_out(6 downto 0),
      rxbyterealign_out(6 downto 0) => rxbyterealign_out(6 downto 0),
      rxcdrfreqreset_in(6 downto 0) => B"0000000",
      rxcdrhold_in(6 downto 0) => B"0000000",
      rxcdrlock_out(6 downto 0) => NLW_inst_rxcdrlock_out_UNCONNECTED(6 downto 0),
      rxcdrovrden_in(6 downto 0) => B"0000000",
      rxcdrphdone_out(6 downto 0) => NLW_inst_rxcdrphdone_out_UNCONNECTED(6 downto 0),
      rxcdrreset_in(6 downto 0) => B"0000000",
      rxcdrresetrsv_in(6 downto 0) => B"0000000",
      rxchanbondseq_out(6 downto 0) => NLW_inst_rxchanbondseq_out_UNCONNECTED(6 downto 0),
      rxchanisaligned_out(6 downto 0) => NLW_inst_rxchanisaligned_out_UNCONNECTED(6 downto 0),
      rxchanrealign_out(6 downto 0) => NLW_inst_rxchanrealign_out_UNCONNECTED(6 downto 0),
      rxchbonden_in(6 downto 0) => B"0000000",
      rxchbondi_in(34 downto 0) => B"00000000000000000000000000000000000",
      rxchbondlevel_in(20 downto 0) => B"000000000000000000000",
      rxchbondmaster_in(6 downto 0) => B"0000000",
      rxchbondo_out(34 downto 0) => NLW_inst_rxchbondo_out_UNCONNECTED(34 downto 0),
      rxchbondslave_in(6 downto 0) => B"0000000",
      rxckcaldone_out(0) => NLW_inst_rxckcaldone_out_UNCONNECTED(0),
      rxckcalreset_in(0) => '0',
      rxckcalstart_in(0) => '0',
      rxclkcorcnt_out(13 downto 0) => NLW_inst_rxclkcorcnt_out_UNCONNECTED(13 downto 0),
      rxcominitdet_out(6 downto 0) => NLW_inst_rxcominitdet_out_UNCONNECTED(6 downto 0),
      rxcommadet_out(6 downto 0) => rxcommadet_out(6 downto 0),
      rxcommadeten_in(6 downto 0) => rxcommadeten_in(6 downto 0),
      rxcomsasdet_out(6 downto 0) => NLW_inst_rxcomsasdet_out_UNCONNECTED(6 downto 0),
      rxcomwakedet_out(6 downto 0) => NLW_inst_rxcomwakedet_out_UNCONNECTED(6 downto 0),
      rxctrl0_out(111 downto 0) => rxctrl0_out(111 downto 0),
      rxctrl1_out(111 downto 0) => rxctrl1_out(111 downto 0),
      rxctrl2_out(55 downto 0) => rxctrl2_out(55 downto 0),
      rxctrl3_out(55 downto 0) => rxctrl3_out(55 downto 0),
      rxdata_out(895 downto 0) => NLW_inst_rxdata_out_UNCONNECTED(895 downto 0),
      rxdataextendrsvd_out(55 downto 0) => NLW_inst_rxdataextendrsvd_out_UNCONNECTED(55 downto 0),
      rxdatavalid_out(13 downto 0) => NLW_inst_rxdatavalid_out_UNCONNECTED(13 downto 0),
      rxdccforcestart_in(0) => '0',
      rxdfeagcctrl_in(13 downto 0) => B"01010101010101",
      rxdfeagchold_in(6 downto 0) => B"0000000",
      rxdfeagcovrden_in(6 downto 0) => B"0000000",
      rxdfecfokfcnum_in(0) => '0',
      rxdfecfokfen_in(0) => '0',
      rxdfecfokfpulse_in(0) => '0',
      rxdfecfokhold_in(0) => '0',
      rxdfecfokovren_in(0) => '0',
      rxdfekhhold_in(0) => '0',
      rxdfekhovrden_in(0) => '0',
      rxdfelfhold_in(6 downto 0) => B"0000000",
      rxdfelfovrden_in(6 downto 0) => B"0000000",
      rxdfelpmreset_in(6 downto 0) => B"0000000",
      rxdfetap10hold_in(6 downto 0) => B"0000000",
      rxdfetap10ovrden_in(6 downto 0) => B"0000000",
      rxdfetap11hold_in(6 downto 0) => B"0000000",
      rxdfetap11ovrden_in(6 downto 0) => B"0000000",
      rxdfetap12hold_in(6 downto 0) => B"0000000",
      rxdfetap12ovrden_in(6 downto 0) => B"0000000",
      rxdfetap13hold_in(6 downto 0) => B"0000000",
      rxdfetap13ovrden_in(6 downto 0) => B"0000000",
      rxdfetap14hold_in(6 downto 0) => B"0000000",
      rxdfetap14ovrden_in(6 downto 0) => B"0000000",
      rxdfetap15hold_in(6 downto 0) => B"0000000",
      rxdfetap15ovrden_in(6 downto 0) => B"0000000",
      rxdfetap2hold_in(6 downto 0) => B"0000000",
      rxdfetap2ovrden_in(6 downto 0) => B"0000000",
      rxdfetap3hold_in(6 downto 0) => B"0000000",
      rxdfetap3ovrden_in(6 downto 0) => B"0000000",
      rxdfetap4hold_in(6 downto 0) => B"0000000",
      rxdfetap4ovrden_in(6 downto 0) => B"0000000",
      rxdfetap5hold_in(6 downto 0) => B"0000000",
      rxdfetap5ovrden_in(6 downto 0) => B"0000000",
      rxdfetap6hold_in(6 downto 0) => B"0000000",
      rxdfetap6ovrden_in(6 downto 0) => B"0000000",
      rxdfetap7hold_in(6 downto 0) => B"0000000",
      rxdfetap7ovrden_in(6 downto 0) => B"0000000",
      rxdfetap8hold_in(6 downto 0) => B"0000000",
      rxdfetap8ovrden_in(6 downto 0) => B"0000000",
      rxdfetap9hold_in(6 downto 0) => B"0000000",
      rxdfetap9ovrden_in(6 downto 0) => B"0000000",
      rxdfeuthold_in(6 downto 0) => B"0000000",
      rxdfeutovrden_in(6 downto 0) => B"0000000",
      rxdfevphold_in(6 downto 0) => B"0000000",
      rxdfevpovrden_in(6 downto 0) => B"0000000",
      rxdfevsen_in(6 downto 0) => B"0000000",
      rxdfexyden_in(6 downto 0) => B"1111111",
      rxdlybypass_in(6 downto 0) => B"1111111",
      rxdlyen_in(6 downto 0) => B"0000000",
      rxdlyovrden_in(6 downto 0) => B"0000000",
      rxdlysreset_in(6 downto 0) => B"0000000",
      rxdlysresetdone_out(6 downto 0) => NLW_inst_rxdlysresetdone_out_UNCONNECTED(6 downto 0),
      rxelecidle_out(6 downto 0) => NLW_inst_rxelecidle_out_UNCONNECTED(6 downto 0),
      rxelecidlemode_in(13 downto 0) => B"11111111111111",
      rxeqtraining_in(0) => '0',
      rxgearboxslip_in(6 downto 0) => B"0000000",
      rxheader_out(41 downto 0) => NLW_inst_rxheader_out_UNCONNECTED(41 downto 0),
      rxheadervalid_out(13 downto 0) => NLW_inst_rxheadervalid_out_UNCONNECTED(13 downto 0),
      rxlatclk_in(6 downto 0) => B"0000000",
      rxlfpstresetdet_out(0) => NLW_inst_rxlfpstresetdet_out_UNCONNECTED(0),
      rxlfpsu2lpexitdet_out(0) => NLW_inst_rxlfpsu2lpexitdet_out_UNCONNECTED(0),
      rxlfpsu3wakedet_out(0) => NLW_inst_rxlfpsu3wakedet_out_UNCONNECTED(0),
      rxlpmen_in(6 downto 0) => B"1111111",
      rxlpmgchold_in(6 downto 0) => B"0000000",
      rxlpmgcovrden_in(6 downto 0) => B"0000000",
      rxlpmhfhold_in(6 downto 0) => B"0000000",
      rxlpmhfovrden_in(6 downto 0) => B"0000000",
      rxlpmlfhold_in(6 downto 0) => B"0000000",
      rxlpmlfklovrden_in(6 downto 0) => B"0000000",
      rxlpmoshold_in(6 downto 0) => B"0000000",
      rxlpmosovrden_in(6 downto 0) => B"0000000",
      rxmcommaalignen_in(6 downto 0) => rxmcommaalignen_in(6 downto 0),
      rxmonitorout_out(48 downto 0) => NLW_inst_rxmonitorout_out_UNCONNECTED(48 downto 0),
      rxmonitorsel_in(13 downto 0) => B"00000000000000",
      rxoobreset_in(6 downto 0) => B"0000000",
      rxoscalreset_in(6 downto 0) => B"0000000",
      rxoshold_in(6 downto 0) => B"0000000",
      rxosintcfg_in(27 downto 0) => B"1101110111011101110111011101",
      rxosintdone_out(6 downto 0) => NLW_inst_rxosintdone_out_UNCONNECTED(6 downto 0),
      rxosinten_in(6 downto 0) => B"1111111",
      rxosinthold_in(6 downto 0) => B"0000000",
      rxosintovrden_in(6 downto 0) => B"0000000",
      rxosintstarted_out(6 downto 0) => NLW_inst_rxosintstarted_out_UNCONNECTED(6 downto 0),
      rxosintstrobe_in(6 downto 0) => B"0000000",
      rxosintstrobedone_out(6 downto 0) => NLW_inst_rxosintstrobedone_out_UNCONNECTED(6 downto 0),
      rxosintstrobestarted_out(6 downto 0) => NLW_inst_rxosintstrobestarted_out_UNCONNECTED(6 downto 0),
      rxosinttestovrden_in(6 downto 0) => B"0000000",
      rxosovrden_in(6 downto 0) => B"0000000",
      rxoutclk_out(6 downto 0) => rxoutclk_out(6 downto 0),
      rxoutclkfabric_out(6 downto 0) => NLW_inst_rxoutclkfabric_out_UNCONNECTED(6 downto 0),
      rxoutclkpcs_out(6 downto 0) => NLW_inst_rxoutclkpcs_out_UNCONNECTED(6 downto 0),
      rxoutclksel_in(20 downto 0) => B"010010010010010010010",
      rxpcommaalignen_in(6 downto 0) => rxpcommaalignen_in(6 downto 0),
      rxpcsreset_in(6 downto 0) => B"0000000",
      rxpd_in(13 downto 0) => rxpd_in(13 downto 0),
      rxphalign_in(6 downto 0) => B"0000000",
      rxphaligndone_out(6 downto 0) => NLW_inst_rxphaligndone_out_UNCONNECTED(6 downto 0),
      rxphalignen_in(6 downto 0) => B"0000000",
      rxphalignerr_out(6 downto 0) => NLW_inst_rxphalignerr_out_UNCONNECTED(6 downto 0),
      rxphdlypd_in(6 downto 0) => B"1111111",
      rxphdlyreset_in(6 downto 0) => B"0000000",
      rxphovrden_in(6 downto 0) => B"0000000",
      rxpllclksel_in(13 downto 0) => B"00000000000000",
      rxpmareset_in(6 downto 0) => B"0000000",
      rxpmaresetdone_out(6 downto 0) => rxpmaresetdone_out(6 downto 0),
      rxpolarity_in(6 downto 0) => rxpolarity_in(6 downto 0),
      rxprbscntreset_in(6 downto 0) => B"0000000",
      rxprbserr_out(6 downto 0) => NLW_inst_rxprbserr_out_UNCONNECTED(6 downto 0),
      rxprbslocked_out(6 downto 0) => NLW_inst_rxprbslocked_out_UNCONNECTED(6 downto 0),
      rxprbssel_in(27 downto 0) => B"0000000000000000000000000000",
      rxprgdivresetdone_out(6 downto 0) => NLW_inst_rxprgdivresetdone_out_UNCONNECTED(6 downto 0),
      rxprogdivreset_in(6 downto 0) => B"0000000",
      rxqpien_in(6 downto 0) => B"0000000",
      rxqpisenn_out(6 downto 0) => NLW_inst_rxqpisenn_out_UNCONNECTED(6 downto 0),
      rxqpisenp_out(6 downto 0) => NLW_inst_rxqpisenp_out_UNCONNECTED(6 downto 0),
      rxrate_in(20 downto 0) => B"000000000000000000000",
      rxratedone_out(6 downto 0) => NLW_inst_rxratedone_out_UNCONNECTED(6 downto 0),
      rxratemode_in(6 downto 0) => B"0000000",
      rxrecclk0_sel_out(1 downto 0) => NLW_inst_rxrecclk0_sel_out_UNCONNECTED(1 downto 0),
      rxrecclk0sel_out(0) => NLW_inst_rxrecclk0sel_out_UNCONNECTED(0),
      rxrecclk1_sel_out(1 downto 0) => NLW_inst_rxrecclk1_sel_out_UNCONNECTED(1 downto 0),
      rxrecclk1sel_out(0) => NLW_inst_rxrecclk1sel_out_UNCONNECTED(0),
      rxrecclkout_out(6 downto 0) => NLW_inst_rxrecclkout_out_UNCONNECTED(6 downto 0),
      rxresetdone_out(6 downto 0) => NLW_inst_rxresetdone_out_UNCONNECTED(6 downto 0),
      rxslide_in(6 downto 0) => B"0000000",
      rxsliderdy_out(6 downto 0) => NLW_inst_rxsliderdy_out_UNCONNECTED(6 downto 0),
      rxslipdone_out(6 downto 0) => NLW_inst_rxslipdone_out_UNCONNECTED(6 downto 0),
      rxslipoutclk_in(6 downto 0) => B"0000000",
      rxslipoutclkrdy_out(6 downto 0) => NLW_inst_rxslipoutclkrdy_out_UNCONNECTED(6 downto 0),
      rxslippma_in(6 downto 0) => B"0000000",
      rxslippmardy_out(6 downto 0) => NLW_inst_rxslippmardy_out_UNCONNECTED(6 downto 0),
      rxstartofseq_out(13 downto 0) => NLW_inst_rxstartofseq_out_UNCONNECTED(13 downto 0),
      rxstatus_out(20 downto 0) => NLW_inst_rxstatus_out_UNCONNECTED(20 downto 0),
      rxsyncallin_in(6 downto 0) => B"0000000",
      rxsyncdone_out(6 downto 0) => NLW_inst_rxsyncdone_out_UNCONNECTED(6 downto 0),
      rxsyncin_in(6 downto 0) => B"0000000",
      rxsyncmode_in(6 downto 0) => B"0000000",
      rxsyncout_out(6 downto 0) => NLW_inst_rxsyncout_out_UNCONNECTED(6 downto 0),
      rxsysclksel_in(13 downto 0) => B"00000000000000",
      rxtermination_in(0) => '0',
      rxuserrdy_in(6 downto 0) => B"1111111",
      rxusrclk2_in(6 downto 0) => rxusrclk2_in(6 downto 0),
      rxusrclk_in(6 downto 0) => rxusrclk_in(6 downto 0),
      rxvalid_out(6 downto 0) => NLW_inst_rxvalid_out_UNCONNECTED(6 downto 0),
      sdm0data_in(0) => '0',
      sdm0finalout_out(0) => NLW_inst_sdm0finalout_out_UNCONNECTED(0),
      sdm0reset_in(0) => '0',
      sdm0testdata_out(0) => NLW_inst_sdm0testdata_out_UNCONNECTED(0),
      sdm0toggle_in(0) => '0',
      sdm0width_in(0) => '0',
      sdm1data_in(0) => '0',
      sdm1finalout_out(0) => NLW_inst_sdm1finalout_out_UNCONNECTED(0),
      sdm1reset_in(0) => '0',
      sdm1testdata_out(0) => NLW_inst_sdm1testdata_out_UNCONNECTED(0),
      sdm1toggle_in(0) => '0',
      sdm1width_in(0) => '0',
      sigvalidclk_in(6 downto 0) => B"0000000",
      tcongpi_in(0) => '0',
      tcongpo_out(0) => NLW_inst_tcongpo_out_UNCONNECTED(0),
      tconpowerup_in(0) => '0',
      tconreset_in(0) => '0',
      tconrsvdin1_in(0) => '0',
      tconrsvdout0_out(0) => NLW_inst_tconrsvdout0_out_UNCONNECTED(0),
      tstin_in(139 downto 0) => B"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      tx8b10bbypass_in(55 downto 0) => B"00000000000000000000000000000000000000000000000000000000",
      tx8b10ben_in(6 downto 0) => tx8b10ben_in(6 downto 0),
      txbufdiffctrl_in(20 downto 0) => B"000000000000000000000",
      txbufstatus_out(13 downto 0) => NLW_inst_txbufstatus_out_UNCONNECTED(13 downto 0),
      txcomfinish_out(6 downto 0) => NLW_inst_txcomfinish_out_UNCONNECTED(6 downto 0),
      txcominit_in(6 downto 0) => B"0000000",
      txcomsas_in(6 downto 0) => B"0000000",
      txcomwake_in(6 downto 0) => B"0000000",
      txctrl0_in(111 downto 0) => txctrl0_in(111 downto 0),
      txctrl1_in(111 downto 0) => txctrl1_in(111 downto 0),
      txctrl2_in(55 downto 0) => txctrl2_in(55 downto 0),
      txdata_in(895 downto 0) => B"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      txdataextendrsvd_in(55 downto 0) => B"00000000000000000000000000000000000000000000000000000000",
      txdccdone_out(0) => NLW_inst_txdccdone_out_UNCONNECTED(0),
      txdccforcestart_in(0) => '0',
      txdccreset_in(0) => '0',
      txdeemph_in(6 downto 0) => B"0000000",
      txdetectrx_in(6 downto 0) => B"0000000",
      txdiffctrl_in(27 downto 0) => txdiffctrl_in(27 downto 0),
      txdiffpd_in(6 downto 0) => B"0000000",
      txdlybypass_in(6 downto 0) => B"0000000",
      txdlyen_in(6 downto 0) => B"0000000",
      txdlyhold_in(6 downto 0) => B"0000000",
      txdlyovrden_in(6 downto 0) => B"0000000",
      txdlysreset_in(6 downto 0) => B"0000000",
      txdlysresetdone_out(6 downto 0) => NLW_inst_txdlysresetdone_out_UNCONNECTED(6 downto 0),
      txdlyupdown_in(6 downto 0) => B"0000000",
      txelecidle_in(6 downto 0) => B"0000000",
      txelforcestart_in(0) => '0',
      txheader_in(41 downto 0) => B"000000000000000000000000000000000000000000",
      txinhibit_in(6 downto 0) => B"0000000",
      txlatclk_in(6 downto 0) => B"0000000",
      txlfpstreset_in(0) => '0',
      txlfpsu2lpexit_in(0) => '0',
      txlfpsu3wake_in(0) => '0',
      txmaincursor_in(48 downto 0) => B"1000000100000010000001000000100000010000001000000",
      txmargin_in(20 downto 0) => B"000000000000000000000",
      txmuxdcdexhold_in(0) => '0',
      txmuxdcdorwren_in(0) => '0',
      txoneszeros_in(0) => '0',
      txoutclk_out(6 downto 0) => txoutclk_out(6 downto 0),
      txoutclkfabric_out(6 downto 0) => NLW_inst_txoutclkfabric_out_UNCONNECTED(6 downto 0),
      txoutclkpcs_out(6 downto 0) => NLW_inst_txoutclkpcs_out_UNCONNECTED(6 downto 0),
      txoutclksel_in(20 downto 0) => B"101101101101101101101",
      txpcsreset_in(6 downto 0) => B"0000000",
      txpd_in(13 downto 0) => txpd_in(13 downto 0),
      txpdelecidlemode_in(6 downto 0) => B"0000000",
      txphalign_in(6 downto 0) => B"0000000",
      txphaligndone_out(6 downto 0) => NLW_inst_txphaligndone_out_UNCONNECTED(6 downto 0),
      txphalignen_in(6 downto 0) => B"0000000",
      txphdlypd_in(6 downto 0) => B"0000000",
      txphdlyreset_in(6 downto 0) => B"0000000",
      txphdlytstclk_in(6 downto 0) => B"0000000",
      txphinit_in(6 downto 0) => B"0000000",
      txphinitdone_out(6 downto 0) => NLW_inst_txphinitdone_out_UNCONNECTED(6 downto 0),
      txphovrden_in(6 downto 0) => B"0000000",
      txpippmen_in(6 downto 0) => B"0000000",
      txpippmovrden_in(6 downto 0) => B"0000000",
      txpippmpd_in(6 downto 0) => B"0000000",
      txpippmsel_in(6 downto 0) => B"0000000",
      txpippmstepsize_in(34 downto 0) => B"00000000000000000000000000000000000",
      txpisopd_in(6 downto 0) => B"0000000",
      txpllclksel_in(13 downto 0) => B"00000000000000",
      txpmareset_in(6 downto 0) => B"0000000",
      txpmaresetdone_out(6 downto 0) => txpmaresetdone_out(6 downto 0),
      txpolarity_in(6 downto 0) => txpolarity_in(6 downto 0),
      txpostcursor_in(34 downto 0) => B"00000000000000000000000000000000000",
      txpostcursorinv_in(6 downto 0) => B"0000000",
      txprbsforceerr_in(6 downto 0) => B"0000000",
      txprbssel_in(27 downto 0) => B"0000000000000000000000000000",
      txprecursor_in(34 downto 0) => B"00000000000000000000000000000000000",
      txprecursorinv_in(6 downto 0) => B"0000000",
      txprgdivresetdone_out(6 downto 0) => txprgdivresetdone_out(6 downto 0),
      txprogdivreset_in(6 downto 0) => B"0000000",
      txqpibiasen_in(6 downto 0) => B"0000000",
      txqpisenn_out(6 downto 0) => NLW_inst_txqpisenn_out_UNCONNECTED(6 downto 0),
      txqpisenp_out(6 downto 0) => NLW_inst_txqpisenp_out_UNCONNECTED(6 downto 0),
      txqpistrongpdown_in(6 downto 0) => B"0000000",
      txqpiweakpup_in(6 downto 0) => B"0000000",
      txrate_in(20 downto 0) => B"000000000000000000000",
      txratedone_out(6 downto 0) => NLW_inst_txratedone_out_UNCONNECTED(6 downto 0),
      txratemode_in(6 downto 0) => B"0000000",
      txresetdone_out(6 downto 0) => NLW_inst_txresetdone_out_UNCONNECTED(6 downto 0),
      txsequence_in(48 downto 0) => B"0000000000000000000000000000000000000000000000000",
      txswing_in(6 downto 0) => B"0000000",
      txsyncallin_in(6 downto 0) => B"0000000",
      txsyncdone_out(6 downto 0) => NLW_inst_txsyncdone_out_UNCONNECTED(6 downto 0),
      txsyncin_in(6 downto 0) => B"0000000",
      txsyncmode_in(6 downto 0) => B"0000000",
      txsyncout_out(6 downto 0) => NLW_inst_txsyncout_out_UNCONNECTED(6 downto 0),
      txsysclksel_in(13 downto 0) => B"00000000000000",
      txuserrdy_in(6 downto 0) => B"1111111",
      txusrclk2_in(6 downto 0) => txusrclk2_in(6 downto 0),
      txusrclk_in(6 downto 0) => txusrclk_in(6 downto 0),
      ubcfgstreamen_in(0) => '0',
      ubdaddr_out(0) => NLW_inst_ubdaddr_out_UNCONNECTED(0),
      ubden_out(0) => NLW_inst_ubden_out_UNCONNECTED(0),
      ubdi_out(0) => NLW_inst_ubdi_out_UNCONNECTED(0),
      ubdo_in(0) => '0',
      ubdrdy_in(0) => '0',
      ubdwe_out(0) => NLW_inst_ubdwe_out_UNCONNECTED(0),
      ubenable_in(0) => '0',
      ubgpi_in(0) => '0',
      ubintr_in(0) => '0',
      ubiolmbrst_in(0) => '0',
      ubmbrst_in(0) => '0',
      ubmdmcapture_in(0) => '0',
      ubmdmdbgrst_in(0) => '0',
      ubmdmdbgupdate_in(0) => '0',
      ubmdmregen_in(0) => '0',
      ubmdmshift_in(0) => '0',
      ubmdmsysrst_in(0) => '0',
      ubmdmtck_in(0) => '0',
      ubmdmtdi_in(0) => '0',
      ubmdmtdo_out(0) => NLW_inst_ubmdmtdo_out_UNCONNECTED(0),
      ubrsvdout_out(0) => NLW_inst_ubrsvdout_out_UNCONNECTED(0),
      ubtxuart_out(0) => NLW_inst_ubtxuart_out_UNCONNECTED(0)
    );
end STRUCTURE;
