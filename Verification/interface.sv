interface BFM_if ;

parameter DATA_WIDTH = 'd8                      ;

logic [DATA_WIDTH - 1 : 0]         TxData       ;
logic [DATA_WIDTH / 8 - 1 : 0]     TxDataK      ;
logic                              Loopback     ;
logic                              TxElecIdle   ;
logic                              TxCompilance ;
logic                              RxPolarity   ; 
logic                              Reset        ;
logic                              Powerdown    ;

logic [DATA_WIDTH - 1 : 0]         RxData       ;                        
logic [DATA_WIDTH / 8 - 1 : 0]     RxDataK      ;
logic                              RxValid      ;
logic                              PhyStatus    ;
logic                              RxElecIdle   ;
logic [2 : 0]                      RxStatus     ; 
logic                              PCLK         ; 


endinterface