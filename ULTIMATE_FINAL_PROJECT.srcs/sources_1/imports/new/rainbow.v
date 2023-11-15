module rainbow(clock, reg_pixel_data);
input clock;
output reg[15:0] reg_pixel_data = 16'b11111_000000_00000;
parameter [31:0] m = 32'd4999999;
reg c_up_red = 0, c_down_red = 0, c_up_green = 0, c_down_green = 0, c_up_blue = 0, c_down_blue = 0;
wire wire_clock_T;
clk_divider clk_divider_1(.CLOCK(clock), .my_m_value(m), .clk_output(wire_clock_T));

always @ (posedge wire_clock_T)
begin
if (c_up_red)
    reg_pixel_data <= reg_pixel_data + 16'b00001_000000_00000;
else if (c_down_red)
    reg_pixel_data <= reg_pixel_data - 16'b00001_000000_00000;
else if (c_up_green)
    reg_pixel_data <= reg_pixel_data + 16'b00000_000001_00000;
else if (c_down_green)
    reg_pixel_data <= reg_pixel_data - 16'b00000_000001_00000;   
else if (c_up_blue)
    reg_pixel_data <= reg_pixel_data + 16'b00000_000000_00001;
else if (c_down_blue)
    reg_pixel_data <= reg_pixel_data - 16'b00000_000000_00001;     
end    

always @(posedge clock)
begin
    case (reg_pixel_data)
        16'b11111_000000_00000:
        begin
            c_up_red <= 0;
            c_down_red <= 0;
            c_up_green <= 0;
            c_down_green <= 0;
            c_up_blue <= 1;
            c_down_blue <= 0;
        end
        16'b11111_000000_11111:
        begin
            c_up_red <= 0;
            c_down_red <= 1;
            c_up_green <= 0;
            c_down_green <= 0;
            c_up_blue <= 0;
            c_down_blue <= 0;
        end
        16'b00000_000000_11111:
        begin
            c_up_red <= 0;
            c_down_red <= 0;
            c_up_green <= 1;
            c_down_green <= 0;
            c_up_blue <= 0;
            c_down_blue <= 0;
        end
        16'b00000_111111_11111:
        begin
            c_up_red <= 0;
            c_down_red <= 0;
            c_up_green <= 0;
            c_down_green <= 0;
            c_up_blue <= 0;
            c_down_blue <= 1;
        end
        16'b00000_111111_00000:
        begin
            c_up_red <= 1;
            c_down_red <= 0;
            c_up_green <= 0;
            c_down_green <= 0;
            c_up_blue <= 0;
            c_down_blue <= 0;
        end
        16'b11111_111111_00000:
        begin
            c_up_red <= 0;
            c_down_red <= 0;
            c_up_green <= 0;
            c_down_green <= 1;
            c_up_blue <= 0;
            c_down_blue <= 0;
        end
        default
        begin
            c_up_red <= c_up_red;
            c_down_red <= c_down_red;
            c_up_green <= c_up_green;
            c_down_green <= c_down_green;
            c_up_blue <= c_up_blue;
            c_down_blue <= c_down_blue;
        end
    endcase
end
endmodule


module draw_rainbow_rect(clock, draw, x, x_draw, x_end, y, y_draw, y_end, reg_pixel_data);
input clock;
input draw;
input [6:0]x, x_draw, x_end;
input [5:0]y, y_draw, y_end;
output reg[15:0] reg_pixel_data;
parameter [31:0] m = 32'd4999999;
reg [15:0] pixel_data = 16'b11111_000000_00000;
reg c_up_red = 0, c_down_red = 0, c_up_green = 0, c_down_green = 0, c_up_blue = 0, c_down_blue = 0;
wire wire_clock_T;

clk_divider clk_divider_1(.CLOCK(clock), .my_m_value(m), .clk_output(wire_clock_T));
always @ (posedge wire_clock_T)
begin
if (c_up_red)
    pixel_data <= pixel_data + 16'b00001_000000_00000;
else if (c_down_red)
    pixel_data <= pixel_data - 16'b00001_000000_00000;
else if (c_up_green)
    pixel_data <= pixel_data + 16'b00000_000001_00000;
else if (c_down_green)
    pixel_data <= pixel_data - 16'b00000_000001_00000;   
else if (c_up_blue)
    pixel_data <= pixel_data + 16'b00000_000000_00001;
else if (c_down_blue)
    pixel_data <= pixel_data - 16'b00000_000000_00001;     
end    

