`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 12:50:46
// Design Name: 
// Module Name: mouseinput_interpreter
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


module mouseinput_interpreter(
    input CLOCK,
    input mouse_leftclick,
    input mouse_middleclick,
    input mouse_rightclick,
    output mouse_leftpressed,
    output mouse_middlepressed,
    output mouse_rightpressed
    );
    /*Signal hold debounce*/
    // sighold_debounce #(
    //     .MAX_DEBOUNCE_COUNT(999_999)
    // )(
    //     .clk(CLOCK),
    //     .noisy_sig(mouse_leftclick),
    //     .debounced_sig(mouse_leftpressed));
    // sighold_debounce #(
    //     .MAX_DEBOUNCE_COUNT(999_999)
    //     )(
    //     .clk(CLOCK),
    //     .noisy_sig(mouse_middleclick),
    //     .debounced_sig(mouse_middlepressed));
    // sighold_debounce #(
    //     .MAX_DEBOUNCE_COUNT(999_999)
    //         )(
    //     .clk(CLOCK),
    //     .noisy_sig(mouse_rightclick),
    //     .debounced_sig(mouse_rightpressed));

    /*Signal ignore debounce*/
    wire mouse_leftpressedrdy;
    sigignore_debounce #(
        .MAX_DEBOUNCE_COUNT(999_9999)
    )(
        .sig(mouse_leftclick),
        .clk(CLOCK),
        .sig_ready(mouse_leftpressedrdy));
    
    wire mouse_middlepressedrdy;
    sigignore_debounce #(
        .MAX_DEBOUNCE_COUNT(999_9999)
    )(
        .sig(mouse_middleclick),
        .clk(CLOCK),
        .sig_ready(mouse_middlepressedrdy));

    wire mouse_rightpressedrdy;
    sigignore_debounce #(
        .MAX_DEBOUNCE_COUNT(999_9999)
    )(
        .sig(mouse_rightclick),
        .clk(CLOCK),
        .sig_ready(mouse_rightpressedrdy));
    
    assign mouse_leftpressed = (mouse_leftclick && mouse_leftpressedrdy) ? 1 : 0;
    assign mouse_middlepressed = (mouse_middleclick && mouse_middlepressedrdy) ? 1 : 0;
    assign mouse_rightpressed = (mouse_rightclick && mouse_rightpressedrdy) ? 1 : 0;

endmodule
