`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:58:51 12/09/2010
// Design Name:   uart_tx
// Module Name:   X:/Desktop/Router/uart_tx_test.v
// Project Name:  Router
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uart_tx
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module uart_tx_test;

	// Inputs
	reg clk_19k2;
	reg rst;
	reg send_ready;
	reg [7:0] byte0;
	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;
	reg [7:0] byte4;

	// Outputs
	wire uart_out;

	// Instantiate the Unit Under Test (UUT)
	uart_tx uut (
		.clk_19k2(clk_19k2), 
		.rst(rst), 
		.send_ready(send_ready), 
		.byte0(byte0), 
		.byte1(byte1), 
		.byte2(byte2), 
		.byte3(byte3), 
		.byte4(byte4), 
		.uart_out(uart_out)
	);

	initial begin
		// Initialize Inputs
		clk_19k2 = 0;
		rst = 1;
		send_ready = 0;
		byte0 = 8'b10000001;
		byte1 = 8'b01000001;
		byte2 = 8'b00100001;
		byte3 = 8'b00010001;
		byte4 = 8'b00001001;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 0;
		#30;
		send_ready = 1;
		#30;
		send_ready = 0;
		#500;
		send_ready = 1;
		#10
		send_ready = 0;
		// Add stimulus here

	end
   always begin
		#5;
		clk_19k2 = ~clk_19k2;
	end
endmodule

