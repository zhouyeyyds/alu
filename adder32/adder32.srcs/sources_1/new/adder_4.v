`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/18 15:49:26
// Design Name: 
// Module Name: adder_4
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


//四位并行进位加法器
module adder_4(x,y,c0,c4,F,Gm,Pm);
      input [4:1] x;
	  input [4:1] y;
	  input c0;
	  output c4,Gm,Pm;
	  output [4:1] F;
	  	  
	  wire p1,p2,p3,p4,g1,g2,g3,g4;
	  wire c1,c2,c3;
	  adder adder1(
	  //调用一位全加器模块
	             .X(x[1]),
					 .Y(y[1]),
					 .Cin(c0),
					 .F(F[1]),
					 .Cout()
				);
		
	  adder adder2(
	  //调用一位全加器模块
	             .X(x[2]),
					 .Y(y[2]),
					 .Cin(c1),
					 .F(F[2]),
					 .Cout()
				);	
		
	  adder adder3(
	  //调用一位全加器模块
	             .X(x[3]),
					 .Y(y[3]),
					 .Cin(c2),
					 .F(F[3]),
					 .Cout()
				);
			
	  adder adder4(
	  //调用一位全加器模块
	             .X(x[4]),
					 .Y(y[4]),
					 .Cin(c3),
					 .F(F[4]),
					 .Cout()
				);		
		
		CLA CLA(
		//调用CLA器件 获取超前进位c1 c2 c3 c4
			.c0(c0),
			.c1(c1),
			.c2(c2),
			.c3(c3),
			.c4(c4),
			.p1(p1),
			.p2(p2),
			.p3(p3),
			.p4(p4),
			.g1(g1),
			.g2(g2),
			.g3(g3),
			.g4(g4)
		);
				
		
	  
  assign   p1 = x[1] ^ y[1],	  
           p2 = x[2] ^ y[2],
		   p3 = x[3] ^ y[3],
		   p4 = x[4] ^ y[4];

  assign   g1 = x[1] & y[1],
           g2 = x[2] & y[2],
		   g3 = x[3] & y[3],
		   g4 = x[4] & y[4];

  assign Pm = p1 & p2 & p3 & p4,
         Gm = g4 ^ (p4 & g3) ^ (p4 & p3 & g2) ^ (p4 & p3 & p2 & g1);
         
         //获取成组进位发生信号 和 成组进位传送信号

endmodule 


