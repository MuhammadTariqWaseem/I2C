vdel -lib work -all
vlib work
vlog -sv tb_I2C_master.sv ../rtl/I2C_master.sv 
vsim -novopt tb_I2C_master
# add wave *
do wave_tb_I2C_master.do
run -a