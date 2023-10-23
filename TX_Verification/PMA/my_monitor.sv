package my_monitor_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;


class my_monitor extends uvm_monitor;

`uvm_component_utils(my_monitor);

uvm_analysis_port #(my_sequence_item)  mon_port ;

virtual BFM_if bfm_vif ;
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
  
     @(posedge  bfm_vif.Bit_Rate_10  )                     ;
      rsp_seq_item.Rst_n          = bfm_vif.Rst_n          ;
      rsp_seq_item.Data_in        = bfm_vif.Data_in        ;
      rsp_seq_item.Tx_Data_Enable = bfm_vif.Tx_Data_Enable ;
      rsp_seq_item.TX_Out         = bfm_vif.TX_Out         ;
      rsp_seq_item.TX_Done        = bfm_vif.TX_Done        ;


     `uvm_info("MY_MONITOR" , "here_1", UVM_MEDIUM);
     `uvm_info("MY_MONITOR" , $sformatf("rst = %d , Data_in = %d , tx_data_en = %d , TX_Out = %d",rsp_seq_item.Rst_n , rsp_seq_item.Data_in , rsp_seq_item.Tx_Data_Enable , rsp_seq_item.TX_Out) , UVM_MEDIUM);
	 mon_port.write(rsp_seq_item);
     
	end
 
endtask

endclass	
endpackage	