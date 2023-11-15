module gate_screen (clock, sw, led, AB, reg_pixel_data, wire_pixel_index);
input clock;
input [3:0] AB;
input [12:0] wire_pixel_index;
input [15:0] sw;
output [15:0] led;
//output [7:0] JB;
parameter [31:0]m_6p25m = 32'd7;
parameter [6:0]x_draw = 6'd27, x_increase = 6'd22;
parameter [5:0]y_draw = 5'd17, y_increase = 5'd14;
parameter [15:0] pixel_data_A = 16'b11111_000000_00000;
parameter [15:0] pixel_data_B = 16'b00000_111111_00000;
parameter [15:0] pixel_data_not_0 = 16'b00000_000000_11111;
parameter [15:0] pixel_data_not_1 = 16'b11111_100000_00000;
parameter [15:0] pixel_data_and_0 = 16'b00000_111100_01111;
parameter [15:0] pixel_data_and_1 = 16'b01111_000000_11110;
parameter [15:0] pixel_data_word = 16'b11111_111111_11111;

output reg [15:0] reg_pixel_data = 16'b0; 
//reg [3:0] kmap = 8'b0000;
wire [1:0] draw_not, draw_and;
wire draw_or;
wire [6:0] draw_wA, draw_wB;           
wire [4:0] draw_wnot0, draw_wnot1;
wire [2:0] draw_wand0, draw_wand1;
wire drawA, drawB, drawOUT;

wire wire_clock_6p25m;
wire wire_frame_begin, wire_sending_pixels, wire_sample_pixel;
//wire [12:0]wire_pixel_index;

wire [6:0] x, x_out_not_0, x_out_not_1, 
            x_out_and_0, x_out_and_1,
            x_out_or_0;
    
wire [5:0] y, y_out_not_0, y_out_not_1,  
    y_out_and_0, y_out_and_1,
    y_out_or_0;  

wire [15:0] pd_A, pd_B, pd_OUT;

wire [15:0] pd_rainbow;

wire [15:0] pd_rainbow_rect_0, pd_rainbow_rect_1, pd_rainbow_rect_2, pd_rainbow_rect_3;

wire [15:0] pd_not_0, pd_not_1,
            pd_and_0, pd_and_1,
            pd_or_0;

wire [15:0] pd_wA_0, pd_wA_1, pd_wA_2, pd_wA_3, pd_wA_4, pd_wA_5, pd_wA_6;
wire [15:0] pd_wB_0, pd_wB_1, pd_wB_2, pd_wB_3, pd_wB_4, pd_wB_5, pd_wB_6;
 
wire [15:0] pd_wnot0_0, pd_wnot0_1, pd_wnot0_2, pd_wnot0_3, pd_wnot0_4;
wire [15:0] pd_wnot1_0, pd_wnot1_1, pd_wnot1_2, pd_wnot1_3, pd_wnot1_4;

wire [15:0] pd_wand0_0, pd_wand0_1, pd_wand0_2;
wire [15:0] pd_wand1_0, pd_wand1_1, pd_wand1_2;
            
wire not_0_in, not_1_in;
reg [1:0]and_0_in, and_1_in; 
reg [1:0]or_0_in; 

wire not_0_out, not_1_out;
wire and_0_out, and_1_out;
wire or_0_out;

wire and_0_in_A_0, and_0_in_A_1, or_0_in_A_0, or_0_in_A_1, and_1_in_A_0,
    and_1_in_B_1, and_1_in_B_0, or_0_in_B_1, or_0_in_B_0, and_0_in_B_0,
    and_0_in_not0, or_0_in_not0_0, or_0_in_not0_1, and_1_in_not0,
    and_1_in_not1, or_0_in_not1_1, or_0_in_not1_0, and_0_in_not1,
    or_0_in_and0_0, or_0_in_and0_1,
    or_0_in_and1_1, or_0_in_and1_0;
//
assign led[0] = or_0_out;
//
k_map k_map_0(.kmap(AB),                 
                .draw_not(draw_not), .draw_and(draw_and), .draw_or(draw_or),
                .draw_wA(draw_wA), .draw_wB(draw_wB),
                .draw_wnot0(draw_wnot0), .draw_wnot1(draw_wnot1),
                .draw_wand0(draw_wand0), .draw_wand1(draw_wand1),
                .drawA(drawA), .drawB(drawB), .drawOUT(drawOUT));
