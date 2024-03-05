`timescale 1ns/1fs
module CDR_Loop (
	input rst_n,  // Asynchronous reset active low
	// input clk_0,
	// input clk_90,
	// input clk_180,
	// input clk_270,
	input Din,
	output PI_Clk,
	output Dout
);
// wire PI_clk;
wire up,dn;
wire [10:0] code;
BBPD phaseDetector (
					.Din  (Din),
					.clk  (PI_Clk),
					.rst_n(rst_n),
					.Up   (up),
					.Dn   (dn),
					.A(Dout)
					);
Digital_Loop_Filter DLF(
						.clk  (PI_Clk),
						.rst_n(rst_n),
						.Dn   (dn),
						.Up   (up),
						.code (code)
						);

PMIX phase_interpolator(
						.Code   (code),
						.CLK_Out(PI_Clk)
						);

// PI phase_interpolator(
// 						.rst_n  (rst_n),
// 						.code   (code),
// 						.clk_0  (clk_0),
// 						.clk_90 (clk_90),
// 						.clk_180(clk_180),
// 						.clk_270(clk_270),
// 						.PI_clk (PI_Clk)
// 						);

endmodule 