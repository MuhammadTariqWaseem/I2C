module I2C_master #(
	parameter inclk = 100, // unit Mhz
	parameter sclk  = 100  // unit KHz
) (
	input  logic       clk        , // System clock
	input  logic       reset      , // Reset signal
	// Control and data from interconnect module
	input  logic      [9:0] no_of_bytes,
	input  logic            en         , // Start condition from the processor
	input  logic            read_write , // Read/Write command: 1 for read, 0 for write
	input  logic [9:0][7:0] data_in    , // Data to be sent to the slave from Processor
	input  logic      [6:0] slave_addr , // 7-bit slave address
	output logic [9:0][7:0] data_out   , // Data read from slave
	output logic            busy       , // Busy flag
	output logic            ack_error  , // Acknowledge error flag
	// I2C lines     
	output logic            scl        , // I2C clock line
	inout  logic            sda          // I2C data line (bidirectional)
);

	localparam  IDLE     = 4'h0;  
	localparam  START    = 4'h1;      
	localparam  ADDRESS  = 4'h2;      
	localparam  R_W      = 4'h3;      
	localparam  CLK_SY_A = 4'h4;      
	localparam  READ     = 4'h5;      
	localparam  WRITE    = 4'h6;              
	localparam  CLK_SY_W = 4'h7;
	localparam  CLK_SY_R = 4'h8;      
	localparam  STOP     = 4'h9;      

  logic             gen_clk_d     ;
	logic             en_reg        ;
	logic             read_write_reg;
	logic [9:0][ 7:0] data_in_reg   ;
	logic [9:0][ 7:0] data_out_store;
	logic      [ 6:0] slave_addr_reg;
	logic             sda_out       ;
	logic      [ 3:0] count_fsm     ;
	logic      [15:0] req_count     ;
	logic             sda_in        ;
  logic      [ 3:0] current_state ;
  logic      [ 3:0] next_state    ; 
	logic             gen_clk       ;
	logic      [15:0] count         ;
	logic      [ 9:0] rem_bytes     ;
	logic      [ 9:0] total_bytes   ;

  always_ff @(posedge clk) begin
  	if(reset) begin
  		total_bytes <= 0;
  		rem_bytes <= 0;
  	end
  	else if(en & busy) begin
  		total_bytes <= no_of_bytes;
      rem_bytes <= no_of_bytes;
  	end
  	else if((current_state == CLK_SY_W | current_state == CLK_SY_R) && (~gen_clk_d & gen_clk))
  		rem_bytes <= rem_bytes - 1;
  end

	assign req_count = (inclk*1000)/(sclk<<1);
  assign sda = (reset)? 1'bz : ((sda_out)? 1'bz : 1'b0);

  always_comb begin
    if(sda == 0)
      sda_in = 0;
    else 
      sda_in = 1;
  end
  
