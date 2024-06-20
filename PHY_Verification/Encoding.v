module Encoding (
    input wire [7:0] data,
    input wire MAC_Data_En,
    input wire Bit_Rate_10,
    input wire Rst,
    input wire TXDataK,
    output wire [9:0] data_out
);


  wire [9:0] encoded_pos_data, encoded_neg_data;


  line_coding_8_10 line_coding_8_10_U (
      .TXDataK(TXDataK),
      .enable(MAC_Data_En),
      .data(data),
      .encoded_data_pos(encoded_pos_data),
      .encoded_data_neg(encoded_neg_data)
  );


  FSM_RD FSM_RD_U (
      .enable     (MAC_Data_En),
      .TXDataK    (TXDataK),
      .data_neg   (encoded_neg_data),
      .data_pos   (encoded_pos_data),
      .Bit_Rate_10(Bit_Rate_10),
      .Rst        (Rst),
      .Data_10    (data_out)
  );



endmodule
