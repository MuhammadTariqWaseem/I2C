module hazardunit (
	input  logic       ResultSrcE,
	input  logic       PCSrc    ,
	input  logic [4:0] WriteAddE,
	input  logic [4:0] rs1      ,
	input  logic [4:0] rs2      ,
	output logic       SS1      ,
	output logic       SS2
);

	always_comb begin
		if(((WriteAddE == rs1) | (WriteAddE == rs2)) & ResultSrcE)
			SS2 = 1'b0;
		else
			SS2 = 1'b1;


		if (PCSrc)
			SS2 = 1'b1;
	end

	always_comb begin
		if(((WriteAddE == rs1) | (WriteAddE == rs2)) & ResultSrcE)
			SS1 = 1'b0;
		else
			SS1 = 1'b1;
	end

endmodule
