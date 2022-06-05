`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2022 10:53:33
// Design Name: 
// Module Name: AVL
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


module AVL(
    input [2:0] level,
    input CLOCK,
    output reg [4:0] led,
    output reg an = 0,
    output reg [7:0] seg
    );
    

    always @(posedge CLOCK) begin
        if (level == 0) begin  //level 0
        
        led[4:0] <= 5'b00000;
        seg[7:0] <= 8'b11000000;
        
        end
        else if (level == 1) begin  //level 1
        
        led[4:0] <= 5'b00001;
        seg[7:0] <= 8'b11111001;
        
        end
        else if (level == 2) begin  //level 2
        
        led[4:0] <= 5'b00011;
        seg[7:0] <= 8'b10100100;     
        end
        else if (level == 3) begin  //level 3
        
        led[4:0] <= 5'b00111;
        seg[7:0] <= 8'b10110000;       
        end
        else if (level == 4) begin  //level 4
        
        led[4:0] <= 5'b01111; 
        seg[7:0] <= 8'b10011001;      
        end
        else begin  //level 5

        led[4:0] <= 5'b11111;
        seg[7:0] <= 8'b10010010;                
        end
    end
endmodule
