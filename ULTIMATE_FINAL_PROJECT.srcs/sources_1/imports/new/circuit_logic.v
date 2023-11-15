`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2023 10:54:26 PM
// Design Name: 
// Module Name: circuit_logic
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

/*
// written by Chai Zi Yang A0262349Y

based on inputs and gates chosen, computes all the signal for all the 2**NO_OF_POSSIBLE_IN_COMBI inputs
store the value in the allstate register to be used for display and what not

limitations:
1) possible number of stages 2^2 - 1 = 3, - 1 becasue input will be considered as stage 0
2) possible number of gates per stage to be 2^2 = 4, conseqeuntly possible input is also be 4 called ABCD
*/
module circuit_logic (
    input clock,
    input [3:0]input_abcd,         // used for current state
    output reg not_ready = 0,   // not_ready = 1 means not ready
    
    // port cannot be 2d array, so have to specify one by one, xy = stage x, gate y, stage 0 is taken as the input (ABCD) thus omitted  
    // specify gate input
    input [15:0]gate_inputs_10,
    input [15:0]gate_inputs_11,
    input [15:0]gate_inputs_12,
    input [15:0]gate_inputs_13,

    input [15:0]gate_inputs_20,
    input [15:0]gate_inputs_21,
    input [15:0]gate_inputs_22,
    input [15:0]gate_inputs_23,

    input [15:0]gate_inputs_30,
    input [15:0]gate_inputs_31,
    input [15:0]gate_inputs_32,
    input [15:0]gate_inputs_33,

    // specify gate type
    input [4:0]gate_type_10,
    input [4:0]gate_type_11,
    input [4:0]gate_type_12,
    input [4:0]gate_type_13,

    input [4:0]gate_type_20,
    input [4:0]gate_type_21,
    input [4:0]gate_type_22,
    input [4:0]gate_type_23,

    input [4:0]gate_type_30,
    input [4:0]gate_type_31,
    input [4:0]gate_type_32,
    input [4:0]gate_type_33,

    // output of all the gates, for each possible input (2^4 = 16)
    output reg [15:0]allstate_10 = 0,
    output reg [15:0]allstate_11 = 0,
    output reg [15:0]allstate_12 = 0,
    output reg [15:0]allstate_13 = 0,

    output reg [15:0]allstate_20 = 0,
    output reg [15:0]allstate_21 = 0,
    output reg [15:0]allstate_22 = 0,
    output reg [15:0]allstate_23 = 0,
    
    output reg [15:0]allstate_30 = 0,
    output reg [15:0]allstate_31 = 0,
    output reg [15:0]allstate_32 = 0,
    output reg [15:0]allstate_33 = 0,

    // output of the current state of the gates based on the previous current state and input
    // first 4 msb is for stage 0, msb is for gate 0 (input A)
    output reg [15:0]current_state_output = 0
);

    wire [15:0]gate_inputs[3:0][3:0];    // input of [1:0]stage [1:0]gate, parsed as [1:0]stage of input4, [1:0]gate of input4, ..., [1:0]stage of input1, [1:0]gate of input1 
    wire [4:0]gate_type[3:0][3:0];       // gate type of [stage][gate] is 1 out of 19 possibility including not used
    reg [15:0]allstates[3:0][3:0];      // output of [1:0]stage [1:0]gate when input is 1 out of 2^4 possibility, stage 
    reg current_state[3:0][3:0];    // current value of each stage and gate

    // assgin ports to 3d array for easier implementation
    // gate input
    assign gate_inputs[1][0] = gate_inputs_10;
    assign gate_inputs[1][1] = gate_inputs_11;
    assign gate_inputs[1][2] = gate_inputs_12;
    assign gate_inputs[1][3] = gate_inputs_13;

    assign gate_inputs[2][0] = gate_inputs_20;
    assign gate_inputs[2][1] = gate_inputs_21;
    assign gate_inputs[2][2] = gate_inputs_22;
    assign gate_inputs[2][3] = gate_inputs_23;

    assign gate_inputs[3][0] = gate_inputs_30;
    assign gate_inputs[3][1] = gate_inputs_31;
    assign gate_inputs[3][2] = gate_inputs_32;
    assign gate_inputs[3][3] = gate_inputs_33;

    // gate type
    assign gate_type[1][0] = gate_type_10;
    assign gate_type[1][1] = gate_type_11;
    assign gate_type[1][2] = gate_type_12;
    assign gate_type[1][3] = gate_type_13;

    assign gate_type[2][0] = gate_type_20;
    assign gate_type[2][1] = gate_type_21;
    assign gate_type[2][2] = gate_type_22;
    assign gate_type[2][3] = gate_type_23;

    assign gate_type[3][0] = gate_type_30;
    assign gate_type[3][1] = gate_type_31;
    assign gate_type[3][2] = gate_type_32;
    assign gate_type[3][3] = gate_type_33;

    reg [3:0]gate_index = 4'b0100; // run from 01 00 (stage 1, gate 0) to 11 11 (stage 3, gate 3), stage 0 skipped stage 0 as thats the input
    reg [3:0]possible_input = 4'b0000; 
    reg [3:0]in_all_gates = 4'b0000;
    wire [19:0]out_all_gates;
    reg state = 0;

    // to run all state, used for truth table and kmap
    all_gates u1(in_all_gates, out_all_gates);

    // to run current state, used for FFs
    reg [3:0]in_current_gates = 4'b0000;
    wire [19:0]out_current_gates;
    all_gates u2(in_current_gates, out_current_gates);

    initial begin
        // reset all state for all gates
        allstates[1][0] = 16'b0000_0000_0000_0000;
        allstates[1][1] = 16'b0000_0000_0000_0000;
        allstates[1][2] = 16'b0000_0000_0000_0000;
        allstates[1][3] = 16'b0000_0000_0000_0000;
        allstates[2][0] = 16'b0000_0000_0000_0000;
        allstates[2][1] = 16'b0000_0000_0000_0000;
        allstates[2][2] = 16'b0000_0000_0000_0000;
        allstates[2][3] = 16'b0000_0000_0000_0000;
        allstates[3][0] = 16'b0000_0000_0000_0000;
        allstates[3][1] = 16'b0000_0000_0000_0000;
        allstates[3][2] = 16'b0000_0000_0000_0000;
        allstates[3][3] = 16'b0000_0000_0000_0000;

        // set all state field for input ABCD
        allstates[0][0] = 16'b1111_1111_0000_0000;  // input A
        allstates[0][1] = 16'b1111_0000_1111_0000;  // input B
        allstates[0][2] = 16'b1100_1100_1100_1100;  // input C
        allstates[0][3] = 16'b1010_1010_1010_1010;  // input D

        // reset all bits in current_state
        current_state[1][0] = 0;
        current_state[1][1] = 0;
        current_state[1][2] = 0;
        current_state[1][3] = 0;
        current_state[2][0] = 0;
        current_state[2][1] = 0;
        current_state[2][2] = 0;
        current_state[2][3] = 0;
        current_state[3][0] = 0;
        current_state[3][1] = 0;
        current_state[3][2] = 0;
        current_state[3][3] = 0;
    end

    // Clock for processing circuit
    wire clk10m;  // m = 4
    clock_gen clk10m_gen(.clk_in(clock), .m(4), .clk_out(clk10m));

    always @ (posedge clk10m) begin
        if (not_ready == 0) begin
            not_ready <= !not_ready;

            // shift data to output when finish
            // for all state
            allstate_10 <= allstates[1][0];
            allstate_11 <= allstates[1][1];
            allstate_12 <= allstates[1][2];
            allstate_13 <= allstates[1][3];

            allstate_20 <= allstates[2][0];
            allstate_21 <= allstates[2][1];
            allstate_22 <= allstates[2][2];
            allstate_23 <= allstates[2][3];

            allstate_30 <= allstates[3][0];
            allstate_31 <= allstates[3][1];
            allstate_32 <= allstates[3][2];
            allstate_33 <= allstates[3][3];

            // for current state
            current_state_output[15] <= current_state[0][0];
            current_state_output[14] <= current_state[0][1];
            current_state_output[13] <= current_state[0][2];
            current_state_output[12] <= current_state[0][3];

            current_state_output[11] <= current_state[1][0];
            current_state_output[10] <= current_state[1][1];
            current_state_output[9] <= current_state[1][2];
            current_state_output[8] <= current_state[1][3];

            current_state_output[7] <= current_state[2][0];
            current_state_output[6] <= current_state[2][1];
            current_state_output[5] <= current_state[2][2];
            current_state_output[4] <= current_state[2][3];

            current_state_output[3] <= current_state[3][0];
            current_state_output[2] <= current_state[3][1];
            current_state_output[1] <= current_state[3][2];
            current_state_output[0] <= current_state[3][3];

            // take in input_abcd input when running for current state
            current_state[0][0] = input_abcd[3];
            current_state[0][1] = input_abcd[2];
            current_state[0][2] = input_abcd[1];
            current_state[0][3] = input_abcd[0];

            // reset gate_index and possible_input register to clear just in case
            gate_index <= 4'b0100;
            possible_input <= 4'b0000;
        end

        // pass in value stored in allstates in to all gates with mux
        else if (not_ready == 1 && state == 0) begin
            // set the input to all_gate accordingly

            // for allstates
            in_all_gates[0] <= allstates[gate_inputs[gate_index[3:2]][gate_index[1:0]][3:2]]
                                        [gate_inputs[gate_index[3:2]][gate_index[1:0]][1:0]]
                                        [possible_input];
            in_all_gates[1] <= allstates[gate_inputs[gate_index[3:2]][gate_index[1:0]][7:6]]
                                        [gate_inputs[gate_index[3:2]][gate_index[1:0]][5:4]]
                                        [possible_input];
            in_all_gates[2] <= allstates[gate_inputs[gate_index[3:2]][gate_index[1:0]][11:10]]
                                        [gate_inputs[gate_index[3:2]][gate_index[1:0]][9:8]]
                                        [possible_input];
            in_all_gates[3] <= allstates[gate_inputs[gate_index[3:2]][gate_index[1:0]][15:14]]
                                        [gate_inputs[gate_index[3:2]][gate_index[1:0]][13:12]]
                                        [possible_input];

            // for current state
            in_current_gates[0] <= current_state[gate_inputs[gate_index[3:2]][gate_index[1:0]][3:2]]
                                                [gate_inputs[gate_index[3:2]][gate_index[1:0]][1:0]];
            in_current_gates[1] <= current_state[gate_inputs[gate_index[3:2]][gate_index[1:0]][7:6]]
                                                [gate_inputs[gate_index[3:2]][gate_index[1:0]][5:4]];
            in_current_gates[2] <= current_state[gate_inputs[gate_index[3:2]][gate_index[1:0]][11:10]]
                                                [gate_inputs[gate_index[3:2]][gate_index[1:0]][9:8]];
            in_current_gates[3] <= current_state[gate_inputs[gate_index[3:2]][gate_index[1:0]][15:14]]
                                                [gate_inputs[gate_index[3:2]][gate_index[1:0]][13:12]];

            state <= 1;
        end 

        // update value in allstates accordingly
        else if (not_ready == 1 && state == 1) begin
            // store the output value from all_gate to output register 

            // for allstates
            allstates[gate_index[3:2]][gate_index[1:0]][possible_input] <= out_all_gates[gate_type[gate_index[3:2]][gate_index[1:0]]];

            // for current state
            current_state[gate_index[3:2]][gate_index[1:0]] <= out_current_gates[gate_type[gate_index[3:2]][gate_index[1:0]]];

            // increment gate_index and possible_input, reset and clear not_ready flag when finish
            possible_input <= possible_input + 1;
            gate_index <= (possible_input == 4'b1111) ? gate_index + 1 : gate_index;

            // clear ready flag when finish
            not_ready <= ((possible_input == 4'b1111) && (gate_index == 4'b1111)) ? 0 : not_ready;

            state <= 0;
        end      
    end     
endmodule
