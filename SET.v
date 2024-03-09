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
    // output reg
    reg valid;

    // conbinational - square of radius
    wire [3:0] r1, r2, r3;
    wire [7:0] r1_sq, r2_sq, r3_sq;

    assign r1_sq = r1 * r1;
    assign r2_sq = r2 * r2;
    assign r3_sq = r3 * r3;

    // conbinational - 8*8 subset
    generate
        genvar i;
        for (i=0; i<63; i=i+1) begin : subsets_gen
            Subset i_subsets(
            .central(central),
            .radius_square({r1_sq,r2_sq,r3_sq}),
            .mode(mode),
            .position_x(i/8),
            .position_y(i%8),
            .ctivated(activated),
            );
        end
    endgenerate

    // conbinational - activated counter (64 to 1 adder tree)

    // sequential - controller
    always @(posedge clk or rst) begin
        if(rst) begin
            valid <= 1'b0;
            candidate <= 8'b0; // clear output
        end
        else begin
            // TBD
        end
    end
    
endmodule
