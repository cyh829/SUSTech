`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/12 21:47:56
// Design Name: 
// Module Name: HazardUnit
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


module HazardUnit(
    input RegWriteW,
    input [3:0]WA3W,
    input RegWriteM,
    input [3:0]WA3M,
    input [3:0]RA1E,
    input [3:0]RA2E,
    input [3:0]RA2M,
    input MemWriteM,
    input MemtoRegW,
    //stalling function
    input [3:0]RA1D,
    input [3:0]RA2D,
    input [3:0]WA3E,
    input MemtoRegE,
    input RegWriteE,//此处图中没有，但是给出的信号定义有？�?
    input PCSrcE,
    input FneedstallE,
    input CacheBusy,

    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE,
    output ForwardM,
    //stalling function
    output  FlushE,
    output  StallD,
    output  StallF,
    output  FlushD,
    output  StallE,
    output  stallM,
    output  stallW
    );

wire Match_1E_M,Match_2E_M,Match_1E_W,Match_2E_W;
assign Match_1E_M = (RA1E == WA3M);
assign Match_2E_M = (RA2E == WA3M);
assign Match_1E_W = (RA1E == WA3W);
assign Match_2E_W = (RA2E == WA3W);
assign ForwardM = (RA2M == WA3W)&MemWriteM&MemtoRegW&RegWriteW;
//stalling function
assign Match_12D_E = (RA1D == WA3E)||(RA2D == WA3E);
assign ldrstall = Match_12D_E & MemtoRegE & RegWriteE;
assign StallF = ldrstall || FneedstallE || CacheBusy;
assign StallD = ldrstall || FneedstallE || CacheBusy;
// assign FlushE = ldrstall || PCSrcE|| FneedstallE;
assign FlushE = ldrstall || PCSrcE;
assign StallE = FneedstallE || CacheBusy;
assign stallM = FneedstallE || CacheBusy;
assign stallW = FneedstallE || CacheBusy;
// assign StallE = 0;
// assign stallM = 0;
// assign stallW = 0;
//Flush function
assign FlushD = PCSrcE;
//assign FlushE = PCSrcE; 与上面stall function同等定义用或合并�?
always @( *) begin//ForwardAE 的判�?
        if(Match_1E_M & RegWriteM) begin
            ForwardAE = 2'b10;
        end
        else if (Match_1E_W & RegWriteW) begin
            ForwardAE = 2'b01;
        end
        else begin
            ForwardAE = 2'b00;
        end
    end

always @( *) begin//ForwardBE的判�?
        if(Match_2E_M & RegWriteM) begin
            ForwardBE = 2'b10;
        end
        else if (Match_2E_W & RegWriteW) begin
            ForwardBE = 2'b01;
        end
        else begin
            ForwardBE = 2'b00;
        end
    end
endmodule
