onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_I2C_master/clk
add wave -noupdate -radix hexadecimal /tb_I2C_master/reset
add wave -noupdate -radix hexadecimal /tb_I2C_master/en
add wave -noupdate -radix hexadecimal /tb_I2C_master/read_write
add wave -noupdate -radix hexadecimal /tb_I2C_master/data_in
add wave -noupdate -radix hexadecimal /tb_I2C_master/slave_addr
add wave -noupdate -radix hexadecimal /tb_I2C_master/scl
add wave -noupdate -radix hexadecimal /tb_I2C_master/sda
add wave -noupdate -radix hexadecimal /tb_I2C_master/busy
add wave -noupdate -radix hexadecimal /tb_I2C_master/ack_error
add wave -noupdate -radix hexadecimal /tb_I2C_master/data_out
add wave -noupdate -radix hexadecimal /tb_I2C_master/sda_out
add wave -noupdate -divider master
add wave -noupdate /tb_I2C_master/i_I2C_master/scl
add wave -noupdate /tb_I2C_master/i_I2C_master/sda
add wave -noupdate -radix hexadecimal /tb_I2C_master/i_I2C_master/en_reg
add wave -noupdate /tb_I2C_master/i_I2C_master/data_out_store
add wave -noupdate -radix hexadecimal /tb_I2C_master/i_I2C_master/read_write_reg
add wave -noupdate -radix hexadecimal /tb_I2C_master/i_I2C_master/data_in_reg
add wave -noupdate -radix hexadecimal /tb_I2C_master/i_I2C_master/slave_addr_reg
add wave -noupdate -radix hexadecimal /tb_I2C_master/i_I2C_master/sda_out
add wave -noupdate -radix hexadecimal /tb_I2C_master/i_I2C_master/count_fsm
add wave -noupdate -radix hexadecimal /tb_I2C_master/i_I2C_master/req_count
add wave -noupdate -radix hexadecimal /tb_I2C_master/i_I2C_master/current_state
add wave -noupdate -radix hexadecimal /tb_I2C_master/i_I2C_master/next_state
add wave -noupdate -radix hexadecimal /tb_I2C_master/i_I2C_master/gen_clk
add wave -noupdate -radix hexadecimal /tb_I2C_master/i_I2C_master/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6406 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1255 ps}
