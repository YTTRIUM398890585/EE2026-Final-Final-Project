module draw_and(draw, x, x_draw, x_out, y, y_draw, y_out, reg_pixel_data);
input draw;
input [6:0]x, x_draw;
input [5:0]y, y_draw;
output [6:0] x_out;
output [5:0] y_out;
output reg [15:0]reg_pixel_data;
assign x_out = x_draw + 10;
assign y_out = y_draw ;
always @ (*)
begin
    if (draw)
    begin
        if (
            ((x >= x_draw && x < x_draw + 2) && (y == y_draw - 2 || y == y_draw + 2)) ||
            ((x >= x_draw + 8 && x < x_draw + 10) && (y == y_draw))
            )
            reg_pixel_data <= 16'b11111_111111_11111;
            
        else if (
                 ((x >= x_draw + 2 && x < x_draw + 5) && (y <= y_draw + 3 && y >= y_draw - 3)) ||
                 ((x >= x_draw + 5 && x < x_draw + 8) && (y <= y_draw + 2 && y >= y_draw - 2))
                )
                reg_pixel_data <= 16'b11111_000000_11111;
                
        else
            reg_pixel_data <= 16'b00000_000000_00000;
    end
end
endmodule


module draw_or(draw, x, x_draw, x_out, y, y_draw, y_out, reg_pixel_data);
input draw;
input [6:0]x, x_draw;
input [5:0]y, y_draw;
output [6:0] x_out;
output [5:0] y_out;
output reg [15:0]reg_pixel_data;
assign x_out = x_draw + 10;
assign y_out = y_draw;
always @ (*)
begin
    if (draw)
    begin
        if (
            ((x >= x_draw && x < x_draw + 3) && (y == y_draw - 2 || y == y_draw + 2)) ||
            ((x >= x_draw + 8 && x < x_draw + 10) && (y == y_draw))
            )
            reg_pixel_data <= 16'b11111_111111_11111;
            
        else if (
                 ((x == x_draw + 2) && (y == y_draw + 3 || y == y_draw - 3)) ||
                 ((x == x_draw + 3) && ((y <= y_draw + 3 && y >= y_draw + 1) || (y <= y_draw - 1 && y >= y_draw - 3))) ||
                 ((x >= x_draw + 4 && x < x_draw + 6) && (y <= y_draw + 2 && y >= y_draw - 2)) ||
                 ((x >= x_draw + 6 && x < x_draw + 8) && (y <= y_draw + 1 && y >= y_draw - 1))
                )
                reg_pixel_data <= 16'b00000_111111_11111;
                
        else
            reg_pixel_data <= 16'b00000_000000_00000;
    end
end
endmodule


module draw_not(draw, x, x_draw, x_out, y, y_draw, y_out, reg_pixel_data);
input draw;
input [6:0]x, x_draw;
input [5:0]y, y_draw;
output [6:0] x_out;
output [5:0] y_out;
output reg [15:0]reg_pixel_data;
assign x_out = x_draw + 10;
assign y_out = y_draw;
always @ (*)
begin
    if (draw)
    begin
        if (
           ((x >= x_draw && x < x_draw + 3) || (x >= x_draw + 7 && x < x_draw + 10)) && (y == y_draw)
            )
            reg_pixel_data <= 16'b11111_111111_11111;
            
        else if (
                 ((x >= x_draw + 3 && x < x_draw + 5) && (y <= y_draw + 1 && y >= y_draw - 1)) ||
                 (x == x_draw + 5 && y == y_draw)
                )
                reg_pixel_data <= 16'b11111_111111_00000;
        else if (
                 (x == x_draw + 6 && y == y_draw)
                )
                reg_pixel_data <= 16'b11111_000000_00000;
                
        else
            reg_pixel_data <= 16'b00000_000000_00000;
    end
end
endmodule

