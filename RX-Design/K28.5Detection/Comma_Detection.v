module Comma_Detection  (
    //input [PARALLEL_DATA_WIDTH-1:0] Data_in,
    // input TXDataK,
    input clk,
    input rst_n,
    input detect_comma,
    output reg RxValid,
    output reg Comma_pulse
);
reg internal;
wire pulse;
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      internal <= 1'b0;
      RxValid <= 0;
      Comma_pulse <= 0;
    end else begin
      RxValid <= pulse;
      internal <= detect_comma;
      Comma_pulse <= pulse;
    end
  end
assign pulse = !internal && detect_comma;
/*
 if (Data_in == 10'b001111_1010 || Data_in == 10'b110000_0101) begin
      RxValid = 1;
      Comma_pulse = 1;
    end else begin
      RxValid = 0;
      Comma_pulse = 0;
    end
*/

endmodule
