module PWM_Decoder (
  input  [1:0] sw,
  input  btn,
  output reg [7:0] R_time_out,
  output reg [7:0] G_time_out,
  output reg [7:0] B_time_out
);

  always @ ( * ) begin
    if (btn) begin
        R_time_out = 8'hff;
        G_time_out = 8'hff;
        B_time_out = 8'hff;
    end
    else begin
        case (sw)
        2'b00: begin
            R_time_out = 8'h99;
            G_time_out = 8'h32;
            B_time_out = 8'hcc;
        end
        2'b01: begin
            R_time_out = 8'h1e;
            G_time_out = 8'h90;
            B_time_out = 8'hff;
        end
        2'b10: begin
            R_time_out = 8'hff;
            G_time_out = 8'hd7;
            B_time_out = 8'h00;
        end
        2'b11: begin
            R_time_out = 8'hff;
            G_time_out = 8'd45;
            B_time_out = 8'd00;
        end
        default: begin
            R_time_out = 8'd0;
            G_time_out = 8'd0;
            B_time_out = 8'd0;
        end
        endcase
    end
  end

endmodule // Decoder