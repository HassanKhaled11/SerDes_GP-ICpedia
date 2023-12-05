module Phase_Mixer
(
 input  [9:0]   Code           ,	

 output         D_CLK          , 
 output         D_CLK_n        ,
 output         PhCLK          ,
 output         PhCLK_n  
 
);
 
 reg [8:0]      P1 , P2        ; 
 reg [8:0]      Interpol_Code  ;



Clk_Gen Clk_Gen_U(

.code          (Interpol_Code) ,

.pmix_clk      (D_CLK)         ,
.pmix_clk_90   (PhCLK)         ,
.pmix_clk_n    (D_CLK_n)       ,
.pmix_clk_90_n (PhCLK_n) 
);


////////////////////////////////////////////////
/////////////// PHASES SELECTION ///////////////
////////////////////////////////////////////////

 always @(*) begin
   case(Code[9:8])
     
     2'b00: begin
           P1 = 0    ;
           P2 = 90   ;
         end

     2'b01: begin
           P1 = 90   ;
           P2 = 180  ;
         end

     2'b10: begin
           P1 = 180  ;
           P2 = 270  ;
         end

     2'b11: begin
           P1 = 270  ;
           P2 = 360  ;
         end         
   endcase  	
 end

////////////////////////////////////////////////
///////////// CODE INTERPOLATION ///////////////
////////////////////////////////////////////////

always @(*) begin
 Interpol_Code =( ((Code[7:0]*1000) / 255) *P2 + (((255 - Code[7:0])*1000) /255) *P1 ) / 1000 ;
end

///////////////////////////////////////////////
///////////////////////////////////////////////
///////////////////////////////////////////////

endmodule

///////////////////////////////////////////////

`timescale 1ns/1fs


module Phase_Mixer_tb ;

 reg  [9:0]    Code           ;
 
 wire          D_CLK          ; 
 wire          D_CLK_n        ;
 wire          PhCLK          ;
 wire          PhCLK_n        ;
 
 integer i                    ;

 Phase_Mixer DUT(.Code(Code) , .D_CLK(D_CLK) , .D_CLK_n(D_CLK_n) ,.PhCLK(PhCLK) , .PhCLK_n(PhCLK_n));


 initial begin

  Code = 10'b0000000000 ;     // 0
  #100;
  Code = 10'b0011111111 ;     // 90
  #100;
  Code = 10'b0010000000 ;     // 45
  #100;

  //////////////////////////////////////////

  Code = 10'b0100000000 ;     // 90
  #100;
  Code = 10'b0111111111 ;     // 180
  #100;
  Code = 10'b0110000000 ;     // 135
  #100;

  //////////////////////////////////////////

  Code = 10'b1000000000 ;     // 180
  #100;
  Code = 10'b1011111111 ;     // 270
  #100;
  Code = 10'b1010000000 ;     // 225
  #100;

  //////////////////////////////////////////


  Code = 10'b1100000000 ;     // 270
  #100;
  Code = 10'b1111111111 ;     // 360 = 0
  #100;
  Code = 10'b1110000000 ;     // 315
  #100;

  //////////////////////////////////////////



 for(i = 0 ; i < 361; i = i + 1) begin
   Code = i ;
   #(100)   ;
 end
  

 #(200) ;
 $stop  ;

 end

 
 endmodule