`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2022 00:10:17
// Design Name: 
// Module Name: BRAM_curr_DUAL
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

module BRAM_curr_DUAL (a_clk, a_addr, a_read_write, a_clear, a_data_in, a_data_out,
                   b_clk, b_addr, b_read_write, b_clear, b_data_in, b_data_out);
parameter n = 13;
parameter w = 16;

input a_clk, a_read_write, a_clear, b_clk, b_read_write, b_clear;
input [n-1:0] a_addr, b_addr;
input [w-1:0] a_data_in, b_data_in;
output reg [w-1:0] a_data_out, b_data_out;

// Start module here!
reg [w-1:0] reg_array [2**n-1:0];

integer i;
initial begin
    for( i = 0; i < 2**n; i = i + 1 ) begin
        reg_array[i] <= 16'b0000011111100000;
    end
end

always @(posedge(a_clk)) begin
    if( a_read_write == 1 && b_read_write == 0)
        reg_array[a_addr] <= a_data_in;
    //if( clear == 1 ) begin
        //for( i = 0; i < 2**n; i = i + 1 ) begin
            //reg_array[i] <= 0;
        //end
    //end
    a_data_out = reg_array[a_addr];
end

always @(posedge(b_clk)) begin
    if( b_read_write == 1 && a_read_write == 0)
        reg_array[b_addr] <= b_data_in;
    //if( clear == 1 ) begin
        //for( i = 0; i < 2**n; i = i + 1 ) begin
            //reg_array[i] <= 0;
        //end
    //end
    b_data_out = reg_array[b_addr];
end

endmodule