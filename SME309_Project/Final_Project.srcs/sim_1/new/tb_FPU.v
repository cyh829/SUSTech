`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 19:18:08
// Design Name: 
// Module Name: tb_FPU
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


module tb_FPU();
    reg CLK,Reset;
    reg [31:0]NumA;
    reg [31:0]NumB;
    reg StartF;
    reg FPUOp;

    wire [31:0]Result;
    wire Fneedstall;
    FPU fpu1(
        .CLK(CLK),
        .Reset(Reset),
        .NumA(NumA),
        .NumB(NumB),
        .StartF(StartF),
        .FPUOp(FPUOp),

        .Result(Result),
        .Fneedstall(Fneedstall)
    );

    initial begin
      CLK = 0;
      Reset = 1;
      StartF = 1;
      NumA = 32'b0_01111111_100_0000_0000_0000_0000_0000;
      NumB = 32'b0_10000000_101_0000_0000_0000_0000_0000;
      #50

      Reset = 0;
      FPUOp = 0;
      NumA = 32'b0_01111111_100_0000_0000_0000_0000_0000;
      NumB = 32'b0_10000000_101_0000_0000_0000_0000_0000;
      #200
      FPUOp = 1;
      NumA = 32'b0_01111111_100_0000_0000_0000_0000_0000;
      NumB = 32'b0_10000000_101_0000_0000_0000_0000_0000;
      #200
      FPUOp = 0;
      NumA = 32'b0_01111111_101_1010_0000_0000_0000_0000;
      NumB = 32'b0_10000000_101_0000_0000_0000_0000_0000;
      #200
      FPUOp = 1;
      NumA = 32'b0_01111111_101_1001_0000_0000_0000_0000;
      NumB = 32'b0_10000000_101_0001_0000_0000_0000_0000;
      // #200
      

      // #150
      // NumA = 32'b0_01111111_100_0000_0000_0000_0000_0000;
      // NumB = 32'b0_10000000_101_0000_0000_0000_0000_0000;
      // #150
      // NumA = 32'b0_01111111_101_0000_0000_0000_0000_0000;
      // NumB = 32'b0_10000000_101_0000_0000_0000_0000_0000;
      
    end
    
    always #5 CLK=~CLK;


endmodule
