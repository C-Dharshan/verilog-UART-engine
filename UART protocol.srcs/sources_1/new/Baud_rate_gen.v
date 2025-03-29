`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 14:26:23
// Design Name: 
// Module Name: Baud_rate_gen
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

//16x baud rate generator 
//This is same for both transmitter and receiver

module Baud_rate_gen #(parameter clock_rate = 50_000_000, 
                  parameter baud_rate = 9600,
                  parameter oversampling = 16,
                  parameter dvsr = clock_rate/(baud_rate * oversampling) )
(
    input wire clk,reset,
    output reg baud_tick
);
reg [9:0]counter;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    baud_tick <= 1'b0;
    counter <= 0;
  end
  else begin
    if(counter == dvsr- 1) begin
        baud_tick <= ~baud_tick;
        counter <= 0;
    end
    else begin
        baud_tick <= 0;
        counter <= counter + 1;
    end
  end
end
endmodule