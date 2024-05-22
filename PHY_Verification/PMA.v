`timescale 1ps / 1fs
module PMA (
    input       Bit_Rate_Clk_10,
    input       Bit_Rate_Clk,
    `ifdef OFFSET_TEST
       input  Bit_Rate_Clk_offset,
    `endif
    input       Rst_n,
    input [9:0] Data_in,
    input       MAC_Data_En,
    input       RxPolarity,
    //input                    RX_POS          ,
    //input                    RX_NEG          ,
    // input       Ser_in,


    output       TX_Out_P,
    output       TX_Out_N,
    //output                   K285            ,
    output [9:0] RX_Out,
    output       recovered_clk_5G
);
  
   reg Bit_Rate_Clk_Rx;
  // reg Bit_Rate_Clk_10_offset;

  parameter OFFSET_PERIOD = 100.01;
  // parameter OFFSET_10_PERIOD = 1000.10001;
  parameter N             = 10;
  parameter Threshold = 0.5;


  // initial begin
  //   Bit_Rate_Clk_offset = 0;
  //   forever begin
  //     #(OFFSET_PERIOD) Bit_Rate_Clk_offset = ~Bit_Rate_Clk_offset;
  //   end
  // end


    initial begin
    Bit_Rate_Clk_Rx = 0;
    forever begin
      #(100) Bit_Rate_Clk_Rx = ~Bit_Rate_Clk_Rx;
    end
  end


reg channel_clk;

initial begin
  channel_clk = 0;
  forever #(OFFSET_PERIOD/N) channel_clk = ~channel_clk;
end



//////////////////////////////////////////////

  wire TX_P;
  wire TX_N;
  real Data_from_channel;
  wire Data_out;


  assign TX_Out_P = TX_P;
  assign TX_Out_N = TX_N;


  PMA_TX #(
      .DATA_WIDTH(10)
  ) PMA_TX_U (
      .Bit_Rate_Clk_10(Bit_Rate_Clk_10),
        `ifdef OFFSET_TEST
           .Bit_Rate_Clk(Bit_Rate_Clk_offset),
        `else
           .Bit_Rate_Clk(Bit_Rate_Clk),   
        `endif
      .Rst_n          (Rst_n),
      .Data_in        (Data_in),
      .MAC_Data_En    (MAC_Data_En),
      .TX_Out_P       (TX_P),
      .TX_Out_N       (TX_N)
  );

  //Channel
  Channel #(.F(2.5),.ATTENUATION(10),.N(N)) channelInst  (
                      .Sample_CLK(channel_clk),
                      .Data_in   (TX_P),
                      .Ynew      (Data_from_channel)
                      );


  Data_sampling #(.Threshold(Threshold)) dataSample(
                            .data_in (Data_from_channel),
                            .Data_out(Data_out)
                            );


  //CDR + serial to parallel
  PMA_RX #(
      .DATA_WIDTH(10)
  ) PM_RX_U (
      .RX_POS          (Data_from_channel),
      .RX_NEG          (TX_N),
      .Rst_n           (Rst_n),
       
      `ifdef SRNS_TEST                        // Separate Ref Clk No Spreading
         .CLK_5G          (Bit_Rate_Clk_Rx),  
      `elsif SRIS_TEST
         .CLK_5G          (Bit_Rate_Clk),     // Separate Ref Clk WITH Indep. Spreading
      `else
         .CLK_5G          (Bit_Rate_Clk),     // Common Ref Clk 
      `endif            

      .RxPolarity      (RxPolarity),
      .Data_out        (RX_Out),
      .recovered_clk_5G(recovered_clk_5G)
  );



endmodule
