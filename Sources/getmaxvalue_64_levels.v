`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2022 16:11:52
// Design Name: 
// Module Name: getmaxvalue_64_levels
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


module getmaxvalue_64_levels(
        input [11:0] mic_in,
        input CLOCK,
        output reg [5:0] level
        );
        integer i;
        reg[11:0] current_peak = 0;
        reg[11:0] real_peak = 0;
        reg[14:0] COUNT = 0;
        always @(posedge CLOCK) begin
            COUNT <= (COUNT == 20000) ? 0 : COUNT + 1;
            current_peak <= (COUNT == 20000) ? 0 : current_peak;
            real_peak <= (COUNT == 20000) ? current_peak : real_peak;
            if (mic_in > current_peak)
                current_peak <= mic_in;
            
            for (i = 64; i > 0; i = i - 1)begin
                if (real_peak < 2048 + 32 * i) begin
                    level <= i-1;
                end
            end
                
//            if (real_peak < 2048+32)
//                level <= 0;
//            else if (real_peak < 2048+32*2)
//                level <= 1;
//            else if (real_peak < 2048+32*3)
//                level <= 2;
//            else if (real_peak < 2048+32*4)
//                level <= 3;
//            else if (real_peak < 2048+32*5)
//                level <= 4;
//            else if (real_peak < 2048*32*6)
//                level <= 5;
//            else if (real_peak < 2048+32*7)
//                level <= 6;
//            else if (real_peak < 2048+32*8)
//                level <= 7;
//            else if (real_peak < 2048+32*9)
//                level <= 8;
//            else if (real_peak < 2048+32*10)
//                level <= 9;
//            else if (real_peak < 2048*32*11)
//                level <= 10;
        end
endmodule
