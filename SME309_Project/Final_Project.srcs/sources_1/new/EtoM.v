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
module EtoM(
    input CLK,
    input Reset,
    input [31:0]ALUResultE,
    // input [31:0]WriteDataE,
    input [31:0] ShOut,
    input [3:0] WA3E,
    //input PCSrcE,
    input RegWriteE,
    input MemWriteE,
    input MemtoRegE,
    input [3:0]RA2E,
    input stallM,

    output reg [31:0] ALUOutM,//注意此处的ALUOutM其实就是A，二者已连起故用后者名称
    output reg [3:0] WA3M,
    output reg [31:0] WriteDataM,
    //output reg PCSrcM,
    output reg RegWriteM,
    output reg MemWriteM,
    output reg MemtoRegM,
    output reg [3:0] RA2M
    );
always @(posedge CLK or posedge Reset) begin
    if (Reset) begin
       ALUOutM <= 0;
       WA3M <= 0;
       WriteDataM <=0;
       
        //PCSrcM <= 0;
        RegWriteM <= 0;
        MemWriteM <= 0;
        MemtoRegM <= 0;
        RA2M <= 0;

    end
    else if(stallM) begin
        ALUOutM <= ALUOutM;
        WA3M <= WA3M;
        WriteDataM <=WriteDataM;
       
        //PCSrcM <= 0;
        RegWriteM <= RegWriteM;
        MemWriteM <= MemWriteM;
        MemtoRegM <= MemtoRegM;
        RA2M <= RA2M;
    end
    else begin
        ALUOutM <= ALUResultE;
        WA3M <= WA3E;
        WriteDataM <=ShOut;

        //PCSrcM <= PCSrcE;
        RegWriteM <= RegWriteE;
        MemWriteM <= MemWriteE;
        MemtoRegM <= MemtoRegE;
        RA2M <= RA2E;
    end
    
end

endmodule
