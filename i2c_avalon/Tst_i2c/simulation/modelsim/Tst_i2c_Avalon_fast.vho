-- Copyright (C) 1991-2011 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 11.0 Build 208 07/03/2011 Service Pack 1 SJ Full Version"

-- DATE "01/08/2012 22:53:34"

-- 
-- Device: Altera EP2C20F484C6 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEII;
LIBRARY IEEE;
USE CYCLONEII.CYCLONEII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	i2c_interface IS
    PORT (
	readdata : OUT std_logic_vector(7 DOWNTO 0);
	irq : OUT std_logic;
	clk : IN std_logic;
	reset : IN std_logic;
	address : IN std_logic_vector(1 DOWNTO 0);
	chipselect : IN std_logic;
	write : IN std_logic;
	writedata : IN std_logic_vector(7 DOWNTO 0);
	read : IN std_logic;
	scl : INOUT std_logic;
	sda : INOUT std_logic
	);
END i2c_interface;

-- Design Ports Information
-- scl	=>  Location: PIN_D1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- sda	=>  Location: PIN_H4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[0]	=>  Location: PIN_AB12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[1]	=>  Location: PIN_C19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[2]	=>  Location: PIN_F3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[3]	=>  Location: PIN_D3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[4]	=>  Location: PIN_E4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[5]	=>  Location: PIN_D4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[6]	=>  Location: PIN_B11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- readdata[7]	=>  Location: PIN_D6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- irq	=>  Location: PIN_U13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- clk	=>  Location: PIN_M1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- address[0]	=>  Location: PIN_D5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- reset	=>  Location: PIN_M2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- address[1]	=>  Location: PIN_F4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- chipselect	=>  Location: PIN_H19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- read	=>  Location: PIN_C1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- writedata[0]	=>  Location: PIN_H5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- write	=>  Location: PIN_U9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- writedata[1]	=>  Location: PIN_G6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- writedata[2]	=>  Location: PIN_C2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- writedata[4]	=>  Location: PIN_G3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- writedata[3]	=>  Location: PIN_R11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- writedata[5]	=>  Location: PIN_G5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- writedata[6]	=>  Location: PIN_E1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- writedata[7]	=>  Location: PIN_E3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF i2c_interface IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_readdata : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_irq : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL ww_address : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_chipselect : std_logic;
SIGNAL ww_write : std_logic;
SIGNAL ww_writedata : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_read : std_logic;
SIGNAL \clk~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \reset~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clkgen|clk_ctr[5]~18_combout\ : std_logic;
SIGNAL \core|ack_out~regout\ : std_logic;
SIGNAL \core|busy~regout\ : std_logic;
SIGNAL \core|i_ack_out~regout\ : std_logic;
SIGNAL \core|i_busy~0_combout\ : std_logic;
SIGNAL \core|i_ack_out~0_combout\ : std_logic;
SIGNAL \core|Mux1~0_combout\ : std_logic;
SIGNAL \core|Mux1~1_combout\ : std_logic;
SIGNAL \core|i_dout[2]~4_combout\ : std_logic;
SIGNAL \core|i_dout[4]~9_combout\ : std_logic;
SIGNAL \core|i_dout[5]~12_combout\ : std_logic;
SIGNAL \core|i_dout[6]~14_combout\ : std_logic;
SIGNAL \core|WideOr5~0_combout\ : std_logic;
SIGNAL \core|WideOr5~2_combout\ : std_logic;
SIGNAL \core|WideOr5~3_combout\ : std_logic;
SIGNAL \core|Selector0~2_combout\ : std_logic;
SIGNAL \core|Add0~0_combout\ : std_logic;
SIGNAL \i_stop_reg~regout\ : std_logic;
SIGNAL \i_stop_reg~1_combout\ : std_logic;
SIGNAL \i_clkdiv_reg[7]~3_combout\ : std_logic;
SIGNAL \core|ack_out~feeder_combout\ : std_logic;
SIGNAL \i_data_in[1]~feeder_combout\ : std_logic;
SIGNAL \i_clkdiv_reg[3]~feeder_combout\ : std_logic;
SIGNAL \sda~0\ : std_logic;
SIGNAL \clk~combout\ : std_logic;
SIGNAL \clk~clkctrl_outclk\ : std_logic;
SIGNAL \scl_in~0_combout\ : std_logic;
SIGNAL \scl_in~regout\ : std_logic;
SIGNAL \write~combout\ : std_logic;
SIGNAL \chipselect~combout\ : std_logic;
SIGNAL \i_stop_reg~0_combout\ : std_logic;
SIGNAL \i_read_reg~0_combout\ : std_logic;
SIGNAL \reset~combout\ : std_logic;
SIGNAL \reset~clkctrl_outclk\ : std_logic;
SIGNAL \i_read_reg~regout\ : std_logic;
SIGNAL \core|n_state~0_combout\ : std_logic;
SIGNAL \i_write_reg~7_combout\ : std_logic;
SIGNAL \i_write_reg~6_combout\ : std_logic;
SIGNAL \i_write_reg~regout\ : std_logic;
SIGNAL \core|p_state~68_combout\ : std_logic;
SIGNAL \core|i_ctr~2_combout\ : std_logic;
SIGNAL \i_start_reg~0_combout\ : std_logic;
SIGNAL \readdata[2]~4_combout\ : std_logic;
SIGNAL \i_stop_reg~2_combout\ : std_logic;
SIGNAL \i_start_reg~regout\ : std_logic;
SIGNAL \core|Selector24~0_combout\ : std_logic;
SIGNAL \core|p_state~74_combout\ : std_logic;
SIGNAL \core|p_state~82_combout\ : std_logic;
SIGNAL \core|p_state.s_RdAck_D~regout\ : std_logic;
SIGNAL \core|p_state.s_RdAck_E~regout\ : std_logic;
SIGNAL \core|p_state.s_WrAck_B~regout\ : std_logic;
SIGNAL \core|p_state.s_WrAck_C~regout\ : std_logic;
SIGNAL \core|p_state.s_WrAck_D~regout\ : std_logic;
SIGNAL \core|Selector10~0_combout\ : std_logic;
SIGNAL \core|p_state.s_Stop_A~regout\ : std_logic;
SIGNAL \core|p_state.s_Stop_B~regout\ : std_logic;
SIGNAL \core|p_state.s_Stop_C~regout\ : std_logic;
SIGNAL \core|p_state~76_combout\ : std_logic;
SIGNAL \core|p_state~77_combout\ : std_logic;
SIGNAL \core|p_state.s_Done~regout\ : std_logic;
SIGNAL \core|p_state~75_combout\ : std_logic;
SIGNAL \core|p_state.s_DoneAck~regout\ : std_logic;
SIGNAL \core|i_cmd_done~0_combout\ : std_logic;
SIGNAL \core|cmd_done~regout\ : std_logic;
SIGNAL \i_cmd_done_ack~0_combout\ : std_logic;
SIGNAL \i_cmd_done_ack~regout\ : std_logic;
SIGNAL \core|p_state~79_combout\ : std_logic;
SIGNAL \core|p_state.s_Start_A~regout\ : std_logic;
SIGNAL \core|p_state.s_Start_B~feeder_combout\ : std_logic;
SIGNAL \core|p_state.s_Start_B~regout\ : std_logic;
SIGNAL \core|p_state.s_Start_C~regout\ : std_logic;
SIGNAL \core|Selector9~0_combout\ : std_logic;
SIGNAL \core|p_state.s_Start_D~regout\ : std_logic;
SIGNAL \core|Selector3~0_combout\ : std_logic;
SIGNAL \core|p_state~73_combout\ : std_logic;
SIGNAL \core|p_state~83_combout\ : std_logic;
SIGNAL \core|p_state.s_Wr_E~regout\ : std_logic;
SIGNAL \core|Selector24~1_combout\ : std_logic;
SIGNAL \core|Selector24~2_combout\ : std_logic;
SIGNAL \core|p_state.s_Wr_A~regout\ : std_logic;
SIGNAL \core|p_state.s_Wr_B~feeder_combout\ : std_logic;
SIGNAL \core|p_state.s_Wr_B~regout\ : std_logic;
SIGNAL \core|p_state.s_Wr_C~regout\ : std_logic;
SIGNAL \core|p_state.s_Wr_D~regout\ : std_logic;
SIGNAL \core|p_state~80_combout\ : std_logic;
SIGNAL \core|p_state.s_RdAck_A~regout\ : std_logic;
SIGNAL \core|p_state.s_RdAck_B~feeder_combout\ : std_logic;
SIGNAL \core|p_state.s_RdAck_B~regout\ : std_logic;
SIGNAL \core|p_state~70_combout\ : std_logic;
SIGNAL \core|p_state.s_RdAck_C~regout\ : std_logic;
SIGNAL \clkgen|clk_ctr[0]~8_combout\ : std_logic;
SIGNAL \clkgen|clk_ctr[0]~9\ : std_logic;
SIGNAL \clkgen|clk_ctr[1]~11\ : std_logic;
SIGNAL \clkgen|clk_ctr[2]~12_combout\ : std_logic;
SIGNAL \clkgen|clk_ctr[2]~13\ : std_logic;
SIGNAL \clkgen|clk_ctr[3]~15\ : std_logic;
SIGNAL \clkgen|clk_ctr[4]~16_combout\ : std_logic;
SIGNAL \clkgen|clk_ctr[4]~17\ : std_logic;
SIGNAL \clkgen|clk_ctr[5]~19\ : std_logic;
SIGNAL \clkgen|clk_ctr[6]~20_combout\ : std_logic;
SIGNAL \clkgen|clk_ctr[6]~21\ : std_logic;
SIGNAL \clkgen|clk_ctr[7]~22_combout\ : std_logic;
SIGNAL \i_clkdiv_reg[0]~0_combout\ : std_logic;
SIGNAL \i_clkdiv_reg[5]~feeder_combout\ : std_logic;
SIGNAL \i_clkdiv_reg[4]~feeder_combout\ : std_logic;
SIGNAL \clkgen|clk_ctr[3]~14_combout\ : std_logic;
SIGNAL \clkgen|clk_ctr[1]~10_combout\ : std_logic;
SIGNAL \clkgen|LessThan0~1_cout\ : std_logic;
SIGNAL \clkgen|LessThan0~3_cout\ : std_logic;
SIGNAL \clkgen|LessThan0~5_cout\ : std_logic;
SIGNAL \clkgen|LessThan0~7_cout\ : std_logic;
SIGNAL \clkgen|LessThan0~9_cout\ : std_logic;
SIGNAL \clkgen|LessThan0~11_cout\ : std_logic;
SIGNAL \clkgen|LessThan0~13_cout\ : std_logic;
SIGNAL \clkgen|LessThan0~14_combout\ : std_logic;
SIGNAL \clkgen|i_clk_out~regout\ : std_logic;
SIGNAL \core|Selector13~0_combout\ : std_logic;
SIGNAL \core|Selector13~1_combout\ : std_logic;
SIGNAL \core|p_state~81_combout\ : std_logic;
SIGNAL \core|p_state.s_Rd_D~regout\ : std_logic;
SIGNAL \core|p_state.s_Rd_E~regout\ : std_logic;
SIGNAL \core|p_state~72_combout\ : std_logic;
SIGNAL \core|p_state.s_Rd_F~regout\ : std_logic;
SIGNAL \core|Selector13~2_combout\ : std_logic;
SIGNAL \core|p_state.s_Rd_A~regout\ : std_logic;
SIGNAL \core|p_state.s_Rd_B~regout\ : std_logic;
SIGNAL \core|p_state~71_combout\ : std_logic;
SIGNAL \core|p_state.s_Rd_C~regout\ : std_logic;
SIGNAL \core|i2c_sync~0_combout\ : std_logic;
SIGNAL \core|i2c_sync~1_combout\ : std_logic;
SIGNAL \core|p_state.s_Reset~feeder_combout\ : std_logic;
SIGNAL \core|p_state.s_Reset~regout\ : std_logic;
SIGNAL \core|p_state~69_combout\ : std_logic;
SIGNAL \core|p_state.s_Idle~regout\ : std_logic;
SIGNAL \core|i_ctr~1_combout\ : std_logic;
SIGNAL \core|p_state~78_combout\ : std_logic;
SIGNAL \core|p_state.s_WrAck_A~regout\ : std_logic;
SIGNAL \core|WideOr5~1_combout\ : std_logic;
SIGNAL \core|Selector1~0_combout\ : std_logic;
SIGNAL \core|scl_out~regout\ : std_logic;
SIGNAL \core|i_ctr~0_combout\ : std_logic;
SIGNAL \i_data_in[7]~0_combout\ : std_logic;
SIGNAL \core|Mux0~0_combout\ : std_logic;
SIGNAL \core|Mux0~1_combout\ : std_logic;
SIGNAL \core|WideOr1~3_combout\ : std_logic;
SIGNAL \core|Selector0~0_combout\ : std_logic;
SIGNAL \i_data_in[4]~feeder_combout\ : std_logic;
SIGNAL \core|Mux0~2_combout\ : std_logic;
SIGNAL \core|Mux0~3_combout\ : std_logic;
SIGNAL \core|Selector0~1_combout\ : std_logic;
SIGNAL \core|WideOr1~0_combout\ : std_logic;
SIGNAL \core|WideOr1~1_combout\ : std_logic;
SIGNAL \core|WideOr1~2_combout\ : std_logic;
SIGNAL \i_ack_reg~feeder_combout\ : std_logic;
SIGNAL \i_ack_reg~regout\ : std_logic;
SIGNAL \core|Selector0~3_combout\ : std_logic;
SIGNAL \core|sda_out~regout\ : std_logic;
SIGNAL \i_clkdiv_reg[0]~1_combout\ : std_logic;
SIGNAL \readdata[0]~0_combout\ : std_logic;
SIGNAL \sda_in~regout\ : std_logic;
SIGNAL \core|i_dout[0]~0_combout\ : std_logic;
SIGNAL \core|data_out[0]~feeder_combout\ : std_logic;
SIGNAL \read~combout\ : std_logic;
SIGNAL \i_read_strobe~combout\ : std_logic;
SIGNAL \readdata[0]~reg0_regout\ : std_logic;
SIGNAL \i_clkdiv_reg[1]~2_combout\ : std_logic;
SIGNAL \readdata[1]~1_combout\ : std_logic;
SIGNAL \core|i_dout[1]~2_combout\ : std_logic;
SIGNAL \core|i_dout[1]~1_combout\ : std_logic;
SIGNAL \core|i_dout[1]~3_combout\ : std_logic;
SIGNAL \core|data_out[1]~feeder_combout\ : std_logic;
SIGNAL \readdata[1]~reg0_regout\ : std_logic;
SIGNAL \i_clkdiv_reg[2]~feeder_combout\ : std_logic;
SIGNAL \readdata[2]~2_combout\ : std_logic;
SIGNAL \core|i_dout[2]~5_combout\ : std_logic;
SIGNAL \core|data_out[2]~feeder_combout\ : std_logic;
SIGNAL \readdata[2]~reg0_regout\ : std_logic;
SIGNAL \readdata[3]~3_combout\ : std_logic;
SIGNAL \core|i_dout[2]~6_combout\ : std_logic;
SIGNAL \core|i_dout[3]~7_combout\ : std_logic;
SIGNAL \core|data_out[3]~feeder_combout\ : std_logic;
SIGNAL \readdata[3]~reg0_regout\ : std_logic;
SIGNAL \core|i_dout[4]~10_combout\ : std_logic;
SIGNAL \core|i_dout[4]~8_combout\ : std_logic;
SIGNAL \core|i_dout[4]~11_combout\ : std_logic;
SIGNAL \core|data_out[4]~feeder_combout\ : std_logic;
SIGNAL \Mux3~0_combout\ : std_logic;
SIGNAL \readdata[4]~reg0_regout\ : std_logic;
SIGNAL \core|i_dout[5]~13_combout\ : std_logic;
SIGNAL \core|data_out[5]~feeder_combout\ : std_logic;
SIGNAL \Mux2~0_combout\ : std_logic;
SIGNAL \readdata[5]~reg0_regout\ : std_logic;
SIGNAL \core|i_dout[6]~15_combout\ : std_logic;
SIGNAL \core|data_out[6]~feeder_combout\ : std_logic;
SIGNAL \Mux1~0_combout\ : std_logic;
SIGNAL \readdata[6]~reg0_regout\ : std_logic;
SIGNAL \core|i_dout[7]~16_combout\ : std_logic;
SIGNAL \core|i_dout[7]~17_combout\ : std_logic;
SIGNAL \Mux0~0_combout\ : std_logic;
SIGNAL \readdata[7]~reg0_regout\ : std_logic;
SIGNAL \i_int_pe_reg~0_combout\ : std_logic;
SIGNAL \i_int_pe_reg~1_combout\ : std_logic;
SIGNAL \i_int_pe_reg~regout\ : std_logic;
SIGNAL \i_int_en_reg~regout\ : std_logic;
SIGNAL \i_irq~combout\ : std_logic;
SIGNAL \irq~reg0_regout\ : std_logic;
SIGNAL \clkgen|clk_ctr\ : std_logic_vector(7 DOWNTO 0);
SIGNAL i_clkdiv_reg : std_logic_vector(7 DOWNTO 0);
SIGNAL i_data_in : std_logic_vector(7 DOWNTO 0);
SIGNAL \address~combout\ : std_logic_vector(1 DOWNTO 0);
SIGNAL \writedata~combout\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \core|data_out\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \core|i_ctr\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \core|i_dout\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \clkgen|ALT_INV_LessThan0~14_combout\ : std_logic;
SIGNAL \core|ALT_INV_scl_out~regout\ : std_logic;
SIGNAL \core|ALT_INV_sda_out~regout\ : std_logic;
SIGNAL \ALT_INV_address~combout\ : std_logic_vector(1 DOWNTO 1);