// Generating a slow clock of the defined parameter

  always_ff @(posedge clk) begin
  	if(reset) 
  		gen_clk <= 0;
  	else if(count == (req_count-1))
  		gen_clk <= ~gen_clk;
  end

  always_ff @(posedge clk) begin
  	if(reset) 
  		gen_clk_d <= 0;
  	else 
  		gen_clk_d <= gen_clk;
  end

	always_ff @(posedge clk) begin 
		if(reset) 
			count <= 0;
  	else if(count == (req_count-1))
		  count <= 0;
	  else 
			count <= count + 1;
	end

  always_ff @(posedge clk) begin 
  	if(reset) begin
  		en_reg         <= 0;
  		read_write_reg <= 0;
  		slave_addr_reg <= 0;
  		data_in_reg    <= 0;
  	end 
  	else if(en && busy) begin
			en_reg         <= en        ;
			read_write_reg <= read_write;
			slave_addr_reg <= slave_addr;
			data_in_reg    <= data_in   ;
  	end
  	else if (current_state != IDLE) begin
  		en_reg         <= 0             ;
			read_write_reg <= read_write_reg;
			slave_addr_reg <= slave_addr_reg;
			data_in_reg    <= data_in_reg   ;	
  	end
  end	           

  always_ff @(posedge clk) begin
  	if(reset) 
  		count_fsm <= 0;
    else if(gen_clk_d && ~gen_clk) begin
	  	if(current_state == ADDRESS)
	      count_fsm <= count_fsm + 1;
	  	else if(current_state == READ)
	      count_fsm <= count_fsm + 1;
	  	else if(current_state == WRITE)
	      count_fsm <= count_fsm + 1;
	  	else 
	  		count_fsm <= 0;
    end
  end

	always_comb begin
		case (current_state)
	    IDLE    : if(en_reg)                      next_state = START   ; 
	              else                            next_state = IDLE    ;	
	    START   :                                 next_state = ADDRESS ;
	    ADDRESS : if(count_fsm == 6)              next_state = R_W     ;
	              else                            next_state = ADDRESS ;	
	    R_W     :                                 next_state = CLK_SY_A;
	    CLK_SY_A: if(~sda_in && read_write)       next_state = READ    ;
	              else if(~sda_in && ~read_write) next_state = WRITE   ;
	              else                            next_state = STOP    ;
	    READ    : if(count_fsm == 7)              next_state = CLK_SY_R;
	              else                            next_state = READ    ;	
	    WRITE   : if(count_fsm == 7)              next_state = CLK_SY_W;
	              else                            next_state = WRITE   ;
      CLK_SY_W: if (~sda_in && rem_bytes != 0)  next_state = WRITE   ;    
                else                            next_state = STOP    ;
      CLK_SY_R: if (rem_bytes == 0)             next_state = STOP    ;
                else                            next_state = READ    ;
      STOP    :                                 next_state = IDLE    ; 
			default :                                 next_state = IDLE    ;
		endcase
	end

	always_ff @(posedge clk) begin 
		if(reset) 
			data_out <= 0;
		else if(count_fsm == 8)
		  data_out <= data_out_store;
	end

  always_ff @(posedge clk) begin
  	if(reset)
  		data_out_store <= 0;
  	else if(~gen_clk_d && gen_clk) begin
	  	if((current_state == READ) && !sda_in)
				data_out_store[total_bytes - rem_bytes][7-count_fsm] <= 0;
			else 
				data_out_store[total_bytes - rem_bytes][7-count_fsm] <= 1;
  	end
  end

  always_ff @(posedge clk) begin
  	if(reset) begin
  		current_state <= 0         ;
  	end 
  	else if(gen_clk_d && ~gen_clk) begin
  		current_state <= next_state;
  	end
  end

  always_comb begin 
		case (current_state)
	  	IDLE    :  scl = 1'b1     ;
	    START   :  scl = 1'b1     ;
	    ADDRESS :  scl = gen_clk_d;
	    R_W     :  scl = gen_clk_d;
	    CLK_SY_A:  scl = gen_clk_d;
	    READ    :  scl = gen_clk_d;
	    WRITE   :  scl = gen_clk_d;
	    CLK_SY_W:  scl = gen_clk_d;
	    CLK_SY_R:  scl = gen_clk_d;
	    STOP    :  scl = 1'b1     ;
	    default :  scl = 1'b1     ;
    endcase
  end

	always_comb begin
		case (current_state)
	  	IDLE    : busy = 1'b1;
	    START   : busy = 1'b0;
	    ADDRESS : busy = 1'b0;
	    R_W     : busy = 1'b0;
	    CLK_SY_A: busy = 1'b0;
	    READ    : busy = 1'b0;
	    WRITE   : busy = 1'b0;
	    CLK_SY_W: busy = 1'b0;
	    CLK_SY_R: busy = 1'b0;
	    STOP    : busy = 1'b0;
	    default : busy = 1'b1;
	  endcase
  end

	always_ff @(posedge clk) begin
    if(~gen_clk_d && gen_clk)
			case (current_state)
		    CLK_SY_A: if(~sda_in) ack_error <= 1'b0;
		              else     ack_error <= 1'b1;
		    CLK_SY_W: if(~sda_in) ack_error <= 1'b0;
		              else     ack_error <= 1'b1;
		    default : ack_error          <= 1'b0;
		  endcase
  end

	always_comb begin
		case (current_state)
	    IDLE    : sda_out = 1'b1                              ;
			START   : sda_out = 1'b0                              ;
			ADDRESS : sda_out = slave_addr_reg[6-count_fsm]       ;
			R_W     : sda_out = read_write_reg                    ;
			CLK_SY_A: sda_out = 1'b1                              ;
			READ    : sda_out = 1'b1                              ;
			WRITE   : sda_out = data_in[rem_bytes-1][7-count_fsm] ;
			CLK_SY_W: if(~sda_in && rem_bytes != 0) sda_out = 1'b0;
			          else                          sda_out = 1'b1;
			CLK_SY_R: sda_out = 1'b0                              ;
			STOP    : sda_out = 1'b1                              ;
			default : sda_out = 1'b1                              ;
		endcase
	end

