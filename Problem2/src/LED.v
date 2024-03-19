
module LED(
    input   clk , //2Hz
    input   rst ,
    input   [1:0] sw    ,
    input   [2:0] btn ,
    output  reg led4_b ,
    output  reg led4_g ,
    output  reg led4_r ,
    output  reg led5_b ,
    output  reg led5_g ,
    output  reg led5_r ,
    output  reg [3:0] led
    );

    reg [31:0]counter;
    reg [31:0]g_r_time;
    reg [31:0]y_r_time;
    reg [31:0]r_r_time;
    reg [2:0] state;
    reg [2:0] next_state;
    
    // state machine
    always@(posedge clk or posedge rst)begin
        if(rst) begin
            state <= 3'b0;
            counter <= 32'd9;
        end
        else if(sw == 2'b00) begin
            state <= next_state;
            case(state)
                3'b000:  begin
                    if(counter == 32'd0 || counter == 32'hffffffff) begin
                        counter <= y_r_time - 32'd1;
                    end
                    else begin
                        counter <= counter - 32'd1;
                    end
                end   
                3'b001:  begin
                    if(counter == 32'd0 || counter == 32'hffffffff) begin
                        counter <= r_r_time - 32'd1;
                    end
                    else begin
                        counter <= counter - 32'd1;
                    end
                end
                3'b010:  begin
                    if(counter == 32'd0 || counter == 32'hffffffff) begin
                        counter <= g_r_time - 32'd1;
                    end
                    else begin
                        counter <= counter - 32'd1;
                    end
                end
                3'b011:  begin
                    if(counter == 32'd0 || counter == 32'hffffffff) begin
                        counter <= y_r_time - 32'd1;
                    end
                    else begin
                        counter <= counter - 32'd1;
                    end
                end
                3'b100:  begin
                    if(counter == 32'd0 || counter == 32'hffffffff) begin
                        counter <= r_r_time - 32'd1;
                    end
                    else begin
                        counter <= counter - 32'd1;
                    end
                end
                3'b101:  begin
                    if(counter == 32'd0 || counter == 32'hffffffff) begin
                        counter <= g_r_time - 32'd1;
                    end
                    else begin
                        counter <= counter - 32'd1;
                    end
                end
            endcase
        end
        else begin
            state <= 3'b00;
            counter <= g_r_time - 32'd1;
        end
    end
    always@(*)begin
        if(rst) begin
            next_state = 3'b000;
        end
        else if(sw == 2'b00) begin
            case(state)
                3'b000:  begin
                    if(counter == 32'd0 || counter == 32'hffffffff) begin
                        next_state = 3'b001;
                    end
                    else begin
                        next_state = 3'b000;
                    end
                end   
                3'b001:  begin
                    if(counter == 32'd0 || counter == 32'hffffffff) begin
                        next_state = 3'b010;
                    end
                    else begin
                        next_state = 3'b001;
                    end
                end
                3'b010:  begin
                    if(counter == 32'd0 || counter == 32'hffffffff) begin
                        next_state = 3'b011;
                    end
                    else begin
                        next_state = 3'b010;
                    end
                end
                3'b011:  begin
                    if(counter == 32'd0 || counter == 32'hffffffff) begin
                        next_state = 3'b100;
                    end
                    else begin
                        next_state = 3'b011;
                    end
                end
                3'b100:  begin
                    if(counter == 32'd0 || counter == 32'hffffffff) begin
                        next_state = 3'b101;
                    end
                    else begin
                        next_state = 3'b100;
                    end
                end
                3'b101:  begin
                    if(counter == 32'd0 || counter == 32'hffffffff) begin
                        next_state = 3'b000;
                    end
                    else begin
                        next_state = 3'b101;
                    end
                end
            endcase
        end
        else begin
            next_state = 3'b00;
        end
    end

    // btn
    always@(posedge clk or posedge rst)begin
        if(rst) begin
            g_r_time <= 32'd10;
            y_r_time <= 32'd2;
            r_r_time <= 32'd4;
        end
        else if(sw == 2'b01) begin
            if(btn[0] == 1'b1) begin
                g_r_time <= 32'd10;
            end
            else if(btn[1] == 1'b1) begin
                g_r_time <= g_r_time + 32'd2;
            end
            else if(btn[2] == 1'b1) begin
                g_r_time <= g_r_time - 32'd2;
            end
        end
        else if(sw == 2'b10) begin
            if(btn[0] == 1'b1) begin
                y_r_time <= 32'd2;
            end
            else if(btn[1] == 1'b1) begin
                y_r_time <= y_r_time + 32'd2;
            end
            else if(btn[2] == 1'b1) begin
                y_r_time <= y_r_time - 32'd2;
            end
        end
        else if(sw == 2'b11) begin
            if(btn[0] == 1'b1) begin
                r_r_time <= 32'd4;
            end
            else if(btn[1] == 1'b1) begin
                r_r_time <= r_r_time + 32'd2;
            end
            else if(btn[2] == 1'b1) begin
                r_r_time <= r_r_time - 32'd2;
            end
        end
        else begin
            g_r_time <= g_r_time;
            y_r_time <= y_r_time;
            r_r_time <= r_r_time;
        end
    end

    // LED
    always@(posedge clk or posedge rst)begin
        if(rst) begin
            led4_b <= 1'b0;
            led4_g <= 1'b0;
            led4_r <= 1'b0;
            led5_b <= 1'b0;
            led5_g <= 1'b0;
            led5_r <= 1'b0;
            led <= 4'b0000;
        end
        else begin
            case(sw)
                2'b00:  begin //white
                    led <= counter[4:1] + 4'b0001;
                    case(state)
                        3'b000:  begin
                            led4_b <= 1'b0;
                            led4_g <= 1'b1;
                            led4_r <= 1'b0;
                            led5_b <= 1'b0;
                            led5_g <= 1'b0;
                            led5_r <= 1'b1;
                        end
                        3'b001:  begin
                            led4_b <= 1'b0;
                            led4_g <= 1'b1;
                            led4_r <= 1'b1;
                            led5_b <= 1'b0;
                            led5_g <= 1'b0;
                            led5_r <= 1'b1;
                        end
                        3'b010:  begin
                            led4_b <= 1'b0;
                            led4_g <= 1'b0;
                            led4_r <= 1'b1;
                            led5_b <= 1'b0;
                            led5_g <= 1'b0;
                            led5_r <= 1'b1;
                        end
                        3'b011:  begin
                            led4_b <= 1'b0;
                            led4_g <= 1'b0;
                            led4_r <= 1'b1;
                            led5_b <= 1'b0;
                            led5_g <= 1'b1;
                            led5_r <= 1'b0;
                        end
                        3'b100:  begin
                            led4_b <= 1'b0;
                            led4_g <= 1'b0;
                            led4_r <= 1'b1;
                            led5_b <= 1'b0;
                            led5_g <= 1'b1;
                            led5_r <= 1'b1;
                        end
                        3'b101:  begin
                            led4_b <= 1'b0;
                            led4_g <= 1'b0;
                            led4_r <= 1'b1;
                            led5_b <= 1'b0;
                            led5_g <= 1'b0;
                            led5_r <= 1'b1;
                        end
                        default : begin
                            led4_b <= 1'b0;
                            led4_g <= 1'b0;
                            led4_r <= 1'b0;
                            led5_b <= 1'b0;
                            led5_g <= 1'b0;
                            led5_r <= 1'b0;
                        end
                    endcase
                end
                2'b01:  begin //red
                    led4_b <= 1'b0;
                    led4_g <= 1'b0;
                    led4_r <= 1'b1;
                    led5_b <= 1'b0;
                    led5_g <= 1'b1;
                    led5_r <= 1'b0;
                    led <= g_r_time[4:1];
                end
                2'b10:  begin //green
                    led4_b <= 1'b0;
                    led4_g <= 1'b1;
                    led4_r <= 1'b1;
                    led5_b <= 1'b0;
                    led5_g <= 1'b1;
                    led5_r <= 1'b1;
                    led <= y_r_time[4:1];
                end
                2'b11:  begin //yellow
                    led4_b <= 1'b0;
                    led4_g <= 1'b0;
                    led4_r <= 1'b1;
                    led5_b <= 1'b0;
                    led5_g <= 1'b0;
                    led5_r <= 1'b1;
                    led <= r_r_time[4:1];
                end
                default : begin
                    led4_b <= 1'b0;
                    led4_g <= 1'b0;
                    led4_r <= 1'b0;
                    led5_b <= 1'b0;
                    led5_g <= 1'b0;
                    led5_r <= 1'b0;
                    led <= 4'b0000;
                end
            endcase
        end
    end 
    
endmodule
