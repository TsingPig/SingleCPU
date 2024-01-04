module decoding(op, func, RegWr, Branch, Jump, ExtOp, AluSrc, Aluctr, MemWr, MemtoReg, RegDst);
// ģ���������������������op�͹�����func�����һϵ�п����ź�
// ���룺6λ�Ĳ�����op�͹�����func
// ����������ź�RegWr, Branch, Jump, ExtOp, AluSrc, MemWr, MemtoReg, RegDst, Aluctr

	input [5:0] op, func;  

	output reg RegWr, Branch, Jump, ExtOp, AluSrc, MemWr, MemtoReg, RegDst;  
	output reg [2:0] Aluctr;  // ���3λALU�����ź�

	// reg RegWr, Branch, Jump, ExtOp, AluSrc, MemWr, MemtoReg, RegDst;  // �Ĵ������͵Ŀ����ź�
	// reg [2:0] Aluctr;  // 3λALU�����źżĴ���

	always @(op)
	// �����������op�����仯ʱִ��
		case(op)
			6'b000000:  // ������Ϊ6'b000000ʱ��R��ָ��
				begin
					{Branch, Jump, RegDst, AluSrc, MemtoReg, RegWr, MemWr} = 7'b0010010;  // ���ö�������ź�
					case(func)
						6'b100000: Aluctr = 3'b001;		// add
						6'b100010: Aluctr = 3'b101;		// sub
						6'b100011: Aluctr = 3'b100;		// subu
						6'b101010: Aluctr = 3'b111;		// slt
						6'b101011: Aluctr = 3'b110;		// sltu
					endcase
				end
			// ʣ��ָ��ֻ��op�ֶ��й�
			6'b001101:									// ori
				begin
					{Branch, Jump, RegDst, AluSrc, MemtoReg, RegWr, MemWr, ExtOp} = 8'b00010100;
					Aluctr = 3'b010;
				end
			6'b001001:									// addiu
				begin
					{Branch, Jump, RegDst, AluSrc, MemtoReg, RegWr, MemWr, ExtOp} = 8'b00010101;
					Aluctr = 3'b000;
				end
			6'b100011:									// lw
				begin
					{Branch, Jump, RegDst, AluSrc, MemtoReg, RegWr, MemWr, ExtOp} = 8'b00011101;
					Aluctr = 3'b000;
				end
			6'b101011:									// sw
				begin
					{Branch, Jump, AluSrc, RegWr, MemWr, ExtOp} = 6'b001011;
					Aluctr = 3'b000;
				end
			6'b000100:									// beq
				begin
					{Branch, Jump, AluSrc, RegWr, MemWr} = 5'b10000;
					Aluctr = 3'b100;
				end
			6'b000010:									// jump
				begin
					{Branch, Jump, RegWr, MemWr} = 4'b0100;
				end
		endcase
endmodule
