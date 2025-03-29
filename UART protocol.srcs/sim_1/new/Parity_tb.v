`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 15:05:49
// Design Name: 
// Module Name: Parity_tb
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


module Parity_tb;
reg reset;
reg [7:0] data_in;
wire parity_bit;

parity lut(.reset(reset),.data_in(data_in),.parity_bit(parity_bit));
initial begin
    $dumpfile("Parity.vcd");
    $dumpvars(0,parity_tb);
    $monitor($time," | reset = %b | data_in = %b | parity = %b ", reset,data_in,parity_bit);
    
    reset = 1;
    data_in = 8'hff;
#10 reset = 0;
#10 data_in = 8'h55;
#10 data_in = 8'h13;
#10 data_in = 8'h21;
#10 data_in = 8'h02;
#10 $finish;

end
endmodule

