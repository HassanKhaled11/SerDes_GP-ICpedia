module Serial_to_Parallel_TB;
reg Recovered_Bit_Clk;
reg Ser_in;
reg Rst_n;
reg RxPolarity;
wire K285;
wire[9:0] Data_to_Decoder;


reg[9:0] k285_;
integer i;

initial begin
	Recovered_Bit_Clk = 0;
	forever #2 Recovered_Bit_Clk = ~Recovered_Bit_Clk;
end

initial begin
	RxPolarity = 0;
	Rst_n = 1'b1;
	k285_ = 10'b00_1111_1010;
	Ser_in = 1'b0;
	@(negedge Recovered_Bit_Clk);
	Rst_n = 1'b0;
	@(negedge Recovered_Bit_Clk);
	Rst_n = 1'b1;
	for(i=0;i<100;i=i+1) begin
		@(negedge Recovered_Bit_Clk);
		Ser_in = $random();
	end
	repeat(2) @(negedge Recovered_Bit_Clk);
	//@(negedge Recovered_Bit_Clk);
	Rst_n = 1'b0;
	@(negedge Recovered_Bit_Clk);
	Rst_n = 1'b1;
	for(i=0;i<10;i=i+1) begin
		
		Ser_in = k285_[i];
		@(negedge Recovered_Bit_Clk);
	end
	#4;
	$stop();
end

Serial_to_Parallel DUT(.*);
endmodule 