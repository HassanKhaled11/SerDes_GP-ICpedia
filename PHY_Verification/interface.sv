interface BFM_if;

  parameter DATA_WIDTH = 10;
  // PORTS


  //////// INPUTS //////////

  logic          Ref_CLK;
  logic          Reset_n;
  logic [ 5 : 0] DataBusWidth;
  logic [31 : 0] MAC_TX_Data;
  logic [ 3 : 0] MAC_TX_DataK;
  logic          MAC_Data_En;
  logic          RxPolarity;


  ///////// OUTPUTS ///////// 
  logic          TX_Out_P;
  logic          TX_Out_N;
  logic [31 : 0] Rx_Data;
  logic          Rx_DataK;
  logic [ 2 : 0] Rx_Status;
  logic          Rx_Valid;
  logic          PCLK;

endinterface




interface INTERNALS_if;

  bit         Bit_CLK;
  bit         Word_CLK;
  bit         PCLK;
  logic [5:0] DataBusWidth;
  bit         TX_Out_P;
  bit         Clk_offset;
  bit         recovered_clk_5G;

  bit         MAC_Data_En;
  bit         COMMA_PULSE;
  bit         Decode_Error;
  bit         Disparity_Error;

endinterface


interface PASSIVE_if;

////////////// TX_GASKET /////////////////

  logic                                 tx_gasket_PCLK                 ;
  logic                                 tx_gasket_Bit_Rate_CLK_10      ;
  logic                                 tx_gasket_Reset_n              ;
  logic  [5  : 0 ]                      tx_gasket_DataBusWidth         ;
  logic  [31 : 0 ]                      tx_gasket_MAC_TX_Data          ;
  logic  [3  : 0 ]                      tx_gasket_MAC_TX_DataK         ;
  logic                                 tx_gasket_MAC_Data_En          ; 
  logic                                 tx_gasket_TxDataK              ;
  logic  [7  : 0 ]                      tx_gasket_TxData               ;

////////////// ENCODER /////////////////

  logic  [7:0]                          encoder_data                 ;
  logic                                 encoder_MAC_Data_En          ;
  logic                                 encoder_Bit_Rate_10          ;
  logic                                 encoder_Rst                  ;
  logic                                 encoder_TXDataK              ; 
  logic  [9:0]                          encoder_data_out             ;

////////////// TX_PMA /////////////////

  logic                                 tx_pma_Bit_Rate_Clk_10      ;  
  logic                                 tx_pma_Bit_Rate_Clk         ;
  logic                                 tx_pma_Rst_n                ;
  logic [10:0]                          tx_pma_Data_in              ; 
  logic                                 tx_pma_MAC_Data_En          ; 
  logic                                 tx_pma_TX_Out_P             ;   
  logic                                 tx_pma_TX_Out_N             ;

////////////// RX_S2p /////////////////

  logic                                 rx_s2p_Recovered_Bit_Clk    ;
  logic                                 rx_s2p_Ser_in               ;
  logic                                 rx_s2p_Rst_n                ;
  logic                                 rx_s2p_RxPolarity           ;
  logic [9:0]                           rx_s2p_Data_Collected       ;

////////////// RX_CDR /////////////////

  logic                                 cdr_rst_n                   ;  
  logic                                 cdr_clk_0                   ;
  logic                                 cdr_clk_data                ;  
  logic                                 cdr_Din                     ;
  logic                                 cdr_PI_Clk                  ;
  logic                                 cdr_Dout                    ;
  //...internal 
  logic [10:0]                          cdr_code                    ;

////////////// EBUFFER /////////////////

  logic                                 ebuffer_write_clk            ;
  logic                                 ebuffer_read_clk             ;
  logic [10:0]                          ebuffer_data_in              ;
  logic                                 ebuffer_rst_n                ;
  logic                                 ebuffer_skp_added            ;
  logic                                 ebuffer_Skp_Removed          ;
  logic                                 ebuffer_overflow             ;
  logic                                 ebuffer_underflow            ;
  logic [10:0]                          ebuffer_data_out             ;


////////////// DECODER /////////////////

  logic                                 decoder_CLK                  ;
  logic                                 decoder_Rst_n                ;
  logic [9:0]                           decoder_Data_in              ;
  logic [7:0]                           decoder_Data_out             ;
  logic                                 decoder_DecodeError          ;
  logic                                 decoder_DisparityError       ;
  logic                                 decoder_RxDataK              ;

////////////// RX_GASKET ///////////////

  logic                                 rx_gasket_clk_to_get           ;
  logic                                 rx_gasket_PCLK                 ;
  logic                                 rx_gasket_Rst_n                ;
  logic                                 rx_gasket_Rx_Datak             ;
  logic [ 5:0]                          rx_gasket_width                ;
  logic [ 7:0]                          rx_gasket_Data_in              ;
  logic [31:0]                          rx_gasket_Data_out             ;


endinterface  
