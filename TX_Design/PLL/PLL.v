module PLL(
			input Ref_Clk,
			input rst,
			input [7:0]div_ratio,
			output CLK,
			output PCLK
			);
freq_mul frquency_multiplier(
							.Ref_Clk(Ref_Clk),
							.CLK(CLK) // 5G
							);

Clock_Div clock_divider(
						.Ref_Clk(CLK), // 5G
						.rst(rst),
						.div_ratio(div_ratio),
						.pclk(PCLK)
						);
endmodule