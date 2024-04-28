
package PARAMETERS_PKG;

  //typedef enum logic [9:0] {FIRST = 10'h001, SECOND = 10'h200, THIRD = 10'h100, FOURTH = 10'h080,FIFTH =  10'h040, SIXTH = 10'h020, SEVENTH = 10'h010,EIGHTH = 10'h008, NINTH = 10'h004, TENTH = 10'h002} e_WALKING_ONES ;

  parameter PPM_TOLERANCE_MIN = 0;
  parameter PPM_TOLERANCE_MAX = 3000;
  parameter REF_CLK_PERIOD_5G = 200;  //5GHz
  parameter REF_CLK_PERIOD = 10;  // 100 MHZ
  parameter PCLK_PERIOD_WIDTH8 = 2;
  parameter PCLK_PERIOD_WIDTH16 = 4;
  parameter PCLK_PERIOD_WIDTH32 = 8;  // 
  parameter WORD_CLOCK_PERIOD = 2;
  parameter BIT_CLOCK_PERIOD = 0.2;


endpackage
