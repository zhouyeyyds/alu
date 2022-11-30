`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 32λ������
// Create Date: 2022/11/30 17:20:39
//////////////////////////////////////////////////////////////////////////////////
module division(
    input   [31:0]         A,
    input   [31:0]         B,
    output  [31:0]         result,//��
    output  [31:0]         r//����
    );
    reg[31:0]                  a_reg;
    reg[31:0]                  b_reg;
    reg[63:0]                  temp_a;
    reg[63:0]                  temp_b;
    integer                    i;//����һ������i
    
always @(*) begin
    a_reg = A;
    b_reg = B;
end
 
always @(*) begin
    temp_a = {32'h0,a_reg};//��������32λ��0
    temp_b = {b_reg,32'h0};//������32λ��0
 
    for(i=0;i<32;i=i+1)
    //ʹ��forѭ�� ѭ��32�μ���
    begin
        temp_a = temp_a <<1 ;
        //����һλ
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
 
assign      r = temp_a[63:32];//��λ��32λ����
assign result = temp_a[31:0];//��λ��32ΪΪ��

endmodule