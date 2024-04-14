// Code your testbench here
// or browse Examples
`timescale 1ns / 1fs


module PMIX #(
    parameter THRESHOLD = 0,
    parameter WIDTH = 9
) (
    input             CLK,
    input      [10:0] Code,
    output         CLK_Out
);


import "DPI-C" function void generate_sin_waves(input real amplitude,input longint frequencye);

import "DPI-C" function void generate_LUTs(input real amp , input longint freq);

export "DPI-C" function  write;
  

  parameter SIZE = 2048;



  reg             clk_index;
  int             index;
  real sin_sum;
  integer         PHASE_SHIFT;

  realtime        t1;
  realtime        t2;
  realtime T1, T_;
  reg      [15:0] sin1;


  realtime        t3;
  realtime        t4;
  realtime        T1_P2;
  reg      [15:0] sin2;

  realtime        t5;
  realtime        t6;
  realtime        RESULT_PERIOD;


  reg             CLK_Out_i;
  realtime        time_now;
  reg             preparation_flag;

  //////////////////////////////////
  /////// CLK FILTERING SIGNALS/////
  //////////////////////////////////
  reg             clk_filter;
  reg glitchR_found, glitchF_found;
  //////////////////////////////////
  ////////////////////////////////// 


  real sin_0   [SIZE]; 
  real sin_45  [SIZE];
  real sin_90  [SIZE];
  real sin_135 [SIZE];
  real sin_180 [SIZE];
  real sin_225 [SIZE];
  real sin_270 [SIZE];
  real sin_315 [SIZE];
  real sin_360 [SIZE];





  reg [WIDTH-1:0] sine[0:359];

  int PPM ;


  assign CLK_Out = CLK_Out_i;


  integer i, j, k;
  realtime    last_time;  // Require time data type



  ////////////////////////////////////////////////
  //////////////// SIGN OF SIN WAVES //////////////
  ////////////////////////////////////////////////

  always @* begin
    if (sin_sum >= THRESHOLD) CLK_Out_i = 1;
    else CLK_Out_i = 0;
  end

  ////////////////////////////////////////////////
  ////////////////////////////////////////////////
  ////////////////////////////////////////////////


  initial begin
    i             = 0;
    j             = 0;
    k             = 0;
    last_time     = 0;
    T1            = 0;
    clk_filter    = 0;
    glitchF_found = 0;
    glitchR_found = 0;
  end



  initial begin
    forever begin
      @(posedge CLK);
      t1 = $realtime;
      @(posedge CLK);
      t2 = $realtime;
      T1 = t2 - t1;
      PPM = int'(((5-(1/T1))/(5))*(10**6));
    end
  end


  initial begin
    forever begin
      @(posedge CLK_Out_i);
      t5 = $realtime;
      @(posedge CLK_Out_i);
      t6 = $realtime;
      RESULT_PERIOD = t6 - t5;
    end
  end


  initial clk_index = 0;
  always #((0.0004*0.2)/2) clk_index = ~clk_index;  // (1 / 2048) * T


  ////////////////////////////////////////////////
  //////////////// INDEX CHANGE //////////////////
  ////////////////////////////////////////////////

  always @(posedge clk_index) begin
    time_now = $realtime - 0.2 * $floor($realtime / 0.2);  //T1 ---> change to T1
    index    = integer'((time_now / 0.2) * SIZE) % SIZE;
  end


  initial begin
    preparation_flag = 0;
    generate_LUTs(1.0 , 64'd5000000000);
    preparation_flag = 1 ;
  end



function automatic void write(input real arr_0[SIZE] , input real arr_45[SIZE]  , input real arr_90[SIZE]  ,input real arr_135[SIZE]  ,input real arr_180[SIZE] ,
input real arr_225[SIZE]  , input real arr_270[SIZE] , input real arr_315[SIZE] );
  
  sin_0     = arr_0   ;
  sin_45    = arr_45  ;
  sin_90    = arr_90  ;
  sin_135   = arr_135 ;
  sin_180   = arr_180 ;
  sin_225   = arr_225 ;
  sin_270   = arr_270 ;
  sin_315   = arr_315 ; 

endfunction



  ////////////////////////////////////////////////
  ////////////////////////////////////////////////
  ////////////////////////////////////////////////



  always @(*) begin
    if (preparation_flag) begin

      case (Code[10:8])

        3'b000: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_45[index]  + ((255.0 - Code[7:0])/255.0 * sin_0[index] )))      ;
        end

        3'b001: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_90[index]  + ((255.0 - Code[7:0])/255.0 * sin_45[index] )))    ;
        end

        3'b010: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_135[index] + ((255.0 - Code[7:0])/255.0 * sin_90[index] )))    ;
        end

        3'b011: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_180[index]  + ((255.0 - Code[7:0])/255.0 * sin_135[index] )))  ;
        end

        3'b100: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_225[index]  + ((255.0 - Code[7:0])/255.0 * sin_180[index] )))  ;
        end

        3'b101: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_270[index]  + ((255.0 - Code[7:0])/255.0 * sin_225[index] )))  ;
        end

        3'b110: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_315[index]  + ((255.0 - Code[7:0])/255.0 * sin_270[index] )))  ;
        end

        3'b111: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_0[index]  + ((255.0 - Code[7:0])/255.0 * sin_315[index] )))    ;
        end
      endcase

    end
  end



endmodule


////////////////////////////////////////////////////////////


module PMIX_Tb;

 reg CLK ;
 reg [10:0] Code          ; 

 wire      CLK_Out       ;

 integer i               ;

PMIX PMIX_DUT (CLK , Code , CLK_Out)       ;

always #0.1 CLK = ~CLK   ;    //5.001Ghz --> 0.1999

initial begin

  CLK     = 0;

  Code = 10'b00_1000_0000;
  #(0.2*2);
  // Code = 10'b00_1111_1111;
  // #(0.2*2);
  // Code = 10'b01_0000_0000;
  // #(0.2*2);
  // Code = 10'b01_1111_1111;
  // #(0.2*2);
  // Code = 10'b10_0000_0000;
  // #(0.2*2);
  // Code = 10'b10_1111_1111;
  // #(0.2*2);
  // Code = 10'b11_0000_0000;
  // #(0.2*2);
  // Code = 10'b11_1111_1111;
  // #(0.2*2);



#5;

  for (i = 0; i < 2050; i = (i + 1)%2048) begin
   Code = i ;
  #(0.000002);
  end
$stop();

end
endmodule      