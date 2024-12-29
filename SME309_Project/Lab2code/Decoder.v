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

    reg RegW_s;
    reg MemW_s;
    reg MemtoReg_s;
    reg ALUSrc_s;
    reg [1:0] ImmSrc_s;
    reg [1:0] RegSrc_S;
    reg [1:0] ALUOp_s;
    reg Branch_s;
    assign Branch = Branch_s;

    assign ALUOp = ALUOp_s;
    assign Branch = Branch_s;
    assign RegW = RegW_s;
    assign MemW= MemW_s;
    assign MemtoReg = MemtoReg_s;
    assign ALUSrc = ALUSrc_s;
    assign ImmSrc = ImmSrc_s;
    assign RegSrc = RegSrc_S;

    wire [3:0]Rd = Instr[15:12];
    wire [1:0]Op = Instr[27:26];
    wire [5:0]Funct = Instr[25:20];

    //PC Logic
    assign PCS = ((Rd == 4'b1111)&RegW | Branch)? 1: 0;
    //Main Decoder
    always @(*) begin
        case (Op)
        2'b00:begin
          if (!Funct[5]) begin
            Branch_s = 0;
            MemtoReg_s = 0;
            MemW_s = 0;
            ALUSrc_s = 0;
            ImmSrc_s = 2'bxx;
            RegW_s = 1;
            RegSrc_S = 2'b00;
            ALUOp_s = 2'b11;
          end
          else begin
            Branch_s = 0;
            MemtoReg_s = 0;
            MemW_s = 0;
            ALUSrc_s = 1;
            ImmSrc_s = 2'b00;
            RegW_s = 1;
            RegSrc_S = 2'bx0;
            ALUOp_s = 2'b11;
          end
        end
        2'b01:begin
          if (!Funct[0]) begin//str
            Branch_s = 0;
            MemtoReg_s = 1'bx;
            MemW_s = 1;
            ALUSrc_s = 1;
            ImmSrc_s = 2'b01;
            RegW_s = 0;
            RegSrc_S = 2'b10;
            if (!Funct[3]) begin
              ALUOp_s = 2'b10;// str pos imm
            end
            else begin
              ALUOp_s = 2'b01;//str neg imm
            end
          end
          else begin//ldr
            Branch_s = 0;
            MemtoReg_s = 1;
            MemW_s = 0;
            ALUSrc_s = 1;
            ImmSrc_s = 2'b01;
            RegW_s = 1;
            RegSrc_S = 2'bx0;
            if (!Funct[3]) begin
              ALUOp_s = 2'b10;//ldr pos imm
            end
            else begin
              ALUOp_s = 2'b01;//ldr neg imm
            end
          end
        end
        2'b10:begin
            Branch_s = 1;
            MemtoReg_s = 0;
            MemW_s = 0;
            ALUSrc_s = 1;
            ImmSrc_s = 2'b10;
            RegW_s = 0;
            RegSrc_S = 2'bx1;
            ALUOp_s = 2'b00;
        end 
        endcase
    end
    //ALU_OP
    //UΪ0-add,UΪ1--sub
    //00 branch
    //10 memory add
    //01 memory sub
    //11 data processing

    //ALU Decoder
    always @(*) begin
        if (ALUOp==2'b00) begin
            ALUControl = 2'b00;
            FlagW = 2'b00;
        end
        else if(ALUOp==2'b01) begin
            ALUControl = 2'b01;
            FlagW = 2'b00;
        end
        else if(ALUOp==2'b10) begin
            ALUControl = 2'b00;
            FlagW = 2'b00;
        end
        else if(ALUOp==2'b11) begin
            case (Funct[4:1])
               4'b0100: begin
                 if(!Funct[0])begin
                   ALUControl=2'b00;
                   FlagW =2'b00;
                 end
                 else if(Funct[0]) begin
                   ALUControl=2'b00;
                   FlagW =2'b11;
                 end
               end 
               4'b0010:begin
                 if(!Funct[0])begin
                   ALUControl=2'b01;
                   FlagW =2'b00;
                 end
                 else if(Funct[0]) begin
                   ALUControl=2'b01;
                   FlagW =2'b11;
                 end
               end
               4'b0000:begin
                 if(!Funct[0])begin
                   ALUControl=2'b10;
                   FlagW =2'b00;
                    
                 end
                 else if(Funct[0]) begin
                    ALUControl=2'b10;
                    FlagW =2'b10;
                 end
                end
                4'b1100:begin
                   if(!Funct[0])begin
                   ALUControl=2'b11;
                   FlagW =2'b00;
                   
                 end
                 else if(Funct[0]) begin
                   ALUControl=2'b11;
                   FlagW =2'b10;
                  
                 end
               end
               4'b1010:begin//CMP
                if(Funct[0])begin
                  ALUControl = 2'b01;
                  FlagW = 2'b11;
                end
               end
               4'b1011:begin//CMN
                  ALUControl = 2'b00;
                  FlagW = 2'b11;
               end
            endcase
        end
    end
    always @(*) begin
      if (ALUOp==2'b11) begin
        case (Funct[4:1])
          4'b1010:begin
            NoWrite = 1;
          end
          4'b1011:begin
            NoWrite = 1;
          end
        endcase
      end
      else begin
        NoWrite = 0;
      end
    end
   
endmodule