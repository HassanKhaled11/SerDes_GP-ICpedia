`timescale 1ps / 1ps

module clk_test ();
  logic Ref_Clk;
  logic Rst;
  // logic [7:0] div_ratio;
  logic Bit_Rate;
  logic Bit_Rate_10;
  logic PCLK;

  int   my_time;
  int   on_time;
  int   off_time;

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

  // always @(posedge Ref_Clk) begin
  //   test_Freq(Bit_Rate);
  //   test_duty(Bit_Rate);
  //   $display("t ref_clk: %d", my_time);
  // end

  initial begin
    correct_count = 0;
    error_count = 0;
    my_time = 0;
    reset();
    // test_Freq(Bit_Rate);
    // test_duty(Bit_Rate);
    fork
      begin
        test_Freq(Bit_Rate_10);
      end

      begin
        test_duty(Bit_Rate_10);
      end

      begin
        test_Freq(Bit_Rate);
      end

      begin
        test_duty(Bit_Rate);
      end
    join
    $display("t ref_clk: %d", my_time);
    #10000;

    // test_Freq(Bit_Rate_10);
    // test_duty(Bit_Rate_10);
    $display("t ref_clk: %d", my_time);
    // fork
    // forever begin
    //   // @(posedge Ref_Clk) 
    //   begin
    //     test_Freq(Ref_Clk);
    //     test_duty(Ref_Clk);
    //     $display("t ref_clk: %d", my_time);
    //   end
    // end
    // join_none
    #50000;
    $display("correct count : ", correct_count, ", error count : ", error_count);
    $stop;
  end

  task test_Freq(input bit clk);
    int t1, t2;
    @(posedge clk);
    t1 = $time;
    @(posedge clk);
    t2 = $time;
    my_time = t2 - t1;
    $display("in task t ref_clk: %d", my_time);
  endtask  //

  task test_duty(input bit clk);
    int t1, t2, t3;
    @(posedge clk);
    t1 = $time;
    @(negedge clk);
    t2 = $time;
    on_time = t2 - t1;
    @(posedge clk);
    t3 = $time;
    off_time = t2 - t3;
    $display("duty: %d", (on_time / (on_time + off_time)));
  endtask  //

  task reset();
    Rst = 1;
    @(negedge Ref_Clk);
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




// `timescale 1ps / 1ps

// module clk_test ();
//   logic Ref_Clk;
//   logic Rst;
//   // logic [7:0] div_ratio;
//   logic Bit_Rate;
//   logic Bit_Rate_10;
//   logic PCLK;

//   int my_time;
//   int on_time;
//   int off_time;

//   PLL testing_pll (
//       .Ref_Clk    (Ref_Clk),
//       .Rst        (Rst),
//       .Bit_Rate   (Bit_Rate),
//       .Bit_Rate_10(Bit_Rate_10),
//       // .div_ratio(div_ratio),
//       .PCLK       (PCLK)
//   );

//   initial begin
//     Ref_Clk = 0;
//     forever #5000 Ref_Clk = ~Ref_Clk;
//   end

//   initial begin
//     reset();
//     my_time = 0;
//     $display("t ref_clk: %d", my_time);

//     // Wait for a while before testing Bit_Rate
//     #20000;
//     test_Freq(Bit_Rate);
//     test_duty(Bit_Rate);
//     $display("t Bit_Rate: %d", my_time);

//     // Wait for a while before testing Bit_Rate_10
//     #20000;
//     test_Freq(Bit_Rate_10);
//     test_duty(Bit_Rate_10);
//     $display("t Bit_Rate_10: %d", my_time);

//     // End simulation
//     #100000;
//     $stop;
//   end

//   task test_Freq(input bit clk);
//     real t1, t2;
//     @(posedge clk); t1 = $realtime;
//     @(posedge clk); t2 = $realtime;
//     my_time = t2 - t1;
//     $display("in task t ref_clk: %d", my_time);
//   endtask

//   task test_duty(input bit clk);
//     real t1, t2, t3;
//     @(posedge clk); t1 = $realtime;
//     @(negedge clk); t2 = $realtime;
//     on_time = (t2 - t1);
//     @(posedge clk); t3 = $realtime;
//     off_time = int(t2 - t3);
//     $display("duty: %d", int(100 * on_time / (on_time + off_time)));
//   endtask

//   task reset();
//     Rst = 1;
//     @(negedge Ref_Clk) Rst = 0;
//     @(negedge Ref_Clk) Rst = 1;
//   endtask
// endmodule
