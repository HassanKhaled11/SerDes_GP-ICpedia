`timescale 1ns / 1fs

module Channel #(
    parameter ATTENUATION = 10,
    parameter F = 2.5,
    parameter N = 10
) (
    input       Sample_CLK,
    input       Data_in,
    output real Ynew
);

  real Unew;
  real Uold;
  // real Ynew ;
  real Yold;
  real Ynewn;

  real A, A_, x1, x2, Wc, alpha, beta;



  initial begin
    Unew = 0;
    Uold = 0;
    Ynew = 0;
    Yold = 0;
  end

  initial begin

    if (ATTENUATION == 10) begin
      A = 1.0 / $sqrt(10);
    end else begin
      A = $pow(10, ATTENUATION / 20);
    end  // 10^(db/20)

    x1    = 1.0 / $pow(A, 2);  // 1 + (W/Wc)^2
    x2    = $sqrt(x1 - 1.0);  // W/Wc = x2 = sqrt(x1-1)
    Wc    = (1.0 / x2) * 2 * 3.14;  // Wc
    alpha = $exp(Wc * (-1 * 1.0 / N));
    beta  = 1.0 - alpha;

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

  parameter ATTENUATION = 10;
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


  always #((0.2 / N) / 2.0) Sample_CLK = ~Sample_CLK;

  always #(0.2 / 2) CLK = ~CLK;

  initial begin
    Sample_CLK = 0;
    CLK = 0;

    for (int i = 0; i < 1000; i++) begin
      @(negedge CLK);
      Data_in = $random();
    end

    $stop;
  end


endmodule
