module wire_vert(A, Z, draw, pixel_data, x, x_draw, y, y_draw, y_end, reg_pixel_data);
input A;
output reg Z;
input draw;
input [15:0]pixel_data;
input [6:0]x, x_draw;
input [5:0]y, y_draw, y_end;
output [15:0]reg_pixel_data;
draw_wire_vert w_v(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .y(y), .y_draw(y_draw), .y_end(y_end), .reg_pixel_data(reg_pixel_data));
always @(*)
begin
if (draw)
    Z <= A;
end
endmodule

module wire_horz(A, Z, draw, pixel_data, x, x_draw, x_end, y, y_draw, reg_pixel_data);
input A;
output reg Z;
input draw;
input [15:0]pixel_data;
input [6:0]x, x_draw, x_end;
input [5:0]y, y_draw;
output [15:0]reg_pixel_data;
draw_wire_horz w_h(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .y(y), .y_draw(y_draw), .x_end(x_end), .reg_pixel_data(reg_pixel_data));
always @(*)
begin
if (draw)
    Z <= A;
end
endmodule

module wire_(A, Z, draw, pixel_data, x, x_draw, x_end, y, y_draw, y_end, reg_pixel_data);
input A;
output reg Z;
input draw;
input [15:0]pixel_data;
input [6:0]x, x_draw, x_end;
input [5:0]y, y_draw, y_end;
output [15:0]reg_pixel_data;
draw_wire w(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .x_end(x_end), .y(y), .y_draw(y_draw), .y_end(y_end), .reg_pixel_data(reg_pixel_data));
always @(*)
begin
if (draw)
    Z <= A;
end
endmodule

module _wire(A, Z, draw, pixel_data, x, x_draw, x_end, y, y_draw, y_end, reg_pixel_data);
input A;
output reg Z;
input draw;
input [15:0]pixel_data;
input [6:0]x, x_draw, x_end;
input [5:0]y, y_draw, y_end;
output [15:0]reg_pixel_data;
draw_wire_inv w(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .x_end(x_end), .y(y), .y_draw(y_draw), .y_end(y_end), .reg_pixel_data(reg_pixel_data));
always @(*)
begin
if (draw)
    Z <= A;
end
endmodule

