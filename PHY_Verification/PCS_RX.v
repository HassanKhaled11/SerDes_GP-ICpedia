module PCS_RX #(parameter DATA_WIDTH = 10,BUFFER_WIDTH = 10 , BUFFER_DEPTH = 16)(
				
				//input 					K285			, // to comma block
				input [DATA_WIDTH-1:0]  Collected_Data	,
				input 					WordClk			, // to elastic buffer & decoder & Gasket
				input 					PCLK			,
				input 					CLK_5G			, // used for comma pulse generator and CLK_5G main input port to PMA_RX
				input 					Rst_n 			,
				input 					buffer_mode		,
				input [5:0]				DataBusWidth	,

				output 		[31:0]		RX_Data 		,
				output 					RX_DataK		,
				output 		[2:0] 		RX_Status		,
				output  				RX_Valid			
				);

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//////////////// 	  internal wires	   /////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
wire Comma_pulse,overflow,skp_added,Skp_Removed,underflow;
wire [DATA_WIDTH-1:0] data_to_decoder;
wire [7:0] data_to_gasket;
wire DecodeError , Disparity_Error;
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//////////////// 	Comma Detection 	   /////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
Comma_Detection 
										comma (
											.RxValid    	(RX_Valid), 		//out port
											.detect_comma    	(Collected_Data),		// from ---------
											.Comma_pulse	(Comma_pulse),	// to elastic buffer
											.clk(CLK_5G),
											.rst_n(Rst_n)
											);

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//////////////// 	Elastic Buffer  	   /////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
elasticBuffer #(.DATA_WIDTH(BUFFER_WIDTH),  .BUFFER_DEPTH(BUFFER_DEPTH)) 
											buffer(
												.rst_n       		(Rst_n),				// inport
												.data_in     		(Collected_Data), 		// from serial to parallel
												.read_clk    		(WordClk), 				// in port
												.write_clk   		(Comma_pulse), 			// pulse from comma detection
												.buffer_mode 		(buffer_mode), 			// in port
												// .read_enable 		(read_enable), 			// -------
												// .write_enable		(Comma_pulse), 			// pulse from comma detection
												.data_out    		(data_to_decoder),  	// to decoder
												.overflow    		(overflow),	    		// to rx status
												.skp_added   		(skp_added),			// to rx status
												.Skp_Removed 		(Skp_Removed), 			// to rx status
												.underflow   		(underflow)				// to rx status
												);

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//////////////// 		 Decoder		   /////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
decoder decode(
			.Rst_n         		(Rst_n),				// in port
			.Data_in       		(data_to_decoder), 		// from elastic buffer
			.CLK           		(WordClk), 			// clk 250 or 125 MHz 
			.RxDataK       		(RX_DataK), 				// out port
			.Data_out      		(data_to_gasket), 		// to gasket
			.DecodeError   		(DecodeError),			// to rx status
			.DisparityError		(Disparity_Error)		// to rx status
			);
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//////////////// 		 RX_Status		   /////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
Reeceiver_Status rx_status(
					.Skp_Removed    	(Skp_Removed), 				// from elastic buffer
					.Overflow       	(overflow), 				// from elastic buffer
					.Underflow      	(underflow),				// from elastic buffer
					.Skp_Added      	(skp_added),				// from elastic buffer
					.Decode_Error   	(DecodeError), 				// from decoder
					.Disparity_Error	(Disparity_Error),			// from decoder
					.RxStatus       	(RX_Status) 					// out port
					);
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//////////////// 			Gasket	   	   /////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
GasKet rx_gasket(
			.Rst_n     			(Rst_n),				// in port
			.Data_in   			(data_to_gasket),		// from decoder
			.PCLK      			(PCLK), 				// in port
			.clk_to_get			(WordClk), 			// in port
			.width     			(DataBusWidth),  		// in port
			.Data_out  			(RX_Data) 				// final out port
			);
endmodule 
