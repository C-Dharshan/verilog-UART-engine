`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 14:43:17
// Design Name: 
// Module Name: PISO
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

//The transmitter's frame generator and shift register to send data serially 

module PISO(
    input wire reset,send,baud_clk,parity_bit,
    input wire [7:0] data_in,
    output reg data_tx,
    output reg active_flag,done_flag
);

reg [3:0] bit_count;
reg [10:0] frame;
reg state;

localparam IDLE = 1'b0, ACTIVE = 1'b1;

always @(posedge baud_clk or posedge reset) begin
    if(reset) 
        frame <= {11{1'b1}} ;
    else if(send && state == IDLE)
        frame <= {1'b1, parity_bit, data_in, 1'b0} ;
end

always @(posedge baud_clk or posedge reset) begin
    if(reset) begin
        state <= IDLE;
        bit_count <= 4'd0;
        data_tx <= 1'b0;
        active_flag <= 1'b0;
        done_flag <= 1'b0;
    end
    else begin
        case (state) 
        IDLE: begin
            data_tx <= 1'b1;
            active_flag <= 1'b0;
            done_flag <= 1'b0;
            if(send) begin
                state <= ACTIVE;
                bit_count <= 4'd0;
            end
        end
        ACTIVE: begin
            data_tx <= frame[0];
            frame <= {frame[10:1]};
            active_flag <= 1'b1;
            done_flag <= 1'b0;
            bit_count <= bit_count + 1;
            if(bit_count == 4'd10) begin
                state <= IDLE;
                done_flag <= 1'b1;
                active_flag <= 1'b0;
            end
        end
        endcase
    end
end
endmodule

