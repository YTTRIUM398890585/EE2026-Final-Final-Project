`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2023 12:19:07 AM
// Design Name: 
// Module Name: student_bc_top_file
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
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2023 12:19:07 AM
// Design Name: 
// Module Name: student_bc_top_file
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


module student_bc_top_file(
    input clock,
    input [15:0]sw,
    input btnL,
    input btnR,
    input [12:0]pix_pos_jb,  
    output reg [15:0]oled_data_student_bc,
    output reg [15:0]led_data_student_bc,
    output [31:0]segment_data_student_bc
);
    wire [3:0]AB;
    wire [15:0]reg_pixel_data;
    wire [15:0] oled_data;
    wire showcircuit;
    wire [15:0]led1;
    wire [15:0]led2;


    // AlgebraInput unit6(CLOCK, pix_index, btnL, btnR, btnC, oled_dataC);
    gate_screen unit2(clock, sw, led2, AB, reg_pixel_data, pix_pos_jb);
    kmap unit1(clock, pix_pos_jb,sw,btnR,btnL,oled_data,AB,showcircuit,led1);
    
    always@(posedge clock)begin
        if (showcircuit==0)begin 
            oled_data_student_bc <= oled_data;
            led_data_student_bc <= led1;
        end
       if (showcircuit==1)begin 
            oled_data_student_bc <= reg_pixel_data;
            led_data_student_bc <= led2;
        end
    end

assign segment_data_student_bc =0;

endmodule
