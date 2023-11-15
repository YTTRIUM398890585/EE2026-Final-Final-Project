`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2023 03:53:13 PM
// Design Name: 
// Module Name: clock_gen
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


module clock_gen(input clk_in, input [31:0]m, output reg clk_out = 0);
    reg [31:0]counter = 0;
    
    always @ (posedge clk_in) begin
        counter <= counter == m ? 0 : counter + 1;
        clk_out <= counter == 0 ? ~clk_out : clk_out;
    end
endmodule

