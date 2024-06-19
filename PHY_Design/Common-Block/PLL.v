`timescale 1ps / 1ps
module PLL (
    input Ref_Clk,
    output reg CLK
);

  integer first, second;
  initial begin
    CLK = 0;
    @(posedge Ref_Clk);
    first = $time();
    $display(first);
    @(posedge Ref_Clk);
    second = $time();
    $display(first);
    $display(second);



    forever #((second - first) / 100) CLK = ~CLK;


  end


endmodule
