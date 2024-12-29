`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/28 16:47:27
// Design Name: 
// Module Name: compandshift
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//This module Compares Exponent of both inputs and shifts mantissa to make exponent equal.
module compandshift(

input [23:0] cas_mantissa_1,
input [23:0] cas_mantissa_2,
input [7:0] cas_exponent_1, 
input [7:0]cas_exponent_2,
input clk,
input reset,
output reg [23:0] cas_shifted_mantissa_1,
output reg [23:0] cas_shifted_mantissa_2,
output reg [7:0] cas_new_exponent,
output reg done_1=0
);
reg [7:0] diff; 

always @(posedge clk)
begin
    if(cas_exponent_1 == cas_exponent_2)
    begin
        cas_shifted_mantissa_1<=cas_mantissa_1;
        cas_shifted_mantissa_2<=cas_mantissa_2;
        cas_new_exponent<=cas_exponent_1+1'b1;
        done_1<=1;
    end
    else if(cas_exponent_1>cas_exponent_2)
    begin
        diff=cas_exponent_1-cas_exponent_2;
        cas_shifted_mantissa_1<=cas_mantissa_1;
        cas_shifted_mantissa_2<=(cas_mantissa_2>>diff);
        cas_new_exponent<=cas_exponent_1+1'b1;
        done_1<=1;
    end
    else if(cas_exponent_2>cas_exponent_1)
    begin
        diff=cas_exponent_2-cas_exponent_1;
        cas_shifted_mantissa_2<=cas_mantissa_2;
        cas_shifted_mantissa_1<=(cas_mantissa_1>>diff);
        cas_new_exponent<=cas_exponent_2+1'b1;
        done_1<=1;
    end
end
endmodule
//=============================================================================================================================================================================================

