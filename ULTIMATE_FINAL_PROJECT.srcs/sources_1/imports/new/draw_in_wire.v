module draw_wire_vert(draw, pixel_data, x, x_draw, y, y_draw, y_end, reg_pixel_data);
input draw;
input [15:0]pixel_data;
input [6:0]x, x_draw;
input [5:0]y, y_draw, y_end;
output reg[15:0]reg_pixel_data;
always @(*)
begin
    if (draw)
    begin
        if (x == x_draw && (y >= y_draw && y <= y_end))   
            reg_pixel_data <= pixel_data;
        else
            reg_pixel_data <= 16'b00000_000000_00000;
    end
end
endmodule

module draw_wire_horz(draw, pixel_data, x, x_draw, x_end, y, y_draw, reg_pixel_data);
input draw;
input [15:0]pixel_data;
input [6:0]x, x_draw, x_end;
input [5:0]y, y_draw;
output reg[15:0]reg_pixel_data;
always @(*)
begin
    if (draw)
    begin
        if (x >= x_draw && x <= x_end && y == y_draw)   
            reg_pixel_data <= pixel_data;
        else
            reg_pixel_data <= 16'b00000_000000_00000;
    end
end
endmodule

module draw_wire(draw, pixel_data, x, x_draw, x_end, y, y_draw, y_end, reg_pixel_data);
input draw;
input [15:0]pixel_data;
input [6:0]x, x_draw, x_end;
input [5:0]y, y_draw, y_end;
output reg[15:0]reg_pixel_data;
wire[15:0]pd_h, pd_v;
draw_wire_vert w_v(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .y_end(y_end), .y(y), .y_draw(y_draw), .reg_pixel_data(pd_v));
draw_wire_horz w_h(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .x_end(x_end), .y(y), .y_draw(y_end), .reg_pixel_data(pd_h));
always @(*)
begin
    if (pd_v)
        reg_pixel_data <= pd_v;
    else if (pd_h)
        reg_pixel_data <= pd_h;
    else
        reg_pixel_data <= 16'b00000_000000_00000;
end
endmodule

module draw_wire_inv(draw, pixel_data, x, x_draw, x_end, y, y_draw, y_end, reg_pixel_data);
input draw;
input [15:0]pixel_data;
input [6:0]x, x_draw, x_end;
input [5:0]y, y_draw, y_end;
output reg[15:0]reg_pixel_data;
wire[15:0]pd_h, pd_v;
draw_wire_vert w_v(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .y_end(y_end), .y(y), .y_draw(y_draw), .reg_pixel_data(pd_v));
draw_wire_horz w_h(.draw(draw), .pixel_data(pixel_data), .x(x), .x_draw(x_draw), .x_end(x_end), .y(y), .y_draw(y_draw), .reg_pixel_data(pd_h));
always @(*)
begin
    if (pd_v)
        reg_pixel_data <= pd_v;
    else if (pd_h)
        reg_pixel_data <= pd_h;
    else
        reg_pixel_data <= 16'b00000_000000_00000;
end
endmodule