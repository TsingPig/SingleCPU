module alu(A,B,ALUctr,Zero,Overflow,Result);
// 输入：操作数A,操作数B,ALU控制信号
// 输出：结果,零标志,溢出标志

	input [31:0] A, B;
	input [2:0] ALUctr;

	output Zero, Overflow;
	output [31:0] Result;


	wire SUBctr, OVctr, SIGctr, SignA, SignB, Cin;
	wire [1:0] OPctr;
	wire [32-1:0] X, Y, Z, Less, M, N, Add_Result;
	wire Add_Carry, Add_Overflow, Add_Sign;

	assign M = {32{1'b0}};
	assign N = {31'b0, 1'b1}; 
	assign SUBctr = ALUctr[2];
	assign OVctr = !ALUctr[1] & ALUctr[0];
	assign SIGctr = ALUctr[0];
	assign OPctr[1] = ALUctr[2] & ALUctr[1];
	assign OPctr[0] = !ALUctr[2] & ALUctr[1] & !ALUctr[0];
	assign Cin = SUBctr;
	assign X = B ^ {32{SUBctr}};
	assign Y = A | B;
	assign SignA = Cin ^ Add_Carry;
	assign SignB = Add_Overflow ^ Add_Sign;
	assign Overflow = Add_Overflow & OVctr;

	Adder adder(Cin, A, X, Add_Carry, Add_Overflow, Add_Sign, Add_Result, Zero);

	MUX2to1 m1(SignA, SignB, SIGctr, Less);
	MUX2to1 m2(M, N, Less, Z);
	MUX3to1 m3(Add_Result, Y, Z, Result, OPctr);
endmodule