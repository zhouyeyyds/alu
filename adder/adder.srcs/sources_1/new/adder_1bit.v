`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/18 14:42:21
// Design Name: 
// Module Name: adder_1bit
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


module adder_1bit(a0,b0,c0,s,c);
//一位全加器
  input a0,b0,c0;
  output s,c;
  
  assign s= a0 ^ b0 ^ c0;
  assign c = (a0 ^ b0) & c0 | a0 & b0;
  
endmodule 

