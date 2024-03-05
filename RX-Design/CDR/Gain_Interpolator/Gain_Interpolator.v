module Gain_Interpolator #(parameter WIDTH = 10 , parameter GAIN = 3  , parameter GAIN_SELECT = 0 )
(
  input                  CLK             ,	   //WHAT RATE?
  input                  RST_n           ,
  input      [1      :0] phe             ,
  output reg [WIDTH-1:0] control2PMIX
);


reg  [5 :0] shifted_phe   ;
reg  [4 :0] gain_selected ;
reg  [14:0] FI_Q          ;
reg  [14:0] PI_Q          ;



always@(*) begin
shifted_phe = phe << GAIN;
end


always@(*) begin
  case(GAIN_SELECT)
       0 : begin gain_selected = phe*1 ; end
       1 : begin gain_selected = phe*2 ; end
       2 : begin gain_selected = phe*4 ; end  
  endcase
end 


always @(posedge CLK or negedge RST_n) begin                //Freq_integrator
if(!RST_n) FI_Q <= 0 ;
else begin
FI_Q <= FI_Q + gain_selected ;            					 // sum_point1	
end
end

always @(posedge CLK or negedge RST_n) begin                //Phase_integrator
if(!RST_n) PI_Q <= 0 ;
else begin
PI_Q <= PI_Q + FI_Q[14:5] + shifted_phe ; 					 // sum_point2
end
end


always @(posedge CLK or negedge RST_n) begin  
if(!RST_n) control2PMIX <= 0 ;
control2PMIX <= PI_Q[14:5] ;
end

endmodule




module Gain_Interpolator_tb;

parameter WIDTH       = 10    ;
parameter GAIN        = 3     ;
parameter GAIN_SELECT = 0     ;

reg              CLK          ;	
reg              RST_n        ;
reg  [1      :0] phe          ;
wire [WIDTH-1:0] control2PMIX ;


Gain_Interpolator  DUT(.*);


always #2 CLK = ~CLK;


initial begin
CLK = 0 ;
phe = 0 ;
RST_n = 0;
#6;
RST_n = 1;

#20;
phe = 1 ;

#20;
phe = 2 ;

#20;

$stop;

end



endmodule
