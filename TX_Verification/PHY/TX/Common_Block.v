module Common_Block (
    input Ref_Clk,  // 100 MG 
    input Rst,
    //input [7:0]div_ratio,
    input  [5:0] DataBusWidth ,
    output Bit_Rate_Clk,
    output Bit_Rate_CLK_10,
    output PCLK
);



reg [7:0] ratio ;

  PLL frquency_multiplier (
      .Ref_Clk(Ref_Clk),
      .RST(Rst),
      .CLK(Bit_Rate_Clk)  // 5G
  );

  Clock_Div clock_divider (
      .Ref_Clk(Bit_Rate_Clk),  // 5G/10
      .rst(Rst),
      .div_ratio(8'b0000_1010),
      .divided_clk(Bit_Rate_CLK_10)
  );

  Clock_Div clock_divider1 (
      .Ref_Clk(Bit_Rate_Clk),  //PCLK
      .rst(Rst),
      //.div_ratio(8'b0000_1010),
      .div_ratio(8'b0001_0100),
      //.div_ratio(8'b0010_1000),
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
