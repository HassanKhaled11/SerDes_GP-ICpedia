

`timescale 1ns/1fs
module PMIX #(parameter THRESHOLD = 125 , parameter WIDTH = 9)
(
  input [10:0] Code      ,	
  output      CLK_Out            
);


int index;
real sin_sum         ;
integer PHASE_SHIFT     ;

realtime t1             ;
realtime t2             ;
realtime CLK_PERIOD_P1  ;
reg [15:0] sin1 ;


realtime t3             ;
realtime t4             ;
realtime CLK_PERIOD_P2  ; 
reg [15:0] sin2 ;

realtime t5             ;
realtime t6             ;
realtime RESULT_PERIOD  ; 


reg clk_bit_p1   ;
reg clk_bit_p2   ;

reg CLK_Out_i;

assign CLK_Out = CLK_Out_i;


integer i , j , k     ;
realtime last_time    ;       // Require time data type

reg [15:0] sin_0 [0:999];
reg [15:0] sin_90 [0:999];
reg [15:0] sin_180 [0:999];
reg [15:0] sin_270 [0:999];
reg [15:0] sin_45 [0:999];
reg [15:0] sin_135 [0:999];
reg [15:0] sin_225 [0:999];
reg [15:0] sin_315 [0:999];
initial begin
    $readmemh("sine_0.hex", sin_0);
    $readmemh("sine_90.hex", sin_90);
    $readmemh("sine_180.hex", sin_180);
    $readmemh("sine_270.hex", sin_270);
    $readmemh("sine_45.hex", sin_45);
    $readmemh("sine_135.hex", sin_135);
    $readmemh("sine_225.hex", sin_225);
    $readmemh("sine_315.hex", sin_315);
end 

always @* begin
    if(sin_sum > THRESHOLD) CLK_Out_i = 1 ;
    else CLK_Out_i = 0;
end


always @* begin
PHASE_SHIFT    = t3 - t1 ;
end


initial begin
   i         = 0 ;
   j         = 0 ;
   k         = 0 ;   
   last_time = 0 ;
end



initial begin
forever begin
@(posedge CLK_Out_i);
t5 = $realtime;
@(posedge CLK_Out_i);
t6 = $realtime;
RESULT_PERIOD  = t6 - t5 ;
end
end


reg clk_;
initial clk_ = 0;
always #(0.001) clk_= ~clk_;   


always @(posedge clk_)
    index = (index + 1)%1000;
always @(*) begin //posedge clk or negedge rst_n
            case(Code[10:8]) 
                3'b000 : begin 
                    sin1 = sin_0[index];
                    sin2 = sin_45[index];
                end
                3'b001 : begin 
                    sin1 = sin_45[index];
                    sin2 = sin_90[index];
                end
                3'b010 : begin 
                    sin1 = sin_90[index];
                    sin2 = sin_135[index];
                end
                3'b011 : begin 
                    sin1 = sin_135[index];
                    sin2 = sin_180[index];
                end
                3'b100 : begin 
                    sin1 = sin_180[index];
                    sin2 = sin_225[index];
                end
                3'b101 : begin 
                        sin1 = sin_225[index];
                        sin2 = sin_270[index];
                end
                3'b110 : begin 
                    sin1 = sin_270[index];
                    sin2 = sin_315[index];
                end
                3'b111 : begin 
                    sin1 = sin_315[index];
                    sin2 = sin_0[index];
                end
            endcase
            // index =((N*($time%T)/T)+1) %1000; 
// end 
end 
always @(*)
begin
   sin_sum  = (Code[7:0]/256.0 * sin2  + ((255.0 - Code[7:0])/256.0 * sin1 )) ; 
end


endmodule



///////////////////////////////////////
///////////////////////////////////////
////// SIGN OF SIN WAVE GENERATOR /////
///////////////////////////////////////
///////////////////////////////////////


// module Sign_Detector #( parameter THRESHOLD = 25 , parameter WIDTH = 9)(
//     input wire signed [WIDTH - 1 : 0] sin_wave,    // Clock
//     output sign_of_wave
// );

// assign sign_of_wave = (sin_wave >=  THRESHOLD ) ? 1'b1 : 1'b0 ;

// endmodule : Sign_Detector


///////////////////////////////////////
///////////////////////////////////////
///////////// TESTBENCH ///////////////
///////////////////////////////////////
///////////////////////////////////////

module PMIX_Tb;

 reg [10:0] Code          ; 
 reg       CLK           ;
 reg       CLK_90        ;
 wire      CLK_180       ;
 wire      CLK_270       ;

 reg       CLK_45        ;
 reg       CLK_135       ;
 reg       CLK_225       ;
 reg       CLK_315       ;

 wire      CLK_Out       ;

 integer i               ;

PMIX PMIX_DUT (.*)       ;

always #0.1 CLK = ~CLK   ;
assign CLK_180  = ~CLK   ;
assign CLK_270  = ~CLK_90; 


initial begin
  CLK_90  = 0;
  #(0.05)      ;
  forever #0.1 CLK_90 = ~CLK_90;
end

initial begin
  CLK_45  = 0;
  #(0.025)      ;
  forever #0.1 CLK_45 = ~CLK_45;
end


initial begin
  CLK_135  = 0;
  #(0.075)      ;
  forever #0.1 CLK_135 = ~CLK_135;
end


initial begin
  CLK_225  = 0;
  #(0.125)      ;
  forever #0.1 CLK_225 = ~CLK_225;
end


initial begin
  CLK_315  = 0;
  #(0.175)      ;
  forever #0.1 CLK_315 = ~CLK_315;
end




initial begin

  CLK     = 0;

  Code = 10'b00_1000_0000;
  #(0.2*2);
  Code = 10'b00_1111_1111;
  #(0.2*2);
  Code = 10'b01_0000_0000;
  #(0.2*2);
  Code = 10'b01_1111_1111;
  #(0.2*2);
  Code = 10'b10_0000_0000;
  #(0.2*2);
  Code = 10'b10_1111_1111;
  #(0.2*2);
  Code = 10'b11_0000_0000;
  #(0.2*2);
  Code = 10'b11_1111_1111;
  #(0.2*2);



#5;

  for (i = 0; i < 3025; i = (i + 1)%2048) begin
   Code = i ;
  #(0.2);
  end
$stop();

end

endmodule      