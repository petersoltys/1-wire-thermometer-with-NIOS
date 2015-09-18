onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /i2c_interface/clk
add wave -noupdate /i2c_interface/reset
add wave -noupdate /i2c_interface/address
add wave -noupdate /i2c_interface/chipselect
add wave -noupdate /i2c_interface/read
add wave -noupdate -radix hexadecimal /i2c_interface/readdata
add wave -noupdate /i2c_interface/write
add wave -noupdate -radix hexadecimal /i2c_interface/writedata
add wave -noupdate /i2c_interface/irq
add wave -noupdate /i2c_interface/sda
add wave -noupdate /i2c_interface/sda_in
add wave -noupdate /i2c_interface/sda_out
add wave -noupdate /i2c_interface/scl
add wave -noupdate /i2c_interface/scl_in
add wave -noupdate /i2c_interface/i_scl_out
add wave -noupdate /i2c_interface/scl_out
add wave -noupdate /i2c_interface/i_sclk
add wave -noupdate -radix hexadecimal /i2c_interface/i_clkdiv_reg
add wave -noupdate -divider {Status Reg bits}
add wave -noupdate /i2c_interface/i_lar_reg
add wave -noupdate /i2c_interface/i_busy_reg
add wave -noupdate /i2c_interface/i_int_pe_reg
add wave -noupdate /i2c_interface/i_tip_reg
add wave -noupdate -divider {Ctrl Reg bits}
add wave -noupdate /i2c_interface/i_ack_reg
add wave -noupdate /i2c_interface/i_stop_reg
add wave -noupdate /i2c_interface/i_start_reg
add wave -noupdate /i2c_interface/i_read_reg
add wave -noupdate /i2c_interface/i_write_reg
add wave -noupdate /i2c_interface/i_int_en_reg
add wave -noupdate /i2c_interface/i_cmd_done
add wave -noupdate /i2c_interface/i_cmd_done_ack
add wave -noupdate -divider {Data Reg}
add wave -noupdate -radix hexadecimal /i2c_interface/i_data_in
add wave -noupdate -radix hexadecimal /i2c_interface/i_data_out
add wave -noupdate /i2c_interface/i_int_clr
add wave -noupdate /i2c_interface/i_irq
add wave -noupdate -radix hexadecimal /i2c_interface/i_readdata
add wave -noupdate /i2c_interface/i_read_strobe
add wave -noupdate /i2c_interface/i_write_strobe
add wave -noupdate -divider ClkGen
add wave -noupdate /i2c_interface/clkgen/clk
add wave -noupdate /i2c_interface/clkgen/rst
add wave -noupdate -radix hexadecimal /i2c_interface/clkgen/clk_cnt
add wave -noupdate -radix hexadecimal /i2c_interface/clkgen/clk_ctr
add wave -noupdate /i2c_interface/clkgen/sclk
add wave -noupdate /i2c_interface/clkgen/i_clk_out
add wave -noupdate /i2c_interface/clkgen/clk_wait
add wave -noupdate /i2c_interface/clkgen/scl_in
add wave -noupdate /i2c_interface/clkgen/scl_out
add wave -noupdate -divider Core
add wave -noupdate /i2c_interface/core/ack_in
add wave -noupdate /i2c_interface/core/ack_out
add wave -noupdate /i2c_interface/core/busy
add wave -noupdate /i2c_interface/core/clk
add wave -noupdate /i2c_interface/core/cmd_done
add wave -noupdate /i2c_interface/core/cmd_done_ack
add wave -noupdate /i2c_interface/core/cmd_read
add wave -noupdate /i2c_interface/core/cmd_start
add wave -noupdate /i2c_interface/core/cmd_stop
add wave -noupdate /i2c_interface/core/cmd_write
add wave -noupdate -radix hexadecimal /i2c_interface/core/data_in
add wave -noupdate -radix hexadecimal /i2c_interface/core/data_out
add wave -noupdate /i2c_interface/core/i_ack_out
add wave -noupdate /i2c_interface/core/i_ack_out_ld
add wave -noupdate /i2c_interface/core/i_busy
add wave -noupdate /i2c_interface/core/i_cmd_done
add wave -noupdate /i2c_interface/core/i_cmd_go
add wave -noupdate /i2c_interface/core/i_ctr
add wave -noupdate /i2c_interface/core/i_ctr_clr
add wave -noupdate /i2c_interface/core/i_ctr_incr
add wave -noupdate /i2c_interface/core/i_data_in
add wave -noupdate /i2c_interface/core/i_dout
add wave -noupdate /i2c_interface/core/i_dout_ld
add wave -noupdate /i2c_interface/core/i_scl_out
add wave -noupdate /i2c_interface/core/i_sclk_en
add wave -noupdate /i2c_interface/core/i_sda_out
add wave -noupdate /i2c_interface/core/n_state
add wave -noupdate /i2c_interface/core/p_state
add wave -noupdate /i2c_interface/core/rst
add wave -noupdate /i2c_interface/core/scl_in
add wave -noupdate /i2c_interface/core/scl_out
add wave -noupdate /i2c_interface/core/sclk
add wave -noupdate /i2c_interface/core/sda_in
add wave -noupdate /i2c_interface/core/sda_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {125000 ps} 0}
configure wave -namecolwidth 212
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {79590 ps} {238779 ps}
