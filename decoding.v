module decoding(op, func, RegWr, Branch, Jump, ExtOp, AluSrc, Aluctr, MemWr, MemtoReg, RegDst);
// 模块声明，接收输入操作码op和功能码func，输出一系列控制信号
// 输入：6位的操作码op和功能码func
// 输出：控制信号RegWr, Branch, Jump, ExtOp, AluSrc, MemWr, MemtoReg, RegDst, Aluctr

	input [5:0] op, func;  

	output reg RegWr, Branch, Jump, ExtOp, AluSrc, MemWr, MemtoReg, RegDst;  
	output reg [2:0] Aluctr;  // 输出3位ALU控制信号

	// reg RegWr, Branch, Jump, ExtOp, AluSrc, MemWr, MemtoReg, RegDst;  // 寄存器类型的控制信号
	// reg [2:0] Aluctr;  // 3位ALU控制信号寄存器

	always @(op)
	// 当输入操作码op发生变化时执行
		case(op)
			6'b000000:  // 操作码为6'b000000时，R型指令
				begin
					{Branch, Jump, RegDst, AluSrc, MemtoReg, RegWr, MemWr} = 7'b0010010;  // 设置多个控制信号
					case(func)
						6'b100000: Aluctr = 3'b001;		// add
						6'b100010: Aluctr = 3'b101;		// sub
						6'b100011: Aluctr = 3'b100;		// subu
						6'b101010: Aluctr = 3'b111;		// slt
						6'b101011: Aluctr = 3'b110;		// sltu
					endcase
				end
			// 剩下指令只和op字段有关
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
