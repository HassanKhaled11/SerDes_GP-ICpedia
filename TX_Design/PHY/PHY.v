module PHY
(
  input                                      Ref_CLK                ,
  input                                      PCLK                   ,
  input                                      Bit_Rate_Clk           ,
  input                                      Bit_Rate_CLK_10        ,
  input                                      Reset_n                ,
  input         [5  : 0 ]                    DataBusWidth           ,
  input         [31 : 0 ]                    MAC_TX_Data            ,
  input         [3  : 0 ]                    MAC_TX_DataK           ,
  input                                      MAC_Data_En            , 
  
  output                                     TX_Out_P               ,
  output                                     TX_Out_N
);

wire [9:0] Data_In_PMA;


PLL  PLL_U (

 .Ref_Clk         (Ref_CLK)            ,  // 100 MG 
 .Bit_Rate_Clk    (Bit_Rate_Clk)       ,
 .Bit_Rate_10     (Bit_Rate_CLK_10)    ,
 .PCLK            (PCLK)               ,
 .Rst             (RST_n)              
 // .DataBusWidth    (DataBusWidth)    ,
);



PCS  PCS_U 
(

 .PCLK                 (PCLK)                    , 
 .RST_n                (RST_n)                   ,
 .Bit_Rate_Clk_10      (Bit_Rate_CLK_10)         ,
 .DataBusWidth         (DataBusWidth)            ,
 .MAC_TX_Data          (MAC_TX_Data)             ,
 .MAC_TX_Datak         (MAC_TX_DataK)            ,
 .MAC_Data_En          (MAC_Data_En)             ,            
 // .Loopback_Path        (Loopback_Path)        , 
 // .TxElecIdle           (TxElecIdle)           ,
 // .TxDetectRx_Loopback  (TxDetectRx_Loopback)  ,
 // .Tx_Compilance        (Tx_Compilance)        ,
 .Data_In_PMA          (Data_In_PMA)   

 );



PMA   PMA_U
(
  .Bit_Rate_Clk (Bit_Rate_Clk)    ,
  .Rst_n        (RST_n)           ,
  .Data_in      (Data_In_PMA)     , 
  .MAC_Data_En  (MAC_Data_En)     ,


  .TX_Out_P     (TX_Out_P)        ,
  .TX_Out_N   	(TX_Out_N)    
);




endmodule