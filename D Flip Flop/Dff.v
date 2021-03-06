module Dff(Clk,D,reset,enable,Q);
input Clk,D,reset,enable;
output reg Q;
always@(posedge Clk)
	begin
	if (reset)
		Q=0;
	else if (enable)
		Q=D;
	end
endmodule

`timescale 1ns/1ps
module Dff_tb;
reg Clk,D,reset,enable; 
wire Q;

Dff dut(.*);
initial begin 
D=0;Clk=0;reset=0;enable=0;
	forever #5 Clk=~Clk; 
		end
	initial begin 

	#10 D=1;reset=0;enable=0; 
	#10 enable=1; 
	#10 reset=1;       

	 end
initial begin
	#50 $finish();
end
endmodule

