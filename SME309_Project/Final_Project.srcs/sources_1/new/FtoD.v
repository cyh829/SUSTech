module FtoD(
    input CLK,
    input Reset,
    input [31:0]InstrF,
    input [31:0]PCPlus4F,
    input StallD,
    input FlushD,
    
    output reg [31:0] InstrD,
    output reg [31:0] PCPlus4D
); 
always @(posedge CLK or posedge Reset) begin
    if (Reset) begin
        InstrD <= 0;
        PCPlus4D <= 0;
    end
    else if(StallD && (!FlushD)) begin//StallD在此处是低位有效
        InstrD <= InstrD;
        PCPlus4D <= PCPlus4D;
    end
    else if(FlushD) begin
        InstrD <= 0;
        PCPlus4D <= 0;
    end
    else begin
        InstrD <= InstrF;
        PCPlus4D <= PCPlus4F;
    end
    
end

endmodule