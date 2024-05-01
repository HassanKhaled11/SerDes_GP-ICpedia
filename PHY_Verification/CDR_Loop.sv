`timescale 1ns / 1fs
module CDR_Loop (
    input rst_n,  // Asynchronous reset active low
    input clk_0,
    input clk_data,
    // input clk_90,
    // input clk_180,
    // input clk_270,
    input Din,
    output PI_Clk,
    output Dout
);

`ifdef THREE_CLKS

wire clk_90 ;
wire clk_180;

`endif


  // wire PI_clk;
  wire up, dn;
  wire [10:0] code;
  reg voting_clk;

  parameter NUMBER_SAMPLES = 3;
  parameter period = 0.2;

  initial begin
    voting_clk = 0;
    forever #((period / 2) / NUMBER_SAMPLES) voting_clk = ~voting_clk;  //200/5 (5 samples per bits)
  end



  BBPD phaseDetector (
      .Din  (Din),
      .clk  (PI_Clk),
      .clk_ref(clk_0),
      `ifdef THREE_CLKS
        .clk_90  (clk_90)  ,
        .clk_180 (clk_180) ,
      `endif  
      .rst_n(rst_n),
      .Up   (up),
      .Dn   (dn),
      .A(Dout)
  );


  Box_Car_Voting #(.NUMBER_SAMPLES(NUMBER_SAMPLES)) Voting_U (
    .clk     (voting_clk),
    .Dn      (dn),
    .Up      (up),
    .vote_Dn (vote_Dn),
    .vote_Up (vote_Up)
);


  Digital_Loop_Filter DLF_U (
      .clk  (clk_0),
      .rst_n(rst_n),
      .Dn   (vote_Dn),
      .Up   (vote_Up),
      .code (code)
  );



  PMIX phase_interpolator (
      .CLK   (clk_0),
      .Code   (code),
      // .clk_filter_(PI_Clk)
      `ifdef THREE_CLKS
        .rst_n(rst_n),
        .clk_90 (clk_90)  ,
        .clk_180 (clk_180),
      `endif    
      .CLK_Out_i(PI_Clk)
  );



  int fd;
  initial begin
    fd = $fopen("./Up_Dn.hex", "w");

  end

  always @(up, dn) begin
    $fwrite(fd, "%h,%h\n", up, dn);
  end


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



  // property CLK_OUT_PPM_prop(int clk_ppm_expected_max);
  //   realtime current_time;
  //   @(posedge PI_CLK_OUT) ('1,
  //   current_time = $realtime()
  //   ) |=> (clk_ppm_expected_max >= int
  //          '(((5000.0 - (1000.0 / ($realtime() - current_time))) / (5000)) * (10 ** 6)), $display(
  //       "PI clk: PPM = %f,curr freq=%f, curr period=%f",
  //       int'(((5000.0 - (1000.0 / ($realtime() - current_time))) / (5000.0)) * (10 ** 6)),
  //       (1000.0 / ($realtime() - current_time)),
  //       ($realtime() - current_time)
  //   ));
  // endproperty
  property CLK_OUT_PPM_prop(int clk_ppm_expected_max);
    realtime current_time;
    @(posedge PI_CLK_OUT) ('1,
    current_time = $realtime()
    ) |=> (clk_ppm_expected_max >= int
           '((((1000.0 / ($realtime() - current_time)) > 5000.0) ?
              (((1000.0 / ($realtime() - current_time)) - 5000.0) / 5000.0) :
              ((5000.0 - (1000.0 / ($realtime() - current_time))) / 5000.0)) * (10 ** 6)), $display(
        "PI clk: PPM = %5d  ,curr freq = %f ,curr period = %f",
        int'((((1000.0 / ($realtime() - current_time)) > 5000.0) ? 
                                      (((1000.0 / ($realtime() - current_time)) - 5000.0) / 5000.0) :
                                      ((5000.0 - (1000.0 / ($realtime() - current_time))) / 5000.0)
                                     ) * (10 ** 6)),
        (1000.0 / ($realtime() - current_time)),
        ($realtime() - current_time)
    ));
  endproperty

  CLK_PPM_assert :
  assert property (CLK_OUT_PPM_prop(clk_ppm_expected_max));
  CLK_PPM_cover :
  cover property (CLK_OUT_PPM_prop(clk_ppm_expected_max));







  property CLK_DATA_PPM_prop(int clk_ppm_expected_max);
    realtime current_time;
    @(posedge Data_CLK_IN) ('1,
    current_time = $realtime()
    ) |=> (clk_ppm_expected_max >= int
           '((((1000.0 / ($realtime() - current_time)) > 5000.0) ?
              (((1000.0 / ($realtime() - current_time)) - 5000.0) / 5000.0) :
              ((5000.0 - (1000.0 / ($realtime() - current_time))) / 5000.0)) * (10 ** 6)), $display(
        "Data  : PPM = %5d , max ppm= %5d ,curr freq = %f ,curr period = %f",
        int'((((1000.0 / ($realtime() - current_time)) > 5000.0) ? 
                                      (((1000.0 / ($realtime() - current_time)) - 5000.0) / 5000.0) :
                                      ((5000.0 - (1000.0 / ($realtime() - current_time))) / 5000.0)
                                     ) * (10 ** 6)),
        clk_ppm_expected_max,
        (1000.0 / ($realtime() - current_time)),
        ($realtime() - current_time)
    ));
  endproperty



  DCLK_PPM_assert :
  assert property (CLK_DATA_PPM_prop(clk_ppm_expected_max));
  DCLK_PPM_cover :
  cover property (CLK_DATA_PPM_prop(clk_ppm_expected_max));



  //   property PPM_ERROR_prop(clk_ppm_error_expected_max = 0.1);
  //     // realtime data = 0
  //     // ;
  //     realtime clk = 0
  //     ;
  //     realtime clk_out = 0;
  //     @(posedge Data_CLK_IN)('1,     clk_out = $realtime()
  // )|=> (clk_ppm_error_expected_max >= (clk - clk_out))
  //     // @(data) ('1,data= $realtime());
  //     @(posedge PI_CLK_OUT) ('1,
  //     clk = $realtime()
  //     ) |=> (clk_ppm_error_expected_max >= (clk - clk_out))
  //   endproperty

  //   PPM_error_assert :
  //   assert property (PPM_ERROR_prop(clk_ppm_error_expected_max));
  //   PPM_error_cover :
  //   cover property (PPM_ERROR_prop(clk_ppm_error_expected_max));


  realtime clks_queue[$];
  realtime curr_pi_clk;
  realtime curr_data_clk;
  realtime ppm_error;
  // always @(posedge PI_CLK_OUT) begin
  //   curr_pi_clk = $realtime();
  //   clks_queue.push_front(curr_pi_clk);
  // end

  // always @(posedge Data_CLK_IN) begin
  //   curr_data_clk = $realtime();
  //   clks_queue.push_front(curr_data_clk);
  // end

  // always @(clks_queue) begin
  //   if (clks_queue.size() == 2) ppm_error = clks_queue[1] - clks_queue[0];
  //   $display("ppm_error=%t", ppm_error);
  //   clks_queue.pop_back();
  //   clks_queue.pop_back();
  // end

  always @(PI_CLK_OUT or Data_CLK_IN) begin
    curr_pi_clk = $realtime();
    if (clks_queue.size() == 2) begin
      ppm_error = clks_queue[1] - clks_queue[0];
      clks_queue.pop_back();
      clks_queue.pop_back();
      $display("ppm_error=%t", ppm_error);
    end else begin
      clks_queue.push_back(curr_pi_clk);
    end

  end



endmodule

