`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 07:38:50
// Design Name: 
// Module Name: displaybutton_control
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


module displaybutton_control(
    input CLOCK,
    input oled_id,
    input gateconfig_en,
    input canvasgrid_en,
    input [7:0] menu_xcoord,
    input [6:0] menu_ycoord,
    input [7:0] canvas_xcoord,
    input [6:0] canvas_ycoord,
    input [11:0] mouse_x,
    input [11:0] mouse_y,
    input mouse_leftpressed,
    input mouse_middlepressed,
    input mouse_rightpressed,
    output [16:0] is_border,
    output is_quad,
    output [16:0] menubtn_pressed,
    output [11:0] canvasbtn_pressed
    );
    /* Menu display buttons*/
    // Stage inputs
    display_button #(
        .LOWERBOUND_X(0),
        .UPPERBOUND_X(9),
        .LOWERBOUND_Y(49),
        .UPPERBOUND_Y(59)
    ) stageinput_1 (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[0]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[0]));
    display_button #(
        .LOWERBOUND_X(0),
        .UPPERBOUND_X(9),
        .LOWERBOUND_Y(34),
        .UPPERBOUND_Y(44)
    ) stageinput_2 (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[1]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[1]));
    display_button #(
        .LOWERBOUND_X(0),
        .UPPERBOUND_X(9),
        .LOWERBOUND_Y(19),
        .UPPERBOUND_Y(29)
    ) stageinput_3 (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[2]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[2]));
    display_button #(
        .LOWERBOUND_X(0),
        .UPPERBOUND_X(9),
        .LOWERBOUND_Y(4),
        .UPPERBOUND_Y(14)
    ) stageinput_4 (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[3]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[3]));

    // Gate inputs
    display_button #(
        .LOWERBOUND_X(11),
        .UPPERBOUND_X(20),
        .LOWERBOUND_Y(49),
        .UPPERBOUND_Y(59)
    ) gateinput_1 (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[4]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[4]));
    display_button #(
        .LOWERBOUND_X(11),
        .UPPERBOUND_X(20),
        .LOWERBOUND_Y(34),
        .UPPERBOUND_Y(44)
    ) gateinput_2 (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[5]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[5]));
    display_button #(
        .LOWERBOUND_X(11),
        .UPPERBOUND_X(20),
        .LOWERBOUND_Y(19),
        .UPPERBOUND_Y(29)
    ) gateinput_3 (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[6]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[6]));
    display_button #(
        .LOWERBOUND_X(11),
        .UPPERBOUND_X(20),
        .LOWERBOUND_Y(4),
        .UPPERBOUND_Y(14)
    ) gateinput_4 (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[7]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[7]));
    // Number of inputs
    display_button #(
        .LOWERBOUND_X(42),
        .UPPERBOUND_X(51),
        .LOWERBOUND_Y(8),
        .UPPERBOUND_Y(18)
    ) btn_num_gateinputs (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[8]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[8]));
    
    // Logic gates   
    /// AND
    display_button #(
        .LOWERBOUND_X(73),
        .UPPERBOUND_X(95),
        .LOWERBOUND_Y(0),
        .UPPERBOUND_Y(8)
    ) button_AND (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[9]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[9]));        
    /// NAND
    display_button #(
        .LOWERBOUND_X(73),
        .UPPERBOUND_X(95),
        .LOWERBOUND_Y(9),
        .UPPERBOUND_Y(17)
    ) button_NAND (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[10]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[10]));      
    /// OR
    display_button #(
        .LOWERBOUND_X(73),
        .UPPERBOUND_X(95),
        .LOWERBOUND_Y(18),
        .UPPERBOUND_Y(26)
    ) button_OR (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[11]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[11]));      
    /// NOR
    display_button #(
        .LOWERBOUND_X(73),
        .UPPERBOUND_X(95),
        .LOWERBOUND_Y(27),
        .UPPERBOUND_Y(35)
    ) button_NOR (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[12]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[12]));        
    /// XOR
    display_button #(
        .LOWERBOUND_X(73),
        .UPPERBOUND_X(95),
        .LOWERBOUND_Y(36),
        .UPPERBOUND_Y(44)
    ) button_XOR (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[13]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[13]));  
    /// XNOR
    display_button #(
        .LOWERBOUND_X(73),
        .UPPERBOUND_X(95),
        .LOWERBOUND_Y(45),
        .UPPERBOUND_Y(53)
    ) button_XNOR (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[14]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[14]));
    /// NOT
    display_button #(
        .LOWERBOUND_X(73),
        .UPPERBOUND_X(95),
        .LOWERBOUND_Y(54),
        .UPPERBOUND_Y(62)
    ) button_NOT (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(gateconfig_en),
        .is_border(is_border[15]),
        .is_quad(),
        .btn_pressed(menubtn_pressed[15]));
    // NOGATE
    display_button #(
        .LOWERBOUND_X(0),
        .UPPERBOUND_X(96),
        .LOWERBOUND_Y(0),
        .UPPERBOUND_Y(64)
    ) button_NOGATE (
        .CLOCK(CLOCK),
        .drawborder_en(0),
        .drawquad_en(0),
        .oledconfirm_id(0),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(mouse_rightpressed),
        .btn_en(gateconfig_en),
        .is_border(),
        .is_quad(),
        .btn_pressed(menubtn_pressed[16]));
    // Current grid display (not a button)
    display_button #(
        .LOWERBOUND_X(40),
        .UPPERBOUND_X(55),
        .LOWERBOUND_Y(27),
        .UPPERBOUND_Y(37)
    ) currentgrid_display (
        .CLOCK(CLOCK),
        .drawborder_en(1),
        .drawquad_en(0),
        .oledconfirm_id(),
        .oled_id(),
        .mouse_x(),
        .mouse_y(),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .mouse_input(),
        .btn_en(0),
        .is_border(is_border[16]),
        .is_quad(),
        .btn_pressed());
    
    /*Canvas grid buttons*/
    // Stage 1, Gate 1
    display_button #(
        .LOWERBOUND_X(0),
        .UPPERBOUND_X(32),
        .LOWERBOUND_Y(0),
        .UPPERBOUND_Y(16)
    ) gridcell0 (
        .CLOCK(CLOCK),
        .drawborder_en(0),
        .drawquad_en(0),
        .oledconfirm_id(1),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(canvas_xcoord),
        .oleddisplay_ycoord(canvas_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(1),
        .is_border(),
        .is_quad(),
        .btn_pressed(canvasbtn_pressed[0]));
    // Stage 1, Gate 2
    display_button #(
        .LOWERBOUND_X(0),
        .UPPERBOUND_X(32),
        .LOWERBOUND_Y(16),
        .UPPERBOUND_Y(32)
    ) gridcell_1 (
        .CLOCK(CLOCK),
        .drawborder_en(0),
        .drawquad_en(0),
        .oledconfirm_id(1),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(canvas_xcoord),
        .oleddisplay_ycoord(canvas_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(1),
        .is_border(),
        .is_quad(),
        .btn_pressed(canvasbtn_pressed[1]));
    // Stage 1, Gate 3
    display_button #(
        .LOWERBOUND_X(0),
        .UPPERBOUND_X(32),
        .LOWERBOUND_Y(32),
        .UPPERBOUND_Y(48)
    ) gridcell_2 (
        .CLOCK(CLOCK),
        .drawborder_en(0),
        .drawquad_en(0),
        .oledconfirm_id(1),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(canvas_xcoord),
        .oleddisplay_ycoord(canvas_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(1),
        .is_border(),
        .is_quad(),
        .btn_pressed(canvasbtn_pressed[2]));
    // Stage 1, Gate 4
    display_button #(
        .LOWERBOUND_X(0),
        .UPPERBOUND_X(32),
        .LOWERBOUND_Y(48),
        .UPPERBOUND_Y(64)
    ) gridcell_3 (
        .CLOCK(CLOCK),
        .drawborder_en(0),
        .drawquad_en(0),
        .oledconfirm_id(1),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(canvas_xcoord),
        .oleddisplay_ycoord(canvas_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(1),
        .is_border(),
        .is_quad(),
        .btn_pressed(canvasbtn_pressed[3]));
    // Stage 2, Gate 1
    display_button #(
        .LOWERBOUND_X(32),
        .UPPERBOUND_X(64),
        .LOWERBOUND_Y(0),
        .UPPERBOUND_Y(16)
    ) gridcell_4 (
        .CLOCK(CLOCK),
        .drawborder_en(0),
        .drawquad_en(0),
        .oledconfirm_id(1),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(canvas_xcoord),
        .oleddisplay_ycoord(canvas_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(1),
        .is_border(),
        .is_quad(),
        .btn_pressed(canvasbtn_pressed[4]));
    // Stage 2, Gate 2
    display_button #(
        .LOWERBOUND_X(32),
        .UPPERBOUND_X(64),
        .LOWERBOUND_Y(16),
        .UPPERBOUND_Y(32)
    ) gridcell_5 (
        .CLOCK(CLOCK),
        .drawborder_en(0),
        .drawquad_en(0),
        .oledconfirm_id(1),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(canvas_xcoord),
        .oleddisplay_ycoord(canvas_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(1),
        .is_border(),
        .is_quad(),
        .btn_pressed(canvasbtn_pressed[5]));
    // Stage 2, Gate 3
    display_button #(
        .LOWERBOUND_X(32),
        .UPPERBOUND_X(64),
        .LOWERBOUND_Y(32),
        .UPPERBOUND_Y(48)
    ) gridcell_6 (
        .CLOCK(CLOCK),
        .drawborder_en(0),
        .drawquad_en(0),
        .oledconfirm_id(1),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(canvas_xcoord),
        .oleddisplay_ycoord(canvas_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(1),
        .is_border(),
        .is_quad(),
        .btn_pressed(canvasbtn_pressed[6]));
    // Stage 2, Gate 4
    display_button #(
        .LOWERBOUND_X(32),
        .UPPERBOUND_X(64),
        .LOWERBOUND_Y(48),
        .UPPERBOUND_Y(64)
    ) gridcell_7 (
        .CLOCK(CLOCK),
        .drawborder_en(0),
        .drawquad_en(0),
        .oledconfirm_id(1),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(canvas_xcoord),
        .oleddisplay_ycoord(canvas_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(1),
        .is_border(),
        .is_quad(),
        .btn_pressed(canvasbtn_pressed[7]));
    // Stage 3, Gate 1
    display_button #(
        .LOWERBOUND_X(64),
        .UPPERBOUND_X(96),
        .LOWERBOUND_Y(0),
        .UPPERBOUND_Y(16)
    ) gridcell_8 (
        .CLOCK(CLOCK),
        .drawborder_en(0),
        .drawquad_en(0),
        .oledconfirm_id(1),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(canvas_xcoord),
        .oleddisplay_ycoord(canvas_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(1),
        .is_border(),
        .is_quad(),
        .btn_pressed(canvasbtn_pressed[8]));
    // Stage 3, Gate 2
    display_button #(
        .LOWERBOUND_X(64),
        .UPPERBOUND_X(96),
        .LOWERBOUND_Y(16),
        .UPPERBOUND_Y(32)
    ) gridcell_9 (
        .CLOCK(CLOCK),
        .drawborder_en(0),
        .drawquad_en(0),
        .oledconfirm_id(1),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(canvas_xcoord),
        .oleddisplay_ycoord(canvas_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(1),
        .is_border(),
        .is_quad(),
        .btn_pressed(canvasbtn_pressed[9]));
    // Stage 3, Gate 3
    display_button #(
        .LOWERBOUND_X(64),
        .UPPERBOUND_X(96),
        .LOWERBOUND_Y(32),
        .UPPERBOUND_Y(48)
    ) gridcell_10 (
        .CLOCK(CLOCK),
        .drawborder_en(0),
        .drawquad_en(0),
        .oledconfirm_id(1),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(canvas_xcoord),
        .oleddisplay_ycoord(canvas_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(1),
        .is_border(),
        .is_quad(),
        .btn_pressed(canvasbtn_pressed[10]));
    // Stage 3, Gate 4
    display_button #(
        .LOWERBOUND_X(64),
        .UPPERBOUND_X(96),
        .LOWERBOUND_Y(48),
        .UPPERBOUND_Y(64)
    ) gridcell_11 (
        .CLOCK(CLOCK),
        .drawborder_en(0),
        .drawquad_en(0),
        .oledconfirm_id(1),
        .oled_id(oled_id),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .oleddisplay_xcoord(canvas_xcoord),
        .oleddisplay_ycoord(canvas_ycoord),
        .mouse_input(mouse_leftpressed),
        .btn_en(1),
        .is_border(),
        .is_quad(),
        .btn_pressed(canvasbtn_pressed[11]));
endmodule
