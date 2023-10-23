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
@(negedge    bfm_vif.Bit_Rate_10);	
`uvm_info("MY_DRIVER" , "here_data start", UVM_MEDIUM);
bfm_vif.Rst_n          = stim_seq_item.Rst_n         ;
bfm_vif.Data_in        = stim_seq_item.Data_in       ;
bfm_vif.Tx_Data_Enable = stim_seq_item.Tx_Data_Enable;
`uvm_info("MY_DRIVER" , $sformatf("rst = %d , Data_in = %d , tx_data_en = %d , TX_Out = %d",bfm_vif.Rst_n , bfm_vif.Data_in , bfm_vif.Tx_Data_Enable , bfm_vif.TX_Out) , UVM_MEDIUM);

repeat(11) @(posedge bfm_vif.Bit_Rate_10); 	
endtask 


endclass	
endpackage	