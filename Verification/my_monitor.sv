package my_monitor_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;


class my_monitor extends uvm_monitor;

`uvm_component_utils(my_monitor);

uvm_analysis_port #(my_sequence_item)  mon_port ;

virtual BFM_if bfm_vif ;
my_sequence_item  rsp_seq_item ;

function new(string name = "my_monitor" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info("MY_MONITOR","BUILD_PHASE",UVM_MEDIUM);
endfunction 


task run_phase(uvm_phase phase);
	super.run_phase(phase);
	//------
	//-----
	//-----
	//mon_port.write(rsp_seq_item);
endtask

endclass	
endpackage	