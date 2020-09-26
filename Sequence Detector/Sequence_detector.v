module Sequence_detector(x,y,clk,reset);
input x,clk,reset;
output reg y;
reg [1: 0] state;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
always @ ( posedge clk, negedge reset)
	if (reset == 0) state <= S0; // Initialize to state S0
	else case (state)
		S0: if (x) state <= S1; else state <= S0;
		S1: if (x) state <= S2; else state <= S1;
		S2: if (x) state <= S3; else state <= S2;
		S3: if (x) state <= S3; else state <= S0;
endcase
always @ (state, x) // For the  output
	case (state)
	S0, S1, S2 : y=0;
	S3: y=1;//detects the 11 only 
	endcase
endmodule


module Sequence_detector_tb;
reg x,clk,reset;
wire y;

Sequence_detector dut(.*);
initial begin
x=0;reset = 0;clk = 0;
#5 reset = 1;
forever #5 clk=~clk; 
end
initial begin
	forever #10 x=~x; 
end

initial begin 
	#200 $finish();
end
endmodule