always @(posedge clock)
begin
    case (pixel_data)
        16'b11111_000000_00000:
        begin
            c_up_red <= 0;
            c_down_red <= 0;
            c_up_green <= 0;
            c_down_green <= 0;
            c_up_blue <= 1;
            c_down_blue <= 0;
        end
        16'b11111_000000_11111:
        begin
            c_up_red <= 0;
            c_down_red <= 1;
            c_up_green <= 0;
            c_down_green <= 0;
            c_up_blue <= 0;
            c_down_blue <= 0;
        end
        16'b00000_000000_11111:
        begin
            c_up_red <= 0;
            c_down_red <= 0;
            c_up_green <= 1;
            c_down_green <= 0;
            c_up_blue <= 0;
            c_down_blue <= 0;
        end
        16'b00000_111111_11111:
        begin
            c_up_red <= 0;
            c_down_red <= 0;
            c_up_green <= 0;
            c_down_green <= 0;
            c_up_blue <= 0;
            c_down_blue <= 1;
        end
        16'b00000_111111_00000:
        begin
            c_up_red <= 1;
            c_down_red <= 0;
            c_up_green <= 0;
            c_down_green <= 0;
            c_up_blue <= 0;
            c_down_blue <= 0;
        end
        16'b11111_111111_00000:
        begin
            c_up_red <= 0;
            c_down_red <= 0;
            c_up_green <= 0;
            c_down_green <= 1;
            c_up_blue <= 0;
            c_down_blue <= 0;
        end
        default
        begin
            c_up_red <= c_up_red;
            c_down_red <= c_down_red;
            c_up_green <= c_up_green;
            c_down_green <= c_down_green;
            c_up_blue <= c_up_blue;
            c_down_blue <= c_down_blue;
        end
    endcase
end

always @(*)
begin
    if(draw)
    begin
        if ((x >= x_draw && x <= x_end) && (y >= y_draw && y <= y_end))
            reg_pixel_data <= pixel_data;
        else
            reg_pixel_data <= 16'b00000_000000_00000;
    end
end
endmodule

module draw_rect(draw, pixel_data, x, x_draw, x_end, y, y_draw, y_end, reg_pixel_data);
input draw;
input [15:0] pixel_data;
input [6:0]x, x_draw, x_end;
input [5:0]y, y_draw, y_end;
output reg[15:0]reg_pixel_data;

always @(*)
begin
    if(draw)
    begin
        if ((x >= x_draw && x <= x_end) && (y >= y_draw && y <= y_end))
            reg_pixel_data <= pixel_data;
        else
            reg_pixel_data <= 16'b00000_000000_00000;
    end
end
endmodule

module draw_A(draw, pixel_data, x, x_draw, y, y_draw, reg_pixel_data);
input draw;
input [15:0] pixel_data;
input [6:0]x, x_draw;
input [5:0]y, y_draw;
output reg[15:0]reg_pixel_data;
wire[15:0] pdA0, pdA1, pdA2, pdA3;
draw_rect A0(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .x_end(x_draw), .y(y), .y_draw(y_draw + 1), .y_end(y_draw + 4), .reg_pixel_data(pdA0));
draw_rect A1(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw + 4), .x_end(x_draw + 4), .y(y), .y_draw(y_draw), .y_end(y_draw + 4), .reg_pixel_data(pdA1));
draw_rect A2(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw + 1), .x_end(x_draw + 4), .y(y), .y_draw(y_draw), .y_end(y_draw), .reg_pixel_data(pdA2));
draw_rect A3(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .x_end(x_draw + 4), .y(y), .y_draw(y_draw + 2), .y_end(y_draw + 2), .reg_pixel_data(pdA3));
always @(*)
begin
if (pdA0)
    reg_pixel_data <= pdA0; 
else if (pdA1) 
    reg_pixel_data <= pdA1; 
else if (pdA2) 
    reg_pixel_data <= pdA2; 
else if (pdA3)
    reg_pixel_data <= pdA3; 
else
    reg_pixel_data <= 16'b00000_000000_00000;   
end
endmodule

module draw_B(draw, pixel_data, x, x_draw, y, y_draw, reg_pixel_data);
input draw;
input [15:0] pixel_data;
input [6:0]x, x_draw;
input [5:0]y, y_draw;
output reg[15:0]reg_pixel_data;
wire[15:0] pdB0, pdB1, pdB2, pdB3, pdB4, pdB5;
draw_rect B0(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .x_end(x_draw), .y(y), .y_draw(y_draw + 1), .y_end(y_draw + 4), .reg_pixel_data(pdB0));
draw_rect B1(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw + 3), .x_end(x_draw + 3), .y(y), .y_draw(y_draw), .y_end(y_draw + 2), .reg_pixel_data(pdB1));
draw_rect B2(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw + 4), .x_end(x_draw + 4), .y(y), .y_draw(y_draw + 2), .y_end(y_draw + 4), .reg_pixel_data(pdB2));
draw_rect B3(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw + 1), .x_end(x_draw + 3), .y(y), .y_draw(y_draw), .y_end(y_draw), .reg_pixel_data(pdB3));
draw_rect B4(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .x_end(x_draw + 4), .y(y), .y_draw(y_draw + 2), .y_end(y_draw + 2), .reg_pixel_data(pdB4));
draw_rect B5(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .x_end(x_draw + 4), .y(y), .y_draw(y_draw + 4), .y_end(y_draw + 4), .reg_pixel_data(pdB5));
always @(*)
begin
if (pdB0)
    reg_pixel_data <= pdB0; 
