module forwardingunit (
	input  logic [4:0] rdM           ,
	input  logic [4:0] rdW           ,
	input  logic [4:0] rs1           ,
	input  logic [4:0] rs2           ,
	input  logic       RegWriteM     ,
	input  logic       RegWriteW     ,
	output logic [1:0] forword_path_A,
	output logic [1:0] forword_path_B
);

	always_comb begin
		if ((rdM == rs1) & !(rdM == 5'b00000) & RegWriteM)
			forword_path_A = 2'b01;
		else 	if ((rdW == rs1) & !(rdW == 5'b00000) & RegWriteW)
			forword_path_A = 2'b10;
		else
			forword_path_A = 2'b00;
	end

	always_comb begin
		if ((rdM == rs2) & !(rdM == 5'b00000) & RegWriteM)
			forword_path_B = 2'b01;
		else 	if ((rdW == rs2) & !(rdW == 5'b00000) & RegWriteW)
			forword_path_B = 2'b10;
		else
			forword_path_B = 2'b00;
	end

endmodule
