//
module PI_TB;
`timescale 1ps/1fs
// parameter N = 8;
parameter CLK_Period = 200;
reg clk_0,clk_90,clk_180,clk_270;
reg rst_n , UP_Quad ,DN_Quad;
reg [7:0] code;
wire PI_clk;
reg tst_clk;
reg out_clk;
// real ph_step  = 90/$pow(2,N);
// real deg_step = ph_step / 360;
// real t_step = deg_step * CLK_Period;
// realtime delay_  = 0;
//reg[5:0] KDPC;

// always begin
// 	#5 clk_90 = clk_0;
// 	#5 clk_180
// end
// int k=0;
// initial begin
// 	tst_clk = 0;
// 	forever begin
// 		#k tst_clk = ~tst_clk;
// 		k=k+10;
// 	end
// end
always begin 
#100 clk_0 = ~clk_0; //CLK_Period/2.0
end 
// fork
// 	begin
// 		clk_90 = 0;
// 		#5;
// 		forever #10 clk_90 =  ~clk_90;
// 	end
// 	begin
// 		clk_180 = 0;
// 		#10;
// 		forever #10 clk_180 =  ~clk_180;
// 	end
// 	begin
// 		clk_270 = 0;
// 		#15;
// 		forever #10 clk_270 =  ~clk_270;
// 	end
// join
integer i;
initial begin
	 #50 //CLK_Period/2.0
	 forever #100 clk_90 = ~clk_90;
end

initial begin
	 #100 //CLK_Period/2.0
	 forever #100 clk_180 = ~clk_180;
end
initial begin
	 #150 //3*CLK_Period/4.0
	 forever #100 clk_270 = ~clk_270;
end

// int j;
// initial begin
// 	out_clk = 0;
// 	forever begin 	
// 		delay_ = 0;		
// 		j = 1;
// 		for(int i = 0;i<N ; i++) begin
// 			delay_ = delay_ + ((code[i] * (t_step) * (j)));
// 			j = j*2;
// 		end
// 		#(delay_*50) out_clk = ~out_clk;
// 	end 
// end

initial begin
	clk_0 = 0;
	clk_90 = 0;
	clk_180 = 0;
	clk_270= 0;
	UP_Quad = 1'b0;
	DN_Quad = 1'b0;
	code = 8'b0000_0000;
	//KDPC = 6'b00_0000;
	rst_n = 1'b1;
	@(negedge clk_0);
	rst_n = 1'b0;
	@(negedge  clk_0);
	rst_n = 1'b1;
	// #2000;
	// code = 8'h0f;
	// #2000;
	// code = 8'hff;
	// #2000;
	for(i=0; i < 1030 ; i = i+1) begin
		@(negedge clk_0);
		code = code + 8'h01;
		if(code == 8'h00)
			code = 8'h03;
		
		//KDPC = KDPC + 6'b1;
		// if((i%255) == 0 && (i != 0)) begin
		// 	UP_Quad = 1'b1;
		// 	//@(negedge DUT.use_clk);
		// 	@(posedge DUT.use_clk);
		// 	UP_Quad = 1'b0;
		// end
		
	end
		$stop();
end
PI DUT(.*);


//////////////////////////////////

endmodule 
