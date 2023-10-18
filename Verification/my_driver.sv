package my_driver_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"
import my_sequence_item_pkg::*;


class my_driver extends uvm_driver #(my_sequence_item);

`uvm_component_utils(my_driver);

function new(string name = "my_driver" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info("MY_DRIVER","BUILD_PHASE",UVM_MEDIUM);
endfunction 




endclass	
endpackage	