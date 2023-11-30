module GasKet
(
  input                                      PCLK                   ,
  input                                      Bit_Rate_CLK_10        ,
  input                                      Reset_n                ,
  input         [5  : 0 ]                    DataBusWidth           ,
  input         [31 : 0 ]                    MAC_TX_Data            ,
  input         [3  : 0 ]                    MAC_TX_DataK           ,
  input                                      MAC_Data_En            , 
  
  output  reg                                TxDataK                ,
  output  reg   [7  : 0 ]                    TxData                                

);



reg       Counter_16    ;
reg [1:0] Counter_32    ;
reg [7:0] Temp_Reg      ; 
reg       Tempk_Reg     ;  

reg enable ;

always@(*) begin

if (!Reset_n) begin
   Temp_Reg  = 0 ;
   Tempk_Reg = 0 ;
end

else begin
  
  case (DataBusWidth)
  
  6'd8 : begin
          Temp_Reg  = MAC_TX_Data [7:0];
          Tempk_Reg = MAC_TX_DataK[0]  ;
         end


  6'd16 : begin
          if(Counter_16 == 0)  begin 
           Temp_Reg  = MAC_TX_Data[7 :0 ];
           Tempk_Reg = MAC_TX_DataK[0]   ;
          end

          else begin
            Temp_Reg = MAC_TX_Data[15:8 ];
            Tempk_Reg = MAC_TX_DataK[1]  ;             
          end
          end 


  6'd32 : begin
           if      (Counter_32 == 0) begin 
           Temp_Reg  = MAC_TX_Data[7 :0 ];
           Tempk_Reg = MAC_TX_DataK[0]   ;
           end

           else if (Counter_32 == 1) begin
           Temp_Reg  = MAC_TX_Data  [15:8 ];
           Tempk_Reg = MAC_TX_DataK [1]    ;
           end

           else if (Counter_32 == 2) begin
            Temp_Reg  = MAC_TX_Data[23:16];
            Tempk_Reg = MAC_TX_DataK[2]   ;
           end

           else  begin
            Temp_Reg  = MAC_TX_Data[31:24];                  
            Tempk_Reg = MAC_TX_DataK[3]   ;            
           end
         end 

  default: begin
            Temp_Reg  = MAC_TX_Data[7:0] ;
            Tempk_Reg = MAC_TX_DataK[0]  ;
          end
  endcase

 end
end





always@(posedge Bit_Rate_CLK_10 or negedge Reset_n) begin

if(!Reset_n) begin
Counter_16 <= 0           ;
Counter_32 <= 0           ; 
TxData     <= 0           ;
end

else if (enable) begin      //

      if(DataBusWidth == 8)begin
      Counter_16 <= 0              ;
      Counter_32 <= 0              ;
      TxData     <= Temp_Reg       ;
      TxDataK    <= Tempk_Reg      ;
      end
      
      else if(DataBusWidth == 16)begin
      Counter_32 <= 0              ;  
      TxData     <= Temp_Reg       ;
      TxDataK    <= Tempk_Reg      ;
      Counter_16 <= Counter_16 + 1 ; 
      end
      
      else begin
      Counter_16 <= 0              ;
      TxData     <= Temp_Reg       ;
      TxDataK    <= Tempk_Reg      ;
      Counter_32 <= Counter_32 + 1 ; 
      end
      
end


else begin

Counter_16 <= 0           ;
Counter_32 <= 0           ; 
TxData     <= 0           ;
TxDataK    <= 0           ;


end

end

//assign enable = (PCLK && MAC_Data_En)? 1'b1 : 1'b0 ;

always@(*) begin
  if(PCLK && MAC_Data_En) enable = 1'b1 ;
  else if (PCLK && !MAC_Data_En) enable = 1'b0;
  else enable = enable ;
end


endmodule





// module GasKet_tb;

// parameter  PERIOD_CLOCK      = 100         ;
// parameter  PERIOD_CLOCK_pclk = 100         ;   
  
// wire                                   PCLK                   ;
// reg                                    Bit_Rate_CLK_10        ;
// reg                                    Reset_n                ;
// reg       [5  : 0 ]                    DataBusWidth           ;
// reg       [31 : 0 ]                    MAC_TX_Data            ;
// reg       [3  : 0 ]                    MAC_TX_DataK           ;
// reg                                    MAC_Data_En            ; 
  

// wire      [7  : 0 ]                    TxData                 ;
// wire                                   TxDataK                ;


// GasKet DUT(.*);


// always #(PERIOD_CLOCK/2) Bit_Rate_CLK_10 = ~Bit_Rate_CLK_10   ;
// //always #(PERIOD_CLOCK_pclk/2) PCLK = ~PCLK   ;


// ClkDiv__  dut(
// .i_ref_clk   (Bit_Rate_CLK_10),
// .i_rst_n     (Reset_n),
// .i_div_ratio (4),
// .o_div_clk   (PCLK)
// );
 


// initial begin
//   Bit_Rate_CLK_10 = 0            ;
//   MAC_TX_Data     = 0            ;
//   MAC_TX_DataK    = 0            ;
//   MAC_Data_En     = 0            ;  
//   DataBusWidth    = 8            ;

//   Reset_n         = 0            ;
//   #(10*PERIOD_CLOCK_pclk)        ;
//   Reset_n         = 1            ;
//   #(5*PERIOD_CLOCK_pclk)         ;
  
//   MAC_Data_En     = 1            ;

//   send_data(100,4)               ;
//   send_data(200,9)               ;

//   DataBusWidth = 16              ;
//   send_data(550,3)               ;

//   DataBusWidth = 32              ;
//   send_data(2024,1)              ;
//   #(50*PERIOD_CLOCK_pclk)        ;
  
// $stop;

// end


// task send_data(input [31:0] data_test , input [3:0]data_testk );
// begin
// @(negedge PCLK);
// MAC_TX_Data  = data_test   ;
// MAC_TX_DataK = data_testk  ;
// #(PERIOD_CLOCK_pclk)    ;
// end
// endtask

// endmodule