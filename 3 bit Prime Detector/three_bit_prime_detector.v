//derived from table using logic//

module three_bit_prime_detector(a,Y);
  input [2:0]a;
  output Y;
	
	assign Y=(a[1]&~a[2])|(a[0]&a[2]);

endmodule

module three_bit_prime_detector_tb;

reg [2:0]a;
wire Y;

three_bit_prime_detector dut(.*); 

	initial begin 
	a=0;

	forever #5 a[0]=~a[0]; 
	end

	initial begin
	forever #10 a[1]=~a[1];
	end

	initial begin
	forever #20 a[2]=~a[2];
	end

	initial begin
	#50 $finish();
end
endmodule
