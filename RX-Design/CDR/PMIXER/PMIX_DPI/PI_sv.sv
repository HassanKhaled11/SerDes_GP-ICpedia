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
import "DPI-C" function real Do_Interpolation(input real Code , input real index);
import "DPI-C" function real generate_LUTs(input real Code , input real index , input real amp , input longint freq);

  

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

  reg [WIDTH-1:0] sine[0:359];

  int PPM ;


  assign CLK_Out = CLK_Out_i;


  integer i, j, k;
  realtime    last_time;  // Require time data type


 real temp  ;
 real temp2 ;


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
  always #(0.004) clk_index = ~clk_index;  //0.0002


  ////////////////////////////////////////////////
  //////////////// INDEX CHANGE //////////////////
  ////////////////////////////////////////////////

  always @(posedge clk_index) begin
    time_now = $realtime - 0.2 * $floor($realtime / 0.2);  //T1 ---> change to T1
    index    = integer'((time_now / 0.2) * 1024) % 1024;
  end


  initial begin
    preparation_flag = 0;
    temp    = generate_LUTs(Code, index ,1.0 , 64'd5000000000);
    preparation_flag = 1 ;
   // $display("temp = ",temp);
  end

  always @(Code or index) begin
    if(preparation_flag) begin
      sin_sum = Do_Interpolation(Code ,index);
    //$display("sin_sum = ",sin_sum);  
    end
  end
  

  ////////////////////////////////////////////////
  ////////////////////////////////////////////////
  ////////////////////////////////////////////////



  // always @(*) begin
  //   // if (!glitchF_found) begin
  //   @(posedge CLK_Out_i);
  //   clk_filter = 1;
  //   // #0.000002;
  //   #0.01;
  //   // $display("HERE 11,out = %b , filter = %b ,t= %t", CLK_Out_i, clk_filter, $realtime);

  //   if (clk_filter != CLK_Out_i) begin
  //     clk_filter_ = 0;
  //     // glitchR_found = 1;
  //     // $display("HERE 1, t= %t", $realtime);
  //   end else begin
  //     clk_filter_ = 1;
  //     // glitchR_found = 0;
  //     // $display("HERE 2");
  //   end
  //   // end
  // end


  // always @(*) begin
  //   // if (!glitchR_found) begin
  //   @(negedge CLK_Out_i);
  //   clk_filter = 0;
  //   // #0.000002;
  //   #0.01;
  //   if (clk_filter != CLK_Out_i) begin
  //     clk_filter_ = 1;
  //     // glitchF_found = 1;
  //     // $display("HERE 3");
  //   end else begin
  //     clk_filter_ = 0;
  //     // glitchF_found = 1'b0;
  //     // $display("HERE 4");
  //   end
  //   // end
  // end


endmodule


////////////////////////////////////////////////////////////


module PMIX_Tb;

 reg CLK ;
 reg [10:0] Code          ; 

 wire      CLK_Out       ;

 integer i               ;

PMIX PMIX_DUT (CLK , Code , CLK_Out)       ;

always #0.1999 CLK = ~CLK   ;    //5.001Ghz --> 0.1999

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
  #(0.00002);
  end
$stop();

end
endmodule      