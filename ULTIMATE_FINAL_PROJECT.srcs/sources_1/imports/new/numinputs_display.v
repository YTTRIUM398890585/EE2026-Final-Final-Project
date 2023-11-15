`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2023 14:31:26
// Design Name: 
// Module Name: numinputs_display
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


module numinputs_display #(
    parameter ORIGIN_X = 0,
    parameter ORIGIN_Y = 0    
    )(
    input CLOCK,
    input [2:0] numinputs_state,
    input [7:0] oleddisplay_xcoord,
    input [6:0] oleddisplay_ycoord,
    output show_zero,
    output show_one,
    output show_two,
    output show_three,
    output show_four
    );
    reg [4:0] isnum_en = 4'b00000;
    always @(posedge CLOCK) begin
        case (numinputs_state) 
            3'd0: isnum_en <= 5'b00001;
            3'd1: isnum_en <= 5'b00010;
            3'd2: isnum_en <= 5'b00100;
            3'd3: isnum_en <= 5'b01000;
            3'd4: isnum_en <= 5'b10000;
        endcase
    end
    wire is_zero;
    draw_zero #(
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
    
    wire is_four;
    draw_four # (
        .ORIGIN_X(ORIGIN_X),
        .ORIGIN_Y(ORIGIN_Y)
    )(
        .oleddisplay_xcoord(oleddisplay_xcoord),
        .oleddisplay_ycoord(oleddisplay_ycoord),
        .is_four(is_four));
    assign show_four = is_four & isnum_en[4];
endmodule
