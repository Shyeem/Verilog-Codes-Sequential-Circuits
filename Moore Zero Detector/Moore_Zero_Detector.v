module Moore_Zero_Detector(input x_in,clock, reset,output [1:0] y_out);

reg [1: 0] state;

parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always @ ( posedge clock, negedge reset) 
	if (!reset) //if reset==0
		state <= S0;
	else 
	case (state)

	S0: if (x_in) state = S0; else state = S1;

	S1: if (x_in) state = S2; else state = S3;

	S2: if (x_in) state = S2; else state = S3;

	S3: if (x_in) state = S3; else state = S0;

	endcase

assign y_out = state;

endmodule

module Moore_Zero_Detector_tb;

wire [1:0] y_out;
reg x_in, clock, reset;

Moore_Zero_Detector dut(.*);

initial begin clock = 0; forever #5 clock = ~clock; end

initial begin
	reset = 0;
	x_in=0;
	#2 reset = 1;
	#8 x_in = 1;
	#20 x_in = 0;
	#10 x_in = 1;
	#10 x_in = 0;
	#2 x_in = 1;
	#2 x_in = 0;
	#26 x_in = 1;
	#7 reset = 0;
	#2 reset = 1;
	#11 x_in = 0;
end
initial begin
	#130 $finish ;
end
endmodule
