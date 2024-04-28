module Arithmetic (
  input [7:0] A, // input 8 bit
  input [7:0] B, // input 8 bit
  input [1:0] op, // operator 
  output reg [7:0] Out, // output result
  output reg overflow // overflow flag
);

    parameter  Opadd = 2'd0,
               OpSub = 2'd1,
               OpMul = 2'd2;

    wire [15:0] ext_A = {{8{A[7]}},A};
    wire [15:0] ext_B = {{8{B[7]}},B};

    wire [15:0] inv_A = (~ext_A + 16'd1);
    wire [15:0] inv_B = (~ext_B + 16'd1);

    wire [7:0] result_Add = A + B;
    wire [7:0] result_Sub = A + inv_B[7:0];

    wire [15:0] mul_A = (A[7])? inv_A : {A[7],ext_A};
    wire [15:0] mul_B = (B[7])? inv_B : {B[7],ext_B};

    wire [15:0] result_Mul = mul_A * mul_B;
  
    always @(*) begin
        case (op)
            Opadd: Out = result_Add;
            OpSub: Out = result_Sub;
            OpMul: Out = (A[7] ^ B[7])?(~result_Mul[7:0] + 8'd1):result_Mul[7:0];
            default: Out = 8'd0;
        endcase
    end

    always @(*) begin
        case (op)
            Opadd: begin
                overflow = (A[7] == B[7] && B[7] != result_Add[7])? 1'b1: 1'b0;
            end
            OpSub: begin
                overflow = (A[7] != B[7] && B[7] == result_Sub[7])? 1'b1: 1'b0;
            end
            OpMul: begin
                overflow = (result_Mul[15:7] == 9'd0)? 1'b0: 1'b1;
            end
            default: overflow = 1'b0;
        endcase
    end

endmodule
