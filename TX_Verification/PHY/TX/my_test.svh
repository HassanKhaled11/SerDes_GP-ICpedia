//package my_test_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "my_env.svh"
`include "my_sequence.svh"
//import my_env_pkg::*;
//import my_sequence_pkg::*;
import my_config_db_pkg::*;


class my_test extends uvm_test;

`uvm_component_utils(my_test);

my_env          env         ;
my_sequence     main_seq    ;
//reset_sequence  reset_seq   ;
my_config_db    cfg         ;

function new(string name = "my_test" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info("MY_TEST","BUILD_PHASE",UVM_MEDIUM);

  env         = my_env         :: type_id :: create("env"       ,this)    ;
  main_seq    = my_sequence    :: type_id :: create("main_seq"  ,this)    ;
  //reset_seq   = reset_sequence :: type_id :: create("reset_seq" ,this)    ;
  cfg         = my_config_db   :: type_id :: create("cfg"       ,this)    ;
  
if(!uvm_config_db#(virtual TX_if)::get(this, "", "tx_if", cfg.dut_vif))
	`uvm_fatal("MY_TEST" , "FATAL GETTING BFM INTERFACE");
 
 uvm_config_db#(my_config_db)::set(this, "*", "CFG", cfg);

endfunction 


task run_phase(uvm_phase phase);
	phase.raise_objection(this);
       
  //`uvm_warning("MY_TEST","RESET SEQ START");
   //reset_seq.start(env.agent.sqr);
  //`uvm_warning("MY_TEST","RESET SEQ END");

  `uvm_warning("MY_TEST","MAIN SEQ START");
   main_seq.start(env.agent.sqr);
  `uvm_warning("MY_TEST","MAIN SEQ END");

	phase.drop_objection(this);
endtask



endclass	
//endpackage	