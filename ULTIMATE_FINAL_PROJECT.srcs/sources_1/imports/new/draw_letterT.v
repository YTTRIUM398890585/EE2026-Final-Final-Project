`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 10:40:47
// Design Name: 
// Module Name: draw_T
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


module draw_letterT #(
    parameter ORIGIN_X = 0,
    parameter ORIGIN_Y = 0
    )(
    input [7:0] oleddisplay_xcoord,
    input [6:0] oleddisplay_ycoord,
    output is_T
    );
    assign is_T = (oleddisplay_xcoord == ORIGIN_X) && (oleddisplay_ycoord == ORIGIN_Y)
    || (oleddisplay_xcoord == ORIGIN_X + 1) && (oleddisplay_ycoord >= ORIGIN_Y) && (oleddisplay_ycoord <= ORIGIN_Y + 4)
    || (oleddisplay_xcoord == ORIGIN_X + 2) && (oleddisplay_ycoord >= ORIGIN_Y) && (oleddisplay_ycoord <= ORIGIN_Y + 4)
    || (oleddisplay_xcoord == ORIGIN_X + 3) && (oleddisplay_ycoord == ORIGIN_Y) ? 1 : 0;
endmodule
