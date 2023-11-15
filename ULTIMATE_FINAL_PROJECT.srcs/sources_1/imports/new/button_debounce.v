`timescale 1ns / 1ps


module button_debounce #(
    parameter MAX_DEBOUNCE_COUNT = 14999999
    )(
    input btn,
    input clk,
    output reg btn_ready = 1
    );

    reg [31:0] debounce_count = 0;
    always @(posedge clk) begin
        if (btn && btn_ready) begin
            btn_ready <= 0;
        end
        if (!btn_ready && (debounce_count < MAX_DEBOUNCE_COUNT)) begin
            debounce_count <= debounce_count + 1;
        end else if (!btn_ready) begin
            debounce_count <= 0;
            btn_ready <= 1;
        end
    end
endmodule