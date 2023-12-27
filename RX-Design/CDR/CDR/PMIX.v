 `timescale 1ns/1fs

module PMIX #(parameter THRESHOLD = 25 , parameter WIDTH = 9 )
(
  input [9:0] Code          ,	
  input       CLK 	        ,
  input       CLK_90	    ,
  input       CLK_180       ,
  input       CLK_270       ,

  output      CLK_Out            
);

reg P1 , P2 ;
wire sign_sin1;
wire sign_sin2;


reg [WIDTH - 1:0] sine [0:359] ;
reg [WIDTH - 1:0] sin_sum      ;
integer PHASE_SHIFT            ;

realtime t1             ;
realtime t2             ;
realtime CLK_PERIOD_P1  ;
reg [WIDTH - 1 :0] sin1 ;


realtime t3             ;
realtime t4             ;
realtime CLK_PERIOD_P2  ; 
reg [WIDTH - 1 :0] sin2 ;


reg clk_bit_p1   ;
reg clk_bit_p2   ;


integer i , j , k    ;




Sign_Detector #(.THRESHOLD (22) ,  .WIDTH (WIDTH)) Sign_Detector_U0 
(
 .sin_wave       (sin_sum) ,
 .sign_of_wave   (CLK_Out)); 


Sign_Detector #(.THRESHOLD (THRESHOLD) ,  .WIDTH (WIDTH)) Sign_Detector_U1 
(
 .sin_wave       (sin1) ,
 .sign_of_wave   (sign_sin1)); 


Sign_Detector #(.THRESHOLD (THRESHOLD) ,  .WIDTH (WIDTH)) Sign_Detector_U2 
(
 .sin_wave       (sin2) ,
 .sign_of_wave   (sign_sin2)); 



always @* begin
CLK_PERIOD_P1  = t2 - t1 ;
CLK_PERIOD_P2  = t4 - t3 ;
PHASE_SHIFT    = t3 - t1 ;
end




initial begin
   i = 0 ;
   j = 0 ;
   k = 0 ;   
end

initial begin
forever begin
@(posedge P1);
t1 = $realtime();
@(posedge P1);
t2 = $realtime();
end
end

initial begin
forever begin
@(posedge P2);
t3 = $realtime;
@(posedge P2);
t4 = $realtime;
end
end



initial clk_bit_p1 = 0;
always #(0.0005/2) clk_bit_p1= ~clk_bit_p1;
  

initial clk_bit_p2 = 0 ;
always #(0.0005/2) clk_bit_p2 = ~clk_bit_p2 ; 



always @(posedge clk_bit_p1)
begin
    sin1 = sine[i];
    i    = (i + 1) % 360 ;   
end


initial begin
    #(0.05);
    forever begin
     @(posedge clk_bit_p2);      
      sin2  = sine[j];
      j     = (j + 1) % 360 ;      
    end
end


always @(*)
begin
   sin_sum  = ((Code[7:0]/255.0) * sin2 + ((255.0 - Code[7:0])/255.0) * sin1) ; 
end



////////////////////////////////////////////////
/////////////// PHASES SELECTION ///////////////
////////////////////////////////////////////////

 always @(*) begin
   case(Code[9:8])
     
     2'b00: begin
           P1 = CLK      ;
           P2 = CLK_90   ;
         end

     2'b01: begin
           P1 = CLK_90    ;
           P2 = CLK_180   ;
         end

     2'b10: begin
           P1 = CLK_180  ;
           P2 = CLK_270  ;
         end

     2'b11: begin
           P1 = CLK_270  ;
           P2 = CLK      ;
         end         
   endcase        
 end


////////////////////////////////////////
//////////// SIN WAVE LUT //////////////
////////////////////////////////////////



initial begin
    sine[0]   = 25; sine[1]   = 25; sine[2]   = 26; sine[3]   = 26; sine[4]   = 27; sine[5]   = 27; sine[6]   = 28; sine[7]   = 28;
    sine[8]   = 28; sine[9]   = 29; sine[10]  = 29; sine[11]  = 30; sine[12]  = 30; sine[13]  = 31; sine[14]  = 31; sine[15]  = 31;
    sine[16]  = 32; sine[17]  = 32; sine[18]  = 33; sine[19]  = 33; sine[20]  = 34; sine[21]  = 34; sine[22]  = 34; sine[23]  = 35;
    sine[24]  = 35; sine[25]  = 36; sine[26]  = 36; sine[27]  = 36; sine[28]  = 37; sine[29]  = 37; sine[30]  = 38; sine[31]  = 38;
    sine[32]  = 38; sine[33]  = 39; sine[34]  = 39; sine[35]  = 39; sine[36]  = 40; sine[37]  = 40; sine[38]  = 40; sine[39]  = 41;
    sine[40]  = 41; sine[41]  = 41; sine[42]  = 42; sine[43]  = 42; sine[44]  = 42; sine[45]  = 43; sine[46]  = 43; sine[47]  = 43;
    sine[48]  = 44; sine[49]  = 44; sine[50]  = 44; sine[51]  = 44; sine[52]  = 45; sine[53]  = 45; sine[54]  = 45; sine[55]  = 45;
    sine[56]  = 46; sine[57]  = 46; sine[58]  = 46; sine[59]  = 46; sine[60]  = 47; sine[61]  = 47; sine[62]  = 47; sine[63]  = 47;
    sine[64]  = 47; sine[65]  = 48; sine[66]  = 48; sine[67]  = 48; sine[68]  = 48; sine[69]  = 48; sine[70]  = 48; sine[71]  = 49;
    sine[72]  = 49; sine[73]  = 49; sine[74]  = 49; sine[75]  = 49; sine[76]  = 49; sine[77]  = 49; sine[78]  = 49; sine[79]  = 50;
    sine[80]  = 50; sine[81]  = 50; sine[82]  = 50; sine[83]  = 50; sine[84]  = 50; sine[85]  = 50; sine[86]  = 50; sine[87]  = 50;
    sine[88]  = 50; sine[89]  = 50; sine[90]  = 50; sine[91]  = 50; sine[92]  = 50; sine[93]  = 50; sine[94]  = 50; sine[95]  = 50;
    sine[96]  = 50; sine[97]  = 50; sine[98]  = 50; sine[99]  = 50; sine[100] = 50; sine[101] = 50; sine[102] = 50; sine[103] = 49;
    sine[104] = 49; sine[105] = 49; sine[106] = 49; sine[107] = 49; sine[108] = 49; sine[109] = 49; sine[110] = 49; sine[111] = 48;
    sine[112] = 48; sine[113] = 48; sine[114] = 48; sine[115] = 48; sine[116] = 48; sine[117] = 47; sine[118] = 47; sine[119] = 47;
    sine[120] = 47; sine[121] = 47; sine[122] = 46; sine[123] = 46; sine[124] = 46; sine[125] = 46; sine[126] = 45; sine[127] = 45;
    sine[128] = 45; sine[129] = 45; sine[130] = 44; sine[131] = 44; sine[132] = 44; sine[133] = 44; sine[134] = 43; sine[135] = 43;
    sine[136] = 43; sine[137] = 42; sine[138] = 42; sine[139] = 42; sine[140] = 41; sine[141] = 41; sine[142] = 41; sine[143] = 40;
    sine[144] = 40; sine[145] = 40; sine[146] = 39; sine[147] = 39; sine[148] = 39; sine[149] = 38; sine[150] = 38; sine[151] = 38;
    sine[152] = 37; sine[153] = 37; sine[154] = 36; sine[155] = 36; sine[156] = 36; sine[157] = 35; sine[158] = 35; sine[159] = 34;
    sine[160] = 34; sine[161] = 34; sine[162] = 33; sine[163] = 33; sine[164] = 32; sine[165] = 32; sine[166] = 31; sine[167] = 31;
    sine[168] = 31; sine[169] = 30; sine[170] = 30; sine[171] = 29; sine[172] = 29; sine[173] = 28; sine[174] = 28; sine[175] = 28;
    sine[176] = 27; sine[177] = 27; sine[178] = 26; sine[179] = 26; sine[180] = 25; sine[181] = 25; sine[182] = 25; sine[183] = 24;
    sine[184] = 24; sine[185] = 23; sine[186] = 23; sine[187] = 22; sine[188] = 22; sine[189] = 22; sine[190] = 21; sine[191] = 21;
    sine[192] = 20; sine[193] = 20; sine[194] = 19; sine[195] = 19; sine[196] = 19; sine[197] = 18; sine[198] = 18; sine[199] = 17;
    sine[200] = 17; sine[201] = 16; sine[202] = 16; sine[203] = 16; sine[204] = 15; sine[205] = 15; sine[206] = 14; sine[207] = 14;
    sine[208] = 14; sine[209] = 13; sine[210] = 13; sine[211] = 13; sine[212] = 12; sine[213] = 12; sine[214] = 11; sine[215] = 11;
    sine[216] = 11; sine[217] = 10; sine[218] = 10; sine[219] = 10; sine[220] = 9 ; sine[221] = 9 ; sine[222] = 9 ; sine[223] = 8 ;
    sine[224] = 8 ; sine[225] = 8 ; sine[226] = 7 ; sine[227] = 7 ; sine[228] = 7 ; sine[229] = 6 ; sine[230] = 6 ; sine[231] = 6 ;
    sine[232] = 6 ; sine[233] = 5 ; sine[234] = 5 ; sine[235] = 5 ; sine[236] = 5 ; sine[237] = 4 ; sine[238] = 4 ; sine[239] = 4 ;
    sine[240] = 4 ; sine[241] = 3 ; sine[242] = 3 ; sine[243] = 3 ; sine[244] = 3 ; sine[245] = 3 ; sine[246] = 2 ; sine[247] = 2 ; 
    sine[248] = 2 ; sine[249] = 2 ; sine[250] = 2 ; sine[251] = 2 ; sine[252] = 1 ; sine[253] = 1 ; sine[254] = 1 ; sine[255] = 1 ;
    sine[256] = 1 ; sine[257] = 1 ; sine[258] = 1 ; sine[259] = 1 ; sine[260] = 0 ; sine[261] = 0 ; sine[262] = 0 ; sine[263] = 0 ;
    sine[264] = 0 ; sine[265] = 0 ; sine[266] = 0 ; sine[267] = 0 ; sine[268] = 0 ; sine[269] = 0 ; sine[270] = 0 ; sine[271] = 0 ;
    sine[272] = 0 ; sine[273] = 0 ; sine[274] = 0 ; sine[275] = 0 ; sine[276] = 0 ; sine[277] = 0 ; sine[278] = 0 ; sine[279] = 0 ;
    sine[280] = 0 ; sine[281] = 0 ; sine[282] = 0 ; sine[283] = 1 ; sine[284] = 1 ; sine[285] = 1 ; sine[286] = 1 ; sine[287] = 1 ;
    sine[288] = 1 ; sine[289] = 1 ; sine[290] = 1 ; sine[291] = 2 ; sine[292] = 2 ; sine[293] = 2 ; sine[294] = 2 ; sine[295] = 2 ;
    sine[296] = 2 ; sine[297] = 3 ; sine[298] = 3 ; sine[299] = 3 ; sine[300] = 3 ; sine[301] = 3 ; sine[302] = 4 ; sine[303] = 4 ;
    sine[304] = 4 ; sine[305] = 4 ; sine[306] = 5 ; sine[307] = 5 ; sine[308] = 5 ; sine[309] = 5 ; sine[310] = 6 ; sine[311] = 6 ;
    sine[312] = 6 ; sine[313] = 6 ; sine[314] = 7 ; sine[315] = 7 ; sine[316] = 7 ; sine[317] = 8 ; sine[318] = 8 ; sine[319] = 8 ; 
    sine[320] = 9 ; sine[321] = 9 ; sine[322] = 9 ; sine[323] = 10; sine[324] =10 ; sine[325] = 10; sine[326] = 11; sine[327] = 11; 
    sine[328] = 11; sine[329] = 12; sine[330] = 12; sine[331] = 13; sine[332] = 13; sine[333] = 13; sine[334] = 14; sine[335] = 14;
    sine[336] = 14; sine[337] = 15; sine[338] = 15; sine[339] = 16; sine[340] = 16; sine[341] = 16; sine[342] = 17; sine[343] = 17;
    sine[344] = 18; sine[345] = 18; sine[346] = 19; sine[347] = 19; sine[348] = 19; sine[349] = 20; sine[350] = 20; sine[351] = 21;
    sine[352] = 21; sine[353] = 22; sine[354] = 22; sine[355] = 22; sine[356] = 23; sine[357] = 23; sine[358] = 24; sine[359] = 25;
end

endmodule



///////////////////////////////////////
///////////////////////////////////////
////// SIGN OF SIN WAVE GENERATOR /////
///////////////////////////////////////
///////////////////////////////////////


module Sign_Detector #( parameter THRESHOLD = 25 , parameter WIDTH = 9)(
    input wire signed [WIDTH - 1 : 0] sin_wave,    // Clock
    output sign_of_wave
);

assign sign_of_wave = (sin_wave >=  THRESHOLD ) ? 1'b1 : 1'b0 ;

endmodule : Sign_Detector


///////////////////////////////////////
///////////////////////////////////////
///////////// TESTBENCH ///////////////
///////////////////////////////////////
///////////////////////////////////////

module PMIX_Tb;

 reg [9:0] Code          ; 
 reg       CLK           ;
 reg       CLK_90        ;
 wire      CLK_180       ;
 wire      CLK_270       ;

 wire      CLK_Out       ;

 integer i               ;

PMIX PMIX_DUT (.*)       ;

always #0.1 CLK  = ~CLK   ;
assign CLK_180  = ~CLK   ;
assign CLK_270  = ~CLK_90; 

initial begin
  CLK_90  = 0;
  #(0.05)      ;
  forever #0.1 CLK_90 = ~CLK_90;
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

  for ( i = 0; i < 100000; i = i + 1) begin
   Code = i ;
   #(0.000005);
  end


end


endmodule      

