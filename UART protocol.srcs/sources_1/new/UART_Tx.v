`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 14:49:34
// Design Name: 
// Module Name: UART_Tx
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


module UART_Tx(
    input wire clk,reset,
    input wire send,wr_en,
    input wire [7:0]data_in,

    output reg data_tx, active_flag, done_flag
);

wire [7:0] fifo_data_out;
wire fifo_empty,fifo_full;
wire baud_clk_w1,baud_clk_w2;
wire parity_w;
wire data_tx_internal;
wire active_flag_internal;
wire done_flag_internal;


Baud_rate_gen brg(
    .clk(clk),
    .reset(reset),
    .baud_tick(baud_clk_w1)
);

Baud_divider brg_divider(
    .reset(reset),
    .baud_tick(baud_clk_w1),
    .baud_clk(baud_clk_w2)
);

Parity parity_gen(
    .reset(reset),
    .data_in(fifo_data_out),
    .parity_bit(parity_w)
);

FIFO fifo_reg(
    .clk(clk),
    .reset(reset),
    .wr_en(wr_en),
    .data_in(data_in),
    .data_out(fifo_data_out),
    .empty(fifo_empty),
    .full(fifo_full)
);

PISO piso_reg(
    .reset(reset),
    .send(send),
    .baud_clk(baud_clk_w2),
    .parity_bit(parity_w),
    .data_in(fifo_data_out),
    .data_tx(data_tx_internal),
    .active_flag(active_flag_internal),
    .done_flag(done_flag_internal)
);

always @(posedge clk) begin
    data_tx <= data_tx_internal;
    active_flag <= active_flag_internal;
    done_flag <= done_flag_internal;
end


endmodule

