`timescale 1ns/10ps
module my_assertion #(parameter ERROR_ALLOWED_BCLK = 0 , parameter ERROR_ALLOWED_WCLK = 0  , parameter ERROR_ALLOWED_PCLK = 0 )(

 wire         Bit_CLK      ,
 wire         Word_CLK     ,
 wire         PCLK         ,
 wire [5:0]   DataBusWidth ,
 wire         TX_Out_P     

);

realtime t1,t2,t3;

  

property Word_clk_prop(int clk_period);
  realtime current_time ;
    (('1,current_time = $realtime) |=> (clk_period == $realtime - current_time));
endproperty
 
assert_WORD_CLK_period:assert property (@(posedge Word_CLK) Word_clk_prop(2 +ERROR_ALLOWED_WCLK));
cover_WORD_CLK_period :cover property  (@(posedge Word_CLK) Word_clk_prop(2 +ERROR_ALLOWED_WCLK));  




property bit_clk_prop(time clk_period);
  realtime current_time ;
    (('1,current_time = $realtime) |=> (clk_period == int'(10*($realtime - current_time))));
//  (('1,current_time = $realtime) |=> (clk_period == int'($realtime - current_time))); AND pass 0.2 instead of 2 will also work as time type is type of int

endproperty


assert_Bit_CLK_period:assert property (@(posedge Bit_CLK) bit_clk_prop(2 + ERROR_ALLOWED_BCLK));
cover_Bit_CLK_period :cover property  (@(posedge Bit_CLK) bit_clk_prop(2 + ERROR_ALLOWED_BCLK));  




property Pclk_prop(time clk_period);
  realtime current_time ;

disable iff((clk_period == 2 + ERROR_ALLOWED_PCLK && DataBusWidth != 6'd8  )  ||
            (clk_period == 4 + ERROR_ALLOWED_PCLK && DataBusWidth != 6'd16 )  ||
            (clk_period == 8 + ERROR_ALLOWED_PCLK && DataBusWidth != 6'd32 )  )

  (('1,current_time = $realtime) |=> (clk_period == int'($realtime - current_time)));
endproperty


assert_PCLK8_period:assert property (@(posedge PCLK) Pclk_prop(2 + ERROR_ALLOWED_PCLK));
cover_PCLK8_period :cover property  (@(posedge PCLK) Pclk_prop(2 + ERROR_ALLOWED_PCLK));  


assert_PCLK16_period:assert property (@(posedge PCLK) Pclk_prop(4 + ERROR_ALLOWED_PCLK));
cover_PCLK16_period :cover property  (@(posedge PCLK) Pclk_prop(4 + ERROR_ALLOWED_PCLK));  


assert_PCLK32_period:assert property (@(posedge PCLK) Pclk_prop(8 + ERROR_ALLOWED_PCLK));
cover_PCLK32_period :cover property  (@(posedge PCLK) Pclk_prop(8 + ERROR_ALLOWED_PCLK));  



endmodule
