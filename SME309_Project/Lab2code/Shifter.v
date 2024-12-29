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
    reg [31:0]mediate;
    reg [31:0]ShOut_s;
    assign ShOut = ShOut_s;
//LSR
always @(*) begin
    if(Shamt5[4])begin
        mediate = {16'b0,ShIn[31:16]};
    end
    else begin
        mediate = ShIn;
    end

    if(Shamt5[3])begin
        mediate = {8'b0,mediate[31:8]};
    end
    else begin
        mediate = mediate;
    end

    if(Shamt5[2])begin
        mediate = {4'b0,mediate[31:4]};
    end
    else begin
        mediate = mediate;
    end

    if(Shamt5[1])begin
        mediate = {2'b0,mediate[31:2]};
    end
    else begin
        mediate = mediate;
    end

    if(Shamt5[0])begin
        mediate = {1'b0,mediate[31:1]};
    end
    else begin
        mediate = mediate;
    end
    ShOutLSR = mediate;
end
//ASR
always @(*) begin
    if (!ShIn[31]) begin
        if(Shamt5[4])begin
            mediate = {16'b0,ShIn[31:16]};
        end
        else begin
            mediate = ShIn;
        end

        if(Shamt5[3])begin
            mediate = {8'b0,mediate[31:8]};
        end
        else begin
            mediate = mediate;
        end

        if(Shamt5[2])begin
            mediate = {4'b0,mediate[31:4]};
        end
        else begin
            mediate = mediate;
        end

        if(Shamt5[1])begin
            mediate = {2'b0,mediate[31:2]};
        end
        else begin
            mediate = mediate;
        end

        if(Shamt5[0])begin
            mediate = {1'b0,mediate[31:1]};
        end
        else begin
            mediate = mediate;
        end
    end
    else if(ShIn[31]) begin
        if(Shamt5[4])begin
            mediate = {16'hFFFF,ShIn[31:16]};
        end
        else begin
            mediate = ShIn;
        end

        if(Shamt5[3])begin
            mediate = {8'hFF,mediate[31:8]};
        end
        else begin
            mediate = mediate;
        end

        if(Shamt5[2])begin
            mediate = {4'hF,mediate[31:4]};
        end
        else begin
            mediate = mediate;
        end

        if(Shamt5[1])begin
            mediate = {2'b11,mediate[31:2]};
        end
        else begin
            mediate = mediate;
        end

        if(Shamt5[0])begin
            mediate = {1'b1,mediate[31:1]};
        end
        else begin
            mediate = mediate;
        end
    end
    
    ShOutASR = mediate;
end
//ROR
always @( *) begin
    if(Shamt5[4])begin
        mediate = {ShIn[15:0],ShIn[31:16]};
    end
    else begin
        mediate = ShIn;
    end

    if(Shamt5[3])begin
        mediate = {mediate[7:0],mediate[31:8]};
    end
    else begin
        mediate = mediate;
    end

    if(Shamt5[2])begin
        mediate = {mediate[3:0],mediate[31:4]};
    end
    else begin
        mediate = mediate;
    end

    if(Shamt5[1])begin
        mediate = {mediate[1:0],mediate[31:2]};
    end
    else begin
        mediate = mediate;
    end

    if(Shamt5[0])begin
        mediate = {mediate[0],mediate[31:1]};
    end
    else begin
        mediate = mediate;
    end
    ShOutROR = mediate;
end
//LSL
always @(*) begin
    if (Shamt5[4]) begin
        mediate = {ShIn[15:0],16'b0};
    end
    else begin
        mediate = ShIn;
    end
    if (Shamt5[3]) begin
        mediate = {ShIn[23:0],8'b0};
    end
    else begin
        mediate = mediate;
    end
    if (Shamt5[4]) begin
        mediate = {ShIn[27:0],4'b0};
    end
    else begin
        mediate = mediate;
    end
    if (Shamt5[4]) begin
        mediate = {ShIn[29:0],2'b0};
    end
    else begin
        mediate = mediate;
    end
    if (Shamt5[4]) begin
        mediate = {ShIn[30:0],1'b0};
    end
    else begin
        mediate = mediate;
    end
    ShOutLSL = mediate;
end
always @(*) begin
    case (Sh)
    2'b00:begin
        ShOut_s = ShOutLSL;
    end
    2'b01:begin
        ShOut_s = ShOutLSR;
    end
    2'b10:begin
        ShOut_s = ShOutASR;
    end
    2'b11:begin
        ShOut_s = ShOutROR;
    end
    default :ShOut_s = 32'b0;
            
    endcase
end

     
endmodule 
