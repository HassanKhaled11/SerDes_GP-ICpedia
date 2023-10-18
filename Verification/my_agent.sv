package my_agent_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_driver_pkg::*;
import my_sequence_item_pkg::*;


class my_agent extends uvm_agent;

`uvm_component_utils(my_agent) ;

my_driver    driver ;
uvm_sequencer #(my_sequence_item)  seqr ;

function new(string name = "my_agent" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	driver = my_driver :: type_id :: create("driver",this);
	seqr   = uvm_sequencer #(my_sequence_item) :: type_id :: create("seqr",this);
	`uvm_info("MY_AGENT","BUILD_PHASE",UVM_MEDIUM);
endfunction 



function void connected_phase(uvm_phase phase);
	super.connect_phase(phase);
	//driver.seq_item_port.connect(seqr.seq_item_export);
	`uvm_info("MY_AGENT","CONNECT_PHASE",UVM_MEDIUM);
endfunction



endclass	
endpackage	