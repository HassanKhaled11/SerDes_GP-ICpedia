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

	 stim_seq_item = my_sequence_item :: type_id :: create("stim_seq_item");
	                       			`uvm_info("MY_SEQUENCE","BEFORE START ITEM",UVM_MEDIUM);   
   
	 // stim_seq_item.MAC_TX_Data_16c.constraint_mode (0);    
	 // stim_seq_item.MAC_TX_Data_8c.constraint_mode  (0);
	 // stim_seq_item.MAC_TX_DataK_16c.constraint_mode(0);    
	 // stim_seq_item.MAC_TX_DataK_8c.constraint_mode (0);

	 // stim_seq_item.MAC_TX_Data_32c.constraint_mode (0);    
	 // stim_seq_item.MAC_TX_Data_8c.constraint_mode  (0);
	 // stim_seq_item.MAC_TX_DataK_32c.constraint_mode(0);    
	 // stim_seq_item.MAC_TX_DataK_8c.constraint_mode (0);

	 // stim_seq_item.MAC_TX_Data_32c.constraint_mode (0);    
	 // stim_seq_item.MAC_TX_Data_16c.constraint_mode  (0);
	 // stim_seq_item.MAC_TX_DataK_32c.constraint_mode(0);    
	 // stim_seq_item.MAC_TX_DataK_16c.constraint_mode (0);

	repeat(100) begin


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