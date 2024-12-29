module Shifter(
    input [1:0] Sh,
    input [4:0] Shamt5,
    input [31:0] ShIn,
    
    output [31:0] ShOut
    );
    reg [31:0]ShOutLSL;
    reg [31:0]ShOutLSR;
    reg [31:0]ShOutASR;
    reg [31:0]ShOutROR;
    reg [31:0]ShOut_s;
    reg [31:0]ShOutA;
    reg [31:0]ShOutB;
    reg [31:0]ShOutC;
    reg [31:0]ShOutD;
    assign ShOut = ShOut_s;

always @(*) begin
   case (Sh)
   //LSL
   2'b00:begin
    if(Shamt5[4])begin
        ShOutA = {ShIn[15:0],16'b0};
    end
    else begin
        ShOutA = ShIn;
    end

    if(Shamt5[3])begin
        ShOutB = {ShOutA[23:0],8'b0};
    end
    else begin
        ShOutB = ShOutA;
    end

    if(Shamt5[2])begin
        ShOutC = {ShOutB[27:0],4'b0};
    end
    else begin
        ShOutC = ShOutB;
    end

    if(Shamt5[1])begin
        ShOutD = {ShOutC[29:0],2'b0};
    end
    else begin
        ShOutD = ShOutC;
    end

    if(Shamt5[0])begin
        ShOutLSL = {ShOutD[30:0],1'b0};
    end
    else begin
        ShOutLSL = ShOutD;
    end
       ShOut_s = ShOutLSL;
   end
   //LSR
   2'b01:begin
    if(Shamt5[4])begin
        ShOutA = {16'b0,ShIn[31:16]};
    end
    else begin
        ShOutA = ShIn;
    end

    if(Shamt5[3])begin
        ShOutB = {8'b0,ShOutA[31:8]};
    end
    else begin
        ShOutB = ShOutA;
    end

    if(Shamt5[2])begin
        ShOutC = {4'b0,ShOutB[31:4]};
    end
    else begin
        ShOutC = ShOutB;
    end

    if(Shamt5[1])begin
        ShOutD = {2'b0,ShOutC[31:2]};
    end
    else begin
        ShOutD = ShOutC;
    end

    if(Shamt5[0])begin
        ShOutLSR = {1'b0,ShOutD[31:1]};
    end
    else begin
        ShOutLSR = ShOutD;
    end
       ShOut_s = ShOutLSR;
   end
   //ASR
   2'b10:begin
    if (!ShIn[31]) begin//若第一位是0
        if(Shamt5[4])begin
            ShOutA = {16'b0,ShIn[31:16]};
        end
        else begin
            ShOutA = ShIn;
        end

        if(Shamt5[3])begin
            ShOutB = {8'b0,ShOutA[31:8]};
        end
        else begin
            ShOutB = ShOutA;
        end

        if(Shamt5[2])begin
            ShOutC = {4'b0,ShOutB[31:4]};
        end
        else begin
            ShOutC = ShOutB;
        end

        if(Shamt5[1])begin
            ShOutD = {2'b0,ShOutC[31:2]};
        end
        else begin
            ShOutD = ShOutC;
        end

        if(Shamt5[0])begin
            ShOutASR = {1'b0,ShOutD[31:1]};
        end
        else begin
            ShOutASR = ShOutD;
        end
    end
    else begin
         if(Shamt5[4])begin
            ShOutA = {16'b1111111111111111,ShIn[31:16]};
        end
        else begin
            ShOutA = ShIn;
        end

        if(Shamt5[3])begin
            ShOutB = {8'b11111111,ShOutA[31:8]};
        end
        else begin
            ShOutB = ShOutA;
        end

        if(Shamt5[2])begin
            ShOutC = {4'b1111,ShOutB[31:4]};
        end
        else begin
            ShOutC = ShOutB;
        end

        if(Shamt5[1])begin
            ShOutD = {2'b11,ShOutC[31:2]};
        end
        else begin
            ShOutD = ShOutC;
        end

        if(Shamt5[0])begin
            ShOutASR = {1'b1,ShOutD[31:1]};
        end
        else begin
            ShOutASR = ShOutD;
        end
    end
       ShOut_s = ShOutASR;
   end
   //ROR
   2'b11:begin
    if(Shamt5[4])begin
        ShOutA = {ShIn[15:0],ShIn[31:16]};
    end
    else begin
        ShOutA = ShIn;
    end

    if(Shamt5[3])begin
        ShOutB = {ShOutA[7:0],ShOutA[31:8]};
    end
    else begin
        ShOutB = ShOutA;
    end

    if(Shamt5[2])begin
        ShOutC = {ShOutB[3:0],ShOutB[31:4]};
    end
    else begin
        ShOutC = ShOutB;
    end

    if(Shamt5[1])begin
        ShOutD = {ShOutC[1:0],ShOutC[31:2]};
    end
    else begin
        ShOutD = ShOutC;
    end

    if(Shamt5[0])begin
        ShOutROR = {ShOutD[0],ShOutD[31:1]};
    end
    else begin
        ShOutROR = ShOutD;
    end
       ShOut_s = ShOutROR;
   end
   default :ShOut_s = 32'b0;
            
   endcase
end

     
endmodule 
