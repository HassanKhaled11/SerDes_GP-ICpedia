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



reg        Counter_16         ;
reg [1:0]  Counter_32         ;
reg [7:0]  Temp_Reg           ; 
reg        Tempk_Reg          ;  
reg [31:0] MAC_TX_Data_temp   ;
reg [3 :0] MAC_TX_DataK_temp  ;
reg        Enable             ;

///////////////////////////////////////////////////////////////

always @(posedge PCLK) begin
  if(~Reset_n) begin
     MAC_TX_Data_temp  <= 0 ;
     MAC_TX_DataK_temp <= 0 ;
  end 

  else if(MAC_Data_En)begin
    MAC_TX_Data_temp   <= MAC_TX_Data  ;
    MAC_TX_DataK_temp  <= MAC_TX_DataK ;
    Enable             <= 1            ;
  end

  else begin
    MAC_TX_Data_temp   <= MAC_TX_Data  ;
    MAC_TX_DataK_temp  <= MAC_TX_DataK ;
    Enable             <= 0            ;
  end
end


///////////////////////////////////////////////////////////////


always@(*) begin

if (!Reset_n) begin
   Temp_Reg  = 0 ;
   Tempk_Reg = 0 ;
end


else  begin
  
  case (DataBusWidth)
  
  6'd8 : begin
          Temp_Reg  = MAC_TX_Data_temp [7:0];
          Tempk_Reg = MAC_TX_DataK_temp[0]  ;
         end


  6'd16 : begin
          if(Counter_16 == 0)  begin 
           Temp_Reg  = MAC_TX_Data_temp[7 :0 ];
           Tempk_Reg = MAC_TX_DataK_temp[0]  ;
          end

          else begin
            Temp_Reg  = MAC_TX_Data_temp[15:8 ];
            Tempk_Reg = MAC_TX_DataK_temp[1]  ;             
          end
          end 


  6'd32 : begin
           if      (Counter_32 == 0) begin 
           Temp_Reg  = MAC_TX_Data_temp[7 :0 ];
           Tempk_Reg = MAC_TX_DataK_temp[0]   ;
           end

           else if (Counter_32 == 1) begin
           Temp_Reg  = MAC_TX_Data_temp  [15:8 ];
           Tempk_Reg = MAC_TX_DataK_temp [1]    ;
           end

           else if (Counter_32 == 2) begin
            Temp_Reg  = MAC_TX_Data_temp[23:16];
            Tempk_Reg = MAC_TX_DataK_temp[2]   ;
           end

           else  begin
            Temp_Reg  = MAC_TX_Data_temp[31:24];                  
            Tempk_Reg = MAC_TX_DataK_temp[3]   ;            
           end
         end 

  default: begin
            Temp_Reg  = MAC_TX_Data_temp[7:0] ;
            Tempk_Reg = MAC_TX_DataK_temp[0]  ;
          end
  endcase

 end
end


///////////////////////////////////////////////////////////////


always@(posedge Bit_Rate_CLK_10 or negedge Reset_n) begin

if(!Reset_n) begin
Counter_16 <= 0           ;
Counter_32 <= 0           ; 
TxData     <= 0           ;
TxDataK    <= 0           ;
end

else if (Enable) begin

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
endmodule


///////////////////////////////////////////////////////////////


