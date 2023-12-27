module Comma_Detection #(
    parameter PARALLEL_DATA_WIDTH = 10
) (
    input [PARALLEL_DATA_WIDTH-1:0] Data_in,
    // input TXDataK,
    output reg RxValid,
    output reg Comma_pulse
);
  always @(*) begin
    if (Data_in == 10'b001111_1010 || Data_in == 10'b110000_0101) begin
      RxValid = 1;
      Comma_pulse = 1;
    end else begin
      RxValid = 0;
      Comma_pulse = 0;
    end
  end


endmodule
