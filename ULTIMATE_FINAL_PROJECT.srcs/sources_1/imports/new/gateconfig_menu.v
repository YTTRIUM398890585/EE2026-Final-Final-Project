`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 06:30:10
// Design Name: 
// Module Name: gateconfig_menu
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


module gateconfig_menu(
    input CLOCK,
    input gateconfig_en,
    input [7:0] menu_xcoord,
    input [6:0] menu_ycoord,
    input [16:0] menubtn_pressed,
    input [11:0] canvasbtn_pressed,
    input [20:0] selected_gatedata,
    output reg loaddata_rdy = 0,
    output reg [3:0] selected_gridcell = 0,
    output reg [4:0] logicgate = 0,
    output [20:0] new_gatedata,
    /*Outputs for display rendering*/
    output numinputs_is_zero,
    output numinputs_is_one,
    output numinputs_is_two,
    output numinputs_is_three,
    output numinputs_is_four,
    output [4:0] stageinput_is_zero,
    output [4:0] stageinput_is_one,
    output [4:0] stageinput_is_two,
    output [4:0] stageinput_is_three,
    output [4:0] gateinput_is_zero,
    output [4:0] gateinput_is_one,
    output [4:0] gateinput_is_two,
    output [4:0] gateinput_is_three,
    output [4:0] gateinput_is_four,
    output reg [2:0] numinputs = 0
    );

    wire clk_10MHz;
    improved_clock # (
        .OUTPUT_FREQUENCY(10_000_000)
    )(
        .CLOCK(CLOCK),
        .IMPROVED_CLOCK(clk_10MHz));

    /*Wiring and labelling canvas buttons*/
    wire [11:0] btn_gridcell;
    generate
        for (genvar num_gridcells = 0; num_gridcells < 12; num_gridcells = num_gridcells + 1)
            assign btn_gridcell[num_gridcells] = canvasbtn_pressed[num_gridcells];
    endgenerate
    /*Wiring and labelling menu buttons*/
    wire [4:1] btn_stageinput;
    wire [4:1] btn_gateinput;
    wire btn_numinput;
    wire [8:1] btn_logicgateinput;
    generate
        for (genvar num_stageinputs = 0; num_stageinputs < 4; num_stageinputs = num_stageinputs + 1) begin
            assign btn_stageinput[num_stageinputs + 1] = menubtn_pressed[num_stageinputs];
        end
        
        for (genvar num_gateinputs = 0; num_gateinputs < 4; num_gateinputs = num_gateinputs + 1) begin
            assign btn_gateinput[num_gateinputs + 1] = menubtn_pressed[num_gateinputs + 4];
        end
        
        assign btn_numinput = menubtn_pressed[8];
        
        for (genvar num_logicgates = 0; num_logicgates < 8; num_logicgates = num_logicgates + 1) begin
            assign btn_logicgateinput[num_logicgates + 1] = menubtn_pressed[num_logicgates + 9];
        end
    endgenerate
    
    /*Load initialisation variables*/
    reg [1:0] load_count = 0;
    reg load_counten = 0;
    reg load_init = 0;
    
    /*Stage inputs*/
    reg [1:0] stageinput1;
    reg [1:0] stageinput2;
    reg [1:0] stageinput3;
    reg [1:0] stageinput4;
    
    /*Gate inputs*/
    reg [1:0] gateinput1;
    reg [1:0] gateinput2;
    reg [1:0] gateinput3;
    reg [1:0] gateinput4;
    
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
    
    /*Logic gate (without number of inputs)*/
    parameter NOT = 19;
    parameter AND = 20;
    parameter NAND = 21;
    parameter OR = 22;
    parameter NOR = 23;
    parameter XOR = 24;
    parameter XNOR = 25;
    
    /*To decode gate type*/
    wire [4:0] loaded_gatetype;
    assign loaded_gatetype = selected_gatedata[4:0];
    
    assign no_gate = (loaded_gatetype == NOGATE);
    assign not_gate = (loaded_gatetype == NOT);
    assign and_gates = (loaded_gatetype == AND2) || (loaded_gatetype == AND3) || (loaded_gatetype == AND4);
    assign nand_gates = (loaded_gatetype == NAND2) || (loaded_gatetype == NAND3) || (loaded_gatetype == NAND4);
    assign or_gates = (loaded_gatetype == OR2) || (loaded_gatetype == OR3) || (loaded_gatetype == OR4);
    assign nor_gates = (loaded_gatetype == NOR2) || (loaded_gatetype == NOR3) || (loaded_gatetype == NOR4);
    assign xor_gates = (loaded_gatetype == XOR2) || (loaded_gatetype == XOR3) || (loaded_gatetype == XOR4);
    assign xnor_gates = (loaded_gatetype == XNOR2) || (loaded_gatetype == XNOR3) || (loaded_gatetype == XNOR4);
    assign twoinput_gates = (loaded_gatetype == AND2) || (loaded_gatetype == NAND2) || (loaded_gatetype == OR2)
    || (loaded_gatetype == NOR2) || (loaded_gatetype == XOR2) || (loaded_gatetype == XNOR2);
    assign threeinput_gates = (loaded_gatetype == AND3) || (loaded_gatetype == NAND3) || (loaded_gatetype == OR3)
    || (loaded_gatetype == NOR3) || (loaded_gatetype == XOR3) || (loaded_gatetype == XNOR3);
    assign fourinput_gates = (loaded_gatetype == AND4) || (loaded_gatetype == NAND4) || (loaded_gatetype == OR4)
    || (loaded_gatetype == NOR4) || (loaded_gatetype == XOR4) || (loaded_gatetype == XNOR4);
    
    /*Gate config logic*/
    always @(posedge CLOCK) begin
        /*Load counter to account for port read latency (at least 2 clock cycles)*/
        if (|btn_gridcell) begin
            loaddata_rdy <= 0;
            load_count <= 0;
            load_counten <= 1;
            load_init <= 0;
        end else begin
            loaddata_rdy <= (load_count == 2) ? 1 : loaddata_rdy;
            load_count <= (load_count < 2) && load_counten ? load_count + 1 : 0; 
            load_counten <= (load_count == 2) ? 0 : load_counten;
            load_init <= (load_count == 2) ? 1 : 0;
        end
        /*Mapping canvas buttons to grid cell*/
        if (btn_gridcell[0]) selected_gridcell <= 0;
        if (btn_gridcell[1]) selected_gridcell <= 1;
        if (btn_gridcell[2]) selected_gridcell <= 2;
        if (btn_gridcell[3]) selected_gridcell <= 3;
        if (btn_gridcell[4]) selected_gridcell <= 4;
        if (btn_gridcell[5]) selected_gridcell <= 5;
        if (btn_gridcell[6]) selected_gridcell <= 6;
        if (btn_gridcell[7]) selected_gridcell <= 7;
        if (btn_gridcell[8]) selected_gridcell <= 8;
        if (btn_gridcell[9]) selected_gridcell <= 9;
        if (btn_gridcell[10]) selected_gridcell <= 10;
        if (btn_gridcell[11]) selected_gridcell <= 11;
        /*Loading selected gate data and decoding gate type*/
        if (load_init) begin
            /*Loading stage and gate inputs*/
            stageinput4 <= selected_gatedata[20:19];
            gateinput4 <= selected_gatedata[18:17];
            stageinput3 <= selected_gatedata[16:15];
            gateinput3 <= selected_gatedata[14:13];
            stageinput2 <= selected_gatedata[12:11];
            gateinput2 <= selected_gatedata[10:9];
            stageinput1 <= selected_gatedata[8:7];
            gateinput1 <= selected_gatedata[6:5];
            /*Loading gate type*/
            if (no_gate) begin
                logicgate <= NOGATE;
                numinputs <= 0;
            end
            if (not_gate) begin
                logicgate <= NOT;
                numinputs <= 1;
            end
            if (and_gates) logicgate <= AND;
            if (nand_gates) logicgate <= NAND;
            if (or_gates) logicgate <= OR;
            if (nor_gates) logicgate <= NOR;
            if (xor_gates) logicgate <= XOR;
            if (xnor_gates) logicgate <= XNOR;
            if (twoinput_gates) numinputs <= 2;
            if (threeinput_gates) numinputs <= 3;
            if (fourinput_gates) numinputs <= 4;
            /*Clear load_init flag once finish loading*/
            load_init <= 0;
        end else begin
            /*Changing stage and gate input states based on display button input*/
            stageinput1 <= btn_stageinput[1] ? stageinput1 + 1 : stageinput1;
            stageinput2 <= btn_stageinput[2] ? stageinput2 + 1 : stageinput2;
            stageinput3 <= btn_stageinput[3] ? stageinput3 + 1 : stageinput3;
            stageinput4 <= btn_stageinput[4] ? stageinput4 + 1 : stageinput4;
            gateinput1 <= btn_gateinput[1] ? gateinput1 + 1 : gateinput1;
            gateinput2 <= btn_gateinput[2] ? gateinput2 + 1 : gateinput2;
            gateinput3 <= btn_gateinput[3] ? gateinput3 + 1 : gateinput3;
            gateinput4 <= btn_gateinput[4] ? gateinput4 + 1 : gateinput4;
            /*Changing numinputs based on display button input and gatetype*/
            if (btn_numinput) begin
                case (logicgate)
                    NOGATE: numinputs <= 0;
                    NOT: numinputs <= 1;
                    AND: numinputs <= (numinputs < 4) ? numinputs + 1 : 2;
                    NAND: numinputs <= (numinputs < 4) ? numinputs + 1 : 2;
                    OR: numinputs <= (numinputs < 4) ? numinputs + 1 : 2;
                    NOR: numinputs <= (numinputs < 4) ? numinputs + 1 : 2;
                    XOR: numinputs <= (numinputs < 4) ? numinputs + 1 : 2;
                    XNOR: numinputs <= (numinputs < 4) ? numinputs + 1 : 2;
                endcase
            end
            /*Changing logicgate based on display button input*/
            if (btn_logicgateinput[1]) begin
                logicgate <= AND;
                numinputs <= (numinputs < 2) ? 2 : numinputs;
            end
            if (btn_logicgateinput[2]) begin
                logicgate <= NAND;
                numinputs <= (numinputs < 2) ? 2 : numinputs;
            end
            if (btn_logicgateinput[3]) begin
                logicgate <= OR;
                numinputs <= (numinputs < 2) ? 2 : numinputs;
            end
            if (btn_logicgateinput[4]) begin
                logicgate <= NOR;
                numinputs <= (numinputs < 2) ? 2 : numinputs;
            end
            if (btn_logicgateinput[5]) begin
                logicgate <= XOR;
                numinputs <= (numinputs < 2) ? 2 : numinputs;
            end
            if (btn_logicgateinput[6]) begin
                logicgate <= XNOR;
                numinputs <= (numinputs < 2) ? 2 : numinputs;
            end
            if (btn_logicgateinput[7]) begin
                logicgate <= NOT;
                numinputs <= 1;
            end
            if (btn_logicgateinput[8]) begin
                logicgate <= NOGATE;
                numinputs <= 0;
            end
        end
    end

    /*Encoding gate type based on logicgate and numinputs*/
    reg [4:0] new_gatetype;
    always @(posedge CLOCK) begin
        if (logicgate == NOGATE) new_gatetype <= NOGATE;
        if (logicgate == NOT) new_gatetype <= NOT;
        if (numinputs == 2) begin
            case (logicgate)
                AND: new_gatetype <= AND2;
                NAND: new_gatetype <= NAND2;
                OR: new_gatetype <= OR2;
                NOR: new_gatetype <= NOR2;
                XOR: new_gatetype <= XOR2;
                XNOR: new_gatetype <= XNOR2;
            endcase
        end
        if (numinputs == 3) begin
            case (logicgate)
                AND: new_gatetype <= AND3;
                NAND: new_gatetype <= NAND3;
                OR: new_gatetype <= OR3;
                NOR: new_gatetype <= NOR3;
                XOR: new_gatetype <= XOR3;
                XNOR: new_gatetype <= XNOR3;
            endcase
        end
        if (numinputs == 4) begin
            case (logicgate)
                AND: new_gatetype <= AND4;
                NAND: new_gatetype <= NAND4;
                OR: new_gatetype <= OR4;
                NOR: new_gatetype <= NOR4;
                XOR: new_gatetype <= XOR4;
                XNOR: new_gatetype <= XNOR4;
            endcase
        end
    end

    assign new_gatedata = {stageinput4, gateinput4, stageinput3, gateinput3, stageinput2, gateinput2, 
    stageinput1, gateinput1, new_gatetype};

    numinputs_display #(
        .ORIGIN_X(45),
        .ORIGIN_Y(11)
        )(
        .CLOCK(CLOCK),
        .numinputs_state(numinputs),
        .oleddisplay_xcoord(menu_xcoord),
        .oleddisplay_ycoord(menu_ycoord),
        .show_zero(numinputs_is_zero),
        .show_one(numinputs_is_one),
        .show_two(numinputs_is_two),
        .show_three(numinputs_is_three),
        .show_four(numinputs_is_four));
    
    wire [1:0] selectedstage_state;
    assign selectedstage_state = selected_gridcell[3:2] + 1;
    stagedisplay_control(
        .CLOCK(CLOCK),
        .numinputs(numinputs),
        .menu_xcoord(menu_xcoord),
        .menu_ycoord(menu_ycoord),
        .stageinput4_state(stageinput4),
        .stageinput3_state(stageinput3),
        .stageinput2_state(stageinput2),
        .stageinput1_state(stageinput1),
        .selectedstage_state(selectedstage_state),
        .stageinput_is_zero(stageinput_is_zero),
        .stageinput_is_one(stageinput_is_one),
        .stageinput_is_two(stageinput_is_two),
        .stageinput_is_three(stageinput_is_three));
    
    wire [1:0] selectedgate_state;
    assign selectedgate_state = selected_gridcell[1:0];
    gatedisplay_control(
        .CLOCK(CLOCK),
        .numinputs(numinputs),
        .menu_xcoord(menu_xcoord),
        .menu_ycoord(menu_ycoord),
        .gateinput4_state(gateinput4),
        .gateinput3_state(gateinput3),
        .gateinput2_state(gateinput2),
        .gateinput1_state(gateinput1),
        .selectedgate_state(selectedgate_state),
        .gateinput_is_zero(gateinput_is_zero),
        .gateinput_is_one(gateinput_is_one),
        .gateinput_is_two(gateinput_is_two),
        .gateinput_is_three(gateinput_is_three),
        .gateinput_is_four(gateinput_is_four));
endmodule
