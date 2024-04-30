module Box_Car_Voting (
    input  clk,
    input  Dn,
    input  Up,
    output vote_Dn,
    output vote_Up
);
  parameter n = 3;

  reg [n-1:0] collector_up;
  reg [n-1:0] collector_dn;
  int sum_up;
  int sum_dn;
  initial begin
    collector_up = 0;
    collector_dn = 0;
  end
  always @(posedge clk) begin
    collector_up = {Up, collector_up[n-1:1]};
    collector_dn = {Dn, collector_dn[n-1:1]};
    sum_up = 0;  // Reset sum_up
    sum_dn = 0;  // Reset sum_dn
    for (int j = 0; j < n; j = j + 1) begin
      sum_up = sum_up + collector_up[j];
      sum_dn = sum_dn + collector_dn[j];
    end
  end

  assign vote_Up = (sum_up > (n / 2));
  assign vote_Dn = (sum_dn > (n / 2));

endmodule

`timescale 1ps / 1ps
module box_Car_voting_Tb ();
  reg  voting_clk;
  reg  Dn;
  reg  Up;
  wire vote_Up;
  wire vote_Dn;

  parameter N = 3;
  reg clk;  //changes up and dn
  //voting clk sample

  int period = 100;
  initial begin
    voting_clk = 0;
    forever #((period / 2) / N) voting_clk = ~voting_clk;  //200/5 (5 samples per bits)
  end

  //change up and dn
  initial begin
    clk = 0;
    forever #(period / 2) clk = ~clk;  //200/5 (5 samples per bits)
  end
  Box_Car_Voting #(N) Box_Car_Voting_U (
      .clk(voting_clk),
      .Dn(Dn),
      .Up(Up),
      .vote_Dn(vote_Dn),
      .vote_Up(vote_Up)
  );
  initial begin
    for (int i = 0; i < 100; i++) begin
      Dn = $random;
      Up = $random;
      @(negedge clk);
    end
    @(negedge clk);
    Up = 0;
    Dn = 0;
    #1;
    /////////////////////////
    Up = 1;
    Dn = 1;
    #1;
    Up = 0;
    Dn = 0;
    #10;


    $stop;
  end
endmodule
