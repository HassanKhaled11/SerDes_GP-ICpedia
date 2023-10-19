package coverage_collector_pkg;
  import sequence_item_pkg::*;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class my_coverage extends uvm_component;
    `uvm_component_utils(my_coverage)
    uvm_analysis_export #(my_sequence_item) cov_export;
    uvm_tlm_analysis_fifo #(my_sequence_item) cov_fifo;
    my_sequence_item seq_item;

    //covergroups
    covergroup cvr;
      coverpoint seq_item.reset;
      coverpoint seq_item.serial_in;
      coverpoint seq_item.direction;
      coverpoint seq_item.mode;
      coverpoint seq_item.datain;
    endgroup

    int error_count   = 0;
    int correct_count = 0;

    function new(string name = "my_coverage", uvm_component parent = null);
      super.new(name, parent);
      cvr = new();
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      cov_export = new("cov_export", this);
      cov_fifo   = new("cov_fifo", this);
    endfunction

    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      cov_export.connect(cov_fifo.analysis_export);
    endfunction

    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      forever begin
        cov_fifo.get(seq_item);
        cvr.sample();
      end
    endtask  //
  endclass
endpackage
