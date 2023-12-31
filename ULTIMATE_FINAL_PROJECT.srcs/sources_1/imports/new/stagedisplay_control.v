`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 13:06:58
// Design Name: 
// Module Name: stagedisplay_control
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


module stagedisplay_control(
    input CLOCK,
    input [2:0] numinputs,
    input [7:0] menu_xcoord,
    input [6:0] menu_ycoord,
    input [1:0] stageinput4_state,
    input [1:0] stageinput3_state,
    input [1:0] stageinput2_state,
    input [1:0] stageinput1_state,
    input [1:0] selectedstage_state,
    output [4:0] stageinput_is_zero,
    output [4:0] stageinput_is_one,
    output [4:0] stageinput_is_two,
    output [4:0] stageinput_is_three
    );

    wire show_stageinput4_is_zero;
    wire show_stageinput4_is_one;
    wire show_stageinput4_is_two;
    wire show_stageinput4_is_three;
    stage_display #(
        .ORIGIN_X(3),
        .ORIGIN_Y(7)
    ) stageinput4 (
        .CLOCK(CLOCK),
        .stage_state(stageinput4_state),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .show_zero(show_stageinput4_is_zero),
        .show_one(show_stageinput4_is_one),
        .show_two(show_stageinput4_is_two),
        .show_three(show_stageinput4_is_three));

    assign stageinput4_is_zero = show_stageinput4_is_zero & (numinputs >= 4);
    assign stageinput4_is_one = show_stageinput4_is_one & (numinputs >= 4);
    assign stageinput4_is_two = show_stageinput4_is_two & (numinputs >= 4);
    assign stageinput4_is_three = show_stageinput4_is_three & (numinputs >= 4);

    wire show_stageinput3_is_zero;
    wire show_stageinput3_is_one;
    wire show_stageinput3_is_two;
    wire show_stageinput3_is_three;
    stage_display #(
        .ORIGIN_X(3),
        .ORIGIN_Y(22)
    ) stageinput3 (
        .CLOCK(CLOCK),
        .stage_state(stageinput3_state),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .show_zero(show_stageinput3_is_zero),
        .show_one(show_stageinput3_is_one),
        .show_two(show_stageinput3_is_two),
        .show_three(show_stageinput3_is_three));
    
    assign stageinput3_is_zero = show_stageinput3_is_zero & (numinputs >= 3);
    assign stageinput3_is_one = show_stageinput3_is_one & (numinputs >= 3);
    assign stageinput3_is_two = show_stageinput3_is_two & (numinputs >= 3);
    assign stageinput3_is_three = show_stageinput3_is_three & (numinputs >= 3);

    wire show_stageinput2_is_zero;
    wire show_stageinput2_is_one;
    wire show_stageinput2_is_two;
    wire show_stageinput2_is_three;
    stage_display #(
        .ORIGIN_X(3),
        .ORIGIN_Y(37)
    ) stageinput2 (
        .CLOCK(CLOCK),
        .stage_state(stageinput2_state),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .show_zero(show_stageinput2_is_zero),
        .show_one(show_stageinput2_is_one),
        .show_two(show_stageinput2_is_two),
        .show_three(show_stageinput2_is_three));

    assign stageinput2_is_zero = show_stageinput2_is_zero & (numinputs >= 2);
    assign stageinput2_is_one = show_stageinput2_is_one & (numinputs >= 2);
    assign stageinput2_is_two = show_stageinput2_is_two & (numinputs >= 2);
    assign stageinput2_is_three = show_stageinput2_is_three & (numinputs >= 2);

    wire show_stageinput1_is_zero;
    wire show_stageinput1_is_one;
    wire show_stageinput1_is_two;
    wire show_stageinput1_is_three;
    stage_display #(
        .ORIGIN_X(3),
        .ORIGIN_Y(52)
    ) stageinput1 (
        .CLOCK(CLOCK),
        .stage_state(stageinput1_state),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .show_zero(show_stageinput1_is_zero),
        .show_one(show_stageinput1_is_one),
        .show_two(show_stageinput1_is_two),
        .show_three(show_stageinput1_is_three));
    
    assign stageinput1_is_zero = show_stageinput1_is_zero & (numinputs >= 1);
    assign stageinput1_is_one = show_stageinput1_is_one & (numinputs >= 1);
    assign stageinput1_is_two = show_stageinput1_is_two & (numinputs >= 1);
    assign stageinput1_is_three = show_stageinput1_is_three & (numinputs >= 1);

    wire selectedstage_is_one;
    wire selectedstage_is_two;
    wire selectedstage_is_three;
    stage_display #(
        .ORIGIN_X(43),
        .ORIGIN_Y(30)
    ) selected_stage (
        .CLOCK(CLOCK),
        .stage_state(selectedstage_state),
        .oleddisplay_xcoord(menu_xcoord), 
        .oleddisplay_ycoord(menu_ycoord),
        .show_zero(),
        .show_one(selectedstage_is_one),
        .show_two(selectedstage_is_two),   
        .show_three(selectedstage_is_three));

    assign stageinput_is_zero = {stageinput4_is_zero, stageinput3_is_zero, stageinput2_is_zero, stageinput1_is_zero};
    assign stageinput_is_one = {selectedstage_is_one, stageinput4_is_one, stageinput3_is_one, stageinput2_is_one, stageinput1_is_one};
    assign stageinput_is_two = {selectedstage_is_two, stageinput4_is_two, stageinput3_is_two, stageinput2_is_two, stageinput1_is_two};
    assign stageinput_is_three = {selectedstage_is_three, stageinput4_is_three, stageinput3_is_three, stageinput2_is_three, stageinput1_is_three};
endmodule
