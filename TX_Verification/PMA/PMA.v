
module PMA #(parameter DATA_WIDTH = 'd10)
  (
     input                    Bit_Rate_10     ,
     input                    Rst_n           ,
     input [DATA_WIDTH - 1:0] Data_in         , 
     input                    Tx_Data_Enable  , 
     output reg               TX_Out          ,
     output reg               TX_Done      
  );

  reg [$clog2(DATA_WIDTH)  : 0] counter       ;

  reg [1:0] current_state                     ;   
  reg [1:0] next_state                        ;
  reg [DATA_WIDTH - 1 : 0] Temp_Reg           ;


  localparam WAIT_STATE     = 2'b00 ;
  localparam TRANSMIT_STATE = 2'b01 ;

  always@(posedge Bit_Rate_10 or negedge Rst_n) begin
  
  if(!Rst_n)
    current_state <= WAIT_STATE ; 
  
  else
    current_state <= next_state ;
  end


  always @(*)
   begin
     case (current_state)
       
       WAIT_STATE     : begin
                          if(Tx_Data_Enable) next_state = TRANSMIT_STATE                  ;
                          else               next_state = WAIT_STATE                      ;
                        end
      

       TRANSMIT_STATE : begin
                          if(counter == DATA_WIDTH - 1)   next_state = WAIT_STATE         ;
                          else                            next_state = TRANSMIT_STATE     ;
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
                           TX_Out    = 1'b0    ;
                           Temp_Reg  = Data_in ; 
                           TX_Done = 0;
                        end
      

       TRANSMIT_STATE : begin
                          if(counter != DATA_WIDTH) begin 
                             TX_Out = Temp_Reg[counter];
                             TX_Done = 1               ;
                           end

                          else begin
                            TX_Out  = 0 ;
                            TX_Done = 0 ; 
                          end 
                        end   


       default        : begin 
                         Temp_Reg      = 0 ;
                         TX_Out        = 0 ;
                         TX_Done = 0       ;
                        end
      endcase
   end




always @(posedge Bit_Rate_10 or negedge Rst_n) begin
  if(!Rst_n) begin
     counter    <= 0             ;
  end

  else begin
     if(counter != DATA_WIDTH && current_state == TRANSMIT_STATE)
       counter <= counter + 1    ;
     else 
       counter <= 0              ; 
  end
end



endmodule







// module PMA #(parameter DATA_WIDTH = 'd10)
//   (
//      input                    Bit_Rate_10     ,
//      input                    Rst_n           ,
//      input [DATA_WIDTH - 1:0] Data_in         , 
//      input                    Tx_Data_Enable  , 
//      output   reg             TX_Out          
//   );

//   reg [DATA_WIDTH - 1 : 0] Temp_Reg;
//   reg [$clog2(DATA_WIDTH) : 0] counter;
//   reg f ;


// // assign TX_Out = (Rst_n)? Temp_Reg[counter] : 0 ;
// // assign f = (Rst_n && counter != DATA_WIDTH)? 1 : 0 ;  

//   always@(posedge Bit_Rate_10 or negedge Rst_n) 
//   begin
 
//    if(!Rst_n) 
//    begin 
//        Temp_Reg <= 0                   ;
//        TX_Out   <= 0                   ;
//        // f <= 0;
//    end
 
//    else if(Tx_Data_Enable && counter ) begin
//        Temp_Reg   <= Data_in            ;
//        TX_Out     <= Temp_Reg [counter - 1] ;
//        f <= 1 ;   
//    end

//    else begin
//        Temp_Reg   <= Data_in                  ;
//        TX_Out     <= 0                        ;
//        // f <= 0;
//    end
  
//   end
 

// always @(posedge Bit_Rate_10 or negedge Rst_n) begin
//   if(!Rst_n) begin
//      counter <= 0;
//   end

//   else begin
//      if(counter != DATA_WIDTH  && Tx_Data_Enable)
//        counter <= counter + 1    ;
//      else 
//        counter <= 0              ; 
//   end
// end




// endmodule






// module PMA #(parameter DATA_WIDTH = 'd10)
//   (
//      input                    Bit_Rate_10     ,
//      input                    Rst_n           ,
//      input [DATA_WIDTH - 1:0] Data_in         , 
//      input                    Tx_Data_Enable  , 
//      output   reg             TX_Out          
//   );


// reg [9:0] Temp_Reg ;
// reg flag ;
// always @(posedge Bit_Rate_10 or negedge Rst_n)
//     begin

//       if (!Rst_n) begin
//         Temp_Reg = 0 ;
//         TX_Out   = 0 ;
//         flag     = 0 ;
//       end
       
//       else begin
         
//         if (!Tx_Data_Enable || flag) begin    // load Data_in into temp_data when Tx_Data_Enable == 0
//             Temp_Reg <= Data_in;
//             flag     <= 0      ;
//         end
      
//         else if (Tx_Data_Enable == 1)      // enables the shift register
//         begin
//             flag     <= 1;
//             Temp_Reg <= {1'b0, Temp_Reg[9:1]};
//             TX_Out   <= Temp_Reg[0];
//         end
//      end
//    end  
// endmodule












////////////////////////////////////////////////////////////////////////////////////


// module sr_tb;

//   parameter DATA_WIDTH = 'd10             ;
//   reg                     Bit_Rate_10     ;
//   reg                     Rst_n           ;
//   reg  [DATA_WIDTH - 1:0] Data_in         ; 
//   reg                     Tx_Data_Enable  ; 
//   wire                    TX_Out          ;


//   PMA  dut(.*) ;

//   always #2 Bit_Rate_10 = ~ Bit_Rate_10 ;


//   initial begin
//     Bit_Rate_10 = 0 ;
//     Tx_Data_Enable = 0;
//     Rst_n = 0 ; 
//     #5;
//     Rst_n = 1 ;

//     Data_in = 'd50 ; 
//     Tx_Data_Enable = 1;
//     @(negedge Bit_Rate_10);
//     repeat(10) @(posedge   Bit_Rate_10);
    
//     Data_in = 'd20    ; 
//     Tx_Data_Enable = 1;
//    @(negedge Bit_Rate_10);
//     repeat(10) @(posedge   Bit_Rate_10);
    

//     Data_in = 'd5    ; 
//     Tx_Data_Enable = 1;
//    @(negedge Bit_Rate_10);
//     repeat(5) @(posedge   Bit_Rate_10);


//     Data_in = 'd50 ; 
//     Tx_Data_Enable = 0;
//    @(negedge Bit_Rate_10);
//     repeat(20) @(posedge   Bit_Rate_10);
//    @(negedge Bit_Rate_10);
//     Data_in =    'd10 ; 
//     Tx_Data_Enable = 1;

//     repeat(20) @(posedge   Bit_Rate_10);
    
//     $stop;

//   end

// endmodule  