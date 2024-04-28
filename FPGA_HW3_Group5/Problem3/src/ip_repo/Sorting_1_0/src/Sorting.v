module Sorting (
    input clk,
    input rst, 
    input [31:0] A, // input 32 bit (8 4-bit number)
    input enable,
    output wire [31:0] out,
    output wire valid
);

parameter Sidle = 1'd0,
          Swork = 1'd1;

reg state;
reg state_next;

reg [3:0] counter;
reg [3:0] sorted_count;


reg [3:0] data [7:0];
reg [3:0] data_next [7:0];
wire [3:0] data_intput [7:0];

assign data_intput[0] = A[3:0];
assign data_intput[1] = A[7:4];
assign data_intput[2] = A[11:8];
assign data_intput[3] = A[15:12];
assign data_intput[4] = A[19:16];
assign data_intput[5] = A[23:20];
assign data_intput[6] = A[27:24];
assign data_intput[7] = A[31:28];

assign out = {
    data[7],data[6],data[5],data[4],data[3],data[2],data[1],data[0]
};

assign valid = (state == Swork && sorted_count == 4'd7)?1'b1:1'b0;

always @(posedge clk) begin
    if(rst) begin
        sorted_count <= 4'b0;
    end
    else if(state == Swork) begin
        if(sorted_count < 4'd7 && counter == 4'd0) begin
            sorted_count <= sorted_count + 4'd1;
        end 
        else if (valid) begin
            sorted_count <= 4'b0;
        end else begin
            sorted_count <= sorted_count;
        end
    end
    else begin
        sorted_count <= 4'b0;
    end
end

always @(posedge clk) begin
    if(rst) begin
        counter <= 4'b0;
    end
    else if(enable && state == Sidle) begin
        counter <= 4'd7;
    end 
    else if(state == Swork) begin
        if(sorted_count >= 4'd7) begin
             counter <= 4'b0;
        end else if(counter == 4'd0) begin
            counter <= 4'd7 - sorted_count;
        end else begin
            counter <= counter - 4'd1;
        end
    end else begin
        counter <= 4'b0;
    end
end

always @(posedge clk) begin
    if(rst) begin
        state <= Sidle;
    end
    else begin
        state <= state_next;
    end
end

always @(*) begin
    case (state)
        Sidle: state_next = (enable)?Swork:Sidle; 
        Swork: state_next = (valid)?Sidle:Swork; 
        default: state_next = Sidle;
    endcase
end

integer  i;
always @(posedge clk) begin
    if(rst) begin
        for(i = 0;i<7;i = i + 1) begin
            data[i] <= 4'd0;
        end
    end else begin
        for(i = 0;i<8;i = i + 1) begin
            data[i] <= data_next[i];
        end
    end
end

always @(*) begin
    if(enable && state == Sidle) begin
        for(i = 0;i<8;i = i + 1) begin
            data_next[i] = data_intput[i];
        end
    end else if(sorted_count == 4'd7 || state == Sidle) begin
        for(i = 0;i<8;i = i + 1) begin
            data_next[i] = data[i]; // locked
        end
    end else begin
        for(i = 0;i<7;i = i + 1) begin
            if(i > sorted_count) begin
                data_next[i] = data[i+1]; // shift
            end else if(i == sorted_count && data[i] < data[i+1]) begin
                data_next[i] = data[i+1]; // compare 
            end
            else begin
                data_next[i] = data[i];// locked
            end
        end

        // i == 7
        if(data[sorted_count] < data[sorted_count+4'd1]) begin
            data_next[7] = data[sorted_count]; // shift
        end else begin
            data_next[7] = data[sorted_count+4'd1]; // compare 
        end
    end
end

endmodule