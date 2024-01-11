package my_sequence_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;


class my_sequence extends uvm_sequence #(my_sequence_item);

`uvm_object_utils(my_sequence);

int fd                         ;
my_sequence_item stim_seq_item ;

function new(string name = "my_sequence");
	super.new(name);
	 `uvm_info("MY_SEQUENCE","SEQ CREATED",UVM_MEDIUM);
      fd = $fopen("./MAC_TX_Data_Stim.hex","w");
endfunction


task body();
	repeat(100) begin
	 stim_seq_item = my_sequence_item :: type_id :: create("stim_seq_item");
	                       			`uvm_info("MY_SEQUENCE","BEFORE START ITEM",UVM_MEDIUM);	
      start_item(stim_seq_item);
                          			`uvm_info("MY_SEQUENCE","AFTER START ITEM",UVM_MEDIUM);
      assert(stim_seq_item.randomize());
      $fwrite(fd ,"%h\n", stim_seq_item.MAC_TX_Data);

      finish_item(stim_seq_item);
      get_response(stim_seq_item);
                         			`uvm_info("MY_SEQUENCE","AFTER FINISH ITEM",UVM_MEDIUM);
	end
	$fclose(fd);
endtask


endclass
	


endpackage	