package my_coverage_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;

class my_coverage extends uvm_component;

`uvm_component_utils(my_coverage);

uvm_analysis_export   #(my_sequence_item) cov_export;
uvm_tlm_analysis_fifo #(my_sequence_item) cov_fifo  ;  
my_sequence_item      data_to_cover                 ;

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	cov_export = new("cov_export" , this);
	cov_fifo   = new("cov_fifo"   , this);
	`uvm_info("MY_COVERAGE","BUILD_PHASE",UVM_MEDIUM);
endfunction 


function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	cov_export.connect(cov_fifo.analysis_export);
endfunction


function new(string name = "my_coverage" , uvm_component parent = null);
	super.new(name,parent);
endfunction



task run_phase(uvm_phase phase);
	super.run_phase(phase);
    forever begin
    	cov_fifo.get(data_to_cover);
    end
endtask



endclass	
endpackage	