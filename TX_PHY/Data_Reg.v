module Data_Reg #(parameter DataWidth = 8)
				(
					input wire pclk,
					input wire rst,
					input wire [DataWidth-1:0] data,
					output reg [DataWidth-1:0] out_data
				);

always @(posedge pclk or negedge rst) begin
	if(!rst) begin
		out_data <= {DataWidth{1'b0}};
	end else begin
		out_data <= data;
	end
end
endmodule