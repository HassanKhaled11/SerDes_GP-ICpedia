// module golden_model #(parameter DATA_WIDTH = 'd10)(

// input  logic                    Bit_Rate_10    , 
// input  logic                    Rst_n          , 
// input  logic [DATA_WIDTH - 1:0] Data_in        ,  
// input  logic                    Tx_Data_Enable ,  
// output logic [DATA_WIDTH - 1:0] TX_Out         

// );


// always @(posedge Bit_Rate_10 , negedge Rst_n) begin
// 	if(!Rst_n) begin
// 		TX_Out <= 0       ;
// 	end

// 	else if(Tx_Data_Enable) begin
// 		TX_Out <= Data_in ; 
// 	end
// end


// endmodule





module golden_model #(parameter DATA_WIDTH = 'd10)
  (
     input                    Bit_Rate_10     ,
     input                    Rst_n           ,
     input [DATA_WIDTH - 1:0] Data_in         , 
     input                    Tx_Data_Enable  , 
     output   reg             TX_Out          
  );

  reg [DATA_WIDTH - 1 : 0] Temp_Reg;
  reg [$clog2(DATA_WIDTH) : 0] counter;
  

  

  always@(posedge Bit_Rate_10 or negedge Rst_n) 
  begin
 
   if(!Rst_n) 
   begin 
       Temp_Reg <= 0                   ;
       TX_Out   <= 0                   ;
     
   end
 
   else if(Tx_Data_Enable && counter ) begin
       Temp_Reg   <= Data_in            ;
       TX_Out     <= Temp_Reg [counter - 1] ;
       
   end

   else begin
       Temp_Reg   <= Data_in                  ;
       TX_Out     <= 0                        ;

   end
  
  end
 

always @(posedge Bit_Rate_10 or negedge Rst_n) begin
  if(!Rst_n) begin
     counter <= 0;
  end

  else begin
     if(counter != DATA_WIDTH  && Tx_Data_Enable)
       counter <= counter + 1    ;
     else 
       counter <= 0              ; 
  end
end


endmodule