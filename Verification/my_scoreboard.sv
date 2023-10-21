package my_scoreboard_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;


class my_scoreboard extends uvm_scoreboard;

`uvm_component_utils(my_scoreboard);

uvm_analysis_export   #(my_sequence_item) sb_export ;
uvm_tlm_analysis_fifo #(my_sequence_item) sb_fifo   ;

my_sequence_item      data_to_check                 ;

function new(string name = "my_scoreboard" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	sb_export = new("sb_export" , this);
	sb_fifo   = new("sb_fifo"   , this);
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
	end
endtask



endclass	
endpackage	