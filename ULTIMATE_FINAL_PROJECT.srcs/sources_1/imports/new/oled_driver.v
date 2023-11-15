`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2023 01:07:31 PM
// Design Name: 
// Module Name: oled_driver
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

// takes in 5 possible states and MUX the output for OLED, 
// features:
// enable
// able to take any PMOD port
module oled_driver(
    input clock,
    input [15:0]oled_data_0,
    input [15:0]oled_data_1,
    input [15:0]oled_data_2,
    input [15:0]oled_data_3,
    input [15:0]oled_data_4,
    input [2:0]state,
    input enable,
    output [12:0]pix_pos,
    output [7:0]PMOD
    );
    // Clock for OLED
    wire clk6p25m;  // m = 7
    clock_gen clk6p25m_gen(.clk_in(clock), .m(7), .clk_out(clk6p25m));
    
    // Stuff
    reg [15:0]oled_data = 0;
    
    // state and enable are synchonous signal
    always @ (*) begin
        if (!enable) begin
            // if disabled, show black screen
            oled_data <= 16'b00000_000000_00000;
        end else begin
            case (state) 
                3'b000: // data 0
                    begin
                        oled_data <= oled_data_0;
                    end
                3'b001: // data 1
                    begin
                        oled_data <= oled_data_1;
                    end
                3'b010: // data 2
                    begin
                        oled_data <= oled_data_2;
                    end
                3'b011: // data 3
                    begin
                        oled_data <= oled_data_3;
                    end
                3'b100: // data 4
                    begin
                        oled_data <= oled_data_4;
                    end
                default: // keep for debugging
                    begin
                        // all red
                        oled_data <= 16'b11111_000000_00000;
                    end
            endcase
        end
    end
    
    // instantiate oled
    Oled_Display oled(
        .clk(clk6p25m), 
        .reset(0), 
        .frame_begin(), 
        .sending_pixels(),
        .sample_pixel(), 
        .pixel_index(pix_pos), 
        .pixel_data(oled_data), 
        .cs(PMOD[0]), 
        .sdin(PMOD[1]), 
        .sclk(PMOD[3]), 
        .d_cn(PMOD[4]), 
        .resn(PMOD[5]), 
        .vccen(PMOD[6]),
        .pmoden(PMOD[7])
    );
endmodule
