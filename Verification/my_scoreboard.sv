package my_scoreboard_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"


class my_scoreboard extends uvm_scoreboard;

`uvm_component_utils(my_scoreboard);

function new(string name = "my_scoreboard" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info("MY_SCOREBOARD","BUILD_PHASE",UVM_MEDIUM);
endfunction 


endclass	
endpackage	