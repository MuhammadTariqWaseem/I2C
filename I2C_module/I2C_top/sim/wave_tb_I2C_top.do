onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_I2C_top/clk
add wave -noupdate -radix hexadecimal /tb_I2C_top/reset
add wave -noupdate -radix hexadecimal /tb_I2C_top/en
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/no_of_bytes
add wave -noupdate -radix hexadecimal /tb_I2C_top/read_write
add wave -noupdate -radix hexadecimal /tb_I2C_top/data_in
add wave -noupdate -radix hexadecimal /tb_I2C_top/data_in_1
add wave -noupdate -radix hexadecimal /tb_I2C_top/data_in_2
add wave -noupdate -radix hexadecimal /tb_I2C_top/data_in_3
add wave -noupdate -radix hexadecimal /tb_I2C_top/data_in_4
add wave -noupdate -radix hexadecimal /tb_I2C_top/slave_addr
add wave -noupdate -radix hexadecimal /tb_I2C_top/data_out_1
add wave -noupdate -radix hexadecimal /tb_I2C_top/data_out_2
add wave -noupdate -radix hexadecimal /tb_I2C_top/data_out_3
add wave -noupdate -radix hexadecimal /tb_I2C_top/data_out_4
add wave -noupdate -radix hexadecimal /tb_I2C_top/data_out
add wave -noupdate -radix hexadecimal /tb_I2C_top/busy
add wave -noupdate -radix hexadecimal /tb_I2C_top/ack_error
add wave -noupdate -divider Master
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/sda
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/scl
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/rem_bytes
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/data_out_store
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/slave_addr_reg
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/sda_out
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/count_fsm
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/current_state
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/next_state
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/gen_clk
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_master/count
add wave -noupdate -divider {Slave 1}
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_54/scl
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_54/sda
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_54/slave_addr
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_54/count_fsm
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_54/data_out_pre
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_54/current_state
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_54/next_state
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_54/read_write
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_54/sda_out
add wave -noupdate -divider {Slave 2}
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_56/scl
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_56/sda
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_56/slave_addr
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_56/count_fsm
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_56/data_out_pre
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_56/current_state
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_56/next_state
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_56/read_write
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_56/sda_out
add wave -noupdate -divider {Slave 3}
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_57/scl
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_57/sda
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_57/slave_addr
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_57/count_fsm
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_57/data_out_pre
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_57/current_state
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_57/next_state
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_57/read_write
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_57/sda_out
add wave -noupdate -divider {Slave 4}
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_58/scl
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_58/sda
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_58/slave_addr
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_58/count_fsm
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_58/data_out_pre
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_58/current_state
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_58/next_state
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_58/read_write
add wave -noupdate -radix hexadecimal /tb_I2C_top/i_I2C_top/I2C_slave_58/sda_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4454 ps} 0}
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
WaveRestoreZoom {0 ps} {1134 ps}
