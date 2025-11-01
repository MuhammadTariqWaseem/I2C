module I2C_slave #(parameter MY_ADDR = 54) (
  input  logic            clk     , // Clock
  input  logic            reset   ,
  input  logic            scl     ,
  inout  logic            sda     ,
  input  logic [9:0][7:0] data_in ,
  output logic [9:0][7:0] data_out
);

  logic       [6:0] slave_addr;
  logic       [3:0] count_fsm ;
  logic [10:0][7:0] data_out_pre;

  logic [2:0] current_state;
  logic [2:0] next_state   ;
  logic [2:0] next_state_d ;
  logic       read_write   ;
  logic       sda_out      ;
  logic       scl_d        ;
  logic       sda_d        ;
  logic       sda_in       ;
  logic [9:0] count_bytes  ;

  assign sda = (reset)? 1'bz : ((sda_out)? 1'bz : 1'b0);

  always_comb begin
    if(sda == 0)
      sda_in = 0;
    else 
      sda_in = 1;
  end
 
  localparam IDLE  = 4'd0;
  localparam ADDR  = 4'd1;
  localparam R_W   = 4'd2;
  localparam A_ACK = 4'd3;
  localparam WRITE = 4'd4;
  localparam READ  = 4'd5;
  localparam D_ACK = 4'd6;
  localparam W_ACK = 4'd7;
  localparam STOP  = 4'd8;

  always_ff @(posedge clk) begin
    if(reset)
      next_state_d <= 0;
    else
      next_state_d <= next_state;
  end

  always_ff @(posedge clk) begin
    if(reset) begin
      sda_d <= 0;
      scl_d <= 0;
    end
    else begin
      sda_d <= sda_in;
      scl_d <= scl;
    end
  end

  always_ff @(posedge clk) begin
    if(reset)
      count_bytes <= 0;
    else if((current_state == D_ACK | current_state == W_ACK) && (!scl_d && scl))
      count_bytes <= count_bytes + 1;
    else if(current_state == IDLE)
      count_bytes <= 0;
  end

  always_ff @(posedge clk) begin
    if(reset) 
      count_fsm <= 0;
    else if(scl_d && ~scl)
      if (current_state == ADDR)
        count_fsm <= count_fsm + 1;
      else if((current_state == READ) && (count_fsm == 8))
        count_fsm <= 0;
      else if(current_state == READ)
        count_fsm <= count_fsm + 1;
      else if(current_state == WRITE)
        count_fsm <= count_fsm + 1;
      else 
        count_fsm <= 0;
  end

  always_comb begin 
    case (current_state)
      IDLE    : if((scl && ~sda_in && sda_d) | ((next_state == ADDR) && (current_state == IDLE))) 
                                            next_state = ADDR ;
                else                        next_state = IDLE ;
      ADDR    : if(count_fsm == 6)          next_state = R_W  ;
                else                        next_state = ADDR ;
      R_W     : if(slave_addr == MY_ADDR)   next_state = A_ACK;
                else                        next_state = IDLE ;
      A_ACK   : if(read_write)              next_state = WRITE;
                else                        next_state = READ ;
      READ    : if(count_fsm == 7)          next_state = D_ACK;
                else                        next_state = READ ;  
      WRITE   : if(count_fsm == 7)          next_state = W_ACK;
                else                        next_state = WRITE;
      D_ACK   :                             next_state = READ ;
      W_ACK   : if(~sda_in)                 next_state = WRITE;
                else                        next_state = STOP ;                   
      STOP    : if(scl && ~sda_in)          next_state = STOP ;
                else                        next_state = IDLE ;
      default :                             next_state = IDLE ;
    endcase   
  end

  always_ff @(posedge clk) begin 
    if(reset) 
      data_out <= 0;
    else if(current_state == ADDR)
      data_out <= 0;
    else if(count_fsm == 8)
      data_out <= data_out_pre[10:1];
  end

  always_ff @(posedge clk) begin
    if(reset)
      data_out_pre <= 0;
    else if(~scl_d && scl) begin
      if ((current_state == READ) && !sda_in)
        data_out_pre[0][7-count_fsm] <= 0;
      else if(current_state == D_ACK)
        data_out_pre[10:1] <= data_out_pre[9:0];
      else
        data_out_pre[0][7-count_fsm] <= 1; 
    end
  end

  always_comb begin
    if(reset)
      sda_out <= 1;
    else 
      case (current_state)
        A_ACK   : if(slave_addr == MY_ADDR) 
                    sda_out <= 0;
                  else                      
                    sda_out <= 1;
        WRITE   : sda_out <= data_in[count_bytes][7-count_fsm];
        D_ACK   : sda_out <= 0; 
        STOP    : sda_out <= 1;
        default : sda_out <= 1;
      endcase
  end

  always_ff @(posedge clk) begin 
    if(reset) 
      current_state <= 0;
    else if(scl && ~sda_d && sda_in)
      current_state <= 0;
    else if(scl_d && ~scl)
      current_state <= next_state_d;
    else if( (~scl_d & scl) &(current_state == D_ACK) )
      current_state <= next_state_d;
  end

  always_ff @(posedge clk) begin
    if(reset)
      read_write <= 0;
    else if(~scl_d && scl)
      if((current_state == R_W) && !sda_in)
        read_write <= 0;
    else if(current_state == R_W)
        read_write <= 1;    
  end

  always_ff @(posedge clk) begin
    if(reset)
      slave_addr            <=  0;
    else if(~scl_d && scl)
      if((current_state == ADDR) && !sda_in)
        slave_addr[6-count_fsm] <=  0;  
      else
        slave_addr[6-count_fsm] <=  1;  
  end

