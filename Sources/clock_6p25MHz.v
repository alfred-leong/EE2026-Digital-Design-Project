`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2022 17:11:22
// Design Name: 
// Module Name: clock_6p25MHz
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


module clock_6p25MHz(input CLOCK, output reg clock6p25MHz = 0);
    reg[3:0] COUNT = 0;
    
    always @ (posedge CLOCK) begin
        COUNT <= (COUNT == 7) ? 0: COUNT+1;
        clock6p25MHz <= (COUNT == 7) ? ~clock6p25MHz : clock6p25MHz;
    end
endmodule
