-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
entity dspcore_stub is
  port (
    adcbay1_0 : in std_logic_vector( 32-1 downto 0 );
    adcbay1_1 : in std_logic_vector( 32-1 downto 0 );
    adcbay1_2 : in std_logic_vector( 32-1 downto 0 );
    adcbay1_3 : in std_logic_vector( 32-1 downto 0 );
    adcbay1_4 : in std_logic_vector( 32-1 downto 0 );
    adcbay1_5 : in std_logic_vector( 32-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    clk : in std_logic;
    dspcore_aresetn : in std_logic;
    dspcore_s_axi_awaddr : in std_logic_vector( 12-1 downto 0 );
    dspcore_s_axi_awvalid : in std_logic;
    dspcore_s_axi_wdata : in std_logic_vector( 32-1 downto 0 );
    dspcore_s_axi_wstrb : in std_logic_vector( 4-1 downto 0 );
    dspcore_s_axi_wvalid : in std_logic;
    dspcore_s_axi_bready : in std_logic;
    dspcore_s_axi_araddr : in std_logic_vector( 12-1 downto 0 );
    dspcore_s_axi_arvalid : in std_logic;
    dspcore_s_axi_rready : in std_logic;
    debugbay1_0 : out std_logic_vector( 32-1 downto 0 );
    debugbay1_1 : out std_logic_vector( 32-1 downto 0 );
    debugbay1_2 : out std_logic_vector( 32-1 downto 0 );
    debugbay1_3 : out std_logic_vector( 32-1 downto 0 );
    dacbay1_0 : out std_logic_vector( 32-1 downto 0 );
    dacbay1_1 : out std_logic_vector( 32-1 downto 0 );
    dspcore_s_axi_awready : out std_logic;
    dspcore_s_axi_wready : out std_logic;
    dspcore_s_axi_bresp : out std_logic_vector( 2-1 downto 0 );
    dspcore_s_axi_bvalid : out std_logic;
    dspcore_s_axi_arready : out std_logic;
    dspcore_s_axi_rdata : out std_logic_vector( 32-1 downto 0 );
    dspcore_s_axi_rresp : out std_logic_vector( 2-1 downto 0 );
    dspcore_s_axi_rvalid : out std_logic
  );
end dspcore_stub;
architecture structural of dspcore_stub is 
begin
  sysgen_dut : entity xil_defaultlib.dspcore 
  port map (
    adcbay1_0 => adcbay1_0,
    adcbay1_1 => adcbay1_1,
    adcbay1_2 => adcbay1_2,
    adcbay1_3 => adcbay1_3,
    adcbay1_4 => adcbay1_4,
    adcbay1_5 => adcbay1_5,
    rst => rst,
    clk => clk,
    dspcore_aresetn => dspcore_aresetn,
    dspcore_s_axi_awaddr => dspcore_s_axi_awaddr,
    dspcore_s_axi_awvalid => dspcore_s_axi_awvalid,
    dspcore_s_axi_wdata => dspcore_s_axi_wdata,
    dspcore_s_axi_wstrb => dspcore_s_axi_wstrb,
    dspcore_s_axi_wvalid => dspcore_s_axi_wvalid,
    dspcore_s_axi_bready => dspcore_s_axi_bready,
    dspcore_s_axi_araddr => dspcore_s_axi_araddr,
    dspcore_s_axi_arvalid => dspcore_s_axi_arvalid,
    dspcore_s_axi_rready => dspcore_s_axi_rready,
    debugbay1_0 => debugbay1_0,
    debugbay1_1 => debugbay1_1,
    debugbay1_2 => debugbay1_2,
    debugbay1_3 => debugbay1_3,
    dacbay1_0 => dacbay1_0,
    dacbay1_1 => dacbay1_1,
    dspcore_s_axi_awready => dspcore_s_axi_awready,
    dspcore_s_axi_wready => dspcore_s_axi_wready,
    dspcore_s_axi_bresp => dspcore_s_axi_bresp,
    dspcore_s_axi_bvalid => dspcore_s_axi_bvalid,
    dspcore_s_axi_arready => dspcore_s_axi_arready,
    dspcore_s_axi_rdata => dspcore_s_axi_rdata,
    dspcore_s_axi_rresp => dspcore_s_axi_rresp,
    dspcore_s_axi_rvalid => dspcore_s_axi_rvalid
  );
end structural;