clk_divider clk_divider_6p25m(.CLOCK(clock), .my_m_value(m_6p25m), .clk_output(wire_clock_6p25m));
pixel_index_to_xy(.pixel_index(wire_pixel_index), .x(x), .y(y));
//Oled_Display oled_display_0(.clk(wire_clock_6p25m), .reset(0), .frame_begin(wire_frame_begin), .sending_pixels(wire_sending_pixels), .sample_pixel(wire_sample_pixel), .pixel_index(wire_pixel_index), .pixel_data(reg_pixel_data), .cs(JB[0]), .sdin(JB[1]), .sclk(JB[3]), .d_cn(JB[4]),.resn(JB[5]), .vccen(JB[6]), .pmoden(JB[7]));
rainbow rainbow_0(.clock(clock), .reg_pixel_data(pd_rainbow));
//
draw_rect rainbow_rect_0 (.draw(1), .pixel_data(pd_rainbow), .x(x), .x_draw(0), .x_end(95), .y(y), .y_draw(0), .y_end(3), .reg_pixel_data(pd_rainbow_rect_0));
draw_rect rainbow_rect_1 (.draw(1), .pixel_data(pd_rainbow), .x(x), .x_draw(0), .x_end(95), .y(y), .y_draw(60), .y_end(63), .reg_pixel_data(pd_rainbow_rect_1));
draw_rect rainbow_rect_2 (.draw(1), .pixel_data(pd_rainbow), .x(x), .x_draw(0), .x_end(3), .y(y), .y_draw(0), .y_end(63), .reg_pixel_data(pd_rainbow_rect_2));
draw_rect rainbow_rect_3 (.draw(1), .pixel_data(pd_rainbow), .x(x), .x_draw(92), .x_end(95), .y(y), .y_draw(0), .y_end(63), .reg_pixel_data(pd_rainbow_rect_3));
//
draw_A A(.draw(drawA), .pixel_data(pixel_data_word), .x(x), .x_draw(x_draw - 19), .y(y), .y_draw(y_draw - 2), .reg_pixel_data(pd_A));
draw_B B(.draw(drawB), .pixel_data(pixel_data_word), .x(x), .x_draw(x_draw - 19), .y(y), .y_draw(y_draw + y_increase * 2 - 2), .reg_pixel_data(pd_B));
draw_OUT OUT(.draw(drawOUT), .pixel_data(pixel_data_word), .x(x), .x_draw(x_out_or_0 + 2), .y(y), .y_draw(y_out_or_0 - 2), .reg_pixel_data(pd_OUT));
//
NOT not_0(.A(not_0_in), .Z(not_0_out), .draw(draw_not[0]), .x(x), .x_draw(x_draw), .x_out(x_out_not_0), .y(y), .y_draw(y_draw), .y_out(y_out_not_0), .reg_pixel_data(pd_not_0));
NOT not_1(.A(not_1_in), .Z(not_1_out), .draw(draw_not[1]), .x(x), .x_draw(x_draw), .x_out(x_out_not_1), .y(y), .y_draw(y_draw + y_increase * 2), .y_out(y_out_not_1), .reg_pixel_data(pd_not_1));
//
AND and_0(.A(and_0_in[0]), .B(and_0_in[1]), .Z(and_0_out), .draw(draw_and[0]), .x(x), .x_draw(x_draw + x_increase), .x_out(x_out_and_0), .y(y), .y_draw(y_draw), .y_out(y_out_and_0), .reg_pixel_data(pd_and_0));
AND and_1(.A(and_1_in[0]), .B(and_1_in[1]), .Z(and_1_out), .draw(draw_and[1]), .x(x), .x_draw(x_draw + x_increase), .x_out(x_out_and_1), .y(y), .y_draw(y_draw + y_increase * 2), .y_out(y_out_and_1), .reg_pixel_data(pd_and_1));
//
OR or_0(.A(or_0_in[0]), .B(or_0_in[1]), .Z(or_0_out), .draw(draw_or), .x(x), .x_draw(x_draw + x_increase * 2), .x_out(x_out_or_0), .y(y), .y_draw(y_draw + y_increase), .y_out(y_out_or_0), .reg_pixel_data(pd_or_0));
//
wire_ w_A_0(.A(), .Z(), .draw(draw_wA[0]), .pixel_data(pixel_data_A), .x(x), .x_draw(x_draw - 12), .x_end(x_draw - 8), .y(y), .y_draw(y_draw), .y_end(y_draw), .reg_pixel_data(pd_wA_0));
_wire w_A_1(.A(sw[0]), .Z(and_0_in_A_0), .draw(draw_wA[1]), .pixel_data(pixel_data_A), .x(x), .x_draw(x_draw - 8), .x_end(x_draw + x_increase), .y(y), .y_draw(y_draw - 2), .y_end(y_draw), .reg_pixel_data(pd_wA_1));
wire_ w_A_2(.A(sw[0]), .Z(not_0_in), .draw(draw_wA[2]), .pixel_data(pixel_data_A), .x(x), .x_draw(x_draw - 8), .x_end(x_draw), .y(y), .y_draw(y_draw), .y_end(y_draw), .reg_pixel_data(pd_wA_2));
wire_ w_A_3(.A(sw[0]), .Z(and_0_in_A_1), .draw(draw_wA[3]), .pixel_data(pixel_data_A), .x(x), .x_draw(x_draw - 8), .x_end(x_draw + x_increase), .y(y), .y_draw(y_draw), .y_end(y_draw + 2), .reg_pixel_data(pd_wA_3));
wire_ w_A_4(.A(sw[0]), .Z(or_0_in_A_0), .draw(draw_wA[4]), .pixel_data(pixel_data_A), .x(x), .x_draw(x_draw - 8), .x_end(x_draw + x_increase * 2), .y(y), .y_draw(y_draw), .y_end(y_draw + y_increase - 2),  .reg_pixel_data(pd_wA_4));
wire_ w_A_5(.A(sw[0]), .Z(or_0_in_A_1), .draw(draw_wA[5]), .pixel_data(pixel_data_A), .x(x), .x_draw(x_draw - 8), .x_end(x_draw + x_increase * 2), .y(y), .y_draw(y_draw), .y_end(y_draw + y_increase + 2), .reg_pixel_data(pd_wA_5));
wire_ w_A_6(.A(sw[0]), .Z(and_1_in_A_0), .draw(draw_wA[6]), .pixel_data(pixel_data_A), .x(x), .x_draw(x_draw - 8), .x_end(x_draw + x_increase), .y(y), .y_draw(y_draw), .y_end(y_draw + y_increase * 2 - 2), .reg_pixel_data(pd_wA_6));
//
wire_ w_B_0(.A(), .Z(), .draw(draw_wB[0]), .pixel_data(pixel_data_B), .x(x), .x_draw(x_draw - 12), .x_end(x_draw - 4), .y(y), .y_draw(y_draw + y_increase * 2), .y_end(y_draw + y_increase * 2), .reg_pixel_data(pd_wB_0));
wire_ w_B_1(.A(sw[1]), .Z(and_1_in_B_1), .draw(draw_wB[1]), .pixel_data(pixel_data_B), .x(x), .x_draw(x_draw - 4), .x_end(x_draw + x_increase), .y(y), .y_draw(y_draw + y_increase * 2), .y_end(y_draw + y_increase * 2 + 2), .reg_pixel_data(pd_wB_1));
wire_ w_B_2(.A(sw[1]), .Z(not_1_in), .draw(draw_wB[2]), .pixel_data(pixel_data_B), .x(x), .x_draw(x_draw - 4), .x_end(x_draw), .y(y), .y_draw(y_draw + y_increase * 2), .y_end(y_draw + y_increase * 2), .reg_pixel_data(pd_wB_2));
_wire w_B_3(.A(sw[1]), .Z(and_1_in_B_0), .draw(draw_wB[3]), .pixel_data(pixel_data_B), .x(x), .x_draw(x_draw - 4), .x_end(x_draw + x_increase), .y(y), .y_draw(y_draw + y_increase * 2 - 2), .y_end(y_draw + y_increase * 2), .reg_pixel_data(pd_wB_3));
_wire w_B_4(.A(sw[1]), .Z(or_0_in_B_1), .draw(draw_wB[4]), .pixel_data(pixel_data_B), .x(x), .x_draw(x_draw - 4), .x_end(x_draw + x_increase * 2), .y(y), .y_draw(y_draw + y_increase + 2), .y_end(y_draw + y_increase * 2), .reg_pixel_data(pd_wB_4));
_wire w_B_5(.A(sw[1]), .Z(or_0_in_B_0), .draw(draw_wB[5]), .pixel_data(pixel_data_B), .x(x), .x_draw(x_draw - 4), .x_end(x_draw + x_increase * 2), .y(y), .y_draw(y_draw + y_increase - 2), .y_end(y_draw + y_increase * 2),.reg_pixel_data(pd_wB_5));
_wire w_B_6(.A(sw[1]), .Z(and_0_in_B_0), .draw(draw_wB[6]), .pixel_data(pixel_data_B), .x(x), .x_draw(x_draw - 4), .x_end(x_draw + x_increase), .y(y), .y_draw(y_draw + 2), .y_end(y_draw + y_increase * 2),.reg_pixel_data(pd_wB_6));
//
wire_ w_not0_0(.A(), .Z(), .draw(draw_wnot0[0]), .pixel_data(pixel_data_not_0), .x(x), .x_draw(x_out_not_0), .x_end(x_out_not_0 + 4), .y(y), .y_draw(y_out_not_0), .y_end(y_out_not_0), .reg_pixel_data(pd_wnot0_0));
_wire w_not0_1(.A(not_0_out), .Z(and_0_in_not0), .draw(draw_wnot0[1]), .pixel_data(pixel_data_not_0), .x(x), .x_draw(x_out_not_0 + 4), .x_end(x_out_not_0 + 12), .y(y), .y_draw(y_out_not_0 - 2), .y_end(y_out_not_0), .reg_pixel_data(pd_wnot0_1));
wire_ w_not0_2(.A(not_0_out), .Z(or_0_in_not0_0), .draw(draw_wnot0[2]), .pixel_data(pixel_data_not_0), .x(x), .x_draw(x_out_not_0 + 4), .x_end(x_out_not_0 + x_increase + 12), .y(y), .y_draw(y_out_not_0), .y_end(y_out_not_0 + y_increase - 2), .reg_pixel_data(pd_wnot0_2));
wire_ w_not0_3(.A(not_0_out), .Z(or_0_in_not0_1), .draw(draw_wnot0[3]), .pixel_data(pixel_data_not_0), .x(x), .x_draw(x_out_not_0 + 4), .x_end(x_out_not_0 + x_increase + 12), .y(y), .y_draw(y_out_not_0), .y_end(y_out_not_0 + y_increase + 2), .reg_pixel_data(pd_wnot0_3));
wire_ w_not0_4(.A(not_0_out), .Z(and_1_in_not0), .draw(draw_wnot0[4]), .pixel_data(pixel_data_not_0), .x(x), .x_draw(x_out_not_0 + 4), .x_end(x_out_not_0 + 12), .y(y), .y_draw(y_out_not_0), .y_end(y_out_not_0 + y_increase * 2 - 2), .reg_pixel_data(pd_wnot0_4));
//
wire_ w_not1_0(.A(), .Z(), .draw(draw_wnot1[0]), .pixel_data(pixel_data_not_1), .x(x), .x_draw(x_out_not_1), .x_end(x_out_not_0 + 8), .y(y), .y_draw(y_out_not_1), .y_end(y_out_not_1), .reg_pixel_data(pd_wnot1_0));
wire_ w_not1_1(.A(not_1_out), .Z(and_1_in_not1), .draw(draw_wnot1[1]), .pixel_data(pixel_data_not_1), .x(x), .x_draw(x_out_not_1 + 8), .x_end(x_out_not_1 + 12), .y(y), .y_draw(y_out_not_1), .y_end(y_out_not_1 + 2), .reg_pixel_data(pd_wnot1_1));
_wire w_not1_2(.A(not_1_out), .Z(or_0_in_not1_1), .draw(draw_wnot1[2]), .pixel_data(pixel_data_not_1), .x(x), .x_draw(x_out_not_1 + 8), .x_end(x_out_not_1 + x_increase + 12), .y(y), .y_draw(y_out_not_1 - y_increase + 2), .y_end(y_out_not_1), .reg_pixel_data(pd_wnot1_2));
_wire w_not1_3(.A(not_1_out), .Z(or_0_in_not1_0), .draw(draw_wnot1[3]), .pixel_data(pixel_data_not_1), .x(x), .x_draw(x_out_not_1 + 8), .x_end(x_out_not_1 + x_increase + 12), .y(y), .y_draw(y_out_not_1 - y_increase - 2), .y_end(y_out_not_1), .reg_pixel_data(pd_wnot1_3));
_wire w_not1_4(.A(not_1_out), .Z(and_0_in_not1), .draw(draw_wnot1[4]), .pixel_data(pixel_data_not_1), .x(x), .x_draw(x_out_not_1 + 8), .x_end(x_out_not_1 + 12), .y(y), .y_draw(y_out_not_1 - y_increase * 2 + 2), .y_end(y_out_not_1), .reg_pixel_data(pd_wnot1_4));
//
wire_ w_and0_0(.A(), .Z(), .draw(draw_wand0[0]), .pixel_data(pixel_data_and_0), .x(x), .x_draw(x_out_and_0), .x_end(x_out_and_0 + 4), .y(y), .y_draw(y_out_and_0), .y_end(y_out_and_0), .reg_pixel_data(pd_wand0_0));
wire_ w_and0_1(.A(and_0_out), .Z(or_0_in_and0_0), .draw(draw_wand0[1]), .pixel_data(pixel_data_and_0), .x(x), .x_draw(x_out_and_0 + 4), .x_end(x_out_and_0 + 12), .y(y), .y_draw(y_out_and_0), .y_end(y_out_and_0 + y_increase - 2), .reg_pixel_data(pd_wand0_1));
wire_ w_and0_2(.A(and_0_out), .Z(or_0_in_and0_1), .draw(draw_wand0[2]), .pixel_data(pixel_data_and_0), .x(x), .x_draw(x_out_and_0 + 4), .x_end(x_out_and_0 + 12), .y(y), .y_draw(y_out_and_0), .y_end(y_out_and_0 + y_increase + 2), .reg_pixel_data(pd_wand0_2));
//
wire_ w_and1_0(.A(), .Z(), .draw(draw_wand1[0]), .pixel_data(pixel_data_and_1), .x(x), .x_draw(x_out_and_1), .x_end(x_out_and_1 + 8), .y(y), .y_draw(y_out_and_1), .y_end(y_out_and_1), .reg_pixel_data(pd_wand1_0));
_wire w_and1_1(.A(and_1_out), .Z(or_0_in_and1_1), .draw(draw_wand1[1]), .pixel_data(pixel_data_and_1), .x(x), .x_draw(x_out_and_1 + 8), .x_end(x_out_and_1 + 12), .y(y), .y_draw(y_out_and_1 - y_increase + 2), .y_end(y_out_and_1), .reg_pixel_data(pd_wand1_1));
_wire w_and1_2(.A(and_1_out), .Z(or_0_in_and1_0), .draw(draw_wand1[2]), .pixel_data(pixel_data_and_1), .x(x), .x_draw(x_out_and_1 + 8), .x_end(x_out_and_1 + 12), .y(y), .y_draw(y_out_and_1 - y_increase - 2), .y_end(y_out_and_1), .reg_pixel_data(pd_wand1_2));
//
always @ (*)
begin