BEGIN

readdata <= ww_readdata;
irq <= ww_irq;
ww_clk <= clk;
ww_reset <= reset;
ww_address <= address;
ww_chipselect <= chipselect;
ww_write <= write;
ww_writedata <= writedata;
ww_read <= read;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \clk~combout\);

\reset~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \reset~combout\);
\clkgen|ALT_INV_LessThan0~14_combout\ <= NOT \clkgen|LessThan0~14_combout\;
\core|ALT_INV_scl_out~regout\ <= NOT \core|scl_out~regout\;
\core|ALT_INV_sda_out~regout\ <= NOT \core|sda_out~regout\;
\ALT_INV_address~combout\(1) <= NOT \address~combout\(1);

-- Location: LCFF_X32_Y24_N25
\clkgen|clk_ctr[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \clkgen|clk_ctr[5]~18_combout\,
	aclr => \reset~clkctrl_outclk\,
	sclr => \clkgen|ALT_INV_LessThan0~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \clkgen|clk_ctr\(5));

-- Location: LCCOMB_X32_Y24_N24
\clkgen|clk_ctr[5]~18\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|clk_ctr[5]~18_combout\ = (\clkgen|clk_ctr\(5) & (!\clkgen|clk_ctr[4]~17\)) # (!\clkgen|clk_ctr\(5) & ((\clkgen|clk_ctr[4]~17\) # (GND)))
-- \clkgen|clk_ctr[5]~19\ = CARRY((!\clkgen|clk_ctr[4]~17\) # (!\clkgen|clk_ctr\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \clkgen|clk_ctr\(5),
	datad => VCC,
	cin => \clkgen|clk_ctr[4]~17\,
	combout => \clkgen|clk_ctr[5]~18_combout\,
	cout => \clkgen|clk_ctr[5]~19\);

-- Location: LCFF_X21_Y24_N25
\core|ack_out\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|ack_out~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|ack_out~regout\);

-- Location: LCFF_X19_Y24_N13
\core|busy\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|i_busy~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|busy~regout\);

-- Location: LCFF_X29_Y24_N7
\i_clkdiv_reg[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \i_clkdiv_reg[3]~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \i_clkdiv_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_clkdiv_reg(3));

-- Location: LCFF_X29_Y24_N21
\i_clkdiv_reg[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \i_clkdiv_reg[7]~3_combout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \i_clkdiv_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_clkdiv_reg(7));

-- Location: LCFF_X21_Y24_N11
\core|i_ack_out\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|i_ack_out~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|i_ack_out~regout\);

-- Location: LCCOMB_X19_Y24_N12
\core|i_busy~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_busy~0_combout\ = (!\core|p_state.s_Idle~regout\ & \core|p_state.s_Reset~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \core|p_state.s_Idle~regout\,
	datad => \core|p_state.s_Reset~regout\,
	combout => \core|i_busy~0_combout\);

-- Location: LCCOMB_X21_Y24_N10
\core|i_ack_out~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_ack_out~0_combout\ = (\core|p_state.s_RdAck_C~regout\ & (\sda_in~regout\)) # (!\core|p_state.s_RdAck_C~regout\ & ((\core|i_ack_out~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \sda_in~regout\,
	datac => \core|i_ack_out~regout\,
	datad => \core|p_state.s_RdAck_C~regout\,
	combout => \core|i_ack_out~0_combout\);

