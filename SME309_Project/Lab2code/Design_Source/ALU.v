////module ALU(
////    input [31:0] Src_A,
////    input [31:0] Src_B,
////    input [1:0] ALUControl,

////    output [31:0] ALUResult,
////    output [3:0] ALUFlags
////    );
////    reg V;
////    reg C;
////    reg N;
////    reg Z;
////    assign ALUFlags = {N,Z,C,V};
////    wire Cout;
////    wire [31:0] Sum;
////    reg [31:0]ALUResult_s;
////    assign ALUResult = ALUResult_s;
////    //assign Cout = ALUControl[0]==1?((Src_A&Src_B)|(ALUControl[0]&Src_A));

//////part1 arithmetic operation
////    reg [32:0]store;
////    assign Sum = store[31:0];
////    assign Cout = store[32];
////      always @(*) begin
////        if (ALUControl[0]==0) begin
////          store = Src_A+Src_B;
////        end
////        else
////          begin
////            store = Src_A + ~Src_B + 1; 
////          end
////      end

////      always @( *) begin
////        V = !(Src_A[31]^ALUControl[0]^Src_B[31])&(Src_A[31]^Sum[31])&(!ALUControl[1]);
////        C = (!ALUControl[1]) & Cout;
////        N = ALUResult[31];
////        Z =(ALUResult==0);
////        end
////        always @( *) begin
////         case (ALUControl)
////                   2'b11:ALUResult_s=Src_A|Src_B;
////                   2'b10:ALUResult_s=Src_A&Src_B;
////                   2'b01:ALUResult_s=Sum;
////                   2'b00:ALUResult_s=Sum;
////                   default: ALUResult_s = 0;
////          endcase
////          end
////endmodule

//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 2023/10/26 13:38:58
//// Design Name: 
//// Module Name: ALU
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module ALU(
//    input [31:0] Src_A,
//    input [31:0] Src_B,
//    input [1:0] ALUControl,
//    output [31:0] ALUResult,
//    output [3:0] ALUFlags
//    );
//    reg [31:0] reg_B;
//    reg [32:0] Sum;
//    reg [31:0] Result;
//    always @( *) begin
//        case (ALUControl[0])
//            0: reg_B <= Src_B;
//            1: reg_B <= ~Src_B+1;
//        endcase
//    end
//    always @( *) begin
//        Sum <= reg_B + Src_A;
//    end
//    always @( *) begin
//        case (ALUControl)
//            2'b00,2'b01: Result <= Sum[31:0]; 
//            2'b10: Result <= Src_A & Src_B;
//            2'b11: Result <= Src_A | Src_B;
//        endcase
//    end
//    assign ALUResult = Result;
//    assign ALUFlags[2] = (Result == 0);//更新Z
//    assign ALUFlags[3] = Result[31];//更新N
//    assign ALUFlags[1] = (!ALUControl[1]) & Sum[32];//更新C
//    assign ALUFlags[0] = (!ALUControl[1]) & (Src_A[31] ^ Sum[31]) & ~(Src_A[31] ^ Src_B[31] ^ALUControl[0]);
//endmodule


module ALU(
    input [31:0] Src_A,
    input [31:0] Src_B,
    input [1:0] ALUControl,

    output [31:0] ALUResult,
    output [3:0] ALUFlags
    );
    reg V;
    reg C;
    reg N;
    reg Z;
    assign ALUFlags = {N,Z,C,V};
    wire Cout;
    wire [31:0] Sum;
    reg [31:0]ALUResult_s;
    assign ALUResult = ALUResult_s;
    //assign Cout = ALUControl[0]==1?((Src_A&Src_B)|(ALUControl[0]&Src_A));

//part1 arithmetic operation
    reg [32:0]store;
    assign Sum = store[31:0];
    assign Cout = store[32];
      always @(*) begin
        if (ALUControl[0]==0) begin
          store = Src_A+Src_B;
        end
        else
          begin
            store = Src_A + ~Src_B + 1; 
          end
      end

      always @( *) begin
        V = !(Src_A[31]^ALUControl[0]^Src_B[31])&(Src_A[31]^Sum[31])&(!ALUControl[1]);
        C = (!ALUControl[1]) & Cout;
        N = ALUResult[31];
        Z =(ALUResult==0);
        end
        always @( *) begin
         case (ALUControl)
                   2'b11:ALUResult_s=Src_A|Src_B;
                   2'b10:ALUResult_s=Src_A&Src_B;
                   2'b01:ALUResult_s=Sum;
                   2'b00:ALUResult_s=Sum;
                   default: ALUResult_s = 0;
          endcase
          end
endmodule
