-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Tue Nov 14 22:43:31 2023
-- Host        : Irwin running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/Irwin/University/AY2023-2024/EE2026/xc7a35tcpg236-1_LAB_PROJECTS/ULTIMATE_FINAL_PROJECT/ULTIMATE_FINAL_PROJECT.srcs/sources_1/ip/canvasgrid_ram/canvasgrid_ram_stub.vhdl
-- Design      : canvasgrid_ram
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity canvasgrid_ram is
  Port ( 
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 5 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 20 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 20 downto 0 );
    clkb : in STD_LOGIC;
    web : in STD_LOGIC_VECTOR ( 0 to 0 );
    addrb : in STD_LOGIC_VECTOR ( 5 downto 0 );
    dinb : in STD_LOGIC_VECTOR ( 20 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 20 downto 0 )
  );

end canvasgrid_ram;

architecture stub of canvasgrid_ram is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,wea[0:0],addra[5:0],dina[20:0],douta[20:0],clkb,web[0:0],addrb[5:0],dinb[20:0],doutb[20:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_1,Vivado 2018.2";
begin
end;