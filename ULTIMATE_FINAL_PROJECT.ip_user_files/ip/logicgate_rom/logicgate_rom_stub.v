// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Tue Nov 14 22:36:03 2023
// Host        : Irwin running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/Irwin/University/AY2023-2024/EE2026/xc7a35tcpg236-1_LAB_PROJECTS/ULTIMATE_FINAL_PROJECT/ULTIMATE_FINAL_PROJECT.srcs/sources_1/ip/logicgate_rom/logicgate_rom_stub.v
// Design      : logicgate_rom
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2" *)
module logicgate_rom(clka, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[8:0],douta[4:0]" */;
  input clka;
  input [8:0]addra;
  output [4:0]douta;
endmodule
