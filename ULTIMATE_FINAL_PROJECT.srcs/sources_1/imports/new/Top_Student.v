`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2023 10:27:37 PM
// Design Name: 
// Module Name: Top_Student
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


module Top_Student(
    input clock,
    input [15:0]sw,
    input btnC, 
    input btnU,
    input btnL, 
    input btnR, 
    input btnD, 
    inout PS2Data,
    inout PS2Clk,
    output [7:0]JA,
    output [7:0]JB,
    output [7:0]JC,
    output [7:0]seg,
    output [3:0]an,
    output [15:0]led
    );

    // Mouse ////////////////////////////////////////////////////////////////////////////
    wire [11:0]mouse_xpos;
    wire [11:0]mouse_ypos;
    wire mouse_left;
    wire mouse_middle;
    wire mouse_right;

    // kmap to circuit thing ////////////////////////////////////////////////////////////
    wire [3:0]AB;

    // circuit sim thing ////////////////////////////////////////////////////////////////
    wire [12:0]pix_pos_ja;
    wire [12:0]pix_pos_jb;
    wire [12:0]pix_pos_jc;
    wire [15:0]current_state;

    // in case if its needed
    wire [15:0]allstate_10;
    wire [15:0]allstate_11;
    wire [15:0]allstate_12;
    wire [15:0]allstate_13;

    wire [15:0]allstate_20;
    wire [15:0]allstate_21;
    wire [15:0]allstate_22;
    wire [15:0]allstate_23;
    
    wire [15:0]allstate_30;
    wire [15:0]allstate_31;
    wire [15:0]allstate_32;
    wire [15:0]allstate_33;

    // loaded gate inputs
    wire [15:0]gate_inputs_10_loaded;
    wire [15:0]gate_inputs_11_loaded;
    wire [15:0]gate_inputs_12_loaded;
    wire [15:0]gate_inputs_13_loaded;

    wire [15:0]gate_inputs_20_loaded;
    wire [15:0]gate_inputs_21_loaded;
    wire [15:0]gate_inputs_22_loaded;
    wire [15:0]gate_inputs_23_loaded;

    wire [15:0]gate_inputs_30_loaded;
    wire [15:0]gate_inputs_31_loaded;
    wire [15:0]gate_inputs_32_loaded;
    wire [15:0]gate_inputs_33_loaded;

    // loaded gate type
    wire [4:0]gate_type_10_loaded;
    wire [4:0]gate_type_11_loaded;
    wire [4:0]gate_type_12_loaded;
    wire [4:0]gate_type_13_loaded;

    wire [4:0]gate_type_20_loaded;
    wire [4:0]gate_type_21_loaded;
    wire [4:0]gate_type_22_loaded;
    wire [4:0]gate_type_23_loaded;

    wire [4:0]gate_type_30_loaded;
    wire [4:0]gate_type_31_loaded;
    wire [4:0]gate_type_32_loaded;
    wire [4:0]gate_type_33_loaded;

    wire [3:0]output_gate;
    wire [1:0]circuit_loaded;

    // menu and state chosser //////////////////////////////////////////////////////////////////////
    reg [3:0]mode_enable = 4'b0001;
    wire [1:0]mode_state;
    // 0: start up
    // 1: menu
    // 2: mode 1 - kmap to circuit
    // 3: mode 2 - circuit to simulation

    wire [15:0]oled_data_startup;
    wire [15:0]oled_data_mainmenu;

    // Main menu module  //
    parameter INIT_SCREEN = 0;
    parameter MENU_SCREEN = 1;
    parameter KMAP_CIR_SCREEN = 2;
    parameter CIR_SIM_SCREEN = 3;

    Menu menu(
        .CLOCK(clock), 
        .sw(sw[1:0]), 
        .btnC(btnC),  // used as a escape from mode 1 and 2, hence enabled for all mode, disabled for init screen internally
        .btnL(btnL & mode_enable[1]),
        .btnR(btnR & mode_enable[1]),
        .mode_state(mode_state), 
        .pixel_index(pix_pos_jb), 
        .oled_data_startup(oled_data_startup),
        .oled_data_mainmenu(oled_data_mainmenu)
    );
    
    // takes care of enable base on modes
    always @ (posedge clock) begin
        case (mode_state) 
            INIT_SCREEN:  // initial start up screen
                begin
                    mode_enable <= 4'b0001;
                end
            MENU_SCREEN:  // menu
                begin
                    mode_enable <= 4'b0010;
                end
            KMAP_CIR_SCREEN:  // mode 1 - kmap to circuit
                begin
                    mode_enable <= 4'b0100;
                end
            CIR_SIM_SCREEN:  // mode 2 - circuit to simulation
                begin
                    mode_enable <= 4'b1000;
                end
            default: 
                begin
                    mode_enable <= 4'b0000;
                end
        endcase
    end

    // student B and C top module ////////////////////////////////////////////////////////////////////
    wire [15:0]oled_data_student_bc;
    wire [15:0]led_data_student_bc;
    wire [31:0]segment_data_student_bc;

     student_bc_top_file(
         .clock(clock),
         .sw(sw),
         .btnL(btnL & mode_enable[KMAP_CIR_SCREEN]), 
         .btnR(btnR & mode_enable[KMAP_CIR_SCREEN]),     
         .pix_pos_jb(pix_pos_jb),  
         .oled_data_student_bc(oled_data_student_bc),
         .led_data_student_bc(led_data_student_bc),   
         .segment_data_student_bc(segment_data_student_bc)
     );


    // student A and D top module ////////////////////////////////////////////////////////////////////////
    wire [15:0]oled_data_student_a_ja;
    wire [15:0]oled_data_student_a_jb;

    student_a_top_file(
        .CLOCK(clock),
        .btnU(btnU & mode_enable[CIR_SIM_SCREEN]),          // changed from btnC to btnU
        .menu_pixelindex(pix_pos_ja),  
        .canvas_pixelindex(pix_pos_jb),  
        .menu_rgbdata(oled_data_student_a_ja),
        .canvas_rgbdata(oled_data_student_a_jb),
        .PS2Clk(PS2Clk),
        .PS2Data(PS2Data),
        .circuit_loaded(circuit_loaded),
        .output_gate(output_gate),

        .gate_inputs_10_loaded(gate_inputs_10_loaded), 
        .gate_inputs_11_loaded(gate_inputs_11_loaded),
        .gate_inputs_12_loaded(gate_inputs_12_loaded),
        .gate_inputs_13_loaded(gate_inputs_13_loaded),

        .gate_inputs_20_loaded(gate_inputs_20_loaded),
        .gate_inputs_21_loaded(gate_inputs_21_loaded),
        .gate_inputs_22_loaded(gate_inputs_22_loaded),
        .gate_inputs_23_loaded(gate_inputs_23_loaded),

       .gate_inputs_30_loaded(gate_inputs_30_loaded),
       .gate_inputs_31_loaded(gate_inputs_31_loaded),
       .gate_inputs_32_loaded(gate_inputs_32_loaded),
       .gate_inputs_33_loaded(gate_inputs_33_loaded),

       .gate_type_10_loaded(gate_type_10_loaded),
       .gate_type_11_loaded(gate_type_11_loaded),
       .gate_type_12_loaded(gate_type_12_loaded),
       .gate_type_13_loaded(gate_type_13_loaded),

       .gate_type_20_loaded(gate_type_20_loaded),
       .gate_type_21_loaded(gate_type_21_loaded),
       .gate_type_22_loaded(gate_type_22_loaded),
       .gate_type_23_loaded(gate_type_23_loaded),

       .gate_type_30_loaded(gate_type_30_loaded),
       .gate_type_31_loaded(gate_type_31_loaded),
       .gate_type_32_loaded(gate_type_32_loaded),
       .gate_type_33_loaded(gate_type_33_loaded)
    );

    wire [15:0]oled_data_student_d;
    wire [15:0]led_data_student_d;
    wire [31:0]segment_data_student_d;
    
    student_d_top_file(
        .clock(clock),
        .sw(sw),
        .btnD(btnD & mode_enable[CIR_SIM_SCREEN]),                                // toggle between oled pages
        .btnL(btnL & mode_enable[CIR_SIM_SCREEN]),                                // toggle between oled pages
        .btnR(btnR & mode_enable[CIR_SIM_SCREEN]),                                // toggle between oled pages
        .pix_pos(pix_pos_jc),            
        .output_gate(output_gate),                      //debug                         // specified by user to kmap/truth table which output
        .oled_data_student_d(oled_data_student_d),
        .led_data_student_d(led_data_student_d),         // will be tied to current_state
        .segment_data_student_d(segment_data_student_d),
        .current_state(current_state),                           // shows the logic level at all the points in the circuit
        .circuit_loaded(circuit_loaded),

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

        .gate_inputs_10_loaded(gate_inputs_10_loaded), 
        .gate_inputs_11_loaded(gate_inputs_11_loaded),
        .gate_inputs_12_loaded(gate_inputs_12_loaded),
        .gate_inputs_13_loaded(gate_inputs_13_loaded),

        .gate_inputs_20_loaded(gate_inputs_20_loaded),
        .gate_inputs_21_loaded(gate_inputs_21_loaded),
        .gate_inputs_22_loaded(gate_inputs_22_loaded),
        .gate_inputs_23_loaded(gate_inputs_23_loaded),

        .gate_inputs_30_loaded(gate_inputs_30_loaded),
        .gate_inputs_31_loaded(gate_inputs_31_loaded),
        .gate_inputs_32_loaded(gate_inputs_32_loaded),
        .gate_inputs_33_loaded(gate_inputs_33_loaded),

        .gate_type_10_loaded(gate_type_10_loaded),
        .gate_type_11_loaded(gate_type_11_loaded),
        .gate_type_12_loaded(gate_type_12_loaded),
        .gate_type_13_loaded(gate_type_13_loaded),

        .gate_type_20_loaded(gate_type_20_loaded),
        .gate_type_21_loaded(gate_type_21_loaded),
        .gate_type_22_loaded(gate_type_22_loaded),
        .gate_type_23_loaded(gate_type_23_loaded),

        .gate_type_30_loaded(gate_type_30_loaded),
        .gate_type_31_loaded(gate_type_31_loaded),
        .gate_type_32_loaded(gate_type_32_loaded),
        .gate_type_33_loaded(gate_type_33_loaded)
    );


    // peripherals drivers ////////////////////////////////////////////////////////////////////////
    oled_driver oled_JA(
        .clock(clock),
        .oled_data_0(0),    // not used
        .oled_data_1(0),    // not used
        .oled_data_2(0),    // not used
        .oled_data_3(oled_data_student_a_ja),    // gate menu for circuit simulation (Irwin)
        .oled_data_4(0),    // not used
        .state(mode_state),
        .enable(1),
        .pix_pos(pix_pos_ja),
        .PMOD(JA)
    );

    oled_driver oled_JB(
        .clock(clock),
        .oled_data_0(oled_data_startup),   // start up pic (Xin Ying)
        .oled_data_1(oled_data_mainmenu),   // main menu (Xin Ying)
        .oled_data_2(oled_data_student_bc),   // Kmap input and Circuit Drawer (Xin Ying and Wan Loong)
        .oled_data_3(oled_data_student_a_jb),   // gate canvas for circuit simulation (Irwin)
        .oled_data_4(0),   // not used
        .state(mode_state),
        .enable(1),
        .pix_pos(pix_pos_jb),
        .PMOD(JB)
    );

    oled_driver oled_JC(
        .clock(clock),
        .oled_data_0(0),    // not used
        .oled_data_1(0),    // not used
        .oled_data_2(0),    // not used
        .oled_data_3(oled_data_student_d), // truth table/kmap for circuit simulation (Zi Yang)
        .oled_data_4(0),    // not used
        .state(mode_state),
        .enable(1),
        .pix_pos(pix_pos_jc),
        .PMOD(JC)
    );

    led_driver led_array(
        .led_data_0(0),    // not used
        .led_data_1(0),     // not used
        .led_data_2(led_data_student_bc), 
        .led_data_3(led_data_student_d), // to show gate status 
        .led_data_4(0),    // not used
        .state(mode_state),
        .enable(1),
        .led_output(led)
    );

    seven_segment_driver seven_seg(
        .clock(clock),
        .segment_data_0(0),    // not used
        .segment_data_1(0),    // not used
        .segment_data_2(segment_data_student_bc), // to show gate view for kmap -> circuit
        .segment_data_3(segment_data_student_d), // to show gate type and pos for circuit sim
        .segment_data_4(0),    // not used
        .state(mode_state),
        .enable(1),
        .segment_output(seg),
        .anode_output(an)
    );
endmodule
