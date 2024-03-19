module top(
    input   clk   ,
    input   rst   ,
    input   [1:0] sw  ,
    input   [2:0] btn ,
    output  led4_b ,
    output  led4_g ,
    output  led4_r ,
    output  led5_b ,
    output  led5_g ,
    output  led5_r ,
    output  [3:0] led
    );
    
    wire    clk_div ;
    
    LED led_0(
    .clk    (clk_div),
    .rst    (rst),
    .sw     (sw),
    .btn    (btn),
    .led4_b (led4_b),
    .led4_g (led4_g),
    .led4_r (led4_r),
    .led5_b (led5_b),
    .led5_g (led5_g),
    .led5_r (led5_r),
    .led    (led)
    );
    
    divider div_0(
    .clk    (clk),
    .rst    (rst),
    .clk_div    (clk_div)
    );
    
endmodule
