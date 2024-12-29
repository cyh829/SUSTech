module ARM(
    input CLK,
    input Reset,
    input [31:0] Instr,
    input [31:0] ReadData,//Readdata其实为readdataM

    output MemWrite,
    output [31:0] PC,
    output [31:0] ALUResult,
    output [31:0] WriteData
); 

//总输入输出端口定义，为一致不改动名称
assign MemWrite = MemWriteM;
assign ALUResult = ALUOutM;
assign WriteData = (ForwardM == 0)?WriteDataM:ResultW;
//fetch part
// assign WriteDataE = RD2;
wire [31:0] PCPlus4F;
wire MemtoReg;
wire [3:0]RA1D;
reg [3:0]RA1_s;
assign RA1D = RA1_s;
wire [3:0]RA2D;
reg [3:0]RA2_s;
assign RA2D = RA2_s;

wire [31:0]RD2;
wire RegWrite;
wire [1:0]RegSrc;


wire [3:0] WA3D = InstrD[15:12];
wire [31:0]RD1;


wire PCSD,RegWD,MemD,FlagWD,MemtoRegD,ALUSrcD,NoWriteD;
wire [1:0] ALUControlD;
wire [1:0] ImmSrcD ;
wire [1:0] RegSrcD ;
wire [31:0]WA3W;

wire [31:0]PCPlus8D;
assign PCPlus8D = PCPlus4F;//去掉一个代表pc+8的加法器
wire [31:0]ExtImm;
wire [23:0]InstrImm;
assign InstrImm = InstrD[23:0];
wire [1:0]ImmSrc;
wire [31:0]SrcAE;
wire [31:0]SrcAE_s;
wire [31:0]ALUResultE;
wire [31:0]SrcBE;
wire [31:0]WA3E;
wire [31:0]WriteDataE;
assign SrcBE = ALUSrcE==0?WriteDataE:ExtImmE;
wire [31:0]WriteDataE_s ;
wire PCSE,RegWE,MemE,FlagWE,MemtoRegE,ALUSrcE,NoWriteE;
wire [1:0] ALUControlE;
wire [1:0] ImmSrcE ;
wire [1:0] RegSrcE ;
wire [3:0] CondD;
assign CondD = InstrD[31:28];
wire [3:0]CondE;
wire [3:0]RA1E;
wire [3:0]RA2E;
wire[1:0]ForwardAE;
wire[1:0]ForwardBE;
wire [3:0]RA2M;
wire ForwardM ;
wire [3:0]ALUFlags;
wire PCSrcE,RegWriteE,MemWriteE;

wire [31:0]ALUOutM ;
wire [31:0] WA3M ;
wire [31:0]WriteDataM ;
wire PCSrcM,RegWriteM,MemWriteM;

wire [31:0]ALUOutW;
wire [31:0]ReadDataW;
wire PCSrcW,RegWriteW,MemtoRegW;
assign ResultW =  MemtoRegW== 1 ? ReadDataW:ALUOutW;

wire StallD,StallF,FlushE,FlushD;

ProgramCounter ProgramCounter1(
    .CLK(CLK),
    .Reset(Reset),
    .PCSrc(PCSrcE),//early BTA,从PcsrcW转成PCSrcE
    .Result(ALUResultE),//early BTA,从ResultW转成ALUResulE
    .StallF(StallF),

    .PCF(PC),
    .PC_Plus_4(PCPlus4F)
);
//FtoD part
wire [31:0]InstrD;
wire [31:0]PCPlus4D;
FtoD FtoD1 (
    .CLK(CLK),
    .Reset(Reset),
    .InstrF(Instr),
    .PCPlus4F(PCPlus4F),
    .StallD(StallD),
    .FlushD(FlushD),

    .InstrD(InstrD),
    .PCPlus4D(PCPlus4D)
);
//Decode part

ControlUnit ControlUnit1(
    .Instr(InstrD),
    .CLK(CLK),

    .PCSD(PCSD),
    .RegWD(RegWD),
    .MemD(MemD),
    .FlagWD(FlagWD),
    .ALUControlD(ALUControlD),
    .MemtoRegD(MemtoRegD),
    .ALUSrcD(ALUSrcD),
    .ImmSrcD(ImmSrcD),
    .RegSrcD(RegSrcD),
    .NoWriteD(NoWriteD)
);
//Register file 前面的数据选择器
always @( *) begin
    if (!RegSrcD[0]) begin
        RA1_s = InstrD[19:16];
    end
    else begin
        RA1_s = 4'd15;
    end
    if (!RegSrcD[1]) begin
        RA2_s = InstrD[3:0];
    end
    else begin
        RA2_s = InstrD[15:12];
    end
end


RegisterFile RegisterFile1(
    .CLK(CLK),
    .WE3(RegWriteW),
    .A1(RA1D),
    .A2(RA2D),
    .A3(WA3W),
    .WD3(ResultW),
    .R15(PC_Plus_8),
    .RD1(RD1),
    .RD2(RD2)
);

Extend Extend1(
    .ImmSrc(ImmSrcD),
    .InstrImm(InstrImm),
    .ExtImm(ExtImm)
);

//DtoE

