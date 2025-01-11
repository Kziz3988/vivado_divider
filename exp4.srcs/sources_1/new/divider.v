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

//8-bit complement converter
module conv(input [7:0]A, output [7:0]B);
    not
        not1(not1_output, A[0]),
        not2(not2_output, A[1]),
        not3(not3_output, A[2]),
        not4(not4_output, A[3]),
        not5(not5_output, A[4]),
        not6(not6_output, A[5]),
        not7(not7_output, A[6]),
        not8(not8_output, A[7]);
   full_adder
        full_adder1(not1_output, 1'b1, 1'b0, B[0], carry1),
        full_adder2(not2_output, 1'b0, carry1, B[1], carry2),
        full_adder3(not3_output, 1'b0, carry2, B[2], carry3),
        full_adder4(not4_output, 1'b0, carry3, B[3], carry4),
        full_adder5(not5_output, 1'b0, carry4, B[4], carry5),
        full_adder6(not6_output, 1'b0, carry5, B[5], carry6),
        full_adder7(not7_output, 1'b0, carry6, B[6], carry7),
        full_adder8(not8_output, 1'b0, carry7, B[7], carry8);
endmodule

//15-bit signed subtructor
module subtractor(input [14:0]A, input [14:0]B, output[14:0]S);
//two's complement
    not
        not1(not1_output, B[0]),
        not2(not2_output, B[1]),
        not3(not3_output, B[2]),
        not4(not4_output, B[3]),
        not5(not5_output, B[4]),
        not6(not6_output, B[5]),
        not7(not7_output, B[6]),
        not8(not8_output, B[7]),
        not9(not9_output, B[8]),
        not10(not10_output, B[9]),
        not11(not11_output, B[10]),
        not12(not12_output, B[11]),
        not13(not13_output, B[12]),
        not14(not14_output, B[13]),
        not15(not15_output, B[14]);
    full_adder
//add
        full_adder1(A[0], not1_output, 1'b1, S[0], carry1),
        full_adder2(A[1], not2_output, carry1, S[1], carry2),
        full_adder3(A[2], not3_output, carry2, S[2], carry3),
        full_adder4(A[3], not4_output, carry3, S[3], carry4),
        full_adder5(A[4], not5_output, carry4, S[4], carry5),
        full_adder6(A[5], not6_output, carry5, S[5], carry6),
        full_adder7(A[6], not7_output, carry6, S[6], carry7),
        full_adder8(A[7], not8_output, carry7, S[7], carry8),
        full_adder9(A[8], not9_output, carry8, S[8], carry9),
        full_adder10(A[9], not10_output, carry9, S[9], carry10),
        full_adder11(A[10], not11_output, carry10, S[10], carry11),
        full_adder12(A[11], not12_output, carry11, S[11], carry12),
        full_adder13(A[12], not13_output, carry12, S[12], carry13),
        full_adder14(A[13], not14_output, carry13, S[13], carry14),
        full_adder15(A[14], not15_output, carry14, S[14], carry15);
endmodule

//8-bit signed subtructor
module subtractor8(input [14:0]A, input [14:0]B, output[14:0]S);
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
        full_adder8(A[7], not8_output, carry7, S[7], carry8);
endmodule

//7-bit left shifter, shift after insert
module lsf(input [6:0]A, input last, output [6:0]B);
    assign B[0] = 1'b0;
    assign B[1] = last;
    assign B[6:2] = A[5:1];
endmodule

//14-bit right shifter
module rsf(input [13:0]A, output [13:0]B);
    assign B[13] = 1'b0;
    assign B[12:0] = A[13:1];
endmodule

//16-7 complexer with complement converter, outputs the absolute value of 8-bit signed number A
module abs(input [7:0]A, output [6:0]X);
    wire [7:0]B;
    conv
        conv1(A, B);
    not
        not1(notC, A[7]);
    and
        and1(and1_output, A[0], notC),
        and2(and2_output, A[1], notC),
        and3(and3_output, A[2], notC),
        and4(and4_output, A[3], notC),
        and5(and5_output, A[4], notC),
        and6(and6_output, A[5], notC),
        and7(and7_output, A[6], notC),
        and9(and9_output, B[0], A[7]),
        and10(and10_output, B[1], A[7]),
        and11(and11_output, B[2], A[7]),
        and12(and12_output, B[3], A[7]),
        and13(and13_output, B[4], A[7]),
        and14(and14_output, B[5], A[7]),
        and15(and15_output, B[6], A[7]);
    or
        or1(X[0], and1_output, and9_output),
        or2(X[1], and2_output, and10_output),
        or3(X[2], and3_output, and11_output),
        or4(X[3], and4_output, and12_output),
        or5(X[4], and5_output, and13_output),
        or6(X[5], and6_output, and14_output),
        or7(X[6], and7_output, and15_output);
endmodule

//14-7 multiplexer and shifter, outputs the next remainder X, divisor Y, and temp quotient Z
module attempt(input [13:0]A, input [13:0]B, input [6:0]D, output [13:0]X, output[13:0]Y, output [6:0]Z);
    wire [14:0]AA, BB, C;
    assign AA[13:0] = A;
    assign BB[13:0] = B;
    assign AA[14] = 1'b0;
    assign BB[14] = 1'b0;
    subtractor
        subtractor1(AA, BB, C);
    not
        not1(notC, C[14]);
    and
        and1(and1_output, A[0], C[14]),
        and2(and2_output, A[1], C[14]),
        and3(and3_output, A[2], C[14]),
        and4(and4_output, A[3], C[14]),
        and5(and5_output, A[4], C[14]),
        and6(and6_output, A[5], C[14]),
        and7(and7_output, A[6], C[14]),
        and8(and8_output, A[7], C[14]),
        and9(and9_output, A[8], C[14]),
        and10(and10_output, A[9], C[14]),
        and11(and11_output, A[10], C[14]),
        and12(and12_output, A[11], C[14]),
        and13(and13_output, A[12], C[14]),
        and14(and14_output, A[13], C[14]),
        and15(and15_output, C[0], notC),
        and16(and16_output, C[1], notC),
        and17(and17_output, C[2], notC),
        and18(and18_output, C[3], notC),
        and19(and19_output, C[4], notC),
        and20(and20_output, C[5], notC),
        and21(and21_output, C[6], notC),
        and22(and22_output, C[7], notC),
        and23(and23_output, C[8], notC),
        and24(and24_output, C[9], notC),
        and25(and25_output, C[10], notC),
        and26(and26_output, C[11], notC),
        and27(and27_output, C[12], notC),
        and28(and28_output, C[13], notC);
    or
        or1(X[0], and1_output, and15_output),
        or2(X[1], and2_output, and16_output),
        or3(X[2], and3_output, and17_output),
        or4(X[3], and4_output, and18_output),
        or5(X[4], and5_output, and19_output),
        or6(X[5], and6_output, and20_output),
        or7(X[6], and7_output, and21_output),
        or8(X[7], and8_output, and22_output),
        or9(X[8], and9_output, and23_output),
        or10(X[9], and10_output, and24_output),
        or11(X[10], and11_output, and25_output),
        or12(X[11], and12_output, and26_output),
        or13(X[12], and13_output, and27_output),
        or14(X[13], and14_output, and28_output);
    rsf
        rsf1(B, Y);
    lsf
        lsf1(D, notC, Z);
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

//Assign 7-bit number A to lower 7 digits of 14-bit number B
module al(input [6:0]A, output [13:0]B);
    assign B[6:0] = A;
    assign B[13:7] = 7'b0000000;
endmodule

//Assign 7-bit number A to higher 7 digits of 14-bit number B
module ah(input [6:0]A, output [13:0]B);
    assign B[13:7] = A;
    assign B[6:0] = 7'b0000000;
endmodule

//Convert 7-bit unsigned number to 8-bit signed number
module sign7(input [6:0]A, input B, output [7:0]C);
    assign C[6:0] = A[6:0];
    assign C[7] = B;
endmodule

//Convert 14-bit unsigned number to 8-bit signed number
module sign14(input [13:0]A, input B, output [7:0]C);
    assign C[6:0] = A[6:0];
    assign C[7] = B;
endmodule

//16-8 complexer, determine quotient
module signQ(input [7:0]A, input B, output [7:0]C);
    wire [7:0]DD, D;
    subtractor8
        sub1(DD, 8'b00000001, D);
    conv
        conv1(A, DD);
    not
        not1(notB, B);
    and
        and1(and1_output, A[0], notB),
        and2(and2_output, A[1], notB),
        and3(and3_output, A[2], notB),
        and4(and4_output, A[3], notB),
        and5(and5_output, A[4], notB),
        and6(and6_output, A[5], notB),
        and7(and7_output, A[6], notB),
        and8(and8_output, A[7], notB),
        and9(and9_output, D[0], B),
        and10(and10_output, D[1], B),
        and11(and11_output, D[2], B),
        and12(and12_output, D[3], B),
        and13(and13_output, D[4], B),
        and14(and14_output, D[5], B),
        and15(and15_output, D[6], B),
        and16(and16_output, D[7], B);
    or
        or1(C[0], and1_output, and9_output),
        or2(C[1], and2_output, and10_output),
        or3(C[2], and3_output, and11_output),
        or4(C[3], and4_output, and12_output),
        or5(C[4], and5_output, and13_output),
        or6(C[5], and6_output, and14_output),
        or7(C[6], and7_output, and15_output),
        or8(C[7], and8_output, and16_output);
endmodule

//16-8 complexer, determine remainder
module signR(input [7:0]A, input B, input [7:0]D, output [7:0]C);
    wire [7:0]DD;
    subtractor8
        sub1(D, A, DD);
    not
        not1(notB, B);
    and
        and1(and1_output, A[0], notB),
        and2(and2_output, A[1], notB),
        and3(and3_output, A[2], notB),
        and4(and4_output, A[3], notB),
        and5(and5_output, A[4], notB),
        and6(and6_output, A[5], notB),
        and7(and7_output, A[6], notB),
        and8(and8_output, A[7], notB),
        and9(and9_output, DD[0], B),
        and10(and10_output, DD[1], B),
        and11(and11_output, DD[2], B),
        and12(and12_output, DD[3], B),
        and13(and13_output, DD[4], B),
        and14(and14_output, DD[5], B),
        and15(and15_output, DD[6], B),
        and16(and16_output, DD[7], B);
    or
        or1(C[0], and1_output, and9_output),
        or2(C[1], and2_output, and10_output),
        or3(C[2], and3_output, and11_output),
        or4(C[3], and4_output, and12_output),
        or5(C[4], and5_output, and13_output),
        or6(C[5], and6_output, and14_output),
        or7(C[6], and7_output, and15_output),
        or8(C[7], and8_output, and16_output);
endmodule

//8-bit signed divider, A is dividend, B is divisor, C is quotient, D is remainder
module divider(input [7:0]A, input[7:0]B, output[7:0]C, output [7:0]D, output LIGALITY);
    wire [13:0] A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2, B3, B4, B5, B6, B7;
    wire [6:0]AA, BB, C1, C2, C3, C4, C5, C6, C7;
    wire [7:0]C0, D0;
    xor
        xor1(xor1_output, A[7], B[7]);
    abs
        abs1(A, AA),
        abs2(B, BB);
    al
        al1(AA, A0);
    ah
        ah1(BB, B0);
    attempt
        atp1(A0, B0, 7'b0000000, A1, B1, C1),
        atp2(A1, B1, C1, A2, B2, C2),
        atp3(A2, B2, C2, A3, B3, C3),
        atp4(A3, B3, C3, A4, B4, C4),
        atp5(A4, B4, C4, A5, B5, C5),
        atp6(A5, B5, C5, A6, B6, C6),
        atp7(A6, B6, C6, A7, B7, C7);
    sign14
        signA(A7, 1'b0, D0);
    sign7
        signB(C7, 1'b0, C0);
    signQ
        signC(C0, xor1_output, C);
    signR
        signD(D0, xor1_output, B, D);
    cmp
        cmp1(B, LIGALITY);
endmodule

//Redesigned divider for the board. The dividend and divisor share the same input, the quotient is the only output
//There are 3 states, which are input dividend, input divisor and calculate.
module divider_(SW, SET, Q);
    input [7:0]SW;
    input SET;
    output Q;
    reg [7:0] A, B=8'b00000001, Q;
    reg state=1'b0;
    wire [7:0] C;
    always @(posedge SET) begin
        if(state)
            B=SW;
        else
            A=SW;
        state<=~state;
    end
    always @(state)begin
        if(state)
            Q<=C;
        else
            Q<=8'b00000000;
    end
    wire [13:0] A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2, B3, B4, B5, B6, B7;
    wire [6:0]AA, BB, C1, C2, C3, C4, C5, C6, C7;
    wire [7:0]C0, D0;
    xor
        xor1(xor1_output, A[7], B[7]);
    abs
        abs1(A, AA),
        abs2(B, BB);
    al
        al1(AA, A0);
    ah
        ah1(BB, B0);
    attempt
        atp1(A0, B0, 7'b0000000, A1, B1, C1),
        atp2(A1, B1, C1, A2, B2, C2),
        atp3(A2, B2, C2, A3, B3, C3),
        atp4(A3, B3, C3, A4, B4, C4),
        atp5(A4, B4, C4, A5, B5, C5),
        atp6(A5, B5, C5, A6, B6, C6),
        atp7(A6, B6, C6, A7, B7, C7);
    sign7
        signB(C7, 1'b0, C0);
    signQ
        signC(C0, xor1_output, C);
endmodule