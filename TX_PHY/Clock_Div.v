module Clock_Div #(parameter WIDTH = 8)
				(
					input clk,
					input rst,
					input [WIDTH-1:0] div_ratio,
					output reg pclk,
					output  ref_clk
				);

wire [WIDTH-2:0] half;
reg[WIDTH-2:0] count;

always @(posedge clk or negedge rst) begin
	if(!rst) begin
		pclk <= 1'b0;
		ref_clk <= 1'b0;
		count <= 'b1;//{WIDTH-2{1'b0}};
	end
	else if(count == half) begin 
		pclk <= ~pclk;
		count <= 'b1;
	end else begin
		count <= count + 1'b1;
	end
end

assign half = (div_ratio >> 1);
assign ref_clk = clk; // for usb & as improvement we can get indication signal from controller to detect usb / pcie
endmodule 