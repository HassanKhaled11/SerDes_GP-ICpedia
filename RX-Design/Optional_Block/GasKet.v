module GasKet(
				input 				clk_to_get,
				input 				PCLK,
				input 				Rst_n,
				input [5:0] 		width,
				input [7:0] 		Data_in,
				output reg [31:0]	Data_out
				);

reg[7:0] temp;
reg[31:0] data_out;
reg[2:0] count;

always @(posedge clk_to_get or negedge Rst_n) begin
	if(!Rst_n) begin 
		//temp <= 8'b0;
		count <= 3'b00;
	end 
	else if((width == 6'd8 && count == 2'b00) || (width == 6'd16 && count == 2'b01) || (width == 6'd32 && count == 2'b11)) begin
		count <= 3'b00;
	end
	else begin 
		//temp <= Data_in;
		count <= count + 1'b1;
	end 
end

always @(posedge clk_to_get or negedge Rst_n) begin
	if(!Rst_n) begin
		data_out <= 32'b0;
	end else begin
		case (count)
			2'b00 : data_out[7:0]   <= Data_in;
			2'b01 : data_out[15:8]  <= Data_in;
			2'b10 : data_out[23:16] <= Data_in;
			2'b11 : data_out[31:24] <= Data_in;
 		endcase
	end
end

// always @(posedge clk_to_get or negedge Rst_n) begin
// 	if(!Rst_n) begin
// 		data_out <= 32'b0;
// 		count	 <= 2'b00;
// 	end else begin
// 		case (width)
// 			6'd8  : begin data_out[7:0]   <= temp; count <= count + 1'b1 end 
// 			6'd16 : begin data_out[15:8]  <= temp; count <= count + 1'b1 end 
// 			6'd32 : begin data_out[31:24] <= temp; count <= count + 1'b1 end 
//  		endcase
// 	end
// end

always @(posedge PCLK or negedge Rst_n) begin
	if(!Rst_n)
		Data_out <= 32'b0;
	else
		Data_out <= data_out;
end

endmodule