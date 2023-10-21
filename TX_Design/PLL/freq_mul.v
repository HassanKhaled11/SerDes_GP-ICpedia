`timescale 1ps/1ps
module freq_mul(
			input Ref_Clk,
			//input RST,
			output reg CLK
			);

integer first , second;
// reg[3:0] first , second;
initial begin
	CLK = 0;
	@(posedge Ref_Clk);
	first = $time();
	$display(first);
	@(posedge Ref_Clk);
	second = $time();
	$display(first);
	$display(second);
	
	forever #((second - first) / 100) CLK =  ~ CLK;
end


endmodule
