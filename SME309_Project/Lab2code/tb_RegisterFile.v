`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/02 14:46:52
// Design Name: 
// Module Name: tb_RegisterFile
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


module tb_RegisterFile;
    reg CLK;
    reg WE3;
    reg [3:0] A1;
    reg [3:0] A2;
    reg [3:0] A3;
    reg [31:0] WD3;
    reg [31:0] R15;
    
    wire [31:0] RD1;
    wire [31:0] RD2;

    // Instantiate the RegisterFile module
    RegisterFile uut (
        .CLK(CLK),
        .WE3(WE3),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .R15(R15),
        .RD1(RD1),
        .RD2(RD2)
    );

    // Initialize signals
    initial begin
        CLK = 0;
        WE3 = 0;
        A1 = 0;
        A2 = 0;
        A3 = 0;
        WD3 = 0;
        R15 = 0;

        // Test case 1: Write to Register 0, Read from Register 1
        WE3 = 1;
        A3 = 0;
        WD3 = 32'h12345678;
        #10;
        WE3 = 0;
        A1 = 1;
        #10;

        // Test case 2: Write to Register 2, Read from Register 3
        WE3 = 1;
        A3 = 2;
        WD3 = 32'hABCDEF01;
        #10;
        WE3 = 0;
        A1 = 3;
        #10;

        // Test case 3: Read from R15
        A1 = 15;
        A2 = 15;
        #10;

        // End simulation
        $finish;
    end

    // Clock generation
    always begin
        #5 CLK = ~CLK;
    end

endmodule

