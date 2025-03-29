`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 14:29:21
// Design Name: 
// Module Name: Baud_rate_gen_tb
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


module Baud_rate_gen_tb;
reg clk,reset;
wire baud_tick;

parameter clock_rate = 50_000_000 ; 
parameter baud_rate = 115200;
parameter oversampling = 16;
parameter dvsr = clock_rate/(baud_rate * oversampling);

integer tick_count,cycle_count;

BAUD_GEN #( .clock_rate(clock_rate), 
            .baud_rate(baud_rate), 
            .oversampling(oversampling), 
            .dvsr(dvsr))
        lut(.clk(clk), 
            .reset(reset),
            .baud_tick(baud_tick) );

initial begin
    clk = 0;
    forever #10 clk = ~clk;     // frequency = 50MHz and T = 20ns
end

initial begin
    $dumpfile("BRG.vcd");
    $dumpvars(0,BRG_tb);
    $monitor($time, " | clk = %b | rst = %b | baud_tick = %b ",clk,reset,baud_tick);

    clk = 0;
    reset = 1;
    tick_count = 0;
    cycle_count = 0;

    #50 reset = 0;
    
    repeat(10000) begin
        @(posedge clk) 
            cycle_count = cycle_count+1;

        if(baud_tick)
            tick_count = tick_count +1;
        end

    $display("Total Cycles = %0d", cycle_count);
    $display("Total Baud Ticks = %0d", tick_count);
    $display("Expected DVSr = %0d", dvsr);

    $finish;
end
endmodule
