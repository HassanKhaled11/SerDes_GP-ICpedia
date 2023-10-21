`timescale 1ps/1ps
module PLL_TB();
reg Ref_Clk , rst ;
reg[7:0] ratio;
wire clk5G, divided_clk;


initial begin
	Ref_Clk = 0;
	forever #5000 Ref_Clk = ~ Ref_Clk;
end 

initial begin
rst = 1;
ratio = 8'b0001_0100;
@(negedge Ref_Clk)
rst = 0;
@(negedge Ref_Clk)
rst = 1;
end
initial begin
	#200000;
	$stop();
end
PLL DUT(
		.Ref_Clk  (Ref_Clk),
		.rst      (rst),
		.CLK      (clk5G),
		.div_ratio(ratio),
		.PCLK     (divided_clk)
		);
endmodule 