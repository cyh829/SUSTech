`timescale 1ns / 1ps
module Decoder(
    input [31:0] Instr,
	
    output PCS,
    output RegW, 
    output MemW, 
    output MemtoReg,
    output ALUSrc,
    output [1:0] ImmSrc,
    output [1:0] RegSrc,
    output reg [1:0] ALUControl,
    output reg [1:0] FlagW, 
    output reg NoWrite
    );
    
    
    wire [1:0]ALUOp ;    
    wire Branch ;
    reg [1:0]R_ALUOp ;   
    reg R_Branch ;
    reg R_RegW; 
    reg R_MemW; 
    reg R_MemtoReg;
    reg R_ALUSrc;
    reg [1:0] R_ImmSrc;
    reg [1:0] R_RegSrc;
    
    always@(*) begin
    
    case (Instr[27:26])
        2'b00: begin
            if(Instr[25]==0) begin
                R_Branch = 0;
                R_MemtoReg = 0;
                R_MemW = 0;
                R_ALUSrc = 0;
                R_ImmSrc = 2'bxx;  
                R_RegW = 1;
                R_RegSrc = 2'b00;
                R_ALUOp = 2'b11;
            end
            else begin
                R_Branch = 0;
                R_MemtoReg = 0;
                R_MemW = 0;
                R_ALUSrc = 1;
                R_ImmSrc = 2'b00;
                R_RegW = 1;
                R_RegSrc = 2'bx0; 
                R_ALUOp = 2'b11;
             end
        end
        2'b01: begin
             if(Instr[20]==0) begin
                R_Branch = 0;
                R_MemtoReg = 1'bx;
                R_MemW = 1;
                R_ALUSrc = 1;
                R_ImmSrc = 2'b01;
                R_RegW = 0;
                R_RegSrc = 2'b10;
                if(Instr[23]==1)  
                    R_ALUOp = 2'b00;   
                else
                    R_ALUOp = 2'b01;
             end
             else begin
                R_Branch = 0;
                R_MemtoReg = 1;
                R_MemW = 0;
                R_ALUSrc = 1;
                R_ImmSrc = 2'b01;
                R_RegW = 1;
                R_RegSrc = 2'bx0;
                if(Instr[23]==1) 
                    R_ALUOp = 2'b00;
                else
                    R_ALUOp = 2'b01;      
             end
        end
        2'b10:begin
            R_Branch = 1;
            R_MemtoReg = 0;
            R_MemW = 0;
            R_ALUSrc = 1;
            R_ImmSrc = 2'b10;
            R_RegW = 0;
            R_RegSrc = 2'bx1;
            R_ALUOp = 2'b10;   
        end

    endcase
       
    end
    
    assign Branch = R_Branch;
    assign MemtoReg = R_MemtoReg;
    assign MemW = R_MemW;
    assign ALUSrc = R_ALUSrc;
    assign ImmSrc = R_ImmSrc;
    assign RegW = R_RegW;
    assign RegSrc = R_RegSrc;
    assign ALUOp =R_ALUOp;    
    
    always @( *) begin
            if (ALUOp==2'b00) begin
                ALUControl <= 2'b00;//STR LDR设成0
            end
            else if(ALUOp==2'b01) begin
                ALUControl <= 2'b01;
            end
            else if(ALUOp==2'b10) begin
                ALUControl <= 2'b00;//Branch设成0
            end
            else if(ALUOp==2'b11) begin
                case (Instr[24:21])
                    4'b0100: ALUControl <= 2'b0;//ALU00是+，01是-，10是AND，11是OR
                    4'b0010: ALUControl <= 2'b01;
                    4'b0000: ALUControl <= 2'b10;
                    4'b1100: ALUControl <= 2'b11;
                    4'b1010: ALUControl <= 2'b01;
                    4'b1011: ALUControl <= 2'b00;
                endcase
            end
        end    
    
    always @( *) begin
            if (ALUOp==2'b0 || ALUOp==2'b01 || ALUOp==2'b10) begin
                FlagW <= 2'b0;
            end
            else if(ALUOp==2'b11) begin
                if (Instr[20]==0) begin
                    FlagW <= 2'b0;
                end
                else begin
                    case (Instr[24:21])
                    4'b0100: FlagW <= 2'b11;
                    4'b0010: FlagW <= 2'b11;
                    4'b0000: FlagW <= 2'b10;
                    4'b1100: FlagW <= 2'b10;
                    4'b1010: FlagW <= 2'b11;
                    4'b1011: FlagW <= 2'b11; 
                    endcase
                end
            end
        end
        
    
    always @( *) begin
            NoWrite <= 0;
            if(ALUOp == 2'b11) begin
            case (Instr[24:21])
                4'b1010: NoWrite <= 1;
                4'b1011: NoWrite <= 1;
            endcase
            end
        end
    
    assign PCS = ((Instr[15:12]==4'b1111 & RegW) | Branch)? 1:0;
    
endmodule
