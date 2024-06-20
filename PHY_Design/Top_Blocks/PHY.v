module PHY (
    input          Ref_CLK,
    input          Reset_n,
    input [ 5 : 0] DataBusWidth,
    input [31 : 0] MAC_TX_Data,
    input [ 3 : 0] MAC_TX_DataK,
    input          MAC_Data_En,
    input          RxPolarity,

    output          TX_Out_P,
    output          TX_Out_N,
    output [31 : 0] RX_Data,
    output          RX_DataK,
    output [   2:0] RX_Status,
    output          RX_Valid,
    output          PCLK
);

  wire [9:0] Data_In_PMA, Data_Out_PMA;
  wire Bit_Rate_Clk;
  wire Bit_Rate_CLK_10;
  wire TX_P, TX_N;

  assign TX_Out_P = TX_P;
  assign TX_Out_N = TX_N;


  Common_Block Common_Block_U (

      .Ref_Clk        (Ref_CLK),          // 100 MG 
      .Bit_Rate_Clk   (Bit_Rate_Clk),
      .Bit_Rate_CLK_10(Bit_Rate_CLK_10),
      .PCLK           (PCLK),
      .Rst_n          (Reset_n),
      .DataBusWidth   (DataBusWidth)
  );



  PCS PCS_U (

      .PCLK           (PCLK),
      .RST_n          (Reset_n),
      .Bit_Rate_Clk_10(Bit_Rate_CLK_10),
      .DataBusWidth   (DataBusWidth),
      .MAC_TX_Data    (MAC_TX_Data),
      .MAC_TX_Datak   (MAC_TX_DataK),
      .MAC_Data_En    (MAC_Data_En),
      .WordClk        (Bit_Rate_CLK_10),  //get from clock source block
      .CLK_5G         (Bit_Rate_Clk),
      .Collected_Data (Data_Out_PMA),
      .Data_In_PMA    (Data_In_PMA),
      .RX_DataK       (RX_DataK),
      .RX_Data        (RX_Data),
      .RX_Status      (RX_Status),
      .RX_Valid       (RX_Valid)

  );



  PMA PMA_U (
      .Bit_Rate_Clk_10(Bit_Rate_CLK_10),
      .Bit_Rate_Clk   (Bit_Rate_Clk),
      .Rst_n          (Reset_n),
      .Data_in        (Data_In_PMA),
      .MAC_Data_En    (MAC_Data_En),
      .RxPolarity     (RxPolarity),       // input to serial to parallel block
      .TX_Out_P       (TX_P),
      .TX_Out_N       (TX_N),
      .RX_Out         (Data_Out_PMA)      //10 bits to elastic buffer  
  );


endmodule




