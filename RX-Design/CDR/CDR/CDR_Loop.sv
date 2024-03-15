`timescale 1ns / 1fs
module CDR_Loop (
    input  rst_n,   // Asynchronous reset active low
    input  clk_0,
    // input clk_90,
    // input clk_180,
    // input clk_270,
    input  Din,
    output PI_Clk,
    output Dout
);




  cdr_assertion #(
      .clk_period_expected_min(19),
      .clk_period_expected_max(21),
      .clk_ppm_expected_max(500)
  ) pi_assertion (
      .PI_CLK_OUT(PI_Clk),
      .Data_CLK_IN(clk_0)
  );




  // wire PI_clk;
  wire up, dn;
  wire [10:0] code;
  BBPD phaseDetector (
      .Din  (Din),
      .clk  (PI_Clk),
      .rst_n(rst_n),
      .Up   (up),
      .Dn   (dn),
      .A(Dout)
  );
  Digital_Loop_Filter DLF (
      .clk  (PI_Clk),
      .rst_n(rst_n),
      .Dn   (dn),
      .Up   (up),
      .code (code)
  );

  PMIX phase_interpolator (
      .CLK   (clk_0),
      .Code   (code),
      .clk_filter_(PI_Clk)
  );


endmodule





module cdr_assertion #(
    clk_period_expected_min = 0.18,
    clk_period_expected_max = 0.31,
    clk_ppm_expected_max = 2000
) (
    input PI_CLK_OUT,
    input Data_CLK_IN
);


  property CLK_OUT_PERIOD_prop(time clk_period_expected_min, time clk_period_expected_max);
    realtime current_time;
    @(posedge PI_CLK_OUT) ('1,
    current_time = $realtime()
    ) |=> ((clk_period_expected_min <= int'(100 * ($realtime() - current_time))) &&
           (clk_period_expected_max >= int'(100 * ($realtime() - current_time))));
  endproperty

  CLK_OUT_PERIOD_assert :
  assert property (CLK_OUT_PERIOD_prop(clk_period_expected_min, clk_period_expected_max));
  CLK_OUT_PERIOD_cover :
  cover property (CLK_OUT_PERIOD_prop(clk_period_expected_min, clk_period_expected_max));



  property CLK_OUT_PPM_prop(int clk_ppm_expected_max);
    realtime current_time;
    @(posedge PI_CLK_OUT) ('1,current_time = $realtime()) |=> 
                          (clk_ppm_expected_max >= int'(((5-(1/($realtime()- current_time)))/(5))*(10**6)),$display("PPM = %d",int'(((5-(1/($realtime()- current_time)))/(5))*(10**6))));
  endproperty

  
  CLK_PPM_assert:
  assert property (CLK_OUT_PPM_prop(clk_ppm_expected_max)); 
  CLK_PPM_cover:
  cover property (CLK_OUT_PPM_prop(clk_ppm_expected_max));







  property CLK_DATA_PPM_prop(int clk_ppm_expected_max);
    realtime current_time;
    @(posedge Data_CLK_IN) ('1,current_time = $realtime()) |=> 
                          (clk_ppm_expected_max >= int'(((5-(1/($realtime()- current_time)))/(5))*(10**6)),$display("DATA_PPM = %d",int'(((5-(1/($realtime()- current_time)))/(5))*(10**6))));
  endproperty

  
  DCLK_PPM_assert:
  assert property (CLK_DATA_PPM_prop(clk_ppm_expected_max)); 
  DCLK_PPM_cover:
  cover property (CLK_DATA_PPM_prop(clk_ppm_expected_max));





endmodule

