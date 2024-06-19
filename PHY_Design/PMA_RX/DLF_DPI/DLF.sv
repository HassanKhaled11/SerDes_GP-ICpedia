module DLF (
    input up,
    input dn,
    input clk,
    input rst_n,
    input [10:0] code
);

  import "DPI-C" function void init_f(
    input int frug,
    freq_width,
    phug,
    phase_width
  );  // CPP function to be visible and usable in SV code
  import "DPI-C" function int accum_freq(
    input int Up,
    input int Dn
  );  // CPP function to be visible and usable in SV code
  import "DPI-C" function int accum_phase(
    input int Up,
    input int Dn
  );  // CPP function to be visible and usable in SV code

  parameter GAIN = 3;
  parameter FREQ_WIDTH = 16;
  parameter PHASE_WIDTH = 16;
  parameter FRUG = 8;

  reg [ FREQ_WIDTH-1:0] freq_integrator;
  reg [PHASE_WIDTH-1:0] phase_integrator;



  assign code = phase_integrator[PHASE_WIDTH-1:PHASE_WIDTH-11];  // top 11



  always @(posedge clk or negedge rst_n) begin

    if (!rst_n) begin
      init_f(FRUG, FREQ_WIDTH, GAIN, PHASE_WIDTH);
      phase_integrator <= 0;

    end else begin
      freq_integrator  <= accum_freq(up, dn);
      phase_integrator <= accum_phase(up, dn);  // phase_integ();
    end

  end


endmodule

