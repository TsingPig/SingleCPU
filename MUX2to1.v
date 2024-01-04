module MUX2to1(X,Y,ctr,Z);
parameter k=32;
input [k-1:0] X,Y;
output reg [k-1:0] Z;
input ctr;
always @(X or Y or ctr)
if(!ctr) Z<=X;
else Z<=Y;
endmodule