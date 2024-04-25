module	RGB_LED(
	input			clk,
	input			rst,
	input	[7:0]	R_time_in,
	input	[7:0]	G_time_in,
	input	[7:0]	B_time_in,
	output	[2:0]	rgb4,
	output	[2:0]	rgb5
);

wire	[7:0]	next_counter_256;

reg		[7:0]	counter_256;

assign			next_counter_256 = (counter_256 == 8'd255)? 8'd0 : counter_256 + 8'd1;

assign			rgb4[2] = (counter_256 < R_time_in)? 1'd1 : 1'd0;
assign			rgb4[1] = (counter_256 < G_time_in)? 1'd1 : 1'd0;
assign			rgb4[0] = (counter_256 < B_time_in)? 1'd1 : 1'd0;

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

parameter TIME      = 100000           ;
parameter TIME_W    = 17               ;
parameter NUM       = 1000             ;
parameter NUM_W     = 10               ;
parameter STEP      = 100              ;

reg  [TIME_W-1:0]   cnt0               ;
wire                    add_cnt0       ;
wire                    end_cnt0       ;
reg  [NUM_W:0]          cnt1           ;
wire                    add_cnt1       ;
wire                    end_cnt1       ;
reg  [1:0]              cnt2           ;
wire                    add_cnt2       ;
wire                    end_cnt2       ;
reg  [TIME_W-1:0]   pwm_high           ;

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

assign rgb5[2] = ((cnt0 < pwm_high) ? 1'b1 : 1'b0) & ((counter_256 < R_time_in)? 1'd1 : 1'd0);
assign rgb5[1] = ((cnt0 < pwm_high) ? 1'b1 : 1'b0) & ((counter_256 < G_time_in)? 1'd1 : 1'd0);
assign rgb5[0] = ((cnt0 < pwm_high) ? 1'b1 : 1'b0) & ((counter_256 < B_time_in)? 1'd1 : 1'd0);

endmodule