if (draw_wA[1])
    and_0_in[0] <= and_0_in_A_0;
else if (draw_wnot0[1])
    and_0_in[0] <= and_0_in_not0;

if (draw_wA[3])
    and_0_in[1] <= and_0_in_A_1;    
else if (draw_wB[6])
    and_0_in[1] <= and_0_in_B_0;
else if(draw_wnot1[4])
    and_0_in[1] <= and_0_in_not1;
//    
if (draw_wA[6])
    and_1_in[0] <= and_1_in_A_0;
else if(draw_wB[3])
    and_1_in[0] <= and_1_in_B_0;
else if (draw_wnot0[4])
    and_1_in[0] <= and_1_in_not0;
    
if (draw_wB[1])
    and_1_in[1] <= and_1_in_B_1;
else if(draw_wnot1[1])
    and_1_in[1] <= and_1_in_not1;
//   
if (draw_wA[4])
    or_0_in[0] <= or_0_in_A_0;
else if (draw_wB[5])
    or_0_in[0] <= or_0_in_B_0;
else if (draw_wnot0[2])
    or_0_in[0] <= or_0_in_not0_0;
else if (draw_wnot1[3])
    or_0_in[0] <= or_0_in_not1_0;
else if (draw_wand0[1])
    or_0_in[0] <= or_0_in_and0_0;