endmodule




// module I2C_master #(
//   parameter inclk = 100,  // unit Mhz
//   parameter sclk  = 100   // unit KHz
// 	)(
// 	input  logic       clk       , // System clock
// 	input  logic       reset     , // Reset signal
// // Control and data from interconnect module
// 	input  logic       en        , // Start condition from the processor
// 	input  logic       read_write, // Read/Write command: 1 for read, 0 for write
// 	input  logic [7:0] data_in   , // Data to be sent to the slave from Processor
// 	input  logic [6:0] slave_addr, // 7-bit slave address
// 	output logic [7:0] data_out  , // Data read from slave
// 	output logic       busy      , // Busy flag
// 	output logic       ack_error , // Acknowledge error flag
// // I2C lines
// 	output logic       scl       , // I2C clock line
// 	inout  logic       sda         // I2C data line (bidirectional)
// );

//   logic        gen_clk_d     ;
// 	logic        en_reg        ;
// 	logic        read_write_reg;
// 	logic [ 7:0] data_in_reg   ;
// 	logic [ 7:0] data_out_store;
// 	logic [ 6:0] slave_addr_reg;
// 	logic        sda_out       ;
// 	logic [ 3:0] count_fsm     ;
// 	logic [15:0] req_count     ;

// 	assign req_count = (inclk*1000)/(sclk<<1);
//   assign sda = (reset)? 1'bz : ((sda_out)? 1'bz : 1'b0);

// 	localparam  IDLE     = 4'h0;  
// 	localparam  START    = 4'h1;      
// 	localparam  ADDRESS  = 4'h2;      
// 	localparam  R_W      = 4'h3;      
// 	localparam  CLK_SY_A = 4'h4;      
// 	localparam  READ     = 4'h5;      
// 	localparam  WRITE    = 4'h6;              
// 	localparam  CLK_SY_D = 4'h7;      
// 	localparam  STOP     = 4'h8;      

//   logic [3:0] current_state;
//   logic [3:0] next_state   ; 
  
// // Generating a slow clock of the defined parameter


// 	logic        gen_clk;
// 	logic [15:0] count  ;

//   always_ff @(posedge clk) begin
//   	if(reset) 
//   		gen_clk <= 0;
//   	else if(count == (req_count-1))
//   		gen_clk <= ~gen_clk;
//   end

//   always_ff @(posedge clk) begin
//   	if(reset) 
//   		gen_clk_d <= 0;
//   	else 
//   		gen_clk_d <= gen_clk;
//   end

// 	always_ff @(posedge clk) begin 
// 		if(reset) 
// 			count <= 0;
//   	else if(count == (req_count-1))
// 		  count <= 0;
// 	  else 
// 			count <= count + 1;
// 	end

//   always_ff @(posedge clk) begin 
//   	if(reset) begin
//   		en_reg         <= 0;
//   		read_write_reg <= 0;
//   		slave_addr_reg <= 0;
//   		data_in_reg    <= 0;
//   	end 
//   	else if(en && busy) begin
// 			en_reg         <= en        ;
// 			read_write_reg <= read_write;
// 			slave_addr_reg <= slave_addr;
// 			data_in_reg    <= data_in   ;
//   	end
//   	else if (current_state != IDLE) begin
//   		en_reg         <= 0             ;
// 			read_write_reg <= read_write_reg;
// 			slave_addr_reg <= slave_addr_reg;
// 			data_in_reg    <= data_in_reg   ;	
//   	end
//   end	           

//   always_ff @(posedge clk) begin
//   	if(reset) 
//   		count_fsm <= 0;
//     else if(gen_clk_d && ~gen_clk) begin
// 	  	if(current_state == ADDRESS)
// 	      count_fsm <= count_fsm + 1;
// 	  	else if(current_state == READ)
// 	      count_fsm <= count_fsm + 1;
// 	  	else if(current_state == WRITE)
// 	      count_fsm <= count_fsm + 1;
// 	  	else 
// 	  		count_fsm <= 0;
//     end
//   end

