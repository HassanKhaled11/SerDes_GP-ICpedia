`timescale 1ns / 1fs
module BBPD (
    input clk,  // Clock
    input clk_ref,

`ifdef THREE_CLKS
    input clk_90,
    input clk_180,
`endif

    input Din,  // serial data
    input rst_n,  // Asynchronous reset active low
    output Up,
    Dn,
    output reg A
);


  ///////////////////////////////////////////////////////////// IMP1

  reg B;
  reg T_, T;



  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      A <= 1'b0;
      B <= 1'b0;
      T <= 1'b0;
    end else begin
      B <= Din;
      A <= B;
      T <= T_;
    end
  end





  always @(negedge clk or negedge rst_n) begin
    if (~rst_n) begin
      T_ <= 0;
    end else begin
      T_ <= Din;
    end
  end

  assign Up = A ^ T;
  assign Dn = B ^ T;


  ///////////////////////////////////////////////////////////// IMP2

  // reg B, C;

  // always @(posedge clk or negedge rst_n) begin
  //   if (!rst_n) begin
  //     A <= 0;
  //   end else begin
  //     A <= Din;
  //   end

  // end

  // always @(posedge clk_90 or negedge rst_n) begin
  //   if (!rst_n) begin
  //     B <= 0;
  //   end else begin
  //     B <= Din;
  //   end
  // end

  // always @(posedge clk_180 or negedge rst_n) begin
  //   if (!rst_n) begin
  //     C <= 0;
  //   end else begin
  //     C <= Din;
  //   end
  // end


  // assign Up = A ^ B;
  // assign Dn = B ^ C;



  ///////////////////////////////////////////////////////////// IMP3

  // reg clear ;


  // always @(posedge clk or negedge rst_n) begin
  // 	if(~rst_n) begin
  // 		A <= 0;
  // 	end else begin
  // 		A <= Din;
  // 	end
  // end


  // /////////////////////////////
  // /////////// UP //////////////
  // /////////////////////////////
  // always @(posedge clk_ref or posedge clear or negedge rst_n) begin

  // if(!rst_n) begin
  // 	Up <= 0;
  // end

  // else if(clear) begin
  // 	Up <= 0;
  // end  


  // else begin
  // 	Up <= 1'b1;
  // end 

  // end



  // /////////////////////////////
  // /////////// DN //////////////
  // /////////////////////////////
  // always @(posedge clk or posedge clear or negedge rst_n) begin

  // if(!rst_n) begin
  // 	Dn <= 0;
  // end

  // else if(clear) begin
  // 	Dn <= 0;
  // end  

  // else begin
  // 	Dn <= 1'b1;
  // end 

  // end

  // always@(*) begin
  // 	clear = Up & Dn;
  // end 



endmodule




//////////////////////////////////


`timescale 1ns / 1fs

module Digital_Loop_Filter (

    input Up,
    Dn,
    input clk,  // Clock
    input rst_n,  // Asynchronous reset active low
    output [10:0] code

);

  parameter PHUG = 8;
  parameter PHASE_WIDTH = 16;
  parameter FREQ_WIDTH = 16;
  parameter FRUG = 3;

  reg [FREQ_WIDTH-1:0] freq_integrator;
  reg [PHASE_WIDTH-1:0] phase_integrator;

  wire [1:0] UP_DN;

  assign code  = phase_integrator[PHASE_WIDTH-1:PHASE_WIDTH-11];  // top 11

  assign UP_DN = {Up, Dn};

  always @(posedge clk or negedge rst_n) begin

    if (!rst_n) begin

      phase_integrator <= 0;
      freq_integrator  <= 0;

    end else begin

      case ({
        Up, Dn
      })

        2'b10: begin  // late

          freq_integrator <= FRUG * (Up - Dn) + (freq_integrator);
          phase_integrator  <=  phase_integrator  + freq_integrator[FREQ_WIDTH-2:FREQ_WIDTH-10] + PHUG*(Up - Dn); //$unsigned(~freq_integrator[18:11])

        end

        2'b01: begin  // early 

          freq_integrator <= FRUG * (Up - Dn) + (freq_integrator);
          phase_integrator <= phase_integrator - $unsigned(
              ~freq_integrator[FREQ_WIDTH-2:FREQ_WIDTH-10]
          ) + PHUG * (Up - Dn);  //$unsigned(~freq_integrator[18:11])     

        end

      endcase

    end

  end


endmodule



/*



A    T    B    -->  Description

--------------------------------------

0    0    0    -->  no transition
0    0    1    -->  early
0    1    0    -->  shouldn't occur
0    1    1    -->  late
1    0    0    -->  late
1    0    1    -->  shouldn't occur
1    1    0    -->  early
1    1    1    -->  no transition



*/


