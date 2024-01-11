package my_driver_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;


class my_driver extends uvm_driver #(my_sequence_item);

`uvm_component_utils(my_driver);

virtual BFM_if bfm_vif ;
my_sequence_item stim_seq_item ;



function new(string name = "my_driver" , uvm_component parent = null);
	super.new(name,parent);

endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info("MY_DRIVER","BUILD_PHASE",UVM_MEDIUM);
endfunction 


task run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever begin
	stim_seq_item = my_sequence_item :: type_id :: create ("stim_seq_item" , this);
	seq_item_port.get_next_item(stim_seq_item);
        drive();
	seq_item_port.item_done(stim_seq_item);
	end 
endtask : run_phase



task drive(); 
  @(negedge bfm_vif.PCLK);

  bfm_vif.DataBusWidth = stim_seq_item.DataBusWidth;
  bfm_vif.MAC_TX_Data  = stim_seq_item.MAC_TX_Data ;
  bfm_vif.MAC_TX_DataK = stim_seq_item.MAC_TX_DataK;
  bfm_vif.MAC_Data_En  = stim_seq_item.MAC_Data_En ;


`uvm_info("MY_DRIVER","DRIVE FUN",UVM_MEDIUM);
	
endtask 


endclass	
endpackage	