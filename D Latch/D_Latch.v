module D_latch(data,en,q);

input data,en; 
output q;
reg q;
always @ ( en or data)
	
	if (~en) 
	begin 
		q <= 1'b0;
	end 

	else if (en) 
	begin
		q <= data;
	end

endmodule 

`timescale 1ns/1ps
module D_latch_tb;
reg data,en; 
wire q;

D_latch dut(.*);
	initial begin 
	data=0;en=0;
	#10 data=0; en=1;
	#10 data=1; en=1; 
	#10 data=1; en=1;
	#10 data=0; en=0;
	#10 data=1; en=0;
	#10 data=1; en=1; 
#70 $finish();
end
endmodule
