module line_coding_8_10 #(parameter DATAWIDTH = 8)
						(
							input wire pclk,
							input wire rst,
							input wire[DATAWIDTH-1:0] data,
							output reg[DATAWIDTH+1:0] encoded_data_pos,
							output reg[DATAWIDTH+1:0] encoded_data_neg
						);

always @(posedge pclk or negedge rst) begin
	if(!rst) begin
		encoded_data <= {DATAWIDTH+1{1'b0}};
	end else begin
		case(data)
			//////////// D0.0 --> D31.0
			8'b0000_0000 : begin
				encoded_data_neg <= 10'b100111_0100;
				encoded_data_pos <= 10'b011000_1011;
			end
			8'b0000_0001 : begin
				encoded_data_neg <= 10'b011101_0100;
				encoded_data_pos <= 10'b100010_1011;
			end
			8'b0000_0010 : begin
				encoded_data_neg <= 10'b101101_0100;
				encoded_data_pos <= 10'b010010 1011;
			end
			8'b0000_0011 : begin
				encoded_data_neg <= 10'b110001_1011;
				encoded_data_pos <= 10'b110001_0100;
			end
			8'b0000_0100 : begin
				encoded_data_neg <= 10'b110101_0100;
				encoded_data_pos <= 10'b001010_1011;
			end
			8'b0000_0101 : begin
				encoded_data_neg <= 10'b101001_1011;
				encoded_data_pos <= 10'b101001_0100;
			end
			8'b0000_0110 : begin
				encoded_data_neg <= 10'b011001_1011;
				encoded_data_pos <= 10'b011001_0100;
			end 
			8'b0000_0111 : begin
				encoded_data_neg <= 10'b111000_1011;
				encoded_data_pos <= 10'b000111_0100;
			end
			8'b0000_1000 : begin
				encoded_data_neg <= 10'b111001_0100;
				encoded_data_pos <= 10'b000110_1011;
			end
			8'b0000_1001 : begin
				encoded_data_neg <= 10'b100101_1011;
				encoded_data_pos <= 10'b100101_0100;
			end
			8'b0000_1010 : begin
				encoded_data_neg <= 10'b010101_1011;
				encoded_data_pos <= 10'b010101_0100;
			end
			8'b0000_1011 : begin
				encoded_data_neg <= 10'b110100_1011;
				encoded_data_pos <= 10'b110100_0100;
			end
			8'b0000_1100 : begin
				encoded_data_neg <= 10'b001101_1011;
				encoded_data_pos <= 10'b001101_0100;
			end
			8'b0000_1101 : begin
				encoded_data_neg <= 10'b101100_1011;
				encoded_data_pos <= 10'b101100_0100;
			end
			8'b0000_1110 : begin
				encoded_data_neg <= 10'b011100_1011;
				encoded_data_pos <= 10'b011100_0100;
			end
			8'b0000_1111 : begin
				encoded_data_neg <= 10'b010111_0100;
				encoded_data_pos <= 10'b101000_1011;
			end
			8'b0001_0000 : begin
				encoded_data_neg <= 10'b011011_0100;
				encoded_data_pos <= 10'b100100_1011;
			end
			8'b0001_0001 : begin
				encoded_data_neg <= 10'b100011_1011;
				encoded_data_pos <= 10'b100011_0100;
			end
			8'b0001_0010 : begin
				encoded_data_neg <= 10'b010011_1011;
				encoded_data_pos <= 10'b010011_0100;
			end
			8'b0001_0011 : begin
				encoded_data_neg <= 10'b110010_1011;
				encoded_data_pos <= 10'b110010_0100;
			end
			8'b0001_0100 : begin
				encoded_data_neg <= 10'b001011_1011;
				encoded_data_pos <= 10'b001011_0100;
			end
			8'b0001_0101 : begin
				encoded_data_neg <= 10'b101010_1011;
				encoded_data_pos <= 10'b101010_0100;
			end
			8'b0001_0110 : begin
				encoded_data_neg <= 10'b011010_1011;
				encoded_data_pos <= 10'b011010_0100;
			end
			8'b0001_0111 : begin
				encoded_data_neg <= 10'b111010_0100;
				encoded_data_pos <= 10'b000101_1011;
			end
			8'b0001_1000 : begin
				encoded_data_neg <= 10'b110011_0100;
				encoded_data_pos <= 10'b001100_1011;
			end
			8'b0001_1001 : begin
				encoded_data_neg <= 10'b100110_1011;
				encoded_data_pos <= 10'b100110_0100;
			end
			8'b0001_1010 : begin
				encoded_data_neg <= 10'b010110_1011;
				encoded_data_pos <= 10'b010110_0100;
			end
			8'b0001_1011 : begin
				encoded_data_neg <= 10'b110110_0100;
				encoded_data_pos <= 10'b001001_1011;
			end
			8'b0001_1100 : begin
				encoded_data_neg <= 10'b001110_1011;
				encoded_data_pos <= 10'b001110_0100;
			end
			8'b0001_1101 : begin
				encoded_data_neg <= 10'b101110_0100;
				encoded_data_pos <= 10'b010001_1011;
			end
			8'b0001_1110 : begin
				encoded_data_neg <= 10'b011110_0100;
				encoded_data_pos <= 10'b100001_1011;
			end
			8'b0001_1111 : begin
				encoded_data_neg <= 10'b101011_0100;
				encoded_data_pos <= 10'b010100_1011;
			end
			//////////// D0.1 --> D31.1
		endcase
	end
end
endmodule 