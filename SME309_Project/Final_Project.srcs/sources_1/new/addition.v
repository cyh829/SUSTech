`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/28 16:48:17
// Design Name: 
// Module Name: addition
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

//This module add shifted mantissas
module addition(
input [23:0] shifted_mantissa_1,
input [23:0] shifted_mantissa_2,
input [7:0] tmp_new_exponent,
input clk,
input reset,
output reg [24:0] mantissa_sum,
output reg [7:0] add_new_exponent,
output reg done_2=0
);
always @(posedge clk)
begin
    mantissa_sum<=shifted_mantissa_1+shifted_mantissa_2;
    add_new_exponent<=tmp_new_exponent;
    if(mantissa_sum==(shifted_mantissa_1+shifted_mantissa_2))
    begin
        done_2<=1;
    end
end 
endmodule
