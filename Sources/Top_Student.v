`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M, TUESDAY P.M, WEDNESDAY P.M, THURSDAY A.M., THURSDAY P.M
//
//  STUDENT A NAME: 
//  STUDENT A MATRICULATION NUMBER: 
//
//  STUDENT B NAME: 
//  STUDENT B MATRICULATION NUMBER: 
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
    output [11:0]led,
    input sw0,
    input sw1,
    input sw2,
    input sw3,
    input sw4,
    input sw5,
    input sw6,
    input sw7,
    input sw8,
    input sw9,
    input sw10,
    input sw11,
    input sw12,
    input sw13,
    input sw14,
    input sw15,
    input CLOCK,
    input btnL, btnR, btnC, btnU, btnD,
    output [7:0] JC,
    output [3:0] an,
    output [7:0] seg
    );
    
    //color_parameters
    parameter BLACK = 16'b0;
    parameter WHITE = ~BLACK;
    parameter LIGHT_YELLOW = 16'b11111_111111_10011;    //255, 255, 153 -> 32, 64, 19.125
    parameter YELLOW1 = 16'b11111_111111_01101;      //255, 255, 102 -> 32, 64, 12.75
    parameter DARK_YELLOW = 16'b11001_110011_00000;        //204, 204, 0 -> 25.5, 51, 0
    
    parameter BEIGE = 16'b1111111011010011;
    parameter ORANGE = 16'b11111_101010_00110;
    parameter BROWN = 16'b11000_010010_00000;
    parameter RED = 16'b11111_000000_00000;
    parameter PURPLE = 16'b11001_011010_11101;
    parameter TURQUOISE = 16'b00010_110000_11001;
    parameter BLUE = 16'b00101_011010_11000;
    parameter GREEN = 16'b00001_100100_01010;
    parameter LIGHT_GREEN = 16'b01110_110100_00111;
    parameter YELLOW = 16'b11111_111110_01011;
    parameter DARK_GREY = 16'b01111_11110_01111;
    parameter GREY = 16'b11000_110000_11000;
    
    parameter NEON_GREEN = 16'b00111_111111_00010;
    
    
    wire clk1h;
    wire clk20k;
    wire clk10;
    wire clk1;
    wire clk1min;
    wire clk100;
    wire clk6p25m;
    wire [15:0] oled_data;
    wire [12:0] pix_index;
    wire [11:0] mic_in;
    wire frame_begin;
    wire sending_pixels;
    wire sample_pixel;
    wire [2:0] level;
    wire [7:0] curr_pixel_x; wire [7:0] curr_pixel_y;
    wire changed;
    wire [15:0] color_output;
    wire [15:0] placeholder_draw;
    wire [15:0] placeholder;
    wire [15:0] cursor_data;
    wire [15:0] play_data;
    wire [15:0] menu_oled_data;
    wire [15:0] test_oled_data;
    wire [3:0] state;
    wire [3:0] chosen_state;
    wire read_write;
    wire [15:0] fakescilloscope_oled;
    wire [15:0] AVL_oled_data;
    wire fakescilloscope;
    wire [11:0] mic_in_slowed;
    wire [2:0] level_holder;
    wire [5:0] histo_level;
    wire read_write_draw;
    wire [15:0] desert_out;
    wire [15:0] oasis_out;
    wire [15:0] sakuratree_out;
    wire [15:0] background_data;
    wire [31:0] interval;
    wire [1:0] scene;
    assign read_write = sw10 ? 1 : read_write_draw;
    assign placeholder = sw10 ? fakescilloscope_oled : placeholder_draw;
    assign level_holder = (sw11) ? 5 : level;
    assign chosen_state = (sw14) ? state : 15;
    assign oled_data = (!sw12 && sw0 && scene == 0) ? sakuratree_out: 
                       (!sw12 && sw0 && scene == 1) ? oasis_out:
                       (!sw12 && sw0 && scene == 2) ? desert_out:
                       (sw7 & sw6) ? sakuratree_out:
                       (sw7) ? oasis_out:
                       (sw6) ? desert_out:
                       (sw12) ? AVL_oled_data :
                       (chosen_state == 15 || chosen_state == 6 || chosen_state == 7 || chosen_state == 8) ? menu_oled_data :
                       (chosen_state == 0 || chosen_state == 1 || chosen_state == 2) ? ((curr_pixel_x+curr_pixel_y*96 == pix_index || (curr_pixel_x+1)+curr_pixel_y*96 == pix_index || curr_pixel_x+(curr_pixel_y+1)*96 == pix_index || ((curr_pixel_x+1)+(curr_pixel_y+1)*96 == pix_index)) ? ((sw13) ? placeholder : cursor_data) : ((sw13) ? placeholder : color_output))  :
                       (chosen_state == 3 || chosen_state == 4 || chosen_state == 5) ? play_data: 0; 
    
    
    //assign oled_data = (sw3) ? play_data : (sw4) ? test_oled_data : (sw0) ? ((curr_pixel_x+curr_pixel_y*96 == pix_index || (curr_pixel_x+1)+curr_pixel_y*96 == pix_index || curr_pixel_x+(curr_pixel_y+1)*96 == pix_index || ((curr_pixel_x+1)+(curr_pixel_y+1)*96 == pix_index)) ? cursor_data : color_output) : menu_oled_data;
    variable_clock clk6p25MHz(CLOCK, 7, clk6p25m);
    //clock_6p25MHz (CLOCK, clk6p25m);
    Audio_Capture AC (.CLK(CLOCK), .cs(clk20k), .MISO(J_MIC3_Pin3), .clk_samp(J_MIC3_Pin1), .sclk(J_MIC3_Pin4), .sample(mic_in));
    Oled_Display OD (.clk(clk6p25m), .reset(0), .pixel_data(oled_data), .cs(JC[0]), .sdin(JC[1]), .sclk(JC[3]),.d_cn(JC[4]), .resn(JC[5]), .vccen(JC[6]), .pmoden(JC[7]), .pixel_index(pix_index), .frame_begin(frame_begin), .sending_pixels(sending_pixels), .sample_pixel(sample_pixel)); 
    getmaxvalue(.mic_in(mic_in), .CLOCK(clk20k), .level(level));
    AVL (.level(level), .CLOCK(CLOCK), .led(led[4:0]), .an(an[0]), .seg(seg));
    AVL_led_display(.mic_in(mic_in), .level(level_holder), .CLOCK(CLOCK), .pixel_index(pix_index), .oled_data(AVL_oled_data), .sw9(sw9), .sw10(sw10), .sw0(sw0));
    draw d (btnC, btnL, btnR,sw1,sw2,sw13, sw14, sw15, color_output, pix_index, curr_pixel_x, curr_pixel_y, CLOCK, placeholder_draw, cursor_data, read_write_draw, background_data, sw6, sw7);
    //pen p(curr_pixel_colour, pix_index, curr_pixel_x, curr_pixel_y, CLOCK, oled_data);
    curr_location cl (sw13, curr_pixel_x, curr_pixel_y, btnL, btnR, btnD, btnU, CLOCK, curr_pixel_x, curr_pixel_y);
    BRAM_test curr_image(.clk(CLOCK),.addr(pix_index),.read_write(read_write),.clear(0),.data_in(placeholder),.data_out(color_output));
    save_and_compress_frames plswork(clk6p25m, pix_index, sw3, frame_begin, sw4, sw5, color_output, play_data, test_oled_data, chosen_state);   
    menu menu_screen(pix_index, CLOCK, btnU, btnD, btnR, btnL, menu_oled_data, state, sw14);
    //variable_clock clk10Hz(CLOCK,9999999, clk10);
    variable_clock clk20kHz(CLOCK,2499,clk20k); 
    variable_clock clk1s(CLOCK, 49999999, clk1);
    variable_clock clk1hr(clk1, 1799, clk1h);
    variable_clock clk1minute(clk1, 29, clk1min);
    getmaxvalue_64_levels histogram(.mic_in(mic_in), .CLOCK(clk20k), .level(histo_level));
    assign interval = sw1 ? 9 : 3599;
    
    desert_to_sakura(clk1, histo_level, interval, scene, sw1);  
    //fakeautodrawaudiowavebecauseicannotdofft fakescilloscope1(histo_level, pix_index, 16'b1111100000000000, fakescilloscope_oled, CLOCK, clk10);    
    assign background_data = (sw6 & sw7) ? sakuratree_out : (sw6) ? desert_out : oasis_out;
    BRAM_desert desert(CLOCK, pix_index, 0, 0, 0, desert_out);
    BRAM_oasis oasis(CLOCK, pix_index, 0, 0, 0, oasis_out);
    BRAM_sakuratree sakuratree(CLOCK, pix_index,0,0,0,sakuratree_out);
    
    

endmodule