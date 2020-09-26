module three_b_bc (output y_out,input x_in, clock, reset);
reg [2: 0] state;
parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011,S4 = 3'b100, S5 = 3'b101, S6 = 3'b110, S7 = 3'b111;
always @ ( posedge clock, negedge reset)
if (reset == 0) state <= S0; 
else case (state)
S0: if (x_in) state <= S1; 
S1: if (x_in) state <= S2; 
S2: if (x_in) state <= S3;
S3: if (x_in) state <= S4;
S4: if (x_in) state <= S5;
S5: if (x_in) state <= S6;
S6: if (x_in) state <= S7; 
S7: if (x_in) state <= S0; 
endcase
assign y_out = state;

endmodule

module three_b_bc_tb;
wire y_out;
reg x_in, clock, reset;
three_b_bc dut(.*);
initial #200 $finish ;
initial begin
reset = 0;
clock = 0;
#5 reset = 1;
repeat (32)
#5 clock = ~clock;
end
initial begin
x_in = 0;
#15 x_in = 1;
repeat (16)
#10 x_in = ~x_in;
end
endmodule
