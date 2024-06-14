`timescale 1ns/1fs

module Clk_Gen(

input       clk_in,
input       rst_n,

output clk_90,
output clk_180


);


reg  clk                     ;
reg  [360:1] clk_            ;

////////////////////////////////////////
///////// INTERNAL CLK GENERAION ///////
////////////////////////////////////////


initial begin
clk = 0;
forever #0.00055 clk = ~clk ;
end



assign clk_90  = clk_[45] ;
assign clk_180 = ~clk_in;


///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////



genvar i;
generate
  for (i = 1; i <= 360; i = i + 1) begin
    always @(posedge clk or negedge rst_n) begin

      if (~rst_n) begin
        clk_[i] <= 0;
      end 

      else if(i == 1) clk_[1] <= clk_in;

      else begin
        clk_[i] <= clk_[i-1]; 
        end
    end
  end
endgenerate



endmodule



// module top(input clk , input rst_n ,input [10:0] code , output clk_90 , output clk_180) ;


//  PMIX PMIX_U(
//     .CLK (clk),
//     .Code(code),
//     // output reg        clk_filter_
//     .CLK_Out_i(CLK_Out_i)
    
// );


// Clk_Gen Clk_gen_U(

// .clk_in(CLK_Out_i)  ,
// .rst_n (rst_n)  ,

// .clk_90  (clk_90),
// .clk_180 (clk_180)
// );


// endmodule  



// module top_tb ;


//   reg clk;    // Clock
//   reg rst_n;  // Asynchronous reset active low
//   reg [10:0] code ;
  
//   wire clk_90;
//   wire clk_180;

//   top dut(.*);


// initial begin
//   clk = 0 ;
//    forever begin
//      #0.1 clk = ~clk;
//    end
// end

// initial begin
//   rst_n = 0 ;
//   #10;
//   rst_n = 1;

//   code = 0 ;

//   #200;

//    for (int i = 0; i < 2050; i = (i + 1) % 2048) begin
//       code = i;
//       #(0.03);
//     end
//     $stop();

// end

// endmodule