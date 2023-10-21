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
	mon_port = new("mon_port" , this);
	`uvm_info("MY_MONITOR","BUILD_PHASE",UVM_MEDIUM);
endfunction 


task run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever begin
	rsp_seq_item = my_sequence_item:: type_id :: create("rsp_seq_item");
     //@(posedge  bfm_vif.clk);
     // rsp_seq_item.A   = bfm_vif.A   ;
     // rsp_seq_item.B   = bfm_vif.B   ;
     // rsp_seq_item.out = bfm_vif.out ;
	 mon_port.write(rsp_seq_item);
     
	end
 
endtask

endclass	
endpackage	