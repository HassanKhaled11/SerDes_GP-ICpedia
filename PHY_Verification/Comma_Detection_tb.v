module Comma_pulse_tb ();
  
  reg rst_n;
  reg clk;
  wire RxValid;
  wire Comma_pulse;

  reg[9:0] data;
  integer i;
  initial begin
    clk = 0;
    forever #1 clk = ~clk;
  end
  Comma_Detection  Comma_Detection_Inst (
      .Comma_pulse (Comma_pulse),
      .RxValid     (RxValid),
      .clk         (clk),
      .rst_n       (rst_n),
      .detect_comma(data)
  );


  initial begin
    rst_n = 1'b1;
    data = 10'b001111_1010;
    @(negedge clk);
    rst_n = 1'b0;
    @(negedge clk);
    rst_n = 1'b1;
    repeat(4) @(negedge clk);
    data = 10'h096;
    @(negedge clk);
    $stop();
  end
endmodule