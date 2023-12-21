module Serial_to_Parallel(

							input Recovered_Bit_Clk,

							input Ser_in,

							input Rst_n,

							input RxPolarity,

							output K285,

							output reg[9:0] Data_to_Decoder

							);

reg[3:0] count;

reg[9:0] collect_register;

always @(posedge Recovered_Bit_Clk or negedge Rst_n) begin 

	if(~Rst_n) begin

		collect_register <= 10'b0;

	end

	else if(RxPolarity) begin // rx polarity = 1 --> invert the serial bit before registering it

		collect_register[count] <= ~Ser_in;

	end else begin   // rx polarity = 0 --> pass the serial bit as it

		collect_register[count] <= Ser_in;

	end

end



always @(posedge Recovered_Bit_Clk or negedge Rst_n) begin 

	if(~Rst_n) begin

		count <= 4'b0;

	end

	else if(count == 4'b1010) begin

		Data_to_Decoder <= collect_register;

	end

	else begin

		count <= count + 1'b1;

	end

end





//assign Data_to_Decoder = (count == 3'b111) ? collect_register : 10'b0;

assign K285 = (collect_register == 10'b00_1111_1010 || collect_register == 10'b11_0000_0101) ? 1'b1 : 1'b0;

endmodule 