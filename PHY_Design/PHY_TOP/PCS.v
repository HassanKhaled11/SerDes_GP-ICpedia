module PCS (
    ///////// CLOCKS   /////////////	
    input          PCLK,
    input          RST_n,
    input          Bit_Rate_Clk_10,
    input [ 5 : 0] DataBusWidth,
    ///////// DATA     ////////////
    input [31 : 0] MAC_TX_Data,
    input [ 3 : 0] MAC_TX_Datak,
    input          MAC_Data_En,

    input       WordClk,
    input       recovered_clk_5G,
    input [9:0] Collected_Data,

    ////////  OUTPUTS  //////////
    output [9 : 0] Data_In_PMA,

    output [31:0] RX_Data,
    output        RX_DataK,
    output [ 2:0] RX_Status,
    output        RX_Valid
);



  PCS_TX PCS_TX_U (

      .PCLK           (PCLK),
      .RST_n          (RST_n),
      .Bit_Rate_Clk_10(Bit_Rate_Clk_10),
      .DataBusWidth   (DataBusWidth),
      .MAC_TX_Data    (MAC_TX_Data),
      .MAC_TX_Datak   (MAC_TX_Datak),
      .MAC_Data_En    (MAC_Data_En),
      .Data_In_PMA    (Data_In_PMA)

  );


  PCS_RX #(
      .DATA_WIDTH  (10),
      .BUFFER_WIDTH(10),
      .BUFFER_DEPTH(16)
  ) PCS_RX_U (
      .WordClk         (WordClk),           // 
      .Collected_Data  (Collected_Data),    //from PMA
      .PCLK            (PCLK),
      .recovered_clk_5G(recovered_clk_5G),  //  in port
      .Rst_n           (RST_n),
      .DataBusWidth    (DataBusWidth),
      .RX_Data         (RX_Data),
      .RX_DataK        (RX_DataK),
      .RX_Status       (RX_Status),
      .RX_Valid        (RX_Valid)
  );

endmodule
