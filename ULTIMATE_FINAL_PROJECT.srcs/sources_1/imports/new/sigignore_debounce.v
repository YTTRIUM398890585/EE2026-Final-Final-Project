`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.11.2023 23:21:25
// Design Name: 
// Module Name: sigignore_debounce
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


module sigignore_debounce #(
    parameter MAX_DEBOUNCE_COUNT = 100
    )(
    input sig,
    input clk,
    output reg sig_ready = 1
    );

    reg [31:0] debounce_count = 0;
    always @(posedge clk) begin
        if (sig && sig_ready) begin
            sig_ready <= 0;
        end
        if (!sig_ready && (debounce_count < MAX_DEBOUNCE_COUNT)) begin
            debounce_count <= debounce_count + 1;
        end else if (!sig_ready) begin
            debounce_count <= 0;
            sig_ready <= 1;
        end
    end
endmodule
