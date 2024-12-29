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

//part1 arithmetic operation
    reg [32:0]store;
    assign Sum = store[31:0];
    assign Cout = store[32];
      always @(*) begin
        if (!ALUControl[0]) begin
          store = Src_A+Src_B;
        end
        else
          begin
            store = Src_A + ~Src_B + 1; 
          end
      end

      always @( *) begin
        V = !(Src_A[31]^ALUControl[0]^Src_B[31])&(Src_A[31]^Sum[31])&(!ALUControl[1]);
        C = (!ALUControl[1])&Cout;
        case (ALUControl)
            2'b11:ALUResult_s=Src_A|Src_B;
            2'b10:ALUResult_s=Src_A&Src_B;
            2'b01:ALUResult_s=Sum;
            2'b00:ALUResult_s=Sum;
        endcase
        N = ALUResult[31];
        Z =(ALUResult==0);

    end
endmodule
//     wire [31:0] Sum_intermediate;
//     wire [31:0] Cout_intermediate;

// // ��λ�ӷ�
// genvar i;
// generate
//   for (i = 0; i < 32; i = i + 1) begin
//     FullAdder adder_instance (
//       .A(Src_A[i]),
//       .B(Src_B[i]),
//       .Cin(i == 0 ? ALUControl[0] : Cout_intermediate[i-1]),
//       .Sum(Sum_intermediate[i]),
//       .Cout(Cout_intermediate[i])
//     );
//   end
// endgenerate

// assign Sum = Sum_intermediate;
// assign Cout = Cout_intermediate[31];

// module FullAdder (
//   input A,
//   input B,
//   input Cin,
//   output Sum,
//   output Cout
// );

// assign {Cout, Sum} = A + B + Cin;

// endmodule













