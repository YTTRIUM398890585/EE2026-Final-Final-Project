module k_map(kmap, 
                draw_not, draw_and, draw_or,
                draw_wA, draw_wB,
                draw_wnot0, draw_wnot1,
                draw_wand0, draw_wand1,
                drawA, drawB, drawOUT);             
input [3:0]kmap;
output reg drawA, drawB, drawOUT;
output reg [1:0] draw_not = 2'b00, draw_and = 2'b00;
output reg draw_or = 0;
output reg [6:0] draw_wA = 7'b000000, draw_wB = 7'b000000;
output reg [4:0] draw_wnot0 = 5'b00000, draw_wnot1 = 5'b00000;
output reg [2:0] draw_wand0 = 3'b000, draw_wand1 = 3'b000;
always @(*)
begin
case (kmap)

4'b0000:
begin
    draw_not <= 2'b01;
    draw_and <= 2'b01;
    draw_or <= 1;
    draw_wA <= 7'b0001101;
    draw_wB <= 7'b0000000;
    draw_wnot0 <= 5'b00011;
    draw_wnot1 <= 5'b00000;
    draw_wand0 <= 3'b111;
    draw_wand1 <= 3'b000;
end

4'b0001:
begin
    draw_not <= 2'b10;
    draw_and <= 2'b01;
    draw_or <= 1;
    draw_wA <= 7'b0000011;
    draw_wB <= 7'b0000101;
    draw_wnot0 <= 5'b00000;
    draw_wnot1 <= 5'b10001;
    draw_wand0 <= 3'b111;
    draw_wand1 <= 3'b000;
end

4'b0010:
begin
    draw_not <= 2'b11;
    draw_and <= 2'b01;
    draw_or <= 1;
    draw_wA <= 7'b0000101;
    draw_wB <= 7'b0000101;
    draw_wnot0 <= 5'b00011;
    draw_wnot1 <= 5'b10001;
    draw_wand0 <= 3'b111;
    draw_wand1 <= 3'b000;
end

4'b0011:
begin
    draw_not <= 2'b10;
    draw_and <= 2'b00;
    draw_or <= 1;
    draw_wA <= 7'b0000000;
    draw_wB <= 7'b0000101;
    draw_wnot0 <= 5'b00000;
    draw_wnot1 <= 5'b01101;
    draw_wand0 <= 3'b000;
    draw_wand1 <= 3'b000;
end

4'b0100:
begin
    draw_not <= 2'b00;
    draw_and <= 2'b01;
    draw_or <= 1;
    draw_wA <= 7'b0000011;
    draw_wB <= 7'b1000001;
    draw_wnot0 <= 5'b00000;
    draw_wnot1 <= 5'b00000;
    draw_wand0 <= 3'b111;
    draw_wand1 <= 3'b000;
end

4'b0101:
begin
    draw_not <= 2'b00;
    draw_and <= 2'b00;
    draw_or <= 1;
    draw_wA <= 7'b0110001;
    draw_wB <= 7'b0000000;
    draw_wnot0 <= 5'b00000;
    draw_wnot1 <= 5'b00000;
    draw_wand0 <= 3'b000;
    draw_wand1 <= 3'b000;
end

4'b0110:
begin
    draw_not <= 2'b11;
    draw_and <= 2'b11;
    draw_or <= 1;
    draw_wA <= 7'b0000111;
    draw_wB <= 7'b1000101;
    draw_wnot0 <= 5'b10001;
    draw_wnot1 <= 5'b00011;
    draw_wand0 <= 3'b011;
    draw_wand1 <= 3'b011;
end

4'b0111:
begin
    draw_not <= 2'b10;
    draw_and <= 2'b00;
    draw_or <= 1;
    draw_wA <= 7'b0010001;
    draw_wB <= 7'b0000101;
    draw_wnot0 <= 5'b00000;
    draw_wnot1 <= 5'b00101;
    draw_wand0 <= 3'b000;
    draw_wand1 <= 3'b000;
