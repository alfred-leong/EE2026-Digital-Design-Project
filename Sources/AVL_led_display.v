`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2022 11:35:53
// Design Name: 
// Module Name: AVL_led_display
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


module AVL_led_display(
    input [11:0] mic_in,
    input [2:0]level,
    input sw0,
    input sw10,
    input sw9,
    input CLOCK,
    input [12:0] pixel_index,
    output reg [15:0] oled_data
    );
    
    wire [7:0] x = pixel_index % 96;
    wire [7:0] y = pixel_index / 96;
    always @(posedge CLOCK) begin
    if (level == 0) begin  //level 0, show black screen
        oled_data <= 0;
    end
    else if (level <= 2) begin  //level 1 and 2, show green
        if (x >= 17 && x < 78) begin
            if (y >= 13 && y < 51) 
                oled_data <= {5'b00000, 6'b111111, 5'b00000};
        end
         
        else begin
        if (x == 0 || x == 95 || y == 0 || y == 63)
             oled_data <= 16'b00000_111111_00000;
        else
             oled_data <= 16'b00000_000000_00000;
        end
    end               
    else if (level <= 4) begin  //level 3 and 4, show green + orange
        if (x >= 17 && x < 78) begin
            if (y == 3 || y == 60) begin
                oled_data <= 16'b11111_110000_00000;
            end else if (y == 0 || y == 63) begin
                oled_data <= 16'b00000_111111_00000;
            end
            else if (y >= 20 && y < 44)
                oled_data <= {5'b11111, 6'b110000, 5'b00000};
            else if (y >= 13 && y < 51) 
                oled_data <= {5'b00000, 6'b111111, 5'b00000};
            else
                oled_data <= 0;
        end
        else begin
        if ((x == 3 && y >= 3 && y <= 60) || (x == 92 && y >= 3 && y <= 60) || (y == 3 && x >= 3 && x <= 92) || (y == 60 && x >= 3 && x <= 92))
            oled_data <= 16'b11111_110000_00000;
        else if (x == 0 || x == 95 || y == 0 || y == 63)
            oled_data <= 16'b00000_111111_00000;
        else
            oled_data <= 16'b00000_000000_00000;
        end
    end
    else if (level == 5) begin  //level 5, show green + orange + red
        if (sw0) begin
            if (x >= 17 && x < 78) begin
                 if (y == 3 || y == 60) begin
                     oled_data <= 16'b11111_110000_00000;
                 end else if (y == 0 || y == 63) begin
                     oled_data <= 16'b00000_111111_00000;
                 end else if ((y >= 7 && y <= 9) || (y >= 54 && y <= 56)) begin
                     oled_data <= 16'b11111_000000_00000;
                 end
            else if (y >= 27 && y < 37) 
                oled_data <= {5'b11111, 6'b000000, 5'b00000};
            else if (y >= 20 && y < 44 && !sw9)
                oled_data <= {5'b11111, 6'b110000, 5'b00000};
            else if (y >= 13 && y < 51)
                oled_data <= {5'b000000, 6'b111111, 5'b00000};
            else 
                oled_data <= 0;         
        end else
        if ((x == 3 && y >= 3 && y <= 60) || (x == 92 && y >= 3 && y <= 60) || (y == 3 && x >= 3 && x <= 92) || (y == 60 && x >= 3 && x <= 92))
            oled_data <= 16'b11111_110000_00000;
        else if (x == 0 || x == 95 || y == 0 || y == 63)
            oled_data <= 16'b00000_111111_00000;
        else if ( (x >= 7 && x <= 9 && y >= 7 && y <= 56) || (x >= 86 && x <= 88 && y>=7 && y <= 56) || (x >= 7 && x <= 88 && y >= 7 && y <= 9) || (x >= 7 && x <= 88 && y >= 54 && y <= 56))
            oled_data <= 16'b11111_000000_00000;
        else
            oled_data <= 16'b00000_000000_00000;
            end
            if (!sw0)begin
                if (x >= 17 && x < 78) begin
                    if (!sw10)begin
                       if (y == 3 || y == 60) begin
                            oled_data <= 16'b11111_110000_00000;
                       end else if (y == 0 || y == 63) begin
                            oled_data <= 16'b00000_111111_00000;
                       end else if ((y >= 7 && y <= 9) || (y >= 54 && y <= 56)) begin
                            oled_data <= 16'b11111_000000_00000;
                       end
                    end
                    if (y >= 27 && y < 37) 
                       oled_data <= {5'b11111, 6'b000000, 5'b00000};
                    else if (y >= 20 && y < 44 && !sw9)
                       oled_data <= {5'b11111, 6'b110000, 5'b00000};
                    else if (y >= 13 && y < 51)
                       oled_data <= {5'b000000, 6'b111111, 5'b00000};
                    else 
                        oled_data <= 0;         
                    end
                    else if (sw10)begin
                        oled_data <= 0;
                    end
                    if (!sw10)begin
                        if ((x == 3 && y >= 3 && y <= 60) || (x == 92 && y >= 3 && y <= 60) || (y == 3 && x >= 3 && x <= 92) || (y == 60 && x >= 3 && x <= 92))
                            oled_data <= 16'b11111_110000_00000;
                        else if (x == 0 || x == 95 || y == 0 || y == 63)
                            oled_data <= 16'b00000_111111_00000;
                        else if ( (x >= 7 && x <= 9 && y >= 7 && y <= 56) || (x >= 86 && x <= 88 && y>=7 && y <= 56) || (x >= 7 && x <= 88 && y >= 7 && y <= 9) || (x >= 7 && x <= 88 && y >= 54 && y <= 56))
                            oled_data <= 16'b11111_000000_00000;
                        else
                            oled_data <= 16'b00000_000000_00000;
                    end
                end
        end 
    end
endmodule