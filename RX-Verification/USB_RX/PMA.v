`timescale 1ps / 1fs
module PMA (
    //input       Bit_Rate_Clk_10,
    input       Bit_Rate_Clk,
    // input       Bit_Rate_Clk_offset,
    input       Rst_n,
    //input [9:0] Data_in,
    //input       MAC_Data_En,
    input       RxPolarity,
    input       TX_P ,
    //input                    RX_POS          ,
    //input                    RX_NEG          ,
    // input       Ser_in,


    //output       TX_Out_P,
    //output       TX_Out_N,
    //output                   K285            ,
    output [9:0] RX_Out,
    output       recovered_clk_5G
);
  
  //reg CLK_5G;
  
  // initial begin
  //   Bit_Rate_Clk_offset = 0;
  //   forever begin
  //     #100.1 Bit_Rate_Clk_offset = ~Bit_Rate_Clk_offset;
  //   end
  // end

  //reg TX_P;
  wire TX_N;


  //assign TX_Out_P = TX_P;
  //assign TX_Out_N = TX_N;


  // PMA_TX #(
  //     .DATA_WIDTH(10)
  // ) PMA_TX_U (
  //     .Bit_Rate_Clk_10(Bit_Rate_Clk_10),
  //     .Bit_Rate_Clk   (Bit_Rate_Clk),
  //     //   .Bit_Rate_Clk   (Bit_Rate_Clk_offset),
  //     .Rst_n          (Rst_n),
  //     .Data_in        (Data_in),
  //     .MAC_Data_En    (MAC_Data_En),
  //     .TX_Out_P       (TX_P),
  //     .TX_Out_N       (TX_N)
  // );

assign TX_N = !TX_P;

//always #100 CLK_data = ~CLK_data ; 


// always @(posedge CLK_data or negedge Rst_n) begin
//   if(~Rst_n) begin
//      TX_P <= 0;
     
//   end else begin
//      TX_P <= $random() ;
//   end
// end



  //CDR + serial to parallel
  PMA_RX #(
      .DATA_WIDTH(10)
  ) PM_RX_U (
      .RX_POS          (TX_P),
      .RX_NEG          (TX_N),
      // .Ser_in    (TX_Out_P),
      .Rst_n           (Rst_n),
      .CLK_5G          (Bit_Rate_Clk),  //CLK_5G
      .RxPolarity      (RxPolarity),
      .Data_out        (RX_Out),
      .recovered_clk_5G(recovered_clk_5G)
      //.K285(K285)
  );



endmodule
