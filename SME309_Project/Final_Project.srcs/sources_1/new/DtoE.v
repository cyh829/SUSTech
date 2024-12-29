`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/11 10:15:14
// Design Name: 
// Module Name: DtoE
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
module DtoE(
    input CLK,
    input Reset,
    input [31:0]RD1,
    input [31:0]RD2,
    input [31:0]ExtImm,
    input [3:0] WA3D,

    input [3:0]CondD,
    input PCSD,
    input RegWD,
    input MemWD, 
    input [1:0]FlagWD,
    input [1:0]ALUControlD,
    input MemtoRegD,
    input ALUSrcD,
    input [1:0]ImmSrcD,
    input [1:0]RegSrcD,
    input NoWriteD,

    input [3:0]RA1D,
    input [3:0]RA2D,
    input FlushE,
    // input [31:0]ShOutD,
    input [31:0]InstrD,
    input StartFD,
    input FPUOpD,
    input FWD,
    input StallE,

    // //
    output reg [31:0] SrcAE,
    output reg [31:0] WriteDataE_s,//注意此处的WritedataE其实就是RD2E，二者已连起故用后者名称
    output reg [31:0] ExtImmE,
    output reg [3:0] WA3E,

    output reg [3:0]CondE,
    output reg PCSE,
    output reg RegWE,
    output reg MemWE, 
    output reg [1:0]FlagWE,
    output reg [1:0]ALUControlE,
    output reg MemtoRegE,
    output reg ALUSrcE,
    output reg [1:0]ImmSrcE,
    output reg [1:0]RegSrcE,
    output reg NoWriteE,

    output reg [3:0] RA1E,
    output reg [3:0] RA2E,
    output reg [31:0] InstrE,

    output reg StartFE,
    output reg FPUOpE,
    output reg FWE

    );
always @(posedge CLK or posedge Reset) begin
    if (Reset) begin
       SrcAE <=0;
       WriteDataE_s <= 0;
       ExtImmE <= 0;
       WA3E <= 0;

       CondE <= 0; 
       PCSE <= 0;
       RegWE <= 0;
       MemWE <= 0;
       FlagWE <= 0;
       ALUControlE <= 0;
       MemtoRegE <= 0;
       ALUSrcE <= 0;
       ImmSrcE <= 0;
       RegSrcE <= 0;
       NoWriteE <= 0;
       RA1E <= 0;
       RA2E <= 0;
       InstrE<=0;
       StartFE <= 0;
       FPUOpE <= 0;
       FWE <= 0;
       
    end
    else if(StallE &&(!FlushE)) begin
       SrcAE <=SrcAE;
       WriteDataE_s <= WriteDataE_s;
       ExtImmE <= ExtImmE;
       WA3E <= WA3E;

       CondE <= CondE; 
       PCSE <= PCSE;
       RegWE <= RegWE;
       MemWE <= MemWE;
       FlagWE <= FlagWE;
       ALUControlE <= ALUControlE;
       MemtoRegE <= MemtoRegE;
       ALUSrcE <= ALUSrcE;
       ImmSrcE <= ImmSrcE;
       RegSrcE <= RegSrcE;
       NoWriteE <= NoWriteE;
       RA1E <= RA1E;
       RA2E <= RA2E;
       InstrE<=InstrE;
       StartFE <= StartFE;
       FPUOpE <= FPUOpE;
       FWE <= FWE;
    end
    else if (FlushE) begin//flush为1时清空状态寄存器
        SrcAE <=0;
        WriteDataE_s <= 0;
        ExtImmE <= 0;
        WA3E <= 0;

        CondE <= 0; 
        PCSE <= 0;
        RegWE <= 0;
        MemWE <= 0;
        FlagWE <= 0;
        ALUControlE <= 0;
        MemtoRegE <= 0;
        ALUSrcE <= 0;
        ImmSrcE <= 0;
        RegSrcE <= 0;
        NoWriteE <= 0;
        RA1E <= 0;
        RA2E <= 0;
        InstrE <= 0;
        StartFE <= 0;
        FPUOpE <= 0;
        FWE <= 0;
    end
    else begin
        SrcAE <= RD1;
        WriteDataE_s <= RD2;
        ExtImmE <= ExtImm;
        WA3E <= WA3D;

        CondE <= CondD;
        PCSE <= PCSD;
        RegWE <= RegWD;
        MemWE <= MemWD;
        FlagWE <=FlagWD;
        ALUControlE <= ALUControlD;
        MemtoRegE <= MemtoRegD;
        ALUSrcE <= ALUSrcD;
        ImmSrcE <= ImmSrcD;
        RegSrcE <= RegSrcD;
        NoWriteE <= NoWriteD;
        RA1E <= RA1D;
        RA2E <= RA2D;
        InstrE <= InstrD;
        StartFE <= StartFD;
        FPUOpE <= FPUOpD;
        FWE <= FWD;
    end
    
end

endmodule
