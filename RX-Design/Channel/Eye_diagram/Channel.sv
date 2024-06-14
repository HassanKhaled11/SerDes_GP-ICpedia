// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples

`timescale 1ns / 1fs

module Channel #(
    parameter ATTENUATION = 10,
    parameter F = 2.5,
    parameter N = 10
) (
    input Sample_CLK,
    input Data_in,

    output reg Data_out  // Atenuated Data
);


  import "DPI-C" function real calculate_alpha(
    input real ATTENUATION,
    input int  N
  );


  real Unew;
  real Uold;
  real Ynew;
  real Yold;
  real Ynewn;

  real A, A_, x1, x2, Wc, alpha, beta;



  assign Data_out = Ynew;


  initial begin
    Unew = 0;
    Uold = 0;
    Ynew = 0;
    Yold = 0;
  end

  initial begin

    alpha = calculate_alpha(ATTENUATION, N);
    beta  = 1.0 - alpha;

    $display("alpha = %f , beta = %f ", alpha, beta);
  end


  always @(posedge Sample_CLK) begin
    Ynew <= alpha * Yold + beta * Uold;
    Yold <= Ynew;
    Uold <= Unew;
    Unew <= Data_in;
  end

  assign Ynewn = 1.0 - Ynew;

endmodule



module Channel_TB;

  parameter ATTENUATION = 0;
  parameter F = 2.5;
  parameter N = 10;

  reg  Sample_CLK;
  reg  Data_in;
  wire Data_out;

  reg  CLK;

  Channel #(
      .ATTENUATION(ATTENUATION),
      .F(F),
      .N(N)
  ) DUT (
      .*
  );


  // always #(0.000001) Sample_CLK = ~Sample_CLK ;
  always #((0.2 / N) / 2.0) Sample_CLK = ~Sample_CLK;

  always #(0.2 / 2) CLK = ~CLK;
  int fd;
  initial begin
    fd = $fopen("channel_bits.txt", "w");
    if (fd) $display("file_opened");
    else $display("Error couldn't open file");

    while (1) begin
      repeat (2) @(negedge Sample_CLK);
      $fdisplay(fd, DUT.Ynew);
      $display(DUT.Ynew);

    end
    $fclose(fd);

  end
  initial begin
    Sample_CLK = 0;
    CLK = 0;

    for (int i = 0; i < 1000; i++) begin
      @(negedge CLK);
      Data_in = $random();
    end

    $stop;
  end


  initial begin

    $dumpfile("dump.vcd");
    $dumpvars;

  end

endmodule
