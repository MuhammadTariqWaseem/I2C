module register_up (
	input  logic        clk         , // Clock
	input  logic        reset       , // reset 
	input  logic        write_enable, // Reset
	input  logic [ 4:0] read_addr1  , // Read address 1
	input  logic [ 4:0] read_addr2  ,
	input  logic [ 4:0] write_addr  , // Write address
	input  logic [31:0] write_data  , // Read address 2
	output logic [31:0] read_data1  , // Read data 1
	output logic [31:0] read_data2    // Read data 2
);

  logic [31:0] register[31:0];
  logic [31:0] reg_temp[31:0];

  always@(negedge clk) begin
		read_data1 <= (read_addr1 == 5'b00000)? 32'b0 : register[read_addr1] ;
	  read_data2 <= (read_addr2 == 5'b00000)? 32'b0 : register[read_addr2] ;
  end

  always@(posedge clk) begin
		for (int i = 0; i < 32; i=i+1) begin
			reg_temp[i] <= register[i];
  	end
  end

  always@(*) begin
		for (int i = 0; i < 32; i=i+1) begin
	  	if (reset) begin
	  			register[i] = 0; 
	  	end
	  	else if(write_enable && (write_addr != 5'b00000) && (i == write_addr)) begin
		    register[i] = write_data;
	  	end
	  	else begin
  			register[i] = reg_temp[i]; 
	  	end
	  end 
  end

endmodule
