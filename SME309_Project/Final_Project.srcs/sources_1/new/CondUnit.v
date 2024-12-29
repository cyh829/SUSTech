`timescale 1ns / 1ps
module CondUnit(
    input CLK,
    input PCSE,
    input RegWE,
    input MemWE,
    input [1:0]FlagWE,
    input [3:0]CondE,
    input [3:0]ALUFlags,
    input NoWriteE,
    // input FWE,

    output PCSrcE,
    output RegWriteE,
    output MemWriteE
    // output FWriteE

    );

    CondLogic CondLogic1(
     .CLK(CLK),
     .PCS(PCSE),
     .RegW(RegWE),
     .MemW(MemWE),
     .FlagW(FlagWE),
     .Cond(CondE),
     .ALUFlags(ALUFlags),
     .NoWrite(NoWriteE),
    //  .FW(FWE),

     .PCSrc(PCSrcE),
     .RegWrite(RegWriteE),
     .MemWrite(MemWriteE)
    //  .FWrite(FWriteE)
    );

endmodule
