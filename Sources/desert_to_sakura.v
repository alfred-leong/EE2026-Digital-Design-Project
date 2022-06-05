`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2022 01:08:21
// Design Name: 
// Module Name: desert_to_sakura
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


module desert_to_sakura(input clk, input [5:0] histo_level, input [31:0] interval, output reg [1:0] scene = 2, input sw1);
    reg [31:0] counter = 0;
    always @(posedge clk)begin
        if (sw1 && counter > 9) begin
            counter <= 0;
        end else begin
        counter <= (counter == interval) ? 0 : counter+1;
        end
        if (counter == interval) begin
        scene <= (scene == 0) ? 0 : scene - 1;
        end
        if (scene == 0 && histo_level > 20) begin
            counter <= 0;
            scene <= 1;
        end
        else if (scene == 1 && histo_level > 40) begin
            counter <= 0;
            scene <= 2;
        end else if (scene == 2 && histo_level > 60) begin
            counter <= 0;
        end
        
    end

endmodule
