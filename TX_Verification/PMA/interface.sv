interface BFM_if ;

parameter  DATA_WIDTH = 'd10             ;
// PORTS
logic                    Bit_Rate_10     ;
logic                    Rst_n           ;
logic [DATA_WIDTH - 1:0] Data_in         ; 
logic                    Tx_Data_Enable  ; 
logic                    TX_Out          ;
logic                    TX_Done         ;

endinterface


interface  golden_if ;
parameter  DATA_WIDTH = 'd10            ;	
logic                    Bit_Rate_10    ; 
logic                    Rst_n          ; 
logic [DATA_WIDTH - 1:0] Data_in        ;  
logic                    Tx_Data_Enable ;  
logic                    TX_Out         ;
logic                    TX_Done        ;
endinterface 

