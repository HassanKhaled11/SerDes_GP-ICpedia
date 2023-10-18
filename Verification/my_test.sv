package my_test_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_env_pkg::*;
import my_sequence_pkg::*;
import my_config_db_pkg::*;


class my_test extends uvm_test;

`uvm_component_utils(my_test);

my_env          env         ;
my_sequence     main_seq    ;
reset_sequence  reset_seq   ;
my_config_db    rx_cfg      ;

function new(string name = "my_test" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info("MY_TEST","BUILD_PHASE",UVM_MEDIUM);
  env       = my_env         :: type_id :: create("env"      ,this)   ;
  main_seq  = my_sequence    :: type_id :: create("main_seq" ,this)   ;
  reset_seq = reset_sequence :: type_id :: create("reset_seq",this)   ;
  rx_cfg    = my_config_db   :: type_id :: create("rx_cfg"   ,this)   ;
if(!uvm_config_db#(virtual BFM_if)::get(this, "", "bfm_if", rx_cfg.dut_vif))
	`uvm_fatal("MY_TEST" , "FATAL GETTING BFM INTERFACE");
 
 uvm_config_db#(my_config_db)::set(this, "*", "CFG", rx_cfg);

endfunction 


task run_phase(uvm_phase phase);
	phase.raise_objection(this);
       
       fork
       	begin
       	  `uvm_warning("MY_TEST","RESET SEQ START");
       	  #(50);
       	end

       	begin
       	  `uvm_warning("MY_TEST","MAIN SEQ START");
       	  #(50);       		
       	end

       join


	phase.drop_objection(this);
endtask



endclass	
endpackage	