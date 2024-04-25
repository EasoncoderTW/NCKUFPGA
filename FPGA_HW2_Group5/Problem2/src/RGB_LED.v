`define RED 24'hdc143c
`define ORANGE 24'hff4500
`define YELLOW 24'hffd700
`define BLUE 24'h1e90ff
`define INDIGO 24'h0000cd
`define PURPLE 24'h9400d3
`define WHITE 24'hffffff

module	RGB_LED(
	input			clk,
	input			rst,
    input           btn,
	output	[2:0]	rgb4
);

parameter sRED    = 3'd0;
parameter sORANGE = 3'd1;
parameter sYELLOW = 3'd2;
parameter sBLUE   = 3'd3;
parameter sINDIGO = 3'd4;
parameter sPURPLE = 3'd5;

reg [2:0] st_next;
reg [2:0] st_cur;

wire	[7:0]	next_counter_256;
reg     [23:0]  colour;
reg		[7:0]	counter_256;

parameter TIME      = 100000            ;
parameter TIME_W    = 17                ;
parameter NUM       = 1000              ;
parameter NUM_W     = 10                ;
parameter STEP      = 100               ;

reg  [TIME_W-1:0]   cnt0                ;
wire                    add_cnt0        ;
wire                    end_cnt0        ;
reg  [NUM_W:0]          cnt1            ;
wire                    add_cnt1        ;
wire                    end_cnt1        ;
reg  [1:0]              cnt2            ;
wire                    add_cnt2        ;
wire                    end_cnt2        ;
reg  [TIME_W-1:0]   pwm_high            ;
reg  [1:0]              cnt3            ;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        st_cur      <= 3'd0;
    end
    else begin
        st_cur      <= st_next;
    end
end

always @(*) begin
    st_next = st_cur;
    case (st_cur)
        sRED:
            if(cnt3==2 && cnt2==0 && end_cnt0) begin
                st_next = sORANGE;
            end
        sORANGE:
            if(cnt3==2 && cnt2==0 && end_cnt0) begin
                st_next = sYELLOW;
            end
        sYELLOW:
            if(cnt3==2 && cnt2==0 && end_cnt0) begin
                st_next = sBLUE;
            end
        sBLUE:
            if(cnt3==2 && cnt2==0 && end_cnt0) begin
                st_next = sINDIGO;
            end
        sINDIGO:
            if(cnt3==2 && cnt2==0 && end_cnt0) begin
                st_next = sPURPLE;
            end
        sPURPLE:
            if(cnt3==2 && cnt2==0 && end_cnt0) begin
                st_next = sRED;
            end
        default: st_next = sRED;
    endcase
end

always @(posedge clk or posedge rst) begin
    if(rst) begin
        colour <= `WHITE;
    end
    else if(btn) begin
        colour <= `WHITE;
    end
    else begin
        case(st_cur)
            sRED:
                colour <= `RED;
            sORANGE:
                colour <= `ORANGE;
            sYELLOW:
                colour <= `YELLOW;
            sBLUE:
                colour <= `BLUE;
            sINDIGO:
                colour <= `INDIGO;
            sPURPLE:
                colour <= `PURPLE;
            default:
                colour <= `WHITE;
        endcase
    end

end

assign	next_counter_256 = (counter_256 == 8'd255)? 8'd0 : counter_256 + 8'd1;

always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		counter_256	<= 8'd0;
	end
	else
	begin
		counter_256	<= next_counter_256;
	end
end



always @(posedge clk or posedge rst)begin
    if(rst)
        cnt0 <= 0;
    else if(add_cnt0)begin
        if(end_cnt0)
            cnt0 <= 0;
        else
            cnt0 <= cnt0 + 1;
    end
    else
       cnt0 <= cnt0;
end

assign add_cnt0 = 1;
assign end_cnt0 = add_cnt0 && cnt0==TIME-1 ;

always @(posedge clk or posedge rst)begin
    if(rst)
        cnt1 <= 0;
    else if(add_cnt1)begin
        if(end_cnt1)
            cnt1 <= 0;
        else
           cnt1 <= cnt1 + 1;
    end
    else
       cnt1 <= cnt1;
end

assign add_cnt1 = end_cnt0;
assign end_cnt1 = add_cnt1 && cnt1==NUM-1 ;

always @(posedge clk or posedge rst)begin
    if(rst)begin
        cnt2 <= 0;
    end
    else if(add_cnt2)begin
       if(end_cnt2)
            cnt2 <= 0;
        else
            cnt2 <= cnt2 + 1;
    end
    else
       cnt2 <= cnt2;
end

assign add_cnt2 = end_cnt1;
assign end_cnt2 = add_cnt2 && cnt2==2-1 ;

always @(posedge clk or posedge rst) begin
    if(rst)
        pwm_high <= 0;
    else if(cnt2==0 && end_cnt0)
        pwm_high <= pwm_high + STEP;
    else if(cnt2==1 && end_cnt0)
        pwm_high <= pwm_high - STEP;
    else
        pwm_high <= pwm_high;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        cnt3 <= 0;
    else if(cnt3 == 0 && cnt2==0 && end_cnt0)
        cnt3 <= cnt3 + 1;
    else if(cnt3 == 1 && cnt2==1 && end_cnt0)
        cnt3 <= cnt3 + 1;
    else if(cnt3 == 2 && cnt2==0 && end_cnt0)
        cnt3 <= 0;

end

assign rgb4[2] = ((cnt0 < pwm_high) ? 1'b1 : 1'b0) & ((counter_256 < colour[23:16])? 1'd1 : 1'd0);
assign rgb4[1] = ((cnt0 < pwm_high) ? 1'b1 : 1'b0) & ((counter_256 < colour[15:8])? 1'd1 : 1'd0);
assign rgb4[0] = ((cnt0 < pwm_high) ? 1'b1 : 1'b0) & ((counter_256 < colour[7:0])? 1'd1 : 1'd0);

endmodule