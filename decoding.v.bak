module decoding(op,func,RegWr,Branch,Jump,ExtOp,AluSrc,Aluctr,MemWr,MemtoReg,RegDst);
input [5:0] op,func;
output RegWr,Branch,Jump,ExtOp,AluSrc,MemWr,MemtoReg,RegDst;
output [2:0] Aluctr;
reg RegWr,Branch,Jump,ExtOp,AluSrc,MemWr,MemtoReg,RegDst;
reg [2:0] Aluctr;

always @(op)
	case(op)
	6'b000000:
	 begin
		{Branch,Jump,RegDst,AluSrc,MemtoReg,RegWr,MemWr}=7'b0010010;
		case(func)
			6'b100000:Aluctr=3'b001;
			6'b100010:Aluctr=3'b101;
			6'b100011:Aluctr=3'b100;
			6'b101010:Aluctr=3'b111;
			6'b101011:Aluctr=3'b110;
		endcase
	 end
	6'b001101:
	 begin
		{Branch,Jump,RegDst,AluSrc,MemtoReg,RegWr,MemWr,ExtOp}=8'b00010100;
		Aluctr=3'b010;
	 end
	6'b001001:
	 begin
		{Branch,Jump,RegDst,AluSrc,MemtoReg,RegWr,MemWr,ExtOp}=8'b00010101;
		Aluctr=3'b000;
	 end
	6'b100011:
	 begin
		{Branch,Jump,RegDst,AluSrc,MemtoReg,RegWr,MemWr,ExtOp}=8'b00011101;
		Aluctr=3'b000;
	 end
	6'b101011:
	 begin
		{Branch,Jump,AluSrc,RegWr,MemWr,ExtOp}=6'b001011;
		Aluctr=3'b000;
	 end
	6'b000100:
	 begin
		{Branch,Jump,AluSrc,RegWr,MemWr}=5'b10000;
		Aluctr=3'b100;
	 end
	6'b000010:
	 begin
		{Branch,Jump,RegWr,MemWr}=4'b0100;
	 end
	endcase
endmodule
	