// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Tue Nov 14 22:43:31 2023
// Host        : Irwin running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/Irwin/University/AY2023-2024/EE2026/xc7a35tcpg236-1_LAB_PROJECTS/ULTIMATE_FINAL_PROJECT/ULTIMATE_FINAL_PROJECT.srcs/sources_1/ip/canvasgrid_ram/canvasgrid_ram_stub.v
// Design      : canvasgrid_ram
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2" *)
module canvasgrid_ram(clka, wea, addra, dina, douta, clkb, web, addrb, dinb, 
  doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[5:0],dina[20:0],douta[20:0],clkb,web[0:0],addrb[5:0],dinb[20:0],doutb[20:0]" */;
  input clka;
  input [0:0]wea;
  input [5:0]addra;
  input [20:0]dina;
  output [20:0]douta;
  input clkb;
  input [0:0]web;
  input [5:0]addrb;
  input [20:0]dinb;
  output [20:0]doutb;
endmodule
