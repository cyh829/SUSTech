module Extend(
    input [1:0] ImmSrc,
    input [23:0] InstrImm,

    output reg [31:0] ExtImm
    );  
always @( *) begin
    case (ImmSrc)
        2'b00:begin
          ExtImm={24'b0,InstrImm[7:0]};
        end
        2'b01:begin
          ExtImm={20'b0,InstrImm[11:0]};
        end
        2'b10:begin
          ExtImm={InstrImm[23],InstrImm[23],InstrImm[23],InstrImm[23],InstrImm[23],InstrImm[23],InstrImm[23:0],2'b00};
        end
        default :begin
          ExtImm = 0;
        end
    endcase
end
    
endmodule
