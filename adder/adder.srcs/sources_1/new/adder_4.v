`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/18 15:02:18
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
	  adder_1bit adder1(
	             .a0(x[1]),
					 .b0(y[1]),
					 .c0(c0),
					 .s(F[1]),
					 .c()
				);
		
	  adder_1bit adder2(
	             .a0(x[2]),
					 .b0(y[2]),
					 .c0(c1),
					 .s(F[2]),
					 .c()
				);	
		
	  adder_1bit adder3(
	             .a0(x[3]),
					 .b0(y[3]),
					 .c0(c2),
					 .s(F[3]),
					 .c()
				);
			
	  adder_1bit adder4(
	             .a0(x[4]),
					 .b0(y[4]),
					 .c0(c3),
					 .s(F[4]),
					 .c()
				);		
		
		adder_4CLA CLA(
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

endmodule 

    
