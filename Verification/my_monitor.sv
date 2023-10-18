package my_monitor_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"


class my_monitor extends uvm_monitor;

`uvm_component_utils(my_monitor);

function new(string name = "my_monitor" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info("MY_MONITOR","BUILD_PHASE",UVM_MEDIUM);
endfunction 


endclass	
endpackage	