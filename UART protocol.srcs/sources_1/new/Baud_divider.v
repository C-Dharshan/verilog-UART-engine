`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 14:32:28
// Design Name: 
// Module Name: Baud_divider
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

//Baud divider divides baud clock by 16 

module Baud_divider(
    input baud_tick,reset,
    output reg baud_clk
);

reg [3:0] count;

always @(posedge baud_tick or posedge reset) begin
    if(reset) begin
        count <= 4'd0;
        baud_clk <= 1'b0;
    end
    else begin
        if(count == 4'd15)begin
            baud_clk <= 1'b1;
            count <= 1'b0;
        end
        else begin
            count <= count + 1;
            baud_clk <= 1'b0;
        end
    end
end
endmodule

