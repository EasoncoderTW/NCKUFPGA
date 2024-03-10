`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/04 15:29:48
// Design Name: 
// Module Name: SET
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "Subset.v"

module SET(
    input clk ,
    input rst,
    input en,
    input [23:0] central,
    input [11:0] radius,
    input [1:0] mode,
    output busy,
    output valid,
    output [7:0] candidate
    );
    // input reg
    reg [23:0] central_reg;
    reg [11:0] radius_reg;
    reg [1:0] mode_reg;

    // output reg
    reg valid;
    reg busy;
    reg [7:0]candidate;

    // conbinational - square of radius
    wire [3:0] r1, r2, r3;
    wire [7:0] r1_sq, r2_sq, r3_sq;

    assign r1 = radius_reg[11:8];
    assign r2 = radius_reg[7:4];
    assign r3 = radius_reg[3:0];

    assign r1_sq = r1 * r1;
    assign r2_sq = r2 * r2;
    assign r3_sq = r3 * r3;

    // conbinational - 8 subset
    wire [7:0] activated;
    generate
        genvar i;
        for (i=0; i<8; i=i+1) begin : subsets_gen
            Subset i_subsets(
            .central(central_reg),
            .radius_square({r1_sq,r2_sq,r3_sq}),
            .mode(mode_reg),
            .position_x(i),
            .position_y(position_y),
            .activated(activated[i]),
            );
        end
    endgenerate

    // conbinational - activated counter (8 to 1 adder tree)
    wire [3:0] partial_candidate;
    wire [3:0] partial_candidate_0;
    wire [3:0] partial_candidate_1;
    wire [3:0] partial_candidate_2;
    wire [3:0] partial_candidate_3;
    wire [3:0] partial_candidate_4;
    wire [3:0] partial_candidate_5;

    assign partial_candidate_0 = {3'd0, activated[1]} + {3'd0, activated[0]};
    assign partial_candidate_1 = {3'd0, activated[3]} + {3'd0, activated[2]};
    assign partial_candidate_2 = {3'd0, activated[5]} + {3'd0, activated[4]};
    assign partial_candidate_3 = {3'd0, activated[7]} + {3'd0, activated[6]};
    assign partial_candidate_4 = partial_candidate_1 + partial_candidate_0;
    assign partial_candidate_5 = partial_candidate_3 + partial_candidate_2;
    assign partial_candidate = partial_candidate_5 + partial_candidate_4;

    // next state
    reg [3:0] position_y;
    wire [3:0] position_y_next;
    wire valid_next;
    wire busy_next;
    wire [7:0] candidate_next;

    assign busy_next = (en)?1'b1:((valid)?1'b0:1'b1); // after en: high,  after valid: low
    assign valid_next = (busy & (position_y==4'd7))? 1'b1:1'b0;
    assign position_y_next = (valid_next | (~busy))? 4'd0: (position_y + 4'd1);
    assign candidate_next = (busy & (~valid))?(candidate_next + {4'd0,partial_candidate}): 8'd0;
    
    // sequential - controller
    always @(posedge clk or rst) begin
        if(rst) begin
            valid <= 1'b0;
            candidate <= 8'b0; // clear output
            position_y <= 4'd0;
            busy <= 1'b0;
            // input reg
            central_reg <= 24'd0;
            radius_reg <= 12'd0;
            mode_reg <= 2'd0;
        end
        else begin
            position_y <= position_y_next;
            valid <= valid_next;
            candidate <= candidate_next;
            busy <= busy_next;
            // input reg
            central_reg <= (en)? central:central_reg;
            radius_reg <= (en)? radius:radius_reg;
            mode_reg <= (en)? mode:mode_reg;
        end
    end
    
endmodule
