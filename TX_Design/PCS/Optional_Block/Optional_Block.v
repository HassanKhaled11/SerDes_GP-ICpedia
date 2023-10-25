module Optional_Block #(parameter DataBusWidth = 'd32)
(
  input                                      PCLK                   ,
  input                                      Reset_n                ,
  input         [31 : 0 ]                    MAC_TX_Data            ,
  input                                      MAC_Data_En            ,  
  output  reg   [7  : 0 ]                    TxData                 ,
  output  reg                                TxDataK                ,
  output  reg                                Encoder_en             

);

reg [7:0] Temp_Data                        ;
reg [2:0] Counter                          ; 



always @(*) begin

if     (Counter == 0) Temp_Data = MAC_TX_Data [7  :0 ] ;
else if(Counter == 1) Temp_Data = MAC_TX_Data [15 :8 ] ;
else if(Counter == 2) Temp_Data = MAC_TX_Data [23 :16] ;
else                  Temp_Data = MAC_TX_Data [31 :24] ;

end





always @(posedge PCLK or negedge Reset_n)
begin

	if(!Reset_n) begin
    TxData       <= 0              ;
    TxDataK      <= 0              ;
    Encoder_en   <= 0              ; 
	end 

    else if (MAC_Data_En & Counter < (DataBusWidth/8)) begin
     TxDataK      <= 0             ;
     TxData       <= Temp_Data     ; 
     Encoder_en   <= 1             ; 
    end
      

    else begin
     TxDataK      <= 0             ;
     TxData       <= 0             ;
     Encoder_en   <= 0             ;      
    end 

end


 

always @(posedge PCLK or negedge Reset_n) begin
	if (!Reset_n) begin
     Counter <= 0              ;
	end

	else if (MAC_Data_En && DataBusWidth) begin
	 Counter <= Counter + 1    ;
	end

	else
	 Counter <= 0              ;
end




endmodule




////////////////////////////////////////
///////// TEST BENCH ///////////////////
////////////////////////////////////////




// module Optional_Block_tb ;

//   reg                                PCLK                   ;
//   reg                                Reset_n                ;
//   reg   [31 : 0 ]                    MAC_TX_Data            ;
//   reg                                MAC_Data_En            ;  
//   wire  [7  : 0 ]                    TxData                 ;
//   wire  [31 : 0 ]                    TxDataK                ;
  


// Optional_Block dut (.*);


// always #2 PCLK = ~PCLK ;


// initial begin
// PCLK = 0 ;

// MAC_TX_Data = 0 ; 
// MAC_Data_En = 0 ;

// Reset_n = 0;
// #4 ;
// Reset_n = 1;
// #2;

// @(negedge PCLK);
// MAC_TX_Data = 900;
// MAC_Data_En = 1;

// #12;

// MAC_Data_En = 0;
// #2;
// @(negedge PCLK);
// MAC_TX_Data = 456789;
// MAC_Data_En = 1;

// #12;
// MAC_Data_En = 0;
// #2;
// @(negedge PCLK);
// MAC_TX_Data = 5000345;
// MAC_Data_En = 1;

// #12;
// MAC_Data_En = 0;
// #2;

// #10
// $stop;


// end




// endmodule