module ARM(
    input CLK,
    input Reset,
    input [31:0] Instr,
    input [31:0] ReadData,

    output MemWrite,
    output [31:0] PC,
    output [31:0] ALUResult,
    output [31:0] WriteData
); 

wire PCSrc;
wire [31:0] Result;
wire [31:0]PC_Plus_4;
wire MemtoReg;
assign Result =  MemtoReg== 1 ? ReadData:ALUResult;
ProgramCounter ProgramCounter1(
    .CLK(CLK),
    .Reset(Reset),
    .PCSrc(PCSrc),
    .Result(Result),
    .PC(PC),
    .PC_Plus_4(PC_Plus_4)
);
wire [3:0]RA1;
reg [3:0]RA1_s;
assign RA1 = RA1_s;
wire [3:0]RA2;
reg [3:0]RA2_s;
assign RA2 = RA2_s;
wire [31:0]PC_Plus_8;
wire [31:0]Src_A;
wire [31:0]Src_B;
reg [31:0]Src_B_s;
assign Src_B = Src_B_s;
wire [31:0]RD2;
wire RegWrite;
wire [1:0]RegSrc;
always @( *) begin
    if (!RegSrc[0]) begin
        RA1_s = Instr[19:16];
    end
    else begin
        RA1_s = 15;
    end
    if (!RegSrc[1]) begin
        RA2_s = Instr[3:0];
    end
    else begin
        RA2_s = Instr[15:12];
    end
end
assign PC_Plus_8 = PC_Plus_4+4;

RegisterFile RegisterFile1(
    .CLK(CLK),
    .WE3(RegWrite),
    .A1(RA1),
    .A2(RA2),
    .A3(Instr[15:12]),
    .WD3(Result),
    .R15(PC_Plus_8),
    .RD1(Src_A),
    .RD2(RD2)
);
wire [3:0]ALUFlags;
wire ALUSrc;
wire [1:0]ImmSrc;
wire [1:0]ALUControl;

ControlUnit ControlUnit1(
    .Instr(Instr),
    .ALUFlags(ALUFlags),
    .CLK(CLK),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegWrite(RegWrite),
    .RegSrc(RegSrc),
    .ALUControl(ALUControl),
    .PCSrc(PCSrc)
    
);
wire [31:0]ExtImm;
wire [31:0]ShOut;
always @( *) begin
    if (!ALUSrc) begin
        Src_B_s = ShOut;
    end
    else begin
        Src_B_s = ExtImm;
    end
end
ALU ALU1(
    .Src_A(Src_A),
    .Src_B(Src_B),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .ALUFlags(ALUFlags)
);
wire [23:0]InstrImm;
assign InstrImm = Instr[23:0];
Extend Extend1(
    .ImmSrc(ImmSrc),
    .InstrImm(InstrImm),
    .ExtImm(ExtImm)
);
wire [4:0]Shamt5 = Instr[11:7];
wire [1:0]Sh = Instr[6:5];
Shifter Shifter1(
    .Sh(Sh),
    .Shamt5(Shamt5),
    .ShIn(RD2),
    .ShOut(ShOut)
);


endmodule