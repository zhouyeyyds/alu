`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
module tb;
    //alu��ط������
    reg clk;
    reg   [13:0] alu_control;
    reg   [31:0] alu_src1;   
    reg   [31:0] alu_src2;   
    wire  [31:0] alu_result; 
    wire  [31:0] div_odd;

    alu alu_module(
        .clk( clk),
        .alu_control(alu_control),
        .alu_src1   (alu_src1   ),
        .alu_src2   (alu_src2   ),
        .alu_result (alu_result ),
        .div_odd (div_odd)
    );
    
    initial begin

          //��
//        alu_control = 14'b00_0000_0000_0001;
//        alu_src1 = 32'h2223;
//        alu_src2 = 32'h2222;

//        //��
//        #5;
//        alu_control = 14'b00_0000_0000_0010;
//        alu_src1 = 32'd25;
//        alu_src2 = 32'd2;
        
        //��
//        clk = 0;
//        alu_control = 14'b00_0000_00000100;
//        alu_src1 = 32'd222;
//        alu_src2 = 32'd2;

//        //��
//        #5;
//        alu_control = 14'b00_0000_0000_1000;
//        alu_src1 = 32'd564;
//        alu_src2 = 32'd7;
        
//        //�з��űȽ�
//        #5;
//        alu_control = 14'b00_0000_0001_0000;
//        alu_src1 = 32'h12345678;
//        alu_src2 = 32'h12345677;
        
//        //�޷��űȽ�
//        #5;
//        alu_control = 14'b00_0000_0010_0000;
//        alu_src1 = 32'd1;
//        alu_src2 = 32'd2;

        //��
//        #5;
//        alu_control = 14'b00_0000_0100_0000;
//        alu_src1 = 32'd22;
//        alu_src2 = 32'd23;
        
//        //���
//        #5;
//        alu_control = 14'b00_0000_1000_0000;
//        alu_src1 = 32'b1010;
//        alu_src2 = 32'b0101;
        
//        //��
//        #5;
//        alu_control = 14'b00_0001_0000_0000;
//        alu_src1 = 32'd4;
//        alu_src2 = 32'hf;
        
        //���
//        #5;
//        alu_control = 14'b00_0010_0000_0000;
//        alu_src1 = 32'h0001;
//        alu_src2 = 32'h1111;

//        //�߼�����       
//        #5;
//        alu_control = 14'b00_0100_0000_0000;
//        alu_src1 = 32'd4;
//        alu_src2 = 32'hf0000000;

//        //�߼�����
//        #5;
//        alu_control = 14'b00_1000_0000_0000;
//        alu_src2 = 32'hbfc0;
        
        //��������
//        #5;
//        alu_control = 14'b01_0000_0000_0000;
//        alu_src1 = 32'd4;
//        alu_src2 = 32'hf0000000;
        
        //��λ����
        #5;
        alu_control = 14'b10_0000_0000_0000;
        alu_src1 = 32'd4444;
        alu_src2 = 32'h5555;



    end
    always #5 clk = ~clk;
    
endmodule

