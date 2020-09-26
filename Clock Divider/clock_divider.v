module clock_divider(clk_in,clk_out,reset,ratio);

input clk_in;
output reg clk_out;
input reset;
input [31:0]ratio;

reg [31:0] counter;
  
  always @ (posedge clk_in, negedge reset) 
    if(reset==0)begin //counter and clk resets
      counter<=32'd0;
      clk_out=0;
    end
    else //if reset=1
      	if (counter==ratio-1) begin
           clk_out<=0;
       	   counter<=32'd0;//reseting after 1 period
      	end
      	else 
           if(counter==(ratio/2)-1) begin
          	clk_out<=1;
          	counter<=counter+1;//new pulse after 
	   end 		          //few pulses of previous
       	   else
          	counter<=counter+1;//pulses are counted anyway
endmodule


module clock_divider_TB();
  reg clk_in, reset;
  reg [31:0]ratio;
  wire clk_out;
 
  clock_divider dut(.*);
  always #5 clk_in = ~clk_in;//100Mhz(10ns)

  initial begin
    ratio=32'd10;//10Mhz(100ns)
    clk_in=0; reset=0; #96;
    reset=1; 
    #1000;
    $stop;
  end
endmodule 
