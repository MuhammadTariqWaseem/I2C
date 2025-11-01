module I2C_top (
	input  logic            clk       , // Clock
	input  logic            reset     ,
	input  logic            en        ,
	input  logic      [9:0] no_of_bytes,
	input  logic            read_write,
	input  logic [9:0][7:0] data_in   ,
	input  logic      [6:0] slave_addr,
	input  logic [9:0][7:0] data_in_1 ,
	input  logic [9:0][7:0] data_in_2 ,
	input  logic [9:0][7:0] data_in_3 ,
	input  logic [9:0][7:0] data_in_4 ,
	output logic [9:0][7:0] data_out  ,
	output logic [9:0][7:0] data_out_1,
	output logic [9:0][7:0] data_out_2,
	output logic [9:0][7:0] data_out_3,
	output logic [9:0][7:0] data_out_4,
	output logic            busy      ,
	output logic            ack_error 
);

	logic scl;
	wire  sda;

	I2C_master #(
		.inclk(100  ),
		.sclk (10000)
	) I2C_master  (
		.clk        (clk        ),
		.reset      (reset      ),
		.en         (en         ),
		.no_of_bytes(no_of_bytes),
		.read_write (read_write ),
		.data_in    (data_in    ),
		.slave_addr (slave_addr ),
		.data_out   (data_out   ),
		.busy       (busy       ),
		.ack_error  (ack_error  ),
		.scl        (scl        ),
		.sda        (sda        )
	);

	I2C_slave #(.MY_ADDR(84)) I2C_slave_54 (
		.clk     (clk       ),
		.reset   (reset     ),
		.scl     (scl       ),
		.sda     (sda       ),
		.data_in (data_in_1 ),
		.data_out(data_out_1)
	);

	I2C_slave #(.MY_ADDR(86)) I2C_slave_56 (
		.clk     (clk       ),
		.reset   (reset     ),
		.scl     (scl       ),
		.sda     (sda       ),
		.data_in (data_in_2 ),
		.data_out(data_out_2)
	);

	I2C_slave #(.MY_ADDR(87)) I2C_slave_57 (
		.clk     (clk       ),
		.reset   (reset     ),
		.scl     (scl       ),
		.sda     (sda       ),
		.data_in (data_in_3 ),
		.data_out(data_out_3)
	);

	I2C_slave #(.MY_ADDR(88)) I2C_slave_58 (
		.clk     (clk       ),
		.reset   (reset     ),
		.scl     (scl       ),
		.sda     (sda       ),
		.data_in (data_in_4 ),
		.data_out(data_out_4)
	);

endmodule