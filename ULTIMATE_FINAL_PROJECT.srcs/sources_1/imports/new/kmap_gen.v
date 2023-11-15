`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2023 11:50:47 PM
// Design Name: 
// Module Name: kmap_gen
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

// written by Chai Zi Yang A0262349Y

// uses is_one, is_zero, is_line to decide each pixel
// take in allstate and output_gate to plot the out
// take in input_abcd to highlight the row that is selected
module kmap_gen(
    input clock,
    input [3:0]input_abcd,
    input [12:0]pix_pos,
    output reg [15:0]oled_data = 0,
    input [3:0]output_gate, // which gate is the truth table tied to
    input enable,

    input [15:0]allstate_10,
    input [15:0]allstate_11,
    input [15:0]allstate_12,
    input [15:0]allstate_13,

    input [15:0]allstate_20,
    input [15:0]allstate_21,
    input [15:0]allstate_22,
    input [15:0]allstate_23,
    
    input [15:0]allstate_30,
    input [15:0]allstate_31,
    input [15:0]allstate_32,
    input [15:0]allstate_33
    );

    wire [15:0]allstates[3:0][3:0];      // output of [1:0]stage [1:0]gate when input is 1 out of 2^4 possibility, stage 
    
    // set all state field for input ABCD
    assign allstates[0][0] = 16'b1111_1111_0000_0000;  // input A
    assign allstates[0][1] = 16'b1111_0000_1111_0000;  // input B
    assign allstates[0][2] = 16'b1100_1100_1100_1100;  // input C
    assign allstates[0][3] = 16'b1010_1010_1010_1010;  // input D

    assign allstates[1][0] = allstate_10;
    assign allstates[1][1] = allstate_11;
    assign allstates[1][2] = allstate_12;
    assign allstates[1][3] = allstate_13;

    assign allstates[2][0] = allstate_20;
    assign allstates[2][1] = allstate_21;
    assign allstates[2][2] = allstate_22;
    assign allstates[2][3] = allstate_23;

    assign allstates[3][0] = allstate_30;
    assign allstates[3][1] = allstate_31;
    assign allstates[3][2] = allstate_32;
    assign allstates[3][3] = allstate_33;

    // display parameters
    parameter BG_COLOUR = 16'b00000_000000_00000;
    parameter LINE_COLOUR = 16'b10000_000000_11111;
    parameter TEXT_COLOUR = 16'b11111_111111_11111;
    parameter TEXT_HL_COLOUR = 16'b00000_111111_10010;

    parameter KMAP_OFFSET_X = 8;

    parameter FIRST_LINE_X = 16 + KMAP_OFFSET_X;
    parameter LINE_X_INCREMENT = 8;
    parameter NO_OF_LINE_X = 4;

    parameter FIRST_LINE_Y = 11;
    parameter LINE_Y_INCREMENT = 12;
    parameter NO_OF_LINE_Y = 4;

    parameter CHAR_OFFSET_X = 2;
    parameter CHAR_OFFSET_Y = 2;
    parameter CHAR_SPACE_OFFSET_Y = 4+1;

    parameter CHAR_HEADER_OFFSET_X = 6 + KMAP_OFFSET_X;
    parameter CHAR_HEADER_OFFSET_Y = 4;

    parameter CHAR_OUTPUT_OFFSET_Y = 2;

    parameter AB_OFFSET_Y = 7;
    parameter CD_OFFSET_X = 1 + KMAP_OFFSET_X;

    parameter OUTPUT_CHOSEN_OFFSET_X = 1;
    parameter OUTPUT_CHOSEN_OFFSET_Y = 6;

    // for pixel checking
    wire clk25m;    // m = 1
    clock_gen clk25m_gen(.clk_in(clock), .m(1), .clk_out(clk25m));

    // xy
    wire [6:0]curr_x;
    wire [5:0]curr_y;
    cartesian_pixel index_to_xy(.pix_index(pix_pos), .x(curr_x), .y(curr_y));

    // draws the lines, 4 vertical, 4 horizontal
    wire it_is_line;
    assign it_is_line = curr_y == FIRST_LINE_Y || 
                        curr_y == FIRST_LINE_Y + LINE_Y_INCREMENT * 1 ||  
                        curr_y == FIRST_LINE_Y + LINE_Y_INCREMENT * 2 || 
                        curr_y == FIRST_LINE_Y + LINE_Y_INCREMENT * 3 || 
                        curr_x == FIRST_LINE_X || 
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 1 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 2 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 3;

    // AB CD character
    wire [3:0]it_is_header;
    is_a a(
        .x_pos(FIRST_LINE_X - LINE_X_INCREMENT + CHAR_OFFSET_X),
        .y_pos(FIRST_LINE_Y + LINE_Y_INCREMENT * (NO_OF_LINE_Y - 1) + AB_OFFSET_Y + CHAR_SPACE_OFFSET_Y),
        .pix_index(pix_pos),
        .it_do_be_a_a(it_is_header[0])
    );

    is_b b(
        .x_pos(FIRST_LINE_X - LINE_X_INCREMENT + CHAR_OFFSET_X),
        .y_pos(FIRST_LINE_Y + LINE_Y_INCREMENT * (NO_OF_LINE_Y - 1) + AB_OFFSET_Y),
        .pix_index(pix_pos),
        .it_do_be_a_b(it_is_header[1])
    );

    is_c c(
        .x_pos(CD_OFFSET_X),
        .y_pos(FIRST_LINE_Y + LINE_Y_INCREMENT * (NO_OF_LINE_Y - 1) + CHAR_OFFSET_Y + CHAR_SPACE_OFFSET_Y),
        .pix_index(pix_pos),
        .it_do_be_a_c(it_is_header[2])
    );

    is_d d(
        .x_pos(CD_OFFSET_X),
        .y_pos(FIRST_LINE_Y + LINE_Y_INCREMENT * (NO_OF_LINE_Y - 1) + CHAR_OFFSET_Y),
        .pix_index(pix_pos),
        .it_do_be_a_d(it_is_header[3])
    );

    // output chosen
    wire it_is_str_out;
    is_str_out(
        .x_pos(OUTPUT_CHOSEN_OFFSET_X),
        .y_pos(FIRST_LINE_Y + LINE_Y_INCREMENT * 2 + OUTPUT_CHOSEN_OFFSET_Y),
        .pix_index(pix_pos),
        .output_gate(output_gate),
        .it_do_be_str_out(it_is_str_out)
    );

    // Cell character generator
    // uses the same module for 0 and 1 and change the position, this reduces LUT usage significantly
    wire [2:0]curr_row;
    wire [2:0]curr_col;
    wire [6:0]x_one_zero;
    wire [5:0]y_one_zero; 

    // gives current row given the pix index
    assign curr_row = curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 3 ? 4 :           // row 4
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 2 ? 3 :         // row 3
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 1 ? 2 :         // row 2
                        curr_x > FIRST_LINE_X ? 1 :                                // row 1
                        0;                                                         // row 0

    // gives current col given the pix index
    assign curr_col = curr_y > FIRST_LINE_Y + LINE_Y_INCREMENT * 3 ? 4 :          // col 4 
                        curr_y > FIRST_LINE_Y + LINE_Y_INCREMENT * 2 ? 3 :        // col 3 
                        curr_y > FIRST_LINE_Y + LINE_Y_INCREMENT * 1 ? 2 :        // col 2 
                        curr_y > FIRST_LINE_Y ? 1 :                               // col 1
                        0;                                                        // col 0

    // x value for the "1" and "0" based on the row and col
    assign x_one_zero = curr_row == 4 ? FIRST_LINE_X + CHAR_OFFSET_X + LINE_X_INCREMENT * 3 :        // row 4
                        curr_row == 3 ? FIRST_LINE_X + CHAR_OFFSET_X + LINE_X_INCREMENT * 2 :        // row 3
                        curr_row == 2 ? FIRST_LINE_X + CHAR_OFFSET_X + LINE_X_INCREMENT * 1 :        // row 2
                        curr_row == 1 ? FIRST_LINE_X + CHAR_OFFSET_X :                               // row 1
                        CHAR_HEADER_OFFSET_X;                                                        // row 0
    
    // y value for the "1" and "0" based on the row and col, this will give the AB CD corner value, to be get rid of later when selecting "0" or "1"
    assign y_one_zero = curr_col == 4 ? (curr_y >= CHAR_SPACE_OFFSET_Y + CHAR_HEADER_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 3 ? CHAR_SPACE_OFFSET_Y + CHAR_HEADER_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 3 : CHAR_HEADER_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 3) :                                                                                                  // col 4
                        curr_col == 3 ? curr_row == 0 ? (curr_y >= CHAR_SPACE_OFFSET_Y + CHAR_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 2 ? CHAR_SPACE_OFFSET_Y + CHAR_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 2 : CHAR_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 2) : FIRST_LINE_Y + LINE_Y_INCREMENT * 2 + CHAR_OFFSET_Y + CHAR_OUTPUT_OFFSET_Y :     // col 3
                        curr_col == 2 ? curr_row == 0 ? (curr_y >= CHAR_SPACE_OFFSET_Y + CHAR_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 1 ? CHAR_SPACE_OFFSET_Y + CHAR_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 1 : CHAR_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 1) : FIRST_LINE_Y + LINE_Y_INCREMENT * 1 + CHAR_OFFSET_Y + CHAR_OUTPUT_OFFSET_Y :     // col 2
                        curr_col == 1 ? curr_row == 0 ? (curr_y >= CHAR_SPACE_OFFSET_Y + CHAR_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 0 ? CHAR_SPACE_OFFSET_Y + CHAR_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 0 : CHAR_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 0) : FIRST_LINE_Y + LINE_Y_INCREMENT * 0 + CHAR_OFFSET_Y + CHAR_OUTPUT_OFFSET_Y :     // col 1
                        curr_row == 0 ? (curr_y >= CHAR_SPACE_OFFSET_Y + CHAR_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * -1 ? CHAR_SPACE_OFFSET_Y + CHAR_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * -1 : CHAR_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * -1) : FIRST_LINE_Y + LINE_Y_INCREMENT * -1 + CHAR_OFFSET_Y + CHAR_OUTPUT_OFFSET_Y;                  // col 0

    wire it_is_zero;
    wire it_is_one;

    is_one_big oneHEADER_CELL(
        .x_pos(x_one_zero),
        .y_pos(y_one_zero),
        .pix_index(pix_pos),
        .it_do_be_a_one(it_is_one)
    );

    is_zero_big zeroHEADER_CELL(
        .x_pos(x_one_zero),
        .y_pos(y_one_zero),
        .pix_index(pix_pos),
        .it_do_be_a_zero(it_is_zero)
    );

    // this decides to display 1 or 0 based on the col and row, and the output_gate
    wire it_is_number;
    assign it_is_number = curr_col == 4 ? curr_row == 0 ? 0 : 
                                            curr_row == 1 ? it_is_zero : 
                                            curr_row == 2 ? (curr_y >= CHAR_SPACE_OFFSET_Y + CHAR_HEADER_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 3 ? it_is_zero : it_is_one) : 
                                            curr_row == 3 ? it_is_one : 
                                            (curr_y >= CHAR_SPACE_OFFSET_Y + CHAR_HEADER_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 3 ? it_is_one : it_is_zero) :
                            curr_col == 3 ? curr_row == 0 ? it_is_zero : 
                                            curr_row == 1 ? allstates[output_gate[3:2]][output_gate[1:0]][0] ? it_is_one & enable: it_is_zero & enable : 
                                            curr_row == 2 ? allstates[output_gate[3:2]][output_gate[1:0]][4] ? it_is_one & enable : it_is_zero & enable :  
                                            curr_row == 3 ? allstates[output_gate[3:2]][output_gate[1:0]][12] ? it_is_one & enable : it_is_zero & enable :  
                                            allstates[output_gate[3:2]][output_gate[1:0]][8] ? it_is_one & enable : it_is_zero & enable :
                            curr_col == 2 ? curr_row == 0 ? (curr_y >= CHAR_SPACE_OFFSET_Y + CHAR_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * 1 ? it_is_zero : it_is_one) : 
                                            curr_row == 1 ? allstates[output_gate[3:2]][output_gate[1:0]][1] ? it_is_one & enable : it_is_zero & enable : 
                                            curr_row == 2 ? allstates[output_gate[3:2]][output_gate[1:0]][5] ? it_is_one & enable : it_is_zero & enable :  
                                            curr_row == 3 ? allstates[output_gate[3:2]][output_gate[1:0]][13] ? it_is_one & enable : it_is_zero & enable :  
                                            allstates[output_gate[3:2]][output_gate[1:0]][9] ? it_is_one & enable : it_is_zero & enable :
                            curr_col == 1 ? curr_row == 0 ? it_is_one :
                                            curr_row == 1 ? allstates[output_gate[3:2]][output_gate[1:0]][3] ? it_is_one & enable : it_is_zero & enable : 
                                            curr_row == 2 ? allstates[output_gate[3:2]][output_gate[1:0]][7] ? it_is_one & enable : it_is_zero & enable :  
                                            curr_row == 3 ? allstates[output_gate[3:2]][output_gate[1:0]][15] ? it_is_one & enable : it_is_zero & enable :  
                                            allstates[output_gate[3:2]][output_gate[1:0]][11] ? it_is_one & enable : it_is_zero & enable :  
                            curr_row == 0 ? (curr_y >= CHAR_SPACE_OFFSET_Y + CHAR_OFFSET_Y + FIRST_LINE_Y + LINE_Y_INCREMENT * -1 ? it_is_one : it_is_zero) :
                                            curr_row == 1 ? allstates[output_gate[3:2]][output_gate[1:0]][2] ? it_is_one & enable : it_is_zero & enable : 
                                            curr_row == 2 ? allstates[output_gate[3:2]][output_gate[1:0]][6] ? it_is_one & enable : it_is_zero & enable :  
                                            curr_row == 3 ? allstates[output_gate[3:2]][output_gate[1:0]][14] ? it_is_one & enable : it_is_zero & enable :  
                                            allstates[output_gate[3:2]][output_gate[1:0]][10] ? it_is_one & enable : it_is_zero & enable; 

    // colour changer based on selected input
    wire [15:0]text_colour;
    wire [6:0]output_highlight_x;
    wire [5:0]output_highlight_y;
    assign output_highlight_x = input_abcd[3:2] == 2'b00 ? FIRST_LINE_X : 
                                input_abcd[3:2] == 2'b01 ? FIRST_LINE_X + LINE_X_INCREMENT :
                                input_abcd[3:2] == 2'b11 ? FIRST_LINE_X + LINE_X_INCREMENT * 2 : 
                                input_abcd[3:2] == 2'b10 ? FIRST_LINE_X + LINE_X_INCREMENT * 3 :
                                0;  // debug

    assign output_highlight_y = input_abcd[1:0] == 2'b00 ? FIRST_LINE_Y + LINE_Y_INCREMENT * 2 : 
                                input_abcd[1:0] == 2'b01 ? FIRST_LINE_Y + LINE_Y_INCREMENT :
                                input_abcd[1:0] == 2'b11 ? FIRST_LINE_Y : 
                                input_abcd[1:0] == 2'b10 ? 0:
                                0;  // debug

    assign text_colour = (curr_x > output_highlight_x && curr_x < output_highlight_x + LINE_X_INCREMENT && curr_y > FIRST_LINE_Y + LINE_Y_INCREMENT * 3) || // for AB
                        (curr_x >= CHAR_HEADER_OFFSET_X && curr_x < FIRST_LINE_X && curr_y > output_highlight_y && curr_y < output_highlight_y + LINE_Y_INCREMENT) || // for CD
                        (curr_x > output_highlight_x && curr_x < output_highlight_x + LINE_X_INCREMENT && curr_y > output_highlight_y && curr_y < output_highlight_y + LINE_Y_INCREMENT)    // for output
                        ? TEXT_HL_COLOUR : TEXT_COLOUR;
    
    // oled data driver
    always @(posedge clk25m) begin  
        if (it_is_number || it_is_header || it_is_str_out) begin
            oled_data <= text_colour;
        end else if (curr_x > (FIRST_LINE_X + LINE_X_INCREMENT * NO_OF_LINE_X) || curr_x < (KMAP_OFFSET_X)) begin // to clean up line at the top and bottom
            oled_data <= BG_COLOUR;
        end else if (curr_x == 63 - curr_y + KMAP_OFFSET_X && curr_x < FIRST_LINE_X) begin // diagonal line at top left
            oled_data <= LINE_COLOUR;
        end else if (it_is_line) begin
            oled_data <= LINE_COLOUR;
        end else begin
            oled_data <= BG_COLOUR; 
        end
    end
endmodule
