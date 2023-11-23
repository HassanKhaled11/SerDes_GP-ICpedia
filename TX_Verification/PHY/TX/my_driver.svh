//package my_driver_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;


class my_driver extends uvm_driver #(my_sequence_item);

`uvm_component_utils(my_driver);

virtual TX_if tx_vif ;
virtual CLK_if  clk_vif ;
//my_sequence_item stim_seq_item ;

function new(string name = "my_driver" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info("MY_DRIVER","BUILD_PHASE",UVM_MEDIUM);
	if(!uvm_config_db #(virtual TX_if) :: get(this , "" , "tx_if" , tx_vif))
			`uvm_fatal("","failed to read interface through driver");



  if(!uvm_config_db#(virtual CLK_if)::get(this , "" , "CLK_if" , clk_vif))
    	`uvm_fatal("","doesn't read clocks through driver")


endfunction 


task run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever begin
	//stim_seq_item = my_sequence_item :: type_id :: create ("stim_seq_item" , this);
	seq_item_port.get_next_item(req);
        drive();
	seq_item_port.item_done(req);
	end 
endtask : run_phase



task drive(); 
@(negedge    clk_vif.PCLK);	
`uvm_info("MY_DRIVER" , "here_data start", UVM_MEDIUM);
	  tx_vif.MAC_Data_En 	  = req.MAC_Data_En;
   	  // tx_vif.Reset_n		  = req.Reset_n;
   	  tx_vif.MAC_TX_DataK     = req.MAC_TX_DataK;
      tx_vif.MAC_TX_Data 	  = req.MAC_TX_Data;
      tx_vif.DataBusWidth	  = req.DataBusWidth;
`uvm_info("MY_DRIVER" , $sformatf("rst = %d , Data_in = 0x%h , tx_data_en = %d , TX_Out = %d",tx_vif.Reset_n , tx_vif.MAC_TX_Data , tx_vif.MAC_Data_En , tx_vif.TX_Out_P) , UVM_MEDIUM);
	
// @(posedge tx_vif.Bit_Rate_10); 	
endtask 


endclass	
//endpackage	