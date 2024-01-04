module Reg(Clk, RegWr, busW, Rw, Ra, Rb, busA, busB);
// 输入：时钟信号,寄存器写使能信号,寄存器写入索引,读取索引A,读取索引B,写入数据
// 输出：输出A,输出B

	input Clk, RegWr, Rw, Ra, Rb, busW;

	output reg [31:0] busA, busB;

	//parameter n = 32; // 寄存器位宽

	reg [31:0] regs[31:0]; // 32个32位寄存器的数组

	integer i;

	initial begin
		// 初始化寄存器数组的前几个元素
		regs[0] = 32'h00000000;
		regs[1] = 32'h00000012; // 18
		regs[2] = 32'h00000024; // 36
		regs[3] = 32'h00000102; // 258
		regs[4] = 32'h00000063; // 99
		// 将其余元素初始化为0
		for (i = 5; i < 32; i = i + 1) regs[i] = 32'h0;
	end

	// 写使能信号有效时，写入数据写入指定寄存器
	always @(negedge Clk) begin
		if (RegWr == 1) regs[Rw] <= busW;
	end

	// 当读取寄存器A或B的索引发生变化时，从寄存器数组中读取相应的数据并放入总线输出
	always @(Ra or Rb) begin
		busA <= regs[Ra];
		busB <= regs[Rb];
	end
endmodule
