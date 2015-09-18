transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {E:/Users/Rene/Enseignement/rb-laboratories/trunk/QuartusOwnLib/Avalon_i2c/Tst_i2c/i2c_interface.vhd}
vcom -93 -work work {E:/Users/Rene/Enseignement/rb-laboratories/trunk/QuartusOwnLib/Avalon_i2c/Tst_i2c/i2c_core.vhd}
vcom -93 -work work {E:/Users/Rene/Enseignement/rb-laboratories/trunk/QuartusOwnLib/Avalon_i2c/Tst_i2c/i2c_clkgen.vhd}

