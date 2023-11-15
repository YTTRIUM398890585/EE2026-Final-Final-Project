`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 22:10:14
// Design Name: 
// Module Name: oleddisplay_control
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


module student_a_top_file(
    input CLOCK,
    input btnU,
    input [12:0] menu_pixelindex,
    input [12:0] canvas_pixelindex,
    output reg [15:0] menu_rgbdata,
    output reg [15:0] canvas_rgbdata,
    inout PS2Clk,
    inout PS2Data,
    output [3:0] output_gate, 
    input [1:0] circuit_loaded,

    output [15:0]gate_inputs_10_loaded, 
    output [15:0]gate_inputs_11_loaded,
    output [15:0]gate_inputs_12_loaded,
    output [15:0]gate_inputs_13_loaded,

    output [15:0]gate_inputs_20_loaded,
    output [15:0]gate_inputs_21_loaded,
    output [15:0]gate_inputs_22_loaded,
    output [15:0]gate_inputs_23_loaded,

    output [15:0]gate_inputs_30_loaded,
    output [15:0]gate_inputs_31_loaded,
    output [15:0]gate_inputs_32_loaded,
    output [15:0]gate_inputs_33_loaded,

    output [4:0]gate_type_10_loaded,
    output [4:0]gate_type_11_loaded,
    output [4:0]gate_type_12_loaded,
    output [4:0]gate_type_13_loaded,

    output [4:0]gate_type_20_loaded,
    output [4:0]gate_type_21_loaded,
    output [4:0]gate_type_22_loaded,
    output [4:0]gate_type_23_loaded,

    output [4:0]gate_type_30_loaded,
    output [4:0]gate_type_31_loaded,
    output [4:0]gate_type_32_loaded,
    output [4:0]gate_type_33_loaded
    );
    
    /*6.25 MHz clock for OLED displays*/
    wire clk_6p25MHz; 
    improved_clock #(
        .MAX_COUNT(7)
        ) prescaler_6p25MHz (
        .CLOCK(CLOCK),
        .IMPROVED_CLOCK(clk_6p25MHz));

    /*Translating menu_pixelindex into x and y coordinates*/
    wire [7:0] inverted_menu_xcoord;
    wire [6:0] inverted_menu_ycoord;
    pixel_index_to_xycoord (
        .pixel_index(menu_pixelindex),
        .oleddisplay_xcoord(inverted_menu_xcoord),
        .oleddisplay_ycoord(inverted_menu_ycoord));

    // Adjusting for upside down OLED display    
    wire [7:0] menu_xcoord;
    wire [6:0] menu_ycoord;
    invert_xy (
        .inverted_x(inverted_menu_xcoord),
        .inverted_y(inverted_menu_ycoord),
        .x(menu_xcoord),
        .y(menu_ycoord));      
    
    /*Translating canvas_pixelindex to x and y coordinates*/
    wire [7:0] canvas_xcoord;
    wire [6:0] canvas_ycoord;
    pixel_index_to_xycoord (
        .pixel_index(canvas_pixelindex),
        .oleddisplay_xcoord(canvas_xcoord),
        .oleddisplay_ycoord(canvas_ycoord));
    
    wire is_cursor;
    wire oled_id;
    wire [11:0] mouse_x;
    wire [11:0] mouse_y;
    wire [3:0] mouse_z;
    wire mouse_leftpressed;
    wire mouse_middlepressed;
    wire mouse_rightpressed;
    mouse_tracker(
        .CLOCK(CLOCK),
        .btnU(btnU),
        .menu_xcoord(menu_xcoord),
        .menu_ycoord(menu_ycoord),
        .canvas_xcoord(canvas_xcoord),
        .canvas_ycoord(canvas_ycoord),
        .is_cursor(is_cursor),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .mouse_z(mouse_z),
        .mouse_leftpressed(mouse_leftpressed),
        .mouse_middlepressed(mouse_middlepressed),
        .mouse_rightpressed(mouse_rightpressed),
        .oled_id(oled_id),
        .PS2Clk(PS2Clk),
        .PS2Data(PS2Data));
    
    reg gateconfig_en = 0;

    wire [16:0] is_border;
    wire [16:0] menubtn_pressed;
    wire [11:0] canvasbtn_pressed;
    displaybutton_control(
        .CLOCK(CLOCK),
        .oled_id(oled_id),
        .gateconfig_en(gateconfig_en),
        .canvasgrid_en(1),
        .menu_xcoord(menu_xcoord),
        .menu_ycoord(menu_ycoord),
        .canvas_xcoord(canvas_xcoord),
        .canvas_ycoord(canvas_ycoord),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .mouse_leftpressed(mouse_leftpressed),
        .mouse_middlepressed(mouse_middlepressed),
        .mouse_rightpressed(mouse_rightpressed),
        .is_border(is_border),
        .is_quad(),
        .menubtn_pressed(menubtn_pressed),
        .canvasbtn_pressed(canvasbtn_pressed));
    
    /*Enabling/disabling gateconfig_en based on user input*/
    always @(posedge CLOCK) begin
        if (|canvasbtn_pressed) gateconfig_en <= 1;
        if (mouse_middlepressed) gateconfig_en <= 0;
    end
    
    wire numinputs_is_zero;
    wire numinputs_is_one;
    wire numinputs_is_two; 
    wire numinputs_is_three;
    wire numinputs_is_four; 
    wire [4:0] stageinput_is_zero;
    wire [4:0] stageinput_is_one;
    wire [4:0] stageinput_is_two;
    wire [4:0] stageinput_is_three;
    wire [4:0] gateinput_is_one;
    wire [4:0] gateinput_is_two;
    wire [4:0] gateinput_is_three;
    wire [4:0] gateinput_is_four;

    wire loaddata_rdy;
    wire [3:0] selected_gridcell;
    assign output_gate = selected_gridcell;

    wire [4:0] logicgate;
    wire [20:0] selected_gatedata;
    wire [20:0] new_gatedata;
    gateconfig_menu(
        .CLOCK(CLOCK),
        .gateconfig_en(gateconfig_en),
        .menu_xcoord(menu_xcoord),
        .menu_ycoord(menu_ycoord),
        .menubtn_pressed(menubtn_pressed),
        .canvasbtn_pressed(canvasbtn_pressed),
        .selected_gatedata(selected_gatedata),
        .loaddata_rdy(loaddata_rdy),
        .selected_gridcell(selected_gridcell),
        .logicgate(logicgate),
        .new_gatedata(new_gatedata),
        .numinputs_is_zero(numinputs_is_zero),
        .numinputs_is_one(numinputs_is_one),
        .numinputs_is_two(numinputs_is_two),
        .numinputs_is_three(numinputs_is_three),
        .numinputs_is_four(numinputs_is_four),
        .stageinput_is_zero(stageinput_is_zero),
        .stageinput_is_one(stageinput_is_one),
        .stageinput_is_two(stageinput_is_two),
        .stageinput_is_three(stageinput_is_three),
        .gateinput_is_one(gateinput_is_one),
        .gateinput_is_two(gateinput_is_two),
        .gateinput_is_three(gateinput_is_three),
        .gateinput_is_four(gateinput_is_four));

    wire is_logicgate;
    wire is_gridline;
    canvas_grid (
        .CLOCK(CLOCK),
        .gateconfig_en(gateconfig_en),
        .loaddata_rdy(loaddata_rdy),
        .circuit_loaded(circuit_loaded),
        .selected_gridcell(selected_gridcell),
        .new_gatedata(new_gatedata),
        .canvas_xcoord(canvas_xcoord),
        .canvas_ycoord(canvas_ycoord),
        .is_logicgate(is_logicgate),
        .is_gridline(is_gridline),
        .selected_gatedata(selected_gatedata),
        
        /*For circuit simulation*/
        .gate_inputs_10_loaded(gate_inputs_10_loaded), 
        .gate_inputs_11_loaded(gate_inputs_11_loaded),
        .gate_inputs_12_loaded(gate_inputs_12_loaded),
        .gate_inputs_13_loaded(gate_inputs_13_loaded),

        .gate_inputs_20_loaded(gate_inputs_20_loaded),
        .gate_inputs_21_loaded(gate_inputs_21_loaded),
        .gate_inputs_22_loaded(gate_inputs_22_loaded),
        .gate_inputs_23_loaded(gate_inputs_23_loaded),

        .gate_inputs_30_loaded(gate_inputs_30_loaded),
        .gate_inputs_31_loaded(gate_inputs_31_loaded),
        .gate_inputs_32_loaded(gate_inputs_32_loaded),
        .gate_inputs_33_loaded(gate_inputs_33_loaded),

        .gate_type_10_loaded(gate_type_10_loaded),
        .gate_type_11_loaded(gate_type_11_loaded),
        .gate_type_12_loaded(gate_type_12_loaded),
        .gate_type_13_loaded(gate_type_13_loaded),

        .gate_type_20_loaded(gate_type_20_loaded),
        .gate_type_21_loaded(gate_type_21_loaded),
        .gate_type_22_loaded(gate_type_22_loaded),
        .gate_type_23_loaded(gate_type_23_loaded),

        .gate_type_30_loaded(gate_type_30_loaded),
        .gate_type_31_loaded(gate_type_31_loaded),
        .gate_type_32_loaded(gate_type_32_loaded),
        .gate_type_33_loaded(gate_type_33_loaded));
    
    always @(posedge CLOCK) begin
        /*Menu display control*/
        if (is_cursor && (oled_id == 0)) menu_rgbdata <= 16'h07E4;
        else if (|is_border & gateconfig_en) menu_rgbdata <= 16'hE7E0;
        else if (numinputs_is_zero & gateconfig_en) menu_rgbdata <= 16'hFFFF;
        else if (numinputs_is_one & gateconfig_en) menu_rgbdata <= 16'hFFFF;
        else if (numinputs_is_two & gateconfig_en) menu_rgbdata <= 16'hFFFF;
        else if (numinputs_is_three & gateconfig_en) menu_rgbdata <= 16'hFFFF;
        else if (numinputs_is_four & gateconfig_en) menu_rgbdata <= 16'hFFFF;
        else if (|stageinput_is_zero & gateconfig_en) menu_rgbdata <= 16'hFFFF;
        else if (|stageinput_is_one & gateconfig_en) menu_rgbdata <= 16'hFFFF;
        else if (|stageinput_is_two & gateconfig_en) menu_rgbdata <= 16'hFFFF;
        else if (|stageinput_is_three & gateconfig_en) menu_rgbdata <= 16'hFFFF;
        else if (|gateinput_is_one & gateconfig_en) menu_rgbdata <= 16'hFFFF;
        else if (|gateinput_is_two & gateconfig_en) menu_rgbdata <= 16'hFFFF;
        else if (|gateinput_is_three & gateconfig_en) menu_rgbdata <= 16'hFFFF;
        else if (|gateinput_is_four & gateconfig_en) menu_rgbdata <= 16'hFFFF;
        else menu_rgbdata <= 16'h0000;
        /*Canvas display control*/
        if (is_cursor && (oled_id == 1)) canvas_rgbdata <= 16'h07E4;
        else if (is_logicgate) canvas_rgbdata <= 16'hFFFF;
        else if (is_gridline) canvas_rgbdata <= 16'hB81F;
        else canvas_rgbdata <= 16'h0000;
    end   
endmodule
