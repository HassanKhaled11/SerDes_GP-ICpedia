`timescale 1ps/1ps
module Clock_Div_tb();
reg refclk , rst;

reg[7:0] ratio;
wire divided_clk;

initial begin
	refclk = 0;
	forever #100 refclk = ~ refclk;
end 

initial begin
rst = 1;
ratio = 8'b0001_0100;
@(negedge refclk)
rst = 0;
@(negedge refclk)
rst = 1;
#5000;
$stop();
end 

Clock_Div DUT(
				.Ref_Clk  (refclk),
				.rst      (rst),
				.div_ratio(ratio),
				.pclk     (divided_clk)
				);
endmodule