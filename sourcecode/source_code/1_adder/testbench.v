`timescale 1ns / 1ps   //仿真单位时间为1ns，精度为1ps
module testbench;

  reg [32:1] A;
  reg [32:1] B;
  reg cin;
  wire [32:1] S;
  wire c32;
 
  adder32 adder32(
          .A(A),
		  .B(B),
		  .cin(cin),
		  .S(S),
		  .C32(c32)
		 );
		 
  initial begin
     A = 32'd0; B = 32'd0;cin=0;
     #100;
  end
  
  always #10 A=$random;
  always #10 B=$random;
  always #10 cin={$random}%2;
  
endmodule 


