`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2022 15:26:03
// Design Name: 
// Module Name: variable_clock
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


module variable_clock(
    input CLOCK,
    input [31:0] count,
    output reg changed_CLOCK = 0
    );
    reg [31:0] counter = 0;
    always @ (posedge CLOCK) begin
        counter <= (counter == count) ? 0 : counter+1;
        if (counter == count) begin
            changed_CLOCK <= ~changed_CLOCK;
        end
    end
    
endmodule
