onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_I2C_top/clk
add wave -noupdate -radix hexadecimal /tb_I2C_top/reset
add wave -noupdate -radix hexadecimal /tb_I2C_top/en
add wave -noupdate -radix hexadecimal /tb_I2C_top/read_write
add wave -noupdate -radix hexadecimal /tb_I2C_top/data_in
add wave -noupdate -radix hexadecimal /tb_I2C_top/data_in_s
add wave -noupdate -radix hexadecimal /tb_I2C_top/slave_addr
add wave -noupdate -radix hexadecimal /tb_I2C_top/data_out
add wave -noupdate -radix hexadecimal /tb_I2C_top/data_out_s
add wave -noupdate -radix hexadecimal /tb_I2C_top/busy
add wave -noupdate -radix hexadecimal /tb_I2C_top/ack_error
add wave -noupdate -divider Master
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/scl
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/sda
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/data_out_store
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/slave_addr_reg
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/sda_out
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/count_fsm
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/current_state
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/next_state
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/gen_clk
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/count
add wave -noupdate -divider Slave
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave/scl
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave/sda
add wave -noupdate /tb_I2C_top/i_I2C_top/I2C_slave/sda_d
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave/slave_addr
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave/count_fsm
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave/data_out_pre
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave/current_state
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave/next_state
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave/read_write
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave/sda_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9195 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {8586 ps} {8830 ps}
