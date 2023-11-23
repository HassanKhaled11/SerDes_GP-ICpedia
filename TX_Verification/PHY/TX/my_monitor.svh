//package my_monitor_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;


class my_monitor extends uvm_monitor;

`uvm_component_utils(my_monitor);

uvm_analysis_port #(my_sequence_item)  mon_port ;

virtual TX_if   bfm_vif ;
virtual CLK_if  clk_vif ;

my_sequence_item  rsp_seq_item ;

function new(string name = "my_monitor" , uvm_component parent = null);
	super.new(name,parent);
	
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	mon_port = new("mon_port" , this);
	`uvm_info("MY_MONITOR","BUILD_PHASE",UVM_MEDIUM);
	if(!uvm_config_db#(virtual TX_if)::get(this, "", "tx_if", bfm_vif))
			`uvm_fatal("","doesn't read stimulus through monitor")

    if(!uvm_config_db#(virtual CLK_if)::get(this , "" , "CLK_if" , clk_vif))
    	`uvm_fatal("","doesn't read clocks through monitor")


endfunction 

// 32'h26c4
virtual task run_phase(uvm_phase phase);
	super.run_phase(phase);
	//rsp_seq_item = my_sequence_item:: type_id :: create("rsp_seq_item");
	forever begin
	  @(posedge clk_vif.Bit_Rate_Clk);
      rsp_seq_item = my_sequence_item:: type_id :: create("rsp_seq_item");                        		   
   	  rsp_seq_item.MAC_Data_En = bfm_vif.MAC_Data_En;
   	  // rsp_seq_item.Reset_n		  = bfm_vif.Reset_n;
   	  rsp_seq_item.MAC_TX_DataK   = bfm_vif.MAC_TX_DataK;
      rsp_seq_item.MAC_TX_Data 	  = bfm_vif.MAC_TX_Data;
      rsp_seq_item.DataBusWidth	  = bfm_vif.DataBusWidth;
      rsp_seq_item.TX_Out_P 	  = bfm_vif.TX_Out_P;
      rsp_seq_item.TX_Out_N		  = bfm_vif.TX_Out_N;
	  mon_port.write(rsp_seq_item);     
	end 
endtask
endclass	
//endpackage	