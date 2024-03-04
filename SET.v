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
    wire [8:0] r1_sq;
    wire [8:0] r2_sq;
    wire [8:0] r3_sq;
    
    // conbinational - 8*8 subset
    Subset  subsets[63:0] ();

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
