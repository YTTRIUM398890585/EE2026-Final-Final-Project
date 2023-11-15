`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2023 18:13:37
// Design Name: 
// Module Name: canvas_grid
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


module canvas_grid(
    input CLOCK,
    input gateconfig_en,
    input loaddata_rdy,
    input [1:0] circuit_loaded,
    input [3:0] selected_gridcell,
    input [7:0] canvas_xcoord,
    input [6:0] canvas_ycoord,
    input [20:0] new_gatedata,
    output reg is_gridline = 0,
    output reg is_logicgate = 0,
    output [20:0] selected_gatedata,

    /*Outputs for circuit simulation*/
    output reg [15:0]gate_inputs_10_loaded, 
    output reg [15:0]gate_inputs_11_loaded,
    output reg [15:0]gate_inputs_12_loaded,
    output reg [15:0]gate_inputs_13_loaded,

    output reg [15:0]gate_inputs_20_loaded,
    output reg [15:0]gate_inputs_21_loaded,
    output reg [15:0]gate_inputs_22_loaded,
    output reg [15:0]gate_inputs_23_loaded,

    output reg [15:0]gate_inputs_30_loaded,
    output reg [15:0]gate_inputs_31_loaded,
    output reg [15:0]gate_inputs_32_loaded,
    output reg [15:0]gate_inputs_33_loaded,

    output reg [4:0]gate_type_10_loaded,
    output reg [4:0]gate_type_11_loaded,
    output reg [4:0]gate_type_12_loaded,
    output reg [4:0]gate_type_13_loaded,

    output reg [4:0]gate_type_20_loaded,
    output reg [4:0]gate_type_21_loaded,
    output reg [4:0]gate_type_22_loaded,
    output reg [4:0]gate_type_23_loaded,

    output reg [4:0]gate_type_30_loaded,
    output reg [4:0]gate_type_31_loaded,
    output reg [4:0]gate_type_32_loaded,
    output reg [4:0]gate_type_33_loaded
    );

    /*Grid dimensions and parameters*/
    // GRIDCELL_WIDTH and GRIDCELL_HEIGHT includes the grid line as well
    parameter GRIDCELL_WIDTH = 32;
    parameter GRIDCELL_HEIGHT = 16;
    parameter GRID_COLUMNS = 3;
    parameter GRID_ROWS = 4;
    
    /*Translating x and y coordinates to grid index and grid cell index*/         
    wire [3:0] grid_index;
    wire [8:0] gridcell_index;
    wire is_gridcell;
    
    xy_to_grid #(
        .GRIDCELL_WIDTH(GRIDCELL_WIDTH),
        .GRIDCELL_HEIGHT(GRIDCELL_HEIGHT),
        .GRID_COLUMNS(GRID_COLUMNS),
        .GRID_ROWS(GRID_ROWS)
        )(
        .CLOCK(CLOCK),
        .x(canvas_xcoord),
        .y(canvas_ycoord),
        .grid_index(grid_index),
        .gridcell_index(gridcell_index),
        .is_gridcell(is_gridcell));
    
    /*Accessing logicgate_rom for logic gate drawings using gridcell_index*/
    wire [4:0] gatedrawing_code;
    logicgate_rom (
        .clka(CLOCK),
        .addra(gridcell_index),
        .douta(gatedrawing_code));
    
    /*Starting addresses for each circuit*/
    parameter CIRCUIT1 = 0;
    parameter CIRCUIT2 = 12;
    parameter CIRCUIT3 = 24;
    parameter CIRCUIT4 = 36;
    reg [5:0] circuit_selected;
    always @(posedge CLOCK) begin
        case (circuit_loaded)
            0: circuit_selected <= CIRCUIT1;
            1: circuit_selected <= CIRCUIT2;
            2: circuit_selected <= CIRCUIT3;
            3: circuit_selected <= CIRCUIT4;
        endcase
    end
    
    /*Memory control for canvas grid*/    
    wire [20:0] current_gate;
    canvasgrid_ram (
        /*Read and write when gate configuration is enabled*/
        .clka(CLOCK),
        .wea(gateconfig_en && loaddata_rdy),
        .addra(circuit_selected + selected_gridcell),
        .dina(new_gatedata),
        .douta(selected_gatedata),
        /*Read for rendering and circuit simulation*/
        .clkb(CLOCK),
        .web(0),
        .addrb(circuit_selected + grid_index),
        .doutb(current_gate));
    
    // Gate variables for logic gate drawings and circuit simulation
    wire [4:0] gate_type;
    assign gate_type = current_gate[4:0];
    wire [16:0] gate_inputs;
    assign gate_inputs = current_gate[20:5];
    
    always @(posedge CLOCK) begin
     case (grid_index)
        0: begin
            gate_inputs_10_loaded <= gate_inputs;
            gate_type_10_loaded <= gate_type;
        end
        1: begin
            gate_inputs_11_loaded <= gate_inputs;
            gate_type_11_loaded <= gate_type;
        end
        2: begin
            gate_inputs_12_loaded <= gate_inputs;
            gate_type_12_loaded <= gate_type;
        end
        3: begin
            gate_inputs_13_loaded <= gate_inputs;
            gate_type_13_loaded <= gate_type;
        end
        4: begin
            gate_inputs_20_loaded <= gate_inputs;
            gate_type_20_loaded <= gate_type;
        end
        5: begin
            gate_inputs_21_loaded <= gate_inputs;
            gate_type_21_loaded <= gate_type;
        end
        6: begin
            gate_inputs_22_loaded <= gate_inputs;
            gate_type_22_loaded <= gate_type;
        end
        7: begin
            gate_inputs_23_loaded <= gate_inputs;
            gate_type_23_loaded <= gate_type;
        end
        8: begin
            gate_inputs_30_loaded <= gate_inputs;
            gate_type_30_loaded <= gate_type;
        end
        9: begin
            gate_inputs_31_loaded <= gate_inputs;
            gate_type_31_loaded <= gate_type;
        end
        10: begin
            gate_inputs_32_loaded <= gate_inputs;
            gate_type_32_loaded <= gate_type;
        end
        11: begin
            gate_inputs_33_loaded <= gate_inputs;
            gate_type_33_loaded <= gate_type;
        end
     endcase
    end
    /*Gate type*/
    parameter NOGATE = 0;
    parameter AND2 = 1;
    parameter AND3 = 2;
    parameter AND4 = 3;
    parameter NAND2 = 4;
    parameter NAND3 = 5;
    parameter NAND4 = 6;
    parameter OR2 = 7;
    parameter OR3 = 8;
    parameter OR4 = 9;
    parameter NOR2 = 10;
    parameter NOR3 = 11;
    parameter NOR4 = 12;
    parameter XOR2 = 13;
    parameter XOR3 = 14;
    parameter XOR4 = 15;
    parameter XNOR2 = 16;
    parameter XNOR3 = 17;
    parameter XNOR4 = 18;
    parameter NOT = 19;
    
    /*Logic gate drawings*/
    parameter NOGATE_DRAWING = 5'b00_000;
    parameter ALLGATE_DRAWING = 5'b00_001;
    parameter AND_DRAWING = 5'b00_010;
    parameter OR_DRAWING = 5'b00_011;
    parameter XOR_DRAWING = 5'b00_100;
    parameter NOT_DRAWING = 5'b00_101;
    parameter BUBBLE_DRAWING = 5'b00_110;
    parameter ANDorNOT_DRAWING = 5'b00_111;
    parameter ORorAND_DRAWING = 5'b01_000;
    parameter IN1_DRAWING = 5'b01_001;
    parameter IN2_DRAWING = 5'b01_010;
    parameter IN3_DRAWING = 5'b01_011;
    parameter IN4_DRAWING = 5'b01_100; 
    /*Gate input templates*/
    // 1 input
    wire in1_template;
    assign in1_template = gatedrawing_code == IN1_DRAWING;
    // 2 inputs
    wire in2_template;
    assign in2_template = in1_template || (gatedrawing_code == IN2_DRAWING);
    // 3 inputs
    wire in3_template;
    assign in3_template = in2_template || (gatedrawing_code == IN3_DRAWING);
    // 4 inputs
    wire in4_template;
    assign in4_template = in3_template || (gatedrawing_code == IN4_DRAWING);
    
    /*Gate templates*/
    // AND gate
    wire andgate_template;
    assign andgate_template = (gatedrawing_code == ALLGATE_DRAWING) || (gatedrawing_code == AND_DRAWING) 
    || (gatedrawing_code == ANDorNOT_DRAWING) || (gatedrawing_code == ORorAND_DRAWING);
    // NAND gate
    wire nandgate_template;
    assign nandgate_template = andgate_template || (gatedrawing_code == BUBBLE_DRAWING);
    // OR gate
    wire orgate_template;
    assign orgate_template = (gatedrawing_code == ALLGATE_DRAWING) || (gatedrawing_code == OR_DRAWING)
    || (gatedrawing_code == ORorAND_DRAWING);
    // NOR gate
    wire norgate_template;
    assign norgate_template = orgate_template || (gatedrawing_code == BUBBLE_DRAWING);
    // XOR gate
    wire xorgate_template;
    assign xorgate_template = orgate_template || (gatedrawing_code == XOR_DRAWING);
    // XNOR gate
    wire xnorgate_template;
    assign xnorgate_template = xorgate_template || (gatedrawing_code == BUBBLE_DRAWING);
    // NOT gate
    wire notgate_template;
    assign notgate_template = (gatedrawing_code == ALLGATE_DRAWING) || (gatedrawing_code == NOT_DRAWING) 
    || (gatedrawing_code == ANDorNOT_DRAWING) || (gatedrawing_code == BUBBLE_DRAWING) || in1_template;
    
    always @(posedge CLOCK) begin
        if (is_gridcell) begin
            is_gridline <= 0;
            case (gate_type)
                NOGATE: is_logicgate <= 0;
                AND2: is_logicgate <= andgate_template || in2_template ? 1 : 0;
                AND3: is_logicgate <= andgate_template || in3_template ? 1 : 0;
                AND4: is_logicgate <= andgate_template || in4_template ? 1 : 0;
                NAND2: is_logicgate <= nandgate_template || in2_template ? 1 : 0;
                NAND3: is_logicgate <= nandgate_template || in3_template ? 1 : 0;
                NAND4: is_logicgate <= nandgate_template || in4_template ? 1 : 0;
                OR2: is_logicgate <= orgate_template || in2_template ? 1 : 0;
                OR3: is_logicgate <= orgate_template || in3_template ? 1 : 0;
                OR4: is_logicgate <= orgate_template || in4_template ? 1 : 0;
                NOR2: is_logicgate <= norgate_template || in2_template ? 1 : 0;
                NOR3: is_logicgate <= norgate_template || in3_template ? 1 : 0;
                NOR4: is_logicgate <= norgate_template || in4_template ? 1 : 0;
                XOR2: is_logicgate <= xorgate_template || in2_template ? 1 : 0;
                XOR3: is_logicgate <= xorgate_template || in3_template ? 1 : 0;
                XOR4: is_logicgate <= xorgate_template || in4_template ? 1 : 0;
                XNOR2: is_logicgate <= xnorgate_template || in2_template ? 1 : 0;
                XNOR3: is_logicgate <= xnorgate_template || in3_template ? 1 : 0;
                XNOR4: is_logicgate <= xnorgate_template || in4_template ? 1 : 0;
                NOT: is_logicgate <= notgate_template ? 1 : 0;
            endcase
        end else begin
            is_logicgate <= 0;
            is_gridline <= 1;
        end
    end
endmodule
