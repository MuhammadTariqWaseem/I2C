module tb_I2C_top ();

	logic            clk        = 0;
	logic            reset      = 1;
	logic            en         = 0; 
	logic            read_write = 0;
	logic      [9:0] no_of_bytes= 0;
	logic [9:0][7:0] data_in    = 0;
	logic      [6:0] slave_addr = 0;
	logic [9:0][7:0] data_out      ;
	logic            busy          ;
	logic            ack_error     ;
  
	logic [9:0][7:0] data_in_1  = 0;
	logic [9:0][7:0] data_in_2  = 0;
	logic [9:0][7:0] data_in_3  = 0;
	logic [9:0][7:0] data_in_4  = 0;
	logic [9:0][7:0] data_out_1    ;
	logic [9:0][7:0] data_out_2    ;
	logic [9:0][7:0] data_out_3    ;
	logic [9:0][7:0] data_out_4    ;
	logic      [1:0] index         ;

  int unsigned options[4] = '{84, 86, 87, 88};
  int selected;

I2C_top i_I2C_top (
	.clk        (clk        ),
	.reset      (reset      ),
	.en         (en         ),
	.no_of_bytes(no_of_bytes),
	.read_write (read_write ),
	.data_in    (data_in    ),
	.slave_addr (slave_addr ),
	.data_in_1  (data_in_1  ),
	.data_in_2  (data_in_2  ),
	.data_in_3  (data_in_3  ),
	.data_in_4  (data_in_4  ),
	.data_out   (data_out   ),
	.data_out_1 (data_out_1 ),
	.data_out_2 (data_out_2 ),
	.data_out_3 (data_out_3 ),
	.data_out_4 (data_out_4 ),
	.busy       (busy       ),
	.ack_error  (ack_error  )
);

always #5 clk = ~clk;  // Toggle clock every 5 time units (period = 10)

initial begin 
  
  for (int z = 0; z < 7; z++) begin  
		index = $urandom_range(0, 3); 
    slave_addr = options[index];
	  for (int i = 0; i < 20; i++) begin  
	  	for (int k = 0; k < 9; k++) begin
		    data_in[k] = $urandom_range(1,254);
	  	end
	    no_of_bytes = $urandom_range(9,1);
	
	    repeat(40) @(posedge clk);
	    reset = 1'b0;                   // Deassert reset after 10 time units
	    repeat(10) @(posedge clk);
	    en = 1'b1;                      // Enable communication
	    @(posedge clk);
	    en = 1'b0;                      // Disable communication after 100 time units
	    
	    repeat(1000) @(posedge clk);
	    for (int k = 0; k < no_of_bytes; k++) begin
	    	if(slave_addr == 84)
			    assert(data_out_1[k] == data_in[k])
			      $display("Perfect write from the master to Slave 1");
			    else
			    	$display("writing error to slave 1                      (--__--)");
	    	else if(slave_addr == 86)
			    assert(data_out_2[k] == data_in[k])
			      $display("Perfect write from the master to Slave 2");
			    else
			    	$display("writing error to slave 2                      (--__--)");
	    	else if(slave_addr == 87)
			    assert(data_out_3[k] == data_in[k])
			      $display("Perfect write from the master to Slave 3");
			    else
			    	$display("writing error to slave 3                      (--__--)");
	    	if(slave_addr == 88)
			    assert(data_out_4[k] == data_in[k])
			      $display("Perfect write from the master to Slave 4");
			    else
			    	$display("writing error to slave 4                      (--__--)");
	  	end
	  end
	end

	for (int z = 0; z < 7; z++) begin  
		index = $urandom_range(0, 3); 
    slave_addr = options[index];
	  for (int i = 0; i < 20; i++) begin  
	    for (int k = 0; k < 9; k++) begin
		    data_in_1 = $urandom_range(1,254);
		    data_in_2 = $urandom_range(1,254);
		    data_in_3 = $urandom_range(1,254);
		    data_in_4 = $urandom_range(1,254);
			end
	    no_of_bytes = $urandom_range(1,9);
	  
	    read_write = 1'b1;              // Initialize to write operation
	    repeat(10) @(posedge clk);
	    reset = 1'b0;                   // Deassert reset after 10 time units
	    repeat(10) @(posedge clk);
	    en = 1'b1;                      // Enable communication
	    @(posedge clk);
	    en = 1'b0;                      // Disable communication after 100 time units
	    repeat(1000) @(posedge clk);
	
	    for (int k = 0; k < no_of_bytes; k++) begin
	    	if(slave_addr == 84)
		      assert(data_out[k] == data_in_1[k])
		        $display("Perfect Read from slave 1");
		      else
		      	$display("Reading error from slave 1                   (--__--)");
	    	else if(slave_addr == 86)
		      assert(data_out[k] == data_in_2[k])
		        $display("Perfect Read from slave 2");
		      else
		      	$display("Reading error from slave 2                   (--__--)");
	    	else if(slave_addr == 87)
		      assert(data_out[k] == data_in_3[k])
		        $display("Perfect Read from slave 3");
		      else
		      	$display("Reading error from slave 3                   (--__--)");
	    	else if(slave_addr == 88)
		      assert(data_out[k] == data_in_4[k])
		        $display("Perfect Read from slave 4");
		      else
		      	$display("Reading error from slave 4                   (--__--)");
	  	end
	  end
  end

  $stop;
end

endmodule