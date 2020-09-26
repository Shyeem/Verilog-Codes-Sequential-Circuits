module shift_register_8b(Din,PL,clk,D);

    input [7:0] Din; //data-in
    input PL;//parallel load
    input clk;
    output reg [7:0] D;    
      
  always @ (negedge clk, negedge PL) begin
    if (PL==0) 
      D<=Din;
    else begin //will work when PL=1
      D[0] <= 0;
      D[1] <= D[0];
      D[2] <= D[1];
      D[3] <= D[2];
      D[4] <= D[3];
      D[5] <= D[4];
      D[6] <= D[5];
      D[7] <= D[6];
    end
  end
endmodule

module shift_register_8b_TB();
  reg clk, PL; 
  reg [7:0] Din;
  wire [7:0] D;

shift_register_8b dut(.*);
  
always  #5 clk = ~clk;

initial begin
PL=0; clk=0; Din=8'b01100101;
	#5 PL=1;
	#100 $finish();

  end
endmodule
