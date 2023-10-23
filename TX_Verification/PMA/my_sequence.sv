package my_sequence_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;


class reset_sequence extends uvm_sequence #(my_sequence_item);

`uvm_object_utils(reset_sequence);

my_sequence_item stim_seq_item ;

function new(string name = "reset_sequence");
	super.new(name);
endfunction

task body();
	stim_seq_item = my_sequence_item :: type_id :: create("stim_seq_item");
	start_item(stim_seq_item);
     stim_seq_item.Rst_n           = 1'b0 ;
     stim_seq_item.Data_in         = 0    ;
     stim_seq_item.Tx_Data_Enable  = 1'b0 ;
	finish_item(stim_seq_item) ;
	get_response(stim_seq_item);
endtask : body


endclass	


class my_sequence extends uvm_sequence #(my_sequence_item);

`uvm_object_utils(my_sequence);

my_sequence_item stim_seq_item ;

function new(string name = "my_sequence");
	super.new(name);
	 `uvm_info("MY_SEQUENCE","SEQ CREATED",UVM_MEDIUM);
endfunction


task body();

	 stim_seq_item = my_sequence_item :: type_id :: create("stim_seq_item");

	  `uvm_info("MY_SEQUENCE","BEFORE START ITEM_1",UVM_MEDIUM);	      
      start_item(stim_seq_item);
      `uvm_info("MY_SEQUENCE","AFTER START ITEM_1",UVM_MEDIUM);        
        stim_seq_item.Rst_n           = 1'b1 ;
        stim_seq_item.Data_in         = 100  ;  
        stim_seq_item.Tx_Data_Enable  = 1'b1 ;
   
      finish_item(stim_seq_item) ;
      get_response(stim_seq_item);

      `uvm_info("MY_SEQUENCE","AFTER FINISH ITEM_1",UVM_MEDIUM);

	repeat(10000) begin

  	 stim_seq_item = my_sequence_item :: type_id :: create("stim_seq_item");

	  `uvm_info("MY_SEQUENCE","BEFORE START ITEM",UVM_MEDIUM);	
      start_item(stim_seq_item);
      `uvm_info("MY_SEQUENCE","AFTER START ITEM",UVM_MEDIUM);
      assert(stim_seq_item.randomize());
      finish_item(stim_seq_item);

      get_response(stim_seq_item);
      `uvm_info("MY_SEQUENCE","AFTER FINISH ITEM",UVM_MEDIUM);
	end
endtask


endclass




endpackage	