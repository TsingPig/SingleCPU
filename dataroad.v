module dataroad(clk,RegWr,Branch,Jump,ExtOp,AluSrc,Aluctr,MemWr,MemtoReg,RegDst,instruction
,busA,busB,AluB,AluF,busW,Datain,Dataout);//,run,busA
parameter n=32;
input clk,RegWr,Branch,Jump,ExtOp,AluSrc,MemWr,MemtoReg,RegDst;//,run
input[2:0] Aluctr;
output [n-1:0] instruction;
output [n-1:0] busA,busB,AluB,AluF,busW,Datain,Dataout;

wire[5:0] op,func;
wire[4:0] Rs,Rt,Rd;
wire[15:0] imm16;
wire[4:0] Rw,Ra,Rb;
wire[n-1:0] imm32;
wire  Zero,Overflow,Ve;

//instruction
fetchins fetch(clk,Zero,Branch,Jump,instruction);//,run
//module fetchins( Clk,Zero,Branch,Jump,inst);
assign op=instruction[31:26];
assign Rs=instruction[25:21];
assign Rt=instruction[20:16];
assign Rd=instruction[15:11];
assign func=instruction[5:0];
assign imm16=instruction[15:0];

//registers
MUX2to1 mux6(Rt,Rd,RegDst,Rw);//module MUX2to1(X,Y,ctr,Z);RegDst xuanzejichuqixieru 1 rd 0 rt
assign Ra=Rs;
assign Rb=Rt;
assign Ve=RegWr & ~Overflow;//buyichu qie kexieru
Reg regs(clk,busW,Ve,Rw,Ra,Rb,busA,busB);//,run
//module Reg(Clk, busW, RegWr, Rw, Ra, Rb, busA, busB,run);

//ALU
assign imm32={{16{imm16[15]&ExtOp}},imm16[15:0]};//imm sign extension
MUX2to1 mux7(busB,imm32,AluSrc,AluB);//0 busB 1 imm sign extension  B
alu alu1(busA,AluB,Aluctr,Zero,Overflow,AluF);
//module alu(A,B,ALUctr,Zero,Overflow,Result);

//data memory
assign Datain=busB;
DataMemory datamem(Datain,clk,MemWr,AluF,Dataout);
//module DataMemory(DataIn,Clk,WrEn,Adr,DataOut);
MUX2to1 mux8(AluF,Dataout,MemtoReg,busW);//dizhi huozhe cunchuqilideneirong

endmodule