else if (draw_wand1[2])
    or_0_in[0] <= or_0_in_and1_0;

if (draw_wA[5])
    or_0_in[1]<= or_0_in_A_1;
else if (draw_wB[4])
    or_0_in[1] <= or_0_in_B_1;
else if (draw_wnot0[3])
    or_0_in[1] <= or_0_in_not0_1;
else if (draw_wnot1[2])
    or_0_in[1] <= or_0_in_not1_1;
else if (draw_wand0[2])
    or_0_in[1] <= or_0_in_and0_1;
else if (draw_wand1[1])
    or_0_in[1] <= or_0_in_and1_1;
//           
if (pd_not_0)
    reg_pixel_data <= pd_not_0;
else if (pd_not_1)
    reg_pixel_data <= pd_not_1;
// 
else if (pd_and_0)
    reg_pixel_data <= pd_and_0;
else if (pd_and_1)
    reg_pixel_data <= pd_and_1;
// 
else if (pd_or_0)
    reg_pixel_data <= pd_or_0;
//
else if (pd_wA_0)
    reg_pixel_data <= pd_wA_0;
else if (pd_wA_1)
    reg_pixel_data <= pd_wA_1;
else if (pd_wA_2)
        reg_pixel_data <= pd_wA_2;     
else if (pd_wA_3)
    reg_pixel_data <= pd_wA_3;    
