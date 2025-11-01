`timescale 1ns/1ps
module tb_processor_5_stage ();

	logic clk   = 0;
	logic reset = 1;
	
	processor_5_stage processor_5_stage (
		.clk  (clk  ),
		.reset(reset)
	);

	always #5 clk <= ~clk;

initial begin
	repeat(20) @(posedge clk);
	reset = 0;
	repeat(70) @(posedge clk);
	$stop;
end

endmodule