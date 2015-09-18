restart
force -freeze sim:/i2c_interface/clk 1 0, 0 {10000 ps} -r 20ns
force -freeze sim:/i2c_interface/reset 0 0
run 25 ns
force -freeze sim:/i2c_interface/chipselect 0 0
force -freeze sim:/i2c_interface/read 0 0
force -freeze sim:/i2c_interface/write 0 0
force -freeze sim:/i2c_interface/reset 1 0
run 50 ns
force -freeze sim:/i2c_interface/reset 0 0
run 50 ns
force -freeze sim:/i2c_interface/i_clkdiv_reg 00000110 0
-- run 200 ns
-- force -deposit sim:/i2c_interface/scl H 0
force -deposit sim:/i2c_interface/sda H 0
run 200 ns
-- write data 
force -freeze sim:/i2c_interface/address 00 0
force -freeze sim:/i2c_interface/chipselect 1 0
force -freeze sim:/i2c_interface/write 1 0
force -freeze sim:/i2c_interface/writedata 11001110 0
run 20 ns
force -freeze sim:/i2c_interface/chipselect 0 0
force -freeze sim:/i2c_interface/write 0 0
force -freeze sim:/i2c_interface/writedata 00000000 0
run 20 ns
-- start a Write access 
force -freeze sim:/i2c_interface/address 01 0
force -freeze sim:/i2c_interface/chipselect 1 0
force -freeze sim:/i2c_interface/write 1 0
force -freeze sim:/i2c_interface/writedata 00110111 0
run 20 ns
force -freeze sim:/i2c_interface/chipselect 0 0
force -freeze sim:/i2c_interface/write 0 0
force -freeze sim:/i2c_interface/writedata 00000000 0
run 20 ns
-- read status register
force -freeze sim:/i2c_interface/address 10 0
force -freeze sim:/i2c_interface/chipselect 1 0
force -freeze sim:/i2c_interface/read 1 0
run 40 ns
force -freeze sim:/i2c_interface/chipselect 0 0
force -freeze sim:/i2c_interface/read 0 0
run 20 ns
force -freeze sim:/i2c_interface/address 10 0
force -freeze sim:/i2c_interface/chipselect 1 0
force -freeze sim:/i2c_interface/read 1 0
run 40 ns
force -freeze sim:/i2c_interface/chipselect 0 0
force -freeze sim:/i2c_interface/read 0 0
run 20 ns
force -freeze sim:/i2c_interface/address 10 0
force -freeze sim:/i2c_interface/chipselect 1 0
force -freeze sim:/i2c_interface/read 1 0
run 40 ns
force -freeze sim:/i2c_interface/chipselect 0 0
force -freeze sim:/i2c_interface/read 0 0
run 20 ns
force -freeze sim:/i2c_interface/address 10 0
force -freeze sim:/i2c_interface/chipselect 1 0
force -freeze sim:/i2c_interface/read 1 0
run 40 ns
force -freeze sim:/i2c_interface/chipselect 0 0
force -freeze sim:/i2c_interface/read 0 0
run 20 ns
force -freeze sim:/i2c_interface/address 10 0
force -freeze sim:/i2c_interface/chipselect 1 0
force -freeze sim:/i2c_interface/read 1 0
run 40 ns
force -freeze sim:/i2c_interface/chipselect 0 0
force -freeze sim:/i2c_interface/read 0 0
run 20 ns
force -freeze sim:/i2c_interface/address 10 0
force -freeze sim:/i2c_interface/chipselect 1 0
force -freeze sim:/i2c_interface/read 1 0
run 40 ns
force -freeze sim:/i2c_interface/chipselect 0 0
force -freeze sim:/i2c_interface/read 0 0
run 20 ns
force -freeze sim:/i2c_interface/address 10 0
force -freeze sim:/i2c_interface/chipselect 1 0
force -freeze sim:/i2c_interface/read 1 0
run 40 ns
force -freeze sim:/i2c_interface/chipselect 0 0
force -freeze sim:/i2c_interface/read 0 0
run 20 ns
force -freeze sim:/i2c_interface/address 10 0
force -freeze sim:/i2c_interface/chipselect 1 0
force -freeze sim:/i2c_interface/read 1 0
run 40 ns
force -freeze sim:/i2c_interface/chipselect 0 0
force -freeze sim:/i2c_interface/read 0 0
run 20 ns
force -freeze sim:/i2c_interface/address 10 0
force -freeze sim:/i2c_interface/chipselect 1 0
force -freeze sim:/i2c_interface/read 1 0
run 40 ns
force -freeze sim:/i2c_interface/chipselect 0 0
force -freeze sim:/i2c_interface/read 0 0
run 20 ns
force -freeze sim:/i2c_interface/address 10 0
force -freeze sim:/i2c_interface/chipselect 1 0
force -freeze sim:/i2c_interface/read 1 0
run 40 ns
force -freeze sim:/i2c_interface/chipselect 0 0
force -freeze sim:/i2c_interface/read 0 0
run 20 ns

run 5000 ns
force -freeze sim:/i2c_interface/address 10 0
force -freeze sim:/i2c_interface/chipselect 1 0
force -freeze sim:/i2c_interface/read 1 0
run 40 ns
force -freeze sim:/i2c_interface/chipselect 0 0
force -freeze sim:/i2c_interface/read 0 0
run 20 ns
run 1000 ns
