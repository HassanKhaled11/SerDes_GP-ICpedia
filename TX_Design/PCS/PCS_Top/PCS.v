module PCS
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
 // input                Loopback_Path          ,
 // ///////// CONTROL  //////////               
 // input                TxElecIdle             ,
 // input                TxDetectRx_Loopback    ,
 // input                Tx_Compilance          ,
 ////////  OUTPUTS  //////////
 output  [9  : 0 ]    Data_In_PMA     
);



PCS_TX   PCS_TX_U
(

 .PCLK                 (PCLK)                    , 
 .RST_n                (RST_n)                   ,
 .Bit_Rate_Clk_10      (Bit_Rate_Clk_10)         ,
 .DataBusWidth         (DataBusWidth)            ,
 .MAC_TX_Data          (MAC_TX_Data)             ,
 .MAC_TX_Datak         (MAC_TX_Datak)            ,
 .MAC_Data_En          (MAC_Data_En)             ,            
 // .Loopback_Path        (Loopback_Path)           , 
 // .TxElecIdle           (TxElecIdle)              ,
 // .TxDetectRx_Loopback  (TxDetectRx_Loopback)     ,
 // .Tx_Compilance        (Tx_Compilance)           ,
 .Data_In_PMA          (Data_In_PMA)   

 );


endmodule