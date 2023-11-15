`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.10.2023 02:37:01
// Design Name: 
// Module Name: draw_quad
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


module draw_quad #(
    parameter LOWERBOUND_X = 0,
    parameter UPPERBOUND_X = 0,
    parameter LOWERBOUND_Y = 0,
    parameter UPPERBOUND_Y = 0
    )(
    input CLOCK,
    input draw_en,
    input [7:0] oleddisplay_xcoord,
    input [6:0] oleddisplay_ycoord,
    output reg is_quad = 0
    );
    always @(posedge CLOCK) begin
        if (draw_en) begin
            if ((oleddisplay_xcoord >= LOWERBOUND_X) && (oleddisplay_xcoord <= UPPERBOUND_X)
            && (oleddisplay_ycoord >= LOWERBOUND_Y) && (oleddisplay_ycoord <= UPPERBOUND_Y)) begin
                is_quad <= 1;
            end else begin
                is_quad <= 0;
            end
        end else is_quad <= 0;
    end
endmodule