-- Location: LCCOMB_X21_Y24_N12
\core|Mux1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Mux1~0_combout\ = (\core|i_ctr\(0) & (\core|i_ctr\(1) & \core|i_ctr\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \core|i_ctr\(0),
	datac => \core|i_ctr\(1),
	datad => \core|i_ctr\(2),
	combout => \core|Mux1~0_combout\);

-- Location: LCCOMB_X20_Y24_N6
\core|Mux1~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Mux1~1_combout\ = (\core|i_ctr\(1) & \core|i_ctr\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_ctr\(1),
	datac => \core|i_ctr\(2),
	combout => \core|Mux1~1_combout\);

-- Location: LCCOMB_X21_Y24_N16
\core|i_dout[2]~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[2]~4_combout\ = (\core|i_ctr\(0) & (!\core|i_ctr\(1) & \core|i_ctr\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \core|i_ctr\(0),
	datac => \core|i_ctr\(1),
	datad => \core|i_ctr\(2),
	combout => \core|i_dout[2]~4_combout\);

-- Location: LCCOMB_X21_Y24_N2
\core|i_dout[4]~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[4]~9_combout\ = (\core|i_ctr\(1) & \core|i_ctr\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \core|i_ctr\(1),
	datad => \core|i_ctr\(0),
	combout => \core|i_dout[4]~9_combout\);

-- Location: LCCOMB_X21_Y24_N22
\core|i_dout[5]~12\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[5]~12_combout\ = (\core|i_ctr\(1) & !\core|i_ctr\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \core|i_ctr\(1),
	datad => \core|i_ctr\(0),
	combout => \core|i_dout[5]~12_combout\);

-- Location: LCCOMB_X21_Y24_N8
\core|i_dout[6]~14\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[6]~14_combout\ = (!\core|i_ctr\(1) & \core|i_ctr\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \core|i_ctr\(1),
	datad => \core|i_ctr\(0),
	combout => \core|i_dout[6]~14_combout\);

-- Location: LCCOMB_X14_Y24_N12
\core|WideOr5~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|WideOr5~0_combout\ = (!\core|p_state.s_Start_D~regout\ & (!\core|p_state.s_Wr_A~regout\ & (!\core|p_state.s_Wr_D~regout\ & !\core|p_state.s_Wr_E~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|p_state.s_Start_D~regout\,
	datab => \core|p_state.s_Wr_A~regout\,
	datac => \core|p_state.s_Wr_D~regout\,
	datad => \core|p_state.s_Wr_E~regout\,
	combout => \core|WideOr5~0_combout\);

-- Location: LCCOMB_X14_Y24_N20
\core|WideOr5~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|WideOr5~2_combout\ = (!\core|p_state.s_Rd_F~regout\ & (!\core|p_state.s_Rd_A~regout\ & (!\core|p_state.s_Rd_E~regout\ & !\core|p_state.s_Start_A~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|p_state.s_Rd_F~regout\,
	datab => \core|p_state.s_Rd_A~regout\,
	datac => \core|p_state.s_Rd_E~regout\,
	datad => \core|p_state.s_Start_A~regout\,
	combout => \core|WideOr5~2_combout\);

-- Location: LCCOMB_X14_Y24_N6
\core|WideOr5~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|WideOr5~3_combout\ = (\core|WideOr5~2_combout\ & (!\core|p_state.s_RdAck_E~regout\ & !\core|p_state.s_RdAck_A~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|WideOr5~2_combout\,
	datac => \core|p_state.s_RdAck_E~regout\,
	datad => \core|p_state.s_RdAck_A~regout\,
	combout => \core|WideOr5~3_combout\);

-- Location: LCFF_X11_Y24_N17
\i_data_in[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \writedata~combout\(2),
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \i_data_in[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_data_in(2));

-- Location: LCFF_X11_Y24_N11
\i_data_in[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \i_data_in[1]~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \i_data_in[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_data_in(1));

-- Location: LCCOMB_X18_Y24_N12
\core|Selector0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Selector0~2_combout\ = (\core|p_state.s_WrAck_A~regout\) # ((\core|p_state.s_WrAck_D~regout\) # ((\core|p_state.s_WrAck_B~regout\) # (\core|p_state.s_WrAck_C~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|p_state.s_WrAck_A~regout\,
	datab => \core|p_state.s_WrAck_D~regout\,
	datac => \core|p_state.s_WrAck_B~regout\,
	datad => \core|p_state.s_WrAck_C~regout\,
	combout => \core|Selector0~2_combout\);

-- Location: LCCOMB_X11_Y24_N20
\core|Add0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Add0~0_combout\ = (\core|i_ctr\(0) & ((\core|p_state.s_Wr_E~regout\) # (\core|p_state.s_Rd_F~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100011001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|p_state.s_Wr_E~regout\,
	datab => \core|i_ctr\(0),
	datac => \core|p_state.s_Rd_F~regout\,
	combout => \core|Add0~0_combout\);

-- Location: LCFF_X15_Y24_N5
i_stop_reg : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \i_stop_reg~1_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \i_stop_reg~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i_stop_reg~regout\);

-- Location: LCCOMB_X15_Y24_N4
\i_stop_reg~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_stop_reg~1_combout\ = (!\i_read_reg~regout\ & (!\i_write_reg~regout\ & \writedata~combout\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_read_reg~regout\,
	datab => \i_write_reg~regout\,
	datad => \writedata~combout\(1),
	combout => \i_stop_reg~1_combout\);

-- Location: LCCOMB_X29_Y24_N10
\i_clkdiv_reg[7]~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_clkdiv_reg[7]~3_combout\ = !\writedata~combout\(7)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \writedata~combout\(7),
	combout => \i_clkdiv_reg[7]~3_combout\);

-- Location: LCCOMB_X21_Y24_N24
\core|ack_out~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|ack_out~feeder_combout\ = \core|i_ack_out~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \core|i_ack_out~regout\,
	combout => \core|ack_out~feeder_combout\);

-- Location: LCCOMB_X11_Y24_N10
\i_data_in[1]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_data_in[1]~feeder_combout\ = \writedata~combout\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \writedata~combout\(1),
	combout => \i_data_in[1]~feeder_combout\);

-- Location: LCCOMB_X29_Y24_N6
\i_clkdiv_reg[3]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_clkdiv_reg[3]~feeder_combout\ = \writedata~combout\(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \writedata~combout\(3),
	combout => \i_clkdiv_reg[3]~feeder_combout\);

-- Location: PIN_H4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\sda~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	open_drain_output => "true",
	operation_mode => "bidir",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \core|ALT_INV_sda_out~regout\,
	oe => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	padio => sda,
	combout => \sda~0\);

-- Location: PIN_M1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\clk~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_clk,
	combout => \clk~combout\);

-- Location: CLKCTRL_G3
\clk~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~clkctrl_outclk\);

-- Location: LCCOMB_X14_Y24_N28
\scl_in~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \scl_in~0_combout\ = !\core|scl_out~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \core|scl_out~regout\,
	combout => \scl_in~0_combout\);

-- Location: LCFF_X14_Y24_N29
scl_in : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \scl_in~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \scl_in~regout\);

-- Location: PIN_G3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\writedata[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_writedata(4),
	combout => \writedata~combout\(4));

-- Location: PIN_F4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\address[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_address(1),
	combout => \address~combout\(1));

-- Location: PIN_U9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\write~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_write,
	combout => \write~combout\);

-- Location: PIN_H19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\chipselect~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_chipselect,
	combout => \chipselect~combout\);

-- Location: LCCOMB_X13_Y19_N0
\i_stop_reg~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_stop_reg~0_combout\ = (\write~combout\ & \chipselect~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \write~combout\,
	datad => \chipselect~combout\,
	combout => \i_stop_reg~0_combout\);

-- Location: PIN_R11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\writedata[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_writedata(3),
	combout => \writedata~combout\(3));

-- Location: LCCOMB_X15_Y24_N12
\i_read_reg~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_read_reg~0_combout\ = (\core|cmd_done~regout\ & (\writedata~combout\(3) & ((\i_write_reg~7_combout\)))) # (!\core|cmd_done~regout\ & ((\i_read_reg~regout\) # ((\writedata~combout\(3) & \i_write_reg~7_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|cmd_done~regout\,
	datab => \writedata~combout\(3),
	datac => \i_read_reg~regout\,
	datad => \i_write_reg~7_combout\,
	combout => \i_read_reg~0_combout\);

-- Location: PIN_M2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\reset~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_reset,
	combout => \reset~combout\);

-- Location: CLKCTRL_G1
\reset~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \reset~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \reset~clkctrl_outclk\);

-- Location: LCFF_X15_Y24_N13
i_read_reg : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \i_read_reg~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i_read_reg~regout\);

-- Location: LCCOMB_X18_Y24_N6
\core|n_state~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|n_state~0_combout\ = (!\i_write_reg~regout\ & !\i_read_reg~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \i_write_reg~regout\,
	datad => \i_read_reg~regout\,
	combout => \core|n_state~0_combout\);

-- Location: LCCOMB_X15_Y24_N6
\i_write_reg~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_write_reg~7_combout\ = (\address~combout\(0) & (!\address~combout\(1) & (\i_stop_reg~0_combout\ & \core|n_state~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \address~combout\(0),
	datab => \address~combout\(1),
	datac => \i_stop_reg~0_combout\,
	datad => \core|n_state~0_combout\,
	combout => \i_write_reg~7_combout\);

-- Location: LCCOMB_X15_Y24_N2
\i_write_reg~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_write_reg~6_combout\ = (\core|cmd_done~regout\ & (\writedata~combout\(4) & ((\i_write_reg~7_combout\)))) # (!\core|cmd_done~regout\ & ((\i_write_reg~regout\) # ((\writedata~combout\(4) & \i_write_reg~7_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|cmd_done~regout\,
	datab => \writedata~combout\(4),
	datac => \i_write_reg~regout\,
	datad => \i_write_reg~7_combout\,
	combout => \i_write_reg~6_combout\);

-- Location: LCFF_X15_Y24_N3
i_write_reg : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \i_write_reg~6_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i_write_reg~regout\);

-- Location: LCCOMB_X15_Y24_N18
\core|p_state~68\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~68_combout\ = (!\i_read_reg~regout\ & (!\i_write_reg~regout\ & \core|p_state.s_Idle~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_read_reg~regout\,
	datab => \i_write_reg~regout\,
	datac => \core|p_state.s_Idle~regout\,
	combout => \core|p_state~68_combout\);

-- Location: LCCOMB_X11_Y24_N6
\core|i_ctr~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_ctr~2_combout\ = (!\core|p_state.s_Idle~regout\ & (\core|Add0~0_combout\ $ (\core|i_ctr\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|Add0~0_combout\,
	datac => \core|i_ctr\(1),
	datad => \core|p_state.s_Idle~regout\,
	combout => \core|i_ctr~2_combout\);

-- Location: LCFF_X11_Y24_N7
\core|i_ctr[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|i_ctr~2_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|i_ctr\(1));

-- Location: PIN_C2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\writedata[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_writedata(2),
	combout => \writedata~combout\(2));

-- Location: LCCOMB_X15_Y24_N30
\i_start_reg~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_start_reg~0_combout\ = (!\i_read_reg~regout\ & (!\i_write_reg~regout\ & \writedata~combout\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_read_reg~regout\,
	datab => \i_write_reg~regout\,
	datad => \writedata~combout\(2),
	combout => \i_start_reg~0_combout\);

-- Location: PIN_D5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\address[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_address(0),
	combout => \address~combout\(0));

-- Location: LCCOMB_X19_Y24_N24
\readdata[2]~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \readdata[2]~4_combout\ = (!\address~combout\(1) & \address~combout\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \address~combout\(1),
	datad => \address~combout\(0),
	combout => \readdata[2]~4_combout\);

-- Location: LCCOMB_X15_Y24_N20
\i_stop_reg~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_stop_reg~2_combout\ = (\core|n_state~0_combout\ & (((\i_stop_reg~0_combout\ & \readdata[2]~4_combout\)))) # (!\core|n_state~0_combout\ & (\core|cmd_done~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|cmd_done~regout\,
	datab => \i_stop_reg~0_combout\,
	datac => \readdata[2]~4_combout\,
	datad => \core|n_state~0_combout\,
	combout => \i_stop_reg~2_combout\);

-- Location: LCFF_X15_Y24_N31
i_start_reg : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \i_start_reg~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \i_stop_reg~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i_start_reg~regout\);

-- Location: LCCOMB_X14_Y24_N14
\core|Selector24~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Selector24~0_combout\ = (\i_write_reg~regout\ & ((\core|p_state.s_Start_D~regout\) # ((\core|p_state.s_Idle~regout\ & !\i_start_reg~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|p_state.s_Start_D~regout\,
	datab => \i_write_reg~regout\,
	datac => \core|p_state.s_Idle~regout\,
	datad => \i_start_reg~regout\,
	combout => \core|Selector24~0_combout\);

-- Location: LCCOMB_X18_Y24_N26
\core|p_state~74\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~74_combout\ = (\core|p_state.s_Wr_D~regout\ & (((!\core|i_ctr\(1)) # (!\core|i_ctr\(2))) # (!\core|i_ctr\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_ctr\(0),
	datab => \core|i_ctr\(2),
	datac => \core|i_ctr\(1),
	datad => \core|p_state.s_Wr_D~regout\,
	combout => \core|p_state~74_combout\);

-- Location: LCCOMB_X21_Y24_N6
\core|p_state~82\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~82_combout\ = (\core|p_state.s_RdAck_C~regout\) # ((\clkgen|i_clk_out~regout\ & \core|p_state.s_RdAck_D~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \clkgen|i_clk_out~regout\,
	datac => \core|p_state.s_RdAck_D~regout\,
	datad => \core|p_state.s_RdAck_C~regout\,
	combout => \core|p_state~82_combout\);

-- Location: LCFF_X21_Y24_N7
\core|p_state.s_RdAck_D\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state~82_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_RdAck_D~regout\);

-- Location: LCFF_X14_Y24_N7
\core|p_state.s_RdAck_E\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \core|p_state.s_RdAck_D~regout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_RdAck_E~regout\);

-- Location: LCFF_X18_Y24_N13
\core|p_state.s_WrAck_B\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \core|p_state.s_WrAck_A~regout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_WrAck_B~regout\);

-- Location: LCFF_X18_Y24_N19
\core|p_state.s_WrAck_C\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \core|p_state.s_WrAck_B~regout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_WrAck_C~regout\);

-- Location: LCFF_X18_Y24_N3
\core|p_state.s_WrAck_D\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \core|p_state.s_WrAck_C~regout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_WrAck_D~regout\);

-- Location: LCCOMB_X14_Y24_N16
\core|Selector10~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Selector10~0_combout\ = (\i_stop_reg~regout\ & ((\core|p_state.s_RdAck_E~regout\) # (\core|p_state.s_WrAck_D~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_stop_reg~regout\,
	datab => \core|p_state.s_RdAck_E~regout\,
	datad => \core|p_state.s_WrAck_D~regout\,
	combout => \core|Selector10~0_combout\);

-- Location: LCFF_X14_Y24_N17
\core|p_state.s_Stop_A\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|Selector10~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Stop_A~regout\);

