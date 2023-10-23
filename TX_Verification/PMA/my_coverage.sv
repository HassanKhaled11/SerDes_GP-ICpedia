package my_coverage_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;

class my_coverage extends uvm_component;

`uvm_component_utils(my_coverage);

uvm_analysis_export   #(my_sequence_item) cov_export;
uvm_tlm_analysis_fifo #(my_sequence_item) cov_fifo  ;  
my_sequence_item      data_to_cover                 ;



covergroup cg;
Data_in_cp: coverpoint data_to_cover.Data_in         ;
Tx_En_cp  : coverpoint data_to_cover.Tx_Data_Enable  ;
Tx_out_cp : coverpoint data_to_cover.TX_Out 
{
	bins one       = {1'b1  } ;
    bins zero      = {1'b0  } ;
	bins one_zero  = (1 => 0) ;
	bins zero_one  = (0 => 1) ;
}
endgroup


covergroup cg_rst;
RST_cp  : coverpoint data_to_cover.Rst_n
{
	bins rst_one       = {1'b1  } ;
    bins rst_zero      = {1'b0  } ;
	bins rst_one_zero  = (1 => 0) ;
	bins rst_zero_one  = (0 => 1) ;	
}  	
endgroup 



function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	cov_export    = new("cov_export" , this);
	cov_fifo      = new("cov_fifo"   , this);
	data_to_cover = new("data_to_cover");
	`uvm_info("MY_COVERAGE","BUILD_PHASE",UVM_MEDIUM);
endfunction 


function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	cov_export.connect(cov_fifo.analysis_export);
endfunction


function new(string name = "my_coverage" , uvm_component parent = null);
	super.new(name,parent);
	cg      = new();
	cg_rst  = new();
endfunction



task run_phase(uvm_phase phase);
	super.run_phase(phase);
    forever begin
    	cov_fifo.get(data_to_cover)        ;
    	if(data_to_cover.Rst_n) cg.sample();
    	cg_rst.sample();
    end
endtask



endclass	
endpackage	