end

4'b1000:
begin
    draw_not <= 2'b01;
    draw_and <= 2'b01;
    draw_or <= 1;
    draw_wA <= 7'b0000101;
    draw_wB <= 7'b1000001;
    draw_wnot0 <= 5'b00011;
    draw_wnot1 <= 5'b00000;
    draw_wand0 <= 3'b111;
    draw_wand1 <= 3'b000;
end

4'b1001:
begin
    draw_not <= 2'b11;
    draw_and <= 2'b11;
    draw_or <= 1;
    draw_wA <= 7'b0000111;
    draw_wB <= 7'b0000111;
    draw_wnot0 <= 5'b10001;
    draw_wnot1 <= 5'b10001;
    draw_wand0 <= 3'b011;
    draw_wand1 <= 3'b011;
end
///////
4'b1010:
begin
    draw_not <= 2'b01;
    draw_and <= 2'b00;
    draw_or <= 1;
    draw_wA <= 7'b0000101;
    draw_wB <= 7'b0000000;
    draw_wnot0 <= 5'b01101;
    draw_wnot1 <= 5'b00000;
    draw_wand0 <= 3'b000;
    draw_wand1 <= 3'b000;
end

4'b1011:
begin
    draw_not <= 2'b11;
    draw_and <= 2'b00;
    draw_or <= 1;
    draw_wA <= 7'b0000101;
    draw_wB <= 7'b0000101;
    draw_wnot0 <= 5'b00101;
    draw_wnot1 <= 5'b00101;
    draw_wand0 <= 3'b000;
    draw_wand1 <= 3'b000;
end

4'b1100:
begin
    draw_not <= 2'b00;
    draw_and <= 2'b00;
    draw_or <= 1;
    draw_wA <= 7'b0000000;
    draw_wB <= 7'b0110001;
    draw_wnot0 <= 5'b00000;
    draw_wnot1 <= 5'b00000;
    draw_wand0 <= 3'b000;
    draw_wand1 <= 3'b000;
end

4'b1101:
begin
    draw_not <= 2'b00;
    draw_and <= 2'b00;
    draw_or <= 1;
    draw_wA <= 7'b0010001;
    draw_wB <= 7'b0010001;
    draw_wnot0 <= 5'b00000;
    draw_wnot1 <= 5'b00000;
    draw_wand0 <= 3'b000;
    draw_wand1 <= 3'b000;
end

4'b1110:
begin
    draw_not <= 2'b01;
    draw_and <= 2'b00;
    draw_or <= 1;
    draw_wA <= 7'b0000101;
    draw_wB <= 7'b0010001;
    draw_wnot0 <= 5'b00101;
    draw_wnot1 <= 5'b00000;
    draw_wand0 <= 3'b000;
    draw_wand1 <= 3'b000;
end

4'b1111:
begin
    draw_not <= 2'b01;
    draw_and <= 2'b00;
    draw_or <= 1;
    draw_wA <= 7'b0010101;
    draw_wB <= 7'b0000000;
    draw_wnot0 <= 5'b01001;
    draw_wnot1 <= 5'b00000;
    draw_wand0 <= 3'b000;
    draw_wand1 <= 3'b000;
end

default
begin
    draw_not <= 2'b11;
    draw_and <= 2'b11;
    draw_or <= 1;
    draw_wA <= 7'b1111111;
    draw_wB <= 7'b1111111;
    draw_wnot0 <= 5'b11111;
    draw_wnot1 <= 5'b11111;
    draw_wand0 <= 3'b111;
    draw_wand1 <= 3'b111;
end

endcase
end

always @(*)
begin
if (draw_wA)
    drawA <= 1;
else
    drawA <= 0;
if (draw_wB)
    drawB <= 1;
else
    drawB <= 0;
if (draw_wA || draw_wB)
    drawOUT <= 1;
else
    drawOUT <= 0;
end  
endmodule