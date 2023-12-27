module Comma_pulse_tb ();
  parameter PARALLEL_DATA_WIDTH = 10;

  reg [PARALLEL_DATA_WIDTH-1:0] Data_in;
  // reg TXDataK;
  wire RxValid;
  wire Comma_pulse;

  reg [1:0] rand_comma;
  integer i;
  Comma_Detection #(PARALLEL_DATA_WIDTH) Comma_Detection_Inst (
      Data_in,
      // TXDataK,
      RxValid,
      Comma_pulse
  );


  initial begin
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