-- Location: LCFF_X14_Y24_N9
\core|p_state.s_Stop_B\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \core|p_state.s_Stop_A~regout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Stop_B~regout\);

-- Location: LCFF_X14_Y24_N31
\core|p_state.s_Stop_C\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \core|p_state.s_Stop_B~regout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Stop_C~regout\);

-- Location: LCCOMB_X14_Y24_N30
\core|p_state~76\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~76_combout\ = (\core|p_state.s_Stop_C~regout\) # ((!\i_stop_reg~regout\ & ((\core|p_state.s_RdAck_E~regout\) # (\core|p_state.s_WrAck_D~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010111110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_stop_reg~regout\,
	datab => \core|p_state.s_RdAck_E~regout\,
	datac => \core|p_state.s_Stop_C~regout\,
	datad => \core|p_state.s_WrAck_D~regout\,
	combout => \core|p_state~76_combout\);

-- Location: LCCOMB_X15_Y24_N14
\core|p_state~77\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~77_combout\ = (\core|p_state~76_combout\ & \core|i2c_sync~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \core|p_state~76_combout\,
	datad => \core|i2c_sync~1_combout\,
	combout => \core|p_state~77_combout\);

-- Location: LCFF_X15_Y24_N15
\core|p_state.s_Done\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state~77_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Done~regout\);

-- Location: LCCOMB_X15_Y24_N28
\core|p_state~75\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~75_combout\ = (\core|p_state.s_Done~regout\) # ((!\i_cmd_done_ack~regout\ & \core|p_state.s_DoneAck~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110011011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_cmd_done_ack~regout\,
	datab => \core|p_state.s_Done~regout\,
	datac => \core|p_state.s_DoneAck~regout\,
	combout => \core|p_state~75_combout\);

-- Location: LCFF_X15_Y24_N29
\core|p_state.s_DoneAck\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state~75_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_DoneAck~regout\);

-- Location: LCCOMB_X15_Y24_N16
\core|i_cmd_done~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_cmd_done~0_combout\ = (\core|p_state.s_Done~regout\) # (\core|p_state.s_DoneAck~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \core|p_state.s_Done~regout\,
	datad => \core|p_state.s_DoneAck~regout\,
	combout => \core|i_cmd_done~0_combout\);

-- Location: LCFF_X15_Y24_N17
\core|cmd_done\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|i_cmd_done~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|cmd_done~regout\);

-- Location: LCCOMB_X15_Y24_N24
\i_cmd_done_ack~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_cmd_done_ack~0_combout\ = (\core|cmd_done~regout\ & ((\i_read_reg~regout\) # (\i_write_reg~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_read_reg~regout\,
	datab => \i_write_reg~regout\,
	datac => \core|cmd_done~regout\,
	combout => \i_cmd_done_ack~0_combout\);

-- Location: LCFF_X15_Y24_N25
i_cmd_done_ack : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \i_cmd_done_ack~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i_cmd_done_ack~regout\);

-- Location: LCCOMB_X18_Y24_N16
\core|p_state~79\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~79_combout\ = (\core|p_state.s_Idle~regout\ & ((\i_start_reg~regout\) # ((!\i_write_reg~regout\ & !\i_read_reg~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_write_reg~regout\,
	datab => \i_read_reg~regout\,
	datac => \i_start_reg~regout\,
	datad => \core|p_state.s_Idle~regout\,
	combout => \core|p_state~79_combout\);

-- Location: LCFF_X18_Y24_N17
\core|p_state.s_Start_A\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state~79_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \core|p_state~83_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Start_A~regout\);

-- Location: LCCOMB_X14_Y24_N24
\core|p_state.s_Start_B~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state.s_Start_B~feeder_combout\ = \core|p_state.s_Start_A~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \core|p_state.s_Start_A~regout\,
	combout => \core|p_state.s_Start_B~feeder_combout\);

-- Location: LCFF_X14_Y24_N25
\core|p_state.s_Start_B\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state.s_Start_B~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Start_B~regout\);

-- Location: LCFF_X14_Y24_N19
\core|p_state.s_Start_C\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \core|p_state.s_Start_B~regout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Start_C~regout\);

-- Location: LCCOMB_X14_Y24_N10
\core|Selector9~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Selector9~0_combout\ = (\core|p_state.s_Start_C~regout\) # ((!\i_read_reg~regout\ & (!\i_write_reg~regout\ & \core|p_state.s_Start_D~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_read_reg~regout\,
	datab => \i_write_reg~regout\,
	datac => \core|p_state.s_Start_D~regout\,
	datad => \core|p_state.s_Start_C~regout\,
	combout => \core|Selector9~0_combout\);

-- Location: LCFF_X14_Y24_N11
\core|p_state.s_Start_D\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|Selector9~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Start_D~regout\);

-- Location: LCCOMB_X18_Y24_N8
\core|Selector3~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Selector3~0_combout\ = (\core|p_state.s_DoneAck~regout\ & \i_cmd_done_ack~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \core|p_state.s_DoneAck~regout\,
	datad => \i_cmd_done_ack~regout\,
	combout => \core|Selector3~0_combout\);

-- Location: LCCOMB_X18_Y24_N0
\core|p_state~73\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~73_combout\ = (\core|n_state~0_combout\ & ((\core|p_state.s_Idle~regout\) # ((\core|p_state.s_Start_D~regout\ & !\core|Selector3~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|n_state~0_combout\,
	datab => \core|p_state.s_Start_D~regout\,
	datac => \core|Selector3~0_combout\,
	datad => \core|p_state.s_Idle~regout\,
	combout => \core|p_state~73_combout\);

-- Location: LCCOMB_X18_Y24_N14
\core|p_state~83\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~83_combout\ = (\core|i2c_sync~1_combout\ & (!\core|p_state~73_combout\ & ((\i_cmd_done_ack~regout\) # (!\core|p_state.s_DoneAck~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|p_state.s_DoneAck~regout\,
	datab => \i_cmd_done_ack~regout\,
	datac => \core|i2c_sync~1_combout\,
	datad => \core|p_state~73_combout\,
	combout => \core|p_state~83_combout\);

-- Location: LCFF_X18_Y24_N27
\core|p_state.s_Wr_E\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state~74_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \core|p_state~83_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Wr_E~regout\);

-- Location: LCCOMB_X14_Y24_N26
\core|Selector24~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Selector24~1_combout\ = (\core|p_state.s_Wr_E~regout\) # ((\core|p_state.s_Start_D~regout\ & (\core|p_state.s_Wr_A~regout\ & !\i_read_reg~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|p_state.s_Start_D~regout\,
	datab => \core|p_state.s_Wr_A~regout\,
	datac => \i_read_reg~regout\,
	datad => \core|p_state.s_Wr_E~regout\,
	combout => \core|Selector24~1_combout\);

-- Location: LCCOMB_X14_Y24_N22
\core|Selector24~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Selector24~2_combout\ = (\core|Selector24~0_combout\) # (\core|Selector24~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \core|Selector24~0_combout\,
	datad => \core|Selector24~1_combout\,
	combout => \core|Selector24~2_combout\);

-- Location: LCFF_X14_Y24_N23
\core|p_state.s_Wr_A\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|Selector24~2_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Wr_A~regout\);

-- Location: LCCOMB_X18_Y24_N28
\core|p_state.s_Wr_B~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state.s_Wr_B~feeder_combout\ = \core|p_state.s_Wr_A~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \core|p_state.s_Wr_A~regout\,
	combout => \core|p_state.s_Wr_B~feeder_combout\);

-- Location: LCFF_X18_Y24_N29
\core|p_state.s_Wr_B\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state.s_Wr_B~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Wr_B~regout\);

-- Location: LCFF_X18_Y24_N5
\core|p_state.s_Wr_C\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \core|p_state.s_Wr_B~regout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Wr_C~regout\);

-- Location: LCFF_X14_Y24_N13
\core|p_state.s_Wr_D\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \core|p_state.s_Wr_C~regout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Wr_D~regout\);

-- Location: LCCOMB_X18_Y24_N24
\core|p_state~80\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~80_combout\ = (\core|i_ctr\(0) & (\core|i_ctr\(2) & (\core|i_ctr\(1) & \core|p_state.s_Wr_D~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_ctr\(0),
	datab => \core|i_ctr\(2),
	datac => \core|i_ctr\(1),
	datad => \core|p_state.s_Wr_D~regout\,
	combout => \core|p_state~80_combout\);

-- Location: LCFF_X18_Y24_N25
\core|p_state.s_RdAck_A\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state~80_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \core|p_state~83_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_RdAck_A~regout\);

-- Location: LCCOMB_X21_Y24_N28
\core|p_state.s_RdAck_B~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state.s_RdAck_B~feeder_combout\ = \core|p_state.s_RdAck_A~regout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \core|p_state.s_RdAck_A~regout\,
	combout => \core|p_state.s_RdAck_B~feeder_combout\);

-- Location: LCFF_X21_Y24_N29
\core|p_state.s_RdAck_B\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state.s_RdAck_B~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_RdAck_B~regout\);

-- Location: LCCOMB_X21_Y24_N18
\core|p_state~70\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~70_combout\ = (\core|i2c_sync~1_combout\ & \core|p_state.s_RdAck_B~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \core|i2c_sync~1_combout\,
	datad => \core|p_state.s_RdAck_B~regout\,
	combout => \core|p_state~70_combout\);

-- Location: LCFF_X21_Y24_N19
\core|p_state.s_RdAck_C\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state~70_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_RdAck_C~regout\);

-- Location: LCCOMB_X32_Y24_N14
\clkgen|clk_ctr[0]~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|clk_ctr[0]~8_combout\ = \clkgen|clk_ctr\(0) $ (VCC)
-- \clkgen|clk_ctr[0]~9\ = CARRY(\clkgen|clk_ctr\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \clkgen|clk_ctr\(0),
	datad => VCC,
	combout => \clkgen|clk_ctr[0]~8_combout\,
	cout => \clkgen|clk_ctr[0]~9\);

-- Location: LCFF_X32_Y24_N15
\clkgen|clk_ctr[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \clkgen|clk_ctr[0]~8_combout\,
	aclr => \reset~clkctrl_outclk\,
	sclr => \clkgen|ALT_INV_LessThan0~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \clkgen|clk_ctr\(0));

-- Location: LCCOMB_X32_Y24_N16
\clkgen|clk_ctr[1]~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|clk_ctr[1]~10_combout\ = (\clkgen|clk_ctr\(1) & (!\clkgen|clk_ctr[0]~9\)) # (!\clkgen|clk_ctr\(1) & ((\clkgen|clk_ctr[0]~9\) # (GND)))
-- \clkgen|clk_ctr[1]~11\ = CARRY((!\clkgen|clk_ctr[0]~9\) # (!\clkgen|clk_ctr\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \clkgen|clk_ctr\(1),
	datad => VCC,
	cin => \clkgen|clk_ctr[0]~9\,
	combout => \clkgen|clk_ctr[1]~10_combout\,
	cout => \clkgen|clk_ctr[1]~11\);

