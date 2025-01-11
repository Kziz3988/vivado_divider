`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/20 16:02:00
// Design Name: 
// Module Name: divider
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

//Full adder
module full_adder(input A, input B, input C, output S, output X);
    xor
        xor1(xor1_output, A, B),
        xor2(S, xor1_output, C);
    and
        and1(and1_output, A, B),
        and2(and2_output, xor1_output, C);
    or
        or1(X, and1_output, and2_output);
endmodule

//8-bit double-signed adder
module adder(input [7:0]A, input [7:0]B, output [7:0]S, output overflow);
    full_adder
        full_adder1(A[0], B[0], 1'b0, S[0], carry1),
        full_adder2(A[1], B[1], carry1, S[1], carry2),
        full_adder3(A[2], B[2], carry2, S[2], carry3),
        full_adder4(A[3], B[3], carry3, S[3], carry4),
        full_adder5(A[4], B[4], carry4, S[4], carry5),
        full_adder6(A[5], B[5], carry5, S[5], carry6),
        full_adder7(A[6], B[6], carry6, S[6], carry7),
        full_adder8(A[7], B[7], carry6, S[7], overflow);
endmodule

//9-bit double-signed subtructor
module subtractor(input [7:0]A, input [7:0]B, output[7:0]S, output overflow);
//two's complement
    not
        not1(not1_output, B[0]),
        not2(not2_output, B[1]),
        not3(not3_output, B[2]),
        not4(not4_output, B[3]),
        not5(not5_output, B[4]),
        not6(not6_output, B[5]),
        not7(not7_output, B[6]),
        not8(not8_output, B[7]);
    full_adder
//add
        full_adder1(A[0], not1_output, 1'b1, S[0], carry1),
        full_adder2(A[1], not2_output, carry1, S[1], carry2),
        full_adder3(A[2], not3_output, carry2, S[2], carry3),
        full_adder4(A[3], not4_output, carry3, S[3], carry4),
        full_adder5(A[4], not5_output, carry4, S[4], carry5),
        full_adder6(A[5], not6_output, carry5, S[5], carry6),
        full_adder7(A[6], not7_output, carry6, S[6], carry7),
        full_adder8(A[7], not8_output, carry7, S[7], overflow);
endmodule

//8-bit left shifter, shift before insert
module lsf(input [7:0]A, input last, output [7:0]B);
    assign B[0] = last;
    assign B[6:1] = A[5:0];
    assign B[7] = A[7];
endmodule

//8-bit left shifter, shift after insert
module fsf(input [7:0]A, input last, output [7:0]B);
    assign B[0] = 1'b0;
    assign B[1] = last;
    assign B[6:2] = A[5:1];
    assign B[7] = A[7];
endmodule

//16-8 multiplexer and left shifter, select A when C = 1, select B when C = 0; X is selected one, D and Y is temp quotient
module mux(input [7:0]A, input [7:0]B, input C, input [7:0]D, output [7:0]X, output [7:0]Y);
    not
        not1(notC, C);
    and
        and1(and1_output, A[0], C),
        and2(and2_output, A[1], C),
        and3(and3_output, A[2], C),
        and4(and4_output, A[3], C),
        and5(and5_output, A[4], C),
        and6(and6_output, A[5], C),
        and7(and7_output, A[6], C),
        and8(and8_output, A[7], C),
        and9(and9_output, B[0], notC),
        and10(and10_output, B[1], notC),
        and11(and11_output, B[2], notC),
        and12(and12_output, B[3], notC),
        and13(and13_output, B[4], notC),
        and14(and14_output, B[5], notC),
        and15(and15_output, B[6], notC),
        and16(and16_output, B[7], notC);
    or
        or1(X[0], and1_output, and9_output),
        or2(X[1], and2_output, and10_output),
        or3(X[2], and3_output, and11_output),
        or4(X[3], and4_output, and12_output),
        or5(X[4], and5_output, and13_output),
        or6(X[5], and6_output, and14_output),
        or7(X[6], and7_output, and15_output),
        or8(X[7], and8_output, and16_output);
    fsf
        fsf1(D, notC, Y);
endmodule

//8-bit comparar: outputs 0 when A is equal to 0, otherwise outputs 1
module cmp(input [7:0]A, output X);
    xnor
        xnor1(xnor1_output, A[0], 1'b0),
        xnor2(xnor2_output, A[1], 1'b0),
        xnor3(xnor3_output, A[2], 1'b0),
        xnor4(xnor4_output, A[3], 1'b0),
        xnor5(xnor5_output, A[4], 1'b0),
        xnor6(xnor6_output, A[5], 1'b0),
        xnor7(xnor7_output, A[6], 1'b0),
        xnor8(xnor8_output, A[7], 1'b0);
    nand
        nand1(X, xnor1_output, xnor2_output, xnor3_output, xnor4_output, xnor5_output, xnor6_output, xnor7_output, xnor8_output);
endmodule

//8-bit signed divider, A is dividend, B is divisor, C is quotient, D is remainder
module divider(input [7:0]A, input[7:0]B, output[7:0]C, output [7:0]D, output OVERFLOW, output LIGALITY);
    wire [7:0]sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8;
    wire [7:0]diff1, diff2, diff3, diff4, diff5, diff6, diff7, diff8;
    wire [7:0]rem1, rem2, rem3, rem4, rem5, rem6, rem7, rem8;
    wire [7:0]rem11, rem22, rem33, rem44, rem55, rem66, rem77;
    wire [7:0]q1, q2, q3, q4, q5, q6, q7, q8;
    xor
        xor1(xor1_output, A[7], B[7]),
        xor2(xor2_output, rem1[7], B[7]),
        xor3(xor3_output, rem2[7], B[7]),
        xor4(xor4_output, rem3[7], B[7]),
        xor5(xor5_output, rem4[7], B[7]),
        xor6(xor6_output, rem5[7], B[7]),
        xor7(xor7_output, rem6[7], B[7]),
        xor8(xor8_output, rem7[7], B[7]);
    cmp
        cmp1(B, LIGALITY);
    adder
        adder1(A, B, sum1, of1),
        adder2(rem1, B, sum2, of2),
        adder3(rem22, B, sum3, of3),
        adder4(rem33, B, sum4, of4),
        adder5(rem44, B, sum5, of5),
        adder6(rem55, B, sum6, of6),
        adder7(rem66, B, sum7, of7),
        adder8(rem77, B, sum8, of8);
    subtractor
        subtractor1(A, B, diff1, of10),
        subtractor2(rem1, B, diff2, of11),
        subtractor3(rem22, B, diff3, of12),
        subtractor4(rem33, B, diff4, of13),
        subtractor5(rem44, B, diff5, of14),
        subtractor6(rem55, B, diff6, of15),
        subtractor7(rem66, B, diff7, of16),
        subtractor8(rem77, B, diff8, of17);
    mux
        //mux0(sum3, diff3, xor3_output, q2, D, C),
        mux1(sum1, diff1, xor1_output, 8'b00000000, rem1, q1),
        mux2(sum2, diff2, xor2_output, 8'b00000000, rem2, q2),
        mux3(sum3, diff3, xor3_output, q2, rem3, q3),
        mux4(sum4, diff4, xor4_output, q3, rem4, q4),
        mux5(sum5, diff5, xor5_output, q4, rem5, q5),
        mux6(sum6, diff6, xor6_output, q5, rem6, q6),
        mux7(sum7, diff7, xor7_output, q6, rem7, q7),
        mux8(sum8, diff8, xor8_output, q7, rem8, q8);
    lsf
        lsf2(rem2, 1'b0, rem22),
        lsf3(rem3, 1'b0, rem33),
        lsf4(rem4, 1'b0, rem44),
        lsf5(rem5, 1'b0, rem55),
        lsf6(rem6, 1'b0, rem66),
        lsf7(rem7, 1'b0, rem77),
        lsf8(rem8, 1'b0, D),
        lsf9(q8, 1'b1, C);
    and
        and1(OVERFLOW, of1, of2, of3, of4, of5, of6, of7, of8, of10, of11, of12, of13, of14, of15, of16, of17);
endmodule
