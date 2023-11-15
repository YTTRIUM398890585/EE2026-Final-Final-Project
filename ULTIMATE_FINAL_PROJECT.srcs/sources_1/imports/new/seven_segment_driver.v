`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2023 01:07:12 PM
// Design Name: 
// Module Name: seven_segment_driver
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

// takes in 5 possible states and MUX the output for the seven segment, 
// features:
// enable
// takes active high input 
module seven_segment_driver(
    input clock,
    input [31:0]segment_data_0,
    input [31:0]segment_data_1,
    input [31:0]segment_data_2,
    input [31:0]segment_data_3,
    input [31:0]segment_data_4,
    input [2:0]state,
    input enable,
    output reg [7:0]segment_output = 0,
    output reg [3:0]anode_output = 0
    );
    
    // Clock for segment multiplexing
    wire clk1k;    //  m = 49999
    clock_gen clk1k_gen(.clk_in(clock), .m(49999), .clk_out(clk1k));
    // cannot too fast, else ghost image, maybe cuz not enough time between clock cycle to run 
    
    // stuff for multiplexing
    reg [31:0]segment_data = 0;
    reg [1:0]segment_count = 0; // 2 bit to store 4 state - the four digits
    
    // takes care of MUX for state
    always @ (*) begin
        if (!enable) begin
            // if disabled, all off
            segment_data <= 32'b0000_0000__0000_0000__0000_0000__0000_0000;
        end else begin
            case (state) 
                3'b000: // Task 0
                    begin
                        segment_data <= segment_data_0;
                    end
                3'b001: // Task A
                    begin
                        segment_data <= segment_data_1;
                    end
                3'b010: // Task B
                    begin
                        segment_data <= segment_data_2;
                    end
                3'b011: // Task C
                    begin
                        segment_data <= segment_data_3;
                    end
                3'b100: // Task D
                    begin
                        segment_data <= segment_data_4;
                    end
                default: // keep for debugging
                    begin
                        // all on
                        segment_data <= 32'b1111_1111__1111_1111__1111_1111__1111_1111;
                    end
            endcase
        end
    end
    
    // sevens segment multiplexing
    always @ (posedge clk1k) begin
        case (segment_count)
            2'b00:
                begin
                    segment_output <= ~segment_data[7:0];    
                    anode_output <= ~4'b0001;                
                end
            2'b01:
                begin
                    segment_output <= ~segment_data[15:8]; 
                    anode_output <= ~4'b0010;              
                end
            2'b10:
                begin
                    segment_output <= ~segment_data[23:16];   
                    anode_output <= ~4'b0100;                 
                end
            2'b11:
                begin            
                    segment_output <= ~segment_data[31:24]; 
                    anode_output <= ~4'b1000;     
                end
            default: // debug
                begin
                    // all on
                    anode_output <= ~4'b1111;  
                    segment_output <= ~32'b1111_1111__1111_1111__1111_1111__1111_1111;
                end
        endcase
        
        segment_count = segment_count + 1;   // no need to manually reset since its 2 bits
    end
    
endmodule