else if (pd_wA_4)
    reg_pixel_data <= pd_wA_4; 
else if (pd_wA_5)
    reg_pixel_data <= pd_wA_5;
else if (pd_wA_6)
        reg_pixel_data <= pd_wA_6;
//   
else if (pd_wB_0)
    reg_pixel_data <= pd_wB_0;
else if (pd_wB_1)
    reg_pixel_data <= pd_wB_1;
else if (pd_wB_2)
    reg_pixel_data <= pd_wB_2;
else if (pd_wB_3)
    reg_pixel_data <= pd_wB_3;   
else if (pd_wB_4)
    reg_pixel_data <= pd_wB_4;
else if (pd_wB_5)
    reg_pixel_data <= pd_wB_5;
else if (pd_wB_6)
    reg_pixel_data <= pd_wB_6;
//
else if (pd_wnot0_0)
    reg_pixel_data <= pd_wnot0_0; 
else if (pd_wnot0_1)
    reg_pixel_data <= pd_wnot0_1;
else if (pd_wnot0_2)
    reg_pixel_data <= pd_wnot0_2; 
else if (pd_wnot0_3)
    reg_pixel_data <= pd_wnot0_3;
else if (pd_wnot0_4)
    reg_pixel_data <= pd_wnot0_4; 
//
else if (pd_wnot1_0)
    reg_pixel_data <= pd_wnot1_0;
