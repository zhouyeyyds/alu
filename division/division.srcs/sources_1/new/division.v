`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 32位除法器
// Create Date: 2022/11/30 17:20:39
//////////////////////////////////////////////////////////////////////////////////
module division(
    input   [31:0]         A,
    input   [31:0]         B,
    output  [31:0]         result,//商
    output  [31:0]         r//余数
    );
    reg[31:0]                  a_reg;
    reg[31:0]                  b_reg;
    reg[63:0]                  temp_a;
    reg[63:0]                  temp_b;
    integer                    i;//定义一个变量i
    
always @(*) begin
    a_reg = A;
    b_reg = B;
end
 
always @(*) begin
    temp_a = {32'h0,a_reg};//被除数高32位补0
    temp_b = {b_reg,32'h0};//除数低32位补0
 
    for(i=0;i<32;i=i+1)
    //使用for循环 循环32次计算
    begin
        temp_a = temp_a <<1 ;
        //左移一位
        if(temp_a >= temp_b)
        begin
            temp_a = temp_a - temp_b +1;
        end
        
        else
        begin
            temp_a = temp_a;
        end
    end
end
 
assign      r = temp_a[63:32];//高位的32位余数
assign result = temp_a[31:0];//低位的32为为商

endmodule