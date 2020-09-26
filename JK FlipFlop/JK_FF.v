module JK_FF(q,q1,j,k,clk);
input j,k,clk;
output q,q1;
reg q,q1;

initial begin q=1'b0; q1=1'b1; end

always @ (posedge clk)
  begin
	case({j,k})
	{1'b0,1'b0}:begin q=q; q1=q1; end//no change
	{1'b0,1'b1}: begin q=1'b0; q1=1'b1; end//reset
	{1'b1,1'b0}:begin q=1'b1; q1=1'b0; end//set
	{1'b1,1'b1}: begin q=~q; q1=~q1; end//inverse
	endcase
   end
endmodule

`timescale 1ns/1ps
module JK_FF_tb;
reg j,k,clk; 
wire q,q1;

JK_FF dut(.*);
initial begin 
j=0;k=0;clk=0;
	forever #10 clk=~clk; 
end
initial begin
	forever #20 j=~j; 
end
initial begin
	forever #40 k=~k; 
end
initial begin 
	#200 $finish();
end
endmodule

