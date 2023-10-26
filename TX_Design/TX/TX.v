module TX #(parameter DataBusWidth = 'd8)
(
 input             PCLK                ,
 input             Bit_Rate_Clk_10     ,
 input             Bit_Rate_Clk        ,
 input             RST_n               ,
 input   [31:0]    MAC_TX_Data         ,
 input             MAC_Data_En         ,
 input   [3 :0]    MAC_TX_Data_k       ,
 // input          TxElecIdle          ,
 // input          TxDetectRx_Loopback ,
 // input          Tx_Compilance       ,
 // input          Loopback_Path       ,
 output            TX_Out              ,
 output            TX_Done

);


wire [9:0]   Data_In_PMA      ;
wire         PMA_Data_Enable  ;



PCS  PCS_Dut
(
 .PCLK                  (PCLK)                ,
 .RST_n                 (RST_n)               ,
 .Bit_Rate_Clk_10       (Bit_Rate_Clk_10)     ,
 .MAC_TX_Data           (MAC_TX_Data)         ,
 .MAC_Data_En           (MAC_Data_En)         ,
 .MAC_TX_Data_k         (MAC_TX_Data_k)       ,         
 // .TxElecIdle            (TxElecIdle)          ,
 // .TxDetectRx_Loopback   (TxDetectRx_Loopback) ,
 // .Tx_Compilance         (Tx_Compilance)       ,
 .Data_In_PMA           (Data_In_PMA)         ,
 .PMA_Data_Enable       (PMA_Data_Enable)
 );





PMA PMA_Dut
  (
  .Bit_Rate       (Bit_Rate_Clk)            ,
  .Rst_n          (RST_n)                   ,
  .Data_in        (Data_In_PMA)             ,  
  .Tx_Data_Enable (PMA_Data_Enable)         ,
  // .Loopback_Path  (Loopback_Path)           , 
  .TX_Out         (TX_Out)                  ,
  .TX_Done        (TX_Done)
  );

endmodule 