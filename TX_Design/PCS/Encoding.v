module Encoding(
				input wire[7:0] data,
				input wire enable,
				input wire Bit_Rate_10,
				input wire Rst,
				input wire TXDataK ,
				output enable_PMA,
				output wire[9:0] data_out
				);

wire[9:0] encoded_pos_data , encoded_neg_data;


line_coding_8_10 u0(
	        .TXDataK(TXDataK),
			.enable(enable),
			.data(data),
			.encoded_data_pos(encoded_pos_data),
			.encoded_data_neg(encoded_neg_data)
			 );


FSM_RD u1(
	        .TXDataK(TXDataK),	
	        .enable(enable),
			.Bit_Rate_10(Bit_Rate_10),
			.Rst(Rst),
			.data_neg(encoded_neg_data),
			.data_pos(encoded_pos_data),
			.Data_10    (data_out),
			.enable_PMA(enable_PMA)
			);

endmodule 