package my_agent_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_driver_pkg::*       ;
import my_sequence_item_pkg::*;
import my_monitor_pkg::*      ;
import my_config_db_pkg::*    ;
import my_sequencer_pkg::*    ;



class my_agent extends uvm_agent;

`uvm_component_utils(my_agent) ;

uvm_analysis_port #(my_sequence_item) agt_port;

	my_config_db cfg    ;
	my_driver    driver ;
	my_monitor   monitor;      
	my_sequencer sqr    ;


function new(string name = "my_agent" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);

	driver   = my_driver    :: type_id :: create("driver"  ,this) ;
	sqr      = my_sequencer :: type_id :: create("sqr"     ,this) ;
	monitor  = my_monitor   :: type_id :: create("monitor" ,this) ;
	cfg      = my_config_db :: type_id :: create ("cfg"    ,this) ; 
    agt_port = new("agt_port", this);

	if(!uvm_config_db#(my_config_db)::get(this, "", "CFG",cfg))
		`uvm_fatal("MY_AGENT" , "FAILED GETTING CONFIG DB");

	`uvm_info("MY_AGENT","BUILD_PHASE",UVM_MEDIUM);
endfunction 



function void connect_phase(uvm_phase phase);
	super.connect_phase(phase)                       ;
    monitor.bfm_vif = cfg.dut_vif                    ;
    driver.bfm_vif  = cfg.dut_vif                    ;
	`uvm_info("MY_AGENT","CONNECT_PHASE",UVM_MEDIUM) ;
    driver.seq_item_port.connect(sqr.seq_item_export);
    monitor.mon_port.connect(agt_port)               ;

endfunction



endclass	
endpackage	