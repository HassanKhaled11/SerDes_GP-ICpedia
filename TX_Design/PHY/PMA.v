module PMA
(
     input                    Bit_Rate_Clk    ,
     input                    Rst_n           ,
     input [9:0]              Data_in         , 
     input                    MAC_Data_En     ,


     output                   TX_Out_P        ,
     output                   TX_Out_N   	  
);



PMA_TX #(.DATA_WIDTH(10))  PM_TX_U 
  (
    .Bit_Rate_Clk (Bit_Rate_Clk)    ,
    .Rst_n        (Rst_n)           ,
    .Data_in      (Data_in)         , 
    .MAC_Data_En  (MAC_Data_En)     , 
    .TX_Out_P     (TX_Out_P)        ,
    .TX_Out_N     (TX_Out_N)              
  );





endmodule