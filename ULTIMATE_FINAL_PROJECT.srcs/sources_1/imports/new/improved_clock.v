`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2023 15:39:30
// Design Name: 
// Module Name: improved_clock
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


module improved_clock #(
    parameter INPUT_FREQUENCY = 100_000_000,
    parameter OUTPUT_FREQUENCY = 100_000_000,
    parameter MAX_COUNT = (INPUT_FREQUENCY / (2 * OUTPUT_FREQUENCY)) - 1 
    )(
    input CLOCK, 
    output reg IMPROVED_CLOCK = 0
    );
    
    reg [31:0] COUNT;
    
    always @ (posedge CLOCK) begin
        COUNT <= (COUNT == MAX_COUNT) ? 0 : COUNT + 1; // count will overflow after m increments
        IMPROVED_CLOCK <= (COUNT == 0) ? ~IMPROVED_CLOCK : IMPROVED_CLOCK; // IMPROVED_CLOCK will toggle when count overflows
    end
endmodule
