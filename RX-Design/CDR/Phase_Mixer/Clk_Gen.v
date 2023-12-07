`timescale 1ns/1fs

module Clk_Gen(

input [8:0] code,
input       clk_in,

output reg  pmix_clk,pmix_clk_90,
output pmix_clk_n,pmix_clk_90_n
);


reg  clk                     ;
reg  rst_n                   ;   
reg  [360:1] clk_            ;

wire [8:0] code_90           ;
////////////////////////////////////////
///////// INTERNAL CLK GENERAION ///////
////////////////////////////////////////


initial begin
clk = 0;
forever #0.00055 clk = ~clk ;
end




initial begin              //Reset Generation
 rst_n = 0;
 #(0.00055 * 3);
 rst_n = 1; 
end

///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////


assign pmix_clk_n    = ~ pmix_clk         ;
assign pmix_clk_90_n = ~ pmix_clk_90      ;
assign code_90       = (code + 90) % 360  ;

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


always @(posedge clk or negedge rst_n)
begin

if(!rst_n) begin
 pmix_clk    <= 0                  ;
 pmix_clk_90 <= 0                  ;
end

else begin
   if(code == 0) begin
    pmix_clk    <= clk_in          ;
    pmix_clk_90 <= clk_[90]        ;
   end
   
   else if(code_90 == 0) begin
     pmix_clk    <= clk_[code]     ;
     pmix_clk_90 <= clk_in         ;
   end
   
   else begin
   pmix_clk     <= clk_[code]      ;
   pmix_clk_90  <= clk_[code_90]   ;
   end

end
end


endmodule