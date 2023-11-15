`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 09:10:52
// Design Name: 
// Module Name: draw_two
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


module draw_two #(
    parameter ORIGIN_X = 0,
    parameter ORIGIN_Y = 0
    )(
    input [7:0] oleddisplay_xcoord,
    input [6:0] oleddisplay_ycoord,
    output is_two
    );
    assign is_two = (oleddisplay_xcoord == ORIGIN_X) && ((oleddisplay_ycoord == ORIGIN_Y + 1) || (oleddisplay_ycoord == ORIGIN_Y + 4))
    || (oleddisplay_xcoord == ORIGIN_X + 1) && ((oleddisplay_ycoord == ORIGIN_Y) || (oleddisplay_ycoord == ORIGIN_Y + 4))
    || (oleddisplay_xcoord == ORIGIN_X + 2) && ((oleddisplay_ycoord == ORIGIN_Y) || ((oleddisplay_ycoord >= ORIGIN_Y + 3) && (oleddisplay_ycoord <= ORIGIN_Y + 4)))
    || (oleddisplay_xcoord == ORIGIN_X + 3) && (((oleddisplay_ycoord >= ORIGIN_Y + 1) && (oleddisplay_ycoord <= ORIGIN_Y + 2)) || (oleddisplay_ycoord == ORIGIN_Y + 4)) ? 1 : 0;
endmodule

