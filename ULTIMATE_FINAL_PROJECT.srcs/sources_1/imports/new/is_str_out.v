`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2023 08:54:18 PM
// Design Name: 
// Module Name: is_str_out
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
module is_str_out(
    input [6:0]x_pos,
    input [5:0]y_pos,
    input [12:0]pix_index,
    input [3:0]output_gate,
    output it_do_be_str_out
    );

    wire [6:0]curr_x;
    wire [5:0]curr_y;
    
    cartesian_pixel index_to_xy(.pix_index(pix_index), .x(curr_x), .y(curr_y));

    wire [3:0]stage_char; 

    is_zero_big stage0(
        .x_pos(x_pos),
        .y_pos(y_pos + 10),
        .pix_index(pix_index),
        .it_do_be_a_zero(stage_char[0])
    );

    is_one_big stage1(
        .x_pos(x_pos),
        .y_pos(y_pos + 10),
        .pix_index(pix_index),
        .it_do_be_a_one(stage_char[1])
    );

    is_two stage2(
        .x_pos(x_pos),
        .y_pos(y_pos + 10),
        .pix_index(pix_index),
        .it_do_be_a_two(stage_char[2])
    );

    is_three stage3(
        .x_pos(x_pos),
        .y_pos(y_pos + 10),
        .pix_index(pix_index),
        .it_do_be_a_three(stage_char[3])
    );

    wire [3:0]gate_char;

    is_zero_big gate0(
        .x_pos(x_pos),
        .y_pos(y_pos + 3),
        .pix_index(pix_index),
        .it_do_be_a_zero(gate_char[0])
    );

    is_one_big gate1(
        .x_pos(x_pos),
        .y_pos(y_pos + 3),
        .pix_index(pix_index),
        .it_do_be_a_one(gate_char[1])
    );

    is_two gate2(
        .x_pos(x_pos),
        .y_pos(y_pos + 3),
        .pix_index(pix_index),
        .it_do_be_a_two(gate_char[2])
    );

    is_three gate3(
        .x_pos(x_pos),
        .y_pos(y_pos + 3),
        .pix_index(pix_index),
        .it_do_be_a_three(gate_char[3])
    );

    wire fixed_str;
    assign fixed_str =
        (((curr_y == y_pos) && (curr_x > x_pos) && (curr_x <= x_pos + 3)) || 

        ((curr_y == y_pos + 1) && (curr_x == x_pos)) ||
        ((curr_y == y_pos + 1) && (curr_x == x_pos + 4)) ||

        ((curr_y == y_pos + 8) && (curr_x == x_pos + 4)) ||

        ((curr_y == y_pos + 15) && (curr_x == x_pos)) ||
        ((curr_y == y_pos + 15) && (curr_x == x_pos + 4)) ||

        ((curr_y == y_pos + 16) && (curr_x > x_pos) && (curr_x <= x_pos + 3)) || 

        ((curr_y == y_pos + 18) && (curr_x == x_pos)) || 

        ((curr_y == y_pos + 19) && (curr_x == x_pos)) || 
        ((curr_y == y_pos + 19) && (curr_x == x_pos + 2)) || 

        ((curr_y == y_pos + 20) && (curr_x == x_pos)) || 
        ((curr_y == y_pos + 20) && (curr_x == x_pos + 2)) || 

        ((curr_y == y_pos + 21) && (curr_x >= x_pos) && (curr_x <= x_pos + 4)))
        ? 1 : 0;

    wire stage_str;
    assign stage_str = 
        output_gate[3:2] == 2'b00 ? stage_char[0] :             
        output_gate[3:2] == 2'b01 ? stage_char[1] : 
        output_gate[3:2] == 2'b10 ? stage_char[2] : 
        output_gate[3:2] == 2'b11 ? stage_char[3] : 1; // debug is all 1

    wire gate_str;
    assign gate_str =
        output_gate[1:0] == 2'b00 ? gate_char[0] :             
        output_gate[1:0] == 2'b01 ? gate_char[1] : 
        output_gate[1:0] == 2'b10 ? gate_char[2] : 
        output_gate[1:0] == 2'b11 ? gate_char[3] : 1; // debug is all 1

    assign it_do_be_str_out = fixed_str || stage_str || gate_str;
endmodule
