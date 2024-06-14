module PMA_TX #(parameter DATA_WIDTH = 'd10)
  (
   input                    Bit_Rate_Clk_10 ,  
   input                    Bit_Rate_Clk    ,
   input                    Rst_n           ,
   input [DATA_WIDTH - 1:0] Data_in         , 
   input                    MAC_Data_En     , 
   output  reg              TX_Out_P        ,   
   output                   TX_Out_N            
  );


reg [DATA_WIDTH - 1 : 0] Temp_Reg           ;
reg [DATA_WIDTH - 1 : 0] Temp_Reg2          ;
reg [3              : 0] Counter            ; 
reg                      flag               ;



assign TX_Out_N = ~TX_Out_P                 ;


always @(posedge Bit_Rate_Clk_10 or negedge Rst_n) begin
  if (!Rst_n) begin
    Temp_Reg <= 0                    ;
    flag     <= 0                    ;    
  end

  else if (MAC_Data_En && Counter != 10) begin
    Temp_Reg <= Data_in              ;
    flag     <= 1                    ; 
  end

  else begin
    Temp_Reg <= Data_in              ;
    flag     <= 0                    ;
  end
end



always @(posedge Bit_Rate_Clk or negedge Rst_n) begin
 if(!Rst_n) begin
   Temp_Reg2 <= 0              ;
 end

 else if(Counter == 0) begin
  Temp_Reg2 <= Temp_Reg        ;
 end

 else
 Temp_Reg2 <= Temp_Reg2 >> 1   ;

end



always @(posedge Bit_Rate_Clk or negedge Rst_n) begin
 if(!Rst_n) begin
   TX_Out_P <= 0                 ;
 end

 else begin
  TX_Out_P <= Temp_Reg2[0]        ;
 end

end



always @(posedge Bit_Rate_Clk or negedge Rst_n) begin
  if(~Rst_n) begin
    Counter <= 0            ;
  end

  else if(Counter != 9 && flag) begin
    Counter <=  Counter + 1 ;
  end

  else 
    Counter <= 0            ;
end



endmodule



//////////////////////////////////////////////////////
 
