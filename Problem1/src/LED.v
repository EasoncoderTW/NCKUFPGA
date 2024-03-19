
module LED(
    input   clk ,  //2Hz
    input   rst ,
    input   [1:0] sw    ,
    output  reg  led4_b ,
    output  reg  led4_g ,
    output  reg  led4_r
    );
    
    always@(posedge clk or posedge rst)begin
        if(rst) begin
            led4_b <= 1'b0;
            led4_g <= 1'b0;
            led4_r <= 1'b0;
        end
        else begin
            case(sw)
                2'b00:  begin //white
                    led4_b <= 1'b1;
                    led4_g <= 1'b1;
                    led4_r <= 1'b1;
                end
                2'b01:  begin //red
                    led4_b <= 1'b0;
                    led4_g <= 1'b0;
                    led4_r <= 1'b1;
                end
                2'b10:  begin //green
                    led4_b <= 1'b0;
                    led4_g <= 1'b1;
                    led4_r <= 1'b0;
                end
                2'b11:  begin //yellow
                    led4_b <= 1'b0;
                    led4_g <= 1'b1;
                    led4_r <= 1'b1;
                end
            endcase
        end
    end 
    
endmodule
