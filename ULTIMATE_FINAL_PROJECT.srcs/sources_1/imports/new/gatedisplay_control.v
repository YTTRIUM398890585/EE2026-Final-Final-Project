`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 13:06:58
// Design Name: 
// Module Name: gatedisplay_control
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


module gatedisplay_control(
    input CLOCK,
    input [2:0] numinputs,
    input [7:0] menu_xcoord,
    input [6:0] menu_ycoord,
    input [1:0] gateinput4_state,
    input [1:0] gateinput3_state,
    input [1:0] gateinput2_state,
    input [1:0] gateinput1_state,
    input [1:0] selectedgate_state,
    output [4:0] gateinput_is_zero,
    output [4:0] gateinput_is_one,
    output [4:0] gateinput_is_two,
    output [4:0] gateinput_is_three,
    output [4:0] gateinput_is_four
    );

    wire show_gateinput4_is_zero;
    wire show_gateinput4_is_one;
    wire show_gateinput4_is_two;
    wire show_gateinput4_is_three;
    wire show_gateinput4_is_four;
    gate_display #(
        .ORIGIN_X(14),
        .ORIGIN_Y(7)
    ) gateinput4 (
        .CLOCK(CLOCK),
        .gate_state(gateinput4_state),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .show_zero(show_gateinput4_is_zero),
        .show_one(show_gateinput4_is_one),
        .show_two(show_gateinput4_is_two),
        .show_three(show_gateinput4_is_three),
        .show_four(show_gateinput4_is_four));

    assign gateinput4_is_zero = show_gateinput4_is_zero & (numinputs >= 4);
    assign gateinput4_is_one = show_gateinput4_is_one & (numinputs >= 4);
    assign gateinput4_is_two = show_gateinput4_is_two & (numinputs >= 4);
    assign gateinput4_is_three = show_gateinput4_is_three & (numinputs >= 4);
    assign gateinput4_is_four = show_gateinput4_is_four & (numinputs >= 4);

    wire show_gateinput3_is_zero;
    wire show_gateinput3_is_one;
    wire show_gateinput3_is_two;
    wire show_gateinput3_is_three;
    wire show_gateinput3_is_four;
    gate_display #(
        .ORIGIN_X(14),
        .ORIGIN_Y(22)
    ) gateinput3 (
        .CLOCK(CLOCK),
        .gate_state(gateinput3_state),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .show_zero(show_gateinput3_is_zero),
        .show_one(show_gateinput3_is_one),
        .show_two(show_gateinput3_is_two),
        .show_three(show_gateinput3_is_three),
        .show_four(show_gateinput3_is_four));

    assign gateinput3_is_zero = show_gateinput3_is_zero & (numinputs >= 3);
    assign gateinput3_is_one = show_gateinput3_is_one & (numinputs >= 3);
    assign gateinput3_is_two = show_gateinput3_is_two & (numinputs >= 3);
    assign gateinput3_is_three = show_gateinput3_is_three & (numinputs >= 3);
    assign gateinput3_is_four = show_gateinput3_is_four & (numinputs >= 3);

    wire show_gateinput2_is_zero;
    wire show_gateinput2_is_one;
    wire show_gateinput2_is_two;
    wire show_gateinput2_is_three;
    wire show_gateinput2_is_four;
    gate_display #(
        .ORIGIN_X(14),
        .ORIGIN_Y(37)
    ) gateinput2 (
        .CLOCK(CLOCK),
        .gate_state(gateinput2_state),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .show_zero(show_gateinput2_is_zero),
        .show_one(show_gateinput2_is_one),
        .show_two(show_gateinput2_is_two),
        .show_three(show_gateinput2_is_three),
        .show_four(show_gateinput2_is_four));

    assign gateinput2_is_zero = show_gateinput2_is_zero & (numinputs >= 2);
    assign gateinput2_is_one = show_gateinput2_is_one & (numinputs >= 2);
    assign gateinput2_is_two = show_gateinput2_is_two & (numinputs >= 2);
    assign gateinput2_is_three = show_gateinput2_is_three & (numinputs >= 2);
    assign gateinput2_is_four = show_gateinput2_is_four & (numinputs >= 2);

    wire show_gateinput1_is_zero;
    wire show_gateinput1_is_one;
    wire show_gateinput1_is_two;
    wire show_gateinput1_is_three;
    wire show_gateinput1_is_four;
    gate_display #(
        .ORIGIN_X(14),
        .ORIGIN_Y(52)
    ) gateinput1 (
        .CLOCK(CLOCK),
        .gate_state(gateinput1_state),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .show_zero(show_gateinput1_is_zero),
        .show_one(show_gateinput1_is_one),
        .show_two(show_gateinput1_is_two),
        .show_three(show_gateinput1_is_three),
        .show_four(show_gateinput1_is_four));
    
    assign gateinput1_is_zero = show_gateinput1_is_zero & (numinputs >= 1);
    assign gateinput1_is_one = show_gateinput1_is_one & (numinputs >= 1);
    assign gateinput1_is_two = show_gateinput1_is_two & (numinputs >= 1);
    assign gateinput1_is_three = show_gateinput1_is_three & (numinputs >= 1);
    assign gateinput1_is_four = show_gateinput1_is_four & (numinputs >= 1);

    wire selectedgate_is_zero;
    wire selectedgate_is_one;
    wire selectedgate_is_two;
    wire selectedgate_is_three;
    wire selectedagte_is_four;
    gate_display #(
        .ORIGIN_X(49),
        .ORIGIN_Y(30)
    ) selected_gate (
        .CLOCK(CLOCK),
        .gate_state(selectedgate_state),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .show_zero(selectedgate_is_zero),
        .show_one(selectedgate_is_one),
        .show_two(selectedgate_is_two),
        .show_three(selectedgate_is_three),
        .show_four(selectedgate_is_four));
    
    assign gateinput_is_zero = {selectedgate_is_zero, gateinput4_is_zero, gateinput3_is_zero, gateinput2_is_zero, gateinput1_is_zero};
    assign gateinput_is_one = {selectedgate_is_one, gateinput4_is_one, gateinput3_is_one, gateinput2_is_one, gateinput1_is_one};
    assign gateinput_is_two = {selectedgate_is_two, gateinput4_is_two, gateinput3_is_two, gateinput2_is_two, gateinput1_is_two};
    assign gateinput_is_three = {selectedgate_is_three, gateinput4_is_three, gateinput3_is_three, gateinput2_is_three, gateinput1_is_three};
    assign gateinput_is_four = {selectedgate_is_four, gateinput4_is_four, gateinput3_is_four, gateinput2_is_four, gateinput1_is_four};
endmodule
