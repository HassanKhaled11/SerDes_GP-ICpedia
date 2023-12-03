module PHY
(
  input                                      Ref_CLK                ,
  input                                      Reset_n                ,
  input         [5  : 0 ]                    DataBusWidth           ,
  input         [31 : 0 ]                    MAC_TX_Data            ,
  input         [3  : 0 ]                    MAC_TX_DataK           ,
  input                                      MAC_Data_En            , 
  
  output                                     TX_Out_P               ,
  output                                     TX_Out_N
);

wire [9:0] Data_In_PMA;
wire Bit_Rate_Clk;
wire Bit_Rate_CLK_10;
wire PCLK ;



PLL  PLL_U (

 .Ref_Clk         (Ref_CLK)            ,  // 100 MG 
 .Bit_Rate_Clk    (Bit_Rate_Clk)       ,
 .Bit_Rate_CLK_10 (Bit_Rate_CLK_10)    ,
 .PCLK            (PCLK)               ,
 .Rst_n           (Reset_n)            ,  
 .DataBusWidth    (DataBusWidth)       
);



PCS  PCS_U 
(

 .PCLK                 (PCLK)                    , 
 .RST_n                (Reset_n)                 ,
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
  .Bit_Rate_Clk_10(Bit_Rate_CLK_10),
  .Bit_Rate_Clk (Bit_Rate_Clk)     ,
  .Rst_n        (Reset_n)          ,
  .Data_in      (Data_In_PMA)      , 
  .MAC_Data_En  (MAC_Data_En)      ,


  .TX_Out_P     (TX_Out_P)         ,
  .TX_Out_N   	(TX_Out_N)    
);


endmodule


////////////////////////////////////////////////////////////////////////

`timescale  1ns/1ns


module PHY_tb;

  reg                                      Ref_CLK                ;
  reg                                      Reset_n                ;
  reg         [5  : 0 ]                    DataBusWidth           ;
  reg         [31 : 0 ]                    MAC_TX_Data            ;
  reg         [3  : 0 ]                    MAC_TX_DataK           ;
  reg                                      MAC_Data_En            ; 
  
  wire                                     TX_Out_P               ;
  wire                                     TX_Out_N               ;


  PHY Dut(.*);


 always #5 Ref_CLK = ~Ref_CLK ;

 initial begin
   Ref_CLK      = 0 ;
   DataBusWidth = 32;

   Reset_n = 0 ;
   #10;
   Reset_n = 1 ;

   MAC_Data_En = 1   ;

   SEND_DATA(150,2)  ;
   SEND_DATA(200,4)  ;
   SEND_DATA(1000,3)  ;
   SEND_DATA(50 ,1)  ;

  Reset_n = 0;
  #10;
  Reset_n = 1;  
  DataBusWidth = 16  ;

   SEND_DATA(150,2)  ;
   SEND_DATA(200,4)  ;
   SEND_DATA(1000,3)  ;
   #500
   SEND_DATA(50 ,1)  ;

  
  Reset_n = 0;
  #10;
  Reset_n = 1;
  DataBusWidth = 8   ;

   SEND_DATA(150,2)  ;
   SEND_DATA(200,4)  ;
   SEND_DATA(100,3)  ;
   SEND_DATA(50 ,1)  ;

   repeat(10) @(negedge Dut.PCLK);
   $stop;
 end

 
 task SEND_DATA(input [31:0] data_in , input [3:0] dataK_in);
  begin
   @(negedge Dut.PCLK);
   MAC_TX_Data  = data_in  ;
   MAC_TX_DataK = dataK_in ;
  end
 endtask

endmodule
