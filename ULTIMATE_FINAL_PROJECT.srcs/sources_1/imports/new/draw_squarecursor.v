`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2023 18:17:54
// Design Name: 
// Module Name: draw_squarecursor
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


module draw_squarecursor #(
    EDGE_SIZE = 3
    )(
    input CLOCK,
    input oled_id,
    input [7:0] menudisplay_x,
    input [6:0] menudisplay_y,
    input [7:0] canvasdisplay_x,
    input [6:0] canvasdisplay_y,
    input [11:0] mouse_x,
    input [11:0] mouse_y,
    output reg is_cursor = 0
    );
    /*Adjusting mouse_x for when oled_num = 1*/
    wire [7:0] adjustedmouse_x;
    assign adjustedmouse_x = mouse_x - 96;
    /*Can only 3x3 (for now)*/
    always @(posedge CLOCK) begin
        if (oled_id == 0) begin
            is_cursor <= ((mouse_x == menudisplay_x) || ((mouse_x - menudisplay_x) == 1) || ((menudisplay_x - mouse_x) == 1))
            && ((mouse_y == menudisplay_y) || ((mouse_y - menudisplay_y) == 1) || ((menudisplay_y - mouse_y) == 1)) ? 1 : 0; 
        end else begin
            is_cursor <= ((adjustedmouse_x == canvasdisplay_x) || ((adjustedmouse_x - canvasdisplay_x) == 1) || ((canvasdisplay_x - adjustedmouse_x) == 1))
            && ((mouse_y == canvasdisplay_y) || ((mouse_y - canvasdisplay_y) == 1) || ((canvasdisplay_y - mouse_y) == 1)) ? 1 : 0; 
        end
    end
endmodule
