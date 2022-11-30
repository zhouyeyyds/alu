`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/18 15:50:21
// Design Name: 
// Module Name: adder32
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


//32λ���н�λ�ӷ�������ģ��
module adder32(A,B,cin,C32,S);
     input [32:1] A;
	 input [32:1] B;
	 input cin;   //	 ��λ����
	 output [32:1] S;
	 output C32;
	 
	 wire px1,gx1,px2,gx2;
	 wire c16;

  CLA_16 CLA1(
      .A(A[16:1]),
		.B(B[16:1]),
		.c0(cin),
		.S(S[16:1]),
		.px(px1),
		.gx(gx1)
	);
  
  CLA_16 CLA2(
        .A(A[32:17]),
		  .B(B[32:17]),
		  .c0(c16),
		  .S(S[32:17]),
		  .px(px2),
		  .gx(gx2)
	);

  assign c16 = gx1 ^ (px1 && cin),
         C32 = gx2 ^ (px2 && c16);

endmodule 


