`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BU
// Engineer: Alexander Whittemore
// 
// Create Date:    20:03:04 12/08/2010 
// Design Name: 19.2KHz 5-byte 8-n-1 UART Transmitter
// Module Name:    uart_tx 
// Project Name: 
// Target Devices: Xilinx Spartan 6
// Revision: 
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////
module uart_tx(
    input clk_19k2,
    input rst,
    input send_ready,
    input [7:0] byte0,
    input [7:0] byte1,
    input [7:0] byte2,
    input [7:0] byte3,
    input [7:0] byte4,
    output reg uart_out
    );
	 
	 reg [7:0] in_byte [0:4];
	 
	 // set up a place to keep track of which bit we're on
	 reg [3:0] uart_state;
	 // and a place to keep track of which byte we're transmitting
	 reg [2:0] byte_state;
	 reg data_sent = 0; //prevent repeat data sends.
	 

	always @(posedge clk_19k2 or posedge rst) begin
		if (rst) begin
			uart_state <= 4'b0000;
			byte_state <= 2'b000;
			uart_out <= 1;
		end else begin
			case (uart_state)
				4'b0000: begin //currently waiting to transmit
					if ((send_ready == 1)&(data_sent == 0)) begin
						uart_state <= 4'b0001; //move to the start bit state
					end
				end
				4'b0001: begin
					uart_out <= 0; // send start bit
					uart_state <= uart_state + 4'b0001; 
				end
				4'b0010: begin // data bit 0
					case (byte_state)
						3'b000:
							uart_out <= byte0[(7-0)];
						3'b001:
							uart_out <= byte1[(7-0)];
						3'b010:
							uart_out <= byte2[(7-0)];
						3'b011:
							uart_out <= byte3[(7-0)];
						3'b100:
							uart_out <= byte4[(7-0)];
					endcase
					uart_state <= uart_state + 4'b0001;
				end
				4'b0011: begin // data bit 1
					case (byte_state)
						3'b000:
							uart_out <= byte0[(7-1)];
						3'b001:
							uart_out <= byte1[(7-1)];
						3'b010:
							uart_out <= byte2[(7-1)];
						3'b011:
							uart_out <= byte3[(7-1)];
						3'b100:
							uart_out <= byte4[(7-1)];
					endcase
					uart_state <= uart_state + 4'b0001;
				end
				4'b0100: begin // data bit 2
					case (byte_state)
						3'b000:
							uart_out <= byte0[(7-2)];
						3'b001:
							uart_out <= byte1[(7-2)];
						3'b010:
							uart_out <= byte2[(7-2)];
						3'b011:
							uart_out <= byte3[(7-2)];
						3'b100:
							uart_out <= byte4[(7-2)];
					endcase
					uart_state <= uart_state + 4'b0001;
				end
				4'b0101: begin // data bit 3
					case (byte_state)
						3'b000:
							uart_out <= byte0[(7-3)];
						3'b001:
							uart_out <= byte1[(7-3)];
						3'b010:
							uart_out <= byte2[(7-3)];
						3'b011:
							uart_out <= byte3[(7-3)];
						3'b100:
							uart_out <= byte4[(7-3)];
					endcase
					uart_state <= uart_state + 4'b0001;
				end
				4'b0110: begin // data bit 4
					case (byte_state)
						3'b000:
							uart_out <= byte0[(7-4)];
						3'b001:
							uart_out <= byte1[(7-4)];
						3'b010:
							uart_out <= byte2[(7-4)];
						3'b011:
							uart_out <= byte3[(7-4)];
						3'b100:
							uart_out <= byte4[(7-4)];
					endcase
					uart_state <= uart_state + 4'b0001;
				end
				4'b0111: begin // data bit 5
					case (byte_state)
						3'b000:
							uart_out <= byte0[(7-5)];
						3'b001:
							uart_out <= byte1[(7-5)];
						3'b010:
							uart_out <= byte2[(7-5)];
						3'b011:
							uart_out <= byte3[(7-5)];
						3'b100:
							uart_out <= byte4[(7-5)];
					endcase
					uart_state <= uart_state + 4'b0001;
				end
				4'b1000: begin // data bit 6
					case (byte_state)
						3'b000:
							uart_out <= byte0[(7-6)];
						3'b001:
							uart_out <= byte1[(7-6)];
						3'b010:
							uart_out <= byte2[(7-6)];
						3'b011:
							uart_out <= byte3[(7-6)];
						3'b100:
							uart_out <= byte4[(7-6)];
					endcase
					uart_state <= uart_state + 4'b0001;
				end
				4'b1001: begin // data bit 7
					case (byte_state)
						3'b000:
							uart_out <= byte0[(7-7)];
						3'b001:
							uart_out <= byte1[(7-7)];
						3'b010:
							uart_out <= byte2[(7-7)];
						3'b011:
							uart_out <= byte3[(7-7)];
						3'b100:
							uart_out <= byte4[(7-7)];
					endcase
					uart_state <= uart_state + 4'b0001;
				end
				4'b1010: begin //stop bit
					uart_out <= 1;
					if (byte_state == 3'b100) begin // if this is the last byte...
						uart_state <= 4'b1011; //throw the uart_state into a holding state.
					end else begin
						uart_state <= 4'b0001; //if this isn't the last byte, go to the start bit state
						byte_state <= byte_state + 3'b001; //increment the byte state to the next one.
					end
				end
				4'b1011: begin
					uart_state <= 4'b0000; // jump to the 'wait for send' state.
					byte_state <= 3'b000;
					if (send_ready == 1) begin
						data_sent <= 1;
					end else begin
						data_sent <= 0;
					end
					uart_out <= 1;
				end
				default: begin
					uart_state <= 4'b0000;
					uart_out <= 1;
				end
			endcase
		end
	end //end always

endmodule
