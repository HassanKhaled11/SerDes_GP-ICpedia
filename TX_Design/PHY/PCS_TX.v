module PCS_TX 
(

 ///////// CLOCKS   /////////////	
 input                PCLK                      ,
 input                RST_n                     ,
 input                Bit_Rate_Clk_10           ,
 input   [5  : 0 ]    DataBusWidth              ,
 ///////// DATA     ////////////
 input   [31 : 0 ]    MAC_TX_Data               ,
 input   [3  : 0 ]    MAC_TX_Datak              ,
 input                MAC_Data_En               ,         
 // input                Loopback_Path             ,
 // ///////// CONTROL  //////////
 // input                TxElecIdle                ,
 // input                TxDetectRx_Loopback       ,
 // input                Tx_Compilance             ,
 ////////  OUTPUTS  //////////
 output  [9  : 0 ]    Data_In_PMA             

 );


 wire    [7 : 0]   TxData                      ;
 wire              TXDataK                     ;


GasKet   GasKet_U
(
 .PCLK           (PCLK)                        ,
 .Bit_Rate_CLK_10(Bit_Rate_Clk_10)             ,
 .Reset_n        (RST_n)                       ,
 .DataBusWidth   (DataBusWidth)                ,
 .MAC_TX_Data    (MAC_TX_Data)                 ,
 .MAC_TX_DataK   (MAC_TX_Datak)                ,
 .MAC_Data_En    (MAC_Data_En)                 ,  
 .TxDataK        (TXDataK)                     ,
 .TxData         (TxData)                       
);




Encoding Encoding_U 
(
 .data        (TxData)                         ,
 .MAC_Data_En (MAC_Data_En)                    ,
 .Bit_Rate_10 (Bit_Rate_Clk_10)                ,
 .Rst         (RST_n)                          ,
 .TXDataK     (TXDataK)                        ,
 .data_out    (Data_In_PMA)                    
);


endmodule