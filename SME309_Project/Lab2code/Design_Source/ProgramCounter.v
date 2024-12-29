module ProgramCounter(
    input CLK,
    input Reset,
    input PCSrc,
    input [31:0] Result,
    input StallF,
    
    output reg [31:0] PCF,
    output [31:0] PC_Plus_4
); 
wire [31:0] next_PC;
reg [31:0]current_PC;
//fill your Verilog code here
assign next_PC = PCSrc == 0? PC_Plus_4:Result;
assign PC_Plus_4 = current_PC+32'd4;
always @(posedge CLK or posedge Reset) begin
    if (Reset)begin
        current_PC <=0;
         PCF <= 0;
    end
    else if(!StallF) begin
        current_PC <= current_PC;
        PCF <= PCF;
    end
    else begin
        current_PC<=next_PC;
        PCF <= next_PC;
     end
end
endmodule