`timescale 1ns / 1ps

module AlgebraInput(
    input CLOCK, 
    input [12:0]pixel_index,
    input btnL,btnR,btnC,
    output reg [15:0]oled_data
    );
    wire [12:0]x,y;
    assign x = pixel_index%96;
    assign y = pixel_index/96;
    
    reg currentposx=3;
    reg frameposx;
    reg [2:0]choice=0;
    wire debounceL;
    wire debounceR;
    
     parameter blue = 16'b0000000000111111;
     reg currentposy=8;
     parameter black=16'b0000000000000000;
     parameter box1x=1;
     parameter box2x=16;
     parameter box3x=31;
     parameter box4x=46;
     parameter box5x=61;
     parameter box6x=76;
     parameter boxyup= 41;
     parameter boxydown= 53; 
     parameter white = 16'b1111111111111111;
       
     
always@(posedge CLOCK)begin
        oled_data <= black;
//A
    if ((x>=(box1x+4)&x<=(box1x+7))&y==(boxyup+2)| (x>=(box1x+3)&x<=(box1x+4))&y==(boxyup+3)| (x>=(box1x+7)&x<=(box1x+8))&y==(boxyup+3)| (x>=(box1x+2)&x<=(box1x+3))&(y>=(boxyup+4)&y<=(boxyup+11))| (x>=(box1x+8)&x<=(box1x+9))&(y>=(boxyup+4)&y<=(boxyup+11))| (x>=(box1x+4)&x<=(box1x+7))&y==(boxyup+6))begin
        oled_data<= white;
    end
//B
    else if ((x>=(box2x+2)&x<=(box2x+3))& (y>=(boxyup+2)&y<=(boxyup+11))|(y>=(boxyup+3)&y<=(boxyup+10))&x==(box2x+8)|(x>=(box2x+4)&x<=(box2x+7))&y==(boxyup+2)| (x>=(box2x+4)&x<=(box2x+7))&y==(boxyup+6)|(x>=(box2x+4)&x<=(box2x+7))&y==(boxyup+11))begin
        oled_data<= white;        
    end
//Abar
    else if ((x>=(box3x+4)&x<=(box3x+7))&y==(boxyup+2)| (x>=(box3x+3)&x<=(box3x+4))&y==(boxyup+3)| (x>=(box3x+7)&x<=(box3x+8))&y==(boxyup+3)| (x>=(box3x+2)&x<=(box3x+3))&(y>=(boxyup+4)&y<=(boxyup+11))| (x>=(box3x+8)&x<=(box3x+9))&(y>=(boxyup+4)&y<=(boxyup+11))| (x>=(box3x+4)&x<=(box3x+7))&y==(boxyup+6)|(x>=(box3x+3)&x<=(box3x+8))&y==boxyup)begin
            oled_data<= white;        
        end
//Bbar
     else if ((x>=(box4x+2)&x<=(box4x+3))& (y>=(boxyup+2)&y<=(boxyup+11))|(y>=(boxyup+3)&y<=(boxyup+10))&x==(box4x+8)|(x>=(box4x+4)&x<=(box4x+7))&y==(boxyup+2)| (x>=(box4x+4)&x<=(box4x+7))&y==(boxyup+6)|(x>=(box4x+4)&x<=(box4x+7))&y==(boxyup+11)| (x>=(box4x+3)&x<=(box4x+8))&y==boxyup)begin
                oled_data<= white;        
            end
//sum
     else if ((x>=(box5x+5)&x<=(box5x+6))&(y>=(boxyup+2)&y<=(boxyup+4))| (x>=(box5x+2)&x<=(box5x+9))&(y>=(boxyup+5)&y<=(boxyup+6))|(x>=(box5x+5)&x<=(box5x+6))&(y>=(boxyup+7)&y<=(boxyup+9)))begin
                    oled_data<= white;        
                end
//product
     else if ((x>=(box6x+4)&x<=(box6x+7))&(y>=(boxyup+4)&y<=(boxyup+7)))begin
                        oled_data<= white;        
                    end
                    
//underline
     if (x>=box1x&x<=(box1x+10)&y==boxydown)begin
        if (choice==0)begin
            oled_data<=blue;
        end
     end
     if (x>=box2x&x<=(box2x+10)&y==boxydown)begin
        if (choice==1)
            oled_data<=blue;
     end
     if (x>=box3x&x<=(box3x+10)&y==boxydown)begin
        if (choice==2)
            oled_data<=blue;
     end
     if (x>=box4x&x<=(box4x+10)&y==boxydown)begin
        if (choice==3)
            oled_data<=blue;
     end
     if (x>=box5x&x<=(box5x+10)&y==boxydown)begin
        if (choice==4)
            oled_data<=blue;
     end
     if (x>=box6x&x<=(box6x+10)&y==boxydown)begin
        if (choice==5)
            oled_data<=blue;
     end
      if (x==currentposx & y==currentposy)begin
        oled_data <=blue;
     end
end

   
   button_debounce unit2(btnL, CLOCK, debounceL);
   button_debounce unit3(btnR, CLOCK, debounceR);
   
   always@(posedge CLOCK)begin
           if (btnL == 1 & debounceL==1 )begin
               choice <= choice+1;                 
           end
           if (btnR == 1 & debounceR==1 )begin
               choice <= choice-1;                 
           end
                if (btnC==1)begin
                    currentposx <= currentposx+10;
                end
      end 
      
      
   
    
        
endmodule
