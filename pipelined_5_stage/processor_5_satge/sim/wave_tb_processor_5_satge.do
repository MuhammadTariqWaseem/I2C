onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/clk
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/reset
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/PC
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/InstrD
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ImmExt
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ALUResultE
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ALUResultM
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/WriteDataW
add wave -noupdate -divider {All Internal Signals}
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/clk
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/reset
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/PCPlus4
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/PCPlus41
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/PCTargetE
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/PCNext
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/PCNext1
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/Instr
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/InstrX
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/PCSrc
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/InstrL
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/InstrK
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/InstrY
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/PCD
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/PCPlus4D
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/RD1
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/RD2
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/WriteAddW
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ALUControl
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ResultSrc
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ImmSrc
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/Branch
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/MemWrite
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ALUSrc
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/RegWrite
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/Jump
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/RegWriteW
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/SS1
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/SS2
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/RD1E
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/RD2E
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/PCE
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ImmExtE
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/PCPlus4E
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/SrcE
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/A32
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/B32
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/WriteAddE
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/rs1
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/rs2
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/IS1
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/IS2
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ALUControlE
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/funct3
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ResultSrcE
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/forword_path_A
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/forword_path_B
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/RegWriteE
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/MemWriteE
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/JumpE
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/BranchE
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ALUSrcE
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/Zero
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/RD2M
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/PCPlus4M
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ReadDataM
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/WriteAddM
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ResultSrcM
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/RegWriteM
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/MemWriteM
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/SS11
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ReadDataW
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ALUResultW
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/PCPlus4W
add wave -noupdate -radix hexadecimal /tb_processor_5_stage/processor_5_stage/ResultSrcW
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {160619 ps} {311964 ps}
