`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BU
// Engineer: Alexander Whittemore
// 
// Create Date:    20:03:04 12/08/2010 
// Design Name: 19.2KHz 5-byte 8-n-1 UART Receiver
// Module Name:    uart_rx 
// Project Name: 
// Target Devices: Xilinx Spartan 6
// Revision: 
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////
module uart_rx(
    input uart_in,
    input clk_19k2,
    input rst,
	 output reg read_ready,
    output reg [7:0] byte0,
	 output reg [7:0] byte1,
	 output reg [7:0] byte2,
	 output reg [7:0] byte3,
	 output reg [7:0] byte4
    );
	 
	 reg [7:0] out_byte [0:4];
	
	//Keep track of UART RX Position
	reg [3:0] uart_state;
	//Keep track of which byte to fill:
	reg [2:0] byte_state;
	
	always @(posedge clk_19k2 or posedge rst) begin
		if (rst) begin
			out_byte[0] <= 8'b00000000;
			out_byte[1] <= 8'b00000000;
			out_byte[2] <= 8'b00000000;
			out_byte[3] <= 8'b00000000;
			out_byte[4] <= 8'b00000000;
			uart_state <= 4'b0000;
			byte_state <= 3'b000;
			read_ready <= 0;
		end else begin
			if (uart_state == 0) begin //if waiting for a start bit
				if ((uart_in == 0)&(read_ready == 0)) begin
					uart_state <= uart_state + 4'b0001; //if we get a start bit, listen for bit 0-7
				end
			end else if ((uart_state >= 4'b0001)&(uart_state <= 4'b0111)) begin
				out_byte[byte_state][4'b0111 - (uart_state - 4'b0001)] <= uart_in; //set the uart_state-1th bit of the current byte to the uart_in line
				uart_state <= uart_state + 4'b0001; //move to the next bit
			end else if (uart_state == 4'b1000) begin //if we're at bit 8, set that bit in the byte then reset
				out_byte[byte_state][4'b0111 - (uart_state - 4'b0001)] <= uart_in;
				uart_state <= 4'b0000;
				if (byte_state < 3'b100) begin
					byte_state <= byte_state + 3'b001;
				end else begin
				// necessarily, if byte_state is greater than byte 3, IE 4 or higher
				// and we're at bit 8, we're done with the last byte.
					byte_state <= 3'b000;
					read_ready <= 1;
				end
			end else begin
				uart_state <= 4'b0000; //if something else, reset to waiting.
			end
		end
	end //end always
	
	always @(out_byte[0]) begin
		byte0 = out_byte[0];
	end
	
	always @(out_byte[1]) begin
		byte1 = out_byte[1];
	end
	
	always @(out_byte[2]) begin
		byte2 = out_byte[2];
	end
	
	always @(out_byte[3]) begin
		byte3 = out_byte[3];
	end
	
	always @(out_byte[4]) begin
		byte4 = out_byte[4];
	end

endmodule
