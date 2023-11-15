module MIF_Reader (
    input CLOCK,
    input reset,
    input [12:0] pix_index,
    input mode, // Input to select MIF file (2 MIF files, for example)          
    output reg [15:0] oled_data 
);

reg [15:0] memory [0:6143]; // 96x64 pixel OLED display (16-bit color depth)
reg [15:0] memory2 [0:6143]; // 96x64 pixel OLED display (16-bit color depth)

initial begin
    // Read data from the MIF file and initialize memory

        $readmemh("frame1.mif", memory);
        $readmemh("frame2.mif", memory2);
end

always @(posedge CLOCK) begin
        if (mode==0)begin
            oled_data <= memory[pix_index]; 
        end
        else if (mode==1)begin
            oled_data <= memory2[pix_index]; 
        end
end

endmodule