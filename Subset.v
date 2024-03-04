`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/04 16:31:07
// Design Name: 
// Module Name: Subset
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


module Subset(
        input [23:0] central,
        input [23:0] radius_square,
        input [1:0] mode,
        input [7:0] position, // fixed from module outside
        output activated,
    );

    /* pure combinational circuit , no clock or reset */ 

    // seperate the central wire
    wire [3:0] central_xA;    
    wire [3:0] central_yA;    
    wire [3:0] central_xB;    
    wire [3:0] central_yB;    
    wire [3:0] central_xC;    
    wire [3:0] central_yC;
    
    assign central_xA = central[23:20];    
    assign central_yA = central[19:16];    
    assign central_xB = central[15:12];    
    assign central_yB = central[11:8];    
    assign central_xC = central[9:4];    
    assign central_yC = central[3:0];  


    // calculate distance (without square root)

    // compare with radius_square

    // determine if the point is activated  

    

endmodule
