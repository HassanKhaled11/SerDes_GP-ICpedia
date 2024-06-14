`timescale 1ns/1fs

module SSC_Generator(input clk , output reg jitterd_clk);

  import "DPI-C" function real calc_ssc_val(input int ppm,input int ssc_iteration);

  int ssc_iteration = 0;
  reg clk_ssc;
  real jitter_value;

   realtime t1,t2;
   realtime Jittered_clk_period;

   int PPM;


///////////////////////////////////////////////
///////////////////// DPI /////////////////////
///////////////////////////////////////////////

  initial  begin
  clk_ssc = 0;

  fork
  	 begin
  	 	forever begin
   		#(3.33/2.0) clk_ssc = ~clk_ssc;        //33.3 microsecond	TRIG PERIOD --->  33300/10000/2
      end
  	 end
 
  	 begin
  	 	forever begin
   		@(posedge clk_ssc) begin
   			  jitter_value = calc_ssc_val(5000,ssc_iteration);     // CALCULATIONS WITH DPI
           ssc_iteration = (ssc_iteration+1)%10000;
   		end
      end
  	 end
 
  join
 end 
  

///////////////////////////////////////////////
////////////////JITTERED CLK///////////////////
///////////////////////////////////////////////

initial begin
	jitterd_clk = 0;
	forever #((jitter_value+0.2)/2) jitterd_clk = ~jitterd_clk; 
end

////////////////////////////////////////////////
/////// JITTERED_CLK_PERIOD & PPM CALC /////////
////////////////////////////////////////////////

initial begin
	t1 =0 ; 
	t2 =0 ;
	Jittered_clk_period = 0;
	forever begin
		@(posedge jitterd_clk);
		t1 = $realtime();
		@(posedge jitterd_clk);
		t2 = $realtime();
    Jittered_clk_period = t2 - t1;
    PPM = int'(((5 - (1 / Jittered_clk_period)) / (5)) * (10 ** 6)); 
	end
end

///////////////////////////////////////////////
///////////////////////////////////////////////
///////////////////////////////////////////////


endmodule





module SSC_Generator_tb;

reg clk ;
wire jitterd_clk;


initial begin
	clk = 0;
	forever begin
		#0.1 clk = ~clk;
	end
end

SSC_Generator DUT(.*);


endmodule