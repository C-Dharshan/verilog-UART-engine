`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 15:11:44
// Design Name: 
// Module Name: BRG_divider_tb
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


module BRG_divider_tb();
    reg baud_tick,reset;
    wire baud_clk;
    
  Baud_divider lut(.baud_tick(baud_tick),.reset(reset),.baud_clk(baud_clk));
  
  initial begin
    baud_tick = 0;
    forever #5 baud_tick = ~baud_tick;
  end
  
  initial begin 
  $monitor($time, " | baud_tick = %b| reset = %b| baud_clk = %b ",baud_tick,reset,baud_clk);
  
  reset = 1;
  #10 reset = 0;
  #100_000 $finish;
  end
  
endmodule

