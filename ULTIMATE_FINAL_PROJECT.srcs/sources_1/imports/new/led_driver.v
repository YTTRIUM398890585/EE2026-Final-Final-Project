`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2023 01:06:51 PM
// Design Name: 
// Module Name: led_driver
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

// takes in 5 possible states and MUX the output for LED, 
// features:
// enable
module led_driver(
    input [15:0]led_data_0,
    input [15:0]led_data_1,
    input [15:0]led_data_2,
    input [15:0]led_data_3,
    input [15:0]led_data_4,
    input [2:0]state,
    input enable,
    output reg [15:0]led_output = 0
    );
    
    // state and enable are synchonous signal
    always @ (*) begin
        if (!enable) begin
            // if disabled, all off
            led_output <= 16'b0000_0000_0000_0000;
        end else begin
            case (state) 
                3'b000: // Task 0
                    begin
                        led_output <= led_data_0;
                    end
                3'b001: // Task A
                    begin
                        led_output <= led_data_1;
                    end
                3'b010: // Task B
                    begin
                        led_output <= led_data_2;
                    end
                3'b011: // Task C
                    begin
                        led_output <= led_data_3;
                    end
                3'b100: // Task D
                    begin
                        led_output <= led_data_4;
                    end
                default: // keep for debugging
                    begin
                        // all on
                        led_output <= 16'b1111_1111_1111_1111;
                    end
            endcase
        end
    end
endmodule
