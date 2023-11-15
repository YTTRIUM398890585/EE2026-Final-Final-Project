`timescale 1ns / 1ps

module kmap(
    input CLOCK, 
    input [12:0]pixel_index,
    input [15:0]sw,
    input btnR,btnL,
    output reg [15:0]oled_data,
    output reg [3:0]AB=0,
    output reg showcircuit = 0,
    output [15:0]led
    );
    
    wire [12:0]x,y;
    assign x = pixel_index%96;
    assign y = pixel_index/96;
       
    reg ready=0;
    
    parameter blue = 16'b0000000000111111;
    parameter white = 16'b1111111111111111;
    parameter black=16'b0000000000000000;

    //for the border of the kmap
    parameter box1x=1;
    parameter box2x=30;
    parameter box3x=1;
    parameter box4x=67;
    parameter boxyup= 7;
    parameter boxyup2= 27;
    parameter boxyup3= 47;

    

    
    always@(posedge CLOCK)begin
        oled_data <= black;

//A
    if ((x>=(box1x+4)&x<=(box1x+7))&y==(boxyup2+2)| (x>=(box1x+3)&x<=(box1x+4))&y==(boxyup2+3)| (x>=(box1x+7)&x<=(box1x+8))&y==(boxyup2+3)| (x>=(box1x+2)&x<=(box1x+3))&(y>=(boxyup2+4)&y<=(boxyup2+11))| (x>=(box1x+8)&x<=(box1x+9))&(y>=(boxyup2+4)&y<=(boxyup2+11))| (x>=(box1x+4)&x<=(box1x+7))&y==(boxyup2+6))begin
        oled_data<= white;
    end
//B
    else if ((x>=(box2x+2)&x<=(box2x+3))& (y>=(boxyup+2)&y<=(boxyup+11))|(y>=(boxyup+3)&y<=(boxyup+10))&x==(box2x+8)|(x>=(box2x+4)&x<=(box2x+7))&y==(boxyup+2)| (x>=(box2x+4)&x<=(box2x+7))&y==(boxyup+6)|(x>=(box2x+4)&x<=(box2x+7))&y==(boxyup+11))begin
        oled_data<= white;        
    end
//Abar
    else if ((x>=(box3x+4)&x<=(box3x+7))&y==(boxyup3+2)| (x>=(box3x+3)&x<=(box3x+4))&y==(boxyup3+3)| (x>=(box3x+7)&x<=(box3x+8))&y==(boxyup3+3)| (x>=(box3x+2)&x<=(box3x+3))&(y>=(boxyup3+4)&y<=(boxyup3+11))| (x>=(box3x+8)&x<=(box3x+9))&(y>=(boxyup3+4)&y<=(boxyup3+11))| (x>=(box3x+4)&x<=(box3x+7))&y==(boxyup3+6)|(x>=(box3x+3)&x<=(box3x+8))&y==boxyup3)begin
            oled_data<= white;        
        end
//Bbar
     else if ((x>=(box4x+2)&x<=(box4x+3))& (y>=(boxyup+2)&y<=(boxyup+11))|(y>=(boxyup+3)&y<=(boxyup+10))&x==(box4x+8)|(x>=(box4x+4)&x<=(box4x+7))&y==(boxyup+2)| (x>=(box4x+4)&x<=(box4x+7))&y==(boxyup+6)|(x>=(box4x+4)&x<=(box4x+7))&y==(boxyup+11)| (x>=(box4x+3)&x<=(box4x+8))&y==boxyup)begin
                oled_data<= white;        
            end
//lines            
     else if ((x>=3&x<=91&(y==21|y==44))|(x==14|x==57)&(y>=13&y<=61))begin
                oled_data<= blue;
     end
//ones and zeros of AB     
     else if ((x>=(box2x+2)&x<=(box2x+9))& (y>=(boxyup2+2)&y<=(boxyup2+3))|(x>=(box2x+2)&x<=(box2x+3))& (y>=(boxyup2+4)&y<=(boxyup2+8))|(x>=(box2x+8)&x<=(box2x+9))& (y>=(boxyup2+4)&y<=(boxyup2+8))|(x>=(box2x+2)&x<=(box2x+9))& (y>=(boxyup2+9)&y<=(boxyup2+10))
     )begin
        if (~sw[14])begin
                oled_data<= white;                  
        end
     end
    else if((x>=(box2x+4)&x<=(box2x+6))& (y>=(boxyup2+2)&y<=(boxyup2+10))
     )begin
        if (sw[14])begin
                oled_data<= white;                  
        end
     end
     
//ones and zeros of AbB         
     else if ((x>=(box2x+2)&x<=(box2x+9))& (y>=(boxyup3+2)&y<=(boxyup3+3))|(x>=(box2x+2)&x<=(box2x+3))& (y>=(boxyup3+4)&y<=(boxyup3+8))|(x>=(box2x+8)&x<=(box2x+9))& (y>=(boxyup3+4)&y<=(boxyup3+8))|(x>=(box2x+2)&x<=(box2x+9))& (y>=(boxyup3+9)&y<=(boxyup3+10))
     )begin
        if (~sw[15])begin
                oled_data<= white;                  
        end
     end
    else if((x>=(box2x+4)&x<=(box2x+6))& (y>=(boxyup3+2)&y<=(boxyup3+10))
     )begin
        if (sw[15])begin
                oled_data<= white;                  
        end
     end
     
 //ones and zeros of ABb     
     else if ((x>=(box4x+2)&x<=(box4x+9))& (y>=(boxyup2+2)&y<=(boxyup2+3))|(x>=(box4x+2)&x<=(box4x+3))& (y>=(boxyup2+4)&y<=(boxyup2+8))|(x>=(box4x+8)&x<=(box4x+9))& (y>=(boxyup2+4)&y<=(boxyup2+8))|(x>=(box4x+2)&x<=(box4x+9))& (y>=(boxyup2+9)&y<=(boxyup2+10))
     )begin
        if (~sw[12])begin
                oled_data<= white;                  
        end
     end
    else if((x>=(box4x+4)&x<=(box4x+6))& (y>=(boxyup2+2)&y<=(boxyup2+10))
     )begin
        if (sw[12])begin
                oled_data<= white;                  
        end
     end
     
//ones and zeros of AbBb
     else if ((x>=(box4x+2)&x<=(box4x+9))& (y>=(boxyup3+2)&y<=(boxyup3+3))|(x>=(box4x+2)&x<=(box4x+3))& (y>=(boxyup3+4)&y<=(boxyup3+8))|(x>=(box4x+8)&x<=(box4x+9))& (y>=(boxyup3+4)&y<=(boxyup3+8))|(x>=(box4x+2)&x<=(box4x+9))& (y>=(boxyup3+9)&y<=(boxyup3+10))
     )begin
        if (~sw[13])begin
                oled_data<= white;                  
        end
     end
    else if((x>=(box4x+4)&x<=(box4x+6))& (y>=(boxyup3+2)&y<=(boxyup3+10))
     )begin
        if (sw[13])begin
                oled_data<= white;                  
        end
     end
                  
     
    


    end
    
always@(posedge CLOCK)begin
    AB[11] <= ~ready;
    if (btnR==1 )begin
        ready <=1;
        AB[3]<=sw[15]; //AbB
        AB[2]<=sw[14]; //AB
        AB[1]<=sw[13]; //AbBb
        AB[0]<=sw[12]; //ABb
        showcircuit <=1;
    end
    if (btnL==1 )begin
        ready <=0;
        showcircuit <=0;
    end
    end

    assign led[15:12] = AB[3:0];
    assign led[11] =ready;
    assign led[10:0] =0;


    
endmodule