module PMA_TX #(parameter DATA_WIDTH = 'd10)
  (
     input                    Bit_Rate_Clk    ,
     input                    Rst_n           ,
     input [DATA_WIDTH - 1:0] Data_in         , 
     input                    MAC_Data_En     , 
     output reg               TX_Out_P        ,
     output                   TX_Out_N            
  );


  reg [$clog2(DATA_WIDTH)  : 0] counter       ;

  reg [1:0] current_state                     ;   
  reg [1:0] next_state                        ;
  reg [DATA_WIDTH - 1 : 0] Temp_Reg           ;
  reg [DATA_WIDTH - 1 : 0] Temp_Reg_           ;

  localparam WAIT_STATE     = 2'b00 ;
  localparam TRANSMIT_STATE = 2'b01 ;


 assign TX_Out_N = ~TX_Out_P;

       
  always@(posedge Bit_Rate_Clk or negedge Rst_n) begin
  
  if(!Rst_n)
    current_state <= WAIT_STATE ; 
  
  else
    current_state <= next_state ;
  end


  always @(*)
   begin
     case (current_state)
       
       WAIT_STATE     : begin
                          if(MAC_Data_En) next_state = TRANSMIT_STATE          ;
                          else            next_state = WAIT_STATE              ;
                        end
      

       TRANSMIT_STATE : begin
                          if(counter == DATA_WIDTH - 1)  begin
                                if(MAC_Data_En)
                                 next_state = TRANSMIT_STATE                   ;
                                else   
                                 next_state = WAIT_STATE                       ;
                          end 

                
                          else  next_state = TRANSMIT_STATE                               ;
          
                        end

       default        : begin 
                            next_state = WAIT_STATE                                       ;  
                        end                            
  
     endcase
   end



   always @(*) 
   begin
    
     case (current_state)
       
       WAIT_STATE     : begin
                           TX_Out_P    = 1'b0      ;
                           Temp_Reg    = Data_in   ; 
                        end
      

       TRANSMIT_STATE : begin
                          Temp_Reg = Data_in   ;
                          if(counter != DATA_WIDTH) begin 
                             TX_Out_P = Temp_Reg_[counter];
                           end

                          else begin
                            TX_Out_P  = 0 ;
                          end 
                        end   


       default        : begin 
                            Temp_Reg      = 0 ;
                            TX_Out_P        = 0 ;
                        end
      endcase
   end




always @(posedge Bit_Rate_Clk or negedge Rst_n) begin
  if(!Rst_n) begin
     counter    <= 0             ;
  end

  else begin
     if(counter != DATA_WIDTH-1 && current_state == TRANSMIT_STATE)
       counter <= counter + 1    ;
     else 
       counter <= 0              ; 
  end
end



always @(posedge Bit_Rate_Clk or negedge Rst_n) begin
  if(!Rst_n) begin
     Temp_Reg_    <= 0             ;
  end

  else begin
    Temp_Reg_ <= Temp_Reg   ; 
  end
end





endmodule







//////////////////////////////// TESTBENCH /////////////////////////////////////////////


module PMA_TX_tb;

  parameter DATA_WIDTH = 'd10             ;
  reg                     Bit_Rate_Clk    ;
  reg                     Rst_n           ;
  reg  [DATA_WIDTH - 1:0] Data_in         ; 
  reg                     MAC_Data_En     ; 
  wire                    TX_Out_P        ;
  wire                    TX_Out_N        ;   

  PMA  dut(.*) ;

  always #2 Bit_Rate_Clk = ~ Bit_Rate_Clk ;


  initial begin
    Bit_Rate_Clk = 0 ;
    MAC_Data_En = 0;
    Rst_n = 0 ; 
    #5;
    Rst_n = 1 ;


  

  SEND_DATA(100);
  SEND_DATA(200);
  SEND_DATA(30) ;

  repeat(20) @(posedge   Bit_Rate_Clk);
    
  $stop;

  end


task SEND_DATA(input [9:0] data_in);
  begin
    
  @(negedge Bit_Rate_Clk);
  MAC_Data_En = 1 ;
  Data_in = data_in ;
  #(10*4);
 
  end
endtask 


endmodule  