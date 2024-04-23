`timescale 1ns / 1fs

module Digital_Loop_Filter (

    input Up,
    Dn,
    input clk,  // Clock
    input rst_n,  // Asynchronous reset active low
    output [10:0] code

);

  parameter PHUG = 8;
  parameter PHASE_WIDTH = 16;
  parameter FREQ_WIDTH  = 16;
  parameter FRUG = 3;

  reg [ FREQ_WIDTH-1:0] freq_integrator;
  reg [PHASE_WIDTH-1:0] phase_integrator;



  assign code = phase_integrator[PHASE_WIDTH-1:PHASE_WIDTH-11];  // top 11



  always @(posedge clk or negedge rst_n) begin

    if (!rst_n) begin

      phase_integrator <= 0;
      freq_integrator  <= 0;

    end else begin

      case ({
        Up, Dn
      })

        2'b10: begin  // late

          freq_integrator <= FRUG * (Up - Dn) + (freq_integrator);
          phase_integrator  <=  phase_integrator  + freq_integrator[FREQ_WIDTH-2:FREQ_WIDTH-10] + PHUG*(Up - Dn); //$unsigned(~freq_integrator[18:11])

        end

        2'b01: begin  // early 

          freq_integrator <= FRUG * (Up - Dn) + (freq_integrator);
          phase_integrator <= phase_integrator - $unsigned(
              ~freq_integrator[FREQ_WIDTH-2:FREQ_WIDTH-10]
          ) + PHUG * (Up - Dn);  //$unsigned(~freq_integrator[18:11])		 

        end

      endcase

    end

  end


  ///////////////////////////

  // always @(posedge clk or negedge rst_n) begin

  //   if (!rst_n) begin

  //     phase_integrator <= 0;
  //     freq_integrator  <= 0;

  //   end else begin

  //     freq_integrator <= FRUG * (Up - Dn) + signed'(freq_integrator);
  //     phase_integrator  <=  (phase_integrator)  + signed'(freq_integrator[WIDTH-2:WIDTH-10]) + PHUG*(Up - Dn); //$unsigned(~freq_integrator[18:11])

  //   end
  // end

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
