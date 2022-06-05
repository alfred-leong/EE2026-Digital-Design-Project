`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2022 10:41:29
// Design Name: 
// Module Name: BRAM_test
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


module BRAM_test(clk, addr, read_write, clear, data_in, data_out);
parameter n = 13;
parameter w = 16;

input clk, read_write, clear;
input [n-1:0] addr;
input [w-1:0] data_in;
output reg [w-1:0] data_out;

// Start module here!
reg [w-1:0] reg_array [2**n-1:0];

integer i;
initial begin
    for( i = 0; i < 2**n; i = i + 1 ) begin
        reg_array[i] <= 16'b1111111111111111;
    end
end

always @(posedge(clk)) begin
    if(read_write == 1)
        reg_array[addr] <= data_in;
    data_out = reg_array[addr];
end
endmodule
