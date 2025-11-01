module processor_to_I2C (
	//processor connection
	input  logic [31:0] memAdd      ,
	input  logic        memwrite    ,
	input  logic [31:0] writedata   ,
	input  logic [ 1:0] RSrc        ,
	output logic        datamemwrite,
	output logic [31:0] RD          ,
	//I2C module connection
	input  logic        busy        ,
	input  logic        ackerror    ,
	output logic        enable      ,
	output logic        RW          ,
	output logic        clks        ,
	output logic [ 7:0] data_in     ,
	output logic [ 6:0] slaveAdd    ,
	input  logic [ 7:0] data_out    
);

	logic [7:0] readdata;

	always_comb begin
		if((memAdd == 32'd7756) && memwrite) begin
			datamemwrite = 1'b0           ;
			enable       = 1'b1           ;
			slaveAdd     = writedata[14:8];
			data_in[7:0] = writedata[ 7:0];
			RW           = 1'b0           ;
		end

	always_comb begin
		if(memAdd == 32'd7756) begin
			datamemwrite = 1'b0;
			if (memwrite == 1'b1) begin
				enable       = 1'b1           ;
				slaveAdd     = writedata[14:8];
				data_in[7:0] = writedata[ 7:0];
				RW           = 1'b0           ;
			end
			if (RSrc == 2'b01) begin
				enable = 1'b1;
				if
					slaveAdd <= 7'b0110110;
				RW            = 1'b1;
				readdata[7:0] = data_out[7:0];
				RD            = {24'h000000,data_out[7:0]};
			end
		end
		else begin
			datamemwrite = 1'b1;
			enable       = 1'b0;
			RD           = 32'hFFFFFFFF;
		end
	end

	always_comb begin
		if(~busy | ~ackerror) 
			clks = 1'b0;
		else 
			clks = 1'b1;
	end

endmodule
