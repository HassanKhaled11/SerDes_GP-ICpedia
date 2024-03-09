`timescale 1ns / 1fs
module channel (
    input clk,
    input rst_n,
    input in,
    output reg out
);
  reg faster_clk;
  // parameter precision = 5;
  reg [10-1:0] out_fading;

  initial begin
    faster_clk = 0;
    forever #(5) faster_clk = ~faster_clk;
  end
  always @(posedge faster_clk or negedge rst_n) begin
    if (!rst_n) begin
      out_fading <= 0;
      out <= 0;
    end else begin
      if (in == 1) begin
        if (out_fading < 10'b1111_1111) out_fading <= out_fading + 1;
        else out_fading = 10'b1111_1111;
      end else begin
        if (out_fading > 0) out_fading <= out_fading - 1;
        else out_fading <= 0;
      end
    end
  end

endmodule

`timescale 1ns / 1fs
module channel_Tb;
  reg clk;
  reg rst_n;
  reg in;
  wire out;

  reg [19:0] inputVal;

  // Clock generation
  initial begin
    clk = 0;
    forever #50 clk = ~clk;
  end

  // Instantiate the channel module
  channel channel_inst (
      .clk(clk),
      .rst_n(rst_n),
      .in(in),
      .out(out)
  );

  // Stimulus
  initial begin
    // Reset
    rst_n = 0;
    #100;
    rst_n = 1;

    inputVal = 20'b1111_0101_1100_1000_1010;

    in = 1;
    #100;
    // Provide stimuli
    for (int i = 0; i < 1000; i = i + 1) begin
      #1000 in = inputVal[i%20];
    end

    #150 $stop;  // Stop simulation after 150 time units
  end

  // Monitor
  always @(posedge clk) begin
    $display("Time = %0t, in = %b, out = %b", $time, in, out);
  end

endmodule

