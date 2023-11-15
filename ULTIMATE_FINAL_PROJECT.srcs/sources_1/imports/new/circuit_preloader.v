`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2023 06:54:35 PM
// Design Name: 
// Module Name: circuit_preloader
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

// written by Chai Zi Yang A0262349Y
module circuit_preloader(
    input clock,
    input btnL, 
    input btnR,
    input load_lock,
    output reg [31:0]segment_data_circuit_loaded = 0,
    output reg [1:0]circuit_loaded = 0
    );

    // segment stuff
    // parameter SEG_USER = 32'b0011_1110__0110_1101__0111_1001__0101_0000;
    // parameter SEG_2ADD = 32'b0101_1011__0111_0111__0101_1110__0101_1110;
    // parameter SEG_SRFF = 32'b0110_1101__0101_0000__0111_0001__0111_0001;
    // parameter SEG_JKFF = 32'b0001_1110__0111_0101__0111_0001__0111_0001;
    parameter SEG_CIR1 = 32'b0111_0000__0000_1000__0110_0000__0000_1100;
    parameter SEG_CIR2 = 32'b0111_0000__0000_1000__0110_0000__0111_0110;
    parameter SEG_CIR3 = 32'b0111_0000__0000_1000__0110_0000__0101_1110;
    parameter SEG_CIR4 = 32'b0111_0000__0000_1000__0110_0000__0100_1110;

    wire btnL_ready;
    wire btnR_ready;
    wire btn_clock;
    clock_gen btn_clock_gen(.clk_in(clock), .m(49999), .clk_out(btn_clock));  // 1kHz m = 49999

    button_debounce #(
        .MAX_DEBOUNCE_COUNT(300)
    ) btnL_debouncer (
        .btn(btnL),
        .clk(btn_clock),
        .btn_ready(btnL_ready)
    );

    button_debounce #(
        .MAX_DEBOUNCE_COUNT(300)
    ) btnR_debouncer (
        .btn(btnR),
        .clk(btn_clock),
        .btn_ready(btnR_ready)
    );

    always @(posedge btn_clock) begin
        if (btnL && btnL_ready) begin
            circuit_loaded <= circuit_loaded == 2'b00 || load_lock ? circuit_loaded : circuit_loaded - 1;
        end else if (btnR && btnR_ready) begin
            circuit_loaded <= circuit_loaded == 2'b11 || load_lock ? circuit_loaded : circuit_loaded + 1;
        end
    end

    always @(circuit_loaded) begin
        case(circuit_loaded)
            0: 
                begin
                    segment_data_circuit_loaded <= SEG_CIR1;
                end
            1: 
                begin
                    segment_data_circuit_loaded <= SEG_CIR2;
                end
            2: 
                begin
                    segment_data_circuit_loaded <= SEG_CIR3;
                end
            3: 
                begin
                    segment_data_circuit_loaded <= SEG_CIR4;
                end
        endcase
    end
endmodule
