`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2022 11:13:22
// Design Name: 
// Module Name: getmaxvalue
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


module getmaxvalue(
    input [11:0] mic_in,
    input CLOCK,
    output reg [2:0] level
    );
    
    reg[11:0] current_peak = 0;
    reg[11:0] real_peak = 0;
    reg[11:0] COUNT = 0;
    always @(posedge CLOCK) begin
        COUNT <= (COUNT == 2000) ? 0 : COUNT + 1;
        current_peak <= (COUNT == 2000) ? 0 : current_peak;
        real_peak <= (COUNT == 2000) ? current_peak : real_peak;
        if (mic_in > current_peak)
            current_peak <= mic_in;
            
        if (real_peak < 2389)
            level <= 0;
        else if (real_peak < 2730)
            level <= 1;
        else if (real_peak < 3071)
            level <= 2;
        else if (real_peak < 3412)
            level <= 3;
        else if (real_peak < 3753)
            level <= 4;
        else if (real_peak <= 4095)
            level <= 5;
    end
endmodule