else if (pd_wnot1_1)
    reg_pixel_data <= pd_wnot1_1;
else if (pd_wnot1_2)
    reg_pixel_data <= pd_wnot1_2;
else if (pd_wnot1_3)
    reg_pixel_data <= pd_wnot1_3;
else if (pd_wnot1_4)
    reg_pixel_data <= pd_wnot1_4;               
//
else if (pd_wand0_0)
    reg_pixel_data <= pd_wand0_0;
else if (pd_wand0_1)
    reg_pixel_data <= pd_wand0_1;
else if (pd_wand0_2)
    reg_pixel_data <= pd_wand0_2; 
//      
else if (pd_wand1_0)
    reg_pixel_data <= pd_wand1_0;
else if (pd_wand1_1)
    reg_pixel_data <= pd_wand1_1;
else if (pd_wand1_2)
    reg_pixel_data <= pd_wand1_2;
//
else if (pd_A)
    reg_pixel_data <= pd_A;
else if (pd_B)
    reg_pixel_data <= pd_B;
else if (pd_OUT)
    reg_pixel_data <= pd_OUT;  
//    
else if (pd_rainbow_rect_0)
    reg_pixel_data <= pd_rainbow_rect_0;   
else if (pd_rainbow_rect_1)
    reg_pixel_data <= pd_rainbow_rect_1;
else if (pd_rainbow_rect_2)
    reg_pixel_data <= pd_rainbow_rect_2;   
else if (pd_rainbow_rect_3)
    reg_pixel_data <= pd_rainbow_rect_3;   
//      
else
    reg_pixel_data <= 16'b00000_000000_00000;
end   

   
endmodule