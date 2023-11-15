`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 05:53:25
// Design Name: 
// Module Name: display_button
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


module display_button #(
    parameter LOWERBOUND_X = 0,
    parameter UPPERBOUND_X = 0,
    parameter LOWERBOUND_Y = 0,
    parameter UPPERBOUND_Y = 0
    )(
    input CLOCK,
    input drawborder_en,
    input drawquad_en,
    input oledconfirm_id,
    input oled_id,
    input [11:0] mouse_x,
    input [11:0] mouse_y,
    input [7:0] oleddisplay_xcoord,
    input [6:0] oleddisplay_ycoord,
    input mouse_input,
    input btn_en,
    output is_border,
    output is_quad,
    output reg btn_pressed = 0
    );
    draw_border #(
        .LOWERBOUND_X(LOWERBOUND_X),
        .UPPERBOUND_X(UPPERBOUND_X),
        .LOWERBOUND_Y(LOWERBOUND_Y),
        .UPPERBOUND_Y(UPPERBOUND_Y)
    )(
        .CLOCK(CLOCK),
        .draw_en(drawborder_en),
        .oleddisplay_xcoord(oleddisplay_xcoord),
        .oleddisplay_ycoord(oleddisplay_ycoord),
        .is_border(is_border));

    draw_quad #(
        .LOWERBOUND_X(LOWERBOUND_X),
        .UPPERBOUND_X(UPPERBOUND_X),
        .LOWERBOUND_Y(LOWERBOUND_Y),
        .UPPERBOUND_Y(UPPERBOUND_Y)
    )(
        .CLOCK(CLOCK),
        .draw_en(drawquad_en),
        .oleddisplay_xcoord(oleddisplay_xcoord),
        .oleddisplay_ycoord(oleddisplay_ycoord),
        .is_quad(is_quad));
    
    wire [11:0] adjustedmouse_x;
    assign adjustedmouse_x = (oled_id == 1) ? mouse_x - 96 : mouse_x;
    always @(posedge CLOCK) begin
        if ((adjustedmouse_x > LOWERBOUND_X) && (adjustedmouse_x < UPPERBOUND_X) && (mouse_y > LOWERBOUND_Y) && (mouse_y < UPPERBOUND_Y)) begin
            btn_pressed <= (btn_en && mouse_input && (oled_id == oledconfirm_id)) ? 1 : 0;
        end
    end
endmodule
