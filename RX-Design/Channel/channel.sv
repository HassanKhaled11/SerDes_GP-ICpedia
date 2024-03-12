`timescale 1ns / 1fs
module channel (
    input clk,
    input rst_n,
    input in,
    output real out
);

  reg faster_clk;
  parameter FASTER_CLK_PERIOD = 0.00019;
  parameter NUMBER_OF_LEVELS = 256;
  parameter THRESHOLD = NUMBER_OF_LEVELS / 2;
  // parameter precision = 5;
  reg [8-1:0] out_fading;

  initial begin
    faster_clk = 0;
    forever #(FASTER_CLK_PERIOD / 2) faster_clk = ~faster_clk;
  end
  always @(posedge faster_clk or negedge rst_n) begin
    if (!rst_n) begin
      out_fading <= 0;
      out <= 0;
    end else begin
      if (in == 1) begin
        if (out_fading < NUMBER_OF_LEVELS - 1) out_fading <= out_fading + 1;
        else out_fading = NUMBER_OF_LEVELS - 1;
      end else begin
        if (out_fading > 0) out_fading <= out_fading - 1;
        else out_fading <= 0;
      end
    end
    out = out_fading / NUMBER_OF_LEVELS;
  end
endmodule

`timescale 1ns / 1fs
module channel_Tb;
  reg clk;
  reg rst_n;
  reg in;
  real out;

  reg [19:0] inputVal;

  // Clock generation
  initial begin
    clk = 0;
    forever #0.1 clk = ~clk;
  end

  // Instantiate the channel module
  channel #(
      .NUMBER_OF_LEVELS(256),
      .THRESHOLD(128),
      .FASTER_CLK_PERIOD(0.0019)  //0.00019 will be always correct
  ) channel_inst (
      .clk(clk),
      .rst_n(rst_n),
      .in(in),
      .out(out)
  );

  // Stimulus
  initial begin
    // Reset
    rst_n = 0;
    #5;
    rst_n = 1;

    in = 1;
    repeat (10) @(negedge clk);


    // Provide stimuli
    for (int i = 0; i < 1000; i = i + 1) begin
      @(negedge clk) in = $random();
    end

    #10 $stop;  // Stop simulation after 150 time units
  end

  // Monitor
  always @(posedge clk) begin
    $display("Time = %0t, in = %b, out = %f", $time, in, out);
  end

endmodule

// module edgeDetector(input )
