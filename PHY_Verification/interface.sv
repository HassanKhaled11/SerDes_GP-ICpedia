interface BFM_if ;

parameter DATA_WIDTH = 10;
  // PORTS


  //////// INPUTS //////////

  logic                        Ref_CLK          ;
  logic                        Reset_n          ;
  logic         [5  : 0 ]      DataBusWidth     ;
  logic         [31 : 0 ]      MAC_TX_Data      ;
  logic         [3  : 0 ]      MAC_TX_DataK     ;
  logic                        MAC_Data_En      ;

 
  
  ///////// OUTPUTS ///////// 

  logic         [31 : 0 ]      Rx_Data          ;
  logic                        Rx_DataK         ;
  logic         [2  : 0 ]      Rx_Status        ; 
  logic                        Rx_Valid         ;
  logic                        PCLK             ; 

endinterface




interface  INTERNALS_if;

  parameter DATA_WIDTH = 10;


  bit   write_clk;
  bit   read_clk;
  logic [DATA_WIDTH-1:0] data_in;
  logic buffer_mode;                      //0:nominal half full ,1:nominal empty buffer
  logic write_enable;
  logic read_enable;
  logic rst_n;

  //OUTPUTS
  logic skp_added;
  logic Skp_Removed;
  logic overflow, underflow;
  logic [DATA_WIDTH-1:0] data_out;


endinterface 