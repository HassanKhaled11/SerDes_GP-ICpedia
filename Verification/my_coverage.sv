package my_coverage_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"
import my_sequence_item_pkg::*;

class my_coverage extends uvm_subscriber #(my_sequence_item);

`uvm_component_utils(my_coverage);


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info("MY_COVERAGE","BUILD_PHASE",UVM_LOW);
endfunction 


function new(string name = "my_coverage" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void write(my_sequence_item  t);
	
endfunction 



endclass	
endpackage	