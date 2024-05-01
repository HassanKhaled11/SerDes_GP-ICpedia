`timescale 1ps / 1fs
module PPM_checker #(
    parameter real PERIOD  = 200.0,
    parameter real MAX_PPM = 50.0
) (
    input logic clk,
    input logic PI_clk,
    input logic Rst_n
);
  realtime current_period = 0;
  realtime previous_rising_edge = 0;
  always_ff @(posedge clk or negedge Rst_n) begin
    if (~Rst_n) begin
      current_period = $realtime();
    end else begin
      current_period = $realtime() - previous_rising_edge;
      previous_rising_edge = $realtime();
    end
  end

  //PPM calculation
  int PPM_value;
  always @(current_period) begin
    PPM_value = 1e6 * (current_period - PERIOD) / PERIOD;
  end

   property PPM_check;
   (@(posedge clk) (Rst_n && (PPM_value >= -MAX_PPM && PPM_value<= MAX_PPM  ) )
  //  ,   $display(
  //           "Assertion passed: Current period = %0.2f ps, PPM deviation = %0.2f, within max allowed %0.2f PPM",
  //           current_period, PPM_value, MAX_PPM
  //       )
        ) 

   endproperty

  property clk_glitch_check;
   (@(posedge clk) (Rst_n && current_period> 0.25* PERIOD)
  //  ,   $display(
  //           "Assertion passed: Current period = %0.2f ps, PPM deviation = %0.2f, within max allowed %0.2f PPM",
  //           current_period, PPM_value, MAX_PPM
  //       )
        ) 
   endproperty

assert_PPM:assert property (PPM_check)  
        else
          begin
            @(posedge clk)
    $display(
        "Clock period PPM deviation out of bounds: %0.2f PPM , max allowed PPM: %0.2f, Current period = %0.2f ps, neg_PPM = %0.2f",
        $past(PPM_value),

        MAX_PPM,
        current_period,
        -MAX_PPM
    );
          end
cover_assert_PPM:cover property  ( PPM_check);

assert_no_glitch:assert property (clk_glitch_check)  
        else
    $error(
        "%t: Clock period: %0.2f , normal period: %0.2f",
        $time,
        $past(current_period),
        PERIOD
    );
cover_no_glitch:cover property  ( clk_glitch_check); 


////////////////////////////////////////////////
////////////////PI_CLK//////////////////////////
////////////////////////////////////////////////

realtime PI_current_period = 0;
  realtime PI_previous_rising_edge = 0;
  always_ff @(posedge PI_clk or negedge Rst_n) begin
    if (~Rst_n) begin
      PI_current_period = $realtime();
    end else begin
      PI_current_period = $realtime() - PI_previous_rising_edge;
      PI_previous_rising_edge = $realtime();
    end
  end

  //PPM calculation
  int PI_PPM_value;
  always @(PI_current_period) begin
    PI_PPM_value = 1e6 * (PI_current_period - PERIOD) / PERIOD;
  end

   property PI_PPM_check;
   (@(posedge PI_clk) (Rst_n && (PI_PPM_value >= -MAX_PPM && PI_PPM_value<= MAX_PPM  ) )
  //  ,   $display(
  //           "Assertion passed: PI Current period = %0.2f ps, PPM deviation = %0.2f, within max allowed %0.2f PPM",
  //           PI_current_period, PI_PPM_value, MAX_PPM
  //       )
        ) 
   endproperty

  property PI_clk_glitch_check;
   (@(posedge PI_clk) (Rst_n && PI_current_period> 0.25* PERIOD)
  //  ,   $display(
  //           "Assertion passed: PI Current period = %0.2f ps, PPM deviation = %0.2f, within max allowed %0.2f PPM",
  //           PI_current_period, PI_PPM_value, MAX_PPM
  //       )
        ) 
   endproperty

assert_PI_PPM:assert property (PI_PPM_check)  
        else begin
         @(posedge PI_clk)
    $display(
        "PI Clock period PPM deviation out of bounds: %0.2f PPM , max allowed PPM: %0.2f, Current period = %0.2f ps, neg_PPM = %0.2f",
        $past(PI_PPM_value),
        MAX_PPM,
        PI_current_period,
        -MAX_PPM
    );
        end
cover_assert__PI_PPM:cover property  (PI_PPM_check);

assert_no_PI_glitch:assert property (PI_clk_glitch_check)  
        else
    $error(
        "%t: Clock period: %0.2f , normal period: %0.2f",
        $time,
        PI_current_period,
        PERIOD
    );
cover_no_PI_glitch:cover property  (PI_clk_glitch_check);  




endmodule