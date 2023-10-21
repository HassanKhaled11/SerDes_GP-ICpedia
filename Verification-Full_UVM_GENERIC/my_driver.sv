package my_driver_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;


class my_driver extends uvm_driver #(my_sequence_item);

`uvm_component_utils(my_driver);

virtual BFM_if bfm_vif ;
my_sequence_item stim_seq_item ;

function new(string name = "my_driver" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info("MY_DRIVER","BUILD_PHASE",UVM_MEDIUM);
endfunction 


task run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever begin
	stim_seq_item = my_sequence_item :: type_id :: create ("stim_seq_item" , this);
	seq_item_port.get_next_item(stim_seq_item);
        drive();
	seq_item_port.item_done(stim_seq_item);
	end 
endtask : run_phase



task drive(); 
        // @(negedge bfm_vif.clk);
        // bfm_vif.A = stim_seq_item.A ;
        // bfm_vif.B = stim_seq_item.B ;	
endtask 


endclass	
endpackage	