endmodule 


// module I2C_slave #(parameter MY_ADDR = 54) (
// 	input  logic       clk     , // Clock
// 	input  logic       reset   ,
// 	input  logic       scl     ,
// 	inout  logic       sda     ,
// 	input  logic [7:0] data_in ,
// 	output logic [7:0] data_out
// );

//   logic [6:0] slave_addr;
//   logic [3:0] count_fsm ;
//   logic [7:0] data_out_pre;

//   logic [2:0] current_state;
//   logic [2:0] next_state   ;
//   logic [2:0] next_state_d ;
//   logic       read_write   ;
//   logic       sda_out      ;
//   logic       scl_d        ;

//   assign sda = (reset)? 1'bz : ((sda_out)? 1'bz : 1'b0);

//   localparam IDLE  = 3'd0;
//   localparam ADDR  = 3'd1;
//   localparam R_W   = 3'd2;
//   localparam A_ACK = 3'd3;
//   localparam WRITE = 3'd4;
//   localparam READ  = 3'd5;
//   localparam D_ACK = 3'd6;
//   localparam STOP  = 3'd7;

//   always_ff @(posedge clk) begin
//     if(reset) begin
//       next_state_d <= 0;
//       scl_d <= 0;
//     end
//     else begin
//       next_state_d <= next_state;
//       scl_d <= scl;
//     end
//   end

//   always_ff @(posedge clk) begin
//   	if(reset) 
//   		count_fsm <= 0;
//   	else if(scl_d && ~scl)
//       if (current_state == ADDR)
//         count_fsm <= count_fsm + 1;
//     	else if(current_state == READ)
//         count_fsm <= count_fsm + 1;
//     	else if(current_state == WRITE)
//         count_fsm <= count_fsm + 1;
//     	else 
//     		count_fsm <= 0;
//   end

//   always_comb begin 
//     case (current_state)
//       IDLE    : if(scl && ~sda)           next_state = ADDR ;
//                 else                      next_state = IDLE ;
//       ADDR    : if(count_fsm == 6)        next_state = R_W  ;
//                 else                      next_state = ADDR ;
//       R_W     : if(slave_addr == MY_ADDR) next_state = A_ACK;
//                 else                      next_state = IDLE ;
//       A_ACK   : if(read_write)            next_state = WRITE;
//                 else                      next_state = READ ;
//       READ    : if(count_fsm == 7)        next_state = D_ACK;
//                 else                      next_state = READ ;  
//       WRITE   : if(count_fsm == 7)        next_state = D_ACK;
//                 else                      next_state = WRITE;
//       D_ACK   :                           next_state = STOP ;
//       STOP    : if(scl && (sda == 0))     next_state = STOP ;
//                 else                      next_state = IDLE ;
//   		default :                           next_state = IDLE ;
//   	endcase  	
//   end

// 	always_ff @(posedge clk) begin 
// 		if(reset) 
// 			data_out <= 0;
// 		else if(count_fsm == 8)
// 		  data_out <= data_out_pre;
// 	end

//   always_ff @(posedge clk) begin
//   	if(reset)
//   		data_out_pre <= 0;
//   	else if(~scl_d && scl) begin
//       if ((current_state == READ) && (sda == 0))
//   			data_out_pre[7-count_fsm] <= 0;
//   		else
//   			data_out_pre[7-count_fsm] <= 1; 
//     end
//   end

//   always_comb begin
//     if(reset)
//       sda_out <= 1;
//     else 
//     	case (current_state)
//     	  A_ACK   : if(slave_addr == MY_ADDR) 
//   						  	  sda_out <= 0;
//   								else                      
//   									sda_out <= 1;
//   		  WRITE   : sda_out <= data_in[7-count_fsm];
//   		  D_ACK   : sda_out <= 0; 
//         STOP    : sda_out <= 1;
//     		default : sda_out <= 1;
//     	endcase
//   end

//   always_ff @(posedge clk) begin 
//   	if(reset) 
//   		current_state <= 0;
//   	else if(scl_d && ~scl)
//   		current_state <= next_state_d;
//     else if(current_state == STOP)
//       current_state <= next_state_d;
//   end

//   always_ff @(posedge clk) begin
//   	if(reset)
//   	  read_write <= 0;
//     else if(~scl_d && scl)
//       if((current_state == R_W) && (sda == 0))
//         read_write <= 0;
//       else if(current_state == R_W)
//         read_write <= 1;  	
//   end

//   always_ff @(posedge clk) begin
//   	if(reset)
//   	  slave_addr            <=  0;
//     else if(~scl_d && scl)
//       if((current_state == ADDR) && (sda == 0))
//         slave_addr[6-count_fsm] <=  0;  
//       else
//         slave_addr[6-count_fsm] <=  1;  
//   end

// endmodule 
