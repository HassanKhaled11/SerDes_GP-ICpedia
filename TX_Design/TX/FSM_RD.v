module FSM_RD(
	            input wire enable,
				input wire [3:0] TXDataK ,	            
				input wire[9:0] data_neg,
				input wire[9:0] data_pos,
				input Bit_Rate_10,
				input Rst,
				output reg[9:0] Data_10,
				output reg enable_PMA
				);

localparam RD_neg = 1'b0,
		   RD_pos = 1'b1;

reg current_state , next_state , pos_flag;

always @(posedge Bit_Rate_10 , negedge Rst) begin

	if(!Rst) begin 

		if(pos_flag)
			current_state <= RD_pos; 
		else 
			current_state <= RD_neg;
	end 


	else if (!enable) begin

		if(pos_flag)
			current_state <= RD_pos; 
		
		else 
			current_state <= RD_neg;		
		
	end
	
	else 
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
	enable_PMA = 1'b1;

	case (current_state)
		RD_neg : begin 
			Data_10 = data_neg;
			pos_flag = 1'b1;
		end    
		RD_pos : begin 
			Data_10 = data_pos;
			pos_flag = 1'b0;
		end 
		default : Data_10 = data_neg;
	endcase
end

endmodule 
