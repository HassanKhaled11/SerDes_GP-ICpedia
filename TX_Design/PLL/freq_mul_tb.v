`timescale 1ps/1ps
module freq_mul_tb();

reg RefClk ;
wire clk;

initial begin
	RefClk = 0;
	forever #5000 RefClk = ~ RefClk;
end 

initial begin
	#200000;
	$stop();
end

freq_mul DUT(
		.Ref_Clk(RefClk),
		.CLK(clk)
		);

endmodule