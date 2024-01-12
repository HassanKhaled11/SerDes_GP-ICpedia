module Common_Block (
    input Ref_Clk,  // 100 MG 
    input Rst_n,
    //input [7:0]div_ratio,
    input  [5:0] DataBusWidth ,
    output Bit_Rate_Clk,
    output Bit_Rate_CLK_10,
    output PCLK
);

wire Bit_Rate_Clk;

reg [7:0] ratio ;

  PLL PLL_frquency_mult (
      .Ref_Clk(Ref_Clk),
      .CLK(Bit_Rate_Clk)  // 5G
  );

  Clock_Div clock_divider (
      .Ref_Clk(Bit_Rate_Clk),  // 5G/10
      .rst(Rst_n),
      .div_ratio(8'b0000_1010),
      .divided_clk(Bit_Rate_CLK_10)
  );

  Clock_Div clock_divider1 (
      .Ref_Clk(Bit_Rate_Clk),  //PCLK
      .rst(Rst_n),
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
