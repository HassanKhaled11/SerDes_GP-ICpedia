package my_agent_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_driver_pkg::*       ;
import my_sequence_item_pkg::*;
import my_monitor_pkg::*      ;
import my_config_db_pkg::*    ;
import my_sequencer_pkg::*    ;
import my_scoreboard_pkg::*   ;



class my_agent extends uvm_agent;

`uvm_component_utils(my_agent) ;

uvm_analysis_port #(my_sequence_item) agt_port;

	my_config_db cfg        ;
	my_driver    driver     ;
	my_monitor   monitor    ;    
	my_scoreboard scoreboard;  
	my_sequencer sqr        ;


function new(string name = "my_agent" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);

	cfg        = my_config_db :: type_id :: create ("cfg"      ,this) ; 

	if(!uvm_config_db#(my_config_db)::get(this, "", "CFG",cfg))
		`uvm_fatal("MY_AGENT" , "FAILED GETTING CONFIG DB");

    if(cfg.is_active == UVM_ACTIVE) begin
    	driver     = my_driver    :: type_id :: create("driver"    ,this) ;
    	sqr        = my_sequencer :: type_id :: create("sqr"       ,this) ;	
    end

	monitor    = my_monitor   :: type_id :: create("monitor"   ,this) ;
	scoreboard = my_scoreboard:: type_id :: create("scoreboard",this) ;
    agt_port   = new("agt_port", this);


	`uvm_info("MY_AGENT","BUILD_PHASE",UVM_MEDIUM);
endfunction 



function void connect_phase(uvm_phase phase);
	super.connect_phase(phase)                       ;
   
	`uvm_info("MY_AGENT","CONNECT_PHASE",UVM_MEDIUM) ;

    monitor.bfm_vif = cfg.dut_vif                    ;
    monitor.internals_if = cfg.internals_if          ;
    monitor.mon_port.connect(agt_port)               ;

if(cfg.is_active == UVM_ACTIVE) begin
    driver.bfm_vif  = cfg.dut_vif                    ;
    driver.seq_item_port.connect(sqr.seq_item_export);
end

endfunction



endclass	
endpackage	