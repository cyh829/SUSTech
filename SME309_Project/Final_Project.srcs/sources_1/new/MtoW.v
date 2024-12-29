`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/11 10:15:14
// Design Name: 
// Module Name: DtoE
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
module MtoW(
    input CLK,
    input Reset,
    input [31:0]RDM,
    input [31:0]ALUOutM,
    input [3:0] WA3M,
    // input PCSrcM,
    input RegWriteM,
    input MemtoRegM,
    input stallW,

    // output reg PCSrcW,
    output reg RegWriteW,
    output reg MemtoRegW,
    output reg [31:0] ReadDataW,
    output reg [31:0] ALUOutW,
    output reg [3:0] WA3W
    );
always @(posedge CLK or posedge Reset) begin
    if (Reset) begin
       ReadDataW <= 0;
       ALUOutW <= 0;
       WA3W <= 0;

    //    PCSrcW <= 0;
       RegWriteW <= 0;
       MemtoRegW <= 0;
    end
    else if(stallW) begin
       ReadDataW <= ReadDataW;
       ALUOutW <= ALUOutW;
       WA3W <= WA3W;

    //    PCSrcW <= 0;
       RegWriteW <= RegWriteW;
       MemtoRegW <= MemtoRegW;
    end
    else begin
        ReadDataW <= RDM;
        ALUOutW <= ALUOutM;
        WA3W <= WA3M;

    //    PCSrcW <= PCSrcM;
       RegWriteW <= RegWriteM;
       MemtoRegW <= MemtoRegM;
    end
    
end

endmodule
