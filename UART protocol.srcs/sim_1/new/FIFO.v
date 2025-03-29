`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 14:35:26
// Design Name: 
// Module Name: FIFO
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

module FIFO(
    input clk, reset, wr_en, rd_en,
    input [width-1:0] data_in,
    output reg [width-1:0] data_out,
    output reg empty,full,
    output reg [4:0] fifo_counter
);

parameter DEPTH = 16 ;      // 16 bytes
parameter width = 8 ;       //8 bits
parameter ptr_size = 4;     //pointer size (address) 5

reg [width-1:0] fifo_mem [0:DEPTH-1];
reg [ptr_size-1:0] wr_ptr,rd_ptr;

//status flag
always @(posedge clk or posedge reset) begin
    if(reset) begin
        empty <= 1;
        full <= 0;
    end 
    else begin 
        empty <= (fifo_counter == 0) ;
        full <= (fifo_counter == DEPTH-1);
    end
end

// fifo_counter flag
always @(posedge clk or posedge reset) begin
    if(reset)
        fifo_counter <= 0;
    else if((!full && wr_en) && (!empty && rd_en))
        fifo_counter <= fifo_counter;
    else if(!full && wr_en)
        fifo_counter <= fifo_counter + 1;
    else if (rd_en && fifo_counter > 0 && !(wr_en && !full))
    fifo_counter <= fifo_counter - 1;
else if (wr_en && fifo_counter < DEPTH && !(rd_en && !empty))
    fifo_counter <= fifo_counter + 1;

end

// read data
always @(posedge clk or posedge reset) begin
    if(reset)
        data_out <= 0;
    else begin
        if(!empty && rd_en)
            data_out <= fifo_mem[rd_ptr];
        else 
            data_out <= 0;
    end
end

// write data
always @(posedge clk) begin
    if(reset)
        fifo_mem[wr_ptr] <= 0;
    else begin
    if(wr_en && !full)
        fifo_mem[wr_ptr] <= data_in;
    else 
        fifo_mem[wr_ptr] <= fifo_mem[wr_ptr];
    end
end

//control pointers
always @(posedge clk or posedge reset) begin
    if (reset) begin
        wr_ptr <= 0;
        rd_ptr <= 0;
    end
    else begin 
        if(!full && wr_en)
            wr_ptr <= wr_ptr + 1;
        else 
            wr_ptr <= wr_ptr;
            
        if(!empty && rd_en)
            rd_ptr <= rd_ptr + 1;
        else 
            rd_ptr <= rd_ptr;
    end
end  
endmodule