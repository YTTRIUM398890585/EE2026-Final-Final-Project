`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2023 10:02:11 PM
// Design Name: 
// Module Name: is_zero_big
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
module is_zero_big(
    input [6:0]x_pos,
    input [5:0]y_pos,
    input [12:0]pix_index,
    output it_do_be_a_zero
    );

    wire [6:0]curr_x;
    wire [5:0]curr_y;
    
    cartesian_pixel index_to_xy(.pix_index(pix_index), .x(curr_x), .y(curr_y));

    assign it_do_be_a_zero =
        (((curr_y == y_pos) && (curr_x > x_pos) && (curr_x <= x_pos + 3)) || 
        ((curr_y == y_pos + 3) && (curr_x > x_pos) && (curr_x <= x_pos + 3)) ||
        ((curr_x == x_pos) && (curr_y > y_pos) && (curr_y <= y_pos + 2)) || 
        ((curr_x == x_pos + 4) && (curr_y > y_pos) && (curr_y <= y_pos + 2)))
        ? 1 : 0;

    // assign it_do_be_a_zero =
    //     (((curr_y == y_pos) && (curr_x > x_pos) && (curr_x <= x_pos + 2)) || 
    //     ((curr_y == y_pos + 1) && (curr_x == x_pos)) ||
    //     ((curr_y == y_pos + 1) && (curr_x == x_pos + 3)) ||
    //     ((curr_y == y_pos + 2) && (curr_x > x_pos) && (curr_x <= x_pos + 2)))
    //     ? 1 : 0;
endmodule
