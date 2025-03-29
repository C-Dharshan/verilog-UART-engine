`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 15:07:08
// Design Name: 
// Module Name: PISO_tb
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


module PISO_tb;
reg reset, send, baud_clk,parity_bit;
reg [7:0] data_in;
wire data_tx,active_flag,done_flag;

piso lut(.reset(reset),.send(send),.baud_clk(baud_clk),.parity_bit(parity_bit),.data_in(data_in),.data_tx(data_tx),.active_flag(active_flag),.done_flag(done_flag));

initial begin
    baud_clk = 0;
    forever #10 baud_clk = ~baud_clk;
end

initial begin
    $dumpfile("piso.vcd");
    $dumpvars(0,piso_tb);
    $monitor($time,"|rst = %b| baud_clk =%b |send = %b| parity_bit = %b | data_in = %h| data_tx = %b | active_flag = %b| done_flag = %b",
                    reset,baud_clk,send,parity_bit,data_in,data_tx,active_flag,done_flag);

    reset = 1;
    send = 0;
    parity_bit =1;
#10 data_in = 8'h85;

#10 reset = 0; send = 1;

#240 $finish;
end 
endmodule

