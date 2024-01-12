package my_scoreboard_pkg;

import uvm_pkg::*             ;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;
import PARAMETERS_PKG::*      ;


class my_scoreboard extends uvm_scoreboard;

`uvm_component_utils(my_scoreboard);

// uvm_analysis_export   #(my_sequence_item) sb_export ;
// uvm_tlm_analysis_fifo #(my_sequence_item) sb_fifo   ;

 uvm_analysis_imp      #(my_sequence_item , my_scoreboard) sb_export ;

virtual BFM_if bfm_vif                              ;
virtual INTERNALS_if internals_if                   ;

my_sequence_item     data_to_check                  ;

int fd            ;
int correct_count ;
int error_count   ;

logic [31:0] temp0               ;
logic [31:0] Queue_Data [$]      ;
logic [31:0] Queue_Expec_Data[$] ;

logic [9 : 0] Coma_collection    ;

realtime t1,t2,t3,t4,t5,t6       ;

function new(string name = "my_scoreboard" , uvm_component parent = null);
	super.new(name,parent);
	fd = 0;
	t1 = 0;
	t2 = 0;
	t3 = 0;
	t4 = 0;
	t5 = 0;
	t6 = 0;
	Coma_collection = 10'h0;
endfunction


  function void write(my_sequence_item  pkt);
  	data_to_check = pkt ;
  endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	sb_export     = new("sb_export" , this);
//	sb_fifo       = new("sb_fifo"   , this);
    data_to_check = new ("data_to_check");

    if(!uvm_config_db#(virtual INTERNALS_if)::get(this,"","internals_if", internals_if))
  `uvm_fatal("MY_TEST" , "FATAL PUTTING INTERNALS INTERFACE in CONFIG_DB");

   if(!uvm_config_db#(virtual BFM_if)::get(this,"","bfm_if", bfm_vif))
  `uvm_fatal("MY_TEST" , "FATAL PUTTING INTERNALS INTERFACE in CONFIG_DB");

	`uvm_info("MY_SCOREBOARD","BUILD_PHASE",UVM_MEDIUM);
endfunction 


// function void connect_phase(uvm_phase phase);
// 	super.connect_phase(phase);
//    sb_export.connect(sb_fifo.analysis_export);	
// endfunction


function void end_of_elaboration_phase (uvm_phase phase);
  super.end_of_elaboration_phase (phase);                          //  OPEN FILE
      fd = $fopen("./MAC_TX_Data_Stim.hex","r");
endfunction



task run_phase(uvm_phase phase);
	super.run_phase(phase);


     forever begin                                     //Collect Outs in Queue after Comma Detection
        // sb_fifo.get(data_to_check);
        @(internals_if.Bit_CLK);
    	 `uvm_info("MY_SCOREBOARD","SOREBOARD's CAPTURING",UVM_MEDIUM);
          Coma_collection = { internals_if.TX_Out_P  ,Coma_collection [9:1]}; // TX_OUT_P	
          if (Coma_collection == 10'h0FA || Coma_collection == 10'h305)
           begin
           repeat(75) @(posedge internals_if.Bit_CLK);    // bit rate clock - Number of latency (EB --> RXOUT)
           Queue_Data.push_back(data_to_check.Rx_Data);
           end
          end  



		// fork

		// 	begin
		// 		for (int k = 0; k < 100; k++) begin
		// 			//(!$feof(fd)) //begin
		// 		   @(posedge internals_if.Bit_CLK);
		// 			$sscanf(fd,"%h",temp0) ;       // Read Original Stimulus in Queue
		// 			Queue_Expec_Data.push_back(temp0);
		// 		end
		// 	end

            
        //     begin   
        //      forever begin
        //                                           //Collect Outs in Queue after Comma Detection
        //            sb_fifo.get(data_to_check);
        // 						`uvm_info("MY_SCOREBOARD","SOREBOARD's CAPTURING",UVM_MEDIUM);
        // 					Coma_collection = { internals_if.TX_Out_P  ,Coma_collection [9:1]}; // TX_OUT_P	
        //         if (Coma_collection == 10'h0FA || Coma_collection == 10'h305)
        //          begin
        //            repeat(75) @(posedge internals_if.Bit_CLK);    // bit rate clock - Number of latency (EB --> RXOUT)
        //            Queue_Data.push_back(data_to_check.Rx_Data);
        //          end
        //       end  
        //     end

 
        //     // begin                                  // Collect COMMA
        //     //   forever begin	
        //     //     @(posedge internals_if.Bit_CLK);          // bit rate clock
                
        //     //   end                                  
        //     // end


        //     begin                                  // CHECK PCLK PERIOD
        //     	forever begin               
            		
        //     	    @(posedge bfm_vif.PCLK) t1 = $realtime() ;
        //     	    @(posedge bfm_vif.PCLK) t2 = $realtime() ;

        //     	    if(internals_if.DataBusWidth == 6'd8)begin   // DATABUSWIDTH
        //     	       if(int'(t2 - t1) == PCLK_PERIOD_WIDTH8) begin
        //         	       	`uvm_info("SECCEEDED_PCLK_PERIOD","RIGHT PCLK PERIOD TST",UVM_MEDIUM) ;
        //     	       end
        //        	       else begin
        //        	       	     `uvm_info("FAILED_PCLK_PERIOD","FAILED PCLK PERIOD TST",UVM_MEDIUM) ;
        //        	       end 
        //     	    end

        //     	    else if(internals_if.DataBusWidth == 6'd16)begin   
        //     	       if(int'(t2 - t1) == PCLK_PERIOD_WIDTH16) begin
        //     	       	   `uvm_info("SECCEEDED_PCLK_PERIOD","RIGHT PCLK PERIOD TST",UVM_MEDIUM) ;
        //     	       end 
        //        	       else begin
        //        	       	    `uvm_info("FAILED_PCLK_PERIOD","FAILED PCLK PERIOD TST",UVM_MEDIUM) ;
        //        	       end 
        //     	    end

        //     	    else begin    
        //     	       if(int'(t2 - t1) == PCLK_PERIOD_WIDTH32) begin
        //     	       	   `uvm_info("SECCEEDED_PCLK_PERIOD","RIGHT PCLK PERIOD TST",UVM_MEDIUM) ;
        //     	       end 
        //        	       else begin
        //        	       	    `uvm_info("FAILED_PCLK_PERIOD","FAILED PCLK PERIOD TST",UVM_MEDIUM) ;
        //        	       end 
        //     	    end

            	
        //     	end
        //     end


        //     begin                                // CHECK WORD_CLK PERIOD
        //     	forever begin
            		
        //     	@(posedge internals_if.Word_CLK) t3 = $realtime() ;
        //     	@(posedge internals_if.Word_CLK) t4 = $realtime() ;

        //     	if(int'(t4 - t3) == WORD_CLOCK_PERIOD) begin
        //     		`uvm_info("SECCEEDED_WORD_CLK PERIOD","RIGHT WORD_CLK PERIOD TST",UVM_MEDIUM) ;
        //     	end 
        //     	else begin
        //     		`uvm_info("FAILED_WORD_CLK_PERIOD","FAILED WORD_CLK PERIOD TST",UVM_MEDIUM) ;
        //     	end

        //     	end
        //     end


        //     begin                                // CHECK BIT_CLK PERIOD
        //     	forever begin
            		
        //     	@(posedge internals_if.Bit_CLK) t5 = $realtime() ;
        //     	@(posedge internals_if.Bit_CLK) t6 = $realtime() ;

        //     	if(int'((t6 - t5)*10) == BIT_CLOCK_PERIOD) begin
        //     		`uvm_info("SECCEEDED_PCLK_PERIOD","RIGHT BIT_CLOCK_PERIOD PERIOD TST",UVM_MEDIUM) ;
        //     	end 
        //     	else begin
        //     		`uvm_info("FAILED_BIT_CLOCK_PERIOD","FAILED BIT_CLOCK_PERIOD TST",UVM_MEDIUM) ;
        //     	end 

        //     	end
        //     end            

		// join
endtask




function void report_phase(uvm_phase phase);
	super.report_phase(phase);

	// for(int j = 0 ; j < Queue_Expec_Data.size() ; j++) begin
	// 	if(Queue_Expec_Data[j] == Queue_Data[j]) begin 
    //         `uvm_info("SECCEEDED_RXDATA",$sformatf("RIGHT OUTPUT DATA = %h",Queue_Data[j]),UVM_MEDIUM) ;
	// 		 correct_count++;
	//     end

	//     else begin
	//     	`uvm_info("FAILED_RXDATA",$sformatf("WRONG OUTPUT DATA = %h",Queue_Data[j]),UVM_LOW) ;
	//     	 error_count++;
	//     end
	// end
   
    if(Queue_Data == Queue_Expec_Data) begin
    	 `uvm_info("SECCEEDED_RXDATA", "RIGHT OUTPUT DATA" , UVM_LOW) ;
    end

    else begin
    	  `uvm_info("FAILED_RXDATA","WRONG OUTPUT DATA",UVM_LOW) ;
    end

	`uvm_info("MY_SCOREBOARD" , $sformatf("CORRECT_COUNT = %d",correct_count) , UVM_MEDIUM);
	`uvm_info("MY_SCOREBOARD" , $sformatf("ERROR_COUNT = %d",error_count)     , UVM_MEDIUM);

endfunction



function void final_phase (uvm_phase phase);
	super.final_phase(phase);

	$fclose(fd);                  // CLOSE FILE
	
endfunction

endclass	
endpackage	