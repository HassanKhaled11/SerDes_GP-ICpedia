module FSM_RD(
				input wire[7:0] data_neg,
				input wire[7:0] data_pos,
				input Bit_Rate_10,
				output reg[9:0] Data_10
				);

localparam RD_neg = 1'b0,
		   RD_pos = 1'b1;
reg current_state , next_state;
always @(posedge Bit_Rate_10) begin
	current_state <= next_state;
end

always @(*) begin
	case (current_state)
		RD_neg : next_state = RD_pos;
		RD_pos : next_state = RD_neg;
		default : next_state = RD_neg;
	endcase
end

always @(*) begin
	case (current_state)
		RD_neg : Data_10 = data_neg;
		RD_pos : Data_10 = data_pos;
		default : Data_10 = data_neg;
	endcase
end

endmodule 