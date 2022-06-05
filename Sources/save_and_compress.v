`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2022 13:24:15
// Design Name: 
// Module Name: save_and_compress
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


module save_and_compress_frames(
    input CLK,
    input [12:0] pix_index,
    input read,
    input frame_begin,
    input save,
    input clear_last,
    input [15:0] curr_oled_data,
    output [15:0] oled_data,
    output [15:0] test_oled_data,
    input [3:0] chosen_state
    );
    

    reg [12:0] curr_index = 0;
    reg [14:0] write_index = 0;
    reg [14:0] read_index = 1;
    reg [15:0] stored_oled_data = 16'b1111100000011111;
    reg done = 0;
    wire [15:0] retrieved_color, dummy2, dummy3;
    wire [12:0] retrieved_index, dummy1,dummy4;
    reg [31:0] count = 0;
    reg [31:0] new_count = 0;
    reg [15:0] prev_oled_data = 16'b0000011111100000;
    reg [14:0] curr_frame_index = 0;
    reg start_read = 0;
    reg wait_one = 0;
    reg read_write = 0;
    reg [12:0] store_pix_index = 0;
    wire [31:0] interval;
    
    assign interval = (chosen_state == 3) ? 3249999 : (chosen_state == 5) ? 6499999 : (chosen_state == 4) ? 1624999 : 99999999;  
    
    BRAM_pixel store_index(CLK,write_index,start_read,0,curr_index, dummy1, 
                           CLK, read_index,0,   0,0         , retrieved_index);
    BRAM_frames store_color(CLK,write_index,start_read,0,prev_oled_data, dummy2,
                            CLK,read_index, 0,   0,0,              retrieved_color);
    BRAM_curr_DUAL curr_frame(CLK, store_pix_index, read_write, 0 , stored_oled_data, dummy3,
                              CLK, pix_index, 0, 0, 0, oled_data);
    
    //BRAM_curr test_frame(CLK, pix_index, start_read,0,prev_oled_data, test_oled_data);
    
    always @(negedge CLK) begin
        if (clear_last && !save) begin
        write_index <= curr_frame_index;
        end
        if (done) begin
            start_read <= 0;
            prev_oled_data <= 16'b1010101010101001;
            if (!save) begin
                done <= 0;
            end
        end
        else if (save) begin
            if (frame_begin && !done) begin
                start_read <= 1;
                curr_index <= 0;
                prev_oled_data <= curr_oled_data;
                write_index <= write_index+1;
                curr_frame_index <= write_index+1;
            end
            if (start_read) begin
                if (pix_index == 6143)begin
                    done <= 1;
                end
                else if (prev_oled_data != curr_oled_data)begin
                    prev_oled_data <= curr_oled_data;
                    curr_index <= pix_index;
                    write_index <= write_index+1;
                end
            end
        end
        if (chosen_state == 15) begin
            read_index <= 1;
            read_write <= 0;
            store_pix_index <= 0;
            wait_one <= 0;
            count <= 0;
        end
        
        if (chosen_state == 3 || chosen_state == 4 || chosen_state == 5) begin
            store_pix_index <= pix_index;
            if (wait_one) begin
                count <= (count == interval) ? 0 : count + 1;
                if (count == interval) begin
                    wait_one <= 0;
                end
            end
            else if (frame_begin && read_write)begin
                wait_one <= 1;
                read_write <= 0;
            end
            else if (frame_begin && !wait_one) begin
                read_write <= 1;
            end
            else if (pix_index == retrieved_index) begin
                stored_oled_data <= retrieved_color;
                read_index <= (read_index == write_index) ? 1 : read_index + 1;
            end
            end
    end
  
    
endmodule
