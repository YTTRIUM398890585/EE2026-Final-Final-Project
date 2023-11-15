`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2023 00:29:45
// Design Name: 
// Module Name: pixel_index_to_xy
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


module pixel_index_to_xycoord(
    input [12:0] pixel_index,
    output [7:0] oleddisplay_xcoord,
    output [6:0] oleddisplay_ycoord
    );
    
    assign oleddisplay_xcoord = pixel_index % 96;
    assign oleddisplay_ycoord = pixel_index / 96;
    
endmodule
