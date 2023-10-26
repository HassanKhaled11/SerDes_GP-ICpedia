module PCS #(parameter DataBusWidth = 'd32)
(

 ///////// CLOCKS   /////////////	
 input                PCLK                      ,
 input                RST_n                     ,
 input                Bit_Rate_Clk_10           ,
 ///////// DATA     ////////////
 input   [31 : 0 ]    MAC_TX_Data               ,
 input   [3  : 0 ]    MAC_TX_Data_k             ,
 input                MAC_Data_En               ,         
 ///////// CONTROL  //////////
 // input                TxElecIdle                ,
 // input                TxDetectRx_Loopback       ,
 // input                Tx_Compilance             ,
 ////////  OUTPUTS  //////////
 output  [9 : 0]      Data_In_PMA               ,
 output               PMA_Data_Enable

 );


 wire    [7 : 0]   TxData                       ;
 wire              Encoder_en                   ;



Optional_Block #(.DataBusWidth ('d32)) Optional_Block_dut
(
  .PCLK        (PCLK)                           ,
  .Reset_n     (RST_n)                          ,
  .MAC_TX_Data (MAC_TX_Data)                    ,
  .MAC_Data_En (MAC_Data_En)                    ,  
  .TxData      (TxData)                         ,         
  .Encoder_en  (Encoder_en)
);



Encoding  Encoding_dut 
(
 .Bit_Rate_10            (Bit_Rate_Clk_10)             ,
 .Rst                    (RST_n)                       ,
 .data                   (TxData)                      ,
 .enable                 (Encoder_en)                  ,
 .TXDataK                (MAC_TX_Data_k)               ,
 // .TxElecIdle             (TxElecIdle)                  ,
 // .TxDetectRx_Loopback    (TxDetectRx_Loopback)         ,
 // .Tx_Compilance          (Tx_Compilance)               ,
 .enable_PMA             (PMA_Data_Enable)             ,
 .data_out               (Data_In_PMA)            
);


endmodule