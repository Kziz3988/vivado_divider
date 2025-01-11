`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/23 16:50:52
// Design Name: 
// Module Name: divider_tb
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


module divider_tb;
    reg [7:0]A = 8'b00000001;
    reg [7:0]B = 8'b00000101;
    wire [7:0]C;
    wire [7:0]D;
    wire LIGALITY;
    divider dut(
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .LIGALITY(LIGALITY)
    );
    initial begin
        #100$finish;
    end
endmodule
