`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:32:40 12/08/2010
// Design Name:   uart_rx
// Module Name:   X:/Desktop/Router/uart_rx_test.v
// Project Name:  Router
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uart_rx
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module uart_rx_test;

	// Inputs
	reg uart_in;
	reg clk_19k2;
	reg rst;

	// Outputs
	wire read_ready;
	wire [7:0] byte0;
	wire [7:0] byte1;
	wire [7:0] byte2;
	wire [7:0] byte3;
	wire [7:0] byte4;

	// Instantiate the Unit Under Test (UUT)
	uart_rx uut (
		.uart_in(uart_in), 
		.clk_19k2(clk_19k2), 
		.rst(rst), 
		.read_ready(read_ready), 
		.byte0(byte0), 
		.byte1(byte1), 
		.byte2(byte2), 
		.byte3(byte3), 
		.byte4(byte4)
	);

	initial begin
		// Initialize Inputs
		uart_in = 1;
		clk_19k2 = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 0;
		// Add stimulus here
		
		#30;
		uart_in = 0; //start bit for byte 0
		#10;
		uart_in = 1;
		#10;
		uart_in = 1;
		#10;
		uart_in = 1;
		#10;
		uart_in = 0;
		#10;
		uart_in = 0;
		#10;
		uart_in = 0;
		#10;
		uart_in = 1;
		#10;
		uart_in = 1;
		#10;
		uart_in = 1; //stop bit
		
		#40;
		uart_in = 0; //start bit byte1
		#10;
		uart_in = 1;
		#10;
		uart_in = 1;
		#10;
		uart_in = 1;
		#10;
		uart_in = 0;
		#10;
		uart_in = 1;
		#10;
		uart_in = 1;
		#10;
		uart_in = 1;
		#10;
		uart_in = 1;
		#10;
		uart_in = 1; //stop bit
		
		#40;
		uart_in = 0; //start bit byte2
		#10;
		uart_in = 0;
		#10;
		uart_in = 1;
		#10;
		uart_in = 1;
		#10;
		uart_in = 1;
		#10;
		uart_in = 0;
		#10;
		uart_in = 0;
		#10;
		uart_in = 0;
		#10;
		uart_in = 0;
		#10;
		uart_in = 1; //stop bit
		
		#40;
		uart_in = 0; //start bit byte3
		#10;
		uart_in = 1;
		#10;
		uart_in = 0;
		#10;
		uart_in = 0;
		#10;
		uart_in = 0;
		#10;
		uart_in = 0;
		#10;
		uart_in = 0;
		#10;
		uart_in = 0;
		#10;
		uart_in = 1;
		#10;
		uart_in = 1; //stop bit
		
		#40;
		uart_in = 0; //start bit byte4
		#10;
		uart_in = 1;
		#10;
		uart_in = 0;
		#10;
		uart_in = 1;
		#10;
		uart_in = 0;
		#10;
		uart_in = 0;
		#10;
		uart_in = 0;
		#10;
		uart_in = 1;
		#10;
		uart_in = 0;
		#10;
		uart_in = 1; //stop bit
		
		//for fun, flail uart bus.
		#10;
		uart_in = 0;
		#10
		uart_in = 1;
		#10;
		uart_in = 0;
		#10
		uart_in = 1;
		#10;
		uart_in = 0;
		#10
		uart_in = 1;
		#10;
		uart_in = 0;
		#10
		uart_in = 1;
		#10;
		uart_in = 0;
		#10
		uart_in = 1;
		#10;
		uart_in = 0;
		#10
		uart_in = 1;
		#10;
		uart_in = 0;
		#10
		uart_in = 1;
		
		#40
		rst = 1;
		#10
		rst = 0;

	end
	always begin
		#5;
		clk_19k2 = ~clk_19k2;
	end
endmodule

