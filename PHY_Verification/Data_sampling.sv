module Data_sampling #(parameter Threshold = 0.5)(
	input  real data_in,
	output reg Data_out
);

always @(*) begin
	if(data_in >= Threshold) Data_out = 1'b1;
	else Data_out = 1'b0;
end

endmodule 