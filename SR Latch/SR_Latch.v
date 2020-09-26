module SR_latch(S, R,Q, Qn,);

   input  S,R;
   output reg Q,Qn;
always@(S,R)
   begin
   if(S)
	begin
	Q<=Q; 
	Qn<=~Q;
	end
   else 
	begin
	Q<=~Q; 
	Qn<=~Q;
	end
end
endmodule 

`timescale 1ns/1ps
module SR_latch_tb;
reg S,R;
wire Q,Qn;

SR_latch dut(.*);
	initial begin 
	S=0;R=0;
	#10 S=0; R=1;
	#10 S=0; R=0;
	#10 S=1; R=0;
	#10 S=0; R=0;
	#10 S=1; R=0;
	#10 S=1; R=1;
#70 $finish();
end
endmodule
