module PLL (
    input Ref_Clk,  // 100 MG 
    input Rst,
    //input [7:0]div_ratio,
    output Bit_Rate_Clk,
    output Bit_Rate_CLK_10,
    output PCLK
);

  freq_mul frquency_multiplier (
      .Ref_Clk(Ref_Clk),
      .RST(Rst),
      .CLK(Bit_Rate_Clk)  // 5G
  );

  // Clock_Div clock_divider (
  //     .Ref_Clk(Bit_Rate),  // 5G/10
  //     .rst(Rst),
  //     .div_ratio(8'b0000_1010),
  //     .pclk(Bit_Rate_10)
  // );

  // Clock_Div clock_divider1 (
  //     .Ref_Clk(Bit_Rate),  // 250MG
  //     .rst(Rst),
  //     .div_ratio(8'b0001_0100),
  //     .pclk(PCLK)
  // );


ClkDiv__  ClkDiv___U0 
(
   .i_ref_clk  (Bit_Rate_Clk) ,
   .i_rst_n    (Rst) ,
   .i_div_ratio(8'b0000_1010) ,
   .o_div_clk  (Bit_Rate_CLK_10)
);


ClkDiv__  ClkDiv___U1 
(
   .i_ref_clk  (Bit_Rate_Clk) ,
   .i_rst_n    (Rst) ,
   .i_div_ratio(8'b0001_0100) ,
   .o_div_clk  (PCLK)
);


endmodule
