module PLL (
    input  Ref_Clk,  // 100 MG 
    input  RST_n,
    input  [5:0] DataBusWidth ,
    
    output Bit_Rate_Clk,
    output Bit_Rate_CLK_10,
    output PCLK
);



reg [7:0] ratio ;

  freq_mul frquency_multiplier (
      .Ref_Clk(Ref_Clk),
      .CLK(Bit_Rate_Clk)  // 5G
  );


  Clock_Div clock_divider (
      .Ref_Clk(Bit_Rate_Clk),  // 5G/10
      .RST_n(RST_n),
      .div_ratio(8'b0000_1010),
      .divided_clk(Bit_Rate_CLK_10)
  );


  Clock_Div clock_divider1 (
      .Ref_Clk(Bit_Rate_Clk),  //PCLK
      .RST_n(RST_n),
      .div_ratio(ratio),
      .divided_clk(PCLK)
  );



always @(*) begin
  
 case (DataBusWidth)
   
   6'd8    :  ratio = 8'd10 ;
   6'd16   :  ratio = 8'd20 ;
   6'd32   :  ratio = 8'd40 ;  

   default :  ratio = 8'd10 ;

 endcase

end

endmodule
