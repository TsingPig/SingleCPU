module Adder(Cin,X,Y,Add_Carry,Add_Overflow,Add_Sign,Add_Result,Zero);
parameter k=32;
input [k-1:0] X,Y;
input Cin;
output reg [k-1:0]Add_Result;
output Add_Carry,Add_Overflow,Add_Sign,Zero;
reg Add_Carry;
assign Zero=~|Add_Result;
assign Add_Sign=Add_Result[31];
assign Add_Overflow=Add_Carry^Add_Result[k-1]^X[k-1]^Y[k-1];
always @(X or Y or Cin)
{Add_Carry,Add_Result}=X+Y+Cin;
endmodule