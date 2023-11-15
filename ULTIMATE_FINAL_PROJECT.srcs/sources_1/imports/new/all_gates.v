`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2023 10:33:53 PM
// Design Name: 
// Module Name: all_gates
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

// takes in four inputs
// output 19 bits based on all the possible combination of inputs and gates
// output is only valid for the corresponding valid input
// eg: if 3-inputs AND is chosen, in[3] is still used for 4-inputs gates but the AND3 used in[2:0]
module all_gates(
    input [3:0]in,
    output [19:0]out
    );

    // Gate not used
    assign out[0] = 0;

    // AND
    assign out[1] = in[0] & in[1];                  // A & B
    assign out[2] = in[0] & in[1] & in[2];          // A & B & C
    assign out[3] = in[0] & in[1] & in[2] & in[3];  // A & B & C & D

    // NAND
    assign out[4] = ~(in[0] & in[1]);                   // ~(A & B)
    assign out[5] = ~(in[0] & in[1] & in[2]);           // ~(A & B & C)
    assign out[6] = ~(in[0] & in[1] & in[2] & in[3]);   // ~(A & B & C & D)

    // OR
    assign out[7] = in[0] | in[1];                  // A + B
    assign out[8] = in[0] | in[1] | in[2];          // A + B + C
    assign out[9] = in[0] | in[1] | in[2] | in[3];  // A + B + C + D

    // NOR
    assign out[10] = ~(in[0] | in[1]);                   // ~(A + B)
    assign out[11] = ~(in[0] | in[1] | in[2]);           // ~(A + B + C)
    assign out[12] = ~(in[0] | in[1] | in[2] | in[3]);   // ~(A + B + C + D)

    // XOR
    assign out[13] = in[0] ^ in[1];                  // A ^ B
    assign out[14] = in[0] ^ in[1] ^ in[2];          // A ^ B ^ C
    assign out[15] = in[0] ^ in[1] ^ in[2] ^ in[3];  // A ^ B ^ C ^ D

    // XNOR
    assign out[16] = ~(in[0] ^ in[1]);                   // ~(A ^ B)
    assign out[17] = ~(in[0] ^ in[1] ^ in[2]);           // ~(A ^ B ^ C)
    assign out[18] = ~(in[0] ^ in[1] ^ in[2] ^ in[3]);   // ~(A ^ B ^ C ^ D)

    // Gate not used
    assign out[19] = ~in[0];
endmodule
// Type     number
// Not used 0
// AND2     1
// AND3     2
// AND4     3
// NAND2    4
// NAND3    5
// NAND4    6
// OR2      7
// OR3      8
// OR4      9
// NOR2     10
// NOR3     11
// NOR4     12
// XOR2     13
// XOR3     14
// XOR4     15
// XNOR2    16
// XNOR3    17
// XNOR4    18
// NOT      19


