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
	
	forever #((second - first) / 100) CLK =  ~ CLK;//#((first - second) / 100)
end

//always #(2) CLK =  ~ CLK;//(first -second) /50
// wire delay_ref_clk;
// assign delay_ref_clk = (second -first) /100;
// buf(delay_ref_clk, Ref_Clk); // this delay used to create new clock pulses
// xor(CLK, delay_ref_clk, Ref_Clk);
endmodule