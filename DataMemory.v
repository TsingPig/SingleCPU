module DataMemory(
	input [31:0] DataIn,
	input Clk,
	input WrEn,
	input [7:0] Adr,
	output reg [31:0] DataOut
);

	reg [31:0] memory [0:255];

	always @(negedge Clk) begin
		if(WrEn) begin
			memory[Adr] <= DataIn;
		end
	end

	always @(posedge Clk or posedge WrEn) begin
		DataOut <= memory[Adr];
	end

endmodule
