module ParityGenerator (
  input [31:0] A, // input 32 bit
  output wire out
);

    assign out = ^A;

endmodule