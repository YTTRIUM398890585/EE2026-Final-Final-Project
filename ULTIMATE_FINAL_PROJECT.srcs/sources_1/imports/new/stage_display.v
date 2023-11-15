`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 13:06:58
// Design Name: 
// Module Name: stage_display
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


module stage_display #(
    parameter ORIGIN_X = 0,
    parameter ORIGIN_Y = 0
    )(
    input CLOCK,
    input [1:0] stage_state,
    input [7:0] oleddisplay_xcoord,
    input [6:0] oleddisplay_ycoord,
    output show_zero,
    output show_one,
    output show_two,
    output show_three
    );
    reg [3:0] isnum_en = 4'b0000;
    always @(posedge CLOCK) begin
        casez (stage_state)
            2'b00: isnum_en <= 4'b0001;
            2'b01: isnum_en <= 4'b0010;
            2'b10: isnum_en <= 4'b0100;
            2'b11: isnum_en <= 4'b1000;
        endcase
    end
    
    wire is_zero;
    draw_zero # (
        .ORIGIN_X(ORIGIN_X),
        .ORIGIN_Y(ORIGIN_Y)
    )(
        .oleddisplay_xcoord(oleddisplay_xcoord),
        .oleddisplay_ycoord(oleddisplay_ycoord),
        .is_zero(is_zero));
    assign show_zero = is_zero & isnum_en[0];
    
    wire is_one;
    draw_one # (
        .ORIGIN_X(ORIGIN_X),
        .ORIGIN_Y(ORIGIN_Y)
    )(
        .oleddisplay_xcoord(oleddisplay_xcoord),
        .oleddisplay_ycoord(oleddisplay_ycoord),
        .is_one(is_one));
    assign show_one = is_one & isnum_en[1];
    
    wire is_two;
    draw_two # (
        .ORIGIN_X(ORIGIN_X),
        .ORIGIN_Y(ORIGIN_Y)
    )(
        .oleddisplay_xcoord(oleddisplay_xcoord),
        .oleddisplay_ycoord(oleddisplay_ycoord),
        .is_two(is_two));
    assign show_two = is_two & isnum_en[2];
    
    wire is_three;
    draw_three # (
        .ORIGIN_X(ORIGIN_X),
        .ORIGIN_Y(ORIGIN_Y)
    )(
        .oleddisplay_xcoord(oleddisplay_xcoord),
        .oleddisplay_ycoord(oleddisplay_ycoord),
        .is_three(is_three));
    assign show_three = is_three & isnum_en[3];
endmodule
