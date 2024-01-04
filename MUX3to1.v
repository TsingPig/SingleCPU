module MUX3to1(A,B,C,D,ctr);
parameter k=32;
input [k-1:0] A,B,C;
output reg [k-1:0] D;
input [1:0]ctr;
always @(A or B or C or ctr)
if(ctr==2'b00) D=A;
else if(ctr==2'b01) D=B;
else if(ctr==2'b10) D=C;
endmodule