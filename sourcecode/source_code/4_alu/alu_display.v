//*************************************************************************
//   > �ļ���: alu_display.v
//   > ����  ��ALU��ʾģ�飬����FPGA���ϵ�IO�ӿںʹ�����
//*************************************************************************
module alu_display(
    input clk,       // ʱ���ź�
    input resetn,    //��λ�ź� ��׺"n"����͵�ƽ��Ч

    //���뿪�أ�����ѡ��������
    input [1:0] input_sel, //01:����Ϊ�����ź�(alu_control)
                           //10:����ΪԴ������1(alu_src1)
                           //11:����ΪԴ������2(alu_src2)

    //��������ؽӿڣ�����Ҫ����
    output lcd_rst,
    output lcd_cs,
    output lcd_rs,
    output lcd_wr,
    output lcd_rd,
    inout[15:0] lcd_data_io,
    output lcd_bl_ctr,
    inout ct_int,
    inout ct_sda,
    output ct_scl,
    output ct_rstn
    );
//-----{����ALUģ��}begin
    reg   [13:0] alu_control;  // ALU�����ź�
    //14λ������
    reg   [31:0] alu_src1;     // ALU������1
    reg   [31:0] alu_src2;     // ALU������2
    wire  [31:0] alu_result;   // ALU���
    wire  [31:0] div_odd;      //����������

    alu alu_module(
        .alu_control(alu_control),
        .alu_src1   (alu_src1   ),
        .alu_src2   (alu_src2   ),
        .alu_result (alu_result ),
        .div_odd    (div_odd    )
    );
    
//-----{����ALUģ��}end


//---------------------{���ô�����ģ��}begin--------------------//
//-----{ʵ����������}begin
//��С�ڲ���Ҫ����
    reg         display_valid;
    reg  [39:0] display_name;
    reg  [31:0] display_value;
    wire [5 :0] display_number;//��6λ2��������ʾ ����64�����
    wire        input_valid;
    wire [31:0] input_value;

    lcd_module lcd_module(
        .clk            (clk           ),   //10Mhz
        .resetn         (resetn        ),
        //�͵�ƽ��Ч

        //���ô������Ľӿ�
        .display_valid  (display_valid ),
        .display_name   (display_name  ),
        .display_value  (display_value ),
        .display_number (display_number),
        .input_valid    (input_valid   ),
        .input_value    (input_value   ),

        //lcd��������ؽӿڣ�����Ҫ����
        .lcd_rst        (lcd_rst       ),
        .lcd_cs         (lcd_cs        ),
        .lcd_rs         (lcd_rs        ),
        .lcd_wr         (lcd_wr        ),
        .lcd_rd         (lcd_rd        ),
        .lcd_data_io    (lcd_data_io   ),
        .lcd_bl_ctr     (lcd_bl_ctr    ),
        .ct_int         (ct_int        ),
        .ct_sda         (ct_sda        ),
        .ct_scl         (ct_scl        ),
        .ct_rstn        (ct_rstn       )
    ); 
//-----{ʵ����������}end

//-----{�Ӵ�������ȡ����}begin
//����ʵ����Ҫ��������޸Ĵ�С�ڣ�
//�����ÿһ���������룬��д����һ��always��
    //��input_selΪ01ʱ����ʾ�����������źţ���alu_control
    always @(posedge clk)
    //ʱ���߼���  �����ش���  ��ʱ���߼����� �÷�������ֵ  <=
    begin
        if (!resetn)
        //resetn �͵�ƽ��Ч ����Ҫȡ��
        begin
            alu_control <= 14'd0;
            //��Ч��ʱ�� �Ƚ�14λȫ����Ϊ0
        end
        else if (input_valid && input_sel==2'b01)
        //����Ѿ���������Ч���� ���Ҳ��뿪��Ϊ01
        begin
            alu_control <= input_value[13:0];
            //�������ֵ��ֵ�������ź� ����ֻѡȡ����14λ ����λ��Ч
        end
    end
    
    //��input_selΪ10ʱ����ʾ������ΪԴ������1����alu_src1
    always @(posedge clk)
    begin
        if (!resetn)
        //resetn �͵�ƽ��Ч ����Ҫȡ��
        begin
            alu_src1 <= 32'd0;
            //�տ�ʼ��Ч��ʱ�� �Ƚ�������1ȫ����Ϊ0
        end
        else if (input_valid && input_sel==2'b10)
        //����Ѿ���������Ч���� ���Ҳ��뿪��Ϊ10
        begin
            alu_src1 <= input_value;
            //�������ֵ��ֵ��������1
        end
    end

    //��input_selΪ11ʱ����ʾ������ΪԴ������2����alu_src2
    always @(posedge clk)
    begin
        if (!resetn)
        //resetn �͵�ƽ��Ч ����Ҫȡ��
        begin
            alu_src2 <= 32'd0;
            //�տ�ʼ��Ч��ʱ�� �Ƚ�������1ȫ����Ϊ0
        end
        else if (input_valid && input_sel==2'b11)
        //����Ѿ���������Ч���� ���Ҳ��뿪��Ϊ11
        begin
            alu_src2 <= input_value;
            //�������ֵ��ֵ��������2
        end
    end
//-----{�Ӵ�������ȡ����}end

//-----{�������������ʾ}begin
//������Ҫ��ʾ�����޸Ĵ�С�ڣ�
//�������Ϲ���44����ʾ���򣬿���ʾ44��32λ����
//44����ʾ�����1��ʼ��ţ����Ϊ1~44��
    always @(posedge clk)
    begin
        case(display_number)
            6'd1 :
            //������1
            begin
                display_valid <= 1'b1;
                display_name  <= "SRC_1";
                display_value <= alu_src1;
            end
            6'd2 :
            //������2
            begin
                display_valid <= 1'b1;
                display_name  <= "SRC_2";
                display_value <= alu_src2;
            end
            6'd3 :
            //��ʾ�����ź�
            begin
                display_valid <= 1'b1;
                display_name  <= "CONTR";
                display_value <={18'd0, alu_control};
                //����ʹ�����ַ�����ƴ�� { ��}
                //��Ϊ��������14λ���� �ʸ�λ��18λ��0����
            end
            6'd4 :
            //��ʾ���
            begin
                display_valid <= 1'b1;
                display_name  <= "RESUL";
                display_value <= alu_result;
            end
            6'd5 :
            //��ʾ�������������
            begin
                display_valid <= 1'b1;
                display_name  <= "ODD";
                display_value <= div_odd;
            end
            default :
            begin
                display_valid <= 1'b0;
                display_name  <= 40'd0;
                display_value <= 32'd0;
            end
        endcase
    end
//-----{�������������ʾ}end
//----------------------{���ô�����ģ��}end---------------------//
endmodule
