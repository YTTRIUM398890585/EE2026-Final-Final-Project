`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2023 15:34:49
// Design Name: 
// Module Name: mouse_tracker
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


module mouse_tracker(
    input CLOCK,
    input btnU,
    input [7:0] menu_xcoord,
    input [6:0] menu_ycoord,
    input [7:0] canvas_xcoord,
    input [6:0] canvas_ycoord,
    output [11:0] mouse_x,
    output [11:0] mouse_y,
    output [3:0] mouse_z,
    output mouse_leftpressed,
    output mouse_middlepressed,
    output mouse_rightpressed,
    output is_cursor,
    output reg oled_id,
    inout PS2Clk,
    inout PS2Data
    );
    
    /*Mouse controller input*/
    // Inputs to set mouse origin, boundaries
    reg [11:0] value;
    reg [3:0] mouse_setsignals = 4'b0000;
    wire setx;
    assign setx = mouse_setsignals[0];
    wire sety;
    assign sety = mouse_setsignals[1];
    wire setmax_x;
    assign setmax_x = mouse_setsignals[2];
    wire setmax_y;
    assign setmax_y = mouse_setsignals[3];
    // btnC to be used as mouse reset
    wire mouse_rst;
    assign mouse_rst = btnU;
    
    /* Mouse controller outputs*/
    wire mouse_leftclick;
    wire mouse_middleclick;
    wire mouse_rightclick;
    
    MouseCtl (
        .clk(CLOCK),
        .rst(mouse_rst),
        .xpos(mouse_x),
        .ypos(mouse_y),
        .zpos(mouse_z),
        .left(mouse_leftclick),
        .middle(mouse_middleclick),
        .right(mouse_rightclick),
        .value(value),
        .setx(setx),
        .sety(sety),
        .setmax_x(setmax_x),
        .setmax_y(setmax_y),
        .ps2_clk(PS2Clk),
        .ps2_data(PS2Data));
    
    /*Initialising mouse boundaries*/    
    parameter SET_X = 3'b000;
    parameter SET_Y = 3'b001;
    parameter SETMAX_X = 3'b010;
    parameter SETMAX_Y = 3'b011;
    parameter INIT_DONE = 3'b100;
    
    // Tracking initialisation current and next states
    reg [2:0] init_currstate;
    reg [2:0] init_nextstate;
    
    always @(posedge CLOCK) begin
        init_currstate <= mouse_rst && (init_currstate == INIT_DONE) ? SET_X : init_nextstate;
        case (init_currstate)
            SET_X: begin
                value <= 0;
                mouse_setsignals <= 4'b0001;
                init_nextstate <= SET_Y;
            end
            SET_Y: begin
                value <= 0;
                mouse_setsignals <= 4'b0010;
                init_nextstate <= SETMAX_X;
            end
            SETMAX_X: begin
                value <= 191;
                mouse_setsignals <= 4'b0100;
                init_nextstate <= SETMAX_Y;
            end
            SETMAX_Y: begin
                value <= 63;
                mouse_setsignals <= 4'b1000;
                init_nextstate <= INIT_DONE;
            end
            INIT_DONE: mouse_setsignals <= 4'b0000;
        endcase
    end
    
    /*Determining which OLED display the mouse cursor is on*/
    always @(posedge CLOCK) begin
        oled_id <= (mouse_x <= 95) ? 0 : 1;  
    end
    
    /*3x3 square cursor*/
    draw_squarecursor (
        .CLOCK(CLOCK),
        .oled_id(oled_id),
        .menudisplay_x(menu_xcoord),
        .menudisplay_y(menu_ycoord),
        .canvasdisplay_x(canvas_xcoord),
        .canvasdisplay_y(canvas_ycoord),
        .mouse_x(mouse_x),
        .mouse_y(mouse_y),
        .is_cursor(is_cursor));

    mouseinput_interpreter (
        .CLOCK(CLOCK),
        .mouse_leftclick(mouse_leftclick),
        .mouse_middleclick(mouse_middleclick),
        .mouse_rightclick(mouse_rightclick),
        .mouse_leftpressed(mouse_leftpressed),
        .mouse_middlepressed(mouse_middlepressed),
        .mouse_rightpressed(mouse_rightpressed));
endmodule
