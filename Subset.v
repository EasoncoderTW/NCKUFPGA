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
        input [4:0] position_x, // fixed from module outside
        input [4:0] position_y, // fixed from module outside
        output activated,
    );

    /* pure combinational circuit , no clock or reset */ 

    // seperate the central wire
    wire [3:0] central_xA,central_yA;      
    wire [3:0] central_xB,central_yB;     
    wire [3:0] central_xC,central_yC;    
    wire [7:0] radius_square_A,radius_square_B,radius_square_C;    
    
    assign central_xA = central[23:20];    
    assign central_yA = central[19:16];    
    assign central_xB = central[15:12];    
    assign central_yB = central[11:8];    
    assign central_xC = central[9:4];    
    assign central_yC = central[3:0];  

    assign radius_square_A = radius_square[23:16];
    assign radius_square_B = radius_square[15:8];
    assign radius_square_C = radius_square[7:0];

    // calculate distance (without square root)
    wire [7:0] distance_A,distance_B,distance_C;
    assign distance_A = (central_xA-position_x)*(central_xA-position_x) + (central_yA-position_y)*(central_yA-position_y);
    assign distance_B = (central_xB-position_x)*(central_xB-position_x) + (central_yB-position_y)*(central_yB-position_y);
    assign distance_C = (central_xC-position_x)*(central_xC-position_x) + (central_yC-position_y)*(central_yC-position_y);

    // compare with radius_square
    wire include_A,include_B,include_C;
    assign include_A = (distance_A < radius_square_A);
    assign include_B = (distance_C < radius_square_B);
    assign include_C = (distance_B < radius_square_C);

    // determine if the point is activated  

    assign activated = (mode==2'b00)?(include_A):
                       (mode==2'b01)?(include_A & include_B):
                       (mode==2'b10)?((include_A & ~include_B)|(~include_A & include_B)):
                       (mode==2'b11)?(
                        ((include_A & include_B)|(include_B & include_C)|(include_C & include_A)) &
                        ~(include_A & include_B & include_C)
                        ):1'b0;

endmodule
