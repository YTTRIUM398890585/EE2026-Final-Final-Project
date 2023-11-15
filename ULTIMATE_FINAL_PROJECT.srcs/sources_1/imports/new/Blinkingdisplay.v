`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 21:29:56
// Design Name: 
// Module Name: Blinkingdisplay
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


module Blinkingdisplay(
    input clk,
    input CLOCK,
    input [15:0]oled1,
    input [15:0]oled2,    
    output reg [15:0] oled
    );
    
  always@(posedge CLOCK)begin
          oled <= (clk)?oled1:oled2;
  end
endmodule
