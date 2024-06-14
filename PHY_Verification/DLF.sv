`timescale 1ns/1fs
module DLF (
input Up , 
input Dn , 
input clk, 
input rst_n,
input [10:0] code
);

import "DPI-C"  function void init_f(input int frug,freq_width,phug,phase_width); // CPP function to be visible and usable in SV code
import "DPI-C"  function int accum_freq(input int Up , input int Dn); // CPP function to be visible and usable in SV code
import "DPI-C"  function int accum_phase(input int Up , input int Dn); // CPP function to be visible and usable in SV code
//export "DPI-C" function Tosv; sv function to be visible and usable in CPP code

parameter GAIN        = 8 ;
parameter PHASE_WIDTH = 25;
parameter FREQ_WIDTH  = 16;
parameter FRUG        = 4;

reg [FREQ_WIDTH-1 :0] freq_integrator ;
reg [PHASE_WIDTH-1:0] phase_integrator;


wire [1:0] UP_DN;

  assign UP_DN = {Up,Dn};

  assign code = phase_integrator[PHASE_WIDTH-1:PHASE_WIDTH-11];  // top 11


// reg clk_calc;

// initial begin
//  clk_calc = 0;
 
//  forever begin
//    #0.01 clk_calc = ~clk_calc; 
//  end

// end 


  always @(posedge clk or negedge rst_n) begin

    if (!rst_n) begin
      init_f(FRUG,FREQ_WIDTH, GAIN , PHASE_WIDTH);
      phase_integrator <= 0;
      //freq_integrator  <= 0;

    end else begin
    	//freq_integrator  <= integ(Up); // freq_integ();
    	freq_integrator <= accum_freq(Up , Dn);
    	phase_integrator <= accum_phase(Up,Dn);// phase_integ();
    	/*
      case ({
        Up, Dn
      })

        2'b10: begin  // late

          freq_integrator <= FRUG * (Up - Dn) + (freq_integrator);
          phase_integrator  <=  phase_integrator  + freq_integrator[FREQ_WIDTH-2:FREQ_WIDTH-10] + GAIN*(Up - Dn); //$unsigned(~freq_integrator[18:11])

        end

        2'b01: begin  // early 

          freq_integrator <= FRUG * (Up - Dn) + (freq_integrator);
          phase_integrator <= phase_integrator - $unsigned(
              ~freq_integrator[FREQ_WIDTH-2:FREQ_WIDTH-10]
          ) + GAIN * (Up - Dn);  //$unsigned(~freq_integrator[18:11])		 

        end

      endcase
*/
    end

  end


endmodule 

