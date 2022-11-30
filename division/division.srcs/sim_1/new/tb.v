`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/30 17:28:06
// Design Name: 
// Module Name: tb
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


module tb();

reg   [31:0]          A;
reg   [31:0]          B;
wire  [31:0]          result;
wire  [31:0]          r;

division division_model(
    .A                  (A     ),
    .B                  (B     ),
    .result             (result),
    .r                  (r   )
    );

// initial clk_in = 1'b0;
// always #5 clk_in = ~clk_in;  // 10ns,50MHz

initial begin
    #100;
    A = 32'd99999999;
    B = 32'd9;
    #1000;
    $stop;
end   
endmodule
