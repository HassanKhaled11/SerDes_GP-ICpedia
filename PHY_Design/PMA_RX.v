module PMA_RX #(parameter DATA_WIDTH = 10)
				(
					//input RX_POS,
					//input RX_NEG,
					input Ser_in,
					input Rst_n,
					input CLK_5G,
					input RxPolarity,
					output [DATA_WIDTH-1:0] Data_out 
					//output K285
				);

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//////////////// 	CDR should be here	   /////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//////////////// 	Serial to parallel	   /////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

// Serial_to_Parallel #(.DATA_WIDTH(DATA_WIDTH)) serialToparallel (
															
// .Rst_n            (Rst_n),															
// .Recovered_Bit_Clk(CLK_5G), // from cdr sampled clk    --> Recovered_Bit_Clk
// .Ser_in           (Ser_in), // from cdr sampled bit
// .RxPolarity       (RxPolarity), // inport
// //.K285             (K285), // out to comma detection
// .Data_to_Decoder  (Data_out) // parallel data to buffer
// );														

  Serial_to_Parallel #(.DATA_WIDTH(DATA_WIDTH)) serialToparallel (

      .Recovered_Bit_Clk(CLK_5G),
      .Ser_in(Ser_in),
      .Rst_n(Rst_n),
      .RxPolarity(RxPolarity),
      .Data_Collected(Data_out)  //change

  );

endmodule 
