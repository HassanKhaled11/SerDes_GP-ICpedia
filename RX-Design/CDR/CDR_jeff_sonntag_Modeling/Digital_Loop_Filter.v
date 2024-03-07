`timescale 1ns/1fs
module Digital_Loop_Filter (
	input Up,Dn,
	input clk,    // Clock
	input  rst_n,  // Asynchronous reset active low
	output [10:0] code
);

reg [19:0] freq_integrator;
reg [15:0] phase_integrator;

// always @(posedge clk or negedge rst_n) begin
// 	if(!rst_n)begin
// 		phase_integrator <= 16'b0;
// 		freq_integrator  <= 20'b0;
// 	end else begin
// 		freq_integrator <= freq_integrator + (Up - Dn);
// 		case({Up,Dn})
// 			2'b01 : begin // early
// 				if(freq_integrator[20] == 1)
// 					phase_integrator  <=  phase_integrator + (Up - Dn)  + $unsigned(~freq_integrator[19:11]);
// 				else 
// 					phase_integrator  <=  phase_integrator + (Up - Dn)  + freq_integrator[19:11];
// 			end 
// 			2'b10 : begin // late
// 				if(freq_integrator[20] == 1)
// 					phase_integrator  <=  phase_integrator + (Up - Dn)  - $unsigned(~freq_integrator[19:11]);
// 				else 
// 					phase_integrator  <=  phase_integrator + (Up - Dn)  - freq_integrator[19:11];
// 			end 
// 		endcase 
// 	end
// end
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)begin
		phase_integrator <= 16'b0;
		freq_integrator  <= 20'b0;
	end else begin
		case({Up,Dn})
			2'b10: begin // late
					freq_integrator <=  (Up - Dn) + freq_integrator ;
					phase_integrator  <=  phase_integrator  + freq_integrator[18:10] + (Up - Dn);//$unsigned(~freq_integrator[18:11])
					end  
			2'b01: begin // early 
					freq_integrator <=  (Up - Dn) + freq_integrator ;
					phase_integrator  <=  phase_integrator  - $unsigned(~freq_integrator[18:10]) + (Up - Dn);//$unsigned(~freq_integrator[18:11])		 
				end
			endcase 
	end
end
//////////////////////////////////////
/////////////// 99.9 ,100 ////////////
//////////////////////////////////////
// always @(posedge clk or negedge rst_n) begin
// 	if(!rst_n)begin
// 		phase_integrator <= 16'b0;
// 		freq_integrator  <= 20'b0;
// 	end else begin
// 		case({Up,Dn})
// 			2'b10: begin // late
// 					freq_integrator <=  (Up - Dn) + freq_integrator ;
// 					if(freq_integrator[19] != 1 && freq_integrator != 20'h7ffff) begin 					
// 						phase_integrator  <=  phase_integrator  + freq_integrator[18:11] + (Up - Dn);
// 					end 
// 					else if(freq_integrator[19] == 1) begin 
// 						phase_integrator  <=  phase_integrator  + freq_integrator[18:11] + (Up - Dn);//$unsigned(~freq_integrator[18:11])
// 					end end 
// 			2'b01: begin // early 
// 					freq_integrator <=  (Up - Dn) + freq_integrator ;
// 					if(freq_integrator[19] != 1 && freq_integrator != 20'h7ffff) begin 						
// 						phase_integrator  <=  phase_integrator  - freq_integrator[18:11] + (Up - Dn);
// 					end 
// 					else if(freq_integrator[19] == 1) begin 
// 						phase_integrator  <=  phase_integrator  - $unsigned(~freq_integrator[18:11]) + (Up - Dn);//$unsigned(~freq_integrator[18:11])
// 					end 
// 				end
// 			endcase 
// 	end
// end
//////////////////////////////////////////////////////
/////////////// after 100,100.1 //////////////////////
//////////////////////////////////////////////////////
// always @(posedge clk or negedge rst_n) begin
// 	if(!rst_n)begin
// 		phase_integrator <= 16'b0;
// 		freq_integrator  <= 20'b0;
// 	end else begin
// 		case({Up,Dn})
// 			2'b10: begin
// 					if(freq_integrator[19] != 1 && freq_integrator != 20'h7ffff) begin 
// 					freq_integrator <=  (Up - Dn) + freq_integrator ;
// 					phase_integrator  <=  phase_integrator  + freq_integrator[18:11] + (Up - Dn);
// 					end 
// 					else if(freq_integrator[19] == 1 && freq_integrator != 20'h7ffff) begin 
// 						freq_integrator <=  (Up - Dn) + freq_integrator ;
// 						phase_integrator  <=  phase_integrator  - $unsigned(~freq_integrator[18:11]) + (Up - Dn);//$unsigned(~freq_integrator[18:11])
// 					end end 
// 			2'b01: begin  
// 					if(freq_integrator[19] != 1 && freq_integrator != 20'h7ffff) begin 
// 						freq_integrator <=  (Up - Dn) + freq_integrator ;
// 						phase_integrator  <=  phase_integrator  + freq_integrator[18:11] + (Up - Dn);
// 					end 
// 					else if(freq_integrator[19] == 1 && freq_integrator != 20'h7ffff) begin 
// 						freq_integrator <=  (Up - Dn) + freq_integrator ;
// 						phase_integrator  <=  phase_integrator  - freq_integrator[18:11] + (Up - Dn);//$unsigned(~freq_integrator[18:11])
// 					end 
// 				end
// 			endcase 
// 	end
// end
/////////////////////////////////////////////////
//////////////// 100.1 , 100 ////////////////////
/////////////////////////////////////////////////
// always @(posedge clk or negedge rst_n) begin
// 	if(!rst_n)begin
// 		phase_integrator <= 16'b0;
// 		freq_integrator  <= 20'b0;
// 	end else begin
		
// 		if(freq_integrator[19] != 1 && freq_integrator != 20'h7ffff) begin 
// 			freq_integrator <=  (Up - Dn) + freq_integrator ;
// 			phase_integrator  <=  phase_integrator  + freq_integrator[18:11] + (Up - Dn);
// 		end 
// 		else if(freq_integrator[19] == 1 && freq_integrator != 20'h7ffff) begin 
// 			freq_integrator <=  (Up - Dn) - freq_integrator ;
// 			phase_integrator  <=  phase_integrator  - freq_integrator[18:11] + (Up - Dn);//$unsigned(~freq_integrator[18:11])
// 		end 
// 	end
// end
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
// always @(posedge clk) begin
// 	if(freq_integrator[19] != 1 && freq_integrator != 20'h7ffff) begin
// 		freq_integrator <= freq_integrator + Up - Dn;
// 	end 
// end
assign code = phase_integrator[15:6]; // top 10
endmodule

/*

A    T    B    -->  Description
--------------------------------------
0    0    0    -->  no transition
0    0    1    -->  early
0    1    0    -->  shouldn't occur
0    1    1    -->  late
1    0    0    -->  late
1    0    1    -->  shouldn't occur
1    1    0    -->  early
1    1    1    -->  no transition

*/