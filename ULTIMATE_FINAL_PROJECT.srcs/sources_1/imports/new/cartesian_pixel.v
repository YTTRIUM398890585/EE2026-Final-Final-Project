`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2023 04:21:20 PM
// Design Name: 
// Module Name: cartesian_pixel
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


module cartesian_pixel(input [12:0]pix_index, output [6:0]x, [5:0]y);
    // 96 across by 64 tall
    // 0-95 2^7
    // 0-63 2^6
    assign x = pix_index % 96;
    assign y = pix_index / 96;
endmodule
