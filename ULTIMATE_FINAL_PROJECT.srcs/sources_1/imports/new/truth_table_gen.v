`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2023 06:36:16 PM
// Design Name: 
// Module Name: truth_table_gen
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
module truth_table_gen(
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
    parameter LINE_COLOUR = 16'b11111_111111_00000;
    parameter TEXT_COLOUR = 16'b11111_111111_11111;
    parameter TEXT_HL_COLOUR = 16'b00000_111111_11111;

    parameter FIRST_LINE_X = 8;
    parameter LINE_X_INCREMENT = 5;
    parameter NO_OF_LINE_X = 16;

    parameter FIRST_LINE_Y = 28;
    parameter LINE_Y_INCREMENT = 9;
    parameter NO_OF_LINE_Y = 4;

    parameter CHAR_OFFSET_X = 1;
    parameter CHAR_OFFSET_Y = 4;

    parameter CHAR_OUTPUT_OFFSET_Y = 12;

    parameter HEADER_OFFSET_X = 2;
    parameter HEADER_OFFSET_Y = 3;

    // for pixel checking
    wire clk25m;    // m = 1
    clock_gen clk25m_gen(.clk_in(clock), .m(1), .clk_out(clk25m));
    
    // xy
    wire [6:0]curr_x;
    wire [5:0]curr_y;
    cartesian_pixel index_to_xy(.pix_index(pix_pos), .x(curr_x), .y(curr_y));

    // draws the lines, 4 vertical, 16 horizontal
    wire it_is_line;
    assign it_is_line = curr_y == FIRST_LINE_Y || 
                        curr_y == FIRST_LINE_Y + LINE_Y_INCREMENT * 1 ||  
                        curr_y == FIRST_LINE_Y + LINE_Y_INCREMENT * 2 || 
                        curr_y == FIRST_LINE_Y + LINE_Y_INCREMENT * 3 || 
                        curr_x == FIRST_LINE_X || 
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 1 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 2 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 3 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 4 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 5 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 6 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 7 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 8 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 9 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 10 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 11 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 12 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 13 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 14 ||
                        curr_x == FIRST_LINE_X + LINE_X_INCREMENT * 15;

    // Header character generator
    wire [4:0]it_is_header;
    is_a a(
        .x_pos(HEADER_OFFSET_X),
        .y_pos(HEADER_OFFSET_Y + 3 * LINE_Y_INCREMENT + FIRST_LINE_Y),
        .pix_index(pix_pos),
        .it_do_be_a_a(it_is_header[0])
    );

    is_b b(
        .x_pos(HEADER_OFFSET_X),
        .y_pos(HEADER_OFFSET_Y + 2 * LINE_Y_INCREMENT + FIRST_LINE_Y),
        .pix_index(pix_pos),
        .it_do_be_a_b(it_is_header[1])
    );

    is_c c(
        .x_pos(HEADER_OFFSET_X),
        .y_pos(HEADER_OFFSET_Y + LINE_Y_INCREMENT + FIRST_LINE_Y),
        .pix_index(pix_pos),
        .it_do_be_a_c(it_is_header[2])
    );

    is_d d(
        .x_pos(HEADER_OFFSET_X),
        .y_pos(HEADER_OFFSET_Y + FIRST_LINE_Y),
        .pix_index(pix_pos),
        .it_do_be_a_d(it_is_header[3])
    );

    is_str_out fout(
        .x_pos(HEADER_OFFSET_X),
        .y_pos(HEADER_OFFSET_Y),
        .pix_index(pix_pos),
        .output_gate(output_gate),
        .it_do_be_str_out(it_is_header[4])
    );

    // Cell character generator
    // uses the same module for 0 and 1 and change the position, this reduces LUT usage significantly
    wire [3:0]curr_row;
    wire [2:0]curr_col;
    wire [6:0]x_one_zero;
    wire [5:0]y_one_zero; 

    // gives current row given the pix index
    assign curr_row = curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 15 ? 15 :         // row 15
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 14 ? 14 :       // row 14
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 13 ? 13 :       // row 13
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 12 ? 12 :       // row 12
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 11 ? 11 :       // row 11
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 10 ? 10 :       // row 10
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 9 ? 9 :         // row 9
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 8 ? 8 :         // row 8
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 7 ? 7 :         // row 7
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 6 ? 6 :         // row 6
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 5 ? 5 :         // row 5
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 4 ? 4 :         // row 4
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 3 ? 3 :         // row 3
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 2 ? 2 :         // row 2
                        curr_x > FIRST_LINE_X + LINE_X_INCREMENT * 1 ? 1 :         // row 1
                        0;                                                         // row 0

    // gives current col given the pix index
    assign curr_col = curr_y > FIRST_LINE_Y + LINE_Y_INCREMENT * 3 ? 4 :          // column A, col 4 
                        curr_y > FIRST_LINE_Y + LINE_Y_INCREMENT * 2 ? 3 :        // column B, col 3 
                        curr_y > FIRST_LINE_Y + LINE_Y_INCREMENT * 1 ? 2 :        // column C, col 2 
                        curr_y > FIRST_LINE_Y ? 1 :                               // column D, col 1
                        0;                                                        // column out, col 0

    // x value for the "1" and "0" based on the row and col
    assign x_one_zero = curr_row == 15 ? FIRST_LINE_X + LINE_X_INCREMENT * 15 + CHAR_OFFSET_X :      // row 15
                        curr_row == 14 ? FIRST_LINE_X + LINE_X_INCREMENT * 14 + CHAR_OFFSET_X :      // row 14
                        curr_row == 13 ? FIRST_LINE_X + LINE_X_INCREMENT * 13 + CHAR_OFFSET_X :      // row 13
                        curr_row == 12 ? FIRST_LINE_X + LINE_X_INCREMENT * 12 + CHAR_OFFSET_X :      // row 12
                        curr_row == 11 ? FIRST_LINE_X + LINE_X_INCREMENT * 11 + CHAR_OFFSET_X :      // row 11
                        curr_row == 10 ? FIRST_LINE_X + LINE_X_INCREMENT * 10 + CHAR_OFFSET_X :      // row 10
                        curr_row == 9 ? FIRST_LINE_X + LINE_X_INCREMENT * 9 + CHAR_OFFSET_X :        // row 9
                        curr_row == 8 ? FIRST_LINE_X + LINE_X_INCREMENT * 8 + CHAR_OFFSET_X :        // row 8
                        curr_row == 7 ? FIRST_LINE_X + LINE_X_INCREMENT * 7 + CHAR_OFFSET_X :        // row 7
                        curr_row == 6 ? FIRST_LINE_X + LINE_X_INCREMENT * 6 + CHAR_OFFSET_X :        // row 6
                        curr_row == 5 ? FIRST_LINE_X + LINE_X_INCREMENT * 5 + CHAR_OFFSET_X :        // row 5
                        curr_row == 4 ? FIRST_LINE_X + LINE_X_INCREMENT * 4 + CHAR_OFFSET_X :        // row 4
                        curr_row == 3 ? FIRST_LINE_X + LINE_X_INCREMENT * 3 + CHAR_OFFSET_X :        // row 3
                        curr_row == 2 ? FIRST_LINE_X + LINE_X_INCREMENT * 2 + CHAR_OFFSET_X :        // row 2
                        curr_row == 1 ? FIRST_LINE_X + LINE_X_INCREMENT * 1 + CHAR_OFFSET_X :        // row 1
                        FIRST_LINE_X + CHAR_OFFSET_X;                                                // row 0
    
    // y value for the "1" and "0" based on the row and col
    assign y_one_zero = curr_col == 4 ? FIRST_LINE_Y + LINE_Y_INCREMENT * 3 + CHAR_OFFSET_Y :        // column A, col 4
                        curr_col == 3 ? FIRST_LINE_Y + LINE_Y_INCREMENT * 2 + CHAR_OFFSET_Y :        // column B, col 3
                        curr_col == 2 ? FIRST_LINE_Y + LINE_Y_INCREMENT * 1 + CHAR_OFFSET_Y :        // column C, col 2
                        curr_col == 1 ? FIRST_LINE_Y + CHAR_OFFSET_Y :                               // column D, col 1
                        CHAR_OUTPUT_OFFSET_Y;                                                        // column out, col 0

    wire it_is_zero;
    wire it_is_one;

    is_one oneABCDOUT(
        .x_pos(x_one_zero),
        .y_pos(y_one_zero),
        .pix_index(pix_pos),
        .it_do_be_a_one(it_is_one)
    );

    is_zero zeroABCDOUT(
        .x_pos(x_one_zero),
        .y_pos(y_one_zero),
        .pix_index(pix_pos),
        .it_do_be_a_zero(it_is_zero)
    );

    // this decides to display 1 or 0 based on the col and row, and the output_gate
    wire it_is_number;
    assign it_is_number = curr_col == 4 ? (curr_row < 8 ? it_is_zero : it_is_one) :
                            curr_col == 3 ? (curr_row < 4 || (curr_row >= 8 && curr_row < 12) ? it_is_zero : it_is_one) :
                            curr_col == 2 ? (curr_row < 2 || curr_row == 4 || curr_row == 5 || curr_row == 8 || curr_row == 9 || curr_row == 12 || curr_row == 13 ? it_is_zero : it_is_one) :
                            curr_col == 1 ? (~curr_row[0] ? it_is_zero : it_is_one) :
                            (curr_row == 0 ? allstates[output_gate[3:2]][output_gate[1:0]][0] ? it_is_one & enable : it_is_zero & enable :
                                curr_row == 1 ? allstates[output_gate[3:2]][output_gate[1:0]][1] ? it_is_one & enable : it_is_zero & enable :
                                curr_row == 2 ? allstates[output_gate[3:2]][output_gate[1:0]][2] ? it_is_one & enable : it_is_zero & enable :
                                curr_row == 3 ? allstates[output_gate[3:2]][output_gate[1:0]][3] ? it_is_one & enable : it_is_zero & enable :
                                curr_row == 4 ? allstates[output_gate[3:2]][output_gate[1:0]][4] ? it_is_one & enable : it_is_zero & enable :
                                curr_row == 5 ? allstates[output_gate[3:2]][output_gate[1:0]][5] ? it_is_one & enable : it_is_zero & enable :
                                curr_row == 6 ? allstates[output_gate[3:2]][output_gate[1:0]][6] ? it_is_one & enable : it_is_zero & enable :
                                curr_row == 7 ? allstates[output_gate[3:2]][output_gate[1:0]][7] ? it_is_one & enable : it_is_zero & enable :
                                curr_row == 8 ? allstates[output_gate[3:2]][output_gate[1:0]][8] ? it_is_one & enable : it_is_zero & enable :
                                curr_row == 9 ? allstates[output_gate[3:2]][output_gate[1:0]][9] ? it_is_one & enable : it_is_zero & enable :
                                curr_row == 10 ? allstates[output_gate[3:2]][output_gate[1:0]][10] ? it_is_one & enable : it_is_zero & enable :
                                curr_row == 11 ? allstates[output_gate[3:2]][output_gate[1:0]][11] ? it_is_one & enable : it_is_zero & enable :
                                curr_row == 12 ? allstates[output_gate[3:2]][output_gate[1:0]][12] ? it_is_one & enable : it_is_zero & enable :
                                curr_row == 13 ? allstates[output_gate[3:2]][output_gate[1:0]][13] ? it_is_one & enable : it_is_zero & enable :
                                curr_row == 14 ? allstates[output_gate[3:2]][output_gate[1:0]][14] ? it_is_one & enable : it_is_zero & enable :
                                allstates[output_gate[3:2]][output_gate[1:0]][15] ? it_is_one & enable : it_is_zero & enable
                            );

    // Change colour based on ABCD input
    wire [15:0]text_colour;
    wire [6:0]multiplier = {2'b00, input_abcd};
    assign text_colour = ((curr_x > FIRST_LINE_X + LINE_X_INCREMENT * multiplier) && (curr_x < FIRST_LINE_X + LINE_X_INCREMENT * (multiplier + 1))) ? TEXT_HL_COLOUR : TEXT_COLOUR;

    // Oled data driver
    always @(posedge clk25m) begin  
        if (curr_x > (FIRST_LINE_X + LINE_X_INCREMENT * NO_OF_LINE_X)) begin // to clean up line at the bottom
            oled_data <= BG_COLOUR; 
        end else if (it_is_line) begin
            oled_data <= LINE_COLOUR;
        end else if (it_is_number || it_is_header) begin
            oled_data <= text_colour;
        end else begin
            oled_data <= BG_COLOUR; 
        end
    end
endmodule
