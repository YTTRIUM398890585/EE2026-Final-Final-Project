`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2023 20:23:02
// Design Name: 
// Module Name: draw_border
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


module draw_border #(
    parameter LOWERBOUND_X = 0,
    parameter UPPERBOUND_X = 0,
    parameter LOWERBOUND_Y = 0,
    parameter UPPERBOUND_Y = 0,
    parameter BORDER_THICKNESS = 1
    )(
    input CLOCK,
    input draw_en,
    input [7:0] oleddisplay_xcoord,
    input [6:0] oleddisplay_ycoord,
    output reg is_border = 0
    );
    
    // Drawing horizontal and vertical borders
    reg is_horizontalborder = 0;
    reg is_verticalborder = 0;
    always @ (posedge CLOCK) begin
        if (draw_en) begin
            // Horizontal
            if ((oleddisplay_xcoord >= LOWERBOUND_X) && (oleddisplay_xcoord <= UPPERBOUND_X)
            && (((oleddisplay_ycoord >= LOWERBOUND_Y) && (oleddisplay_ycoord < LOWERBOUND_Y + BORDER_THICKNESS))
            || ((oleddisplay_ycoord > UPPERBOUND_Y - BORDER_THICKNESS) && (oleddisplay_ycoord <= UPPERBOUND_Y)))) begin
                is_horizontalborder <= 1;
            end else begin
                is_horizontalborder <= 0;
            end
            // Vertical
            if ((((oleddisplay_xcoord >= LOWERBOUND_X) && (oleddisplay_xcoord < LOWERBOUND_X + BORDER_THICKNESS))
            || ((oleddisplay_xcoord > UPPERBOUND_X - BORDER_THICKNESS) && (oleddisplay_xcoord <= UPPERBOUND_X)))
            && (oleddisplay_ycoord >= LOWERBOUND_Y) && (oleddisplay_ycoord <= UPPERBOUND_Y)) begin
                is_verticalborder <= 1;
            end else begin
                is_verticalborder <= 0;
            end
            if (|({is_horizontalborder, is_verticalborder})) begin
                is_border <= 1;
            end else begin
                is_border <= 0;
            end 
        end else is_border <= 0;
    end
endmodule
