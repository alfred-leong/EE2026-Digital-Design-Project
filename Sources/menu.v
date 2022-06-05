`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2022 18:47:29
// Design Name: 
// Module Name: menu
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

parameter BLACK = 16'b0;
parameter WHITE = ~BLACK;
parameter LIGHT_YELLOW = 16'b11111_111111_10011;    //255, 255, 153 -> 32, 64, 19.125
parameter YELLOW = 16'b11111_111111_01101;      //255, 255, 102 -> 32, 64, 12.75
parameter DARK_YELLOW = 16'b11001_110011_00000;        //204, 204, 0 -> 25.5, 51, 0

module menu(
    input [12:0] pixel_index,
    input CLOCK,
    btnU, btnD, btnR, btnL,
    output reg [15:0] oled_data,
    output reg [3:0] state = 0,
    input sw14
    );
    
    wire [7:0] x = pixel_index % 96;
    wire [7:0] y = pixel_index / 96;
    
    wire [15:0] menudisplay[0:8];
   
    wire menu, draw, watch, speed;
    wire onetimes, twotimes, halftimes;
    wire M, E, N, U;
    wire d1, r, a1, w1, w2, a2, t, c, h, s, p, e1, e2, d2, colon;
    wire one, times1, two, zero, point, five, times2;
    
    wire star1, star2, star3;
    wire star1_black, star1_lightyellow, star1_yellow, star1_darkyellow;
    wire star2_black, star2_lightyellow, star2_yellow, star2_darkyellow;
    wire star3_black, star3_lightyellow, star3_yellow, star3_darkyellow;  
    
    wire black, lightyellow, yellow, darkyellow;  
    
    assign menudisplay[0] = (menu || draw || watch || speed || onetimes || star1);
    assign menudisplay[1] = (menu || draw || watch || speed || twotimes || star1);
    assign menudisplay[2] = (menu || draw || watch || speed || halftimes || star1);
    
    assign menudisplay[3] = (menu || draw || watch || speed || onetimes || star2);
    assign menudisplay[4] = (menu || draw || watch || speed || twotimes || star2);
    assign menudisplay[5] = (menu || draw || watch || speed || halftimes || star2);
    
    assign menudisplay[6] = (menu || draw || watch || speed || onetimes || star3);
    assign menudisplay[7] = (menu || draw || watch || speed || twotimes || star3);
    assign menudisplay[8] = (menu || draw || watch || speed || halftimes || star3);
   
    assign black = (menu || draw || watch || speed || onetimes || star1_black || star2_black || star3_black ||
                    twotimes || halftimes);
    assign lightyellow = star1_lightyellow || star2_lightyellow || star3_lightyellow;
    assign yellow = star1_yellow || star2_yellow || star3_yellow;
    assign darkyellow = star1_darkyellow || star2_darkyellow || star3_darkyellow;                   
   
    assign star1 = star1_black || star1_lightyellow || star1_yellow || star1_darkyellow;
    assign star2 = star2_black || star2_lightyellow || star2_yellow || star2_darkyellow;
    assign star3 = star3_black || star3_lightyellow || star3_yellow || star3_darkyellow;
    
    assign menu = M || E || N || U;
    assign draw = (d1 || r || a1 || w1);
    assign watch = (w2 || a2 || t || c || h);
    assign speed = (s || p || e1 || e2 || d2 || colon);
    assign onetimes = (one || times1);
    assign twotimes = (two || times1);
    assign halftimes = (zero || point || five || times2);
    
    assign star1_black = (x >= 20 && x <= 21 && y == 25) || (x == 19 && y == 26) || (x == 22 && y == 26) ||
                         (x >= 17 && x <= 19 && y == 27) || (x >= 22 && x <= 24 && y == 27) ||
                         (x == 16 && y == 28) || (x == 17 && y == 29) || (x == 18 && y == 30) ||
                         (x == 25 && y == 28) || (x == 24 && y == 29) || (x == 23 && y == 30) || 
                         (x == 17 && y >= 31 && y <= 32) || (x == 24 && y >= 31 && y <= 32) || 
                         (x >= 18 && x <= 19 && y == 33) || (x >= 22 && x <= 23 && y == 33) ||
                         (x >= 20 && x <= 21 && y == 32);
    assign star1_lightyellow = (x >= 20 && x <= 21 && y >= 26 && y <= 27) || (x >= 17 && x <= 24 && y == 28) ||
                               (x >= 18 && x <= 20 && y == 29) || (x == 19 && y == 30) || (x == 18 && y == 31);
    assign star1_yellow = (x == 21 && y == 29) || (x == 20 && y == 30) || (x == 19 && y == 31) || (x == 18 && y == 32) ||
                          (x == 23 && y == 29) || (x == 22 && y == 30) || (x == 23 && y == 31);
    assign star1_darkyellow = (x == 22 && y == 29) || (x == 21 && y == 30) || (x == 19 && y == 32) || 
                              (x >= 20 && x <= 22 && y == 31) || (x >= 22 && x <= 23 && y == 32);
                              
    assign star2_black = (x >= 16 && x <= 17 && y == 37) || (x == 15 && y == 38) || (x == 18 && y == 38) ||
                         (x >= 13 && x <= 15 && y == 39) || (x >= 18 && x <= 20 && y == 39) ||
                         (x == 12 && y == 40) || (x == 13 && y == 41) || (x == 14 && y == 42) ||
                         (x == 21 && y == 40) || (x == 20 && y == 41) || (x == 19 && y == 42) || 
                         (x == 13 && y >= 43 && y <= 44) || (x == 20 && y >= 43 && y <= 44) || 
                         (x >= 14 && x <= 15 && y == 45) || (x >= 18 && x <= 19 && y == 45) ||
                         (x >= 16 && x <= 17 && y == 44);
    assign star2_lightyellow = (x >= 16 && x <= 17 && y >= 38 && y <= 39) || (x >= 13 && x <= 20 && y == 40) ||
                               (x >= 14 && x <= 16 && y == 41) || (x == 15 && y == 42) || (x == 14 && y == 43);
    assign star2_yellow = (x == 17 && y == 41) || (x == 16 && y == 42) || (x == 15 && y == 43) || (x == 14 && y == 44) ||
                          (x == 19 && y == 41) || (x == 18 && y == 42) || (x == 19 && y == 43);
    assign star2_darkyellow = (x == 18 && y == 41) || (x == 17 && y == 42) || (x == 15 && y == 44) || 
                              (x >= 16 && x <= 18 && y == 43) || (x >= 18 && x <= 19 && y == 44);
                              
    assign star3_black = (x >= 7 && x <= 8 && y == 49) || (x == 6 && y == 50) || (x == 9 && y == 50) ||
                         (x >= 4 && x <= 6 && y == 51) || (x >= 9 && x <= 11 && y == 51) ||
                         (x == 3 && y == 52) || (x == 4 && y == 53) || (x == 5 && y == 54) ||
                         (x == 12 && y == 52) || (x == 11 && y == 53) || (x == 10 && y == 54) || 
                         (x == 4 && y >= 55 && y <= 56) || (x == 11 && y >= 55 && y <= 56) || 
                         (x >= 5 && x <= 6 && y == 57) || (x >= 9 && x <= 10 && y == 57) ||
                         (x >= 7 && x <= 8 && y == 56);
    assign star3_lightyellow = (x >= 7 && x <= 8 && y >= 50 && y <= 51) || (x >= 4 && x <= 11 && y == 52) ||
                               (x >= 5 && x <= 7 && y == 53) || (x == 6 && y == 54) || (x == 5 && y == 55);
    assign star3_yellow = (x == 8 && y == 53) || (x == 7 && y == 54) || (x == 6 && y == 55) || (x == 5 && y == 56) ||
                          (x == 10 && y == 53) || (x == 9 && y == 54) || (x == 10 && y == 55);
    assign star3_darkyellow = (x == 9 && y == 53) || (x == 8 && y == 54) || (x == 6 && y == 56) || 
                              (x >= 7 && x <= 9 && y == 55) || (x >= 9 && x <= 10 && y == 56);
    
    wire menu_height;                          
    assign menu_height = (y >= 2 && y <= 17);
    assign M = (x >= 15 && x <= 18 && menu_height) || (x >= 27 && x <= 30 && menu_height) ||
                (x >= 19 && x <= 20 && y >= 4 && y <= 11) || (x >= 25 && x <= 26 && y >= 4 && y <= 11) || 
                (x >= 21 && x <= 24 && y >= 6 && y <= 13);
    assign E = (x >= 35 && x <= 38 && menu_height) || (x >= 39 && x <= 46 && y >= 2 && y <= 5) ||
               (x >= 39 && x <= 46 && y >= 14 && y <= 17) || (x >= 39 && x <= 44 && y >= 8 && y <= 11);
    assign N = (x >= 51 && x <= 54 && menu_height) || (x >= 61 && x <= 64 && menu_height) ||
               (x >= 55 && x <= 56 && y >= 4 && y <= 11) || (x >= 57 && x <= 58 && y >= 6 && y <= 13) || 
               (x >= 59 && x <= 60 && y >= 8 && y <= 13);
    assign U = (x >= 69 && x <= 72 && y >= 2 && y <= 15) || (x >= 77 && x <= 80 && y >= 2 && y <= 15) || 
               (x >= 71 && x <= 78 && y >= 12 && y <= 17);
               
    assign d1 = (x >= 32 && x <= 33 && y >= 26 && y <= 33) || (x >= 34 && x <= 36 && y >= 26 && y <= 27) || 
                (x >= 34 && x <= 35 && y >= 32 && y <= 33) || (x >= 36 && x <= 37 && y >= 27 && y <= 32);
    assign r = (x >= 40 && x <= 41 && y >= 26 && y <= 33) || (x >= 42 && x <= 44 && y >= 26 && y <= 27) || 
               (x >= 44 && x <= 45 && y >= 27 && y <= 29) || (x >= 42 && x <= 44 && y >= 30 && y <= 31) || 
               (x >= 44 && x <= 45 && y >= 31 && y <= 33);
    assign a1 = (x >= 48 && x <= 49 && y >= 28 && y <= 33) || (x >= 49 && x <= 52 && y == 27) || 
                (x >= 50 && x <= 51 && y == 26) || (x >= 52 && x <= 53 && y >= 28 && y <= 33) ||
                (x >= 50 && x <= 51 && y >= 30 && y <= 31);
    assign w1 = (x >= 56 && x <= 57 && y >= 26 && y <= 33) || (x >= 62 && x <= 63 && y >= 26 && y <= 33) || 
                (x == 58 && y >= 29 && y <= 32) || (x == 61 && y >= 29 && y <= 32) || 
                (x >= 59 && x <= 60 && y >= 27 && y <= 31);
    assign w2 = (x >= 28 && x <= 29 && y >= 38 && y <= 45) || (x >= 34 && x <= 35 && y >= 38 && y <= 45) || 
                (x == 30 && y >= 41 && y <= 44) || (x == 33 && y >= 41 && y <= 44) || 
                (x >= 31 && x <= 32 && y >= 39 && y <= 43);
    assign a2 = (x >= 38 && x <= 39 && y >= 40 && y <= 45) || (x >= 42 && x <= 43 && y >= 40 && y <= 45) ||
                (x >= 39 && x <= 42 && y == 39) || (x >= 40 && x <= 41 && y == 38) || (x >= 40 && x <= 41 && y >= 42 && y <= 43);
    assign t = (x >= 46 && x <= 51 && y >= 38 && y <= 39) || (x >= 47 && x <= 50 && y >= 44 && y <= 45) || (x >= 48 && x <= 49 && y >= 40 & y <= 43);
    assign c = (x >= 54 && x <= 55 && y >= 39 && y <= 44) || (x >= 55 && x <= 58 && y >= 38 && y <= 39) || 
               (x >= 58 && x <= 59 && y >= 39 && y <= 40) || (x >= 55 && x <= 58 && y >= 44 && y <= 45) || (x >= 58 && x <= 59 && y >= 43 && y <= 44);
    assign h = (x >= 62 && x <= 63 && y >= 38 && y <= 45) || (x >= 66 && x <= 67 && y >= 38 && y <= 45) ||
               (x >= 64 && x <= 65 && y >= 40 && y <= 41);
    assign s = (x >= 20 && x <= 24 && y >= 50 && y <= 51) || (x >= 19 && x <= 20 && y >= 51 && y <= 53) ||
               (x >= 20 && x <= 23 && y >= 53 && y <= 54) || (x >= 22 && x <= 24 && y >= 54 && y <= 56) || 
               (x >= 19 && x <= 23 && y >= 56 && y <= 57);
    assign p = (x >= 27 && x <= 28 && y >= 50 && y <= 57) || (x >= 29 && x <= 31 && y >= 50 && y <= 51) ||
               (x >= 29 && x <= 31 && y >= 54 && y <= 55) || (x >= 31 && x <= 32 && y >= 51 && y <= 53);
    assign e1 = (x >= 35 && x <= 36 && y >= 50 && y <= 57) || (x >= 37 && x <= 40 && y >= 50 && y <= 51) || 
                (x >= 37 && x <= 39 && y >= 53 && y <= 54) || (x >= 37 && x <= 40 && y >= 56 && y <= 57);
    assign e2 = (x >= 43 && x <= 44 && y >= 50 && y <= 57) || (x >= 45 && x <= 48 && y >= 50 && y <= 51) || 
                (x >= 45 && x <= 47 && y >= 53 && y <= 54) || (x >= 45 && x <= 48 && y >= 56 && y <= 57);
    assign d2 = (x >= 51 && x <= 52 && y >= 50 && y <= 57) || (x >= 53 && x <= 55 && y >= 50 && y <= 51) ||
                (x >= 55 && x <= 56 && y >= 51 && y <= 56) || (x >= 53 && x <= 54 && y >= 56 && y <= 57);
    assign colon = (x == 59 && y == 52) || (x == 59 && y == 55);
    assign one = (x == 66 && y >= 51 && y <= 56) || (x >= 64 && x <= 68 && y == 57) || (x == 65 && y == 52) ||
                 (x == 64 && y == 53);
    assign times1 = (x == 71 && (y == 53 || y == 57)) || (x == 75 && (y == 53 || y == 57)) || (x == 73 && y == 55) || 
                    (x == 72 && (y == 54 || y == 56)) || (x == 74 && (y == 54 || y == 56)) ;
    assign two = (x == 64 && y == 52) || (x >= 65 && x <= 67 && y == 51) || (x == 64 && y >= 56 && y <= 57) ||
                 (x >= 64 && x <= 68 && y == 57) || (x == 68 && y == 52) || (x == 67 && y == 53) || (x == 66 && y == 54) ||
                 (x == 65 && y == 55);
    assign zero = (x >= 65 && x <= 67 && y == 51) || (x >= 65 && x <= 67 && y == 57) ||
                  (x == 64 && y >= 52 && y <= 56) || (x == 68 && y >= 52 && y <= 56);
    assign point = (x == 70 && y == 57);
    assign five = (x >= 72 && x <= 76 && y == 51) || (x == 72 && y >= 52 && y <= 54) ||
                  (x >= 73 && x <= 75 && y == 54) || (x == 76 && y >= 55 && y <= 56) ||
                  (x >= 72 && x <= 75 && y == 57);
    assign times2 = (x == 79 && (y == 53 || y == 57)) || (x == 83 && (y == 53 || y == 57)) || (x == 81 && y == 55) || 
                    (x == 80 && (y == 54 || y == 56)) || (x == 82 && (y == 54 || y == 56));
    
    reg pressed = 0;
    reg [26:0] count = 0;
    
    always @(posedge CLOCK) begin
        if (sw14) begin
        end
        else begin
        if (pressed == 1) begin
            count <= (count == 24999999) ? 0 : count + 1;
            pressed <= (count == 24999999) ? 0 : 1;
        end
        if (btnU && state >= 3 && state <= 8 && pressed == 0) begin
            state <= state - 3;
            pressed <= 1;
        end
        else if (btnD && state >= 0 && state <= 5 && pressed == 0) begin
            state <= state + 3;
            pressed <= 1;
        end
        else if (btnR && state == 6 && pressed == 0) begin
            state <= 7;     //one times -> two times
            pressed <= 1;
        end
        else if (btnR && state == 7 && pressed == 0) begin
            state <= 8;     //two times -> half times
            pressed <= 1;
        end
        else if (btnR && state == 8 && pressed == 0) begin
            state <= 6;     //half times -> one times
            pressed <= 1;
        end
        else if (btnL && state == 6 && pressed == 0) begin
            state <= 8;      //half times <- one times
            pressed <= 1;
        end
        else if (btnL && state == 8 && pressed == 0) begin 
            state <= 7;     //two times <- half times
            pressed <= 1;
        end
        else if (btnL && state == 7 && pressed == 0) begin 
            state <= 6;     //one times <- two times
            pressed <= 1;
        end
        end
    end
    
    always @(*) begin
        if (menudisplay[state]) begin
            if (black)
                oled_data <= BLACK;
            else if (lightyellow)
                oled_data <= LIGHT_YELLOW;
            else if (yellow)
                oled_data <= YELLOW;
            else if (darkyellow)
                oled_data <= DARK_YELLOW;
        end
        else
            oled_data <= WHITE;
    end
endmodule