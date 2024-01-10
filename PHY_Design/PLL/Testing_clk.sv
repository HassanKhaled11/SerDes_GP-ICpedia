`timescale 1ps / 1ps

module clk_test ();
  logic Ref_Clk;
  logic Rst;
  // logic [7:0] div_ratio;
  logic Bit_Rate;
  logic Bit_Rate_10;
  logic PCLK;

  int   Bit_Rate_rising_time;
  int   Old_Bit_Rate_rising_time;
  int   Bit_Rate_falling_time;
  bit   bit_rate_failed_flag;
  int   bit_rate_period;

  int   Bit_Rate_10_rising_time;
  int   Old_Bit_Rate_10_rising_time;
  int   Bit_Rate_10_falling_time;
  bit   bit_rate_10_failed_flag;
  int   bit_rate_10_period;

  int   Pclk_rising_time;
  int   Old_Pclk_rising_time;
  int   Pclk_falling_time;
  bit   pclk_failed_flag;
  int   pclk_period;

  int correct_count, error_count;
  PLL testing_pll (
      .Ref_Clk    (Ref_Clk),
      .Rst        (Rst),
      .Bit_Rate   (Bit_Rate),
      .Bit_Rate_10(Bit_Rate_10),
      // .div_ratio(div_ratio),
      .PCLK       (PCLK)
  );
  initial begin
    Ref_Clk = 0;
    repeat (50) #5000 Ref_Clk = ~Ref_Clk;
  end

  /////////////////PCLK////////////////////////
  // rising time  
  always @(posedge PCLK) begin
    Old_Pclk_rising_time = Pclk_rising_time;
    Pclk_rising_time = $time;
  end
  // falling time  
  always @(negedge PCLK) begin
    if (Rst) begin
      Pclk_falling_time = $time;
      pclk_period       = (Pclk_rising_time - Old_Pclk_rising_time);

      if (Old_Pclk_rising_time != 0 && pclk_period != 4000) begin
        pclk_failed_flag = 1;
        $display("%0t:period bit_rate_10 = %0dps", $time, pclk_period);
        error_count++;
      end else correct_count++;

      //check duty cycle
      if ( Old_Pclk_rising_time!=0 && ((Pclk_falling_time - Pclk_rising_time) * 100) / pclk_period != 50) begin
        pclk_failed_flag = 1;
        $display("%0t:duty bit_rate_10 = %0dps, fall:%0d, rise:%0d, oldRise:%0d", $time,
                 ((Pclk_falling_time - Pclk_rising_time) * 100) / pclk_period, Pclk_falling_time,
                 Pclk_rising_time, Old_Pclk_rising_time);
        error_count++;
      end else correct_count++;
    end
  end

  /////////////////Bit_Rate////////////////////////

  // rising time  
  always @(posedge Bit_Rate) begin
    Old_Bit_Rate_rising_time = Bit_Rate_rising_time;
    Bit_Rate_rising_time = $time;

  end
  // falling time  
  always @(negedge Bit_Rate) begin
    if (Rst) begin
      Bit_Rate_falling_time = $time;
      bit_rate_period       = (Bit_Rate_rising_time - Old_Bit_Rate_rising_time);

      if (Old_Bit_Rate_rising_time != 0 && bit_rate_period != 200) begin
        bit_rate_failed_flag = 1;
        $display("%0t:period bit_rate = %0dps", $time,
                 2 * (Bit_Rate_falling_time - Bit_Rate_rising_time));
        error_count++;
      end else correct_count++;

      //duty
      if ( Old_Bit_Rate_rising_time!=0 && ((Bit_Rate_falling_time - Bit_Rate_rising_time) * 100) / bit_rate_period != 50) begin
        bit_rate_failed_flag = 1;
        $display("%0t:duty bit_rate = %0dps, fall:%0d, rise:%0d, oldRise:%0d", $time,
                 ((Bit_Rate_falling_time - Bit_Rate_rising_time) * 100) / bit_rate_period,
                 Bit_Rate_falling_time, Bit_Rate_rising_time, Old_Bit_Rate_rising_time);
        error_count++;

      end else correct_count++;
    end
  end
  /////////////////Bit_Rate_10////////////////////////
  // rising time  
  always @(posedge Bit_Rate_10) begin
    Old_Bit_Rate_10_rising_time = Bit_Rate_10_rising_time;
    Bit_Rate_10_rising_time = $time;
  end
  // falling time  
  always @(negedge Bit_Rate_10) begin
    if (Rst) begin

      Bit_Rate_10_falling_time = $time;
      bit_rate_10_period = (Bit_Rate_10_rising_time - Old_Bit_Rate_10_rising_time);

      if (Old_Bit_Rate_10_rising_time != 0 && bit_rate_10_period != 2000) begin
        bit_rate_10_failed_flag = 1;

        $display("%0t:period bit_rate_10 = %0dps", $time,
                 2 * (Bit_Rate_10_falling_time - Bit_Rate_10_rising_time));
        error_count++;
      end else correct_count++;

      //check duty cycle
      if ( Old_Bit_Rate_10_rising_time!=0 && ((Bit_Rate_10_falling_time - Bit_Rate_10_rising_time) * 100) / bit_rate_10_period != 50) begin
        bit_rate_10_failed_flag = 1;
        $display("%0t:duty bit_rate_10 = %0dps, fall:%0d, rise:%0d, oldRise:%0d", $time,
                 ((Bit_Rate_10_falling_time - Bit_Rate_10_rising_time) * 100) / bit_rate_10_period,
                 Bit_Rate_10_falling_time, Bit_Rate_10_rising_time, Old_Bit_Rate_10_rising_time);
        error_count++;
      end else correct_count++;
    end
  end

  initial begin
    correct_count = 0;
    error_count = 0;
    pclk_failed_flag = 0;
    bit_rate_failed_flag = 0;
    bit_rate_10_failed_flag = 0;
    reset();
  end
  initial begin
    #100000;  // Wait for the simulation to run

    if (!pclk_failed_flag) begin
      $display("PCLK period = %0dps,\t PCLK duty Cycle = 50", pclk_period);
    end

    if (!bit_rate_failed_flag) begin
      $display("bit_rate period = %0dps,\t bit_rate duty Cycle = 50", bit_rate_period);
    end

    if (!bit_rate_10_failed_flag) begin
      $display("bit_rate_10 period = %0dps,\t bit_rate_10 duty Cycle = 50", bit_rate_10_period);
    end

    $display("correct count : %0d, error count : %0d", correct_count, error_count);
    #10000;  // Allow some time for potential display output
    $stop;
  end



  task reset();
    Rst = 0;
    // check_res();
    @(negedge Ref_Clk);
    // check_res();
    Rst = 1;
  endtask  //

  task check_res();
    if (!Rst)
      if (Bit_Rate !== 0 || Bit_Rate_10 !== 0 || PCLK !== 0) begin
        $display("Bit_Rate %b, Bit_Rate_10 %b, PCLK %b", Bit_Rate, Bit_Rate_10, PCLK);
        error_count++;
      end else correct_count++;
  endtask  //
endmodule


