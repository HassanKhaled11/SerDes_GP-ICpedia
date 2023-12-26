package my_scoreboard_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;


class my_scoreboard extends uvm_scoreboard;

`uvm_component_utils(my_scoreboard);

uvm_analysis_export   #(my_sequence_item) sb_export ;
uvm_tlm_analysis_fifo #(my_sequence_item) sb_fifo   ;

virtual Internals_if    internal_vif               ;
my_sequence_item     data_to_check                 ;

int correct_count ;
int error_count ;


function new(string name = "my_scoreboard" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	sb_export     = new("sb_export" , this);
	sb_fifo       = new("sb_fifo"   , this);
    data_to_check = new ("data_to_check")  ;

	if(!uvm_config_db#(virtual Internals_if)::get(this,"" ,"internal_if",internal_vif))
		`uvm_fatal("MY_SCOREBOARD" , "FAILED GETTING internal_if_db");

	`uvm_info("MY_SCOREBOARD","BUILD_PHASE",UVM_MEDIUM);
endfunction 


function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
 sb_export.connect(sb_fifo.analysis_export);	
endfunction


task run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever begin
		sb_fifo.get(data_to_check);
		`uvm_info("MY_SCOREBOARD","SOREBOARD's CAPTURING",UVM_MEDIUM);

         fork
         	//.............TESTING OVERFLOW..............
         	begin
         		if(internal_vif.gray_write_pointer[4]   != internal_vif.gray_read_pointer[3]  && 
         		   internal_vif.gray_write_pointer[3]   != internal_vif.gray_read_pointer[2]  &&
         		   internal_vif.gray_write_pointer[2:0]	== internal_vif.gray_read_pointer[2:0] && data_to_check.rst_n) begin
         		   	 
         		   	  if (data_to_check.overflow == 1) begin	
         		   	  	`uvm_info("SUCCEDED_OVERFLOW_TEST","TEST_SUCCEDDED",UVM_MEDIUM);
         		   	  end

         		   	  else begin
         		   	  	`uvm_info("FAILED_OVERFLOW_TEST","TEST_FAILED",UVM_MEDIUM);
         		   	  end 

         		end

         		else begin
					  if (data_to_check.overflow == 0) begin	
					  	`uvm_info("SUCCEDED_OVERFLOW_TEST","TEST_SUCCEDDED",UVM_MEDIUM);
					  end
         		   	  else begin	
         		   	  	`uvm_info("FAILED_OVERFLOW_TEST","TEST_FAILED",UVM_MEDIUM);         			
         		   	  end
         		end
         	end

         	//.............TESTING UNDERFLOW..............
         	
         	begin
         		if(internal_vif.gray_write_pointer == internal_vif.gray_read_pointer|| !data_to_check.rst_n) begin
         			if(data_to_check.underflow == 1)
         			 begin
         			   `uvm_info("SUCCEDED_UNDERFLOW_TEST","TEST_SUCCEDDED",UVM_MEDIUM); 
         			  end
         		   	  
         		   	  else  begin
         		   	  	`uvm_info("FAILED_UNDERFLOW_TEST","TEST_FAILED",UVM_MEDIUM);
         		   	  end
         		end

         		else begin
         			if(data_to_check.underflow == 0) begin
         			`uvm_info("SUCCEDED_UNDERFLOW_TEST","TEST_SUCCEDDED",UVM_MEDIUM);
         			end

         		   	else begin
         		     `uvm_info("FAILED_UNDERFLOW_TEST","TEST_FAILED",UVM_MEDIUM);		
         		   	end          			
         		end
         	end

         	//.............TESTING UNDERFLOW..............
            
            begin
               

            end 


         join

	end
endtask


function void report_phase(uvm_phase phase);
	super.report_phase(phase);
	// `uvm_info("MY_SCOREBOARD" , $sformatf("CORRECT_COUNT = %d",correct_count) , UVM_MEDIUM);
	// `uvm_info("MY_SCOREBOARD" , $sformatf("ERROR_COUNT = %d",error_count)     , UVM_MEDIUM);
endfunction




endclass	
endpackage	