DtoE DtoE1(
    .CLK(CLK),
    .Reset(Reset),
    .RD1(RD1),
    .RD2(RD2),
    .ExtImm(ExtImm),
    .WA3D(WA3D),

    .CondD(CondD),
    .PCSD(PCSD),
    .RegWD(RegWD),
    .MemD(MemD),
    .FlagWD(FlagWD),
    .ALUControlD(ALUControlD),
    .MemtoRegD(MemtoRegD),
    .ALUSrcD(ALUSrcD),
    .ImmSrcD(ImmSrcD),
    .RegSrcD(RegSrcD),
    .NoWriteD(NoWriteD),
    .RA1D(RA1D),
    .RA2D(RA2D),
    .FlushE(FlushE),
//output
    .SrcAE(SrcAE_s),
    .WriteDataE(WriteDataE_s),
    .ExtImmE(ExtImmE),
    .WA3E(WA3E),

    .CondE(CondE),
    .PCSE(PCSE),
    .RegWE(RegWE),
    .MemE(MemE),
    .FlagWE(FlagWE),
    .ALUControlE(ALUControlE),
    .MemtoRegE(MemtoRegE),
    .ALUSrcE(ALUSrcE),
    .ImmSrcE(ImmSrcE),
    .RegSrcE(RegSrcE),
    .NoWriteE(NoWriteE),
    .RA1E(RA1E),
    .RA2E(RA2E)
);

//SrcAE前的数据选择器
 assign SrcAE = (ForwardAE[1]) ? ALUOutM : ((ForwardAE[0]) ? ResultW : SrcAE_s);
    // case (ForwardAE)
    //     2'b00:assign SrcAE = SrcAE_s;
    //     2'b01:assign SrcAE = ResultW;
    //     2'b10:assign SrcAE = ALUOutM;
    // endcase
   
   
    
//WriteDataE前的数据选择器
 assign WriteDataE = (ForwardBE[1]) ? ALUOutM : ((ForwardAE[0]) ? ResultW : WriteDataE_s);
    // case (ForwardBE)
    //     2'b00:assign WriteDataE = WriteDataE_s;
    //     2'b01:assign WriteDataE = ResultW;
    //     2'b10:assign WriteDataE = ALUOutM;
    // endcase

//Hazaerd Unit

HazardUnit HazardUnit1(
    .RegWriteW(RegWriteW),
    .WA3W(WA3W),
    .RegWriteM(RegWriteM),
    .WA3M(WA3M),
    .RA1E(RA1E),
    .RA2E(RA2E),
    .RA2M(RA2M),
    .MemWriteM(MemWriteM),
    .MemtoRegW(MemtoRegW),
    .RA1D(RA1D),
    .RA2D(RA2D),
    .WA3E(WA3E),
    .MemtoRegE(MemtoRegE),
    .RegWriteE(RegWriteE),
    .PCSrcE(PCSrcE),

    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE),
    .ForwardM(ForwardM),
    .FlushE(FlushE),
    .StallD(StallD),
    .StallF(StallF),
    .FlushD(FlushD)
); 

//Execute part

ALU ALU1(
    .Src_A(SrcAE),
    .Src_B(SrcBE),
    .ALUControl(ALUControlE),
    .ALUResult(ALUResultE),
    .ALUFlags(ALUFlags)
);

CondUnit CondUnit1(
    .CLK(CLK),
    .PCSE(PCSE),
    .RegWE(RegWE),
    .MemWE(MemWE),
    .FlagWE(FlagWE),
    .CondE(CondE),
    .ALUFlags(ALUFlags),

    .PCSrcE(PCSrcE),
    .RegWriteE(RegWriteE),
    .MemWriteE(MemWriteE)
);

//EtoM

EtoM EtoM1(
    .CLK(CLK),
    .Reset(Reset),
    .ALUResultE(ALUResultE),
    .WriteDataE(WriteDataE),
    .WA3E(WA3E),

    //.PCSrcE(PCSrcE),
    .RegWriteE(RegWriteE),
    .MemWriteE(MemWriteE),
    .MemtoRegE(MemtoRegE),
    .RA2E(RA2E),

    .ALUOutM(ALUOutM),
    .WA3M(WA3M),
    .WriteDataM(WriteDataM),

    //.PCSrcM(PCSrcM),
    .RegWriteM(RegWriteM),
    .MemWriteM(MemWriteM),
    .MemtoRegM(MemtoRegM),
    .RA2M(RA2M)

);

//MtoW

MtoW MtoW1(
    .CLK(CLK),
    .Reset(Reset),
    .RDM(ReadData),///此处要注意，readdata是arm的输出，RDM是datamemory的输出
    .ALUOutM(ALUOutM),
    .WA3M(WA3M),

    //.PCSrcM(PCSrcM),
    .RegWriteM(RegWriteM),
    .MemtoRegM(MemtoRegM),

    .ReadDataW(ReadDataW),
    .ALUOutW(ALUOutW),
    .WA3W(WA3W),

    //.PCSrcW(PCSrcW),
    .RegWriteW(RegWriteW),
    .MemtoRegW(MemtoRegW)

);

// wire [4:0]Shamt5 = Instr[11:7];
// wire [1:0]Sh = Instr[6:5];
// Shifter Shifter1(
//     .Sh(Sh),
//     .Shamt5(Shamt5),
//     .ShIn(RD2),
//     .ShOut(ShOut)
// );







endmodule