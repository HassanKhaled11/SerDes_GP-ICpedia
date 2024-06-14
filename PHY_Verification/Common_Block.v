// coverage off

`timescale 1ns/1fs

module Common_Block (
    input Ref_Clk,  // 100 MG 
    input Rst_n,
    //input [7:0]div_ratio,
    input  [5:0] DataBusWidth ,
    output Bit_Rate_Clk,
    output Bit_Rate_CLK_10,
    `ifdef OFFSET_TEST
       output reg Bit_Rate_Clk_offset,
    `endif
    output PCLK
);


  reg [7:0] ratio ;


  PLL PLL_frquency_mult (
      .Ref_Clk(Ref_Clk),
      .CLK(Bit_Rate_Clk_)  // 5G
  );


  Clock_Div clock_divider (
      .Ref_Clk(Bit_Rate_Clk_),  // 5G/10
      .rst(Rst_n),
      .div_ratio(8'b0000_1010),
      .divided_clk(Bit_Rate_CLK_10)
  );


  Clock_Div clock_divider1 (
      .Ref_Clk(Bit_Rate_Clk_),  //PCLK
      .rst(Rst_n),
      .div_ratio(ratio),
      .divided_clk(PCLK)
  );

 
 `ifdef OFFSET_TEST
   initial begin
     Bit_Rate_Clk_offset = 0 ;
     @(posedge Bit_Rate_Clk_) ;
     #0.00001
     Bit_Rate_Clk_offset  = 1 ;
     forever begin
       #0.1 Bit_Rate_Clk_offset = ~ Bit_Rate_Clk_offset ;
     end 
  end

   // initial begin
   //   Bit_Rate_Clk_offset = 0 ;
   //   @(posedge Bit_Rate_Clk) ;
   //   //#0.00003
   //   Bit_Rate_Clk_offset  = 1 ;
   //   forever begin
   //     #0.1001 Bit_Rate_Clk_offset = ~ Bit_Rate_Clk_offset ;
   //   end
   // end
 `endif



////////////////////////////
///////// SRIS TESTING /////
////////////////////////////

 `ifdef SRIS_TEST
    wire Bit_Rate_Clk_SSC; 
    assign Bit_Rate_Clk = Bit_Rate_Clk_SSC; 
    `ifdef OFFSET_TEST
        SSC_Generator SSC_Generator_DUT (Bit_Rate_Clk_offset , Bit_Rate_Clk_SSC);
    `else
        SSC_Generator SSC_Generator_DUT (Bit_Rate_Clk_, Bit_Rate_Clk_SSC);
    `endif
 `else 
     assign Bit_Rate_Clk = Bit_Rate_Clk_;
 `endif


////////////////////////////
////////////////////////////
////////////////////////////


always @(*) begin
  
 case (DataBusWidth)
   
   6'd8    :  ratio = 8'd10 ;
   6'd16   :  ratio = 8'd20 ;
   6'd32   :  ratio = 8'd40 ;  

   default :  ratio = 8'd10 ;

 endcase

end

endmodule
