 module ProgramCounter(
     input CLK,
     input Reset,
     input PCSrc,
     input [31:0] Result,
    
     output reg [31:0] PC,
     output [31:0] PC_Plus_4
 ); 
 wire [31:0] next_PC;
 reg [31:0]current_PC;
 //fill your Verilog code here
 assign next_PC = PCSrc == 0? PC_Plus_4:Result;
 assign PC_Plus_4 = current_PC+32'd4;
 always @(posedge CLK) begin
         current_PC<=next_PC;
         PC <= next_PC;
 end
 always @(*)begin
     if(Reset)begin
         current_PC <=0;
         PC <= 0;
     end
 end
 endmodule


// endmodule
//`timescale 1ns / 1ps

//module ProgramCounter(
//    input CLK,
//    input Reset,
//    input PCSrc,
//    input [31:0] result,
    
//    output reg [31:0] PC,
//    output [31:0] PC_Plus_4
//); 
//    reg [31:0] next_PC;
//    assign PC_Plus_4 = PC + 4'b100;
//    always@(*)begin
//        if(PCSrc)begin
//            next_PC = result;
//        end
//        else begin
//            next_PC = PC_Plus_4;
//        end    
//    end
////    assign next_PC = PCSrc ? result : PC_Plus_4;
    
//    always@(posedge CLK or posedge Reset)begin
//        if(Reset)begin
//            PC = 32'b0;
//        end
//        else begin
//            PC = next_PC;
//        end
//    end



//endmodule