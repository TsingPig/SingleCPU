module Reg(Clk, busW, RegWr, Rw, Ra, Rb, busA, busB);//run
	parameter n = 32;
	input Clk, RegWr;//, run
	input [n-1:0] busW;
	input [4:0] Rw, Ra, Rb;
	output reg [n-1:0] busA, busB;
	reg [n-1:0] regs[31:0];
	integer i;


		initial 
		begin
		regs[0]=32'h00000000;
		regs[1]=32'h00000012;//18
		regs[2]=32'h00000024;//36
		regs[3]=32'h00000102;//258
		regs[4]=32'h00000063;//99
		for(i=5;i<32;i=i+1)
		regs[i]=32'h0;
		end

		//always @(negedge Clk) begin
		//if (run == 1) begin
			//if (RegWr == 1)
			//regs[Rw] <= busW;
		//end
		//end
		always @(negedge Clk) begin
		if (RegWr == 1)
			regs[Rw] <= busW;
		end

		always @(Ra or Rb) begin
		busA <= regs[Ra];
		busB <= regs[Rb];
		end
endmodule
