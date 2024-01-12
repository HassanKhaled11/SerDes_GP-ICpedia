package my_monitor_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"


import my_sequence_item_pkg::*;


class my_monitor extends uvm_monitor;

`uvm_component_utils(my_monitor);

uvm_analysis_port #(my_sequence_item)  mon_port ;

virtual BFM_if bfm_vif ;
virtual INTERNALS_if internals_if;

my_sequence_item  rsp_seq_item ;

function new(string name = "my_monitor" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	mon_port = new("mon_port" , this);
	`uvm_info("MY_MONITOR","BUILD_PHASE",UVM_MEDIUM);

endfunction 


task run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever begin
	rsp_seq_item = my_sequence_item:: type_id :: create("rsp_seq_item");
     @(posedge internals_if.Bit_CLK);    // BIT CLK
     
     `uvm_info("MY_MONITOR","MONITOR IS CAPTURING",UVM_MEDIUM);
    
     // rsp_seq_item.DataBusWidth = bfm_vif.DataBusWidth;
     rsp_seq_item.MAC_TX_Data  = bfm_vif.MAC_TX_Data ;
     rsp_seq_item.MAC_TX_DataK = bfm_vif.MAC_TX_DataK;
     rsp_seq_item.MAC_Data_En  = bfm_vif.MAC_Data_En ;

     rsp_seq_item.Rx_Data      = bfm_vif.Rx_Data     ;
     rsp_seq_item.Rx_DataK     = bfm_vif.Rx_DataK    ;
     rsp_seq_item.Rx_Status    = bfm_vif.Rx_Status   ;
     rsp_seq_item.Rx_Valid     = bfm_vif.Rx_Valid    ;
     rsp_seq_item.PCLK         = bfm_vif.PCLK        ;

	 mon_port.write(rsp_seq_item)                    ;
     
	end
 
endtask

endclass	
endpackage	