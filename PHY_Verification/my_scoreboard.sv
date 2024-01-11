package my_scoreboard_pkg;

import uvm_pkg::*             ;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;
import PARAMETERS_PKG::*      ;


class my_scoreboard extends uvm_scoreboard;

`uvm_component_utils(my_scoreboard);

uvm_analysis_export   #(my_sequence_item) sb_export ;
uvm_tlm_analysis_fifo #(my_sequence_item) sb_fifo   ;


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
	fd = $fopen("./MAC_TX_Data_Stim.hex","r");
	Coma_collection = 10'h0;
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	sb_export     = new("sb_export" , this);
	sb_fifo       = new("sb_fifo"   , this);
    data_to_check = new ("data_to_check");

	`uvm_info("MY_SCOREBOARD","BUILD_PHASE",UVM_MEDIUM);
endfunction 


function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
 sb_export.connect(sb_fifo.analysis_export);	
endfunction


task run_phase(uvm_phase phase);
	super.run_phase(phase);

		fork

			begin
				while(!feof(fd)) begin
					$sscanf(fd,"%h",temp0) ;       // Read Original Stimulus in Queue
					Queue_Expec_Data.push_back(temp0);
				end
			end

            
            begin   
             forever begin
                                                  //Collect Outs in Queue after Comma Detection
                   sb_fifo.get(data_to_check);
        						`uvm_info("MY_SCOREBOARD","SOREBOARD's CAPTURING",UVM_MEDIUM);
                if (Coma_collection == 10'h0FA || Coma_collection == 10'h305)
                 begin
                   repeat() @(posedge );    // bit rate clock - Number of latency (EB --> RXOUT)
                   Queue_Data.push_back(data_to_check.Rx_Data);
                 end
              end  
            end

 
            begin                                  // Collect COMMA
              forever begin	
                @(posedge )          // bit rate clock
                Coma_collection = {   ,Coma_collection [9:1]}; // TX_OUT_P
              end                                  
            end


            begin                                  // CHECK PCLK PERIOD
            	forever begin               
            		
            	    @(posedge ) t1 = $realtime() ;
            	    @(posedge ) t2 = $realtime() ;

            	    if( == 6'd8)begin   // DATABUSWIDTH
            	       if(int'(t2 - t1) == PCLK_PERIOD_WIDTH8) `uvm_info("SECCEEDED_PCLK_PERIOD","RIGHT PCLK PERIOD TST",UVM_MEDIUM) ;
               	       else `uvm_info("FAILED_PCLK_PERIOD","FAILED PCLK PERIOD TST",UVM_MEDIUM) ;
            	    end

            	    else if( == 6'd16)begin   
            	       if(int'(t2 - t1) == PCLK_PERIOD_WIDTH16) `uvm_info("SECCEEDED_PCLK_PERIOD","RIGHT PCLK PERIOD TST",UVM_MEDIUM) ;
               	       else `uvm_info("FAILED_PCLK_PERIOD","FAILED PCLK PERIOD TST",UVM_MEDIUM) ;
            	    end

            	    else begin    
            	       if(int'(t2 - t1) == PCLK_PERIOD_WIDTH32) `uvm_info("SECCEEDED_PCLK_PERIOD","RIGHT PCLK PERIOD TST",UVM_MEDIUM) ;
               	       else `uvm_info("FAILED_PCLK_PERIOD","FAILED PCLK PERIOD TST",UVM_MEDIUM) ;
            	    end

            	
            	end
            end


            begin                                // CHECK WORD_CLK PERIOD
            	forever begin
            		
            	@(posedge ) t3 = $realtime() ;
            	@(posedge ) t4 = $realtime() ;

            	if(int'(t4 - t3) == WORD_CLOCK_PERIOD) `uvm_info("SECCEEDED_PCLK_PERIOD","RIGHT PCLK PERIOD TST",UVM_MEDIUM) ;
            	else `uvm_info("FAILED_PCLK_PERIOD","FAILED PCLK PERIOD TST",UVM_MEDIUM) ;

            	end
            end


            begin                                // CHECK BIT_CLK PERIOD
            	forever begin
            		
            	@(posedge ) t5 = $realtime() ;
            	@(posedge ) t6 = $realtime() ;

            	if(int'((t6 - t5)*10) == BIT_CLOCK_PERIOD) `uvm_info("SECCEEDED_PCLK_PERIOD","RIGHT PCLK PERIOD TST",UVM_MEDIUM) ;
            	else `uvm_info("FAILED_PCLK_PERIOD","FAILED PCLK PERIOD TST",UVM_MEDIUM) ;

            	end
            end            


		join

	end
endtask




function void report_phase(uvm_phase phase);
	super.report_phase(phase);

	for(int j = 0 ; j < Queue_Expec_Data.size() ; j++) begin
		if(Queue_Expec_Data[j] == Queue_Data[j]) begin 
            `uvm_info("SECCEEDED_RXDATA",$sformatf("RIGHT OUTPUT DATA = %h",Queue_Data[j]),UVM_MEDIUM) ;
			 correct_count++;
	    end

	    else begin
	    	`uvm_info("FAILED_RXDATA",$sformatf("WRONG OUTPUT DATA = %h",Queue_Data[j]),UVM_LOW) ;
	    	 error_count++;
	    end
	end

	`uvm_info("MY_SCOREBOARD" , $sformatf("CORRECT_COUNT = %d",correct_count) , UVM_MEDIUM);
	`uvm_info("MY_SCOREBOARD" , $sformatf("ERROR_COUNT = %d",error_count)     , UVM_MEDIUM);

endfunction

endclass	
endpackage	