`timescale 1ns/1fs

module Digital_Loop_Filter (

	input Up,Dn,
	input clk,    // Clock
	input  rst_n,  // Asynchronous reset active low
	output [10:0] code

);

parameter GAIN = 2;

reg  [15:0] freq_integrator;
reg  [15:0] phase_integrator;



assign code = phase_integrator[15:5]; // top 11



always @(posedge clk or negedge rst_n) begin

	if(!rst_n)begin

		phase_integrator <= 0;
		freq_integrator  <= 10000;

	end else begin

		case({Up,Dn})

			2'b10: begin // late

					freq_integrator <=  (Up - Dn) + freq_integrator ;
					phase_integrator  <=  phase_integrator  + freq_integrator[14:6] + GAIN*(Up - Dn);//$unsigned(~freq_integrator[18:11])

					end  

			2'b01: begin // early 

					freq_integrator <=  (Up - Dn) + freq_integrator ;
					phase_integrator  <=  phase_integrator  - $unsigned(~freq_integrator[14:6]) + GAIN*(Up - Dn);//$unsigned(~freq_integrator[18:11])		 

				end

			endcase 

	end

end




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