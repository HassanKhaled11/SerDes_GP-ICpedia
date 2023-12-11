//package my_coverage_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;

class my_coverage extends uvm_component;

`uvm_component_utils(my_coverage);

uvm_analysis_export   #(my_sequence_item) cov_export;
uvm_tlm_analysis_fifo #(my_sequence_item) cov_fifo  ;  
my_sequence_item      data_to_cover                 ;
int count;
logic[9:0] data_to_collect;

covergroup cg_collect;
Data_in_cp: coverpoint data_to_collect;
         // {
         // 	bins All_zeros_n = {10'b100111_0100}; // positive collected encoded data for 8'b0000000
         // 	bins All_zeros_p = {10'b011000_1011}; // negative collected encoded data for 8'b0000000
         // 	bins All_ones_n = {10'b101011_0001}; // positive collected encoded data for 8'b0000000
         // 	bins All_ones_p = {10'b010100_1110}; // negative collected encoded data for 8'b0000000
         // 	bins other[]		= default;
         // } 
endgroup

covergroup cg;
En : coverpoint data_to_cover.MAC_Data_En
{
	bins EN_one       = {1'b1  } ;
    bins EN_zero      = {1'b0  } ;
	bins EN_one_zero  = (1 => 0) ;
	bins EN_zero_one  = (0 => 1) ;	
}
endgroup
covergroup cg_rst;
RST_cp  : coverpoint data_to_cover.Reset_n
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
	cg 		        = new();
	cg_collect      = new();
	cg_rst 		    = new();
endfunction



task run_phase(uvm_phase phase);
	super.run_phase(phase);
    forever begin
    	cov_fifo.get(data_to_cover)        ;
   		if(count == 0) begin
   			data_to_collect = 10'b0;
   		end
    	data_to_collect[count] = data_to_cover.TX_Out_P;
    	count++;
    	if(count == 10) begin
    		if(data_to_cover.Reset_n) cg_collect.sample();
    		count = 0;
    	end
    	if(data_to_cover.Reset_n) cg.sample();
    	cg_rst.sample();
    end
endtask



endclass	
//endpackage	