module ControlUnit(
    input [31:0] Instr,
    input CLK,


    output PCSD,
    output RegWD,
    output MemWD, 
    output [1:0]FlagWD,
    output [1:0]ALUControlD,
    output MemtoRegD,
    output ALUSrcD,
    output [1:0]ImmSrcD,
    output [1:0]RegSrcD,
    output NoWriteD,//此处相比图上增加了Nowrite到condunit
    output StartFD,
    output FPUOpD
    // output FWD

    // output MemtoReg,
    // output MemWrite,
    // output ALUSrc,
    // output [1:0] ImmSrc,
    // output RegWrite,
    // output [1:0] RegSrc,
    // output [1:0] ALUControl,	
    // output PCSrc

    ); 
    
    // CondLogic CondLogic1(
    //  .CLK(CLK),
    //  .PCS(PCS),
    //  .RegW(RegW),
    //  .MemW(MemW),
    //  .FlagW(FlagW),
    //  .Cond(Cond),
    //  .ALUFlags(ALUFlags),
    //  .NoWrite(NoWrite),

    //  .PCSrc(PCSrc),
    //  .RegWrite(RegWrite),
    //  .MemWrite(MemWrite)
    // );

    Decoder Decoder1(
     .Instr(Instr),
     .PCS(PCSD),
     .RegW(RegWD),
     .MemW(MemWD),
     .MemtoReg(MemtoRegD),
     .ALUSrc(ALUSrcD),
     .ImmSrc(ImmSrcD),
     .RegSrc(RegSrcD),
     .ALUControl(ALUControlD),
     .FlagW(FlagWD),
     .NoWrite(NoWriteD),

     .StartF(StartFD),
     .FPUOp(FPUOpD)
    //  .FW(FWD)
    );
endmodule