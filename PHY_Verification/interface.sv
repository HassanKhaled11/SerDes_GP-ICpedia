interface BFM_if;

  parameter DATA_WIDTH = 10;
  // PORTS


  //////// INPUTS //////////

  logic          Ref_CLK;
  logic          Reset_n;
  logic [ 5 : 0] DataBusWidth;
  logic [31 : 0] MAC_TX_Data;
  logic [ 3 : 0] MAC_TX_DataK;
  logic          MAC_Data_En;
  logic          RxPolarity;
  logic          Bit_CLK_Offset;

  ///////// OUTPUTS ///////// 
  logic          TX_Out_P;
  logic          TX_Out_N;
  logic [31 : 0] Rx_Data;
  logic          Rx_DataK;
  logic [ 2 : 0] Rx_Status;
  logic          Rx_Valid;
  logic          PCLK;

endinterface




interface INTERNALS_if;

  bit         Bit_CLK;
  bit         Word_CLK;
  bit         PCLK;
  logic [5:0] DataBusWidth;
  bit         TX_Out_P;


endinterface