// 	always_comb begin
// 		case (current_state)
// 	    IDLE    : if(en_reg)                   next_state = START   ; 
// 	              else                         next_state = IDLE    ;	
// 	    START   :                              next_state = ADDRESS ;
// 	    ADDRESS : if(count_fsm == 6)           next_state = R_W     ;
// 	              else                         next_state = ADDRESS ;	
// 	    R_W     :                              next_state = CLK_SY_A;
// 	    CLK_SY_A: if(~sda && read_write)       next_state = READ    ;
// 	              else if(~sda && ~read_write) next_state = WRITE   ;
// 	              else                         next_state = STOP    ;
// 	    READ    : if(count_fsm == 7)           next_state = CLK_SY_D;
// 	              else                         next_state = READ    ;	
// 	    WRITE   : if(count_fsm == 7)           next_state = CLK_SY_D;
// 	              else                         next_state = WRITE   ;
//       CLK_SY_D:                              next_state = STOP    ;
//       STOP    :                              next_state = IDLE    ; 
// 			default :                              next_state = IDLE    ;
// 		endcase
// 	end

// 	always_ff @(posedge clk) begin 
// 		if(reset) 
// 			data_out <= 0;
// 		else if(count_fsm == 8)
// 		  data_out <= data_out_store;
// 	end

//   always_ff @(posedge clk) begin
//   	if(reset)
//   		data_out_store <= 0;
//   	else if(~gen_clk_d && gen_clk) begin
// 	  	if((current_state == READ) && (sda == 0))
// 				data_out_store[7-count_fsm] <= 0;
// 			else 
// 				data_out_store[7-count_fsm] <= 1;
//   	end
//   end

//   always_ff @(posedge clk) begin
//   	if(reset) begin
//   		current_state <= 0         ;
//   	end 
//   	else if(gen_clk_d && ~gen_clk) begin
//   		current_state <= next_state;
//   	end
//   end

//   always_comb begin 
// 		case (current_state)
// 	  	IDLE    :  scl = 1'b1   ;
// 	    START   :  scl = 1'b1   ;
// 	    ADDRESS :  scl = gen_clk;
// 	    R_W     :  scl = gen_clk;
// 	    CLK_SY_A:  scl = gen_clk;
// 	    READ    :  scl = gen_clk;
// 	    WRITE   :  scl = gen_clk;
// 	    CLK_SY_D:  scl = gen_clk;
// 	    STOP    :  scl = 1'b1   ;
// 	    default :  scl = 1'b1   ;
//     endcase
//   end

// 	always_comb begin
// 		case (current_state)
// 	  	IDLE    : busy = 1'b1;
// 	    START   : busy = 1'b0;
// 	    ADDRESS : busy = 1'b0;
// 	    R_W     : busy = 1'b0;
// 	    CLK_SY_A: busy = 1'b0;
// 	    READ    : busy = 1'b0;
// 	    WRITE   : busy = 1'b0;
// 	    CLK_SY_D: busy = 1'b0;
// 	    STOP    : busy = 1'b0;
// 	    default : busy = 1'b1;
// 	  endcase
//   end

// 	always_ff @(posedge clk) begin
//     if(gen_clk_d && ~gen_clk)
// 			case (current_state)
// 		    CLK_SY_A: if(~sda) ack_error <= 1'b0;
// 		              else     ack_error <= 1'b1;
// 		    CLK_SY_D: if(~sda) ack_error <= 1'b0;
// 		              else     ack_error <= 1'b1;
// 		    default : ack_error          <= 1'b0;
// 		  endcase
//   end

// 	always_comb begin
// 		case (current_state)
// 	    IDLE    : sda_out = 1'b1                       ;
// 			START   : sda_out = 1'b0                       ;
// 			ADDRESS : sda_out = slave_addr_reg[6-count_fsm];
// 			R_W     : sda_out = read_write_reg             ;
// 			CLK_SY_A: sda_out = 1'b1                       ;
// 			READ    : sda_out = 1'b1                       ;
// 			WRITE   : sda_out = data_in[7-count_fsm]       ;
// 			CLK_SY_D: sda_out = 1'b1                       ;
// 			STOP    : sda_out = 1'b1                       ;
// 			default : sda_out = 1'b1                       ;
// 		endcase
// 	end

// endmodule
