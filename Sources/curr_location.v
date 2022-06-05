`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2022 18:25:47
// Design Name: 
// Module Name: curr_location
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


module curr_location(
    input sw13,
    input [7:0] curr_pixel_x, [7:0] curr_pixel_y,
    input btnL, btnR, btnD, btnU, CLOCK,
    output reg [7:0] next_pixel_x, reg [7:0] next_pixel_y 
    );
    
    reg [31:0] count = 0;
    reg pressed = 0;
    reg [31:0] pressed_count = 0;
    always @(posedge CLOCK) begin
        count <= (count == 999999999) ? 0 : count+1;
        if (pressed)begin
        pressed_count <= (pressed_count == 9999999) ? 0 : pressed_count+1;
        pressed <= (pressed_count == 9999999) ? 0 : pressed;
        end
        if (btnL & !pressed & !sw13) begin
            pressed <= 1;
            next_pixel_y <= curr_pixel_y;
            if (curr_pixel_x == 0)
                next_pixel_x <= 0;
            else 
                next_pixel_x <= curr_pixel_x - 1;
         end
         else if (btnR & !pressed & !sw13) begin
            pressed <= 1;
            next_pixel_y <= curr_pixel_y;
            if (curr_pixel_x == 94)
                next_pixel_x <= 94;
            else 
                next_pixel_x <= curr_pixel_x + 1;
         end
         else if (btnU & !pressed & !sw13) begin
            pressed <= 1;
            next_pixel_x <= curr_pixel_x;
            if (curr_pixel_y == 0)
                next_pixel_y <= 0;
            else
                next_pixel_y <= curr_pixel_y - 1;
         end
         else if (btnD & !pressed & !sw13) begin
            pressed <= 1;
            next_pixel_x <= curr_pixel_x;
            if (curr_pixel_y == 62)
                next_pixel_y <= 62;
            else
                next_pixel_y <= curr_pixel_y + 1;
         end
         else begin
            next_pixel_y <= curr_pixel_y;
            next_pixel_x <= curr_pixel_x;
         end
    end
    
endmodule
