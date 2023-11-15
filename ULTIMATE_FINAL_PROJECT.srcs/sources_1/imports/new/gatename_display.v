`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.11.2023 17:16:13
// Design Name: 
// Module Name: gatename_display
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


module gatename_display(
    input [7:0] menu_xcoord,
    input [6:0] menu_ycoord,
    output [2:0] name_AND,
    output [3:0] name_NAND,
    output [1:0] name_OR,
    output [2:0] name_NOR,
    output [2:0] name_XOR,
    output [3:0] name_XNOR,
    output [2:0] name_NOT
    );
    // AND
    wire and_A, and_N, and_D;
    draw_letterA #(
        .ORIGIN_X(75),
        .ORIGIN_Y(2)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_A(and_A));

    draw_letterN #(
        .ORIGIN_X(79),
        .ORIGIN_Y(2)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_A(and_N));

    draw_letterD #(
        .ORIGIN_X(83),
        .ORIGIN_Y(2)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_A(and_D));

    assign name_AND = {and_A, and_N, and_D};

    // NAND
//    wire nand_N1, nand_A, nand_N2, nand_D;
//    draw_letterN1 #(
        
//    )
endmodule
