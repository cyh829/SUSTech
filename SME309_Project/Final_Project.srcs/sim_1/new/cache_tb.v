module cache_tb;
reg RESET,CLK,MemWrite,MemRead,MenReady,UpdateReady;
reg [31:0] ALUResult;
reg [31:0] WriteData;
reg [31:0] MenData;
wire [31:0] ReadData;
wire [31:0] LoadMemAddress;
wire [31:0] DataToMen;
wire [31:0] DataToMenAddress;
wire LoadMen;
wire UpdateMem;
wire busy;
cache cache1(
            .CLK(CLK),
            .RESET(RESET),
            .MemWrite(MemWrite),
            .MemRead(MemRead),
            .MenReady(MenReady),
            .UpdateReady(UpdateReady),
            .ALUResult(ALUResult),
            .WriteData(WriteData),
            .MenData(MenData),
            .ReadData(ReadData),
            .LoadMemAddress(LoadMemAddress),
            .DataToMen(DataToMen),
            .DataToMenAddress(DataToMenAddress),
            .LoadMen(LoadMen),
            .UpdateMem(UpdateMem),
            .busy(busy)
            );
always #5 CLK = ~CLK;
initial begin
  CLK = 0;
  RESET = 0;
  MemWrite = 0;
  MemRead = 0;
  MenReady = 0;
  UpdateReady = 0;
  ALUResult = 32'b1;
  WriteData = 32'b10;
  MenData = 32'b11;
  #10
  RESET = 1;
  #10
  RESET = 0;
  #10
  MemRead = 1;
  MenReady = 1;
  UpdateReady = 1;
  #75
  MemRead = 0;
  MemWrite = 1;
  #20
  ALUResult = 32'h10000001;
  WriteData = 32'b100;
  #70
  ALUResult = 32'h11000001;
  WriteData = 32'b100;  
  #70
  ALUResult = 32'h11100001;
  WriteData = 32'b100;
  #70
  ALUResult = 32'h11110001;
  WriteData = 32'b1000;  
  #85
  MemWrite = 0;
  #8000
  $finish;
end

endmodule
