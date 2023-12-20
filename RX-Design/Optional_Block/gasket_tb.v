// 500 MHz = 2 ns (byte -->    8 bits)
// 250 MHz = 4 ns (2 byte --> 16 bits)
// 125 MHz = 8 ns (4 byte --> 32 bits)
module gasket_tb();
reg clk_to_get;
reg PCLK;
reg Rst_n;
reg[5:0] width;
reg[7:0] Data_in;
wire[31:0] Data_out;
integer i;
initial begin
	clk_to_get = 0;
	forever #2 clk_to_get = ~clk_to_get;
end

initial begin
	PCLK = 0;
	forever #1 PCLK = ~PCLK;
end

initial begin
	 Rst_n = 1'b1;
	 width = 6'd32;
    @(negedge clk_to_get);
    Rst_n = 1'b0;
    @(negedge clk_to_get);
    Rst_n = 1'b1;
    for (i = 0; i < 1000; i=i+1) begin
    	
    	Data_in = $random();
    	@(negedge clk_to_get);
    end
    repeat(2) @(negedge clk_to_get);
    $stop();
end

GasKet Dut(.*);

endmodule