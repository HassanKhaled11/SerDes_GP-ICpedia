module PMA (
    input       Bit_Rate_Clk_10,
    input       Bit_Rate_Clk,
    input       Rst_n,
    input [9:0] Data_in,
    input       MAC_Data_En,
    input       RxPolarity,
    //input                    RX_POS          ,
    //input                    RX_NEG          ,
    // input       Ser_in,


    //output       TX_Out_P,
    //output       TX_Out_N,
    //output                   K285            ,
    output [9:0] RX_Out
);

wire TX_Out_P ;

  PMA_TX #(
      .DATA_WIDTH(10)
  ) PMA_TX_U (
      .Bit_Rate_Clk_10(Bit_Rate_Clk_10),
      .Bit_Rate_Clk   (Bit_Rate_Clk),
      .Rst_n          (Rst_n),
      .Data_in        (Data_in),
      .MAC_Data_En    (MAC_Data_En),
      .TX_Out_P       (TX_Out_P)
      // .TX_Out_N       (TX_Out_N)
  );


  //CDR + serial to parallel
  PMA_RX #(
      .DATA_WIDTH(10)
  ) PM_RX_U (
      //.RX_POS    (RX_POS),
      //.RX_NEG    (RX_NEG),
      .Ser_in    (TX_Out_P),
      .Rst_n     (Rst_n),
      .CLK_5G    (Bit_Rate_Clk),  //CLK_5G
      .RxPolarity(RxPolarity),
      .Data_out  (RX_Out)
      //.K285(K285)
  );



endmodule