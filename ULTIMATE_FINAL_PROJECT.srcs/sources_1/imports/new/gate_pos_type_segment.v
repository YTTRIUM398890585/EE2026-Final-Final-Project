`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2023 11:13:14 PM
// Design Name: 
// Module Name: gate_pos_type_segment
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
/* 
shows the position and type of gate the output is selected
this is implemented here so that can accedd the 3d array easily
*/
module gate_pos_type_segment(
        input clock,
        output reg [31:0]segment_data_pos_type = 0,    // for seven segment
        input [3:0]output_gate,                         // for seven segment
        
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
        input [4:0]gate_type_33
    );

    wire [4:0]gate_type[3:0][3:0];       // gate type of [stage][gate] is 1 out of 19 possibility including not used
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

    // Clock segment data changing
    wire clk1k;    //  m = 49999
    reg [31:0]counter = 0;
    clock_gen clk1k_gen(.clk_in(clock), .m(49_999), .clk_out(clk1k));

    parameter DURATION_MS = 1000;
    parameter SEG_NOT = 32'b0011_0111__0101_1100__0111_1000__0000_0000;
    parameter SEG_AND = 32'b0111_0111__0011_0111__0101_1110__0000_0000;
    parameter SEG_NAND = 32'b0011_0111__0111_0111__0011_0111__0101_1110;
    parameter SEG_OR = 32'b0101_1100__0101_0000__0000_0000__0000_0000;
    parameter SEG_NOR = 32'b0011_0111__0101_1100__0101_0000__0000_0000;
    parameter SEG_XOR = 32'b0111_0110__0101_1100__0101_0000__0000_0000;
    parameter SEG_XNOR = 32'b0111_0110__0011_0111__0101_1100__0101_0000;
    parameter SEG_UNUSED = 32'b0100_0000__0100_0000__0100_0000__0100_0000;

    parameter SEG_A = 32'b0111_0111__0000_0000__0000_0000__0000_0000;
    parameter SEG_B = 32'b0111_1100__0000_0000__0000_0000__0000_0000;
    parameter SEG_C = 32'b0011_1001__0000_0000__0000_0000__0000_0000;
    parameter SEG_D = 32'b0101_1110__0000_0000__0000_0000__0000_0000;

    parameter SEG_0 = 8'b0011_1111;
    parameter SEG_1 = 8'b0000_0110;
    parameter SEG_2 = 8'b0101_1011;
    parameter SEG_3 = 8'b0100_1111;

    wire [7:0]stage_seg;
    wire [7:0]gate_seg;

    assign stage_seg = output_gate[3:2] == 2'b00 ? SEG_0 : 
                        output_gate[3:2] == 2'b01 ? SEG_1 : 
                        output_gate[3:2] == 2'b10 ? SEG_2 : 
                        output_gate[3:2] == 2'b11 ? SEG_3 : 
                        8'b1111_1111;                           // all on for debug

    assign gate_seg = output_gate[1:0] == 2'b00 ? SEG_0 : 
                        output_gate[1:0] == 2'b01 ? SEG_1 : 
                        output_gate[1:0] == 2'b10 ? SEG_2 : 
                        output_gate[1:0] == 2'b11 ? SEG_3 : 
                        8'b1111_1111;                           // all on for debug

    wire [31:0]type_seg;
    
    assign type_seg = gate_type[output_gate[3:2]][output_gate[1:0]] == 0 ? output_gate[3:2] == 0 ? output_gate[1:0] == 0 ? SEG_A : 
                                                                                                    output_gate[1:0] == 1 ? SEG_B :
                                                                                                    output_gate[1:0] == 2 ? SEG_C :
                                                                                                    SEG_D :
                                                                                                    SEG_UNUSED : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 1 ? SEG_AND : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 2 ? SEG_AND : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 3 ? SEG_AND : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 4 ? SEG_NAND : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 5 ? SEG_NAND : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 6 ? SEG_NAND : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 7 ? SEG_OR : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 8 ? SEG_OR : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 9 ? SEG_OR : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 10 ? SEG_NOR : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 11 ? SEG_NOR : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 12 ? SEG_NOR : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 13 ? SEG_XOR : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 14 ? SEG_XOR : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 15 ? SEG_XOR : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 16 ? SEG_XNOR : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 17 ? SEG_XNOR : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 18 ? SEG_XNOR : 
                        gate_type[output_gate[3:2]][output_gate[1:0]] == 19 ? SEG_NOT : 
                        32'b1111_1111__1111_1111__1111_1111__1111_1111;     // all on for debug

    always @(posedge clk1k) begin
        if (counter < DURATION_MS) begin    
            // show position
            segment_data_pos_type = {8'b0000_0000, stage_seg, gate_seg, 8'b0000_0000};

            counter = counter + 1;
        end else begin
            // show gate type
            segment_data_pos_type = type_seg;
            
            counter = counter > DURATION_MS * 2 ? 0 : counter + 1;
        end
    end
endmodule
