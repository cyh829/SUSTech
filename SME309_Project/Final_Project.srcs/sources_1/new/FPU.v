`timescale 1ns / 1ps
module FPU(
    input CLK,
    input Reset,
    input [31:0]NumA,
    input [31:0]NumB,
    input StartF,//startF为1说明启用了FPU 单元，指令需要浮点数计算
    input FPUOp,

    output [31:0] Result,
    output Fneedstall
    );
    
    reg[31:0]R_Result;
    wire [31:0] add_result,mul_result;
    // reg R_Fneedstall;
    wire underflow,overflow;
    wire valid;

assign Result = R_Result;
assign Fneedstall = R_Fneedstall && StartF;//乘法组合逻辑不用停，加法时如果不是valid就停;要启用该模块时再看停不停
reg R_Fneedstall=0;
always @(posedge CLK or posedge Reset ) begin
    if (Reset) begin
        R_Result <= 0;
    end
    else begin
        if (FPUOp) begin//mul
            R_Result <= mul_result;
            R_Fneedstall <= 0;
        end
        else begin//add
            if (valid) begin
                R_Result <= add_result;
                R_Fneedstall <= 0;
            end
            else begin//还未算完
                R_Fneedstall <= 1;
            end
        end
    end
end
wire[31:0]operand_1,operand_2,Sum,input_a,input_b,product;
wire clk;
assign operand_1 = NumA;
assign operand_2 = NumB;
assign input_a = NumA;
assign input_b = NumB;
assign clk = CLK;
assign add_result = Sum;
assign mul_result = product;
adder adder1(.operand_1(operand_1),.operand_2(operand_2),.clk(clk),.StartF(StartF),.Sum(Sum),.valid(valid));
multiplier multiplier1(.input_a(input_a), .input_b(input_b), .product(product), .underflow(underflow), .overflow(overflow));
// adder adder1(
//     .operand_1(NumA),
//     .operand_2(NumB),
//     .clk(CLK),
//     .reset(Reset),

//     .Sum(add_result),
//     .valid(valid)
// );

// multiplier multiplier1(
//     .input_a(NumA),
//     .input_b(NumB),

//     .underflow(underflow),
//     .overflow(overflow),
//     .product(mul_result)
    
// );

endmodule
