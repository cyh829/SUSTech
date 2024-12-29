`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/02 14:55:19
// Design Name: 
// Module Name: tb_CondLogic
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


module tb_CondLogic();
    reg CLK;
    reg PCS;
    reg RegW;
    reg MemW;
    reg [1:0]FlagW;
    reg [3:0]Cond;
    reg [3:0] ALUFlags;
    reg NoWrite;
    
    wire PCSrc;
    wire RegWrite;
    wire MemWrite;

    CondLogic uut(
     .CLK(CLK),
     .PCS(PCS),
     .RegW(RegW),
     .MemW(MemW),
     .FlagW(FlagW),
     .Cond(Cond),
     .ALUFlags(ALUFlags),
     .NoWrite(NoWrite),

     .PCSrc(PCSrc),
     .RegWrite(RegWrite),
     .MemWrite(MemWrite)
    );

    always begin
       #5 CLK = ~CLK;
   end
   // ��ʼ���ź�
   initial begin
       CLK = 0;
       PCS = 0;
       RegW = 0;
       MemW = 0;
       FlagW = 0;
       Cond = 0;
       ALUFlags = 0;
       NoWrite = 0;
       
       #10 FlagW =2'b11;PCS=1;RegW=1;MemW=1;Cond = 4'b0000;ALUFlags=4'b1111;
       #10 FlagW =2'b11;PCS=1;RegW=1;MemW=1;Cond = 4'b1110;ALUFlags=4'b1111;
       #10 FlagW =2'b11;PCS=1;RegW=1;MemW=1;Cond = 4'b1110;ALUFlags=4'b1111;
       #10 FlagW =2'b11;PCS=1;RegW=1;MemW=1;Cond = 4'b1110;ALUFlags=4'b1111;
       #10 FlagW =2'b11;PCS=1;RegW=1;MemW=1;Cond = 4'b0000;ALUFlags=4'b1111;
       #10 FlagW =2'b11;PCS=1;RegW=1;MemW=1;Cond = 4'b0001;ALUFlags=4'b1111;
       #10 FlagW =2'b11;PCS=1;RegW=1;MemW=1;Cond = 4'b0001;ALUFlags=4'b1111;
       #10 FlagW =2'b11;PCS=1;RegW=1;MemW=1;Cond = 4'b0001;ALUFlags=4'b0000;
       #10 FlagW =2'b11;PCS=1;RegW=1;MemW=1;Cond = 4'b1110;ALUFlags=4'b1111;
       #10 FlagW =2'b11;PCS=0;RegW=1;MemW=1;Cond = 4'b1110;ALUFlags=4'b1111;
       #10 FlagW =2'b11;PCS=1;RegW=0;MemW=1;Cond = 4'b1110;ALUFlags=4'b1111;
       #10 FlagW =2'b11;PCS=1;RegW=1;MemW=0;Cond = 4'b1110;ALUFlags=4'b1111;
       // ���Ӹ���������������
       $finish;
   end
endmodule
