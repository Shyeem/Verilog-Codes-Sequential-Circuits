module tff (q,t,clk,reset);
input t,clk,reset;
output q;
reg q;
always @ ( posedge clk, negedge reset)
if (reset == 0) q <= 1'b0;
else if (t) q <= ~q;
endmodule

module three_bit_tff(A,t,clk,reset);
input clk,reset;
output [2:0] A;
output [2:0]t;
assign t[0]=3'b001;
wire D;

tff tff0 (A[0],t[0], clk, reset);
tff tff1 (A[1],A[0], clk, reset);
and (D,A[1],A[0]);
tff tff2 (A[2],D, clk, reset);
endmodule

module three_bit_tff_tb;
wire [2:0] A,t;
reg clk,reset;
three_bit_tff dut(.*);

initial #200 $finish ;
initial begin
reset = 0;clk = 0;
#5 reset = 1;
repeat (32)#5 clk = ~clk;
end
endmodule
