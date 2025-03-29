`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 14:39:34
// Design Name: 
// Module Name: Parity
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//Parity generator

module Parity(
    input reset,
    input [7:0] data_in,
    output reg parity_bit
);

always @(*) begin
  if(reset)
    parity_bit <= 1'b1;
  else
    parity_bit <= (^data_in)? 1'b1 : 1'b0;
end
endmodule
