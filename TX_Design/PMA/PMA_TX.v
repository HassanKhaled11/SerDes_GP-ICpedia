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


module PMA_TX_tb;

  parameter DATA_WIDTH = 'd10             ;

  reg                     Bit_Rate_Clk_10 ;
  reg                     Bit_Rate_Clk    ;
  reg                     Rst_n           ;
  reg  [DATA_WIDTH - 1:0] Data_in         ; 
  reg                     MAC_Data_En     ; 
  wire                    TX_Out_P        ;
  wire                    TX_Out_N        ;   

  PMA_TX  dut(.*) ;

  always #2   Bit_Rate_Clk      = ~ Bit_Rate_Clk     ;
  always #20  Bit_Rate_Clk_10   = ~ Bit_Rate_Clk_10  ;


  initial begin
    Bit_Rate_Clk     = 1 ;
    Bit_Rate_Clk_10  = 1 ;
    MAC_Data_En = 0;

    Rst_n = 0 ; 
    #5;
    Rst_n = 1 ;


  

  SEND_DATA(100) ;
  SEND_DATA(200) ;
  SEND_DATA(200) ;
  SEND_DATA(30)  ;

  @(negedge Bit_Rate_Clk_10);
  MAC_Data_En = 1 ;
  Data_in = 50    ;
  #(8*4);

  Data_in = 10    ;
  #(8*4);

  MAC_Data_En = 0;

  Data_in = 70;

  repeat(20) @(posedge   Bit_Rate_Clk);
    
  $stop;

  end


task SEND_DATA(input [9:0] data_in);
  begin
    
  @(negedge Bit_Rate_Clk_10);
  MAC_Data_En = 1 ;
  Data_in = data_in ;
  #(10*4);
 
  end
endtask 


endmodule  