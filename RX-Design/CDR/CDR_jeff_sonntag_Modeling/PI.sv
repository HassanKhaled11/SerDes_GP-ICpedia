`timescale 1ps/1fs
module PI #(parameter N = 10 , parameter Period = 200) (
			input rst_n,
			input clk_0,
			input clk_90,
			input clk_180,
			input clk_270,
			//input [5:0]KDPC,
			input [N-1:0] code,
			output reg PI_clk
			);



real ph_step  = 90/$pow(2,N-2);
real deg_step = ph_step / 360;
real t_step = deg_step * Period;
realtime delay_  = 0;
real UI = 1/$pow(2,N-2);
int j,k;
real freq_ch;
reg use_clk;
// reg[1:0] Quad_Sel;

initial begin
	PI_clk = 0;
end
// always @(posedge clk_0 or negedge rst_n) begin
// 	if(!rst_n) begin
// 		Quad_Sel <= 2'b00;
// 	end else begin // for up , dn there is no priority for one over other so, if up,dn are high so no decision taken
// 		if(UP_Quad) begin
// 			Quad_Sel <= Quad_Sel + 1'b1;
// 		end
// 		if(DN_Quad) begin
// 			Quad_Sel <= Quad_Sel - 1'b1;
// 		end
// 	end
// end
// 90/256 = 0.3515625 , 100(Ts)/256 = 0.390625 , 100/360 = 0.278  0.09765625
always @(*) begin
	case(code[9:8])
		2'b00 : use_clk = clk_0;
		2'b01 : use_clk = clk_90;
		2'b10 : use_clk = clk_180;
		2'b11 : use_clk = clk_270;
	endcase 
end
//0.43402777777777777777777777777778

//////////////////////////////////////////////
//////////////////////////////////////////////
///////////// Frequency change ///////////////
//////////////////////////////////////////////
//////////////////////////////////////////////
// always begin

// 	// if(!rst_n) begin
// 	//  	PI_clk <= 1'b1;
// 	// end else begin 
// 		// #((code[0] * 0.22) + (code[1] * 0.43)  + (code[2] * 0.86) + (code[3] * 1.73) + (code[4] * 3.47) + (code[5] * 6.94) + (code[6] * 13.89) + (code[7] * 27.78)) ;//PI_clk <=  ~PI_clk;  
		
// 		delay_ = 0;		
// 		j = 1;
// 		for(int i = 0;i<(N-2) ; i++) begin
// 			delay_ = delay_ + ((code[i] * (t_step) * (j)));
// 			j = j*2;
// 		end		 
// 		#(100-delay_) PI_clk = ~PI_clk;	
// 	// end 
// end

//////////////////////////////////////////////
//////////////////////////////////////////////
///////////// realistic change ///////////////
//////////////////////////////////////////////
//////////////////////////////////////////////

// always begin

// 	// if(!rst_n) begin
// 	//  	PI_clk <= 1'b1;
// 	// end else begin 
// 		// #((code[0] * 0.22) + (code[1] * 0.43)  + (code[2] * 0.86) + (code[3] * 1.73) + (code[4] * 3.47) + (code[5] * 6.94) + (code[6] * 13.89) + (code[7] * 27.78)) ;//PI_clk <=  ~PI_clk;  
// 		delay_ = 0;		
// 		 j = 1;
// 		for(int i = 0;i<N ; i++) begin
// 			delay_ = delay_ + ((code[i] * (t_step) * (j)));
// 			j = j*2;
// 		end
		
// 		PI_clk = #(delay_ + 100) ~PI_clk;
		
// 	// end 
// end


//////////////////////////////////////////////
//////////////////////////////////////////////
///////////// Phase change ///////////////////
//////////////////////////////////////////////
//////////////////////////////////////////////


always @(posedge use_clk) begin

	// if(!rst_n) begin
	//  	PI_clk <= 1'b1;
	// end else begin 
		// #((code[0] * 0.22) + (code[1] * 0.43)  + (code[2] * 0.86) + (code[3] * 1.73) + (code[4] * 3.47) + (code[5] * 6.94) + (code[6] * 13.89) + (code[7] * 27.78)) ;//PI_clk <=  ~PI_clk;  
		delay_ = 0;		
		 j = 1;
		for(int i = 0;i<(N-2) ; i++) begin
			delay_ = delay_ + ((code[i] * (t_step) * (j)));
			j = j*2;
		end
		 #(delay_)
		PI_clk = use_clk;
		
	// end 
end

always @(negedge use_clk) begin

	// if(!rst_n) begin
	//  	PI_clk <= 1'b1;
	// end else begin 
		// #((code[0] * 0.22) + (code[1] * 0.43)  + (code[2] * 0.86) + (code[3] * 1.73) + (code[4] * 3.47) + (code[5] * 6.94) + (code[6] * 13.89) + (code[7] * 27.78)) ;//PI_clk <=  ~PI_clk;  
		delay_ = 0;
		k = 1;
		for(int i = 0;i<(N-2) ; i++) begin
			delay_ = delay_ + ((code[i] * (t_step) * (k)));
			k = k * 2;
		end
		#(delay_)
		PI_clk =  use_clk;
		
	// end 
end
real freq_def;
real positive_,negative_;
always @(posedge PI_clk or negedge rst_n) begin  
	if(!rst_n) begin
		negative_ = 0;
		positive_ = 0;
	end	else begin 
		positive_ = $realtime();
		@(posedge PI_clk);
		negative_ = $realtime();
	end 
end 

// always @(negedge PI_clk)
// 	negative_ = $realtime();

// assign freq_def = (negative_ - positive_);
always @(*) begin
	if(negative_ > positive_)
		freq_def = negative_ - positive_;
	else 
		freq_def = positive_ - negative_;
end
// always @(*) begin
// 	if(freq_def < 0)
// 		freq_ch = -1/freq_def;
// 	else 
// 		freq_ch = 1/freq_def;
// end
assign freq_ch =  1/freq_def ;




// always @(negedge use_clk) begin 
	
// 	PI_clk <= #((code[0] * 0.22) + (code[1] * 0.43)  + (code[2] * 0.86) + (code[3] * 1.73) + (code[4] * 3.47) + (code[5] * 6.94) + (code[6] * 13.89) + (code[7] * 27.78)) use_clk; 
// end


// CLK Period = 100
// always @(posedge use_clk) begin
	
// 	PI_clk <= #((code[7] * 12.5) + (code[0] * 0.097)  + (code[1] * 0.195) + (code[2] * 0.39) + (code[3] * 0.78) + (code[4] * 1.56) + (code[5] * 3.125) + (code[6] * 6.25)) use_clk; 
// end
// always @(negedge use_clk) begin 
	
// 	PI_clk <= #((code[7] * 12.5) + (code[0] * 0.097)  + (code[1] * 0.195) + (code[2] * 0.39) + (code[3] * 0.78) + (code[4] * 1.56) + (code[5] * 3.125) + (code[6] * 6.25)) use_clk; 
// end

// always @(posedge use_clk) begin
	
// 	PI_clk <= #((code[0] * 0.048) + (code[1] * 0.097)  + (code[2] * 0.195) + (code[3] * 0.39) + (code[4] * 0.78) + (code[5] * 1.56) + (code[6] * 3.125) + (code[7] * 6.25)) use_clk; 
// end
// always @(negedge use_clk) begin 
	
// 	PI_clk <= #((code[0] * 0.048) + (code[1] * 0.097) + (code[2] * 0.195) + (code[3] * 0.39) + (code[4] * 0.78) + (code[5] * 1.56) + (code[6] * 3.125) + (code[7] * 6.25)) use_clk; 
// end


// initial begin
// 	#(4*48649000);
// 	$stop();
// end
endmodule 