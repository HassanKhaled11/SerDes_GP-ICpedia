module assertion_encoding (
    Bit_Rate_10,
    Rst,
    enable_PMA,
    data_out,
    enable,
    data,
    TXDataK
);
  input reg Bit_Rate_10;
  input reg Rst;
  input wire enable_PMA;
  input wire [9:0] data_out;
  input reg enable;
  input reg [7:0] data;
  input reg [3:0] TXDataK;
  property enable_pma_value;
    @(posedge Bit_Rate_10) disable iff (!Rst) (enable && Rst) |=> enable_PMA;
  endproperty
  // property enable_deasserted;
  //   @(posedge Bit_Rate_10) disable iff (!Rst) (!enable && Rst) |=> data_out == $past(
  //       data_out
  //   );
  // endproperty

  assert property (enable_pma_value)
  else $error("pma_assertion failed");
  // assert property (enable_deasserted)
  // else $error("enable_deasserted assertion failed");

  cover property (enable_pma_value);
  // cover property (enable_deasserted);
endmodule
