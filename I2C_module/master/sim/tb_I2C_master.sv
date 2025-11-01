module tb_I2C_master;

logic       clk       ; 
logic       reset     ;
logic       en        ; 
logic       read_write; // Declare control signals
logic [7:0] data_in   ; // Data to send
logic [6:0] slave_addr; // 7-bit slave address
logic       scl       ; // I2C clock
wire        sda       ; // I2C data line (bidirectional)
logic       busy      ; // Busy signal
logic       ack_error ; // Acknowledge error signal
logic [7:0] data_out  ; // Data read from slave
logic       sda_out   ; // For controlling sda output

I2C_master #(
  .inclk(100  ),
  .sclk (10000)
) i_I2C_master (
  .clk       (clk       ),
  .reset     (reset     ),
  .en        (en        ),
  .read_write(read_write),
  .data_in   (data_in   ),
  .slave_addr(slave_addr),
  .data_out  (data_out  ),
  .busy      (busy      ),
  .ack_error (ack_error ),
  .scl       (scl       ),
  .sda       (sda       )
);

// Clock generation block (50% duty cycle, period = 10 time units)
always #5 clk = ~clk;  // Toggle clock every 5 time units (period = 10)
assign sda = (sda_out)? 1'bz : 1'b0;


// Testbench initial block
initial begin 
    // Initializing signals
    clk = 1'b1;                     // Initialize clock
    en = 1'b0;                      // Disable communication at start
    reset = 1'b1;                   // Apply reset initially
    slave_addr = 7'b0110110;        // Slave address
    read_write = 1'b0;              // Initialize to write operation
    data_in = 8'hA5;                // Example data to send
    sda_out = 1;

    // Test sequence
    repeat(10) @(posedge clk);
    reset = 1'b0;                   // Deassert reset after 10 time units
    repeat(10) @(posedge clk);
    en = 1'b1;                      // Enable communication
    @(posedge clk);
    en = 1'b0;                      // Disable communication after 100 time units
    
    // Simulate I2C behavior by forcing and releasing sda
    repeat(100) @(posedge clk);
    sda_out = 1'b0;           
    repeat(10) @(posedge clk);
    sda_out = 1;;                

    repeat(80) @(posedge clk);
    sda_out = 1'b0;           
    repeat(10) @(posedge clk);
    sda_out = 1;; 
    repeat(200) @(posedge clk);

    read_write = 1'b1;              // Initialize to write operation
    repeat(10) @(posedge clk);
    reset = 1'b0;                   // Deassert reset after 10 time units
    repeat(10) @(posedge clk);
    en = 1'b1;                      // Enable communication
    @(posedge clk);
    en = 1'b0;                      // Disable communication after 100 time units
    repeat(100) @(posedge clk);
    sda_out = 1'b0;           
    repeat(10) @(posedge clk);
    sda_out = 1'b0;           
    repeat(10) @(posedge clk);
    sda_out = 1'b0;           
    repeat(10) @(posedge clk);
    sda_out = 1'b1;           
    repeat(10) @(posedge clk);
    sda_out = 1'b0;           
    repeat(10) @(posedge clk);
    sda_out = 1'b1;           
    repeat(10) @(posedge clk);
    sda_out = 1'b0;           
    repeat(10) @(posedge clk);
    sda_out = 1'b1;
    repeat(10) @(posedge clk);
    sda_out = 1'b0;           
    repeat(10) @(posedge clk);
    sda_out = 1'b1;           
    repeat(10) @(posedge clk);
    sda_out = 1;;           

    repeat(200) @(posedge clk);

  $stop;
end

endmodule
