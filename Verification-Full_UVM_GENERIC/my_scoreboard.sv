package my_scoreboard_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;


class my_scoreboard extends uvm_scoreboard;

`uvm_component_utils(my_scoreboard);

uvm_analysis_export   #(my_sequence_item) sb_export ;
uvm_tlm_analysis_fifo #(my_sequence_item) sb_fifo   ;

virtual golden_if    gm_vif;
my_sequence_item     data_to_check                 ;

int correct_count ;
int error_count ;


function new(string name = "my_scoreboard" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	sb_export = new("sb_export" , this);
	sb_fifo   = new("sb_fifo"   , this);
    data_to_check = new ("data_to_check");

	if(!uvm_config_db#(virtual golden_if)::get(this, "", "gm_if",gm_vif))
		`uvm_fatal("MY_SCOREBOARD" , "FAILED GETTING gm_if_db");

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
		// if(data_to_check.out == gm_vif.out) begin
		// `uvm_info("MY_SCOREBOARD" , "SUCCESS" , UVM_MEDIUM);
		// correct_count ++ ;
		// end
		// else begin
		// 	`uvm_info("MY_SCOREBOARD" , "FAILED" , UVM_MEDIUM);
		// 	error_count++;
		// end
	end
endtask


function void report_phase(uvm_phase phase);
	super.report_phase(phase);
	// `uvm_info("MY_SCOREBOARD" , $sformatf("CORRECT_COUNT = %d",correct_count) , UVM_MEDIUM);
	// `uvm_info("MY_SCOREBOARD" , $sformatf("ERROR_COUNT = %d",error_count)     , UVM_MEDIUM);
endfunction

endclass	
endpackage	