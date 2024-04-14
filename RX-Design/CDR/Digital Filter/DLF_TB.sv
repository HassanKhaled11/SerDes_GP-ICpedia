module DLF_tb;

reg up,dn,clk,rst_n;
wire[10:0] code;

DLF DUT(.*);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin
	rst_n = 1;
	@(negedge clk);
	rst_n = 0;
	@(negedge clk);
	rst_n = 1;
	for(int i=0;i<600000;i++) begin
		@(negedge clk);
		up = i%2;
		// dn = (i+1)%2;

		
	end
	#20;
	$stop();
end

endmodule 