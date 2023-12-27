package decoder_monitor_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import decoder_sequence_item_pkg::*;


  class decoder_monitor extends uvm_monitor;
    `uvm_component_utils(decoder_monitor);

    uvm_analysis_port #(decoder_sequence_item) mon_port;
    virtual Decoder_if decoder_bfm_vif;
    decoder_sequence_item rsp_seq_item;
    // virtual CLK_if  clk_vif ;


    function new(string name = "decoder_monitor", uvm_component parent = null);
      super.new(name, parent);

    endfunction


    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      mon_port = new("mon_port", this);
      // `uvm_info("DECODER_MONITOR","BUILD_PHASE",UVM_MEDIUM);
      // if(!uvm_config_db#(virtual decoder_config_db)::get(this, "", "CFG", cfg))
      // 		`uvm_fatal("Monitor","doesn't read stimulus through monitor")

    endfunction

    // virtual task run_phase(uvm_phase phase);
    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      forever begin
        // rsp_seq_item = my_sequence_item::type_id::create("rsp_seq_item");
        //repeat(10) begin
        @(negedge decoder_bfm_vif.CLK);

        rsp_seq_item                = decoder_sequence_item::type_id::create("rsp_seq_item");
        rsp_seq_item.CLK            = decoder_bfm_vif.CLK;  //////////////////////
        rsp_seq_item.Rst_n          = decoder_bfm_vif.Rst_n;
        rsp_seq_item.Data_in        = decoder_bfm_vif.Data_in;
        rsp_seq_item.Data_out       = decoder_bfm_vif.Data_out;
        rsp_seq_item.DecodeError    = decoder_bfm_vif.DecodeError;
        rsp_seq_item.DisparityError = decoder_bfm_vif.DisparityError;
        rsp_seq_item.RxDataK        = decoder_bfm_vif.RxDataK;
        //////
        `uvm_info("MONITOR", "DATA SENT TO SCOREBOARD HERE", UVM_HIGH);
        mon_port.write(rsp_seq_item);

      end
    endtask
  endclass
endpackage
