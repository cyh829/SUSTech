module RegisterFile(
    input CLK,
    input WE3,
    input [3:0] A1,
    input [3:0] A2,
    input [3:0] A3,
    input [31:0] WD3,
    input [31:0] R15,

    output [31:0] RD1,
    output [31:0] RD2
    );
    
    reg [31:0]RD1_s;
    reg [31:0]RD2_s;
    // declare RegBank
    reg [31:0] RegBank[0:14] ;

    always @(posedge CLK) begin
        if (A1!=4'd15) begin
            RD1_s <= RegBank[A1];
        end
        else begin
            RD1_s <= R15;
        end

        if (A2!=4'd15) begin
            RD2_s <= RegBank[A2];
        end
        else begin
            RD2_s <= R15;
        end
        
        if (WE3) begin
            RegBank[A3]<= WD3;
        end
        

    end
 
    
endmodule