vdel -lib work -all
vlib work
vlog -sv tb_I2C_top.sv ../rtl/I2C_top.sv
vlog -sv ../../master/rtl/I2C_master.sv  ../../slave/rtl/I2C_slave.sv 
vsim -novopt tb_I2C_top
# add wave *
do wave_tb_I2C_top.do
run -a