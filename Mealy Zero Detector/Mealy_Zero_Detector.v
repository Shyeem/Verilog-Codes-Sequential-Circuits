module Mealy_Zero_Detector (input x_in,clock, reset,output reg y_out);

reg [1: 0] state, next_state;

parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always @ ( posedge clock, negedge reset) 
	if (!reset) //if reset==0
		state <= S0;
	else 
		state <= next_state;
always @ (state, x_in) //the next state //activated when "state" gets a value 
	case (state)

	S0: if (x_in) next_state = S1; else next_state = S0;

	S1: if (x_in) next_state = S3; else next_state = S0;

	S2: if (x_in) next_state = S2; else next_state = S0;

	S3: if (x_in) next_state = S2; else next_state = S0;

	endcase

always @ (state, x_in) // For the  output
	case (state)

	S0: y_out = 0;

	S1, S2, S3: y_out = ~x_in;
	endcase
endmodule

module Mealy_Zero_Detector_tb;

wire y_out;
reg x_in, clock, reset;

Mealy_Zero_Detector dut(.*);

initial begin clock = 0; forever #5 clock = ~clock; end

initial begin
	reset = 0;
	x_in=0;
	repeat(2)@(posedge clock);
	reset=1;
	@(posedge clock);
	x_in=1;
	@(posedge clock);
	x_in=0;
	@(posedge clock);
	@(posedge clock);
	x_in=1;
	@(posedge clock);
	@(posedge clock);
	x_in=0;
	@(posedge clock);
	x_in=1;
	@(posedge clock);
	x_in=0;
	@(posedge clock);
	@(posedge clock);
	x_in=1;
	@(posedge clock);
	x_in=0;
	reset=0; //so the last zero will not be detected

	#150 $finish ;
end
endmodule
