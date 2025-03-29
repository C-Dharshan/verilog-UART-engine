`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 15:09:56
// Design Name: 
// Module Name: FIFO_tb
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

module FIFO_tb ;
parameter DEPTH = 16 ;      // 16 bytes
parameter width = 8 ;       //8 bits
parameter ptr_size = 4;     //pointer size (address) 5


reg  clk, rst, wr_en, rd_en;
reg [width-1:0] data_in;
wire [width-1:0] data_out;
wire [4:0] fifo_counter;
wire buf_empty, buf_full;

FIFO register(
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .fifo_counter(fifo_counter),
    .empty(buf_empty),
    .full(buf_full)
);

always #5 clk = ~clk ;

initial begin
$dumpfile("fifo.vcd");
$dumpvars(0,FIFO_tb);
$monitor("Time = %t | clk = %b |reset = %b | wr_en = %b | rd_en = %b | data_in = %d | data_out = %d | fifo_counter = %b | buf_empty = %b | buf_full = %b ", $time, clk, rst, wr_en, rd_en, data_in, data_out, fifo_counter, buf_empty, buf_full );

clk = 1;
rst = 1;
wr_en = 0;
rd_en = 0;
data_in = 0;
#10 rst = 0;

repeat(16) begin
    @(posedge clk) ;
    $monitor($time," | clk = %b | rst = %b | data_in = %d | wr_en = %b | rd_en = %b | data_out = %d | counter =%d | full = %b",clk,rst,data_in,wr_en,rd_en,data_out,fifo_counter,buf_full) ;
    wr_en = 1;
    data_in = ($random & 8'hFF); 
end
    wr_en = 0;

repeat(17) begin
    @(posedge clk) ;
    $monitor($time," | clk = %b | rst = %b | data_in = %d | wr_en = %b | rd_en = %b | data_out = %d | counter = %d| empty = %b",clk,rst,data_in,wr_en,rd_en,data_out,fifo_counter,buf_empty) ;
    rd_en = 1;
    data_in = 0;
end
    rd_en = 0;
 $finish;

end
endmodule
