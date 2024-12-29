`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/28 16:04:21
// Design Name: 
// Module Name: multiplier_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module multiplier_tb();
  reg[31:0] a, b;
  wire[31:0] prod;
  wire[7:0] a_e, b_e, p_e;
  wire[22:0] a_m, b_m, p_m;
  wire a_s, b_s, p_s;
  integer i;
  assign {a_s, a_e, a_m} = a;
  assign {b_s, b_e, b_m} = b;
  Multiplier multiplier1(a, b, {p_s, p_e, p_m}, underflow, overflow);
  initial begin
    a = 32'b0;
    b = 32'b0;
    #100;
      a=32'b0_01111111_100_0000_0000_0000_0000_0000;
      b=32'b0_10000000_101_0000_0000_0000_0000_0000;
  end
  always @(posedge underflow or posedge overflow)
    $display("Error detected, UNDR: %b OVRFLOW: %b", underflow, overflow);
endmodule