//////////////////////////////////////////////////////////


module Box_Car_Voting (
    input  clk,
    input  Dn,
    input  Up,
    output vote_Dn,
    output vote_Up
);
  parameter NUMBER_SAMPLES = 3;

  reg [NUMBER_SAMPLES-1:0] collector_up;
  reg [NUMBER_SAMPLES-1:0] collector_dn;
  int sum_up;
  int sum_dn;
  initial begin
    collector_up = 0;
    collector_dn = 0;
  end
  always @(posedge clk) begin
    collector_up = {Up, collector_up[NUMBER_SAMPLES-1:1]};
    collector_dn = {Dn, collector_dn[NUMBER_SAMPLES-1:1]};
    sum_up = 0;  // Reset sum_up
    sum_dn = 0;  // Reset sum_dn
    for (int j = 0; j < NUMBER_SAMPLES; j = j + 1) begin
      sum_up = sum_up + collector_up[j];
      sum_dn = sum_dn + collector_dn[j];
    end
  end

  assign vote_Up = (sum_up > (NUMBER_SAMPLES / 2));
  assign vote_Dn = (sum_dn > (NUMBER_SAMPLES / 2));

endmodule







////////////////////////////////////////////////////////////////////


// `timescale 1ps / 1ps
// module box_Car_voting_Tb ();
//   reg  voting_clk;
//   reg  Dn;
//   reg  Up;
//   wire vote_Up;
//   wire vote_Dn;

//   parameter N = 3;
//   reg clk;  //changes up and dn
//   //voting clk sample

//   int period = 100;
//   initial begin
//     voting_clk = 0;
//     forever #((period / 2) / N) voting_clk = ~voting_clk;  //200/5 (5 samples per bits)
//   end

//   //change up and dn
//   initial begin
//     clk = 0;
//     forever #(period / 2) clk = ~clk;  //200/5 (5 samples per bits)
//   end

//   Box_Car_Voting #(N) Box_Car_Voting_U (
//       .clk(voting_clk),
//       .Dn(Dn),
//       .Up(Up),
//       .vote_Dn(vote_Dn),
//       .vote_Up(vote_Up)
//   );
//   initial begin
//     for (int i = 0; i < 100; i++) begin
//       Dn = $random;
//       Up = $random;
//       @(negedge clk);
//     end
//     @(negedge clk);
//     Up = 0;
//     Dn = 0;
//     #1;
//     /////////////////////////
//     Up = 1;
//     Dn = 1;
//     #1;
//     Up = 0;
//     Dn = 0;
//     #10;


//     $stop;
//   end
// endmodule



//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

`timescale 1ns / 1fs

module Clk_Gen (

    input clk_in,
    input rst_n,

    output clk_90,
    output clk_180


);


  reg         clk;
  reg [360:1] clk_;

  ////////////////////////////////////////
  ///////// INTERNAL CLK GENERAION ///////
  ////////////////////////////////////////


  initial begin
    clk = 0;
    forever #0.00055 clk = ~clk;
  end



  assign clk_90  = clk_[45];
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
        end else if (i == 1) clk_[1] <= clk_in;

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

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

`timescale 1ns / 1fs
module PMIX #(
    parameter THRESHOLD = 25,
    parameter WIDTH = 9
) (
    input        CLK,
    input [10:0] Code,

    // output reg        clk_filter_
`ifdef THREE_CLKS
    input  rst_n,
    output clk_90,
    output clk_180,
`endif

    output reg CLK_Out_i

);


  realtime        Queue       [$];

  reg             clk_index;
  int             index;
  reg      [15:0] sin_sum;





  integer         PHASE_SHIFT;

  realtime        t1;
  realtime        t2;
  realtime T1, T_;
  reg      [15:0] sin1;


  realtime        t3;
  realtime        t4;
  realtime        T1_P2;
  reg      [15:0] sin2;

  realtime        t5;
  realtime        t6;
  realtime        RESULT_PERIOD;


  // reg             CLK_Out_i;
  realtime        time_now;
  reg             preparation_flag;

  //////////////////////////////////
  /////// CLK FILTERING SIGNALS/////
  //////////////////////////////////
  // reg             clk_filter;
  reg glitchR_found, glitchF_found;
  //////////////////////////////////
  //////////////////////////////////  

  reg [WIDTH-1:0] sine[0:359];

  int PPM;


  assign CLK_Out = CLK_Out_i;


  integer i, j, k;
  realtime               last_time;  // Require time data type

  reg      [WIDTH - 1:0] sin_0                                [0:359];
  reg      [WIDTH - 1:0] sin_90                               [0:359];
  reg      [WIDTH - 1:0] sin_180                              [0:359];
  reg      [WIDTH - 1:0] sin_270                              [0:359];
  reg      [WIDTH - 1:0] sin_45                               [0:359];
  reg      [WIDTH - 1:0] sin_135                              [0:359];
  reg      [WIDTH - 1:0] sin_225                              [0:359];
  reg      [WIDTH - 1:0] sin_315                              [0:359];



  reg                    sign_0;
  reg                    sign_90;
  reg                    sign_180;
  reg                    sign_270;
  reg                    sign_45;
  reg                    sign_135;
  reg                    sign_225;
  reg                    sign_315;



