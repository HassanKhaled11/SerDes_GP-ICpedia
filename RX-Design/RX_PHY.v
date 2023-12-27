module RX_PHY #(parameter BUFFER_WIDTH = 10 , BUFFER_DEPTH = 16)( 
				input 				RX_POS,
				input 				RX_NEG,
				input 				PCLK, 				// to gasket
				input 				CLK_250MHz, 		// to elastic buffer , decoder , gasket
				input 				CLK_5G, 			// to CDR block
				input 				Rst_n,
				input 				RxPolarity, 		// serial to parallel &  --> clk
				input 				buffer_mode, 		// to elastic buffer
				input 	[5:0]	 	DataBusWidth,

				output 	[2:0]	  	RxStatus,
				output 		  		RxDataK,
				output 		  		RxValid,
				output  [31:0] 		Data_out 			// 32 || 16 || 8
				);
////////////////////////////////// internal signals
wire [9:0] data_to_buffer , data_to_decoder;
wire Comma_pulse , Overflow , Underflow , skp_added , Skp_Removed;
wire [7:0] data_to_gasket;
wire DecodeError , Disparity_Error;



/////////////////////////  CDR Block

// Code for CDR blocks here



/////////////////////////  serial to parallel Block
Serial_to_Parallel u1(
						.RxPolarity       		(RxPolarity),
						.Rst_n            		(Rst_n),
						.Recovered_Bit_Clk		(Recovered_Bit_Clk),	//from CRC block
						.Ser_in           		(Ser_in), 				// from DRC block
						//.K285             		(K285), 				// to k28.5 block
						.Data_to_Decoder  		(data_to_buffer) 		// to elastic buffer
						);

/////////////////////////  k28.5 Block
Comma_Detection #(.PARALLEL_DATA_WIDTH(BUFFER_WIDTH)) 
										u2 (
											.RxValid    	(RxValid), 		//out port
											.Data_in    	(data_to_buffer),		// from ---------
											//.TXDataK    	(TXDataK), 		// in port
											.Comma_pulse	(Comma_pulse)	// to elastic buffer
											);

/////////////////////////  Elastic buffer Block
elasticBuffer #(.DATA_WIDTH(BUFFER_WIDTH) , .BUFFER_DEPTH(BUFFER_DEPTH)) 
											u3(
												.rst_n       		(Rst_n),				// inport
												.data_in     		(data_to_buffer), 		// from serial to parallel
												.read_clk    		(CLK_250MHz), 			// in port
												.write_clk   		(CLK_5G), 				// from -----
												.buffer_mode 		(buffer_mode), 			// in port
												.read_enable 		(read_enable), 			// -------
												.write_enable		(Comma_pulse), 			// pulse from comma detection
												.data_out    		(data_to_decoder),  	// to decoder
												.overflow    		(Overflow),	    		// to rx status
												.skp_added   		(skp_added),			// to rx status
												.Skp_Removed 		(Skp_Removed), 			// to rx status
												.underflow   		(Underflow)				// to rx status
												);
/////////////////////////  Decoder Block
decoder u4(
			.Rst_n         		(Rst_n),				// in port
			.Data_in       		(data_to_decoder), 		// from elastic buffer
			.CLK           		(CLK_250MHz), 			// clk 250 or 125 MHz 
			.RxDataK       		(RxDataK), 				// out port
			.Data_out      		(data_to_gasket), 		// to gasket
			.DecodeError   		(DecodeError),			// to rx status
			.DisparityError		(Disparity_Error)		// to rx status
			);

/////////////////////////  Rx status Block
Reeceiver_Status u5(
					.Skp_Removed    	(Skp_Removed), 				// from elastic buffer
					.Overflow       	(Overflow), 				// from elastic buffer
					.Underflow      	(Underflow),				// from elastic buffer
					.Skp_Added      	(skp_added),				// from elastic buffer
					.Decode_Error   	(DecodeError), 				// from decoder
					.Disparity_Error	(Disparity_Error),			// from decoder
					.RxStatus       	(RxStatus) 					// out port
					);

/////////////////////////  gasket Block
GasKet u6(
			.Rst_n     			(Rst_n),				// in port
			.Data_in   			(data_to_gasket),		// from decoder
			.PCLK      			(PCLK), 				// in port
			.clk_to_get			(CLK_250MHz), 			// in port
			.width     			(DataBusWidth),  		// in port
			.Data_out  			(Data_out) 				// final out port
			);

endmodule 