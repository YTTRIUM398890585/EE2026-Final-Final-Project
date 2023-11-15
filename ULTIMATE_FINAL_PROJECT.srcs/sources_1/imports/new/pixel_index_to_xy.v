module pixel_index_to_xy(pixel_index, x, y);
input [12:0]pixel_index;
output [6:0]x;
output [5:0]y;
assign x = pixel_index % 96;
assign y = pixel_index / 96;
endmodule