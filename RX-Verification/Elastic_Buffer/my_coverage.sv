package my_coverage_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;

class my_coverage extends uvm_component;

`uvm_component_utils(my_coverage);

uvm_analysis_export   #(my_sequence_item) cov_export;
uvm_tlm_analysis_fifo #(my_sequence_item) cov_fifo  ;  
my_sequence_item      data_to_cover                 ;

virtual BFM_if dut_if;

covergroup cg;
 Data_in: coverpoint data_to_cover.data_in  ;
 
 Overflow_cp: coverpoint data_to_cover.overflow {
  bins overflow_Zero     = {0};
  bins overflow_One      = {1};
  bins overflow_Zero_one = (0 => 1);
  bins overflow_One_Zero = (1 => 0);
 }


 Underflow_cp: coverpoint data_to_cover.underflow {
  bins underflow_Zero     = {0};
  bins underflow_One      = {1};
  bins underflow_Zero_one = (0 => 1);
  bins underflow_One_Zero = (1 => 0);
 }


 Write_Enable_cp: coverpoint data_to_cover.write_enable {
  bins write_enable_Zero     = {0};
  bins write_enable_One      = {1};
  bins write_enable_Zero_one = (0 => 1);
  bins write_enable_One_Zero = (1 => 0);
 }


 Read_Enable_cp: coverpoint data_to_cover.read_enable {
  bins read_enable_Zero     = {0};
  bins read_enable_One      = {1};
  bins read_enable_Zero_one = (0 => 1);
  bins read_enable_One_Zero = (1 => 0);
 }


 Data_Out_cp: coverpoint data_to_cover.data_out;


endgroup




function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	cov_export    = new("cov_export" , this);
	cov_fifo      = new("cov_fifo"   , this);
	data_to_cover = new("data_to_cover");
	`uvm_info("MY_COVERAGE","BUILD_PHASE",UVM_MEDIUM);

if(!uvm_config_db#(virtual BFM_if)::get(this , "", "bfm_if",dut_if)) 
	`uvm_info("MY_COVERAGE" , "FAILED GET INTERFACE",UVM_MEDIUM);

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
    	cov_fifo.get(data_to_cover);
    	`uvm_info("MY_COVERAGE","COVERAGE's CAPTURING",UVM_MEDIUM);
         
    	@(posedge dut_if.write_clk);
         if(dut_if.rst_n)
    	    cg.sample();
    end
endtask



endclass	
endpackage	