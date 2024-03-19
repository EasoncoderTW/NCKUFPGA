module top(
    input   clk   ,
    input   rst   ,
    input   [1:0] sw  ,
    output  led4_b ,
    output  led4_g ,
    output  led4_r
    );
    
    wire    clk_div ;
    
    LED led_0(
    .clk    (clk_div),
    .rst    (rst),
    .sw     (sw),
    .led4_b (led4_b),
    .led4_g (led4_g),
    .led4_r (led4_r)
    );
    
    divider div_0(
    .clk    (clk),
    .rst    (rst),
    .clk_div    (clk_div)
    );
    
endmodule
