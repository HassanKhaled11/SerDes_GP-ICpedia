`timescale 1ps/1ps
module PLL_TB();
reg Ref_Clk , rst ;

wire clk5G, divided_clk, Bit_Rate_CLK_10;


initial begin
	Ref_Clk = 0;
	forever #5000 Ref_Clk = ~ Ref_Clk;
end 

initial begin
rst = 1;
#2;
rst = 0;
#2;
rst = 1;
end
initial begin
	#200000;
	$stop();
end
PLL DUT(
		.Ref_Clk  (Ref_Clk),
		.Rst      (rst),
		.Bit_Rate_Clk      (clk5G),
		.Bit_Rate_CLK_10(Bit_Rate_CLK_10),
		.PCLK     (divided_clk)
		);
endmodule 