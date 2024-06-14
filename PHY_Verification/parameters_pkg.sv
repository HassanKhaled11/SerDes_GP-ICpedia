
package PARAMETERS_PKG;

  parameter PPM_TOLERANCE_MIN = 0;
  parameter PPM_TOLERANCE_MAX = 6000;
 
  parameter REF_CLK_PERIOD_5G = 200.04;  //5GHz
  parameter PCLK_PERIOD_WIDTH8 = 2;
  parameter PCLK_PERIOD_WIDTH16 = 4;
  parameter PCLK_PERIOD_WIDTH32 = 8;  
  parameter WORD_CLOCK_PERIOD = 2;
  parameter BIT_CLOCK_PERIOD = 0.2;

`ifdef SRNS_TEST 
  parameter REF_CLK_PERIOD = 10.05;   // 100 MHZ
`elsif SRIS_TEST
  parameter REF_CLK_PERIOD = 10.00;    
`else
  parameter REF_CLK_PERIOD = 10.00;  
`endif     


endpackage