else if (pdB1) 
    reg_pixel_data <= pdB1; 
else if (pdB2) 
    reg_pixel_data <= pdB2; 
else if (pdB3)
    reg_pixel_data <= pdB3;
else if (pdB4)
    reg_pixel_data <= pdB4;
else if (pdB5)
    reg_pixel_data <= pdB5; 
else
    reg_pixel_data <= 16'b00000_000000_00000;   
end
endmodule

module draw_O(draw, pixel_data, x, x_draw, y, y_draw, reg_pixel_data);
input draw;
input [15:0] pixel_data;
input [6:0]x, x_draw;
input [5:0]y, y_draw;
output reg[15:0]reg_pixel_data;
wire[15:0] pdO0, pdO1, pdO2, pdO3;
draw_rect O0(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .x_end(x_draw), .y(y), .y_draw(y_draw + 1), .y_end(y_draw + 3), .reg_pixel_data(pdO0));
draw_rect O1(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw + 4), .x_end(x_draw + 4), .y(y), .y_draw(y_draw + 1), .y_end(y_draw + 4), .reg_pixel_data(pdO1));
draw_rect O2(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw + 1), .x_end(x_draw + 3), .y(y), .y_draw(y_draw), .y_end(y_draw), .reg_pixel_data(pdO2));
draw_rect O3(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw + 1), .x_end(x_draw + 4), .y(y), .y_draw(y_draw + 4), .y_end(y_draw + 4), .reg_pixel_data(pdO3));
always @(*)
begin
if (pdO0)
    reg_pixel_data <= pdO0; 
else if (pdO1) 
    reg_pixel_data <= pdO1; 
else if (pdO2) 
    reg_pixel_data <= pdO2; 
else if (pdO3)
    reg_pixel_data <= pdO3; 
else
    reg_pixel_data <= 16'b00000_000000_00000;   
end
endmodule

module draw_U(draw, pixel_data, x, x_draw, y, y_draw, reg_pixel_data);
input draw;
input [15:0] pixel_data;
input [6:0]x, x_draw;
input [5:0]y, y_draw;
output reg[15:0]reg_pixel_data;
wire[15:0] pdU0, pdU1, pdU2;
draw_rect U0(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .x_end(x_draw), .y(y), .y_draw(y_draw), .y_end(y_draw + 3), .reg_pixel_data(pdU0));
draw_rect U1(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw + 4), .x_end(x_draw + 4), .y(y), .y_draw(y_draw), .y_end(y_draw + 4), .reg_pixel_data(pdU1));
draw_rect U2(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw + 1), .x_end(x_draw + 4), .y(y), .y_draw(y_draw + 4), .y_end(y_draw + 4), .reg_pixel_data(pdU2));
always @(*)
begin
if (pdU0)
    reg_pixel_data <= pdU0; 
else if (pdU1) 
    reg_pixel_data <= pdU1; 
else if (pdU2) 
    reg_pixel_data <= pdU2; 
else
    reg_pixel_data <= 16'b00000_000000_00000;   
end
endmodule

module draw_T(draw, pixel_data, x, x_draw, y, y_draw, reg_pixel_data);
input draw;
input [15:0] pixel_data;
input [6:0]x, x_draw;
input [5:0]y, y_draw;
output reg[15:0]reg_pixel_data;
wire[15:0] pdT0, pdT1, pdT2;
draw_rect T0(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw + 2), .x_end(x_draw + 2), .y(y), .y_draw(y_draw), .y_end(y_draw + 4), .reg_pixel_data(pdT0));
draw_rect T1(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .x_end(x_draw + 4), .y(y), .y_draw(y_draw), .y_end(y_draw), .reg_pixel_data(pdT1));
always @(*)
begin
if (pdT0)
    reg_pixel_data <= pdT0; 
else if (pdT1) 
    reg_pixel_data <= pdT1; 
else
    reg_pixel_data <= 16'b00000_000000_00000;   
end
endmodule

module draw_OUT(draw, pixel_data, x, x_draw, y, y_draw, reg_pixel_data);
input draw;
input [15:0] pixel_data;
input [6:0]x, x_draw;
input [5:0]y, y_draw;
output reg[15:0]reg_pixel_data;
wire [15:0] pd_O, pd_U, pd_T;
draw_O O(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .y(y), .y_draw(y_draw - 6), .reg_pixel_data(pd_O));
draw_U U(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .y(y), .y_draw(y_draw), .reg_pixel_data(pd_U));
draw_T T(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .y(y), .y_draw(y_draw + 6), .reg_pixel_data(pd_T));
always @(*)
begin
if (pd_O)
    reg_pixel_data <= pd_O; 
else if (pd_U) 
    reg_pixel_data <= pd_U; 
else if (pd_T) 
    reg_pixel_data <= pd_T; 
else
    reg_pixel_data <= 16'b00000_000000_00000;   
end
endmodule