-- Location: LCCOMB_X32_Y24_N18
\clkgen|clk_ctr[2]~12\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|clk_ctr[2]~12_combout\ = (\clkgen|clk_ctr\(2) & (\clkgen|clk_ctr[1]~11\ $ (GND))) # (!\clkgen|clk_ctr\(2) & (!\clkgen|clk_ctr[1]~11\ & VCC))
-- \clkgen|clk_ctr[2]~13\ = CARRY((\clkgen|clk_ctr\(2) & !\clkgen|clk_ctr[1]~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clkgen|clk_ctr\(2),
	datad => VCC,
	cin => \clkgen|clk_ctr[1]~11\,
	combout => \clkgen|clk_ctr[2]~12_combout\,
	cout => \clkgen|clk_ctr[2]~13\);

-- Location: LCFF_X32_Y24_N19
\clkgen|clk_ctr[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \clkgen|clk_ctr[2]~12_combout\,
	aclr => \reset~clkctrl_outclk\,
	sclr => \clkgen|ALT_INV_LessThan0~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \clkgen|clk_ctr\(2));

-- Location: LCCOMB_X32_Y24_N20
\clkgen|clk_ctr[3]~14\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|clk_ctr[3]~14_combout\ = (\clkgen|clk_ctr\(3) & (!\clkgen|clk_ctr[2]~13\)) # (!\clkgen|clk_ctr\(3) & ((\clkgen|clk_ctr[2]~13\) # (GND)))
-- \clkgen|clk_ctr[3]~15\ = CARRY((!\clkgen|clk_ctr[2]~13\) # (!\clkgen|clk_ctr\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \clkgen|clk_ctr\(3),
	datad => VCC,
	cin => \clkgen|clk_ctr[2]~13\,
	combout => \clkgen|clk_ctr[3]~14_combout\,
	cout => \clkgen|clk_ctr[3]~15\);

-- Location: LCCOMB_X32_Y24_N22
\clkgen|clk_ctr[4]~16\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|clk_ctr[4]~16_combout\ = (\clkgen|clk_ctr\(4) & (\clkgen|clk_ctr[3]~15\ $ (GND))) # (!\clkgen|clk_ctr\(4) & (!\clkgen|clk_ctr[3]~15\ & VCC))
-- \clkgen|clk_ctr[4]~17\ = CARRY((\clkgen|clk_ctr\(4) & !\clkgen|clk_ctr[3]~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clkgen|clk_ctr\(4),
	datad => VCC,
	cin => \clkgen|clk_ctr[3]~15\,
	combout => \clkgen|clk_ctr[4]~16_combout\,
	cout => \clkgen|clk_ctr[4]~17\);

-- Location: LCFF_X32_Y24_N23
\clkgen|clk_ctr[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \clkgen|clk_ctr[4]~16_combout\,
	aclr => \reset~clkctrl_outclk\,
	sclr => \clkgen|ALT_INV_LessThan0~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \clkgen|clk_ctr\(4));

-- Location: LCCOMB_X32_Y24_N26
\clkgen|clk_ctr[6]~20\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|clk_ctr[6]~20_combout\ = (\clkgen|clk_ctr\(6) & (\clkgen|clk_ctr[5]~19\ $ (GND))) # (!\clkgen|clk_ctr\(6) & (!\clkgen|clk_ctr[5]~19\ & VCC))
-- \clkgen|clk_ctr[6]~21\ = CARRY((\clkgen|clk_ctr\(6) & !\clkgen|clk_ctr[5]~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clkgen|clk_ctr\(6),
	datad => VCC,
	cin => \clkgen|clk_ctr[5]~19\,
	combout => \clkgen|clk_ctr[6]~20_combout\,
	cout => \clkgen|clk_ctr[6]~21\);

-- Location: LCFF_X32_Y24_N27
\clkgen|clk_ctr[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \clkgen|clk_ctr[6]~20_combout\,
	aclr => \reset~clkctrl_outclk\,
	sclr => \clkgen|ALT_INV_LessThan0~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \clkgen|clk_ctr\(6));

-- Location: LCCOMB_X32_Y24_N28
\clkgen|clk_ctr[7]~22\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|clk_ctr[7]~22_combout\ = \clkgen|clk_ctr[6]~21\ $ (\clkgen|clk_ctr\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \clkgen|clk_ctr\(7),
	cin => \clkgen|clk_ctr[6]~21\,
	combout => \clkgen|clk_ctr[7]~22_combout\);

-- Location: LCFF_X32_Y24_N29
\clkgen|clk_ctr[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \clkgen|clk_ctr[7]~22_combout\,
	aclr => \reset~clkctrl_outclk\,
	sclr => \clkgen|ALT_INV_LessThan0~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \clkgen|clk_ctr\(7));

-- Location: PIN_E1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\writedata[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_writedata(6),
	combout => \writedata~combout\(6));

-- Location: LCCOMB_X15_Y24_N22
\i_clkdiv_reg[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_clkdiv_reg[0]~0_combout\ = (\address~combout\(0) & (\address~combout\(1) & (\i_stop_reg~0_combout\ & \core|n_state~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \address~combout\(0),
	datab => \address~combout\(1),
	datac => \i_stop_reg~0_combout\,
	datad => \core|n_state~0_combout\,
	combout => \i_clkdiv_reg[0]~0_combout\);

-- Location: LCFF_X29_Y24_N5
\i_clkdiv_reg[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \writedata~combout\(6),
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \i_clkdiv_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_clkdiv_reg(6));

-- Location: PIN_G5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\writedata[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_writedata(5),
	combout => \writedata~combout\(5));

-- Location: LCCOMB_X29_Y24_N2
\i_clkdiv_reg[5]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_clkdiv_reg[5]~feeder_combout\ = \writedata~combout\(5)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \writedata~combout\(5),
	combout => \i_clkdiv_reg[5]~feeder_combout\);

-- Location: LCFF_X29_Y24_N3
\i_clkdiv_reg[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \i_clkdiv_reg[5]~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \i_clkdiv_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_clkdiv_reg(5));

-- Location: LCCOMB_X29_Y24_N0
\i_clkdiv_reg[4]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_clkdiv_reg[4]~feeder_combout\ = \writedata~combout\(4)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \writedata~combout\(4),
	combout => \i_clkdiv_reg[4]~feeder_combout\);

-- Location: LCFF_X29_Y24_N1
\i_clkdiv_reg[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \i_clkdiv_reg[4]~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \i_clkdiv_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_clkdiv_reg(4));

-- Location: LCFF_X32_Y24_N21
\clkgen|clk_ctr[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \clkgen|clk_ctr[3]~14_combout\,
	aclr => \reset~clkctrl_outclk\,
	sclr => \clkgen|ALT_INV_LessThan0~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \clkgen|clk_ctr\(3));

-- Location: LCFF_X32_Y24_N17
\clkgen|clk_ctr[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \clkgen|clk_ctr[1]~10_combout\,
	aclr => \reset~clkctrl_outclk\,
	sclr => \clkgen|ALT_INV_LessThan0~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \clkgen|clk_ctr\(1));

-- Location: LCCOMB_X29_Y24_N16
\clkgen|LessThan0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|LessThan0~1_cout\ = CARRY((!i_clkdiv_reg(0) & !\clkgen|clk_ctr\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010001",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => i_clkdiv_reg(0),
	datab => \clkgen|clk_ctr\(0),
	datad => VCC,
	cout => \clkgen|LessThan0~1_cout\);

-- Location: LCCOMB_X29_Y24_N18
\clkgen|LessThan0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|LessThan0~3_cout\ = CARRY((i_clkdiv_reg(1) & ((\clkgen|clk_ctr\(1)) # (!\clkgen|LessThan0~1_cout\))) # (!i_clkdiv_reg(1) & (\clkgen|clk_ctr\(1) & !\clkgen|LessThan0~1_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => i_clkdiv_reg(1),
	datab => \clkgen|clk_ctr\(1),
	datad => VCC,
	cin => \clkgen|LessThan0~1_cout\,
	cout => \clkgen|LessThan0~3_cout\);

-- Location: LCCOMB_X29_Y24_N20
\clkgen|LessThan0~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|LessThan0~5_cout\ = CARRY((i_clkdiv_reg(2) & ((!\clkgen|LessThan0~3_cout\) # (!\clkgen|clk_ctr\(2)))) # (!i_clkdiv_reg(2) & (!\clkgen|clk_ctr\(2) & !\clkgen|LessThan0~3_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => i_clkdiv_reg(2),
	datab => \clkgen|clk_ctr\(2),
	datad => VCC,
	cin => \clkgen|LessThan0~3_cout\,
	cout => \clkgen|LessThan0~5_cout\);

-- Location: LCCOMB_X29_Y24_N22
\clkgen|LessThan0~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|LessThan0~7_cout\ = CARRY((i_clkdiv_reg(3) & (\clkgen|clk_ctr\(3) & !\clkgen|LessThan0~5_cout\)) # (!i_clkdiv_reg(3) & ((\clkgen|clk_ctr\(3)) # (!\clkgen|LessThan0~5_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => i_clkdiv_reg(3),
	datab => \clkgen|clk_ctr\(3),
	datad => VCC,
	cin => \clkgen|LessThan0~5_cout\,
	cout => \clkgen|LessThan0~7_cout\);

-- Location: LCCOMB_X29_Y24_N24
\clkgen|LessThan0~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|LessThan0~9_cout\ = CARRY((\clkgen|clk_ctr\(4) & (i_clkdiv_reg(4) & !\clkgen|LessThan0~7_cout\)) # (!\clkgen|clk_ctr\(4) & ((i_clkdiv_reg(4)) # (!\clkgen|LessThan0~7_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \clkgen|clk_ctr\(4),
	datab => i_clkdiv_reg(4),
	datad => VCC,
	cin => \clkgen|LessThan0~7_cout\,
	cout => \clkgen|LessThan0~9_cout\);

-- Location: LCCOMB_X29_Y24_N26
\clkgen|LessThan0~11\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|LessThan0~11_cout\ = CARRY((\clkgen|clk_ctr\(5) & ((!\clkgen|LessThan0~9_cout\) # (!i_clkdiv_reg(5)))) # (!\clkgen|clk_ctr\(5) & (!i_clkdiv_reg(5) & !\clkgen|LessThan0~9_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \clkgen|clk_ctr\(5),
	datab => i_clkdiv_reg(5),
	datad => VCC,
	cin => \clkgen|LessThan0~9_cout\,
	cout => \clkgen|LessThan0~11_cout\);

-- Location: LCCOMB_X29_Y24_N28
\clkgen|LessThan0~13\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|LessThan0~13_cout\ = CARRY((\clkgen|clk_ctr\(6) & (i_clkdiv_reg(6) & !\clkgen|LessThan0~11_cout\)) # (!\clkgen|clk_ctr\(6) & ((i_clkdiv_reg(6)) # (!\clkgen|LessThan0~11_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \clkgen|clk_ctr\(6),
	datab => i_clkdiv_reg(6),
	datad => VCC,
	cin => \clkgen|LessThan0~11_cout\,
	cout => \clkgen|LessThan0~13_cout\);

-- Location: LCCOMB_X29_Y24_N30
\clkgen|LessThan0~14\ : cycloneii_lcell_comb
-- Equation(s):
-- \clkgen|LessThan0~14_combout\ = (i_clkdiv_reg(7) & (\clkgen|LessThan0~13_cout\ & !\clkgen|clk_ctr\(7))) # (!i_clkdiv_reg(7) & ((\clkgen|LessThan0~13_cout\) # (!\clkgen|clk_ctr\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000011110101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => i_clkdiv_reg(7),
	datad => \clkgen|clk_ctr\(7),
	cin => \clkgen|LessThan0~13_cout\,
	combout => \clkgen|LessThan0~14_combout\);

-- Location: LCFF_X29_Y24_N15
\clkgen|i_clk_out\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \clkgen|LessThan0~14_combout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \clkgen|i_clk_out~regout\);

-- Location: LCCOMB_X15_Y24_N0
\core|Selector13~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Selector13~0_combout\ = (!\i_write_reg~regout\ & ((\i_read_reg~regout\) # (\core|p_state.s_Rd_A~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_read_reg~regout\,
	datab => \i_write_reg~regout\,
	datad => \core|p_state.s_Rd_A~regout\,
	combout => \core|Selector13~0_combout\);

-- Location: LCCOMB_X15_Y24_N26
\core|Selector13~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Selector13~1_combout\ = (\core|p_state.s_Idle~regout\ & (!\i_start_reg~regout\ & ((\i_read_reg~regout\) # (\i_write_reg~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_read_reg~regout\,
	datab => \i_write_reg~regout\,
	datac => \core|p_state.s_Idle~regout\,
	datad => \i_start_reg~regout\,
	combout => \core|Selector13~1_combout\);

-- Location: LCCOMB_X20_Y24_N22
\core|p_state~81\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~81_combout\ = (\core|p_state.s_Rd_C~regout\) # ((\clkgen|i_clk_out~regout\ & \core|p_state.s_Rd_D~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \clkgen|i_clk_out~regout\,
	datac => \core|p_state.s_Rd_D~regout\,
	datad => \core|p_state.s_Rd_C~regout\,
	combout => \core|p_state~81_combout\);

-- Location: LCFF_X20_Y24_N23
\core|p_state.s_Rd_D\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state~81_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Rd_D~regout\);

-- Location: LCFF_X14_Y24_N21
\core|p_state.s_Rd_E\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \core|p_state.s_Rd_D~regout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Rd_E~regout\);

-- Location: LCCOMB_X18_Y24_N22
\core|p_state~72\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~72_combout\ = (\core|p_state.s_Rd_E~regout\ & (((!\core|i_ctr\(1)) # (!\core|i_ctr\(2))) # (!\core|i_ctr\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_ctr\(0),
	datab => \core|i_ctr\(2),
	datac => \core|i_ctr\(1),
	datad => \core|p_state.s_Rd_E~regout\,
	combout => \core|p_state~72_combout\);

-- Location: LCFF_X18_Y24_N23
\core|p_state.s_Rd_F\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state~72_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \core|p_state~83_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Rd_F~regout\);

-- Location: LCCOMB_X14_Y24_N2
\core|Selector13~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Selector13~2_combout\ = (\core|p_state.s_Rd_F~regout\) # ((\core|Selector13~0_combout\ & ((\core|p_state.s_Start_D~regout\) # (\core|Selector13~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|p_state.s_Start_D~regout\,
	datab => \core|Selector13~0_combout\,
	datac => \core|Selector13~1_combout\,
	datad => \core|p_state.s_Rd_F~regout\,
	combout => \core|Selector13~2_combout\);

-- Location: LCFF_X14_Y24_N3
\core|p_state.s_Rd_A\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|Selector13~2_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Rd_A~regout\);

-- Location: LCFF_X20_Y24_N13
\core|p_state.s_Rd_B\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \core|p_state.s_Rd_A~regout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \core|i2c_sync~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Rd_B~regout\);

-- Location: LCCOMB_X20_Y24_N28
\core|p_state~71\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~71_combout\ = (\core|i2c_sync~1_combout\ & \core|p_state.s_Rd_B~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \core|i2c_sync~1_combout\,
	datad => \core|p_state.s_Rd_B~regout\,
	combout => \core|p_state~71_combout\);

-- Location: LCFF_X20_Y24_N29
\core|p_state.s_Rd_C\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state~71_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Rd_C~regout\);

-- Location: LCCOMB_X18_Y24_N10
\core|i2c_sync~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i2c_sync~0_combout\ = (\core|p_state.s_Rd_F~regout\) # ((\core|p_state.s_Wr_E~regout\) # ((\core|p_state.s_Rd_C~regout\) # (!\clkgen|i_clk_out~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|p_state.s_Rd_F~regout\,
	datab => \core|p_state.s_Wr_E~regout\,
	datac => \clkgen|i_clk_out~regout\,
	datad => \core|p_state.s_Rd_C~regout\,
	combout => \core|i2c_sync~0_combout\);

-- Location: LCCOMB_X18_Y24_N20
\core|i2c_sync~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i2c_sync~1_combout\ = ((\core|p_state.s_RdAck_C~regout\) # ((\core|i_cmd_done~0_combout\) # (\core|i2c_sync~0_combout\))) # (!\core|i_busy~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_busy~0_combout\,
	datab => \core|p_state.s_RdAck_C~regout\,
	datac => \core|i_cmd_done~0_combout\,
	datad => \core|i2c_sync~0_combout\,
	combout => \core|i2c_sync~1_combout\);

-- Location: LCCOMB_X19_Y24_N28
\core|p_state.s_Reset~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state.s_Reset~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \core|p_state.s_Reset~feeder_combout\);

-- Location: LCFF_X19_Y24_N29
\core|p_state.s_Reset\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state.s_Reset~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Reset~regout\);

-- Location: LCCOMB_X19_Y24_N30
\core|p_state~69\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~69_combout\ = (\core|i2c_sync~1_combout\ & ((\core|Selector3~0_combout\) # ((\core|p_state~68_combout\) # (!\core|p_state.s_Reset~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|Selector3~0_combout\,
	datab => \core|p_state~68_combout\,
	datac => \core|i2c_sync~1_combout\,
	datad => \core|p_state.s_Reset~regout\,
	combout => \core|p_state~69_combout\);

-- Location: LCFF_X19_Y24_N31
\core|p_state.s_Idle\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state~69_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_Idle~regout\);

-- Location: LCCOMB_X11_Y24_N12
\core|i_ctr~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_ctr~1_combout\ = (!\core|p_state.s_Idle~regout\ & (\core|i_ctr\(2) $ (((\core|Add0~0_combout\ & \core|i_ctr\(1))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|Add0~0_combout\,
	datab => \core|p_state.s_Idle~regout\,
	datac => \core|i_ctr\(2),
	datad => \core|i_ctr\(1),
	combout => \core|i_ctr~1_combout\);

-- Location: LCFF_X11_Y24_N13
\core|i_ctr[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|i_ctr~1_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|i_ctr\(2));

-- Location: LCCOMB_X18_Y24_N30
\core|p_state~78\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|p_state~78_combout\ = (\core|i_ctr\(0) & (\core|i_ctr\(2) & (\core|i_ctr\(1) & \core|p_state.s_Rd_E~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_ctr\(0),
	datab => \core|i_ctr\(2),
	datac => \core|i_ctr\(1),
	datad => \core|p_state.s_Rd_E~regout\,
	combout => \core|p_state~78_combout\);

-- Location: LCFF_X18_Y24_N31
\core|p_state.s_WrAck_A\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|p_state~78_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \core|p_state~83_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|p_state.s_WrAck_A~regout\);

-- Location: LCCOMB_X14_Y24_N4
\core|WideOr5~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|WideOr5~1_combout\ = (\core|WideOr5~0_combout\ & (!\core|p_state.s_WrAck_A~regout\ & (!\core|p_state.s_Stop_A~regout\ & !\core|p_state.s_WrAck_D~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|WideOr5~0_combout\,
	datab => \core|p_state.s_WrAck_A~regout\,
	datac => \core|p_state.s_Stop_A~regout\,
	datad => \core|p_state.s_WrAck_D~regout\,
	combout => \core|WideOr5~1_combout\);

-- Location: LCCOMB_X14_Y24_N0
\core|Selector1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Selector1~0_combout\ = (\core|WideOr5~3_combout\ & (!\core|WideOr5~1_combout\ & ((!\core|p_state.s_Start_A~regout\) # (!\scl_in~regout\)))) # (!\core|WideOr5~3_combout\ & (((!\core|p_state.s_Start_A~regout\)) # (!\scl_in~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|WideOr5~3_combout\,
	datab => \scl_in~regout\,
	datac => \core|WideOr5~1_combout\,
	datad => \core|p_state.s_Start_A~regout\,
	combout => \core|Selector1~0_combout\);

-- Location: LCFF_X14_Y24_N1
\core|scl_out\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|Selector1~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|scl_out~regout\);

-- Location: LCCOMB_X11_Y24_N18
\core|i_ctr~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_ctr~0_combout\ = (!\core|p_state.s_Idle~regout\ & (\core|i_ctr\(0) $ (((\core|p_state.s_Wr_E~regout\) # (\core|p_state.s_Rd_F~regout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000011110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|p_state.s_Wr_E~regout\,
	datab => \core|p_state.s_Rd_F~regout\,
	datac => \core|i_ctr\(0),
	datad => \core|p_state.s_Idle~regout\,
	combout => \core|i_ctr~0_combout\);

-- Location: LCFF_X11_Y24_N19
\core|i_ctr[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|i_ctr~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|i_ctr\(0));

-- Location: LCCOMB_X11_Y24_N14
\i_data_in[7]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_data_in[7]~0_combout\ = (!\address~combout\(1) & (!\address~combout\(0) & (\core|n_state~0_combout\ & \i_stop_reg~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \address~combout\(1),
	datab => \address~combout\(0),
	datac => \core|n_state~0_combout\,
	datad => \i_stop_reg~0_combout\,
	combout => \i_data_in[7]~0_combout\);

-- Location: LCFF_X11_Y24_N5
\i_data_in[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \writedata~combout\(3),
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \i_data_in[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_data_in(3));

-- Location: LCCOMB_X11_Y24_N4
\core|Mux0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Mux0~0_combout\ = (\core|i_ctr\(0) & (((\core|i_ctr\(1))))) # (!\core|i_ctr\(0) & ((\core|i_ctr\(1) & (i_data_in(1))) # (!\core|i_ctr\(1) & ((i_data_in(3))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => i_data_in(1),
	datab => \core|i_ctr\(0),
	datac => i_data_in(3),
	datad => \core|i_ctr\(1),
	combout => \core|Mux0~0_combout\);

-- Location: PIN_H5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\writedata[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_writedata(0),
	combout => \writedata~combout\(0));

-- Location: LCFF_X11_Y24_N31
\i_data_in[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \writedata~combout\(0),
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \i_data_in[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_data_in(0));

-- Location: LCCOMB_X11_Y24_N30
\core|Mux0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Mux0~1_combout\ = (\core|Mux0~0_combout\ & (((i_data_in(0)) # (!\core|i_ctr\(0))))) # (!\core|Mux0~0_combout\ & (i_data_in(2) & ((\core|i_ctr\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => i_data_in(2),
	datab => \core|Mux0~0_combout\,
	datac => i_data_in(0),
	datad => \core|i_ctr\(0),
	combout => \core|Mux0~1_combout\);

-- Location: LCCOMB_X18_Y24_N18
\core|WideOr1~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|WideOr1~3_combout\ = (!\core|p_state.s_Wr_C~regout\ & !\core|p_state.s_Wr_B~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \core|p_state.s_Wr_C~regout\,
	datad => \core|p_state.s_Wr_B~regout\,
	combout => \core|WideOr1~3_combout\);

-- Location: LCCOMB_X11_Y24_N24
\core|Selector0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Selector0~0_combout\ = (!\core|p_state.s_Wr_E~regout\ & (!\core|p_state.s_Wr_A~regout\ & (!\core|p_state.s_Wr_D~regout\ & \core|WideOr1~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|p_state.s_Wr_E~regout\,
	datab => \core|p_state.s_Wr_A~regout\,
	datac => \core|p_state.s_Wr_D~regout\,
	datad => \core|WideOr1~3_combout\,
	combout => \core|Selector0~0_combout\);

-- Location: LCCOMB_X11_Y24_N22
\i_data_in[4]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_data_in[4]~feeder_combout\ = \writedata~combout\(4)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \writedata~combout\(4),
	combout => \i_data_in[4]~feeder_combout\);

-- Location: LCFF_X11_Y24_N23
\i_data_in[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \i_data_in[4]~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \i_data_in[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_data_in(4));

-- Location: LCFF_X11_Y24_N1
\i_data_in[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \writedata~combout\(5),
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \i_data_in[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_data_in(5));

-- Location: LCFF_X11_Y24_N3
\i_data_in[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \writedata~combout\(6),
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \i_data_in[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_data_in(6));

-- Location: PIN_E3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\writedata[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_writedata(7),
	combout => \writedata~combout\(7));

-- Location: LCFF_X11_Y24_N29
\i_data_in[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \writedata~combout\(7),
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \i_data_in[7]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_data_in(7));

-- Location: LCCOMB_X11_Y24_N28
\core|Mux0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Mux0~2_combout\ = (\core|i_ctr\(1) & (((\core|i_ctr\(0))))) # (!\core|i_ctr\(1) & ((\core|i_ctr\(0) & (i_data_in(6))) # (!\core|i_ctr\(0) & ((i_data_in(7))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_ctr\(1),
	datab => i_data_in(6),
	datac => i_data_in(7),
	datad => \core|i_ctr\(0),
	combout => \core|Mux0~2_combout\);

-- Location: LCCOMB_X11_Y24_N0
\core|Mux0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Mux0~3_combout\ = (\core|i_ctr\(1) & ((\core|Mux0~2_combout\ & (i_data_in(4))) # (!\core|Mux0~2_combout\ & ((i_data_in(5)))))) # (!\core|i_ctr\(1) & (((\core|Mux0~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_ctr\(1),
	datab => i_data_in(4),
	datac => i_data_in(5),
	datad => \core|Mux0~2_combout\,
	combout => \core|Mux0~3_combout\);

-- Location: LCCOMB_X11_Y24_N26
\core|Selector0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Selector0~1_combout\ = (!\core|Selector0~0_combout\ & ((\core|i_ctr\(2) & (\core|Mux0~1_combout\)) # (!\core|i_ctr\(2) & ((\core|Mux0~3_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110100001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_ctr\(2),
	datab => \core|Mux0~1_combout\,
	datac => \core|Selector0~0_combout\,
	datad => \core|Mux0~3_combout\,
	combout => \core|Selector0~1_combout\);

-- Location: LCCOMB_X18_Y24_N4
\core|WideOr1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|WideOr1~0_combout\ = (!\core|p_state.s_WrAck_B~regout\ & (!\core|p_state.s_Wr_B~regout\ & (!\core|p_state.s_Wr_C~regout\ & !\core|p_state.s_WrAck_C~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|p_state.s_WrAck_B~regout\,
	datab => \core|p_state.s_Wr_B~regout\,
	datac => \core|p_state.s_Wr_C~regout\,
	datad => \core|p_state.s_WrAck_C~regout\,
	combout => \core|WideOr1~0_combout\);

-- Location: LCCOMB_X18_Y24_N2
\core|WideOr1~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|WideOr1~1_combout\ = (!\core|p_state.s_Stop_B~regout\ & (!\core|p_state.s_Stop_A~regout\ & (!\core|p_state.s_WrAck_D~regout\ & !\core|p_state.s_WrAck_A~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|p_state.s_Stop_B~regout\,
	datab => \core|p_state.s_Stop_A~regout\,
	datac => \core|p_state.s_WrAck_D~regout\,
	datad => \core|p_state.s_WrAck_A~regout\,
	combout => \core|WideOr1~1_combout\);

-- Location: LCCOMB_X14_Y24_N18
\core|WideOr1~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|WideOr1~2_combout\ = (\core|WideOr5~0_combout\ & (\core|WideOr1~0_combout\ & (!\core|p_state.s_Start_C~regout\ & \core|WideOr1~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|WideOr5~0_combout\,
	datab => \core|WideOr1~0_combout\,
	datac => \core|p_state.s_Start_C~regout\,
	datad => \core|WideOr1~1_combout\,
	combout => \core|WideOr1~2_combout\);

-- Location: LCCOMB_X25_Y24_N12
\i_ack_reg~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_ack_reg~feeder_combout\ = \writedata~combout\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \writedata~combout\(0),
	combout => \i_ack_reg~feeder_combout\);

-- Location: LCFF_X25_Y24_N13
i_ack_reg : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \i_ack_reg~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \i_write_reg~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i_ack_reg~regout\);

-- Location: LCCOMB_X11_Y24_N8
\core|Selector0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|Selector0~3_combout\ = (!\core|Selector0~1_combout\ & (!\core|WideOr1~2_combout\ & ((!\i_ack_reg~regout\) # (!\core|Selector0~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|Selector0~2_combout\,
	datab => \core|Selector0~1_combout\,
	datac => \core|WideOr1~2_combout\,
	datad => \i_ack_reg~regout\,
	combout => \core|Selector0~3_combout\);

-- Location: LCFF_X11_Y24_N9
\core|sda_out\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|Selector0~3_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|sda_out~regout\);

-- Location: LCCOMB_X29_Y24_N14
\i_clkdiv_reg[0]~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_clkdiv_reg[0]~1_combout\ = !\writedata~combout\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \writedata~combout\(0),
	combout => \i_clkdiv_reg[0]~1_combout\);

-- Location: LCFF_X29_Y24_N9
\i_clkdiv_reg[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \i_clkdiv_reg[0]~1_combout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \i_clkdiv_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_clkdiv_reg(0));

-- Location: LCCOMB_X19_Y24_N20
\readdata[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \readdata[0]~0_combout\ = (\address~combout\(0) & ((!i_clkdiv_reg(0)))) # (!\address~combout\(0) & (\core|ack_out~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|ack_out~regout\,
	datab => \address~combout\(0),
	datad => i_clkdiv_reg(0),
	combout => \readdata[0]~0_combout\);

-- Location: LCFF_X21_Y24_N1
sda_in : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \sda~0\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \sda_in~regout\);

-- Location: LCCOMB_X21_Y24_N4
\core|i_dout[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[0]~0_combout\ = (\core|Mux1~0_combout\ & ((\core|p_state.s_Rd_C~regout\ & ((\sda_in~regout\))) # (!\core|p_state.s_Rd_C~regout\ & (\core|i_dout\(0))))) # (!\core|Mux1~0_combout\ & (((\core|i_dout\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100001110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|Mux1~0_combout\,
	datab => \core|p_state.s_Rd_C~regout\,
	datac => \core|i_dout\(0),
	datad => \sda_in~regout\,
	combout => \core|i_dout[0]~0_combout\);

-- Location: LCFF_X21_Y24_N5
\core|i_dout[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|i_dout[0]~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|i_dout\(0));

-- Location: LCCOMB_X19_Y24_N16
\core|data_out[0]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|data_out[0]~feeder_combout\ = \core|i_dout\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \core|i_dout\(0),
	combout => \core|data_out[0]~feeder_combout\);

-- Location: LCFF_X19_Y24_N17
\core|data_out[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|data_out[0]~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|data_out\(0));

-- Location: PIN_C1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\read~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_read,
	combout => \read~combout\);

-- Location: LCCOMB_X19_Y24_N22
i_read_strobe : cycloneii_lcell_comb
-- Equation(s):
-- \i_read_strobe~combout\ = (\read~combout\ & \chipselect~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \read~combout\,
	datad => \chipselect~combout\,
	combout => \i_read_strobe~combout\);

-- Location: LCFF_X19_Y24_N21
\readdata[0]~reg0\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \readdata[0]~0_combout\,
	sdata => \core|data_out\(0),
	aclr => \reset~clkctrl_outclk\,
	sclr => \readdata[2]~4_combout\,
	sload => \ALT_INV_address~combout\(1),
	ena => \i_read_strobe~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \readdata[0]~reg0_regout\);

-- Location: PIN_G6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\writedata[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_writedata(1),
	combout => \writedata~combout\(1));

-- Location: LCCOMB_X29_Y24_N8
\i_clkdiv_reg[1]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_clkdiv_reg[1]~2_combout\ = !\writedata~combout\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \writedata~combout\(1),
	combout => \i_clkdiv_reg[1]~2_combout\);

-- Location: LCFF_X29_Y24_N11
\i_clkdiv_reg[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \i_clkdiv_reg[1]~2_combout\,
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \i_clkdiv_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_clkdiv_reg(1));

-- Location: LCCOMB_X19_Y24_N18
\readdata[1]~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \readdata[1]~1_combout\ = (\address~combout\(0) & ((!i_clkdiv_reg(1)))) # (!\address~combout\(0) & (\core|busy~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|busy~regout\,
	datab => \address~combout\(0),
	datad => i_clkdiv_reg(1),
	combout => \readdata[1]~1_combout\);

-- Location: LCCOMB_X20_Y24_N0
\core|i_dout[1]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[1]~2_combout\ = (!\core|i_ctr\(0) & \core|p_state.s_Rd_C~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \core|i_ctr\(0),
	datad => \core|p_state.s_Rd_C~regout\,
	combout => \core|i_dout[1]~2_combout\);

-- Location: LCCOMB_X21_Y24_N30
\core|i_dout[1]~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[1]~1_combout\ = (\core|p_state.s_Rd_C~regout\ & (!\core|i_ctr\(0) & \sda_in~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \core|p_state.s_Rd_C~regout\,
	datac => \core|i_ctr\(0),
	datad => \sda_in~regout\,
	combout => \core|i_dout[1]~1_combout\);

-- Location: LCCOMB_X20_Y24_N24
\core|i_dout[1]~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[1]~3_combout\ = (\core|Mux1~1_combout\ & ((\core|i_dout[1]~1_combout\) # ((!\core|i_dout[1]~2_combout\ & \core|i_dout\(1))))) # (!\core|Mux1~1_combout\ & (((\core|i_dout\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|Mux1~1_combout\,
	datab => \core|i_dout[1]~2_combout\,
	datac => \core|i_dout\(1),
	datad => \core|i_dout[1]~1_combout\,
	combout => \core|i_dout[1]~3_combout\);

-- Location: LCFF_X20_Y24_N25
\core|i_dout[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|i_dout[1]~3_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|i_dout\(1));

-- Location: LCCOMB_X19_Y24_N4
\core|data_out[1]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|data_out[1]~feeder_combout\ = \core|i_dout\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \core|i_dout\(1),
	combout => \core|data_out[1]~feeder_combout\);

-- Location: LCFF_X19_Y24_N5
\core|data_out[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|data_out[1]~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|data_out\(1));

-- Location: LCFF_X19_Y24_N19
\readdata[1]~reg0\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \readdata[1]~1_combout\,
	sdata => \core|data_out\(1),
	aclr => \reset~clkctrl_outclk\,
	sclr => \readdata[2]~4_combout\,
	sload => \ALT_INV_address~combout\(1),
	ena => \i_read_strobe~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \readdata[1]~reg0_regout\);

-- Location: LCCOMB_X29_Y24_N12
\i_clkdiv_reg[2]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_clkdiv_reg[2]~feeder_combout\ = \writedata~combout\(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \writedata~combout\(2),
	combout => \i_clkdiv_reg[2]~feeder_combout\);

-- Location: LCFF_X29_Y24_N13
\i_clkdiv_reg[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \i_clkdiv_reg[2]~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \i_clkdiv_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => i_clkdiv_reg(2));

-- Location: LCCOMB_X19_Y24_N26
\readdata[2]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \readdata[2]~2_combout\ = (\address~combout\(0) & ((i_clkdiv_reg(2)))) # (!\address~combout\(0) & (\i_int_pe_reg~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_int_pe_reg~regout\,
	datab => \address~combout\(0),
	datad => i_clkdiv_reg(2),
	combout => \readdata[2]~2_combout\);

-- Location: LCCOMB_X21_Y24_N14
\core|i_dout[2]~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[2]~5_combout\ = (\core|i_dout[2]~4_combout\ & ((\core|p_state.s_Rd_C~regout\ & ((\sda_in~regout\))) # (!\core|p_state.s_Rd_C~regout\ & (\core|i_dout\(2))))) # (!\core|i_dout[2]~4_combout\ & (((\core|i_dout\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100001110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_dout[2]~4_combout\,
	datab => \core|p_state.s_Rd_C~regout\,
	datac => \core|i_dout\(2),
	datad => \sda_in~regout\,
	combout => \core|i_dout[2]~5_combout\);

-- Location: LCFF_X21_Y24_N15
\core|i_dout[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|i_dout[2]~5_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|i_dout\(2));

-- Location: LCCOMB_X19_Y24_N14
\core|data_out[2]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|data_out[2]~feeder_combout\ = \core|i_dout\(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \core|i_dout\(2),
	combout => \core|data_out[2]~feeder_combout\);

-- Location: LCFF_X19_Y24_N15
\core|data_out[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|data_out[2]~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|data_out\(2));

-- Location: LCFF_X19_Y24_N27
\readdata[2]~reg0\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \readdata[2]~2_combout\,
	sdata => \core|data_out\(2),
	aclr => \reset~clkctrl_outclk\,
	sclr => \readdata[2]~4_combout\,
	sload => \ALT_INV_address~combout\(1),
	ena => \i_read_strobe~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \readdata[2]~reg0_regout\);

-- Location: LCCOMB_X19_Y24_N0
\readdata[3]~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \readdata[3]~3_combout\ = (\address~combout\(0) & (i_clkdiv_reg(3))) # (!\address~combout\(0) & ((!\core|n_state~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => i_clkdiv_reg(3),
	datab => \core|n_state~0_combout\,
	datad => \address~combout\(0),
	combout => \readdata[3]~3_combout\);

-- Location: LCCOMB_X20_Y24_N2
\core|i_dout[2]~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[2]~6_combout\ = (!\core|i_ctr\(1) & \core|i_ctr\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_ctr\(1),
	datac => \core|i_ctr\(2),
	combout => \core|i_dout[2]~6_combout\);

-- Location: LCCOMB_X20_Y24_N18
\core|i_dout[3]~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[3]~7_combout\ = (\core|i_dout[2]~6_combout\ & ((\core|i_dout[1]~1_combout\) # ((!\core|i_dout[1]~2_combout\ & \core|i_dout\(3))))) # (!\core|i_dout[2]~6_combout\ & (((\core|i_dout\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110001110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_dout[1]~2_combout\,
	datab => \core|i_dout[2]~6_combout\,
	datac => \core|i_dout\(3),
	datad => \core|i_dout[1]~1_combout\,
	combout => \core|i_dout[3]~7_combout\);

-- Location: LCFF_X20_Y24_N19
\core|i_dout[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|i_dout[3]~7_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|i_dout\(3));

-- Location: LCCOMB_X19_Y24_N8
\core|data_out[3]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|data_out[3]~feeder_combout\ = \core|i_dout\(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \core|i_dout\(3),
	combout => \core|data_out[3]~feeder_combout\);

-- Location: LCFF_X19_Y24_N9
\core|data_out[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|data_out[3]~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|data_out\(3));

-- Location: LCFF_X19_Y24_N1
\readdata[3]~reg0\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \readdata[3]~3_combout\,
	sdata => \core|data_out\(3),
	aclr => \reset~clkctrl_outclk\,
	sclr => \readdata[2]~4_combout\,
	sload => \ALT_INV_address~combout\(1),
	ena => \i_read_strobe~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \readdata[3]~reg0_regout\);

-- Location: LCCOMB_X21_Y24_N20
\core|i_dout[4]~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[4]~10_combout\ = (\core|p_state.s_Rd_C~regout\ & !\core|i_ctr\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \core|p_state.s_Rd_C~regout\,
	datad => \core|i_ctr\(2),
	combout => \core|i_dout[4]~10_combout\);

-- Location: LCCOMB_X21_Y24_N0
\core|i_dout[4]~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[4]~8_combout\ = (\core|p_state.s_Rd_C~regout\ & (\sda_in~regout\ & !\core|i_ctr\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \core|p_state.s_Rd_C~regout\,
	datac => \sda_in~regout\,
	datad => \core|i_ctr\(2),
	combout => \core|i_dout[4]~8_combout\);

-- Location: LCCOMB_X27_Y24_N2
\core|i_dout[4]~11\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[4]~11_combout\ = (\core|i_dout[4]~9_combout\ & ((\core|i_dout[4]~8_combout\) # ((!\core|i_dout[4]~10_combout\ & \core|i_dout\(4))))) # (!\core|i_dout[4]~9_combout\ & (((\core|i_dout\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_dout[4]~9_combout\,
	datab => \core|i_dout[4]~10_combout\,
	datac => \core|i_dout\(4),
	datad => \core|i_dout[4]~8_combout\,
	combout => \core|i_dout[4]~11_combout\);

-- Location: LCFF_X27_Y24_N3
\core|i_dout[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|i_dout[4]~11_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|i_dout\(4));

-- Location: LCCOMB_X27_Y24_N26
\core|data_out[4]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|data_out[4]~feeder_combout\ = \core|i_dout\(4)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \core|i_dout\(4),
	combout => \core|data_out[4]~feeder_combout\);

-- Location: LCFF_X27_Y24_N27
\core|data_out[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|data_out[4]~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|data_out\(4));

-- Location: LCCOMB_X19_Y24_N6
\Mux3~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux3~0_combout\ = (\address~combout\(1) & (((i_clkdiv_reg(4) & \address~combout\(0))))) # (!\address~combout\(1) & (\core|data_out\(4) & ((!\address~combout\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \address~combout\(1),
	datab => \core|data_out\(4),
	datac => i_clkdiv_reg(4),
	datad => \address~combout\(0),
	combout => \Mux3~0_combout\);

-- Location: LCFF_X19_Y24_N7
\readdata[4]~reg0\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \Mux3~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \i_read_strobe~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \readdata[4]~reg0_regout\);

-- Location: LCCOMB_X27_Y24_N12
\core|i_dout[5]~13\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[5]~13_combout\ = (\core|i_dout[5]~12_combout\ & ((\core|i_dout[4]~8_combout\) # ((!\core|i_dout[4]~10_combout\ & \core|i_dout\(5))))) # (!\core|i_dout[5]~12_combout\ & (((\core|i_dout\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_dout[5]~12_combout\,
	datab => \core|i_dout[4]~10_combout\,
	datac => \core|i_dout\(5),
	datad => \core|i_dout[4]~8_combout\,
	combout => \core|i_dout[5]~13_combout\);

-- Location: LCFF_X27_Y24_N13
\core|i_dout[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|i_dout[5]~13_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|i_dout\(5));

-- Location: LCCOMB_X27_Y24_N20
\core|data_out[5]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|data_out[5]~feeder_combout\ = \core|i_dout\(5)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \core|i_dout\(5),
	combout => \core|data_out[5]~feeder_combout\);

-- Location: LCFF_X27_Y24_N21
\core|data_out[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|data_out[5]~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|data_out\(5));

-- Location: LCCOMB_X19_Y24_N2
\Mux2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux2~0_combout\ = (\address~combout\(1) & (\address~combout\(0) & ((i_clkdiv_reg(5))))) # (!\address~combout\(1) & (!\address~combout\(0) & (\core|data_out\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \address~combout\(1),
	datab => \address~combout\(0),
	datac => \core|data_out\(5),
	datad => i_clkdiv_reg(5),
	combout => \Mux2~0_combout\);

-- Location: LCFF_X19_Y24_N3
\readdata[5]~reg0\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \Mux2~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \i_read_strobe~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \readdata[5]~reg0_regout\);

-- Location: LCCOMB_X27_Y24_N22
\core|i_dout[6]~15\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[6]~15_combout\ = (\core|i_dout[6]~14_combout\ & ((\core|i_dout[4]~8_combout\) # ((!\core|i_dout[4]~10_combout\ & \core|i_dout\(6))))) # (!\core|i_dout[6]~14_combout\ & (((\core|i_dout\(6)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_dout[6]~14_combout\,
	datab => \core|i_dout[4]~10_combout\,
	datac => \core|i_dout\(6),
	datad => \core|i_dout[4]~8_combout\,
	combout => \core|i_dout[6]~15_combout\);

-- Location: LCFF_X27_Y24_N23
\core|i_dout[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|i_dout[6]~15_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|i_dout\(6));

-- Location: LCCOMB_X27_Y24_N6
\core|data_out[6]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|data_out[6]~feeder_combout\ = \core|i_dout\(6)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \core|i_dout\(6),
	combout => \core|data_out[6]~feeder_combout\);

-- Location: LCFF_X27_Y24_N7
\core|data_out[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|data_out[6]~feeder_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|data_out\(6));

-- Location: LCCOMB_X19_Y24_N10
\Mux1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux1~0_combout\ = (\address~combout\(1) & (\address~combout\(0) & ((i_clkdiv_reg(6))))) # (!\address~combout\(1) & (!\address~combout\(0) & (\core|data_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \address~combout\(1),
	datab => \address~combout\(0),
	datac => \core|data_out\(6),
	datad => i_clkdiv_reg(6),
	combout => \Mux1~0_combout\);

-- Location: LCFF_X19_Y24_N11
\readdata[6]~reg0\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \Mux1~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \i_read_strobe~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \readdata[6]~reg0_regout\);

-- Location: LCCOMB_X21_Y24_N26
\core|i_dout[7]~16\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[7]~16_combout\ = (!\core|i_ctr\(1) & !\core|i_ctr\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \core|i_ctr\(1),
	datad => \core|i_ctr\(0),
	combout => \core|i_dout[7]~16_combout\);

-- Location: LCCOMB_X27_Y24_N8
\core|i_dout[7]~17\ : cycloneii_lcell_comb
-- Equation(s):
-- \core|i_dout[7]~17_combout\ = (\core|i_dout[7]~16_combout\ & ((\core|i_dout[4]~8_combout\) # ((\core|i_dout\(7) & !\core|i_dout[4]~10_combout\)))) # (!\core|i_dout[7]~16_combout\ & (((\core|i_dout\(7)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|i_dout[4]~8_combout\,
	datab => \core|i_dout[7]~16_combout\,
	datac => \core|i_dout\(7),
	datad => \core|i_dout[4]~10_combout\,
	combout => \core|i_dout[7]~17_combout\);

-- Location: LCFF_X27_Y24_N9
\core|i_dout[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \core|i_dout[7]~17_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|i_dout\(7));

-- Location: LCFF_X27_Y24_N1
\core|data_out[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \core|i_dout\(7),
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \core|data_out\(7));

-- Location: LCCOMB_X27_Y24_N16
\Mux0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux0~0_combout\ = (\address~combout\(1) & (!i_clkdiv_reg(7) & (\address~combout\(0)))) # (!\address~combout\(1) & (((!\address~combout\(0) & \core|data_out\(7)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100001101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => i_clkdiv_reg(7),
	datab => \address~combout\(1),
	datac => \address~combout\(0),
	datad => \core|data_out\(7),
	combout => \Mux0~0_combout\);

-- Location: LCFF_X27_Y24_N17
\readdata[7]~reg0\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \Mux0~0_combout\,
	aclr => \reset~clkctrl_outclk\,
	ena => \i_read_strobe~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \readdata[7]~reg0_regout\);

-- Location: LCCOMB_X15_Y24_N10
\i_int_pe_reg~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_int_pe_reg~0_combout\ = (!\address~combout\(0) & (!\address~combout\(1) & (\core|n_state~0_combout\ & \chipselect~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \address~combout\(0),
	datab => \address~combout\(1),
	datac => \core|n_state~0_combout\,
	datad => \chipselect~combout\,
	combout => \i_int_pe_reg~0_combout\);

-- Location: LCCOMB_X15_Y24_N8
\i_int_pe_reg~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \i_int_pe_reg~1_combout\ = (\i_int_pe_reg~0_combout\ & (((!\core|n_state~0_combout\)))) # (!\i_int_pe_reg~0_combout\ & ((\i_int_pe_reg~regout\) # ((\core|cmd_done~regout\ & !\core|n_state~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \core|cmd_done~regout\,
	datab => \core|n_state~0_combout\,
	datac => \i_int_pe_reg~regout\,
	datad => \i_int_pe_reg~0_combout\,
	combout => \i_int_pe_reg~1_combout\);

-- Location: LCFF_X15_Y24_N9
i_int_pe_reg : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \i_int_pe_reg~1_combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i_int_pe_reg~regout\);

-- Location: LCFF_X25_Y24_N3
i_int_en_reg : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	sdata => \writedata~combout\(5),
	aclr => \reset~clkctrl_outclk\,
	sload => VCC,
	ena => \i_write_reg~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \i_int_en_reg~regout\);

-- Location: LCCOMB_X25_Y24_N0
i_irq : cycloneii_lcell_comb
-- Equation(s):
-- \i_irq~combout\ = (\i_int_pe_reg~regout\ & \i_int_en_reg~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \i_int_pe_reg~regout\,
	datad => \i_int_en_reg~regout\,
	combout => \i_irq~combout\);

-- Location: LCFF_X25_Y24_N1
\irq~reg0\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \i_irq~combout\,
	aclr => \reset~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \irq~reg0_regout\);

-- Location: PIN_D1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\scl~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "bidir",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \core|ALT_INV_scl_out~regout\,
	oe => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	padio => scl);

-- Location: PIN_AB12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \readdata[0]~reg0_regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(0));

-- Location: PIN_C19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \readdata[1]~reg0_regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(1));

-- Location: PIN_F3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \readdata[2]~reg0_regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(2));

-- Location: PIN_D3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \readdata[3]~reg0_regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(3));

-- Location: PIN_E4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \readdata[4]~reg0_regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(4));

-- Location: PIN_D4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \readdata[5]~reg0_regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(5));

-- Location: PIN_B11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \readdata[6]~reg0_regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(6));

-- Location: PIN_D6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\readdata[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \readdata[7]~reg0_regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_readdata(7));

-- Location: PIN_U13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\irq~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \irq~reg0_regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_irq);
END structure;


