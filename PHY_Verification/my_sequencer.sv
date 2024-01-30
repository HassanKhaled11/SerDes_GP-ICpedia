package my_sequencer_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;


class my_sequencer extends uvm_sequencer #(my_sequence_item);

`uvm_component_utils(my_sequencer) ;


function new(string name = "my_sequencer" , uvm_component parent = null);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

endclass	
endpackage	