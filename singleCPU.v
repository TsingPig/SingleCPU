module singleCPU(clk, I, busA, busB, AluB, AluF, busW, Datain, Dataout);
	parameter n = 32;
	input clk;
	output [n-1:0] I, busA, busB, AluB, AluF, busW, Datain, Dataout;
	
	wire RegWr, Branch, Jump, ExtOp, AluSrc, MemWr, MemtoReg, RegDst;
	wire [2:0] ALUctr;
	wire[5:0] op, func;
	dataroad dataroadbj(clk, RegWr, Branch, Jump, ExtOp, AluSrc, ALUctr, MemWr, MemtoReg, RegDst, 
	I, busA, busB, AluB, AluF, busW, Datain, Dataout);

	assign op = I[31:26];	// op表示指令的前6位
	assign func = I[5:0];
	decoding qzbj(op, func, RegWr,Branch, Jump, ExtOp, AluSrc, ALUctr, MemWr, MemtoReg, RegDst);
endmodule