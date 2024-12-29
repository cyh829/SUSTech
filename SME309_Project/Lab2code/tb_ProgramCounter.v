`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/01 20:21:27
// Design Name: 
// Module Name: tb_ProgramCounter
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


module tb_ProgramCounter();
   reg CLK;
   reg Reset;
   reg PCSrc;
   reg [31:0] Result;
   
   wire [31:0] PC;
   wire [31:0] PC_Plus_4;
   
   // ʵ����Ҫ���Ե�ProgramCounterģ��
   ProgramCounter PC_inst (
       .CLK(CLK),
       .Reset(Reset),
       .PCSrc(PCSrc),
       .Result(Result),
       .PC(PC),
       .PC_Plus_4(PC_Plus_4)
   );
   
   // ʱ���ź�����
   always begin
       #5 CLK = ~CLK;
   end
   // ��ʼ���ź�
   initial begin
       CLK = 0;
       Reset = 0;
       PCSrc = 0;
       #10 Reset = 1;
       #10 Reset = 0;
       #10 Reset = 0;
       #10 Result = 32'b1;PCSrc = 1;
        #10 Result = 32'b1;PCSrc = 0;
       #100
       // ��Ӹ���������������
       $finish;
   end
endmodule
