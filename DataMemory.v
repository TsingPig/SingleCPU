module DataMemory(DataIn,Clk,WrEn,Adr,DataOut);
 parameter n = 32;
 input Clk,WrEn;
 input [n-1:0]DataIn,Adr;
 output reg [n-1:0]DataOut;
 
 reg [7:0] memory [0:255]; //256 8-bit registers
 
 always @(negedge Clk) begin
 if(WrEn==1)begin
  {memory[Adr+3],memory[Adr+2],memory[Adr+1],memory[Adr]} <= DataIn;
  end
  end
 always @(Adr)begin
  DataOut<={memory[Adr+3],memory[Adr+2],memory[Adr+1],memory[Adr]};
  end
  
endmodule
