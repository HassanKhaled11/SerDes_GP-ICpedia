package my_env_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_agent_pkg     ::*;
import my_monitor_pkg   ::*; 
import my_scoreboard_pkg::*;
import my_coverage_pkg  ::*;



class my_env extends uvm_env;

`uvm_component_utils(my_env);

my_agent        agent      ;
my_monitor      monitor    ;
my_scoreboard   scoreboard ; 
my_coverage     coverage   ;

function new(string name = "my_env" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	agent      = my_agent      :: type_id :: create("agent"     ,this);
	monitor    = my_monitor    :: type_id :: create("monitor"   ,this);
	scoreboard = my_scoreboard :: type_id :: create("scoreboard",this);
	coverage   = my_coverage   :: type_id :: create("coverage"  ,this);
	`uvm_info("MY_ENV","BUILD_PHASE",UVM_MEDIUM);
endfunction 


endclass	
endpackage	