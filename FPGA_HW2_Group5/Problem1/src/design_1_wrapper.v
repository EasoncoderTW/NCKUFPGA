//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.2 (lin64) Build 4029153 Fri Oct 13 20:13:54 MDT 2023
//Date        : Sun Apr 14 11:55:32 2024
//Host        : e500-16 running 64-bit Ubuntu 22.04.4 LTS
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (btn,
    clk,
    rgb4,
    rgb5,
    rst,
    sw);
  input btn;
  input clk;
  output [2:0]rgb4;
  output [2:0]rgb5;
  input rst;
  input [1:0]sw;

  wire btn;
  wire clk;
  wire [2:0]rgb4;
  wire [2:0]rgb5;
  wire rst;
  wire [1:0]sw;

  design_1 design_1_i
       (.btn(btn),
        .clk(clk),
        .rgb4(rgb4),
        .rgb5(rgb5),
        .rst(rst),
        .sw(sw));
endmodule
