module PMA_RX #(
    parameter DATA_WIDTH = 10
) (
    input RX_POS,
    input RX_NEG,
    //input Ser_in,
    input Rst_n,
    input CLK_5G,
    input RxPolarity,
    output [DATA_WIDTH-1:0] Data_out,
    output recovered_clk_5G
    //output K285
);
  wire Recoverd_data;
  wire rec_clk_5G;
  assign recovered_clk_5G = rec_clk_5G;
  ////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////
  //////////////// 	CDR should be here	   /////////////////
  ////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////
  CDR_Loop CDRLoopInst (
      .rst_n(Rst_n),  // Asynchronous reset active low
      .clk_0(CLK_5G),
      .clk_data(200),
      .Din(RX_POS),
      .PI_Clk(rec_clk_5G),
      .Dout(Recoverd_data)
  );

  ////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////
  //////////////// 	Serial to parallel	   /////////////////
  ////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////


  Serial_to_Parallel #(
      .DATA_WIDTH(DATA_WIDTH)
  ) serialToparallel (

      .Recovered_Bit_Clk(rec_clk_5G),
      .Ser_in(Recoverd_data),
      .Rst_n(Rst_n),
      .RxPolarity(RxPolarity),
      .Data_Collected(Data_out)

  );

endmodule
