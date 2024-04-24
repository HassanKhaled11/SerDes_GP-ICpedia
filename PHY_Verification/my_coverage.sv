package my_coverage_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;

class my_coverage extends uvm_component;

`uvm_component_utils(my_coverage);

uvm_analysis_export   #(my_sequence_item) cov_export;
uvm_tlm_analysis_fifo #(my_sequence_item) cov_fifo  ;  
my_sequence_item      data_to_cover                 ;

virtual BFM_if bfm_vif ;
virtual INTERNALS_if internals_if;

covergroup cg;

// TX_cp: coverpoint data_to_cover.TX_Out_N   ;

TX_cp: coverpoint data_to_cover.TX_Out_P   ;
MAC_TX_Data_cp: coverpoint data_to_cover.MAC_TX_Data;
MAC_TX_DataK:coverpoint data_to_cover.MAC_TX_DataK  iff(bfm_vif.Reset_n)
{
  bins full_command_pkt = {4'd15};	
}

RX_DATA_cp:coverpoint data_to_cover.Rx_Data     ;
Rx_Valid_cp : coverpoint data_to_cover.Rx_Valid ;
Rx_status_cp: coverpoint data_to_cover.Rx_Status;


  

endgroup




function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	cov_export    = new("cov_export" , this);
	cov_fifo      = new("cov_fifo"   , this);
	data_to_cover = new("data_to_cover");

if(!uvm_config_db#(virtual BFM_if)::get(this, "", "bfm_if", bfm_vif))
	`uvm_fatal("MY_TEST" , "FATAL PUTTING BFM INTERFACE in CONFIG_DB");
 

if(!uvm_config_db#(virtual INTERNALS_if)::get(this,"","internals_if", internals_if))
  `uvm_fatal("MY_TEST" , "FATAL PUTTING INTERNALS INTERFACE in CONFIG_DB");

endfunction 


function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	cov_export.connect(cov_fifo.analysis_export);
endfunction


function new(string name = "my_coverage" , uvm_component parent = null);
	super.new(name,parent);
	cg = new();
endfunction



task run_phase(uvm_phase phase);
	super.run_phase(phase);
    forever begin
         @(internals_if.Bit_CLK);
    	cov_fifo.get(data_to_cover);
    	cg.sample();
    end
endtask



endclass	
endpackage	