`ifdef THREE_CLKS

  Clk_Gen Clk_gen_U (

      .clk_in(CLK_Out_i),
      .rst_n (rst_n),

      .clk_90 (clk_90),
      .clk_180(clk_180)
  );

`endif

  ////////////////////////////////////////////////
  //////////////// SIGN OF SIN WAVES //////////////
  ////////////////////////////////////////////////

  always @* begin
    if (sin_sum >= THRESHOLD) CLK_Out_i = 1;
    else CLK_Out_i = 0;
  end


  always @* begin
    if (sin_0[index] >= THRESHOLD) sign_0 = 1;
    else sign_0 = 0;
  end


  always @* begin
    if (sin_45[index] >= THRESHOLD) sign_45 = 1;
    else sign_45 = 0;
  end


  always @* begin
    if (sin_90[index] >= THRESHOLD) sign_90 = 1;
    else sign_90 = 0;
  end


  always @* begin
    if (sin_135[index] >= THRESHOLD) sign_135 = 1;
    else sign_135 = 0;
  end


  always @* begin
    if (sin_180[index] >= THRESHOLD) sign_180 = 1;
    else sign_180 = 0;
  end


  always @* begin
    if (sin_225[index] >= THRESHOLD) sign_225 = 1;
    else sign_225 = 0;
  end


  always @* begin
    if (sin_270[index] >= THRESHOLD) sign_270 = 1;
    else sign_270 = 0;
  end

  always @* begin
    if (sin_315[index] >= THRESHOLD) sign_315 = 1;
    else sign_315 = 0;
  end




  ////////////////////////////////////////////////
  ////////////////////////////////////////////////
  ////////////////////////////////////////////////



  initial begin
    i             = 0;
    j             = 0;
    k             = 0;
    last_time     = 0;
    T1            = 0;
    // clk_filter_   = 0;
    // clk_filter    = 0;
    glitchF_found = 0;
    glitchR_found = 0;
  end


  initial begin
    forever begin
      @(posedge CLK);
      t1 = $realtime;
      @(posedge CLK);
      t2  = $realtime;
      T1  = t2 - t1;
      PPM = int'(((5 - (1 / T1)) / (5)) * (10 ** 6));
    end
  end


  initial begin
    forever begin
      @(negedge sign_0);
      t3 = $realtime;
      @(negedge sign_0);
      t4 = $realtime;
      T_ = t4 - t3;
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




  reg clk_sin;
  initial clk_sin = 0;
  always #(((0.2 / 360) / 2)) clk_sin = ~clk_sin;



  initial begin

    do begin
      preparation_flag = 1;
      @(posedge clk_sin);
      sin_0[i]   = sine[i];
      sin_45[i]  = sine[(i+45)%360];
      sin_90[i]  = sine[(i+90)%360];
      sin_135[i] = sine[(i+135)%360];
      sin_180[i] = sine[(i+180)%360];
      sin_225[i] = sine[(i+225)%360];
      sin_270[i] = sine[(i+270)%360];
      sin_315[i] = sine[(i+315)%360];
      i          = i + 1;
    end while (i != 360);
    i = 0;
    preparation_flag = 0;
  end




  initial clk_index = 0;
  always #(0.0001) clk_index = ~clk_index;  //0.0002


  ////////////////////////////////////////////////
  //////////////// INDEX CHANGE //////////////////
  ////////////////////////////////////////////////

  always @(posedge clk_index) begin
    time_now = $realtime - 0.2 * $floor($realtime / 0.2);  //T1 ---> change to T1
    index    = integer'((time_now / 0.2) * 360) % 360;
  end

  ////////////////////////////////////////////////
  ////////////////////////////////////////////////
  ////////////////////////////////////////////////


  always @(*) begin
    if (!preparation_flag) begin

      case (Code[10:8])

        3'b000: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_45[index]  + ((255.0 - Code[7:0])/255.0 * sin_0[index] )))      ;
        end

        3'b001: begin
          sin_sum   = ((Code[7:0]/255.0 * sin_90[index]  + ((255.0 - Code[7:0])/255.0 * sin_45[index] )))       ;

        end

        3'b010: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_135[index] + ((255.0 - Code[7:0])/255.0 * sin_90[index] )))    ;

        end

        3'b011: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_180[index]  + ((255.0 - Code[7:0])/255.0 * sin_135[index] )))  ;

        end

        3'b100: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_225[index]  + ((255.0 - Code[7:0])/255.0 * sin_180[index] )))  ;

        end

        3'b101: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_270[index]  + ((255.0 - Code[7:0])/255.0 * sin_225[index] )))  ;

        end

        3'b110: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_315[index]  + ((255.0 - Code[7:0])/255.0 * sin_270[index] )))  ;

        end

        3'b111: begin
          sin_sum  = ((Code[7:0]/255.0 * sin_0[index]  + ((255.0 - Code[7:0])/255.0 * sin_315[index] )))    ;

        end
      endcase

    end
  end



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



  end
