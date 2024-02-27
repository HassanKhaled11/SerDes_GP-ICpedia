`timescale 1ns / 1fs

module PMIX #(
    parameter THRESHOLD = 25,
    parameter WIDTH = 9
) (
    input [10:0] Code,
    input        CLK,
    input        CLK_90,
    input        CLK_180,
    input        CLK_270,

    input CLK_45,
    input CLK_135,
    input CLK_225,
    input CLK_315,


    output CLK_Out
);

  reg P1, P2;
  wire                     sign_sin1;
  wire                     sign_sin2;


  reg      [  WIDTH - 1:0] sine          [0:359];
  // reg [WIDTH - 1:0] sine [0:255] ;
  // reg [WIDTH - 1:0] sine [0:9] ;
  // reg [WIDTH - 1:0] sin_sum      ;
  integer                  sin_sum;
  integer                  PHASE_SHIFT;

  realtime                 t1;
  realtime                 t2;
  realtime                 CLK_PERIOD_P1;
  reg      [WIDTH - 1 : 0] sin1;


  realtime                 t3;
  realtime                 t4;
  realtime                 CLK_PERIOD_P2;
  reg      [WIDTH - 1 : 0] sin2;


  realtime                 t5;
  realtime                 t6;
  realtime                 RESULT_PERIOD;


  reg                      clk_bit_p1;
  reg                      clk_bit_p2;

  reg                      CLK_Out_i;

  assign CLK_Out = CLK_Out_i;


  integer i, j, k;
  realtime last_time;  // Require time data type


  // Calc_Distance Calc_Distance_U (.CLK(P1) , .difference_t(CLK_PERIOD_P1));


  // Sign_Detector #(.THRESHOLD (THRESHOLD) ,  .WIDTH (WIDTH)) Sign_Detector_U0 
  // (
  //  .sin_wave       (sin_sum) ,
  //  .sign_of_wave   (CLK_Out_i)); 


  always @* begin
    if (sin_sum > THRESHOLD) CLK_Out_i = 1;
    else CLK_Out_i = 0;
  end


  Sign_Detector #(
      .THRESHOLD(THRESHOLD),
      .WIDTH(WIDTH)
  ) Sign_Detector_U1 (
      .sin_wave    (sin1),
      .sign_of_wave(sign_sin1)
  );


  Sign_Detector #(
      .THRESHOLD(THRESHOLD),
      .WIDTH(WIDTH)
  ) Sign_Detector_U2 (
      .sin_wave    (sin2),
      .sign_of_wave(sign_sin2)
  );



  always @* begin
    PHASE_SHIFT = t3 - t1;
  end


  initial begin
    i         = 0;
    j         = 0;
    k         = 0;
    last_time = 0;
  end


  initial begin
    forever begin
      @(posedge P1);
      t1 = $realtime();
      @(posedge P1);
      t2 = $realtime();
      CLK_PERIOD_P1 = t2 - t1;
    end
  end


  initial begin
    forever begin
      @(posedge P2);
      t3 = $realtime;
      @(posedge P2);
      t4 = $realtime;
      CLK_PERIOD_P2 = t4 - t3;
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


  initial begin
    forever begin
      @(posedge CLK_Out_i);
      t5 = $realtime;
      @(posedge CLK_Out_i);
      t6 = $realtime;
      RESULT_PERIOD = t6 - t5;
    end
  end



  initial clk_bit_p1 = 0;
  always #(0.0005555 / 2) clk_bit_p1 = ~clk_bit_p1;  // 0.2/360 --> need to be parametrized
  // always #(0.02/2) clk_bit_p1= ~clk_bit_p1;   

  initial clk_bit_p2 = 0;
  always #(0.0005555 / 2) clk_bit_p2 = ~clk_bit_p2;
  // always #(0.02/2) clk_bit_p2 = ~clk_bit_p2 ; 



  always @(posedge clk_bit_p1) begin
    sin1 = sine[i];
    i    = (i + 1) % 360;
    // i    = (i + 1) % 256 ;
    // i    = (i + 1) % 10  ;       
  end


  initial begin
    #(0.025);  // 8 phases = 0.025 - 4 phases = 0.05
    forever begin
      @(posedge clk_bit_p2);
      sin2 = sine[j];
      j    = (j + 1) % 360 ;
      //j    = (j + 1) % 256 ;
      //j    = (j + 1) % 10  ;               
    end
  end


  always @(*) begin
    sin_sum = integer'(((Code[7:0] / 255.0) * sin2 + ((255.0 - Code[7:0]) / 255.0) * sin1)) % 255;
  end


  ////////////////////////////////////////////////
  /////////////// PHASES SELECTION ///////////////
  ////////////////////////////////////////////////

  // always @(*) begin
  //   case(Code[9:8])

  //     2'b00: begin
  //           P1 = CLK      ;
  //           P2 = CLK_90   ;
  //         end

  //     2'b01: begin
  //           P1 = CLK_90    ;
  //           P2 = CLK_180   ;
  //         end

  //     2'b10: begin
  //           P1 = CLK_180  ;
  //           P2 = CLK_270  ;
  //         end 

  //     2'b11: begin
  //           P1 = CLK_270  ;
  //           P2 = CLK      ;
  //         end         
  //   endcase        
  // end



  always @(*) begin
    case (Code[10:8])

      3'b000: begin
        P1 = CLK;
        P2 = CLK_45;
      end

      3'b001: begin
        P1 = CLK_45;
        P2 = CLK_90;
      end

      3'b010: begin
        P1 = CLK_90;
        P2 = CLK_135;
      end

      3'b011: begin
        P1 = CLK_135;
        P2 = CLK_180;
      end


      3'b100: begin
        P1 = CLK_180;
        P2 = CLK_225;
      end

      3'b101: begin
        P1 = CLK_225;
        P2 = CLK_270;
      end


      3'b110: begin
        P1 = CLK_270;
        P2 = CLK_315;
      end


      3'b111: begin
        P1 = CLK_315;
        P2 = CLK;
      end


    endcase
  end



  ////////////////////////////////////////
  //////////// SIN WAVE LUT //////////////
  ////////////////////////////////////////



  initial begin
    sine[0]   = 25;
    sine[1]   = 25;
    sine[2]   = 26;
    sine[3]   = 26;
    sine[4]   = 27;
    sine[5]   = 27;
    sine[6]   = 28;
    sine[7]   = 28;
    sine[8]   = 28;
    sine[9]   = 29;
    sine[10]  = 29;
    sine[11]  = 30;
    sine[12]  = 30;
    sine[13]  = 31;
    sine[14]  = 31;
    sine[15]  = 31;
    sine[16]  = 32;
    sine[17]  = 32;
    sine[18]  = 33;
    sine[19]  = 33;
    sine[20]  = 34;
    sine[21]  = 34;
    sine[22]  = 34;
    sine[23]  = 35;
    sine[24]  = 35;
    sine[25]  = 36;
    sine[26]  = 36;
    sine[27]  = 36;
    sine[28]  = 37;
    sine[29]  = 37;
    sine[30]  = 38;
    sine[31]  = 38;
    sine[32]  = 38;
    sine[33]  = 39;
    sine[34]  = 39;
    sine[35]  = 39;
    sine[36]  = 40;
    sine[37]  = 40;
    sine[38]  = 40;
    sine[39]  = 41;
    sine[40]  = 41;
    sine[41]  = 41;
    sine[42]  = 42;
    sine[43]  = 42;
    sine[44]  = 42;
    sine[45]  = 43;
    sine[46]  = 43;
    sine[47]  = 43;
    sine[48]  = 44;
    sine[49]  = 44;
    sine[50]  = 44;
    sine[51]  = 44;
    sine[52]  = 45;
    sine[53]  = 45;
    sine[54]  = 45;
    sine[55]  = 45;
    sine[56]  = 46;
    sine[57]  = 46;
    sine[58]  = 46;
    sine[59]  = 46;
    sine[60]  = 47;
    sine[61]  = 47;
    sine[62]  = 47;
    sine[63]  = 47;
    sine[64]  = 47;
    sine[65]  = 48;
    sine[66]  = 48;
    sine[67]  = 48;
    sine[68]  = 48;
    sine[69]  = 48;
    sine[70]  = 48;
    sine[71]  = 49;
    sine[72]  = 49;
    sine[73]  = 49;
    sine[74]  = 49;
    sine[75]  = 49;
    sine[76]  = 49;
    sine[77]  = 49;
    sine[78]  = 49;
    sine[79]  = 50;
    sine[80]  = 50;
    sine[81]  = 50;
    sine[82]  = 50;
    sine[83]  = 50;
    sine[84]  = 50;
    sine[85]  = 50;
    sine[86]  = 50;
    sine[87]  = 50;
    sine[88]  = 50;
    sine[89]  = 50;
    sine[90]  = 50;
    sine[91]  = 50;
    sine[92]  = 50;
    sine[93]  = 50;
    sine[94]  = 50;
    sine[95]  = 50;
    sine[96]  = 50;
    sine[97]  = 50;
    sine[98]  = 50;
    sine[99]  = 50;
    sine[100] = 50;
    sine[101] = 50;
    sine[102] = 50;
    sine[103] = 49;
    sine[104] = 49;
    sine[105] = 49;
    sine[106] = 49;
    sine[107] = 49;
    sine[108] = 49;
    sine[109] = 49;
    sine[110] = 49;
    sine[111] = 48;
    sine[112] = 48;
    sine[113] = 48;
    sine[114] = 48;
    sine[115] = 48;
    sine[116] = 48;
    sine[117] = 47;
    sine[118] = 47;
    sine[119] = 47;
    sine[120] = 47;
    sine[121] = 47;
    sine[122] = 46;
    sine[123] = 46;
    sine[124] = 46;
    sine[125] = 46;
    sine[126] = 45;
    sine[127] = 45;
    sine[128] = 45;
    sine[129] = 45;
    sine[130] = 44;
    sine[131] = 44;
    sine[132] = 44;
    sine[133] = 44;
    sine[134] = 43;
    sine[135] = 43;
    sine[136] = 43;
    sine[137] = 42;
    sine[138] = 42;
    sine[139] = 42;
    sine[140] = 41;
    sine[141] = 41;
    sine[142] = 41;
    sine[143] = 40;
    sine[144] = 40;
    sine[145] = 40;
    sine[146] = 39;
    sine[147] = 39;
    sine[148] = 39;
    sine[149] = 38;
    sine[150] = 38;
    sine[151] = 38;
    sine[152] = 37;
    sine[153] = 37;
    sine[154] = 36;
    sine[155] = 36;
    sine[156] = 36;
    sine[157] = 35;
    sine[158] = 35;
    sine[159] = 34;
    sine[160] = 34;
    sine[161] = 34;
    sine[162] = 33;
    sine[163] = 33;
    sine[164] = 32;
    sine[165] = 32;
    sine[166] = 31;
    sine[167] = 31;
    sine[168] = 31;
    sine[169] = 30;
    sine[170] = 30;
    sine[171] = 29;
    sine[172] = 29;
    sine[173] = 28;
    sine[174] = 28;
    sine[175] = 28;
    sine[176] = 27;
    sine[177] = 27;
    sine[178] = 26;
    sine[179] = 26;
    sine[180] = 25;
    sine[181] = 25;
    sine[182] = 25;
    sine[183] = 24;
    sine[184] = 24;
    sine[185] = 23;
    sine[186] = 23;
    sine[187] = 22;
    sine[188] = 22;
    sine[189] = 22;
    sine[190] = 21;
    sine[191] = 21;
    sine[192] = 20;
    sine[193] = 20;
    sine[194] = 19;
    sine[195] = 19;
    sine[196] = 19;
    sine[197] = 18;
    sine[198] = 18;
    sine[199] = 17;
    sine[200] = 17;
    sine[201] = 16;
    sine[202] = 16;
    sine[203] = 16;
    sine[204] = 15;
    sine[205] = 15;
    sine[206] = 14;
    sine[207] = 14;
    sine[208] = 14;
    sine[209] = 13;
    sine[210] = 13;
    sine[211] = 13;
    sine[212] = 12;
    sine[213] = 12;
    sine[214] = 11;
    sine[215] = 11;
    sine[216] = 11;
    sine[217] = 10;
    sine[218] = 10;
    sine[219] = 10;
    sine[220] = 9;
    sine[221] = 9;
    sine[222] = 9;
    sine[223] = 8;
    sine[224] = 8;
    sine[225] = 8;
    sine[226] = 7;
    sine[227] = 7;
    sine[228] = 7;
    sine[229] = 6;
    sine[230] = 6;
    sine[231] = 6;
    sine[232] = 6;
    sine[233] = 5;
    sine[234] = 5;
    sine[235] = 5;
    sine[236] = 5;
    sine[237] = 4;
    sine[238] = 4;
    sine[239] = 4;
    sine[240] = 4;
    sine[241] = 3;
    sine[242] = 3;
    sine[243] = 3;
    sine[244] = 3;
    sine[245] = 3;
    sine[246] = 2;
    sine[247] = 2;
    sine[248] = 2;
    sine[249] = 2;
    sine[250] = 2;
    sine[251] = 2;
    sine[252] = 1;
    sine[253] = 1;
    sine[254] = 1;
    sine[255] = 1;
    sine[256] = 1;
    sine[257] = 1;
    sine[258] = 1;
    sine[259] = 1;
    sine[260] = 0;
    sine[261] = 0;
    sine[262] = 0;
    sine[263] = 0;
    sine[264] = 0;
    sine[265] = 0;
    sine[266] = 0;
    sine[267] = 0;
    sine[268] = 0;
    sine[269] = 0;
    sine[270] = 0;
    sine[271] = 0;
    sine[272] = 0;
    sine[273] = 0;
    sine[274] = 0;
    sine[275] = 0;
    sine[276] = 0;
    sine[277] = 0;
    sine[278] = 0;
    sine[279] = 0;
    sine[280] = 0;
    sine[281] = 0;
    sine[282] = 0;
    sine[283] = 1;
    sine[284] = 1;
    sine[285] = 1;
    sine[286] = 1;
    sine[287] = 1;
    sine[288] = 1;
    sine[289] = 1;
    sine[290] = 1;
    sine[291] = 2;
    sine[292] = 2;
    sine[293] = 2;
    sine[294] = 2;
    sine[295] = 2;
    sine[296] = 2;
    sine[297] = 3;
    sine[298] = 3;
    sine[299] = 3;
    sine[300] = 3;
    sine[301] = 3;
    sine[302] = 4;
    sine[303] = 4;
    sine[304] = 4;
    sine[305] = 4;
    sine[306] = 5;
    sine[307] = 5;
    sine[308] = 5;
    sine[309] = 5;
    sine[310] = 6;
    sine[311] = 6;
    sine[312] = 6;
    sine[313] = 6;
    sine[314] = 7;
    sine[315] = 7;
    sine[316] = 7;
    sine[317] = 8;
    sine[318] = 8;
    sine[319] = 8;
    sine[320] = 9;
    sine[321] = 9;
    sine[322] = 9;
    sine[323] = 10;
    sine[324] = 10;
    sine[325] = 10;
    sine[326] = 11;
    sine[327] = 11;
    sine[328] = 11;
    sine[329] = 12;
    sine[330] = 12;
    sine[331] = 13;
    sine[332] = 13;
    sine[333] = 13;
    sine[334] = 14;
    sine[335] = 14;
    sine[336] = 14;
    sine[337] = 15;
    sine[338] = 15;
    sine[339] = 16;
    sine[340] = 16;
    sine[341] = 16;
    sine[342] = 17;
    sine[343] = 17;
    sine[344] = 18;
    sine[345] = 18;
    sine[346] = 19;
    sine[347] = 19;
    sine[348] = 19;
    sine[349] = 20;
    sine[350] = 20;
    sine[351] = 21;
    sine[352] = 21;
    sine[353] = 22;
    sine[354] = 22;
    sine[355] = 22;
    sine[356] = 23;
    sine[357] = 23;
    sine[358] = 24;
    sine[359] = 25;


    //////////////////////// 256 point ///////////////////////////
    // sine[0]   = 25; sine[1]   = 26; sine[2]   = 26; sine[3]   = 27; sine[4]   = 27; sine[5]   = 28; sine[6]   = 29; sine[7]   = 29;
    // sine[8]   = 30; sine[9]   = 30; sine[10]  = 31; sine[11]  = 32; sine[12]  = 32; sine[13]  = 33; sine[14]  = 33; sine[15]  = 34;
    // sine[16]  = 35; sine[17]  = 35; sine[18]  = 36; sine[19]  = 36; sine[20]  = 37; sine[21]  = 37; sine[22]  = 38; sine[23]  = 38;
    // sine[24]  = 39; sine[25]  = 39; sine[26]  = 40; sine[27]  = 40; sine[28]  = 41; sine[29]  = 41; sine[30]  = 42; sine[31]  = 42;
    // sine[32]  = 43; sine[33]  = 43; sine[34]  = 44; sine[35]  = 44; sine[36]  = 44; sine[37]  = 45; sine[38]  = 45; sine[39]  = 45;
    // sine[40]  = 46; sine[41]  = 46; sine[42]  = 46; sine[43]  = 47; sine[44]  = 47; sine[45]  = 47; sine[46]  = 48; sine[47]  = 48;
    // sine[48]  = 48; sine[49]  = 48; sine[50]  = 49; sine[51]  = 49; sine[52]  = 49; sine[53]  = 49; sine[54]  = 49; sine[55]  = 49;
    // sine[56]  = 50; sine[57]  = 50; sine[58]  = 50; sine[59]  = 50; sine[60]  = 50; sine[61]  = 50; sine[62]  = 50; sine[63]  = 50;
    // sine[64]  = 50; sine[65]  = 50; sine[66]  = 50; sine[67]  = 50; sine[68]  = 50; sine[69]  = 50; sine[70]  = 50; sine[71]  = 50;
    // sine[72]  = 50; sine[73]  = 50; sine[74]  = 50; sine[75]  = 50; sine[76]  = 50; sine[77]  = 50; sine[78]  = 49; sine[79]  = 49;
    // sine[80]  = 49; sine[81]  = 49; sine[82]  = 49; sine[83]  = 49; sine[84]  = 48; sine[85]  = 48; sine[86]  = 48; sine[87]  = 48;
    // sine[88]  = 47; sine[89]  = 47; sine[90]  = 47; sine[91]  = 46; sine[92]  = 46; sine[93]  = 46; sine[94]  = 45; sine[95]  = 45;
    // sine[96]  = 45; sine[97]  = 44; sine[98]  = 44; sine[99]  = 44; sine[100] = 43; sine[101] = 43; sine[102] = 42; sine[103] = 42;
    // sine[104] = 41; sine[105] = 41; sine[106] = 40; sine[107] = 40; sine[108] = 39; sine[109] = 39; sine[110] = 38; sine[111] = 38;
    // sine[112] = 37; sine[113] = 37; sine[114] = 36; sine[115] = 36; sine[116] = 35; sine[117] = 35; sine[118] = 34; sine[119] = 33;
    // sine[120] = 33; sine[121] = 32; sine[122] = 32; sine[123] = 31; sine[124] = 30; sine[125] = 30; sine[126] = 29; sine[127] = 29;
    // sine[128] = 28; sine[129] = 27; sine[130] = 27; sine[131] = 26; sine[132] = 26; sine[133] = 25; sine[134] = 24; sine[135] = 24;
    // sine[136] = 23; sine[137] = 23; sine[138] = 22; sine[139] = 21; sine[140] = 21; sine[141] = 20; sine[142] = 20; sine[143] = 19;
    // sine[144] = 18; sine[145] = 18; sine[146] = 17; sine[147] = 17; sine[148] = 16; sine[149] = 15; sine[150] = 15; sine[151] = 14;
    // sine[152] = 14; sine[153] = 13; sine[154] = 13; sine[155] = 12; sine[156] = 12; sine[157] = 11; sine[158] = 11; sine[159] = 10;
    // sine[160] = 10; sine[161] = 9 ; sine[162] = 9 ; sine[163] = 8 ; sine[164] = 8 ; sine[165] = 7 ; sine[166] = 7 ; sine[167] = 6 ;
    // sine[168] = 6 ; sine[169] = 6 ; sine[170] = 5 ; sine[171] = 5 ; sine[172] = 5 ; sine[173] = 4 ; sine[174] = 4 ; sine[175] = 4 ;
    // sine[176] = 3 ; sine[177] = 3 ; sine[178] = 3 ; sine[179] = 2 ; sine[180] = 2 ; sine[181] = 2 ; sine[182] = 2 ; sine[183] = 1 ;
    // sine[184] = 1 ; sine[185] = 1 ; sine[186] = 1 ; sine[187] = 1 ; sine[188] = 1 ; sine[189] = 0 ; sine[190] = 0 ; sine[191] = 0 ;
    // sine[192] = 0 ; sine[193] = 0 ; sine[194] = 0 ; sine[195] = 0 ; sine[196] = 0 ; sine[197] = 0 ; sine[198] = 0 ; sine[199] = 0 ;
    // sine[200] = 0 ; sine[201] = 0 ; sine[202] = 0 ; sine[203] = 0 ; sine[204] = 0 ; sine[205] = 0 ; sine[206] = 0 ; sine[207] = 0 ;
    // sine[208] = 0 ; sine[209] = 0 ; sine[210] = 0 ; sine[211] = 0 ; sine[212] = 0 ; sine[213] = 0 ; sine[214] = 1 ; sine[215] = 1 ;
    // sine[216] = 1 ; sine[217] = 1 ; sine[218] = 1 ; sine[219] = 1 ; sine[220] = 2 ; sine[221] = 2 ; sine[222] = 2 ; sine[223] = 2 ;
    // sine[224] = 3 ; sine[225] = 3 ; sine[226] = 3 ; sine[227] = 4 ; sine[228] = 4 ; sine[229] = 4 ; sine[230] = 5 ; sine[231] = 5 ;
    // sine[232] = 5 ; sine[233] = 6 ; sine[234] = 6 ; sine[235] = 7 ; sine[236] = 7 ; sine[237] = 8 ; sine[238] = 9 ; sine[239] = 9 ;
    // sine[240] = 10; sine[241] = 10; sine[242] = 11; sine[243] = 11; sine[244] = 12; sine[245] = 12; sine[246] = 13; sine[247] = 13;
    // sine[248] = 15; sine[249] = 17; sine[250] = 19; sine[251] = 20; sine[252] = 21; sine[253] = 22; sine[254] = 23; sine[255] = 24;

    //////////////////////// 10 points /////////////////////////
    // sine[0] = 5;
    // sine[1] = 8;
    // sine[2] = 9;
    // sine[3] = 10;
    // sine[4] = 8;
    // sine[5] = 5;
    // sine[6] = 2;
    // sine[7] = 0;
    // sine[8] = 2;
    // sine[9] = 5;
  end




endmodule



///////////////////////////////////////
///////////////////////////////////////
////// SIGN OF SIN WAVE GENERATOR /////
///////////////////////////////////////
///////////////////////////////////////


module Sign_Detector #(
    parameter THRESHOLD = 25,
    parameter WIDTH = 9
) (
    input wire signed [WIDTH - 1 : 0] sin_wave,  // Clock
    output sign_of_wave
);

  assign sign_of_wave = (sin_wave >= THRESHOLD) ? 1'b1 : 1'b0;

endmodule : Sign_Detector


///////////////////////////////////////
///////////////////////////////////////
///////////// TESTBENCH ///////////////
///////////////////////////////////////
///////////////////////////////////////

module PMIX_Tb;

  reg     [10:0] Code;
  reg            CLK;
  reg            CLK_90;
  wire           CLK_180;
  wire           CLK_270;

  reg            CLK_45;
  reg            CLK_135;
  reg            CLK_225;
  reg            CLK_315;

  wire           CLK_Out;

  integer        i;

  PMIX PMIX_DUT (.*);

  always #0.1 CLK = ~CLK;
  assign CLK_180 = ~CLK;
  assign CLK_270 = ~CLK_90;


  initial begin
    CLK_90 = 0;
    #(0.05);
    forever #0.1 CLK_90 = ~CLK_90;
  end

  initial begin
    CLK_45 = 0;
    #(0.025);
    forever #0.1 CLK_45 = ~CLK_45;
  end


  initial begin
    CLK_135 = 0;
    #(0.075);
    forever #0.1 CLK_135 = ~CLK_135;
  end


  initial begin
    CLK_225 = 0;
    #(0.125);
    forever #0.1 CLK_225 = ~CLK_225;
  end


  initial begin
    CLK_315 = 0;
    #(0.175);
    forever #0.1 CLK_315 = ~CLK_315;
  end




  initial begin

    CLK  = 0;

    Code = 10'b00_1000_0000;
    #(0.2 * 2);
    Code = 10'b00_1111_1111;
    #(0.2 * 2);
    Code = 10'b01_0000_0000;
    #(0.2 * 2);
    Code = 10'b01_1111_1111;
    #(0.2 * 2);
    Code = 10'b10_0000_0000;
    #(0.2 * 2);
    Code = 10'b10_1111_1111;
    #(0.2 * 2);
    Code = 10'b11_0000_0000;
    #(0.2 * 2);
    Code = 10'b11_1111_1111;
    #(0.2 * 2);



    #5;

    for (i = 0; i < 1025; i = (i + 1) % 2048) begin
      Code = i;
      #(0.0002);
    end


  end



endmodule
