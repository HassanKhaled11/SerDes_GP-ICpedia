module Clock_Div #(parameter WIDTH = 8)
				(
					input Ref_Clk,
					input rst,
					input [WIDTH-1:0] div_ratio,
					output reg divided_clk
					
				);

wire [WIDTH-2:0] half ;
reg  [WIDTH-2:0] count;

always @(posedge Ref_Clk or negedge rst) begin
	if(!rst) begin
		divided_clk <= 1'b1;
		count <= 'b1;//{WIDTH-2{1'b0}};
	end
	else if(count == half) begin 
		divided_clk <= ~divided_clk;
		count <= 'b1;
	end else begin
		count <= count + 1'b1;
	end
end

assign half = (div_ratio >> 1);

endmodule 