`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.11.2023 23:21:25
// Design Name: 
// Module Name: sighold_debounce
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


module sighold_debounce # (
    parameter MAX_DEBOUNCE_COUNT = 100
    )(
    input clk,
    input noisy_sig,
    output reg debounced_sig = 0
    );
    reg [31:0] debounce_count = 0;
    always @(posedge clk) begin
        if (noisy_sig) begin
            debounce_count <= (debounce_count < MAX_DEBOUNCE_COUNT) ? debounce_count + 1 : MAX_DEBOUNCE_COUNT;
            debounced_sig <= (debounce_count == MAX_DEBOUNCE_COUNT) ? 1 : 0; 
        end else begin
            debounced_sig <= 0;
            debounce_count <= 0;
        end
    end
endmodule
