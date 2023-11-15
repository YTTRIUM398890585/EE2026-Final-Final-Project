module AND (A, B, Z, draw, x, x_draw, x_out, y, y_draw, y_out, reg_pixel_data);
input A, B, draw;
output reg Z;
input [6:0]x, x_draw;
input [5:0]y, y_draw;
output [6:0] x_out;
output [5:0] y_out;
output [15:0]reg_pixel_data;
draw_and _and(.draw(draw), .x(x), .x_draw(x_draw) , .x_out(x_out), .y(y), .y_draw(y_draw), .y_out(y_out), .reg_pixel_data(reg_pixel_data));
always @(*)
begin
if (draw)
    Z <= A & B;   
end
endmodule

module OR (A, B, Z, draw, x, x_draw, x_out, y, y_draw, y_out, reg_pixel_data);
input A, B, draw;
output reg Z;
input [6:0]x, x_draw;
input [5:0]y, y_draw;
output [6:0] x_out;
output [5:0] y_out;
output [15:0]reg_pixel_data;
draw_or _or(.draw(draw), .x(x), .x_draw(x_draw) , .x_out(x_out), .y(y), .y_draw(y_draw), .y_out(y_out), .reg_pixel_data(reg_pixel_data));
always @(*)
begin
if (draw)
    Z <= A | B;   
end
endmodule

module NOT (A, Z, draw, x, x_draw, x_out, y, y_draw, y_out, reg_pixel_data);
input A, draw;
output reg Z;
input [6:0]x, x_draw;
input [5:0]y, y_draw;
output [6:0] x_out;
output [5:0] y_out;
output [15:0]reg_pixel_data;
draw_not _not(.draw(draw), .x(x), .x_draw(x_draw) , .x_out(x_out), .y(y), .y_draw(y_draw), .y_out(y_out), .reg_pixel_data(reg_pixel_data));
always @(*)
begin
if (draw)
    Z <= ~A;   
end
endmodule