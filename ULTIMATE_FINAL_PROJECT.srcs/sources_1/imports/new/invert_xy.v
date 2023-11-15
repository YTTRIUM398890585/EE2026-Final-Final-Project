`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2023 22:22:15
// Design Name: 
// Module Name: invert_xy
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


module invert_xy(
    input [7:0] inverted_x,
    input [6:0] inverted_y,
    output [7:0] x,
    output [6:0] y
    );
    assign x = 95 - inverted_x;
    assign y = 63 - inverted_y;
endmodule
