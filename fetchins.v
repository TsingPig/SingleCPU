module fetchins(Clk, Zero, Branch, Jump, inst);
// 取指部件 = 指令存储器 + PC + 下地址逻辑
// 输入：时钟信号Clk，零标志位Zero，分支标志位Branch，跳转标志位Jump
// 输出：指令inst，并计算下地址逻辑，将PC+1，或者跳转到指定地址

	input wire Clk, Zero, Branch, Jump;

	output reg [31:0] inst;

	reg [15:0] imm16;
	reg [29:0] next_addr;
	reg [29:0] pc = 30'h0;
	reg [31:0] addr;
	reg [25:0] target;
	reg [31:0] inst_mem [1023:0];
		
	initial begin  //初始化指令存储器
			inst_mem[0] <= {6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b100000};
			//add $3, $1, $2 00221820
			
			inst_mem[4] <= {6'b000000, 5'b00011, 5'b00001, 5'b00100, 5'b00000, 6'b100010};
			//sub 4,3,1   00612022
			
			inst_mem[8] <= {6'b000000,5'b00001,5'b00010,5'b00011,5'b00000,6'b101010};
			//slt 3,1,2   0022182a
			
			inst_mem[12] <={6'b000100,5'b00001,5'b00010,5'b00000,5'b00000,6'b000001};
			//beq 1,2, 1  10220001
			
			inst_mem[16]<={6'b100011,5'b00001,5'b00100,5'b00000,5'b00000,6'b000101};
			//lw $4,$1,5  8c240005
			
			inst_mem[20]<=32'b00000000100000110011000000100010;//00833022  
			//regs[0]=32'h00000000;
			//regs[1]=32'h00000012;//18
			//regs[2]=32'h00000024;//36
			//regs[3]=32'h00000102;//258
			//regs[4]=32'h00000063;//99
			//for(i=5;i<32;i=i+1)
				//regs[i]=32'h0;
			//end
	end


	always @(*) begin
		addr = {pc[29:0], 2'b00};
		inst = inst_mem[addr];
		imm16 = inst[15:0];
		target = inst[25:0];
			
		if (Jump)                                       // 无条件转移
			next_addr = {pc[29:26], target};
		else if (Branch & Zero)                         // 条件转移
			next_addr = pc + 1 + {{14{imm16[15]}}, imm16};
		else                                            // 顺序执行
			next_addr= pc+ 1;
	end


	always @(negedge Clk) begin // 更新 PC
		pc <= next_addr;
	end

endmodule
