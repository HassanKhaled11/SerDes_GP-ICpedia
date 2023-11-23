interface TX_if ;

parameter  DATA_WIDTH = 'd32            ;
// PORTS
logic Ref_CLK;
logic Reset_n;
logic [5:0] DataBusWidth;
logic [31:0] MAC_TX_Data;
logic [3:0] MAC_TX_DataK;
logic MAC_Data_En;
logic TX_Out_P;
logic TX_Out_N;

endinterface




interface CLK_if ;


// PORTS
logic  Bit_Rate_Clk;      
logic  Bit_Rate_CLK_10;  
logic  PCLK         ;
 
 

endinterface



// interface  golden_if ;
// parameter  DATA_WIDTH = 'd10            ;	
// logic                    Bit_Rate_10    ; 
// logic                    Rst_n          ; 
// logic [DATA_WIDTH - 1:0] Data_in        ;  
// logic                    Tx_Data_Enable ;  
// logic                    TX_Out         ;
// logic                    TX_Done        ;
// endinterface 