endmodule




///////////////////////////////////////
///////////////////////////////////////
///////////// TESTBENCH ///////////////
///////////////////////////////////////
///////////////////////////////////////


`timescale 1ns / 1fs
module CDR_Loop (
    input rst_n,  // Asynchronous reset active low
    input clk_0,
    input clk_data,
    input Din,
    output PI_Clk,
    output Dout
);

`ifdef THREE_CLKS

  wire clk_90;
  wire clk_180;

`endif


  wire up, dn;
  wire [10:0] code;
  reg voting_clk;

  parameter NUMBER_SAMPLES = 3;
  parameter period = 0.2;

  initial begin
    voting_clk = 0;
    forever
      #((period / 2) / 2 * NUMBER_SAMPLES) voting_clk = ~voting_clk;  //200/5 (5 samples per bits)
  end



  BBPD phaseDetector (
      .Din  (Din),
      .clk  (PI_Clk),
      .clk_ref(clk_0),
`ifdef THREE_CLKS
      .clk_90  (clk_90)  ,
      .clk_180 (clk_180) ,
`endif
      .rst_n(rst_n),
      .Up   (up),
      .Dn   (dn),
      .A(Dout)
  );


  Box_Car_Voting #(
      .NUMBER_SAMPLES(NUMBER_SAMPLES)
  ) Voting_U (
      .clk    (voting_clk),
      .Dn     (dn),
      .Up     (up),
      .vote_Dn(vote_Dn),
      .vote_Up(vote_Up)
  );


  Digital_Loop_Filter DLF_U (
      .clk  (clk_0),
      .rst_n(rst_n),
      .Up   (vote_Up),
      .Dn   (vote_Dn),
      .code (code)
  );



  PMIX phase_interpolator (
      .CLK   (clk_0),
      .Code   (code),
`ifdef THREE_CLKS
      .rst_n(rst_n),
      .clk_90 (clk_90)  ,
      .clk_180 (clk_180),
