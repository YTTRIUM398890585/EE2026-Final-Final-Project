`timescale 1ns / 1ps

module Menu(
    input CLOCK,
    input [1:0]sw,
    input btnL,btnR,btnC,
    output reg [1:0]mode_state=0,
    input [12:0]pixel_index,
    output [15:0]oled_data_startup,
    output reg [15:0]oled_data_mainmenu = 0
    );
    
    wire startup_2Hz_clk;
    clock_gen startup_2Hz_clk_gen(.clk_in(CLOCK), .m(24999999), .clk_out(startup_2Hz_clk));  // 2 Hz m = 24999999

    wire mif_reader_clk;
    clock_gen mif_reader_clk_gen(.clk_in(CLOCK), .m(7), .clk_out(mif_reader_clk));  // 6.25 MHz m = 7
   
    wire [15:0]oled1;  
    display1 display1(CLOCK,pixel_index,oled1); 
    wire [15:0]oled2;  
    display2 display2(CLOCK,pixel_index,oled2);  
    
    Blinkingdisplay(startup_2Hz_clk,CLOCK,oled1,oled2,oled_data_startup);

    wire debounceL;
    wire debounceR;
    wire [12:0]x,y;
    reg [1:0]option=0;

    assign x = pixel_index%96;
    assign y = pixel_index/96;   
    parameter Menured = 16'b1111100000000000;
    parameter expression = 16'b1010010100101101;
    parameter circuit = 16'b00001111111000000;
    parameter blue = 16'b0000000000111111;
    parameter black = 16'b0000000000000000;
    parameter light = 16'b1111111111111111;

    parameter INIT_SCREEN = 0;
    parameter MENU_SCREEN = 1;
    parameter KMAP_CIR_SCREEN = 2;
    parameter CIR_SIM_SCREEN = 3;
    
    button_debounce unit2(btnL, CLOCK, debounceL);
    button_debounce unit3(btnR, CLOCK, debounceR);

    reg [31:0]startup_count = 0;

    reg [31:0]escape_count = 0;

    reg [31:0]escape_wait_count = 0;

    always@(posedge CLOCK)begin
        // count to 10 with 2 Hz clock to swap over to main menu after startup finished
        startup_count <= startup_count == 500_000_000 ? startup_count : startup_count + 1;

        // only will change mode_state if its 0 else dun touch
        mode_state <= mode_state == INIT_SCREEN & startup_count == 500_000_000 ? MENU_SCREEN : mode_state;

        if (btnL == 1 & debounceL==1 )begin
            option <= (option==1)?option:option+1;                 
        end

        if (btnR == 1 & debounceR==1 )begin
            option <= (option==0)?option:option-1;                 
        end

        if (option==1)begin
            if (btnC==1 && escape_wait_count == 0)begin
                mode_state <= KMAP_CIR_SCREEN; // mode 1 - kmap to circuit
            end
        end 

        if (option==0)begin
            if (btnC==1 && escape_wait_count == 0)begin
                mode_state <= CIR_SIM_SCREEN; // mode 2 - circuit to simulation
            end
        end

        // to escape after pressing 2 seconds if in the 2 modes
        escape_count <= btnC && (mode_state == KMAP_CIR_SCREEN || mode_state == CIR_SIM_SCREEN) ? (escape_count == 200_000_000 ? escape_count : escape_count + 1) : 0;

        escape_wait_count <= escape_wait_count == 0 ? escape_wait_count : escape_wait_count - 1;

        if (escape_count == 200_000_000) begin
            mode_state <= MENU_SCREEN; 
            escape_wait_count <= 100_000_000;
        end 


   end
   
    always@(posedge CLOCK)begin
        if ((x>=24 & x<=71)& y==3 | 
        (x==35 | x==39 | x==42 | x==43 | x==44 | x==45 | x==46 | x==49 | x==54 | x==57 | x==61 ) & y==5|
        (x==35 | x==36 | x==38 | x==39 | x==42 | x==49 | x==50 | x==52| x==57 | x==61 ) & y==6|
        (x==35 | x==37 | x==42 | x==39 | x==43 | x==44 | x==49 | x==51 | x==54 | x==57 | x==61) & y==7|
        (x==35 | x==39 | x==42 | x==43 | x==44 | x==45 | x==46 | x==49 | x==53 | x==54 | x==57 | x==58 | x==59 | x==60 | x==61) & y==9|
        (x==35|x==39|x==42|x==49|x==52|x==54|x==57|x==61)&y==8|(x>=24 & x<=71)&y==11)
        begin
            oled_data_mainmenu <= Menured;
        end
        else if(
        (x>=3&x<=46)& y==22 | (x>=3&x<=46)& y==14 | (x==2 | x==47)&y==15 |
        (x==2|x==5|x==7|x==10|x==13|x==15|x==19|x==21|x==26|x==31|x==37|x==40|x==42|x==44|x==45|x==47)&y==17|
        (x==2|x==6|x==10|x==11|x==12|x==13|x==15|x==16|x==17|x==18|x==21|x==22|x==23|x==27|x==28|x==32|x==33|x==37|x==40|x==42|x==44|x==46|x==47)&y==18|(x==2 | x==10 | x==11 | x==12 | x==13 | x==15 | x==16 | x==17 | x==18 | x==21 |x==22 | x==28 | x==29 | x==33 | x==34 | x==36 | x==37 | x==38 | x==40 | x==41 | x==42 | x==44 | x==47)&y==16 | 
        (x==2|x==4|x==8|x==10|x==15|x==19|x==21|x==22|x==23|x==24|x==26|x==27|x==28|x==31|x==32|x==33|x==36|x==37|x==38|x==40 |x==41|x==42|x==44|x==47)&y==20|(x==2&x==47)&y==21|(x==2 | x==5 | x==7 | x==10 | x==15 | x==18 | x==21 | x==29 | x==34 | x==37 | x==40 | x==42 | x==44 | x==47)&y==19)
        begin
            oled_data_mainmenu <= expression;
        end
        else if((x>=52&x<=94)&y==14|(x>=52&x<=94)&y==22 | (x==51|x==95)&y==15 | (x==51|x==95)&y==21 | (x==51 | x==53 | x==54 | x==55 | x==56 | x==57 | x==60 | x==61 | x==62 | x== 65 | x==66 | x==67 | x==68 | x==72 | x==73 | x==74 | x==75 | x==76| x==79 | x==83 | x==85 | x==86 | x==87 | x==89 | x==90 | x==91 | x==92 |x==93|x==95)&y==16|(x==51 | x==53 | x==61 | x==65 | x==69 | x==72 | x==79 | x==83 | x==86 | x==91 | x==95)&y==17|(x==51 | x==53|x==61|x==65|x==66|x==67|x==68|x==72|x==79|x==83|x==86|x==91|x==95)&y==18|(x==51|x==53|x==61|x==65|x==68|x==72|x==79|x==83|x==86|x==91|x==95)&y==19|(x==51 | x==53 | x==54 | x==55 | x==56 | x==57 | x==60 | x==61 | x==62 | x==65 | x==69 | x==72 | x==73 | x==74 | x==75 | x==76 | x==79 | x==80 | x==81 | x==82 | x==83 |x==85|x==86|x==87|x==91|x==95 )&y==20
        )begin
            oled_data_mainmenu <= circuit;
        end
        else if ((x>=0&x<=46)&y==24|(x>=48&x<=95)&y==24|x==46&(y>=25&y<=63)|x==48&(y>=25&y<=63) | (x>=0&x<=46)&y==63 | (x>=48&x<=95)&y==63|x==0&(y>=25&y<=63)|x==95&(y>=25&y<=63)
        )begin
            oled_data_mainmenu <= blue;
        end
        else if((x>=59&x<=90)&(y>=30&y<=35)|(x>=69&x<=77)&(y>=36&y<=59))begin
                    if (option==0)begin

                oled_data_mainmenu <= Menured;
            end
        end
        else if((x>=8&x<=39)&(y>=30&y<=35)|(x>=18&x<=26)&(y>=36&y<=59))begin
                    if (option==1)begin

                oled_data_mainmenu <= Menured;
            end
        end
        else
            oled_data_mainmenu <= (sw[0])? light:black;   
    end
endmodule