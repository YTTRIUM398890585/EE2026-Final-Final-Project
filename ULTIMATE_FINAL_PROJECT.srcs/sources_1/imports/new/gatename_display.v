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
    input CLOCK,
    input [4:0] logicgate,
    input [7:0] menu_xcoord,
    input [6:0] menu_ycoord,
    output blinky_AND,
    output blinky_NAND,
    output blinky_OR,
    output blinky_NOR,
    output blinky_XOR,
    output blinky_XNOR,
    output blinky_NOT,
    output [2:0] name_AND,
    output [3:0] name_NAND,
    output [1:0] name_OR,
    output [2:0] name_NOR,
    output [2:0] name_XOR,
    output [3:0] name_XNOR,
    output [2:0] name_NOT
    );
    /*Logic gate (without number of inputs)*/
    parameter NOT = 19;
    parameter AND = 20;
    parameter NAND = 21;
    parameter OR = 22;
    parameter NOR = 23;
    parameter XOR = 24;
    parameter XNOR = 25;

    /*Mapping blinky to logicgate selected*/
    wire clk_1Hz;
    improved_clock #(
        .OUTPUT_FREQUENCY(2)
    ) prescaler_1Hz (
        .CLOCK(CLOCK),
        .IMPROVED_CLOCK(clk_1Hz));
    
    assign blinky_AND = (logicgate == AND) ? clk_1Hz : 1;
    assign blinky_NAND = (logicgate == NAND) ? clk_1Hz : 1;
    assign blinky_OR = (logicgate == OR) ? clk_1Hz : 1;
    assign blinky_NOR = (logicgate == NOR) ? clk_1Hz : 1;
    assign blinky_XOR = (logicgate == XOR) ? clk_1Hz : 1;
    assign blinky_XNOR = (logicgate == XNOR) ? clk_1Hz : 1;
    assign blinky_NOT = (logicgate == NOT) ? clk_1Hz : 1;

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
        .ORIGIN_X(80),
        .ORIGIN_Y(2)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_N(and_N));

    draw_letterD #(
        .ORIGIN_X(85),
        .ORIGIN_Y(2)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_D(and_D));

    assign name_AND = {and_A, and_N, and_D};

    // NAND
   wire nand_N1, nand_A, nand_N2, nand_D;
   draw_letterN #(
        .ORIGIN_X(75),
        .ORIGIN_Y(11)
    )(   
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_N(nand_N1));

    draw_letterA #(
        .ORIGIN_X(80),
        .ORIGIN_Y(11)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_A(nand_A));

    draw_letterN #(
        .ORIGIN_X(85),
        .ORIGIN_Y(11)
    )(   
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_N(nand_N2));

    draw_letterD #(
        .ORIGIN_X(90),
        .ORIGIN_Y(11)
    )(  
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_D(nand_D));
    
    assign name_NAND = {nand_N1, nand_A, nand_N2, nand_D};

    // OR
    wire or_O, or_R;
    draw_letterO #(
        .ORIGIN_X(75),
        .ORIGIN_Y(20)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_O(or_O));
    
    draw_letterR #(
        .ORIGIN_X(80),
        .ORIGIN_Y(20)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_R(or_R));
    
    assign name_OR = {or_O, or_R};

    // NOR
    wire nor_N, nor_O, nor_R;
    draw_letterN #(
        .ORIGIN_X(75),
        .ORIGIN_Y(29)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_N(nor_N));
    
    draw_letterO #(
        .ORIGIN_X(80),
        .ORIGIN_Y(29)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_O(nor_O));
    
    draw_letterR #(
        .ORIGIN_X(85),
        .ORIGIN_Y(29)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_R(nor_R));
    
    assign name_NOR = {nor_N, nor_O, nor_R};

    // XOR
    wire xor_X, xor_O, xor_R;
    draw_letterX #(
        .ORIGIN_X(75),
        .ORIGIN_Y(38)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_X(xor_X));
    
    draw_letterO #(
        .ORIGIN_X(80),
        .ORIGIN_Y(38)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_O(xor_O));
    
    draw_letterR #(
        .ORIGIN_X(85),
        .ORIGIN_Y(38)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_R(xor_R));

    assign name_XOR = {xor_X, xor_O, xor_R};

    // XNOR
    wire xnor_X, xnor_N, xnor_O, xnor_R;
    draw_letterX #(
        .ORIGIN_X(75),
        .ORIGIN_Y(47)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_X(xnor_X));

    draw_letterN #(
        .ORIGIN_X(80),
        .ORIGIN_Y(47)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_N(xnor_N));
    
    draw_letterO #(
        .ORIGIN_X(85),
        .ORIGIN_Y(47)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_O(xnor_O));
    
    draw_letterR #(
        .ORIGIN_X(90),
        .ORIGIN_Y(47)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_R(xnor_R));
    
    assign name_XNOR = {xnor_X, xnor_N, xnor_O, xnor_R};

    // NOT
    wire not_N, not_O, not_T;
    draw_letterN #(
        .ORIGIN_X(75),
        .ORIGIN_Y(56)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_N(not_N));
    
    draw_letterO #(
        .ORIGIN_X(80),
        .ORIGIN_Y(56)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_O(not_O));
    
    draw_letterT #(
        .ORIGIN_X(85),
        .ORIGIN_Y(56)
    )(
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .is_T(not_T));
    
    assign name_NOT = {not_N, not_O, not_T};
endmodule
