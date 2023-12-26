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
     @(posedge  bfm_vif.read_clk);
     `uvm_info("MY_MONITOR","MONITOR IS CAPTURING",UVM_MEDIUM);
     rsp_seq_item.data_out = bfm_vif.data_out;
     rsp_seq_item.skp_added= bfm_vif.skp_added;
     rsp_seq_item.Skp_Removed= bfm_vif.Skp_Removed;
     rsp_seq_item.overflow = bfm_vif.overflow;
     rsp_seq_item.underflow = bfm_vif.underflow;
     rsp_seq_item.data_in  = bfm_vif.data_in;
     rsp_seq_item.write_enable = bfm_vif.write_enable;
     rsp_seq_item.read_enable = bfm_vif.read_enable;

	 mon_port.write(rsp_seq_item);
     
	end
 
endtask

endclass	
endpackage	