`endif
      .CLK_Out_i(PI_Clk)
  );



  int fd;
  initial begin
    fd = $fopen("./Up_Dn.hex", "w");

  end

  always @(up, dn) begin
    $fwrite(fd, "%h,%h\n", up, dn);
  end


endmodule





module cdr_assertion #(
    clk_period_expected_min = 0.18,
    clk_period_expected_max = 0.31,
    clk_ppm_expected_max = 2000
) (
    input PI_CLK_OUT,
    input Data_CLK_IN
);


  property CLK_OUT_PERIOD_prop(time clk_period_expected_min, time clk_period_expected_max);
    realtime current_time;
    @(posedge PI_CLK_OUT) ('1,
    current_time = $realtime()
    ) |=> ((clk_period_expected_min <= int'(100 * ($realtime() - current_time))) &&
           (clk_period_expected_max >= int'(100 * ($realtime() - current_time))));
  endproperty

  CLK_OUT_PERIOD_assert :
  assert property (CLK_OUT_PERIOD_prop(clk_period_expected_min, clk_period_expected_max));
  CLK_OUT_PERIOD_cover :
  cover property (CLK_OUT_PERIOD_prop(clk_period_expected_min, clk_period_expected_max));




  property CLK_OUT_PPM_prop(int clk_ppm_expected_max);
    realtime current_time;
    @(posedge PI_CLK_OUT) ('1,
    current_time = $realtime()
    ) |=> (clk_ppm_expected_max >= int
           '((((1000.0 / ($realtime() - current_time)) > 5000.0) ?
              (((1000.0 / ($realtime() - current_time)) - 5000.0) / 5000.0) :
              ((5000.0 - (1000.0 / ($realtime() - current_time))) / 5000.0)) * (10 ** 6)), $display(
        "PI clk: PPM = %5d  ,curr freq = %f ,curr period = %f",
        int'((((1000.0 / ($realtime() - current_time)) > 5000.0) ? 
                                      (((1000.0 / ($realtime() - current_time)) - 5000.0) / 5000.0) :
                                      ((5000.0 - (1000.0 / ($realtime() - current_time))) / 5000.0)
                                     ) * (10 ** 6)),
        (1000.0 / ($realtime() - current_time)),
        ($realtime() - current_time)
    ));
  endproperty

  CLK_PPM_assert :
  assert property (CLK_OUT_PPM_prop(clk_ppm_expected_max));
  CLK_PPM_cover :
  cover property (CLK_OUT_PPM_prop(clk_ppm_expected_max));







  property CLK_DATA_PPM_prop(int clk_ppm_expected_max);
    realtime current_time;
    @(posedge Data_CLK_IN) ('1,
    current_time = $realtime()
    ) |=> (clk_ppm_expected_max >= int
           '((((1000.0 / ($realtime() - current_time)) > 5000.0) ?
              (((1000.0 / ($realtime() - current_time)) - 5000.0) / 5000.0) :
              ((5000.0 - (1000.0 / ($realtime() - current_time))) / 5000.0)) * (10 ** 6)), $display(
        "Data  : PPM = %5d , max ppm= %5d ,curr freq = %f ,curr period = %f",
        int'((((1000.0 / ($realtime() - current_time)) > 5000.0) ? 
                                      (((1000.0 / ($realtime() - current_time)) - 5000.0) / 5000.0) :
                                      ((5000.0 - (1000.0 / ($realtime() - current_time))) / 5000.0)
                                     ) * (10 ** 6)),
        clk_ppm_expected_max,
        (1000.0 / ($realtime() - current_time)),
        ($realtime() - current_time)
    ));
  endproperty



  DCLK_PPM_assert :
  assert property (CLK_DATA_PPM_prop(clk_ppm_expected_max));
  DCLK_PPM_cover :
  cover property (CLK_DATA_PPM_prop(clk_ppm_expected_max));




  realtime clks_queue[$];
  realtime curr_pi_clk;
  realtime curr_data_clk;
  realtime ppm_error;


  always @(PI_CLK_OUT or Data_CLK_IN) begin
    curr_pi_clk = $realtime();
    if (clks_queue.size() == 2) begin
      ppm_error = clks_queue[1] - clks_queue[0];
      clks_queue.pop_back();
      clks_queue.pop_back();
      $display("ppm_error=%t", ppm_error);
    end else begin
      clks_queue.push_back(curr_pi_clk);
    end

  end



endmodule



//////////////////////////////////////////////////////////



`timescale 1ps / 1fs
module CDR_Tb2 ();


  // parameter N = 8;
  parameter CLK_Period = 200;

  reg rst_n, clk_0, Din;
  reg  clk_data;
  wire PI_Clk;
  wire Dout;

`ifdef THREE_CLKS

  reg clk_90;
  reg clk_180;
  reg clk_270;

`endif
  ////////////////////////////////////////////////////////////////
  ///////////////////////// VCO Clocks ///////////////////////////
  ////////////////////////////////////////////////////////////////
  always begin
    #100 clk_0 = ~clk_0;  //CLK_Period/2.0
  end


  CDR_Loop DUT (.*);

  ////////////////////////////////////////////////////////////////
  ///////////////////////// Din Clock ////////////////////////////
  ////////////////////////////////////////////////////////////////
  // always begin 
  // #100 clk_data = ~clk_data; //CLK_Period/2.0
  // end
  initial begin
    // #110;
    forever #99.9 clk_data = ~clk_data;
  end

  ////////////////////////////////////////////////////////////////
  //////////////////////////// Din  //////////////////////////////
  ////////////////////////////////////////////////////////////////

  initial begin
    clk_0 = 0;
    clk_90 = 0;
    clk_180 = 0;
    clk_270 = 0;
    clk_data = 0;
    Din = 0;
    rst_n = 1;
    @(negedge clk_0);
    rst_n = 0;
    @(negedge clk_0);
    rst_n = 1;
    for (int i = 0; i < 50000; i++) begin
      Din = ~Din;
      // #(50);
      @(negedge clk_data);
    end
    $stop();
  end


endmodule


