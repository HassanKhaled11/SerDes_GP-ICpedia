
`timescale 1ns/1fs
module PMIX #(parameter THRESHOLD = 25 , parameter WIDTH = 9)
(
  input      CLK        ,
  input      [10:0] Code,	
  output      CLK_Out            
);


realtime Queue [$];

reg clk_index;
int index;
reg[15:0] sin_sum       ;
integer PHASE_SHIFT     ;

realtime t1             ;
realtime t2             ;
realtime T1  ;
reg [15:0] sin1 ;


realtime t3             ;
realtime t4             ;
realtime T1_P2  ; 
reg [15:0] sin2 ;

realtime t5             ;
realtime t6             ;
realtime RESULT_PERIOD  ; 


reg CLK_Out_i;
realtime time_now;
reg preparation_flag;


reg [WIDTH-1:0] sine [0:359];


assign CLK_Out = CLK_Out_i;


integer i , j , k     ;
realtime last_time    ;       // Require time data type

reg [WIDTH - 1:0] sin_0   [0:359];
reg [WIDTH - 1:0] sin_90  [0:359];
reg [WIDTH - 1:0] sin_180 [0:359];
reg [WIDTH - 1:0] sin_270 [0:359];
reg [WIDTH - 1:0] sin_45  [0:359];
reg [WIDTH - 1:0] sin_135 [0:359];
reg [WIDTH - 1:0] sin_225 [0:359];
reg [WIDTH - 1:0] sin_315 [0:359];


 
reg sign_0   ;
reg sign_90  ;
reg sign_180 ;
reg sign_270 ;
reg sign_45  ;
reg sign_135 ;
reg sign_225 ;
reg sign_315 ;




cdr_assertion #(.clk_period_expected_min(2) , .clk_period_expected_max(5)) pi_assertion
(
  .PI_CLK_OUT(CLK_Out_i)
);


////////////////////////////////////////////////
//////////////// SIGN OF SIN WAVES //////////////
////////////////////////////////////////////////

always @* begin
    if(sin_sum > THRESHOLD) CLK_Out_i = 1 ;
    else CLK_Out_i = 0;
end


always @* begin
    if(sin_0[index] > THRESHOLD) sign_0 = 1 ;
    else sign_0 = 0;
end


always @* begin
    if(sin_45[index] > THRESHOLD) sign_45 = 1 ;
    else sign_45 = 0;
end


always @* begin
    if(sin_90[index] > THRESHOLD) sign_90 = 1 ;
    else sign_90 = 0;
end


always @* begin
    if(sin_135[index] > THRESHOLD) sign_135 = 1 ;
    else sign_135 = 0;
end


always @* begin
    if(sin_180[index] > THRESHOLD) sign_180 = 1 ;
    else sign_180 = 0;
end


always @* begin
    if(sin_225[index] > THRESHOLD) sign_225 = 1 ;
    else sign_225 = 0;
end


always @* begin
    if(sin_270[index] > THRESHOLD) sign_270 = 1 ;
    else sign_270 = 0;
end

always @* begin
    if(sin_315[index] > THRESHOLD) sign_315 = 1 ;
    else sign_315 = 0;
end




////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////


// always @* begin
// PHASE_SHIFT    = t3 - t1 ;
// end


initial begin
   i          = 0 ;
   j          = 0 ;
   k          = 0 ;   
   last_time  = 0 ;
   T1 = 0;
end



// initial begin
//    forever @(posedge CLK) begin
//        Queue.push_back($realtime());
//         if(Queue.size() == 2) begin
//           T = Queue[1] - Queue[0];
//              Queue.pop_front();
//         end

//    end 
     
// end


initial begin
forever begin
@(posedge CLK);
t1 = $realtime;
@(posedge CLK);
t2 = $realtime;
T1  = t2 - t1 ;
end
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




reg clk_sin;
initial clk_sin = 0;
always #((0.1999/360) / 2) clk_sin = ~ clk_sin; 



always @(T1) begin
  preparation_flag = 1            ;   
 do begin
   @(posedge clk_sin)             ;
   sin_0   [i] = sine[i]          ;
   sin_45  [i] = sine[(i+45)%360] ;
   sin_90  [i] = sine[(i+90)%360] ;
   sin_135 [i] = sine[(i+135)%360];
   sin_180 [i] = sine[(i+180)%360];
   sin_225 [i] = sine[(i+225)%360];
   sin_270 [i] = sine[(i+270)%360];
   sin_315 [i] = sine[(i+315)%360];
   i = i + 1 ;          
 end while (i != 360);
   i = 0 ;
   preparation_flag = 0;
end




initial clk_index = 0;
always #(0.0002) clk_index= ~clk_index;   

    
////////////////////////////////////////////////
//////////////// INDEX CHANGE //////////////////
////////////////////////////////////////////////

 always @(posedge clk_index) begin
    time_now = $realtime - 0.1999*$floor($realtime/0.1999);                      //0.2 ---> change to T1
    index   = integer'((time_now/0.1999) * 360 ) % 360;
  end

////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////


always @(*)
begin

 if(!preparation_flag) begin
      
   case(Code[10:8]) 
    
        3'b000 : begin
             sin_sum  = integer'((Code[7:0]/255.0 * sin_45[index]  + ((255.0 - Code[7:0])/255.0 * sin_0[index] ))) % 51     ; 
        end
    
        3'b001 : begin 
             sin_sum  = integer'((Code[7:0]/255.0 * sin_90[index]  + ((255.0 - Code[7:0])/255.0 * sin_45[index] ))) % 51   ;    
        end 
        
        3'b010 : begin 
             sin_sum  = integer'((Code[7:0]/255.0 * sin_135[index] + ((255.0 - Code[7:0])/255.0 * sin_90[index] ))) % 51   ;    
        end
        
        3'b011 : begin 
             sin_sum  = integer'((Code[7:0]/255.0 * sin_180[index]  + ((255.0 - Code[7:0])/255.0 * sin_135[index] ))) % 51 ;    
        end
        
        3'b100 : begin 
             sin_sum  = integer'((Code[7:0]/255.0 * sin_225[index]  + ((255.0 - Code[7:0])/255.0 * sin_180[index] ))) % 51 ;    
        end
        
        3'b101 : begin 
             sin_sum  = integer'((Code[7:0]/255.0 * sin_270[index]  + ((255.0 - Code[7:0])/255.0 * sin_225[index] ))) % 51 ;    
        end
        
        3'b110 : begin 
             sin_sum  = integer'((Code[7:0]/255.0 * sin_315[index]  + ((255.0 - Code[7:0])/255.0 * sin_270[index] ))) % 51 ;    
        end
        
        3'b111 : begin 
             sin_sum  = integer'((Code[7:0]/255.0 * sin_0[index]  + ((255.0 - Code[7:0])/255.0 * sin_315[index] ))) % 51   ;    
        end
    endcase 

   end  
end



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
///////////// TESTBENCH ///////////////
///////////////////////////////////////
///////////////////////////////////////

module PMIX_Tb;

 reg CLK ;
 reg [10:0] Code          ; 
 // reg       CLK           ;
 // reg       CLK_90        ;
 // wire      CLK_180       ;
 // wire      CLK_270       ;

 // reg       CLK_45        ;
 // reg       CLK_135       ;
 // reg       CLK_225       ;
 // reg       CLK_315       ;

 wire      CLK_Out       ;

 integer i               ;

PMIX PMIX_DUT (.*)       ;

always #0.0999 CLK = ~CLK   ;    //5.001Ghz --> 0.1999
// assign CLK_180  = ~CLK   ;
// assign CLK_270  = ~CLK_90; 


// initial begin
//   CLK_90  = 0;
//   #(0.05)      ;
//   forever #0.1 CLK_90 = ~CLK_90;
// end

// initial begin
//   CLK_45  = 0;
//   #(0.025)      ;
//   forever #0.1 CLK_45 = ~CLK_45;
// end


// initial begin
//   CLK_135  = 0;
//   #(0.075)      ;
//   forever #0.1 CLK_135 = ~CLK_135;
// end


// initial begin
//   CLK_225  = 0;
//   #(0.125)      ;
//   forever #0.1 CLK_225 = ~CLK_225;
// end


// initial begin
//   CLK_315  = 0;
//   #(0.175)      ;
//   forever #0.1 CLK_315 = ~CLK_315;
// end




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

  for (i = 0; i < 2050; i = (i + 1)%2048) begin
   Code = i ;
  #(0.03);
  end
$stop();

end
endmodule      



module cdr_assertion #(clk_period_expected_min = 0.1 , clk_period_expected_max = 0.3)
(input PI_CLK_OUT
);


property CLK_OUT_PERIOD_prop (time clk_period_expected_min , time clk_period_expected_max);
 realtime current_time;    
@(posedge PI_CLK_OUT) ('1,current_time = $realtime()) |=> 
      ((clk_period_expected_min <= int'(1000*($realtime()-current_time))) &&
      (clk_period_expected_max  >= int'(1000*($realtime()-current_time)))); 
endproperty     

CLK_OUT_PERIOD_assert: assert property(CLK_OUT_PERIOD_prop(clk_period_expected_min , clk_period_expected_max));
CLK_OUT_PERIOD_cover : cover property (CLK_OUT_PERIOD_prop(clk_period_expected_min , clk_period_expected_max));

endmodule     