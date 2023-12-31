module Comma_pulse_tb ();
  parameter PARALLEL_DATA_WIDTH = 10;

  reg Data_in;
  // reg TXDataK;
  wire RxValid;
  wire Comma_pulse;
  reg clk;
  reg rst_n;
  reg [1:0] rand_comma;
  integer i;
  Comma_Detection Comma_Detection_Inst (
      clk,
      rst_n,
      Data_in,
      // TXDataK,
      RxValid,
      Comma_pulse
  );
  initial begin
    clk = 0;
    forever #1 clk = ~clk;
  end

  initial begin
    rst_n = 0;
    #5;
    rst_n = 1;
    #1;
    for (i = 0; i < 100; i = i + 1) begin
      Data_in = $random;
      // TXDataK = $random;
      rand_comma = $random;
      if (rand_comma == 2'b11) begin
        Data_in = 10'b001111_1010;
        // TXDataK = 1;
      end else if (rand_comma == 2'b00) begin
        Data_in = 10'b110000_0101;
        // TXDataK = 1;
      end
      #5;
    end
    $stop();
  end
endmodule
