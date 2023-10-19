package scoreboard_pkg;
  import sequence_item_pkg::*;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class my_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(my_scoreboard)
    uvm_analysis_export #(my_sequence_item) sb_export;
    uvm_tlm_analysis_fifo #(my_sequence_item) sb_fifo;
    my_sequence_item seq_item;
    logic [5:0] dataout_ref;

    int error_count = 0;
    int correct_count = 0;

    function new(string name = "my_scoreboard", uvm_component parent = null);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      sb_export = new("sb_export", this);
      sb_fifo   = new("sb_fifo", this);
    endfunction


    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      sb_export.connect(sb_fifo.analysis_export);
    endfunction

    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      forever begin
        sb_fifo.get(seq_item);
        ref_model(seq_item);
        if (seq_item.dataout != dataout_ref) begin
          `uvm_error(
              "run_phase",
              $sformatf(
                  "comparison failed, Transaction recieved by the DUT: %s while the reference out: 0b%0b",
                  seq_item.convert2string(), dataout_ref));
          error_count++;
        end else begin
          `uvm_info("run_phase", $sformatf("correct ALU out: %s", seq_item.convert2string()),
                    UVM_HIGH);
          correct_count++;
        end
      end
    endtask

    //generating golden model
    task ref_model(my_sequence_item seq_item);
      if (seq_item.reset) dataout_ref = 0;
      else if (seq_item.mode)  // rotate
        if (seq_item.direction)  // left
          dataout_ref = {seq_item.datain[4:0], seq_item.datain[5]};
        else dataout_ref = {seq_item.datain[0], seq_item.datain[5:1]};
      else  // shift
      if (seq_item.direction)  // left
        dataout_ref <= {seq_item.datain[4:0], seq_item.serial_in};
      else dataout_ref <= {seq_item.serial_in, seq_item.datain[5:1]};
    endtask

    function void report_phase(uvm_phase phase);
      super.report_phase(phase);
      `uvm_info("report_phase", $sformatf("Total successful transactions: %0d", correct_count),
                UVM_MEDIUM);
      `uvm_info("report_phase", $sformatf("Total failed transactions: %0d", error_count),
                UVM_MEDIUM);
    endfunction
  endclass
endpackage
