`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2023 11:52:44 AM
// Design Name: 
// Module Name: student_d_top_file
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
module student_d_top_file(
    input clock,
    input [15:0]sw,
    input btnD,                         // toggle between oled pages
    input btnL,                         // preload left
    input btnR,                         // preload right
    input [12:0]pix_pos,            
    input [3:0]output_gate,             // specified by user to kmap/truth table which output
    output [15:0]oled_data_student_d,
    output [15:0]led_data_student_d,         // will be tied to current_state
    output [31:0]segment_data_student_d,
    output [15:0]current_state,         // shows the logic level at all the points in the circuit
    output [1:0]circuit_loaded,

    // output of all the gates, for each possible input (2^4 = 16)
    output [15:0]allstate_10,
    output [15:0]allstate_11,
    output [15:0]allstate_12,
    output [15:0]allstate_13,

    output [15:0]allstate_20,
    output [15:0]allstate_21,
    output [15:0]allstate_22,
    output [15:0]allstate_23,
    
    output [15:0]allstate_30,
    output [15:0]allstate_31,
    output [15:0]allstate_32,
    output [15:0]allstate_33,

    input [15:0]gate_inputs_10_loaded, 
    input [15:0]gate_inputs_11_loaded,
    input [15:0]gate_inputs_12_loaded,
    input [15:0]gate_inputs_13_loaded,

    input [15:0]gate_inputs_20_loaded,
    input [15:0]gate_inputs_21_loaded,
    input [15:0]gate_inputs_22_loaded,
    input [15:0]gate_inputs_23_loaded,

    input [15:0]gate_inputs_30_loaded,
    input [15:0]gate_inputs_31_loaded,
    input [15:0]gate_inputs_32_loaded,
    input [15:0]gate_inputs_33_loaded,

    input [4:0]gate_type_10_loaded,
    input [4:0]gate_type_11_loaded,
    input [4:0]gate_type_12_loaded,
    input [4:0]gate_type_13_loaded,

    input [4:0]gate_type_20_loaded,
    input [4:0]gate_type_21_loaded,
    input [4:0]gate_type_22_loaded,
    input [4:0]gate_type_23_loaded,

    input [4:0]gate_type_30_loaded,
    input [4:0]gate_type_31_loaded,
    input [4:0]gate_type_32_loaded,
    input [4:0]gate_type_33_loaded
    );

    wire [15:0]oled_data_truth_table;
    wire [15:0]oled_data_kmap;
    wire [31:0]segment_data_pos_type;
    wire [31:0]segment_data_circuit_loaded;

    /* 
    detects sequential circuit/wrongly implemented by opposing flow of simulation by checking if gate input have input from same stage or stage infront
    then disables truth table and kmap displays
    */
    wire it_is_sequencial;

    assign it_is_sequencial = (gate_inputs_10_loaded | gate_inputs_11_loaded | gate_inputs_12_loaded | gate_inputs_13_loaded) & 16'b1100_1100_1100_1100 ? 1 :
                                (gate_inputs_20_loaded | gate_inputs_21_loaded | gate_inputs_22_loaded | gate_inputs_23_loaded) & 16'b1000_1000_1000_1000 ? 1 :
                                gate_inputs_30_loaded[15:14] == 2'b11 || gate_inputs_30_loaded[11:10] == 2'b11 || gate_inputs_30_loaded[7:6] == 2'b11 || gate_inputs_30_loaded[3:2] == 2'b11 ? 1 :
                                gate_inputs_31_loaded[15:14] == 2'b11 || gate_inputs_31_loaded[11:10] == 2'b11 || gate_inputs_31_loaded[7:6] == 2'b11 || gate_inputs_31_loaded[3:2] == 2'b11 ? 1 :
                                gate_inputs_32_loaded[15:14] == 2'b11 || gate_inputs_32_loaded[11:10] == 2'b11 || gate_inputs_32_loaded[7:6] == 2'b11 || gate_inputs_32_loaded[3:2] == 2'b11 ? 1 :
                                gate_inputs_33_loaded[15:14] == 2'b11 || gate_inputs_33_loaded[11:10] == 2'b11 || gate_inputs_33_loaded[7:6] == 2'b11 || gate_inputs_33_loaded[3:2] == 2'b11 ? 1 :
                                0;

    /* 
    to select a screen of truth table or kmap with btnD
    double click will lock loading, segment will have decimals when locked
    */
    reg oled_page = 0;  // 0 = truth table, 1 = kmap
    wire btn_ready;
    wire btn_clock;
    reg [31:0]double_click_counter = 0;
    reg load_lock = 0;
    clock_gen btn_clock_gen(.clk_in(clock), .m(49999), .clk_out(btn_clock));  // 1kHz m = 49999

    button_debounce #(
        .MAX_DEBOUNCE_COUNT(230)
    )(
        .btn(btnD),
        .clk(btn_clock),
        .btn_ready(btn_ready)
    );

    always @(posedge btn_clock) begin
        double_click_counter <= double_click_counter == 0 ? double_click_counter : double_click_counter - 1;

        if (btnD && btn_ready && double_click_counter == 0) begin
            double_click_counter <= 300;
        end

        if (btnD && btn_ready && double_click_counter > 1) begin
            // double clicked
            load_lock = ~load_lock;
            double_click_counter <= 0;
        end 

        if (double_click_counter == 1) begin
            // single click
            oled_page <= ~oled_page;
        end 
    end

    assign oled_data_student_d = oled_page ? oled_data_kmap : oled_data_truth_table;

    /* 
    led is tied to each of the logic level of the gates
    */
    assign led_data_student_d = current_state;

    /* 
    clock generator for simulations
    */
    wire clk1;
    wire clk10;
    wire clk1k;
    wire input_c;

    clock_gen clk1_gen(.clk_in(clock), .m(49999999), .clk_out(clk1));  //  1Hz m = 49999999
    clock_gen clk10_gen(.clk_in(clock), .m(4999999), .clk_out(clk10));  // 10Hz m = 4999999
    clock_gen clk1k_gen(.clk_in(clock), .m(49999), .clk_out(clk1k));  // 1kHz m = 49999
    
    assign input_c = sw[11:10] == 2'b00 ? sw[13] :
                        sw[11:10] == 2'b01 ? clk1 :  
                        sw[11:10] == 2'b10 ? clk10 :  
                        sw[11:10] == 2'b11 ? clk1k :
                        sw[13];                             // default to input switch C

    /* 
    to show circuit loaded, when changed, otherwise will show pos type
    */
    wire segment_circuit_load_clock;
    reg [31:0]segment_data_student_d_internal = 0;
    reg [31:0]circuit_load_counter = 0;
    clock_gen segment_circuit_load_clock_gen(.clk_in(clock), .m(4999), .clk_out(segment_circuit_load_clock));  //  10 kHz m = 4999

    always @ (posedge segment_circuit_load_clock) begin
        if (btnL || btnR) begin
            circuit_load_counter <= 10000;
        end

        if (circuit_load_counter != 0) begin
            segment_data_student_d_internal <= segment_data_circuit_loaded;
            circuit_load_counter <= circuit_load_counter - 1;
        end else begin
            segment_data_student_d_internal <= segment_data_pos_type;
        end
    end

    assign segment_data_student_d = load_lock ? segment_data_student_d_internal | 32'h80_80_80_80 : segment_data_student_d_internal;
    
    /* 
    module to use preloaded circuit or user circuit
    */
    circuit_preloader circuit_loader(
        .clock(clock),
        .btnL(btnL), 
        .btnR(btnR),
        .load_lock(load_lock),
        .segment_data_circuit_loaded(segment_data_circuit_loaded),
        .circuit_loaded(circuit_loaded)
    );

    /* 
    module to simulate the circuit made by the user, output allstates for the plotting of
    truth table and kmap, output current state for the on the fly simulation of the circuit
    used for simulating flip flops
    */
    circuit_logic circuit_analyser(
        .clock(clock),
        .input_abcd({sw[15:14], input_c, sw[12]}),      // sw needed for the current state simulation
        .not_ready(),                                   // not_ready = 1 means not ready, not used as the thing runs too fast to notice
        
        // port cannot be 2d array, so have to specify one by one, xy = stage x, gate y, stage 0 is taken as the input (ABCD) thus omitted  
        // specify gate input
        .gate_inputs_10(gate_inputs_10_loaded),
        .gate_inputs_11(gate_inputs_11_loaded),
        .gate_inputs_12(gate_inputs_12_loaded),
        .gate_inputs_13(gate_inputs_13_loaded),

        .gate_inputs_20(gate_inputs_20_loaded),
        .gate_inputs_21(gate_inputs_21_loaded),
        .gate_inputs_22(gate_inputs_22_loaded),
        .gate_inputs_23(gate_inputs_23_loaded),

        .gate_inputs_30(gate_inputs_30_loaded),
        .gate_inputs_31(gate_inputs_31_loaded),
        .gate_inputs_32(gate_inputs_32_loaded),
        .gate_inputs_33(gate_inputs_33_loaded),

        // specify gate type
        .gate_type_10(gate_type_10_loaded),
        .gate_type_11(gate_type_11_loaded),
        .gate_type_12(gate_type_12_loaded),
        .gate_type_13(gate_type_13_loaded),

        .gate_type_20(gate_type_20_loaded),
        .gate_type_21(gate_type_21_loaded),
        .gate_type_22(gate_type_22_loaded),
        .gate_type_23(gate_type_23_loaded),

        .gate_type_30(gate_type_30_loaded),
        .gate_type_31(gate_type_31_loaded),
        .gate_type_32(gate_type_32_loaded),
        .gate_type_33(gate_type_33_loaded),

        // output of all the gates, for each possible input (2^4 = 16)
        .allstate_10(allstate_10),
        .allstate_11(allstate_11),
        .allstate_12(allstate_12),
        .allstate_13(allstate_13),

        .allstate_20(allstate_20),
        .allstate_21(allstate_21),
        .allstate_22(allstate_22),
        .allstate_23(allstate_23),
        
        .allstate_30(allstate_30),
        .allstate_31(allstate_31),
        .allstate_32(allstate_32),
        .allstate_33(allstate_33),

        .current_state_output(current_state)
    );

    /* 
    module to plot truth table base on allstates
    highlights the input based on the input switches, sw[15:12]
    */
    truth_table_gen truth_table(
        .clock(clock),
        .input_abcd({sw[15:14], input_c, sw[12]}),
        .pix_pos(pix_pos),
        .oled_data(oled_data_truth_table),
        .output_gate(output_gate), // which gate is the truth table tied to
        .enable(~it_is_sequencial),

        .allstate_10(allstate_10),
        .allstate_11(allstate_11),
        .allstate_12(allstate_12),
        .allstate_13(allstate_13),

        .allstate_20(allstate_20),
        .allstate_21(allstate_21),
        .allstate_22(allstate_22),
        .allstate_23(allstate_23),
        
        .allstate_30(allstate_30),
        .allstate_31(allstate_31),
        .allstate_32(allstate_32),
        .allstate_33(allstate_33)
    );

    /* 
    module to plot kmap base on allstates
    highlights the input based on the input switches, sw[15:12]
    */
    kmap_gen kmap(
        .clock(clock),
        .input_abcd({sw[15:14], input_c, sw[12]}),
        .pix_pos(pix_pos),
        .oled_data(oled_data_kmap),
        .output_gate(output_gate), // which gate is the truth table tied to
        .enable(~it_is_sequencial),

        .allstate_10(allstate_10),
        .allstate_11(allstate_11),
        .allstate_12(allstate_12),
        .allstate_13(allstate_13),

        .allstate_20(allstate_20),
        .allstate_21(allstate_21),
        .allstate_22(allstate_22),
        .allstate_23(allstate_23),
        
        .allstate_30(allstate_30),
        .allstate_31(allstate_31),
        .allstate_32(allstate_32),
        .allstate_33(allstate_33)
    );

    /* 
    shows the position and type of gate the output is selected
    this is implemented here so that can accedd the 3d array easily
    */
    gate_pos_type_segment segment(
        .clock(clock),
        .segment_data_pos_type(segment_data_pos_type),    // for seven segment
        .output_gate(output_gate), 
        
        // specify gate type
        .gate_type_10(gate_type_10_loaded),
        .gate_type_11(gate_type_11_loaded),
        .gate_type_12(gate_type_12_loaded),
        .gate_type_13(gate_type_13_loaded),

        .gate_type_20(gate_type_20_loaded),
        .gate_type_21(gate_type_21_loaded),
        .gate_type_22(gate_type_22_loaded),
        .gate_type_23(gate_type_23_loaded),

        .gate_type_30(gate_type_30_loaded),
        .gate_type_31(gate_type_31_loaded),
        .gate_type_32(gate_type_32_loaded),
        .gate_type_33(gate_type_33_loaded)
    );
endmodule
